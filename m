Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F22C54EEB
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 16:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEE882051A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 16:26:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R0affpWB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbgCWQ02 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 12:26:28 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:51813 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727277AbgCWQ02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 12:26:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584980787;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ehj56ajVRi23GK2T3VjArh7Mw9HqSg7LkHrp/uuAqAM=;
        b=R0affpWBWeXIFlBMR+2HiG3PVXGnT9H6ODp0znrGTfFHXbnG/YpkL4luap05IuZwUvAG+3
        Hd+DjUk2KM3vFXZbe6tXLMDmyDeYycE+g9QCXpTW9OupOFIDcAAe4w28h5bZsGS2Ll0kA9
        oHkWtDbcYt2BN0RSn9VakkIbd/JsrEo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-104-E8MyuUU4MoavOvYxzAOjew-1; Mon, 23 Mar 2020 12:26:23 -0400
X-MC-Unique: E8MyuUU4MoavOvYxzAOjew-1
Received: by mail-wr1-f69.google.com with SMTP id f15so2224726wrt.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 09:26:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ehj56ajVRi23GK2T3VjArh7Mw9HqSg7LkHrp/uuAqAM=;
        b=TJS2geeEJcANWcKQeY8+sauSIfztmz+QAM/0DlXCxjZeQWJs+bA3DtQQ7WqOciaEbU
         qQ8fc4RZcwm8CucdAF1Juy9yduG++ZgMdrjTbVV+2vLpr9//gVUT6APW0uYcEP9QtZXj
         jlpChJ+vpiARCbAx6MGQPVVpFIXoWNUs2iXpevRf34kpMhiWZC2RuAMG/NMjrVxJt8wa
         5o3JdReHHkNLeqb3BPDRQ+nwarWHzXZfVRAI2Jem5CGejbGT+Ef6TrN9fam6sWF6Bb1G
         95Q+lPX6HnvgmuRz7diEnlP9vXXTfjQ1WcgmB9X2SXmtH+gjTXs0JqtMubkmAdIZveUJ
         YcNQ==
X-Gm-Message-State: ANhLgQ0SyO9aKNIpAa6EU7eovAlNpenLl01bfx9+lF5ZW8dW6WpP+Jpk
        n/xZGxLEHvcbxN4hx6B80+ep8YoPHP80YtqIJi/F8UMxuXAMJ9rGSnw2oZX90nJt1cnt5lMP5XV
        54ZYBxBmoARZxW7aiEA+8/Hhd
X-Received: by 2002:adf:edcf:: with SMTP id v15mr21828469wro.309.1584980782065;
        Mon, 23 Mar 2020 09:26:22 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtMysjez2ebPBp50c+OTI7OG21qECbdMaArQCV37S+j+P83ACU6Rz9s2G4ofu1vahE6S+f0NQ==
X-Received: by 2002:adf:edcf:: with SMTP id v15mr21828443wro.309.1584980781832;
        Mon, 23 Mar 2020 09:26:21 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id a8sm66129wmb.39.2020.03.23.09.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 09:26:21 -0700 (PDT)
Date:   Mon, 23 Mar 2020 12:26:17 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Yan Zhao <yan.y.zhao@intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Christophe de Dinechin <dinechin@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v7 03/14] KVM: X86: Don't track dirty for
 KVM_SET_[TSS_ADDR|IDENTITY_MAP_ADDR]
Message-ID: <20200323162617.GK127076@xz-x1>
References: <20200318163720.93929-1-peterx@redhat.com>
 <20200318163720.93929-4-peterx@redhat.com>
 <20200321192211.GC13851@linux.intel.com>
 <20200323145824.GI127076@xz-x1>
 <20200323154216.GG28711@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200323154216.GG28711@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 23, 2020 at 08:42:16AM -0700, Sean Christopherson wrote:
> On Mon, Mar 23, 2020 at 10:58:24AM -0400, Peter Xu wrote:
> > On Sat, Mar 21, 2020 at 12:22:11PM -0700, Sean Christopherson wrote:
> > > On Wed, Mar 18, 2020 at 12:37:09PM -0400, Peter Xu wrote:
> > > > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > > > index e54c6ad628a8..a5123a0aa7d6 100644
> > > > --- a/arch/x86/kvm/x86.c
> > > > +++ b/arch/x86/kvm/x86.c
> > > > @@ -9786,7 +9786,34 @@ void kvm_arch_sync_events(struct kvm *kvm)
> > > >  	kvm_free_pit(kvm);
> > > >  }
> > > >  
> > > > -int __x86_set_memory_region(struct kvm *kvm, int id, gpa_t gpa, u32 size)
> > > > +#define  ERR_PTR_USR(e)  ((void __user *)ERR_PTR(e))
> > > > +
> > > > +/**
> > > > + * __x86_set_memory_region: Setup KVM internal memory slot
> > > > + *
> > > > + * @kvm: the kvm pointer to the VM.
> > > > + * @id: the slot ID to setup.
> > > > + * @gpa: the GPA to install the slot (unused when @size == 0).
> > > > + * @size: the size of the slot. Set to zero to uninstall a slot.
> > > > + *
> > > > + * This function helps to setup a KVM internal memory slot.  Specify
> > > > + * @size > 0 to install a new slot, while @size == 0 to uninstall a
> > > > + * slot.  The return code can be one of the following:
> > > > + *
> > > > + *   HVA:           on success (uninstall will return a bogus HVA)
> > > > + *   -errno:        on error
> > > > + *
> > > > + * The caller should always use IS_ERR() to check the return value
> > > > + * before use.  NOTE: KVM internal memory slots are guaranteed and
> > > 
> > > "are guaranteed" to ...
> > > 
> > > > + * won't change until the VM is destroyed. This is also true to the
> > > > + * returned HVA when installing a new memory slot.  The HVA can be
> > > > + * invalidated by either an errornous userspace program or a VM under
> > > > + * destruction, however as long as we use __copy_{to|from}_user()
> > > > + * properly upon the HVAs and handle the failure paths always then
> > > > + * we're safe.
> > > 
> > > Regarding the HVA, it's a bit confusing saying that it's guaranteed to be
> > > valid, and then contradicting that in the second clause.  Maybe something
> > > like this to explain the GPA->HVA is guaranteed to be valid, but the
> > > HVA->HPA is not.
> > >  
> > > /*
> > >  * before use.  Note, KVM internal memory slots are guaranteed to remain valid
> > >  * and unchanged until the VM is destroyed, i.e. the GPA->HVA translation will
> > >  * not change.  However, the HVA is a user address, i.e. its accessibility is
> > >  * not guaranteed, and must be accessed via __copy_{to,from}_user().
> > >  */
> > 
> > Sure I can switch to this, though note that I still think the GPA->HVA
> > is not guaranteed logically because the userspace can unmap any HVA it
> > wants..
> 
> You're conflating the GPA->HVA translation with the validity of the HVA,
> i.e. the HVA->HPA and/or HVA->VMA translation/association.  GPA->HVA is
> guaranteed because userspace doesn't have access to the memslot which
> defines that transation.

Yes I completely agree if you mean the pure mapping of GPA->HVA.

I think it's a matter of how to define the "valid" when you say
"guaranteed to remain valid", because I don't think the mapping is
still valid from the most strict sense if e.g. the backing HVA does
not exist any more for that GPA->HVA mapping, then the memslot won't
be anything useful.

> 
> > However I agree that shouldn't be important from kvm's perspective as long as
> > we always emphasize on using legal HVA accessors.
> 
> The fact that GPA->HVA can't change _is_ important, otherwise KVM would
> need to take steps to ensure that whatever can change GPA->HVA can't run
> concurrently with consuming the HVA. 

I wanted to mean "the userspace unmaps the HVA" is not important.  The
mapping is for sure important!

Thanks,

-- 
Peter Xu

