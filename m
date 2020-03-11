Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,RDNS_NONE,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32904 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729887AbgCKPtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 11:49:01 -0400
Received: by mail-qk1-f199.google.com with SMTP id b82so1739534qkc.11
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 08:48:54 -0700 (PDT)
Date: Wed, 11 Mar 2020 11:48:50 -0400
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
Subject: Re: [PATCH v6 02/14] KVM: Cache as_id in kvm_memory_slot
Message-ID: <20200311154850.GE479302@xz-x1>
References: <20200309214424.330363-1-peterx@redhat.com>
 <20200309214424.330363-3-peterx@redhat.com>
 <20200310144858.GA7600@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200310144858.GA7600@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 10, 2020 at 07:48:59AM -0700, Sean Christopherson wrote:
> On Mon, Mar 09, 2020 at 05:44:12PM -0400, Peter Xu wrote:
> > Cache the address space ID just like the slot ID.  It will be used in
> > order to fill in the dirty ring entries.
> > 
> > Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> > Suggested-by: Sean Christopherson <sean.j.christopherson@intel.com>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  include/linux/kvm_host.h | 1 +
> >  virt/kvm/kvm_main.c      | 2 ++
> >  2 files changed, 3 insertions(+)
> > 
> > diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> > index bcb9b2ac0791..afa0e9034881 100644
> > --- a/include/linux/kvm_host.h
> > +++ b/include/linux/kvm_host.h
> > @@ -346,6 +346,7 @@ struct kvm_memory_slot {
> >  	unsigned long userspace_addr;
> >  	u32 flags;
> >  	short id;
> > +	u8 as_id;
> 
> My vote is to store this as a u16 and remove the BUILD_BUG_ON.  Using a u8
> doesn't save any memory since the compiler will pad out the struct.

Sure. Indeed that BUILD_BUG_ON does not help much in this case.  Thanks,

> 
> >  };
> >  
> >  static inline unsigned long kvm_dirty_bitmap_bytes(struct kvm_memory_slot *memslot)
> > diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> > index 70f03ce0e5c1..e6484dabfc59 100644
> > --- a/virt/kvm/kvm_main.c
> > +++ b/virt/kvm/kvm_main.c
> > @@ -1036,6 +1036,8 @@ int __kvm_set_memory_region(struct kvm *kvm,
> >  
> >  	new = old = *slot;
> >  
> > +	BUILD_BUG_ON(U8_MAX < KVM_ADDRESS_SPACE_NUM);
> > +	new.as_id = as_id;
> >  	new.id = id;
> >  	new.base_gfn = base_gfn;
> >  	new.npages = npages;
> > -- 
> > 2.24.1
> > 
> 

-- 
Peter Xu

