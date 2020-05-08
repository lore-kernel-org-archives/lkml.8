Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C5CC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 09:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37B5421473
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 09:51:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tfm15WQ5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgEHJvD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 05:51:03 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:49977 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726083AbgEHJvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 05:51:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588931461;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yBP012LisVeq02MvD+mTCJEz8/IbuMae8oTpvqKDdT0=;
        b=Tfm15WQ5rUde3jWNCXLJ1W6DymyJiJAjAcZKLLI3DCECNuc5SjUqqmy92lAhoPAJT8fOO0
        Kdn80d/UqgauNfx/bihUrI3+RK0LeXm+0H7GKZvtixDqGEvFJIPDov3Zj/ZnFjdstV6Bu5
        4SFYuK19QI0vh0Z5Bi8XSFjrmS/hHic=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-138-8bQWnaDHOy-1YKZtyJAUFQ-1; Fri, 08 May 2020 05:50:59 -0400
X-MC-Unique: 8bQWnaDHOy-1YKZtyJAUFQ-1
Received: by mail-wr1-f72.google.com with SMTP id z5so616081wrt.17
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 02:50:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yBP012LisVeq02MvD+mTCJEz8/IbuMae8oTpvqKDdT0=;
        b=Acu+VixF54RtLuj5sEjum1Dd4uAZ29ZLwsDdM2j01uac11CVJAfOdBln1xRV9t0I9A
         IPJ3xprfu/Yazc7WAt69iUrjXorSZBGqQmR01YCldUEZ6j9DZWrZwZ8CX25ksDhxtYJp
         9vjT96sxzb6ZcOsjdFGRLYACJ2J+sCKy7JMCjfUkcE2yeaKab7Ze3yDAE9l30yg6ii3r
         /VvGeQwYxMlGIBQdmRnDOV4gID0atBVv5mCw5xs1o26syfSrjoUB6DI0uubejJCKUiG8
         8W8A1NbpJ8kc8xgB7dkt5NcHe9x95dQ7kNTBXbN45tpqGhUXZ3Xj4E/53Y4xwAwJIXeU
         7Q6g==
X-Gm-Message-State: AGi0PuZhNiBuM4mspu5I2VnYwm5zuZdkzRz19w6TE2LntLRgEJV84eWN
        luuGqPt+w99fXyMhfwCCZsgoeRc08+w3gC/UIAgew4UXH7wFWm8ooiglVA079ziKRK8dP30XWxm
        HFk3tDslpitxHy8epZsTAgv2g
X-Received: by 2002:a05:6000:1244:: with SMTP id j4mr2010704wrx.189.1588931458113;
        Fri, 08 May 2020 02:50:58 -0700 (PDT)
X-Google-Smtp-Source: APiQypIWXmDNhLC5gO9SMkwG5Lh6nz7g8uF7L7LsK3nzgsXIOvFcFCFkDeit0JOLiJZCVVFzWCUN/A==
X-Received: by 2002:a05:6000:1244:: with SMTP id j4mr2010670wrx.189.1588931457883;
        Fri, 08 May 2020 02:50:57 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:20ea:bae4:47a7:31db? ([2001:b07:6468:f312:20ea:bae4:47a7:31db])
        by smtp.gmail.com with ESMTPSA id z1sm12491316wmf.15.2020.05.08.02.50.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 May 2020 02:50:57 -0700 (PDT)
Subject: Re: [PATCH v3] KVM: x86/pmu: Support full width counting
To:     Like Xu <like.xu@linux.intel.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200508083218.120559-1-like.xu@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f1c77c79-7ff8-c5f3-e011-9874a4336217@redhat.com>
Date:   Fri, 8 May 2020 11:50:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200508083218.120559-1-like.xu@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I would just do small changes to the validity checks for MSRs.

On 08/05/20 10:32, Like Xu wrote:
>  		return 0;
> +	case MSR_IA32_PERF_CAPABILITIES:
> +		*data = vcpu->arch.perf_capabilities;
> +		return 0;

This should be:

		if (!msr_info->host_initiated &&
		    !guest_cpuid_has(vcpu, X86_FEATURE_PDCM))
			return 1;

>  	default:
> -		if ((pmc = get_gp_pmc(pmu, msr, MSR_IA32_PERFCTR0))) {
> +		if ((pmc = get_gp_pmc(pmu, msr, MSR_IA32_PERFCTR0)) ||
> +			(pmc = get_gp_pmc(pmu, msr, MSR_IA32_PMC0))) {
>  			u64 val = pmc_read_counter(pmc);
>  			*data = val & pmu->counter_bitmask[KVM_PMC_GP];
>  			return 0;
> @@ -258,9 +277,21 @@ static int intel_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  			return 0;
>  		}
>  		break;
> +	case MSR_IA32_PERF_CAPABILITIES:
> +		if (msr_info->host_initiated &&
> +			!(data & ~vmx_get_perf_capabilities())) {

Likewise:

		if (!msr->info->host_initiated)
			return 1;
		if (guest_cpuid_has(vcpu, X86_FEATURE_PDCM))
		    ? data & ~vmx_get_perf_capabilities()
		    : data)
			return 1;

Otherwise looks good, I'm going to queue this.

Paolo

