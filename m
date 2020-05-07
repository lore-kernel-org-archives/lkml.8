Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA71FC38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 07:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6E702080D
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 07:57:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hxVZJcBD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbgEGH5Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 03:57:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27891 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725845AbgEGH5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 03:57:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588838233;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y9mwxyuCup0Q6hGGVaVop/Mcsx5sPEES6xR+JKy3xlE=;
        b=hxVZJcBDiF9XWNz0ur4Dun5BEo26R1Mqd9OOf6LqmMDwvkOiQXSjIa7Scy5z9nom661t+P
        ozshqaEWv1joaVwX3Z9X238YK3DAglLfRNTgLFpxz2T5r27C6wTpb9ymJFk0JiZ7j+wXvj
        GWQQpTSS77H4JkK3bJDSNTSOVoKRpGw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-179-YsvCxeH0NlScWpa0CkhEVg-1; Thu, 07 May 2020 03:57:10 -0400
X-MC-Unique: YsvCxeH0NlScWpa0CkhEVg-1
Received: by mail-wr1-f70.google.com with SMTP id a12so2940348wrv.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 00:57:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=y9mwxyuCup0Q6hGGVaVop/Mcsx5sPEES6xR+JKy3xlE=;
        b=JnwxzLjIQoQjf56D/bwF4P1tHP2B45vumieJzHuJXsV8deP/ayVEikckTs8/nZ8Ni5
         EaYub18vytmDk99RcSVRIg2fzgSNNJ0dG3n9YSRRHT+3lMJQuWzACUiETNIOB9Qr4LGc
         wkKJXKjCZYgI/lHxDgNBmcm/k8e7z77lJCUGZFcJRjSbKUUnWCFPAyCdN4xuOHwI/yBq
         IrFRq7k1qtpMXhlSidGP5cfVCk1GZ6patZgL6iePCKgeY9v1sccWzMCXnt6lfQkKldBf
         3EUIi0FSgfa97ETji4ESbz+fNset8eOEol7REfGDgyVdtZOWlJAnhsRMwSktTQW6mSOA
         rVsg==
X-Gm-Message-State: AGi0PuYxj3mePhbONPP2klHC0I/gfuWFrpA4/4JCgxmVHY0APmKogK12
        Wz0qzdBebdy5843taQynqbF//2LHOS/yMT/wUWASW60bKCokIv+0XtBD8A7mm/E7y4cg51k0SeS
        jUY6eOynJT0wUcSskW3aySbW2
X-Received: by 2002:a1c:3206:: with SMTP id y6mr8660128wmy.111.1588838228718;
        Thu, 07 May 2020 00:57:08 -0700 (PDT)
X-Google-Smtp-Source: APiQypJ1HGj369geDqMTet3EHW3ra3/6X7k36PjWNlzfDZu8OSHXRqpZOWKYn7h+nDpGIM9yv2dipw==
X-Received: by 2002:a1c:3206:: with SMTP id y6mr8660098wmy.111.1588838228397;
        Thu, 07 May 2020 00:57:08 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:8d3e:39e5:cd88:13cc? ([2001:b07:6468:f312:8d3e:39e5:cd88:13cc])
        by smtp.gmail.com with ESMTPSA id m15sm6619827wmc.35.2020.05.07.00.57.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2020 00:57:07 -0700 (PDT)
Subject: Re: [PATCH v2] KVM: x86/pmu: Support full width counting
To:     Like Xu <like.xu@linux.intel.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200507021452.174646-1-like.xu@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3fb56700-7f0b-59e1-527a-f8eb601185b1@redhat.com>
Date:   Thu, 7 May 2020 09:57:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200507021452.174646-1-like.xu@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/05/20 04:14, Like Xu wrote:
> +static inline u64 vmx_get_perf_capabilities(void)
> +{
> +	u64 perf_cap = 0;
> +
> +	if (boot_cpu_has(X86_FEATURE_PDCM))
> +		rdmsrl(MSR_IA32_PERF_CAPABILITIES, perf_cap);
> +
> +	/* Currently, KVM only supports Full-Width Writes. */
> +	perf_cap &= PMU_CAP_FW_WRITES;
> +
> +	return perf_cap;
> +}
> +

Since counters are virtualized, it seems to me that you can support
PMU_CAP_FW_WRITES unconditionally, even if the host lacks it.  So just
return PMU_CAP_FW_WRITES from this function.

> +	case MSR_IA32_PERF_CAPABILITIES:
> +		return 1; /* RO MSR */
>  	default:

You need to allow writes from the host if (data &
~vmx_get_perf_capabilities()) == 0.

> -			if (!msr_info->host_initiated)
> +		if ((pmc = get_gp_pmc(pmu, msr, MSR_IA32_PERFCTR0)) ||
> +			(pmc = get_gp_pmc(pmu, msr, MSR_IA32_PMC0))) {
> +			if (data & ~pmu->counter_bitmask[KVM_PMC_GP])
> +				return 1;
> +			if (!fw_writes_is_enabled(pmu))
>  				data = (s64)(s32)data;


You are dropping the test on msr_info->host_initiated here, you should
keep it otherwise you allow full-width write to MSR_IA32_PERFCTR0 as
well.  So:

#define MSR_PMC_FULL_WIDTH_BIT      (MSR_IA32_PMC0 - MSR_IA32_PERFCTR0)

	if (!msr_info->host_initiated && !(msr & MSR_PMC_FULL_WIDTH_BIT))
		data = (s64)(s32)data;

> +	case MSR_IA32_PERF_CAPABILITIES:
> +		if (!nested)
> +			return 1;
> +		msr->data = vmx_get_perf_capabilities();
> +		return 0;

The !nested check is wrong.

> 
> +++ b/arch/x86/kvm/x86.c
> @@ -1220,6 +1220,13 @@ static const u32 msrs_to_save_all[] = {
>  	MSR_ARCH_PERFMON_EVENTSEL0 + 12, MSR_ARCH_PERFMON_EVENTSEL0 + 13,
>  	MSR_ARCH_PERFMON_EVENTSEL0 + 14, MSR_ARCH_PERFMON_EVENTSEL0 + 15,
>  	MSR_ARCH_PERFMON_EVENTSEL0 + 16, MSR_ARCH_PERFMON_EVENTSEL0 + 17,
> +
> +	MSR_IA32_PMC0, MSR_IA32_PMC0 + 1, MSR_IA32_PMC0 + 2,
> +	MSR_IA32_PMC0 + 3, MSR_IA32_PMC0 + 4, MSR_IA32_PMC0 + 5,
> +	MSR_IA32_PMC0 + 6, MSR_IA32_PMC0 + 7, MSR_IA32_PMC0 + 8,
> +	MSR_IA32_PMC0 + 9, MSR_IA32_PMC0 + 10, MSR_IA32_PMC0 + 11,
> +	MSR_IA32_PMC0 + 12, MSR_IA32_PMC0 + 13, MSR_IA32_PMC0 + 14,
> +	MSR_IA32_PMC0 + 15, MSR_IA32_PMC0 + 16, MSR_IA32_PMC0 + 17,
>  };

This is not needed because the full-width content is already accessible
from the host via MSR_IA32_PERFCTRn.

Given the bugs, it is clear that you should also modify the pmu.c
testcase for kvm-unit-tests to cover full-width writes (and especially
the non-full-width write behavior of MSR_IA32_PERFCTRn).  Even before
the QEMU side is begin worked on, you can test it with "-cpu
host,migratable=off".

Thanks,

Paolo

