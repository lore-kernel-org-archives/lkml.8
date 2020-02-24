Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BCAFC38BFA
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 23:20:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71D7E2080D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 23:20:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cKQHMhMn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728235AbgBXXUL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 18:20:11 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21391 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726651AbgBXXUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 18:20:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582586408;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3xN9hq90N1oCxmHLczxcJX9jZofURAy8C2m6ZpIZZKs=;
        b=cKQHMhMnqZKg69DgkLqrXdyHbMTOdgi8DToVxGYzq5/YbPyhTbKMujbjTCqPSWpM3pKNgR
        NyIWdBv7QW+e99AXKJlwTVPQ23utTC4g6iDDrxZEDEkd3vqBXfQgpzn9K+Z5VpId3aTKWR
        ajchrLyhtpZHlQnCNVXcb8L21K/9D2I=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-362-73rCJALWNH-LXBWSyqBjrA-1; Mon, 24 Feb 2020 18:20:07 -0500
X-MC-Unique: 73rCJALWNH-LXBWSyqBjrA-1
Received: by mail-wr1-f70.google.com with SMTP id l1so6370775wrt.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 15:20:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=3xN9hq90N1oCxmHLczxcJX9jZofURAy8C2m6ZpIZZKs=;
        b=XZSdmx/hVOrz/f1UHa4KhY+k07JfCmENay9e5qF7OJiJM61KS5upDojRaLtajgHPKK
         W0LMTKIH3zdmu9u6FM4b3fWwguEnMCbpRSC5xOaUcOkhf37m+/ubLK31bD+dRixVjCsQ
         e9K8L6YXDF3BYLNv/0B7NCFAfwXphz5iXbcV6lIQ+6/tSZsMx0G9KlM3GRZUfvgemHnh
         Cr9Rs75GQU9bUhGUYwlRnzeAIwtpiu++ZGEnpDSzZe6XmXOkM+6uF+csQtzIXPWwa+re
         izOyoBXGWizWsX0Wj86mhs4sp1J8zaGn+5r08J9JpLTTIiFLFvWNR1dD8dOLPzdxs8u/
         TZuw==
X-Gm-Message-State: APjAAAVOBJ5gIsibmFLcfvLvO/o/MNH5H6mNIzAm+1g+AsDKDNAdZ6Y9
        uZLcNmj45BhmtTrh6uyZ0VmVN2aheRA0f+BI53RG/5HDHvJEFxuCCPOGRkrkz9GeL7ZJBtjsUCE
        IOnEJLYvi2gwFdIBusttFt+Lp
X-Received: by 2002:a1c:9d85:: with SMTP id g127mr1267506wme.75.1582586405669;
        Mon, 24 Feb 2020 15:20:05 -0800 (PST)
X-Google-Smtp-Source: APXvYqw4/T7cggFhTWfC4KkRP75jACd72Qyu+h14eKTuE+dLWVQ5k57SvfKJwNvSwtdxDI6CJ+/UOw==
X-Received: by 2002:a1c:9d85:: with SMTP id g127mr1267494wme.75.1582586405459;
        Mon, 24 Feb 2020 15:20:05 -0800 (PST)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id o9sm21491605wrw.20.2020.02.24.15.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 15:20:04 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 38/61] KVM: x86: Introduce kvm_cpu_caps to replace runtime CPUID masking
In-Reply-To: <20200224225743.GP29865@linux.intel.com>
References: <20200201185218.24473-1-sean.j.christopherson@intel.com> <20200201185218.24473-39-sean.j.christopherson@intel.com> <87h7zgndxl.fsf@vitty.brq.redhat.com> <20200224225743.GP29865@linux.intel.com>
Date:   Tue, 25 Feb 2020 00:20:03 +0100
Message-ID: <87ftezmv30.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> On Mon, Feb 24, 2020 at 05:32:54PM +0100, Vitaly Kuznetsov wrote:
>> Sean Christopherson <sean.j.christopherson@intel.com> writes:
>> 

...

>
>> > +
>> > +	BUILD_BUG_ON(sizeof(kvm_cpu_caps) >
>> > +		     sizeof(boot_cpu_data.x86_capability));
>> > +
>> > +	memcpy(&kvm_cpu_caps, &boot_cpu_data.x86_capability,
>> > +	       sizeof(kvm_cpu_caps));
>> > +
>> > +	kvm_cpu_cap_mask(CPUID_1_EDX,
>> > +		F(FPU) | F(VME) | F(DE) | F(PSE) |
>> > +		F(TSC) | F(MSR) | F(PAE) | F(MCE) |
>> > +		F(CX8) | F(APIC) | 0 /* Reserved */ | F(SEP) |
>> > +		F(MTRR) | F(PGE) | F(MCA) | F(CMOV) |
>> > +		F(PAT) | F(PSE36) | 0 /* PSN */ | F(CLFLUSH) |
>> > +		0 /* Reserved, DS, ACPI */ | F(MMX) |
>> > +		F(FXSR) | F(XMM) | F(XMM2) | F(SELFSNOOP) |
>> > +		0 /* HTT, TM, Reserved, PBE */
>> > +	);
>> > +
>> > +	kvm_cpu_cap_mask(CPUID_8000_0001_EDX,
>> > +		F(FPU) | F(VME) | F(DE) | F(PSE) |
>> > +		F(TSC) | F(MSR) | F(PAE) | F(MCE) |
>> > +		F(CX8) | F(APIC) | 0 /* Reserved */ | F(SYSCALL) |
>> > +		F(MTRR) | F(PGE) | F(MCA) | F(CMOV) |
>> > +		F(PAT) | F(PSE36) | 0 /* Reserved */ |
>> > +		f_nx | 0 /* Reserved */ | F(MMXEXT) | F(MMX) |
>> > +		F(FXSR) | F(FXSR_OPT) | f_gbpages | F(RDTSCP) |
>> > +		0 /* Reserved */ | f_lm | F(3DNOWEXT) | F(3DNOW)
>> > +	);
>> > +
>> > +	kvm_cpu_cap_mask(CPUID_1_ECX,
>> > +		/* NOTE: MONITOR (and MWAIT) are emulated as NOP,
>> > +		 * but *not* advertised to guests via CPUID ! */
>> > +		F(XMM3) | F(PCLMULQDQ) | 0 /* DTES64, MONITOR */ |
>> > +		0 /* DS-CPL, VMX, SMX, EST */ |
>> > +		0 /* TM2 */ | F(SSSE3) | 0 /* CNXT-ID */ | 0 /* Reserved */ |
>> > +		F(FMA) | F(CX16) | 0 /* xTPR Update, PDCM */ |
>> > +		F(PCID) | 0 /* Reserved, DCA */ | F(XMM4_1) |
>> > +		F(XMM4_2) | F(X2APIC) | F(MOVBE) | F(POPCNT) |
>> > +		0 /* Reserved*/ | F(AES) | F(XSAVE) | 0 /* OSXSAVE */ | F(AVX) |
>> > +		F(F16C) | F(RDRAND)
>> > +	);
>> 
>> I would suggest we order things by CPUID_NUM here, i.e.
>> 
>> CPUID_1_ECX
>> CPUID_1_EDX
>> CPUID_7_1_EAX
>> CPUID_7_0_EBX
>> CPUID_7_ECX
>> CPUID_7_EDX
>> CPUID_D_1_EAX
>> ...
>
> Hmm, generally speaking I agree, but I didn't want to change the ordering
> in this patch when moving the code.  Throw a patch on top?  Leave as is?
> Something else?

My line of thought was: it's not a mechanical "s,const u32
xxx_x86_features =,kvm_cpu_cap_mask...," change, things get moved from
do_cpuid_7_mask() and __do_cpuid_func() so we may as well re-order them,
reviewing-wise it's more or less the same. But honestly, this is very
minor, feel free to leave as-is.

-- 
Vitaly

