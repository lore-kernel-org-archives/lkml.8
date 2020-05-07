Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 412FBC38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 18:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D7122145D
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 18:05:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dbIMaMty"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbgEGSFR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 14:05:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20655 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726514AbgEGSFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 14:05:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588874715;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7ZT8uf+8nR83y0d403Od1JUqxjPNizjmPd+u74qytwY=;
        b=dbIMaMtyowm+UNPdR0XQrz3rLX09T3QF8RIWJdeCC587UF7OWtIQTkWer6rlo+WaQSJTKt
        O8TfMW5okqRoC5u0Bt73LsUJ4StSNfKp7nUbCw7iOg2hBJHzNsdE86+CfCEL3TPujHi13S
        0EQ0y55yLH8FkroEMV7cQmfmxW8C4XA=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-2UqXDvlnMmy8rXYVrwXgrQ-1; Thu, 07 May 2020 14:05:12 -0400
X-MC-Unique: 2UqXDvlnMmy8rXYVrwXgrQ-1
Received: by mail-qk1-f198.google.com with SMTP id i10so6619134qkm.23
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 11:05:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7ZT8uf+8nR83y0d403Od1JUqxjPNizjmPd+u74qytwY=;
        b=BBS7jn8lgnSYWpEKOxbyvB6fTp68/+u2vArRq0+kDMFwgsJjbyduMB9dsFbZm6TEHz
         cryBas/bFVriqLnbDeNHlrQWRf74//DylBFJecY2bTDL2lhci+gvKTnEA5/pLOYq2oB7
         2NeZeVTdqOpZKTVBIUojUrVchrecz+WJhjf6WYKqvFONTasp0n4kvgaUbThCdHWMNfoM
         QoFNgsk2YYKrUW1YNxH6F7uhagIzVpFjT3A4W5xegTNZ2SIt62FfFhO6p9eeklmoGXQw
         pEWQLptlzAVJdwgurozHyRkeuXoX6IGcgWtjtnUmFuU3Zs8LUWMDTf2/7BM+uSFHDe2j
         2rKg==
X-Gm-Message-State: AGi0PuYL5MXxv9TI+c/0xU4qfplNKSAA5E4hdb0aYwuDShFsN6UiuA1A
        8jpZhLUAJE1o302eBBtdU4I6NezC5XMCvi+EndqhbzAkkppg6SNYyDCAa1I7GFnDN7CAwmp4NFl
        2uFF0nCMLLWFtp4lGMhl7WYeI
X-Received: by 2002:a37:8d07:: with SMTP id p7mr16276236qkd.500.1588874711177;
        Thu, 07 May 2020 11:05:11 -0700 (PDT)
X-Google-Smtp-Source: APiQypLaD9wsQNdumwebtoAZ7rJYDUyJERvx2DqBTrcl3tFL8/q8qwbOR3ce/0xUX7ee+QK3N2tBXw==
X-Received: by 2002:a37:8d07:: with SMTP id p7mr16276184qkd.500.1588874710644;
        Thu, 07 May 2020 11:05:10 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id o16sm4104750qko.38.2020.05.07.11.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 11:05:09 -0700 (PDT)
Date:   Thu, 7 May 2020 14:05:08 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH 9/9] KVM: VMX: pass correct DR6 for GD userspace exit
Message-ID: <20200507180508.GH228260@xz-x1>
References: <20200507115011.494562-1-pbonzini@redhat.com>
 <20200507115011.494562-10-pbonzini@redhat.com>
 <20200507161854.GF228260@xz-x1>
 <7abe5f7b-2b5a-4e32-34e2-f37d0afef00a@redhat.com>
 <20200507163839.GG228260@xz-x1>
 <db06ffa7-1e3c-14e5-28b8-5053f4383ecf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <db06ffa7-1e3c-14e5-28b8-5053f4383ecf@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 07, 2020 at 07:42:25PM +0200, Paolo Bonzini wrote:
> On 07/05/20 18:38, Peter Xu wrote:
> > On Thu, May 07, 2020 at 06:21:18PM +0200, Paolo Bonzini wrote:
> >> On 07/05/20 18:18, Peter Xu wrote:
> >>>>  		if (vcpu->guest_debug & KVM_GUESTDBG_USE_HW_BP) {
> >>>> -			vcpu->run->debug.arch.dr6 = vcpu->arch.dr6;
> >>>> +			vcpu->run->debug.arch.dr6 = DR6_BD | DR6_RTM | DR6_FIXED_1;
> >>> After a second thought I'm thinking whether it would be okay to have BS set in
> >>> that test case.  I just remembered there's a test case in the kvm-unit-test
> >>> that checks explicitly against BS leftover as long as dr6 is not cleared
> >>> explicitly by the guest code, while the spec seems to have no explicit
> >>> description on this case.
> >>
> >> Yes, I noticed that test as well.  But I don't like having different
> >> behavior for Intel and AMD, and the Intel behavior is more sensible.
> >> Also...
> > 
> > Do you mean the AMD behavior is more sensible instead? :)
> 
> No, I mean within the context of KVM_EXIT_DEBUG: the Intel behavior is
> to only include the latest debug exception in kvm_run's DR6 field, while
> the AMD behavior would be to include all of them.  This was an
> implementation detail (it happens because Intel sets kvm_run's DR6 from
> the exit qualification of #DB), but it's more sensible too.
> 
> In addition:
> 
> * AMD was completely broken until this week, so the behavior of
> KVM_EXIT_DEBUG is defined de facto by kvm_intel.ko.  Userspace has not
> been required to set DR6 with KVM_SET_GUEST_DEBUG, and since we can
> emulate that on AMD, we should.
> 
> * we have to fix anyway the fact that on AMD a KVM_EXIT_DEBUG is
> clobbering the contents of the guest's DR6
> 
> >>> Intead of above, I'm thinking whether we should allow the userspace to also
> >>> change dr6 with the KVM_SET_GUEST_DEBUG ioctl when they wanted to (right now
> >>> iiuc dr6 from userspace is completely ignored), instead of offering a fake dr6.
> >>> Or to make it simple, maybe we can just check BD bit only?
> >>
> >> ... I'm afraid that this would be a backwards-incompatible change, and
> >> it would require changes in userspace.  If you look at v2, emulating the
> >> Intel behavior in AMD turns out to be self-contained and relatively
> >> elegant (will be better when we finish cleaning up nested SVM).
> > 
> > I'm still trying to read the other patches (I need some more digest because I'm
> > even less familiar with nested...).  I agree that it would be good to keep the
> > same behavior across Intel/AMD.  Actually that also does not violate Intel spec
> > because the AMD one is stricter.
> 
> Again, careful---we're talking about KVM_EXIT_DEBUG, not the #DB exception.

OK I get your point now.  Thanks,

-- 
Peter Xu

