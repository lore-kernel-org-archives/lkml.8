Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8812C33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 05:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86E602467B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 05:50:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jE0gSyQW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725899AbgA1FuY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 00:50:24 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:60627 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725791AbgA1FuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 00:50:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580190623;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yYYuRiOOOADVXfbeD2Pv+x4LlQDB1K7hRlPiSPrIgfs=;
        b=jE0gSyQWix5QUvkfZwHRjcNwZy0dS/XxQcB5KgHr/R2v/4Mn4ZM5iWil7K88zWb725iTp6
        MBGFPFPP11PaXlhwkRjOeOJTCkU2Sd6DPSAv4n9LMIwZvkXHD3FXbCiqyo/1zqjhYtNpqy
        v7+xPFSTxdQ1UYmxGxwKOxYL4WEXScQ=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-377-mJ1m1pozPl6zdRTbsJEYQg-1; Tue, 28 Jan 2020 00:50:21 -0500
X-MC-Unique: mJ1m1pozPl6zdRTbsJEYQg-1
Received: by mail-pl1-f198.google.com with SMTP id t12so5078899plo.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 21:50:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yYYuRiOOOADVXfbeD2Pv+x4LlQDB1K7hRlPiSPrIgfs=;
        b=o81vGQYHx4fybQn3oKEy6ZAMOQ+qJI1IQ2YGjt8r2l0ccwAWPwCY064NnFl3jJM/X+
         ibkgjmn70vJAOVQFiFbk9pH14i5eIfkEXv106UXMkXlnRBSIjRyGe0WBDe2NQzqKgn4x
         eft8oo77XqusGeLENLMljUzmgP9CLCWituI+w8igWSg/jWfWejbAM8KxsAnHXzZhF7js
         ArsMk6TyYIeY6O8aF4CbRG4ZEP5nw3ewTd8/qLZ4GnPSdIRJGxTXI6YcHyxplfzGFcsf
         G9jw94u4c/b9I2au9LWd5T8zwiBPpvSh1GwJ+ng7ZLgdX2AR+PYDiFx5Zw9XGIl9reyb
         IwhA==
X-Gm-Message-State: APjAAAVdAQQTmzRw/t+poPKknz58IeqE/j41ijOpg4wDV6LZ4aAsLUR7
        KDk9n0jsNyMw8xt6uvJl5lP6g7xRb7h+vtphJg8MGsrVjpNDnwGrGd29amseUN0jy8ZbPjF2BhZ
        oPF5RXSGXsciblRc8nlKBjEZL
X-Received: by 2002:a17:902:b611:: with SMTP id b17mr21076471pls.23.1580190620308;
        Mon, 27 Jan 2020 21:50:20 -0800 (PST)
X-Google-Smtp-Source: APXvYqzvxoYmYdKo0qycj3OjHlsiXjSQSEio0j+mObIUJyskXKJS+FYlMtyizXR+driketVKPcdRiQ==
X-Received: by 2002:a17:902:b611:: with SMTP id b17mr21076445pls.23.1580190619831;
        Mon, 27 Jan 2020 21:50:19 -0800 (PST)
Received: from xz-x1 ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id s25sm17234160pfh.110.2020.01.27.21.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 21:50:17 -0800 (PST)
Date:   Tue, 28 Jan 2020 13:50:05 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christophe de Dinechin <dinechin@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Yan Zhao <yan.y.zhao@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Kevin Kevin <kevin.tian@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH v3 09/21] KVM: X86: Don't track dirty for
 KVM_SET_[TSS_ADDR|IDENTITY_MAP_ADDR]
Message-ID: <20200128055005.GB662081@xz-x1>
References: <20200109145729.32898-1-peterx@redhat.com>
 <20200109145729.32898-10-peterx@redhat.com>
 <20200121155657.GA7923@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200121155657.GA7923@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 21, 2020 at 07:56:57AM -0800, Sean Christopherson wrote:
> On Thu, Jan 09, 2020 at 09:57:17AM -0500, Peter Xu wrote:
> > Originally, we have three code paths that can dirty a page without
> > vcpu context for X86:
> > 
> >   - init_rmode_identity_map
> >   - init_rmode_tss
> >   - kvmgt_rw_gpa
> > 
> > init_rmode_identity_map and init_rmode_tss will be setup on
> > destination VM no matter what (and the guest cannot even see them), so
> > it does not make sense to track them at all.
> > 
> > To do this, allow __x86_set_memory_region() to return the userspace
> > address that just allocated to the caller.  Then in both of the
> > functions we directly write to the userspace address instead of
> > calling kvm_write_*() APIs.  We need to make sure that we have the
> > slots_lock held when accessing the userspace address.
> > 
> > Another trivial change is that we don't need to explicitly clear the
> > identity page table root in init_rmode_identity_map() because no
> > matter what we'll write to the whole page with 4M huge page entries.
> > 
> > Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  arch/x86/include/asm/kvm_host.h |  3 +-
> >  arch/x86/kvm/svm.c              |  3 +-
> >  arch/x86/kvm/vmx/vmx.c          | 68 ++++++++++++++++-----------------
> >  arch/x86/kvm/x86.c              | 18 +++++++--
> >  4 files changed, 51 insertions(+), 41 deletions(-)
> > 
> > diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> > index eb6673c7d2e3..f536d139b3d2 100644
> > --- a/arch/x86/include/asm/kvm_host.h
> > +++ b/arch/x86/include/asm/kvm_host.h
> > @@ -1618,7 +1618,8 @@ void __kvm_request_immediate_exit(struct kvm_vcpu *vcpu);
> >  
> >  int kvm_is_in_guest(void);
> >  
> > -int __x86_set_memory_region(struct kvm *kvm, int id, gpa_t gpa, u32 size);
> > +int __x86_set_memory_region(struct kvm *kvm, int id, gpa_t gpa, u32 size,
> > +			    unsigned long *uaddr);
> 
> No need for a new param, just return a "void __user *" (or "void *" if the
> __user part requires lots of casting) and use ERR_PTR() to encode errors in
> the return value.  I.e. return the userspace address.
> 
> The refactoring to return the address should be done in a separate patch as
> prep work for the move to __copy_to_user().

Yes this sounds cleaner, will do.

> 
> >  bool kvm_vcpu_is_reset_bsp(struct kvm_vcpu *vcpu);
> >  bool kvm_vcpu_is_bsp(struct kvm_vcpu *vcpu);
> >  
> > diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
> > index 8f1b715dfde8..03a344ce7b66 100644
> > --- a/arch/x86/kvm/svm.c
> > +++ b/arch/x86/kvm/svm.c
> > @@ -1698,7 +1698,8 @@ static int avic_init_access_page(struct kvm_vcpu *vcpu)
> >  	ret = __x86_set_memory_region(kvm,
> >  				      APIC_ACCESS_PAGE_PRIVATE_MEMSLOT,
> >  				      APIC_DEFAULT_PHYS_BASE,
> > -				      PAGE_SIZE);
> > +				      PAGE_SIZE,
> > +				      NULL);
> >  	if (ret)
> >  		goto out;
> >  
> > diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> > index 7e3d370209e0..62175a246bcc 100644
> > --- a/arch/x86/kvm/vmx/vmx.c
> > +++ b/arch/x86/kvm/vmx/vmx.c
> > @@ -3441,34 +3441,28 @@ static bool guest_state_valid(struct kvm_vcpu *vcpu)
> >  	return true;
> >  }
> >  
> > -static int init_rmode_tss(struct kvm *kvm)
> > +static int init_rmode_tss(struct kvm *kvm, unsigned long *uaddr)
> 
> uaddr is not a pointer to an unsigned long, it's a pointer to a TSS.  Given
> that it's dereferenced as a "void __user *", it's probably best passed as
> exactly that.
> 
> This code also needs to be tested by doing unrestricted_guest=0 when
> loading kvm_intel, because it's obviously broken.  __x86_set_memory_region()
> takes an "unsigned long *", interpreted as a "pointer to a usersepace
> address", i.e. a "void __user **".  But the callers are treating the param
> as a "unsigned long in userpace", e.g. init_rmode_identity_map() declares
> uaddr as an "unsigned long *", when really it should be declaring a
> straight "unsigned long" and passing "&uaddr".  The only thing that saves
> KVM from dereferencing a bad pointer in __x86_set_memory_region() is that
> uaddr is initialized to NULL 

Yes it's broken.  Thanks very much for figuring it out.  I'll test
unrestricted_guest=N.

> 
> >  {
> > -	gfn_t fn;
> > +	const void *zero_page = (const void *) __va(page_to_phys(ZERO_PAGE(0)));
> >  	u16 data = 0;
> >  	int idx, r;
> >  
> > -	idx = srcu_read_lock(&kvm->srcu);
> > -	fn = to_kvm_vmx(kvm)->tss_addr >> PAGE_SHIFT;
> > -	r = kvm_clear_guest_page(kvm, fn, 0, PAGE_SIZE);
> > -	if (r < 0)
> > -		goto out;
> > +	for (idx = 0; idx < 3; idx++) {
> > +		r = __copy_to_user((void __user *)uaddr + PAGE_SIZE * idx,
> > +				   zero_page, PAGE_SIZE);
> > +		if (r)
> > +			return -EFAULT;
> > +	}
> > +
> >  	data = TSS_BASE_SIZE + TSS_REDIRECTION_SIZE;
> > -	r = kvm_write_guest_page(kvm, fn++, &data,
> > -			TSS_IOPB_BASE_OFFSET, sizeof(u16));
> > -	if (r < 0)
> > -		goto out;
> > -	r = kvm_clear_guest_page(kvm, fn++, 0, PAGE_SIZE);
> > -	if (r < 0)
> > -		goto out;
> > -	r = kvm_clear_guest_page(kvm, fn, 0, PAGE_SIZE);
> > -	if (r < 0)
> > -		goto out;
> > +	r = __copy_to_user((void __user *)uaddr + TSS_IOPB_BASE_OFFSET,
> > +			   &data, sizeof(data));
> > +	if (r)
> > +		return -EFAULT;
> > +
> >  	data = ~0;
> > -	r = kvm_write_guest_page(kvm, fn, &data,
> > -				 RMODE_TSS_SIZE - 2 * PAGE_SIZE - 1,
> > -				 sizeof(u8));
> > -out:
> > -	srcu_read_unlock(&kvm->srcu, idx);
> > +	r = __copy_to_user((void __user *)uaddr - 1, &data, sizeof(data));
> > +
> >  	return r;
> 
> Why not "return __copy_to_user();"?

Sure.

> 
> >  }
> >  
> > @@ -3478,6 +3472,7 @@ static int init_rmode_identity_map(struct kvm *kvm)
> >  	int i, r = 0;
> >  	kvm_pfn_t identity_map_pfn;
> >  	u32 tmp;
> > +	unsigned long *uaddr = NULL;
> 
> Again, not a pointer to an unsigned long.
> 
> >  	/* Protect kvm_vmx->ept_identity_pagetable_done. */
> >  	mutex_lock(&kvm->slots_lock);
> > @@ -3490,21 +3485,21 @@ static int init_rmode_identity_map(struct kvm *kvm)
> >  	identity_map_pfn = kvm_vmx->ept_identity_map_addr >> PAGE_SHIFT;
> >  
> >  	r = __x86_set_memory_region(kvm, IDENTITY_PAGETABLE_PRIVATE_MEMSLOT,
> > -				    kvm_vmx->ept_identity_map_addr, PAGE_SIZE);
> > +				    kvm_vmx->ept_identity_map_addr, PAGE_SIZE,
> > +				    uaddr);
> >  	if (r < 0)
> >  		goto out;
> >  
> > -	r = kvm_clear_guest_page(kvm, identity_map_pfn, 0, PAGE_SIZE);
> > -	if (r < 0)
> > -		goto out;
> >  	/* Set up identity-mapping pagetable for EPT in real mode */
> >  	for (i = 0; i < PT32_ENT_PER_PAGE; i++) {
> >  		tmp = (i << 22) + (_PAGE_PRESENT | _PAGE_RW | _PAGE_USER |
> >  			_PAGE_ACCESSED | _PAGE_DIRTY | _PAGE_PSE);
> > -		r = kvm_write_guest_page(kvm, identity_map_pfn,
> > -				&tmp, i * sizeof(tmp), sizeof(tmp));
> > -		if (r < 0)
> > +		r = __copy_to_user((void __user *)uaddr + i * sizeof(tmp),
> > +				   &tmp, sizeof(tmp));
> > +		if (r) {
> > +			r = -EFAULT;
> >  			goto out;
> > +		}
> >  	}
> >  	kvm_vmx->ept_identity_pagetable_done = true;
> >  
> > @@ -3537,7 +3532,7 @@ static int alloc_apic_access_page(struct kvm *kvm)
> >  	if (kvm->arch.apic_access_page_done)
> >  		goto out;
> >  	r = __x86_set_memory_region(kvm, APIC_ACCESS_PAGE_PRIVATE_MEMSLOT,
> > -				    APIC_DEFAULT_PHYS_BASE, PAGE_SIZE);
> > +				    APIC_DEFAULT_PHYS_BASE, PAGE_SIZE, NULL);
> >  	if (r)
> >  		goto out;
> >  
> > @@ -4478,19 +4473,22 @@ static int vmx_interrupt_allowed(struct kvm_vcpu *vcpu)
> >  static int vmx_set_tss_addr(struct kvm *kvm, unsigned int addr)
> >  {
> >  	int ret;
> > +	unsigned long *uaddr = NULL;
> >  
> >  	if (enable_unrestricted_guest)
> >  		return 0;
> >  
> >  	mutex_lock(&kvm->slots_lock);
> >  	ret = __x86_set_memory_region(kvm, TSS_PRIVATE_MEMSLOT, addr,
> > -				      PAGE_SIZE * 3);
> > -	mutex_unlock(&kvm->slots_lock);
> > -
> > +				      PAGE_SIZE * 3, uaddr);
> >  	if (ret)
> > -		return ret;
> > +		goto out;
> > +
> >  	to_kvm_vmx(kvm)->tss_addr = addr;
> > -	return init_rmode_tss(kvm);
> > +	ret = init_rmode_tss(kvm, uaddr);
> > +out:
> > +	mutex_unlock(&kvm->slots_lock);
> 
> Unnecessary, see below.

Do you mean that we don't even need the lock?

I feel like this could at least fail lockdep.  More below.

[1]

> 
> > +	return ret;
> >  }
> >  
> >  static int vmx_set_identity_map_addr(struct kvm *kvm, u64 ident_addr)
> > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > index c4d3972dcd14..ff97782b3919 100644
> > --- a/arch/x86/kvm/x86.c
> > +++ b/arch/x86/kvm/x86.c
> > @@ -9584,7 +9584,15 @@ void kvm_arch_sync_events(struct kvm *kvm)
> >  	kvm_free_pit(kvm);
> >  }
> >  
> > -int __x86_set_memory_region(struct kvm *kvm, int id, gpa_t gpa, u32 size)
> > +/*
> > + * If `uaddr' is specified, `*uaddr' will be returned with the
> > + * userspace address that was just allocated.  `uaddr' is only
> > + * meaningful if the function returns zero, and `uaddr' will only be
> > + * valid when with either the slots_lock or with the SRCU read lock
> > + * held.  After we release the lock, the returned `uaddr' will be invalid.
> 
> This is all incorrect.  Neither of those locks has any bearing on the
> validity of the hva.  slots_lock does as the name suggests and prevents
> concurrent writes to the memslots.  The SRCU lock ensures the implicit
> memslots lookup in kvm_clear_guest_page() won't result in a use-after-free
> due to derefencing old memslots.
> 
> Neither of those has anything to do with the userspace address, they're
> both fully tied to KVM's gfn->hva lookup.  As Paolo pointed out, KVM's
> mapping is instead tied to the lifecycle of the VM.  Note, even *that* has
> no bearing on the validity of the mapping or address as KVM only increments
> mm_count, not mm_users, i.e. guarantees the mm struct itself won't be freed
> but doesn't ensure the vmas or associated pages tables are valid.
> 
> Which is the entire point of using __copy_{to,from}_user(), as they
> gracefully handle the scenario where the process has not valid mapping
> and/or translation for the address.

Sorry I don't understand.

I do think either the slots_lock or SRCU would protect at least the
existing kvm.memslots, and if so at least the previous vm_mmap()
return value should still be valid.  I agree that __copy_to_user()
will protect us from many cases from process mm pov (which allows page
faults inside), but again if the kvm.memslots is changed underneath us
then it's another story, IMHO, and that's why we need either the lock
or SRCU.

Or are you assuming that (1) __x86_set_memory_region() is only for the
3 private kvm memslots, and (2) currently the kvm private memory slots
will never change after VM is created and before VM is destroyed?  If
so, I agree with you.  However I don't see why we need to restrict
__x86_set_memory_region() with that assumption, after all taking a
lock is not expensive in this slow path.  Even if so, we'd better
comment above __x86_set_memory_region() about this, so we know that we
should not use __x86_set_memory_region() for future kvm internal
memslots that are prone to change during VM's lifecycle (while
currently it seems to be a very general interface).

Please let me know if I misunderstood your point.

Thanks,

-- 
Peter Xu

