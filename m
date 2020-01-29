Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B938FC33CB2
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 10:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 851782070E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 10:36:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X+Ds/bEP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbgA2KgN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 05:36:13 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21059 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726142AbgA2KgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 05:36:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580294172;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J2ELfdfmeOLb/CT6GrrCevIO+CxmbSz5WWZ5pC+6QHI=;
        b=X+Ds/bEPpfQgjnDjkVOUaN2gQChyR7rSwXrN72Jk2OOg2+grnbYyltGygpDcVCmnnOcP6l
        Y4WLC8YmOILiBBrYW6WMxxhUCRKaGYjdH/olfdF0aBPtshGd8wUWC2VzJy3IT6wXPFWBzg
        Ol/ocwlF37L6feNDzbFnmADwzbmftNM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318-XbcK9SFLODuNormEbPeVHQ-1; Wed, 29 Jan 2020 05:36:10 -0500
X-MC-Unique: XbcK9SFLODuNormEbPeVHQ-1
Received: by mail-wr1-f72.google.com with SMTP id o6so9792628wrp.8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jan 2020 02:36:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=J2ELfdfmeOLb/CT6GrrCevIO+CxmbSz5WWZ5pC+6QHI=;
        b=XCKXHtssftRnQEUZbwqJ40Af+RB1rXWofLWbx5U/FDy+HaZMmu7VTJB0x6XbYS9ZTk
         7p/HVWQVXAeOL8PDc0/KUAhLYZJvkmL0h/Dzca5VDzXg+7QGjDM8NOY4MeR6ecdN533b
         7cZCl++umBJUgKYqcM8Nr2WJSnuX4j+mS/G3wjXglSeXFK6SwQ/uJ8c8RgB/pdepuDvJ
         JCp7EjC1LvH19JdhIfFCtQ1dUVOe2FQgQZv2u09yIkC5N2OzBzD98dgdV+U3Dy7RRYuw
         3PmZB/TEiczX9fxN8iy0lDxzoyqRTe1ycnhoyERuocdb41EmU+jT8nK6N9FT2JtIdDNU
         yfVQ==
X-Gm-Message-State: APjAAAWJQw97mKrf/n3f83Ojxv4687NQzoJTh2GswbKNnZBrZ/L57VP7
        1Zfxw3Oi9L4/HNy5fZhwtW0z/XKG+BxH8hlkFieq5kqvATn8wbmvKWSZqKHKa8/3Wh3+r5H84DC
        3xZ63LsrYxHBeDWcyaRlbrITS
X-Received: by 2002:adf:e448:: with SMTP id t8mr6809319wrm.224.1580294169569;
        Wed, 29 Jan 2020 02:36:09 -0800 (PST)
X-Google-Smtp-Source: APXvYqwyGUSnZ951MOEhC0vpWncAdy7BLZiUBINFhZRmdX3WwGLbYkpXpkpM5qyjRh4C9RpFDiLfIg==
X-Received: by 2002:adf:e448:: with SMTP id t8mr6809295wrm.224.1580294169324;
        Wed, 29 Jan 2020 02:36:09 -0800 (PST)
Received: from [10.200.153.153] ([213.175.37.12])
        by smtp.gmail.com with ESMTPSA id z19sm1684563wmi.35.2020.01.29.02.36.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jan 2020 02:36:08 -0800 (PST)
Subject: Re: [PATCH] KVM: x86: Fix perfctr WRMSR for running counters
To:     Eric Hankland <ehankland@google.com>,
        Jim Mattson <jmattson@google.com>,
        Peter Shier <pshier@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <20200127212256.194310-1-ehankland@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2a394c6d-c453-6559-bf33-f654af7922bd@redhat.com>
Date:   Wed, 29 Jan 2020 11:36:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200127212256.194310-1-ehankland@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/01/20 22:22, Eric Hankland wrote:
> Correct the logic in intel_pmu_set_msr() for fixed and general purpose
> counters. This was recently changed to set pmc->counter without taking
> in to account the value of pmc_read_counter() which will be incorrect if
> the counter is currently running and non-zero; this changes back to the
> old logic which accounted for the value of currently running counters.
> 
> Signed-off-by: Eric Hankland <ehankland@google.com>
> ---
>  arch/x86/kvm/vmx/pmu_intel.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
> index 34a3a17bb6d7..9bdbe05b599c 100644
> --- a/arch/x86/kvm/vmx/pmu_intel.c
> +++ b/arch/x86/kvm/vmx/pmu_intel.c
> @@ -264,9 +264,10 @@ static int intel_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  				pmc->counter = data;
>  			else
>  				pmc->counter = (s32)data;
> +			pmc->counter += pmc->counter - pmc_read_counter(pmc);

I think this best written as it was before commit 2924b52117:

			if (!msr_info->host_initiated)
				data = (s64)(s32)data;
			pmc->counter += data - pmc_read_counter(pmc);

Do you have a testcase?

Paolo

>  			return 0;
>  		} else if ((pmc = get_fixed_pmc(pmu, msr))) {
> -			pmc->counter = data;
> +			pmc->counter += data - pmc_read_counter(pmc);
>  			return 0;
>  		} else if ((pmc = get_gp_pmc(pmu, msr, MSR_P6_EVNTSEL0))) {
>  			if (data == pmc->eventsel)
> 

