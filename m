Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B122C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 10:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35EA7206D4
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 10:53:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DowyvbiF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728675AbgESKxq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 06:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbgESKxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 06:53:45 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9732C061A0C;
        Tue, 19 May 2020 03:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=L/mR8vOE2/C4uXbuHUIpvj8AhD8h9hJmK8FIwWqfLoo=; b=DowyvbiFDd1nuuW79qrugnsmKj
        W7/5XeFIyXvVjQZXn4ztxJda1TDBWKbEm/MuLiK5Q/M+OtTneDrrrxbOaU5oDENJB0nA9vm4zBahz
        bRlSRqPvctUD0X7j/wrDZMGzO1JMxGMqU/OESm19sx+/0VLGPAYhuwO8gIjoNeBXqXtu1vE83QPqn
        m2V9GZXCw1h8jitvI/t9nP7UAbIThrCbIVV8OX8FkQbXZupX4rTn3XCV7vuaLkWbpaCNnXDJvZ+0x
        XG0npnDpq9BbCeEaqXK/S9fvTUoGeVOIIUxeVdH50hy6nVuokgVM+YAIzqjpRlz8G3abK10N8Pilt
        JngH84IA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jazsQ-0001f1-6p; Tue, 19 May 2020 10:53:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F3C463008A8;
        Tue, 19 May 2020 12:53:35 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DF7202868A9D5; Tue, 19 May 2020 12:53:35 +0200 (CEST)
Date:   Tue, 19 May 2020 12:53:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Like Xu <like.xu@linux.intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>, ak@linux.intel.com,
        wei.w.wang@intel.com
Subject: Re: [PATCH v11 07/11] KVM: x86: Expose MSR_IA32_PERF_CAPABILITIES
 for LBR record format
Message-ID: <20200519105335.GF279861@hirez.programming.kicks-ass.net>
References: <20200514083054.62538-1-like.xu@linux.intel.com>
 <20200514083054.62538-8-like.xu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200514083054.62538-8-like.xu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 04:30:50PM +0800, Like Xu wrote:
> @@ -203,6 +206,12 @@ static int intel_pmu_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  	case MSR_CORE_PERF_GLOBAL_OVF_CTRL:
>  		msr_info->data = pmu->global_ovf_ctrl;
>  		return 0;
> +	case MSR_IA32_PERF_CAPABILITIES:
> +		if (!msr_info->host_initiated &&
> +			!guest_cpuid_has(vcpu, X86_FEATURE_PDCM))
> +			return 1;

I know this is KVM code, so maybe they feel differently, but I find the
above indentation massively confusing. Consider using: "set cino=:0(0"
if you're a vim user.

> +		msr_info->data = vcpu->arch.perf_capabilities;
> +		return 0;
>  	default:
>  		if ((pmc = get_gp_pmc(pmu, msr, MSR_IA32_PERFCTR0))) {
>  			u64 val = pmc_read_counter(pmc);
> @@ -261,6 +270,16 @@ static int intel_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  			return 0;
>  		}
>  		break;
> +	case MSR_IA32_PERF_CAPABILITIES:
> +		if (!msr_info->host_initiated ||
> +			!guest_cpuid_has(vcpu, X86_FEATURE_PDCM))
> +			return 1;

Idem.

> +		if (!(data & ~vmx_get_perf_capabilities()))
> +			return 1;
> +		if ((data ^ vmx_get_perf_capabilities()) & PERF_CAP_LBR_FMT)
> +			return 1;
> +		vcpu->arch.perf_capabilities = data;
> +		return 0;
>  	default:
>  		if ((pmc = get_gp_pmc(pmu, msr, MSR_IA32_PERFCTR0))) {
>  			if (!msr_info->host_initiated)
