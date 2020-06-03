Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC522C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 11:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96CCA207D8
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 11:14:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TBNU0htz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726082AbgFCLOV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 07:14:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31157 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725936AbgFCLOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 07:14:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591182859;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=66+2fJmyMEeOm+RfdaX0dEV8FbowH6WPfR+JgsoWFaY=;
        b=TBNU0htzL4T+BmdndP5/nCKIe0+PWjr97ZMgRxt6V1D21MbVrRcG1l7LiCKVhX0O0WOJrv
        GyzU8OU5n6V4BeFbiY9sEpirA3Bkk3UjCNwwnQE2rbBaaIWBoBpXpxga7KLUH8ILOWULWz
        Ywtqn8vjmig3ub0t9obE2ml3aKTG0IY=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-wSwlmBnYPY-5MfGjfcSRLw-1; Wed, 03 Jun 2020 07:14:17 -0400
X-MC-Unique: wSwlmBnYPY-5MfGjfcSRLw-1
Received: by mail-ej1-f71.google.com with SMTP id w12so641187ejf.5
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 04:14:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=66+2fJmyMEeOm+RfdaX0dEV8FbowH6WPfR+JgsoWFaY=;
        b=FbdcSQqtA551MLx1m+y7TBGr6xfJmzyOmzMDrrjFMcMMQglwMEEilRsV6kFNCf45Wc
         0q5SD4ZEI5wzU9WYS15/LOburMWAnNzMIgkjkFwdod8WFmO4112i6pq+zYrxc+LP/DlU
         wEMTtNOL0LTubSKOT1teVra4fhlEmKauCRvdhH1TQboEps1aixFJVVFxL/JVvBfbwAIU
         T8llMENGLoQ2w18R4s4plEagTjCLVXb/lp7YwumtTBQXaZELI28pFACRfOwqjTv7zeas
         BT6tYQCv6P2/U0UwfABJ2A4AQUrKc03qAn+dbkmPxNfgscWIXaD3dBWDHYg8Ai4yKYj4
         GjPQ==
X-Gm-Message-State: AOAM533A/6DTowsmXsWqUzqFFtFkSthNuy3+OfuIJUYb8G+fYf5DHplp
        AvV8daF/0WW7oG3WyZR2P0MHlwHwuaCGKaY7Wr2APCy8impWHSyBsg/NsVMNcUBLIdWYyEdFXMF
        k5Tt3Nx9F5I9SBhKwNhcgDitV
X-Received: by 2002:a17:906:560b:: with SMTP id f11mr12470102ejq.11.1591182856241;
        Wed, 03 Jun 2020 04:14:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwmmkDjbCjAIUFgF6xHVnWC41NZMGs2xGfwkhaV1dIKlp/faLOhnX0X4W/6u4Q/Xq0ZFu5mvQ==
X-Received: by 2002:a17:906:560b:: with SMTP id f11mr12470075ejq.11.1591182856011;
        Wed, 03 Jun 2020 04:14:16 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id us3sm962679ejb.31.2020.06.03.04.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2020 04:14:15 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     "Huang\, Kai" <kai.huang@intel.com>
Cc:     "kvm\@vger.kernel.org" <kvm@vger.kernel.org>,
        "wad\@chromium.org" <wad@chromium.org>,
        "Kleen\, Andi" <andi.kleen@intel.com>,
        "luto\@kernel.org" <luto@kernel.org>,
        "aarcange\@redhat.com" <aarcange@redhat.com>,
        "keescook\@chromium.org" <keescook@chromium.org>,
        "dave.hansen\@linux.intel.com" <dave.hansen@linux.intel.com>,
        "wanpengli\@tencent.com" <wanpengli@tencent.com>,
        "kirill.shutemov\@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pbonzini\@redhat.com" <pbonzini@redhat.com>,
        "linux-mm\@kvack.org" <linux-mm@kvack.org>,
        "joro\@8bytes.org" <joro@8bytes.org>,
        "peterz\@infradead.org" <peterz@infradead.org>,
        "jmattson\@google.com" <jmattson@google.com>,
        "Edgecombe\, Rick P" <rick.p.edgecombe@intel.com>,
        "rientjes\@google.com" <rientjes@google.com>,
        "x86\@kernel.org" <x86@kernel.org>,
        "kirill\@shutemov.name" <kirill@shutemov.name>,
        "Christopherson\, Sean J" <sean.j.christopherson@intel.com>
Subject: Re: [RFC 02/16] x86/kvm: Introduce KVM memory protection feature
In-Reply-To: <0cd53be8abede7e82a68c32b1d8b0e4ca6f24a05.camel@intel.com>
References: <20200522125214.31348-1-kirill.shutemov@linux.intel.com> <20200522125214.31348-3-kirill.shutemov@linux.intel.com> <87d06s83is.fsf@vitty.brq.redhat.com> <20200525151525.qmfvzxbl7sq46cdq@box> <20200527050350.GK31696@linux.intel.com> <87eer56abe.fsf@vitty.brq.redhat.com> <0cd53be8abede7e82a68c32b1d8b0e4ca6f24a05.camel@intel.com>
Date:   Wed, 03 Jun 2020 13:14:13 +0200
Message-ID: <87r1uwflkq.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Huang, Kai" <kai.huang@intel.com> writes:

> On Wed, 2020-05-27 at 10:39 +0200, Vitaly Kuznetsov wrote:
>> Sean Christopherson <sean.j.christopherson@intel.com> writes:
>> 
>> > On Mon, May 25, 2020 at 06:15:25PM +0300, Kirill A. Shutemov wrote:
>> > > On Mon, May 25, 2020 at 04:58:51PM +0200, Vitaly Kuznetsov wrote:
>> > > > > @@ -727,6 +734,15 @@ static void __init kvm_init_platform(void)
>> > > > >  {
>> > > > >  	kvmclock_init();
>> > > > >  	x86_platform.apic_post_init = kvm_apic_init;
>> > > > > +
>> > > > > +	if (kvm_para_has_feature(KVM_FEATURE_MEM_PROTECTED)) {
>> > > > > +		if (kvm_hypercall0(KVM_HC_ENABLE_MEM_PROTECTED)) {
>> > > > > +			pr_err("Failed to enable KVM memory
>> > > > > protection\n");
>> > > > > +			return;
>> > > > > +		}
>> > > > > +
>> > > > > +		mem_protected = true;
>> > > > > +	}
>> > > > >  }
>> > > > 
>> > > > Personally, I'd prefer to do this via setting a bit in a KVM-specific
>> > > > MSR instead. The benefit is that the guest doesn't need to remember if
>> > > > it enabled the feature or not, it can always read the config msr. May
>> > > > come handy for e.g. kexec/kdump.
>> > > 
>> > > I think we would need to remember it anyway. Accessing MSR is somewhat
>> > > expensive. But, okay, I can rework it MSR if needed.
>> > 
>> > I think Vitaly is talking about the case where the kernel can't easily get
>> > at its cached state, e.g. after booting into a new kernel.  The kernel would
>> > still have an X86_FEATURE bit or whatever, providing a virtual MSR would be
>> > purely for rare slow paths.
>> > 
>> > That being said, a hypercall plus CPUID bit might be better, e.g. that'd
>> > allow the guest to query the state without risking a #GP.
>> 
>> We have rdmsr_safe() for that! :-) MSR (and hypercall to that matter)
>> should have an associated CPUID feature bit of course.
>> 
>> Yes, hypercall + CPUID would do but normally we treat CPUID data as
>> static and in this case we'll make it a dynamically flipping
>> bit. Especially if we introduce 'KVM_HC_DISABLE_MEM_PROTECTED' later.
>
> Not sure why is KVM_HC_DISABLE_MEM_PROTECTED needed?
>

I didn't put much thought in it but we may need it to support 'kexec'
case when no reboot is performed but we either need to pass  the data
about which regions are protected from old kernel to the new one or
'unprotect exerything'.

-- 
Vitaly

