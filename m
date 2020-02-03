Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83020C3524D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 12:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59AC920721
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 12:42:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bf2k9Iu0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727965AbgBCMmZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 07:42:25 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:47197 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727335AbgBCMmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 07:42:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580733742;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TYmvaWdfWIY2CO2m0YyjXtoTDOMMJedRMMAbCyAuU5U=;
        b=Bf2k9Iu0CICu5AAYKJ9DyPpablKXQu/9OvhfQ7qJi4BpsMQfy6/VMZ9P7nEweUX4k0C3Fy
        UuKC3q6JsruQR+OGnSBYTUE4Z05sN3mi1TVZ8Bne/BgQ91MOQWcWKQGHC+7UeMhGL7z7Of
        tdWa0pgw5Q3er9dY5xKi6bnICpiIcoA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-Yoyz9xG1O5OjUo-xJH3mtA-1; Mon, 03 Feb 2020 07:42:17 -0500
X-MC-Unique: Yoyz9xG1O5OjUo-xJH3mtA-1
Received: by mail-wm1-f71.google.com with SMTP id 7so4739083wmf.9
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 04:42:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=TYmvaWdfWIY2CO2m0YyjXtoTDOMMJedRMMAbCyAuU5U=;
        b=NNPEB50nDjVhR/Z6N+CVnw/ilpVR/uBuh/C0eQzRuX5VTHk6b+1ai10f+ibG+eGge3
         +lmmrvDChAyqI6qlnscunS1H3491IIoMCfgOU++J1wNTN4ySw31LpjR7Ea85XnD6d5ZY
         86WlxjxCCawnjQj/r+tSEhjv6V7zIlsEwxWq9vfrrFJYV31tT3YAGLjkQeRXIKi2EZDv
         5wXYx9+Q+bMCx7+gyCLYQ5GGXjgUk5ndEPHtTGZT6AAlpzUSRhKeVwB3r08UE+eeUU4K
         oBAOJgH6SPQYy5JGDOk6SsAIXW8Ab/PIrPXnzJVHHg73ZksV6JWT4r4ABnDNAKFnv81k
         ob/Q==
X-Gm-Message-State: APjAAAVgfLj1xL2fAYtn1E2ox95+Y+jSeSFc7tjlkii0rDTsSNH8m3O6
        /dXSkI4x46Mg5+DRg3YuFMWYBXOrSDiRBmIhAx31gp8ucRw7PyetlN1n34kOAu/JXLnm1j0yzsU
        w4WTy5i9SG4Ey3SKzo81HKdPk
X-Received: by 2002:a7b:c0d9:: with SMTP id s25mr4276782wmh.98.1580733736475;
        Mon, 03 Feb 2020 04:42:16 -0800 (PST)
X-Google-Smtp-Source: APXvYqwdm4k8EedzgClLA+MN0ll3YAa2bCfhF2w/sjiLgqXACvp+q6FVH7riajO76FmIcSp3p77YNw==
X-Received: by 2002:a7b:c0d9:: with SMTP id s25mr4276733wmh.98.1580733736187;
        Mon, 03 Feb 2020 04:42:16 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id n3sm23352349wmc.27.2020.02.03.04.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 04:42:15 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Cc:     pbonzini@redhat.com, sean.j.christopherson@intel.com,
        wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH] x86/kvm: do not setup pv tlb flush when not paravirtualized
In-Reply-To: <20200203101514.GG40679@calabresa>
References: <20200131155655.49812-1-cascardo@canonical.com> <87wo94ng9d.fsf@vitty.brq.redhat.com> <20200203101514.GG40679@calabresa>
Date:   Mon, 03 Feb 2020 13:42:14 +0100
Message-ID: <87r1zbona1.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thadeu Lima de Souza Cascardo <cascardo@canonical.com> writes:

> On Mon, Feb 03, 2020 at 10:59:10AM +0100, Vitaly Kuznetsov wrote:
>> Thadeu Lima de Souza Cascardo <cascardo@canonical.com> writes:
>> 
>> > kvm_setup_pv_tlb_flush will waste memory and print a misguiding message
>> > when KVM paravirtualization is not available.
>> >
>> > Intel SDM says that the when cpuid is used with EAX higher than the
>> > maximum supported value for basic of extended function, the data for the
>> > highest supported basic function will be returned.
>> >
>> > So, in some systems, kvm_arch_para_features will return bogus data,
>> > causing kvm_setup_pv_tlb_flush to detect support for pv tlb flush.
>> >
>> > Testing for kvm_para_available will work as it checks for the hypervisor
>> > signature.
>> >
>> > Besides, when the "nopv" command line parameter is used, it should not
>> > continue as well, as kvm_guest_init will no be called in that case.
>> >
>> > Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
>> > ---
>> >  arch/x86/kernel/kvm.c | 3 +++
>> >  1 file changed, 3 insertions(+)
>> >
>> > diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
>> > index 81045aabb6f4..d817f255aed8 100644
>> > --- a/arch/x86/kernel/kvm.c
>> > +++ b/arch/x86/kernel/kvm.c
>> > @@ -736,6 +736,9 @@ static __init int kvm_setup_pv_tlb_flush(void)
>> >  {
>> >  	int cpu;
>> >  
>> > +	if (!kvm_para_available() || nopv)
>> > +		return 0;
>> > +
>> >  	if (kvm_para_has_feature(KVM_FEATURE_PV_TLB_FLUSH) &&
>> >  	    !kvm_para_has_hint(KVM_HINTS_REALTIME) &&
>> >  	    kvm_para_has_feature(KVM_FEATURE_STEAL_TIME)) {
>> 
>> The patch will fix the immediate issue, but why kvm_setup_pv_tlb_flush()
>> is just an arch_initcall() which will be executed regardless of the fact
>> if we are running on KVM or not?
>> 
>> In Hyper-V we setup PV TLB flush from ms_hyperv_init_platform() -- which
>> only happens if Hyper-V platform was detected. Why don't we do it from
>> kvm_init_platform() in KVM?
>> 
>> -- 
>> Vitaly
>> 
>
> Because we can't call the allocator that early.
>
> Also, see the thread where this was "decided", the v6 of the original patch:
>
> https://lore.kernel.org/kvm/20171129162118.GA10661@flask/

Ok, I see, it's basically about what we prioritize: shorter boot time vs
smaller memory footprint. I'd personally vote for the former but the
opposite opinion is equally valid. Let's preserve the status quo.

-- 
Vitaly

