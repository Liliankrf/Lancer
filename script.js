// ===================================
// LANCER IA - Interactive Script
// ===================================

// Smooth Scroll for Anchor Links
document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', function (e) {
        e.preventDefault();
        const target = document.querySelector(this.getAttribute('href'));
        if (target) {
            target.scrollIntoView({
                behavior: 'smooth',
                block: 'start'
            });
        }
    });
});

// Parallax Effect on Background Layers
window.addEventListener('scroll', () => {
    const scrolled = window.pageYOffset;
    const layers = document.querySelectorAll('.bg-layer');
    
    layers.forEach((layer, index) => {
        const speed = (index + 1) * 0.05;
        layer.style.transform = `translateY(${scrolled * speed}px)`;
    });
});

// Dock Active State Management
const dockItems = document.querySelectorAll('.dock-item');
const sections = document.querySelectorAll('section');

function updateActiveDockItem() {
    let currentSection = '';
    
    sections.forEach(section => {
        const sectionTop = section.offsetTop;
        const sectionHeight = section.clientHeight;
        
        if (window.pageYOffset >= sectionTop - 200) {
            currentSection = section.getAttribute('id') || 'home';
        }
    });
    
    dockItems.forEach(item => {
        item.classList.remove('active');
        const href = item.getAttribute('href');
        
        if (
            (currentSection === '' && href === '#') ||
            (href === `#${currentSection}`)
        ) {
            item.classList.add('active');
        }
    });
}

window.addEventListener('scroll', updateActiveDockItem);
updateActiveDockItem();

// Contact Form Handling
const contactForm = document.getElementById('contactForm');

contactForm.addEventListener('submit', async (e) => {
    e.preventDefault();
    
    const submitBtn = contactForm.querySelector('button[type="submit"]');
    const originalText = submitBtn.textContent;
    
    // Visual Feedback
    submitBtn.textContent = 'Envoi en cours...';
    submitBtn.style.opacity = '0.7';
    submitBtn.disabled = true;
    
    // Get Form Data
    const formData = new FormData(contactForm);
    const data = {
        name: formData.get('name'),
        email: formData.get('email'),
        type: formData.get('type'),
        message: formData.get('message'),
        timestamp: new Date().toISOString()
    };
    
    console.log('Form Data:', data);
    
    // Simulate API Call (replace with actual endpoint)
    setTimeout(() => {
        // Success State
        submitBtn.textContent = '✓ Message envoyé !';
        submitBtn.style.background = 'linear-gradient(135deg, #10B981 0%, #059669 100%)';
        
        // Reset Form
        contactForm.reset();
        
        // Reset Button After 3s
        setTimeout(() => {
            submitBtn.textContent = originalText;
            submitBtn.style.background = '';
            submitBtn.style.opacity = '1';
            submitBtn.disabled = false;
        }, 3000);
    }, 1500);
    
    // TODO: Replace with actual form submission
    // Example with Fetch API:
    /*
    try {
        const response = await fetch('YOUR_API_ENDPOINT', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(data)
        });
        
        if (response.ok) {
            submitBtn.textContent = '✓ Message envoyé !';
            submitBtn.style.background = 'linear-gradient(135deg, #10B981 0%, #059669 100%)';
            contactForm.reset();
        } else {
            throw new Error('Erreur lors de l\'envoi');
        }
    } catch (error) {
        submitBtn.textContent = '✗ Erreur, réessayez';
        submitBtn.style.background = 'linear-gradient(135deg, #EF4444 0%, #DC2626 100%)';
    }
    
    setTimeout(() => {
        submitBtn.textContent = originalText;
        submitBtn.style.background = '';
        submitBtn.style.opacity = '1';
        submitBtn.disabled = false;
    }, 3000);
    */
});

// Card Hover 3D Effect
const cards = document.querySelectorAll('.grid-card');

cards.forEach(card => {
    card.addEventListener('mousemove', (e) => {
        const rect = card.getBoundingClientRect();
        const x = e.clientX - rect.left;
        const y = e.clientY - rect.top;
        
        const centerX = rect.width / 2;
        const centerY = rect.height / 2;
        
        const rotateX = (y - centerY) / 20;
        const rotateY = (centerX - x) / 20;
        
        card.style.transform = `
            translateY(-8px) 
            perspective(1000px) 
            rotateX(${rotateX}deg) 
            rotateY(${rotateY}deg)
        `;
    });
    
    card.addEventListener('mouseleave', () => {
        card.style.transform = '';
    });
});

// Intersection Observer for Fade-in Animations
const observerOptions = {
    threshold: 0.1,
    rootMargin: '0px 0px -100px 0px'
};

const observer = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
        if (entry.isIntersecting) {
            entry.target.style.opacity = '1';
            entry.target.style.transform = 'translateY(0)';
        }
    });
}, observerOptions);

// Observe Cards and Process Steps
document.querySelectorAll('.grid-card, .process-step').forEach(el => {
    el.style.opacity = '0';
    el.style.transform = 'translateY(30px)';
    el.style.transition = 'opacity 0.6s ease, transform 0.6s ease';
    observer.observe(el);
});

// Neural Network Pulse Animation Enhancement
const neuralNetwork = document.querySelector('.neural-network');
if (neuralNetwork) {
    setInterval(() => {
        neuralNetwork.style.filter = 'blur(0px)';
        setTimeout(() => {
            neuralNetwork.style.filter = 'blur(2px)';
        }, 100);
    }, 3000);
}

// Performance: Reduce Motion for Users with Preference
if (window.matchMedia('(prefers-reduced-motion: reduce)').matches) {
    document.querySelectorAll('*').forEach(el => {
        el.style.animation = 'none !important';
        el.style.transition = 'none !important';
    });
}

console.log('🚀 LANCER IA - Site loaded successfully');
