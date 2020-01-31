Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14E1CC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 15:08:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D59C2214D8
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 15:08:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IV3x0LjH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729244AbgAaPIm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 10:08:42 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33869 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729074AbgAaPIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 10:08:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580483320;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ao5KrNXtNkM/tF29re2/qinnBa2LAW0IsXBS+tc1J3M=;
        b=IV3x0LjHw+MhTH+ko0LI59/B2U5lJ0NhJjcdLKhUhbcZIj1m1PTLDmHcUDptnaS5mxuLVD
        uAFoMzUV6h9JV8QhhqgA1IAx7vEJsiL4D2sEYQMxWDawtbvmVnV+c/Q0DSJjJpKMMhgPqu
        XEAudtU4rbslXDFzgQf/3b7FlyRe//c=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-247-J6B5JiS9OKGCjH8rj8WtPg-1; Fri, 31 Jan 2020 10:08:36 -0500
X-MC-Unique: J6B5JiS9OKGCjH8rj8WtPg-1
Received: by mail-qt1-f198.google.com with SMTP id m30so4814439qtb.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jan 2020 07:08:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ao5KrNXtNkM/tF29re2/qinnBa2LAW0IsXBS+tc1J3M=;
        b=gbmMbgLgSyirL+uE3f566JU9DXk0zyxMV6R1uyc78vAudk4nKwKjF11kCaMNep7WHZ
         K3d54aZn76NpuWQreMouBQpWoK50/8tKrFLE4KfBRq65Zj8qJ4yR9gmOPPR3fzdd17Bv
         E/i/e/O8YPHhh+hoQTF8xaZKQzsO39/RNNak6Za2UUExH7VM02S5RGPD87PVZiGxRoKH
         urxEvKsjKm1t2n1G+UQtOm1Q0NMoZTEIqdjhsYqkds0lWhVkj2RYF5QQMobYOJxNvLFe
         gaiX876tNSZZEtxYnlUr8YCSD7fI3FcuSq9/X/Qji+FwvhS4Bt8vBEJHryEW32Mh+d8S
         g71w==
X-Gm-Message-State: APjAAAVjcAqoFlJteHxmNkeNIBlpSQuL90JB+nTW+99gyHliLOg1H6d7
        vpncCs2ef64CGXTqk46QlTm56lEwdUIDN7AlvIRjSCX+aG5+/3DFe5BVEzFoFHFs2plpRBzXI0o
        HKIj0O74mGEjqgIsFNcdktScn
X-Received: by 2002:a05:620a:2050:: with SMTP id d16mr11206394qka.473.1580483316156;
        Fri, 31 Jan 2020 07:08:36 -0800 (PST)
X-Google-Smtp-Source: APXvYqy4dWlHCI+GWoFvd6CMrReascKHMPXtyM7CmlPjhpmhjbOmlW6CuUmZbV3doAAOjs9vT2Z0bQ==
X-Received: by 2002:a05:620a:2050:: with SMTP id d16mr11206356qka.473.1580483315741;
        Fri, 31 Jan 2020 07:08:35 -0800 (PST)
Received: from xz-x1 ([2607:9880:19c8:32::2])
        by smtp.gmail.com with ESMTPSA id m68sm4462082qke.17.2020.01.31.07.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2020 07:08:35 -0800 (PST)
Date:   Fri, 31 Jan 2020 10:08:32 -0500
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
Message-ID: <20200131150832.GA740148@xz-x1>
References: <20200109145729.32898-1-peterx@redhat.com>
 <20200109145729.32898-10-peterx@redhat.com>
 <20200121155657.GA7923@linux.intel.com>
 <20200128055005.GB662081@xz-x1>
 <20200128182402.GA18652@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200128182402.GA18652@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2020 at 10:24:03AM -0800, Sean Christopherson wrote:
> On Tue, Jan 28, 2020 at 01:50:05PM +0800, Peter Xu wrote:
> > On Tue, Jan 21, 2020 at 07:56:57AM -0800, Sean Christopherson wrote:
> > > > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > > > index c4d3972dcd14..ff97782b3919 100644
> > > > --- a/arch/x86/kvm/x86.c
> > > > +++ b/arch/x86/kvm/x86.c
> > > > @@ -9584,7 +9584,15 @@ void kvm_arch_sync_events(struct kvm *kvm)
> > > >  	kvm_free_pit(kvm);
> > > >  }
> > > >  
> > > > -int __x86_set_memory_region(struct kvm *kvm, int id, gpa_t gpa, u32 size)
> > > > +/*
> > > > + * If `uaddr' is specified, `*uaddr' will be returned with the
> > > > + * userspace address that was just allocated.  `uaddr' is only
> > > > + * meaningful if the function returns zero, and `uaddr' will only be
> > > > + * valid when with either the slots_lock or with the SRCU read lock
> > > > + * held.  After we release the lock, the returned `uaddr' will be invalid.
> > > 
> > > This is all incorrect.  Neither of those locks has any bearing on the
> > > validity of the hva.  slots_lock does as the name suggests and prevents
> > > concurrent writes to the memslots.  The SRCU lock ensures the implicit
> > > memslots lookup in kvm_clear_guest_page() won't result in a use-after-free
> > > due to derefencing old memslots.
> > > 
> > > Neither of those has anything to do with the userspace address, they're
> > > both fully tied to KVM's gfn->hva lookup.  As Paolo pointed out, KVM's
> > > mapping is instead tied to the lifecycle of the VM.  Note, even *that* has
> > > no bearing on the validity of the mapping or address as KVM only increments
> > > mm_count, not mm_users, i.e. guarantees the mm struct itself won't be freed
> > > but doesn't ensure the vmas or associated pages tables are valid.
> > > 
> > > Which is the entire point of using __copy_{to,from}_user(), as they
> > > gracefully handle the scenario where the process has not valid mapping
> > > and/or translation for the address.
> > 
> > Sorry I don't understand.
> > 
> > I do think either the slots_lock or SRCU would protect at least the
> > existing kvm.memslots, and if so at least the previous vm_mmap()
> > return value should still be valid.
> 
> Nope.  kvm->slots_lock only protects gfn->hva lookups, e.g. userspace can
> munmap() the range at any time.

Do we need to consider that?  If the userspace did this then it'll
corrupt itself, and imho private memory slot is not anything special
here comparing to the user memory slots.  For example, the userspace
can unmap any region after KVM_SET_USER_MEMORY_REGION ioctl even if
the region is filled into some of the userspace_addr of
kvm_userspace_memory_region, so the cached userspace_addr can be
invalid, then kvm_write_guest_page() can fail too with the same
reason.  IMHO kvm only need to make sure it handles the failure path
then it's perfectly fine.

> 
> > I agree that __copy_to_user() will protect us from many cases from process
> > mm pov (which allows page faults inside), but again if the kvm.memslots is
> > changed underneath us then it's another story, IMHO, and that's why we need
> > either the lock or SRCU.
> 
> No, again, slots_lock and SRCU only protect gfn->hva lookups.

Yes, then could you further explain why do you think we don't need the
slot lock?  

> 
> > Or are you assuming that (1) __x86_set_memory_region() is only for the
> > 3 private kvm memslots, 
> 
> It's not an assumption, the entire purpose of __x86_set_memory_region()
> is to provide support for private KVM memslots.
> 
> > and (2) currently the kvm private memory slots will never change after VM
> > is created and before VM is destroyed?
> 
> No, I'm not assuming the private memslots are constant, e.g. the flow in
> question, vmx_set_tss_addr() is directly tied to an unprotected ioctl().

Why it's unprotected?  Now vmx_set_tss_add() is protected by the slots
lock so concurrent operation is safe, also it'll return -EEXIST if
called for more than once.

[1]

> 
> KVM's sole responsible for vmx_set_tss_addr() is to not crash the kernel.
> Userspace is responsible for ensuring it doesn't break its guests, e.g.
> that multiple calls to KVM_SET_TSS_ADDR are properly serialized.
> 
> In the existing code, KVM ensures it doesn't crash by holding the SRCU lock
> for the duration of init_rmode_tss() so that the gfn->hva lookups in
> kvm_clear_guest_page() don't dereference a stale memslots array.

Here in the current master branch we have both the RCU lock and the
slot lock held, that's why I think we can safely remove the RCU lock
as long as we're still holding the slots lock.  We can't do the
reverse because otherwise multiple KVM_SET_TSS_ADDR could race.

> In no way
> does that ensure the validity of the resulting hva,

Yes, but as I mentioned, I don't think it's an issue to be considered
by KVM, otherwise we should have the same issue all over the places
when we fetch the cached userspace_addr from any user slots.

> e.g. multiple calls to
> KVM_SET_TSS_ADDR would race to set vmx->tss_addr and so init_rmode_tss()
> could be operating on a stale gpa.

Please refer to [1].

I just want to double-confirm on what we're discussing now. Are you
sure you're suggesting that we should remove the slot lock in
init_rmode_tss()?  Asked because you discussed quite a bit on how the
slot lock should protect GPA->HVA, about concurrency and so on, then
I'm even more comfused...

Thanks,

-- 
Peter Xu

