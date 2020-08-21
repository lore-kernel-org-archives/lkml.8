Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8708C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 01:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B590620748
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 01:46:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UJiTVBb0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbgHUBqn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 21:46:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54545 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726810AbgHUBqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 21:46:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597974394;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GLmCKZgr3b1tSy1Gjcxl9scoffP4gQg5bODIFLHH+RI=;
        b=UJiTVBb01tLYK8EXrvMFJyaObpc4MDNftVj4vrFHGHivcaQEHgwc4+CorLKX+vxbW/B4VB
        +ynZBESWL+VfY5b65DhVzCMhSP0VgFWzO4Yr0IWHtMNX65W8tbC36Wm/kUx40fwvWgF+6S
        yghAQGVfnrA5qVoZDFWCM2fzkBGRTK8=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-445-5saBiPcXNEWXAbp2_op9cQ-1; Thu, 20 Aug 2020 21:46:32 -0400
X-MC-Unique: 5saBiPcXNEWXAbp2_op9cQ-1
Received: by mail-qk1-f200.google.com with SMTP id 195so291259qke.14
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 18:46:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GLmCKZgr3b1tSy1Gjcxl9scoffP4gQg5bODIFLHH+RI=;
        b=LY37dV+Ma4isiYlYdVwy2QrnBFGN2UlSDWYG1cYWSDK3D9yAFtDN8fdPX+TavdwFPB
         8RE63ScflwBN5GlgIac3GYKyXFrK4aWhwzRBDNx3GhmepkIkSfrFEWsw9ivbYGFXr5m4
         BK/Il9P+tMnwRVr2GUkySkPK7c8HcquuIojMv/scL4XsgYjWR8e0ebVNAzrD35L1LSkh
         2ins1lcVqtzPOdMJCxfJs8+wvIIrTBrhaK/NIJLL2njuZFtgVI73RLZmR6XQRoAOOIh8
         c9b0gIySw0GOAbvY8rkwp6paP4bI5LwTvlGTtXGJjgVKFL5bfgFKoalYFxAyqa/jFr4j
         hPXg==
X-Gm-Message-State: AOAM5327gSJ5FVv2Cmc6/iRRd6I53hbD8V6sE7786Y3gROywO46p6dm4
        AMuvRbx9AGRS6ZcGPqjrGd+8etgozH0A1+ssmn0oxJILjqRSfFUwewYK6evTyOy1shoakSh7Ex8
        2kkKiSFrFYGLbnwrn1OaTwyLu
X-Received: by 2002:ad4:4aa5:: with SMTP id i5mr519419qvx.179.1597974392186;
        Thu, 20 Aug 2020 18:46:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzrlFMy+84phcbTZX0JBOmoAL1qg1oqQYDrKrHvnBQYxhl6Ynsyk4M9JlvVmeSM4LO9CKHZYw==
X-Received: by 2002:ad4:4aa5:: with SMTP id i5mr519405qvx.179.1597974391929;
        Thu, 20 Aug 2020 18:46:31 -0700 (PDT)
Received: from redhat.com (bzq-109-67-40-161.red.bezeqint.net. [109.67.40.161])
        by smtp.gmail.com with ESMTPSA id 73sm453194qtf.74.2020.08.20.18.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 18:46:30 -0700 (PDT)
Date:   Thu, 20 Aug 2020 21:46:25 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Peter Xu <peterx@redhat.com>,
        Julia Suvorova <jsuvorov@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Jones <drjones@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] KVM: x86: introduce KVM_MEM_PCI_HOLE memory
Message-ID: <20200820214407-mutt-send-email-mst@kernel.org>
References: <20200807141232.402895-1-vkuznets@redhat.com>
 <20200807141232.402895-3-vkuznets@redhat.com>
 <20200814023139.GB4845@linux.intel.com>
 <20200814102850-mutt-send-email-mst@kernel.org>
 <20200817163207.GC22407@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200817163207.GC22407@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 17, 2020 at 09:32:07AM -0700, Sean Christopherson wrote:
> On Fri, Aug 14, 2020 at 10:30:14AM -0400, Michael S. Tsirkin wrote:
> > On Thu, Aug 13, 2020 at 07:31:39PM -0700, Sean Christopherson wrote:
> > > > @@ -2318,6 +2338,11 @@ static int __kvm_read_guest_page(struct kvm_memory_slot *slot, gfn_t gfn,
> > > >  	int r;
> > > >  	unsigned long addr;
> > > >  
> > > > +	if (unlikely(slot && (slot->flags & KVM_MEM_PCI_HOLE))) {
> > > > +		memset(data, 0xff, len);
> > > > +		return 0;
> > > > +	}
> > > 
> > > This feels wrong, shouldn't we be treating PCI_HOLE as MMIO?  Given that
> > > this is performance oriented, I would think we'd want to leverage the
> > > GPA from the VMCS instead of doing a full translation.
> > > 
> > > That brings up a potential alternative to adding a memslot flag.  What if
> > > we instead add a KVM_MMIO_BUS device similar to coalesced MMIO?  I think
> > > it'd be about the same amount of KVM code, and it would provide userspace
> > > with more flexibility, e.g. I assume it would allow handling even writes
> > > wholly within the kernel for certain ranges and/or use cases, and it'd
> > > allow stuffing a value other than 0xff (though I have no idea if there is
> > > a use case for this).
> > 
> > I still think down the road the way to go is to map
> > valid RO page full of 0xff to avoid exit on read.
> > I don't think a KVM_MMIO_BUS device will allow this, will it?
> 
> No, it would not, but adding KVM_MEM_PCI_HOLE doesn't get us any closer to
> solving that problem either.

I'm not sure why. Care to elaborate?

> What if we add a flag to allow routing all GFNs in a memslot to a single
> HVA?

An issue here would be this breaks attempts to use a hugepage for this.


>  At a glance, it doesn't seem to heinous.  It would have several of the
> same touchpoints as this series, e.g. __kvm_set_memory_region() and
> kvm_alloc_memslot_metadata().
> 
> The functional changes (for x86) would be a few lines in
> __gfn_to_hva_memslot() and some new logic in kvm_handle_hva_range().  The
> biggest concern is probably the fragility of such an implementation, as KVM
> has a habit of open coding operations on memslots.
> 
> The new flags could then be paired with KVM_MEM_READONLY to yield the desired
> behavior of reading out 0xff for an arbitrary range without requiring copious
> memslots and/or host pages.
> 
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 852fc8274bdd..875243a0ab36 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -1103,6 +1103,9 @@ __gfn_to_memslot(struct kvm_memslots *slots, gfn_t gfn)
>  static inline unsigned long
>  __gfn_to_hva_memslot(struct kvm_memory_slot *slot, gfn_t gfn)
>  {
> +       if (unlikely(slot->flags & KVM_MEM_SINGLE_HVA))
> +               return slot->userspace_addr;
> +
>         return slot->userspace_addr + (gfn - slot->base_gfn) * PAGE_SIZE;
>  }

