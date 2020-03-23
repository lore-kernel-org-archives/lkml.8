Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B79C54FCE
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 14:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 785FD20735
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 14:58:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FCc7MxzM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbgCWO6g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 10:58:36 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:36227 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725776AbgCWO6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 10:58:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584975515;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=d3WRK4z56Y42/PY4ghJillk9+g6MIzYsEFbTD8+0g1Y=;
        b=FCc7MxzMXH1DrtADJDpmUHHurrUyGL/0lQOPVpKNvGV/7PLG1KFCp4CVjajLX2o6JJqjI+
        ZG59q115lZ6NX/Cjog7OV4bvfCHUBNPv91YrJKnSfpsaVuw2zCu7SgzXLXxNzI0p5rOu5F
        bdNTtrMuUcqXJ1vauL4SgkmR2wTbxgY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-356-7f4i5WOwNOKvHBToDxEqSA-1; Mon, 23 Mar 2020 10:58:33 -0400
X-MC-Unique: 7f4i5WOwNOKvHBToDxEqSA-1
Received: by mail-wr1-f70.google.com with SMTP id r9so5372149wrs.13
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 07:58:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=d3WRK4z56Y42/PY4ghJillk9+g6MIzYsEFbTD8+0g1Y=;
        b=lpYkMBd9uwJvOYyzsZzRnS7b5cVqWaYKfvASR+iTQ/itmdFyydaw6hpBUtA1f8kQk4
         pLmG3AZAutA2aMBhiU70cGDnuRJrlo/Sj019iy4miEDyXsXVCchxhLYuvK67KaEQ92Mn
         2CcV/vSKVxmyHjUgEf9ITjEtYVtt7RR/152kNr6pIY0154Qtc9K5tBdoGGLwP2oOJqO+
         wP+0RHgsX37k12w3e+WjZ1B9u/a6bydVVc4QVYBB288PNOYtVuZ0nrqlRD1E9BeiC3Tp
         W3GEcDBJczG50WGyy7984mbShvPhnRLx9J1um7opli6rBqXLJU1e3EzSxEltywZdxoWv
         fumQ==
X-Gm-Message-State: ANhLgQ2S0E2/RF+RlKDQlKwTywzlLELF7W0hs8VX/uCGkh5hXUpOTaPZ
        3OKC12WrcSqf6Tu2HkLarwd1uXyNUX8yJ7VnXTrrw1uFoUzBcPVWFz+Z2xlSY7Sn2Z/1Ge+rehq
        qz8E47TwB9yJ3gDhWmMT9UQ/Y
X-Received: by 2002:a1c:63c4:: with SMTP id x187mr27485579wmb.124.1584975510396;
        Mon, 23 Mar 2020 07:58:30 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtoTXAh8X4n57EHAjSowNYqJvDEgjxu7m+yH90pSUDygASePCuRdJZ/5o/fIE8laYiQAShSiw==
X-Received: by 2002:a1c:63c4:: with SMTP id x187mr27485546wmb.124.1584975510037;
        Mon, 23 Mar 2020 07:58:30 -0700 (PDT)
Received: from xz-x1 (CPEf81d0fb19163-CMf81d0fb19160.cpe.net.fido.ca. [72.137.123.47])
        by smtp.gmail.com with ESMTPSA id 195sm22060803wmb.8.2020.03.23.07.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 07:58:29 -0700 (PDT)
Date:   Mon, 23 Mar 2020 10:58:24 -0400
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
Message-ID: <20200323145824.GI127076@xz-x1>
References: <20200318163720.93929-1-peterx@redhat.com>
 <20200318163720.93929-4-peterx@redhat.com>
 <20200321192211.GC13851@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200321192211.GC13851@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 21, 2020 at 12:22:11PM -0700, Sean Christopherson wrote:
> On Wed, Mar 18, 2020 at 12:37:09PM -0400, Peter Xu wrote:
> > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > index e54c6ad628a8..a5123a0aa7d6 100644
> > --- a/arch/x86/kvm/x86.c
> > +++ b/arch/x86/kvm/x86.c
> > @@ -9786,7 +9786,34 @@ void kvm_arch_sync_events(struct kvm *kvm)
> >  	kvm_free_pit(kvm);
> >  }
> >  
> > -int __x86_set_memory_region(struct kvm *kvm, int id, gpa_t gpa, u32 size)
> > +#define  ERR_PTR_USR(e)  ((void __user *)ERR_PTR(e))
> > +
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
> > + *   HVA:           on success (uninstall will return a bogus HVA)
> > + *   -errno:        on error
> > + *
> > + * The caller should always use IS_ERR() to check the return value
> > + * before use.  NOTE: KVM internal memory slots are guaranteed and
> 
> "are guaranteed" to ...
> 
> > + * won't change until the VM is destroyed. This is also true to the
> > + * returned HVA when installing a new memory slot.  The HVA can be
> > + * invalidated by either an errornous userspace program or a VM under
> > + * destruction, however as long as we use __copy_{to|from}_user()
> > + * properly upon the HVAs and handle the failure paths always then
> > + * we're safe.
> 
> Regarding the HVA, it's a bit confusing saying that it's guaranteed to be
> valid, and then contradicting that in the second clause.  Maybe something
> like this to explain the GPA->HVA is guaranteed to be valid, but the
> HVA->HPA is not.
>  
> /*
>  * before use.  Note, KVM internal memory slots are guaranteed to remain valid
>  * and unchanged until the VM is destroyed, i.e. the GPA->HVA translation will
>  * not change.  However, the HVA is a user address, i.e. its accessibility is
>  * not guaranteed, and must be accessed via __copy_{to,from}_user().
>  */

Sure I can switch to this, though note that I still think the GPA->HVA
is not guaranteed logically because the userspace can unmap any HVA it
wants..  However I agree that shouldn't be important from kvm's
perspective as long as we always emphasize on using legal HVA accessors.

-- 
Peter Xu

