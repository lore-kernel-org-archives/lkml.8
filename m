Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,RDNS_NONE,SPF_HELO_NONE,SPF_NONE autolearn=no
	autolearn_force=no version=3.4.0
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:56686 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729995AbgCKQB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 12:01:26 -0400
Received: by mail-qk1-f199.google.com with SMTP id m6so1782137qkm.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 09:01:23 -0700 (PDT)
Date: Wed, 11 Mar 2020 12:01:19 -0400
From: Peter Xu <peterx@redhat.com>
To: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Yan Zhao <yan.y.zhao@intel.com>,
        Jason Wang <jasowang@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Christophe de Dinechin <dinechin@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v6 03/14] KVM: X86: Don't track dirty for
 KVM_SET_[TSS_ADDR|IDENTITY_MAP_ADDR]
Message-ID: <20200311160119.GF479302@xz-x1>
References: <20200309214424.330363-1-peterx@redhat.com>
 <20200309214424.330363-4-peterx@redhat.com>
 <20200310150637.GB7600@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200310150637.GB7600@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 10, 2020 at 08:06:37AM -0700, Sean Christopherson wrote:
> On Mon, Mar 09, 2020 at 05:44:13PM -0400, Peter Xu wrote:
> > diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> > index 40b1e6138cd5..fc638a164e03 100644
> > --- a/arch/x86/kvm/vmx/vmx.c
> > +++ b/arch/x86/kvm/vmx/vmx.c
> > @@ -3467,34 +3467,26 @@ static bool guest_state_valid(struct kvm_vcpu *vcpu)
> >  	return true;
> >  }
> >  
> > -static int init_rmode_tss(struct kvm *kvm)
> > +static int init_rmode_tss(struct kvm *kvm, void __user *ua)
> >  {
> > -	gfn_t fn;
> > +	const void *zero_page = (const void *) __va(page_to_phys(ZERO_PAGE(0)));
> >  	u16 data = 0;
> 
> "data" doesn't need to be intialized to zero, it's set below before it's used.

Yeah I didn't touch it because this change is irrelevant to the rest.
But I can remove it altogether.

> 
> >  	int idx, r;
> 
> nit: I'd prefer to rename "idx" to "i" to make it more obvious it's a plain
> ole loop counter.  Reusing the srcu index made me do a double take :-)

Another irrelevant change, but ok.

> 
> >  
> > -	idx = srcu_read_lock(&kvm->srcu);
> > -	fn = to_kvm_vmx(kvm)->tss_addr >> PAGE_SHIFT;
> > -	r = kvm_clear_guest_page(kvm, fn, 0, PAGE_SIZE);
> > -	if (r < 0)
> > -		goto out;
> > +	for (idx = 0; idx < 3; idx++) {
> > +		r = __copy_to_user(ua + PAGE_SIZE * idx, zero_page, PAGE_SIZE);
> > +		if (r)
> > +			return -EFAULT;
> > +	}
> 
> Can this be done in a single __copy_to_user(), or do those helpers not like
> crossing page boundaries?

Maybe because the zero_page is only PAGE_SIZE long? :)

[...]

> > -int __x86_set_memory_region(struct kvm *kvm, int id, gpa_t gpa, u32 size)
> > +/**
> > + * __x86_set_memory_region: Setup KVM internal memory slot
> > + *
> > + * @kvm: the kvm pointer to the VM.
> > + * @id: the slot ID to setup.
> > + * @gpa: the GPA to install the slot (unused when @size == 0).
> > + * @size: the size of the slot. Set to zero to uninstall a slot.
> > + *
> > + * This function helps to setup a KVM internal memory slot.  Specify
> > + * @size > 0 to install a new slot, while @size == 0 to uninstall a
> > + * slot.  The return code can be one of the following:
> > + *
> > + *   - An error number if error happened, or,
> > + *   - For installation: the HVA of the newly mapped memory slot, or,
> > + *   - For uninstallation: zero if we successfully uninstall a slot.
> 
> Maybe tweak this so the return it stands out?  And returning zero on
> uninstallation is no longer true in kvm/queue, at least not without further
> modifications (as is it'll return 0xdead000000000000 on 64-bit).  The
> 0xdead shenanigans won't trigger IS_ERR(), so I think this can simply be:
> 
>  * Returns:
>  *   hva:    on success
>  *   -errno: on error
> 
> With the blurb below calling out that hva is bogus uninstallation.

Sure, I'll rebase to kvm/queue for the next version with the
suggestion.

Thanks,

-- 
Peter Xu

