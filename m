Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF7AC35671
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 07:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 453762071E
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 07:35:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dqcrsz14"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727163AbgBVHeo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 02:34:44 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:51360 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726689AbgBVHeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 02:34:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582356883;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n5QiDO/cYngNst5DwCBSGaHO3mEAXrmiolBfoQ+ipjE=;
        b=dqcrsz14QSQBvrS03avS71l+ZVyONRziX1M3Xxq4NhSQGGfW1hXtiZyR0dhcc9J4fta0dG
        z3/StWkf36zRzjKnv08Hi5n2XodU2VoP9CTJeA+aRy9zkQAvKxGWVG5LhqfrgGMF2Cs1Cz
        ObAJaOILF7q7VA8FDQuoMbPT4ACPHeQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-111-0ONxitSaOviiXpjaWC2dbg-1; Sat, 22 Feb 2020 02:34:41 -0500
X-MC-Unique: 0ONxitSaOviiXpjaWC2dbg-1
Received: by mail-wr1-f70.google.com with SMTP id 90so2164953wrq.6
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 23:34:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=n5QiDO/cYngNst5DwCBSGaHO3mEAXrmiolBfoQ+ipjE=;
        b=EtgVd0SEadWRjsOEEmY9pgqDPXPeQolt539/XHbVWTX1uuPkLIOHNUlHEBF6tN1XTk
         c/262oiTdK9TSYxaJKOUgHMAIV7u2ZINpcC6bUqIrxoPHhEv2imJhYCgSdfD9TK8a1/t
         LOYViiDpF/7rNmSsOrd8u5GsPiZGF8QhQbxFMDfpC9yucGyMdOrw+RqiKvUaWeRC1RTD
         7PWQ3H/qOd3cgHcHWx4HqPnp9mAkePvPufQS1Tk6oAqZbqExb/SIdgHR3dkPr7DsOSvl
         XOU1Lf4kzUEw8VhhdjPmmfWid+LCckV4V+xUEfuw7svOK/yvCl0S89KLiJR/50ZLiWdJ
         t+vQ==
X-Gm-Message-State: APjAAAWlg7tnI9mZIkjk28JC2j2amgnFPvQWNIvbooSxYWE8M9Go0R9+
        jBqYnstyJXX6qGKy8hrqUaoFIUYtCPim38iPyUF6D7T1H/yrftC0N1gRDT26/pnnMLysRWdP7oD
        ID7AJwGKKFThWwASmIEVbwxFG
X-Received: by 2002:adf:e602:: with SMTP id p2mr48534155wrm.388.1582356880475;
        Fri, 21 Feb 2020 23:34:40 -0800 (PST)
X-Google-Smtp-Source: APXvYqwXhE+bWdSsegefuoDYCV5dHo1uX3uXwl4IzYHol3g9sHCd2ycgZbiFxk+vGq4YCQwNGC5BMw==
X-Received: by 2002:adf:e602:: with SMTP id p2mr48534121wrm.388.1582356880117;
        Fri, 21 Feb 2020 23:34:40 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:ec41:5e57:ff4d:8e51? ([2001:b07:6468:f312:ec41:5e57:ff4d:8e51])
        by smtp.gmail.com with ESMTPSA id a16sm7491633wrx.87.2020.02.21.23.34.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2020 23:34:39 -0800 (PST)
Subject: Re: [PATCH] KVM: x86: Adjust counter sample period after a wrmsr
To:     Eric Hankland <ehankland@google.com>,
        Jim Mattson <jmattson@google.com>,
        Peter Shier <pshier@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <20200222023413.78202-1-ehankland@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9adcb973-7b60-71dd-636d-1e451e664c55@redhat.com>
Date:   Sat, 22 Feb 2020 08:34:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200222023413.78202-1-ehankland@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/02/20 03:34, Eric Hankland wrote:
> The sample_period of a counter tracks when that counter will
> overflow and set global status/trigger a PMI. However this currently
> only gets set when the initial counter is created or when a counter is
> resumed; this updates the sample period after a wrmsr so running
> counters will accurately reflect their new value.
> 
> Signed-off-by: Eric Hankland <ehankland@google.com>
> ---
>  arch/x86/kvm/pmu.c           | 4 ++--
>  arch/x86/kvm/pmu.h           | 8 ++++++++
>  arch/x86/kvm/vmx/pmu_intel.c | 6 ++++++
>  3 files changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
> index bcc6a73d6628..d1f8ca57d354 100644
> --- a/arch/x86/kvm/pmu.c
> +++ b/arch/x86/kvm/pmu.c
> @@ -111,7 +111,7 @@ static void pmc_reprogram_counter(struct kvm_pmc *pmc, u32 type,
>  		.config = config,
>  	};
>  
> -	attr.sample_period = (-pmc->counter) & pmc_bitmask(pmc);
> +	attr.sample_period = get_sample_period(pmc, pmc->counter);
>  
>  	if (in_tx)
>  		attr.config |= HSW_IN_TX;
> @@ -158,7 +158,7 @@ static bool pmc_resume_counter(struct kvm_pmc *pmc)
>  
>  	/* recalibrate sample period and check if it's accepted by perf core */
>  	if (perf_event_period(pmc->perf_event,
> -			(-pmc->counter) & pmc_bitmask(pmc)))
> +			      get_sample_period(pmc, pmc->counter)))
>  		return false;
>  
>  	/* reuse perf_event to serve as pmc_reprogram_counter() does*/
> diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
> index 13332984b6d5..354b8598b6c1 100644
> --- a/arch/x86/kvm/pmu.h
> +++ b/arch/x86/kvm/pmu.h
> @@ -129,6 +129,15 @@ static inline struct kvm_pmc *get_fixed_pmc(struct kvm_pmu *pmu, u32 msr)
>  	return NULL;
>  }
>  
> +static inline u64 get_sample_period(struct kvm_pmc *pmc, u64 counter_value)
> +{
> +	u64 sample_period = (-counter_value) & pmc_bitmask(pmc);
> +
> +	if (!sample_period)
> +		sample_period = pmc_bitmask(pmc) + 1;
> +	return sample_period;
> +}
> +
>  void reprogram_gp_counter(struct kvm_pmc *pmc, u64 eventsel);
>  void reprogram_fixed_counter(struct kvm_pmc *pmc, u8 ctrl, int fixed_idx);
>  void reprogram_counter(struct kvm_pmu *pmu, int pmc_idx);
> diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
> index fd21cdb10b79..e933541751fb 100644
> --- a/arch/x86/kvm/vmx/pmu_intel.c
> +++ b/arch/x86/kvm/vmx/pmu_intel.c
> @@ -263,9 +263,15 @@ static int intel_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  			if (!msr_info->host_initiated)
>  				data = (s64)(s32)data;
>  			pmc->counter += data - pmc_read_counter(pmc);
> +			if (pmc->perf_event)
> +				perf_event_period(pmc->perf_event,
> +						  get_sample_period(pmc, data));
>  			return 0;
>  		} else if ((pmc = get_fixed_pmc(pmu, msr))) {
>  			pmc->counter += data - pmc_read_counter(pmc);
> +			if (pmc->perf_event)
> +				perf_event_period(pmc->perf_event,
> +						  get_sample_period(pmc, data));
>  			return 0;
>  		} else if ((pmc = get_gp_pmc(pmu, msr, MSR_P6_EVNTSEL0))) {
>  			if (data == pmc->eventsel)
> 

Queued, thanks.

Paolo

