Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0266C35254
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 14:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7132D217BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 14:29:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O1JHN+SK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbgBEO3e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 09:29:34 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60806 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726334AbgBEO3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 09:29:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580912973;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VqJmWuecyrzET8whJwBuHfcZJEAlaI0Vpv3y64xtnOY=;
        b=O1JHN+SKGVs2MkMMicXFeRJrDEK9EYCjTWvWa6y6xv80mQtnTnPYg/btBIOoRtBlrViOJI
        77I3ao7c8A+eYfDW6KbH7N1T8jPmIhxggj7NEBYHAW6j9QaV49MJgeK91hg81ERLmB0sqt
        YwWhDLwv4RzEOG6gx2+L5jOp+WwINU4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-143-ELrx5SOxNYKogc6XpFm95Q-1; Wed, 05 Feb 2020 09:29:31 -0500
X-MC-Unique: ELrx5SOxNYKogc6XpFm95Q-1
Received: by mail-wr1-f69.google.com with SMTP id p8so1274735wrw.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 06:29:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=VqJmWuecyrzET8whJwBuHfcZJEAlaI0Vpv3y64xtnOY=;
        b=W3BCnvRE7xwy+pyg9PUBiRGuk8ca1yQ7uRnloCSWVDcuPwKg+3ugeUJVj/JrsP4YgX
         P/eR6qtC2Fgqkwtt3Bzbq7pFnQqqYNmCprl8zfgK4ECfAltMQ6J4dsawUAPb3XA4f6f6
         ywpO+4No9sqdWcVj6cJh1DPqpD2Zkcmnl+PuXfYFjmDr17g+DJixOopwWxCwL3z5XbSY
         ZDd1+m9wKB10VenN+ByxUE7FD0d8SKwc2YBoePkSZylriJuA4KjX+gvFhkL8xaoSe76g
         yEYbVYO7DYVw76NbonLnE+fK7+E9CgPcrC3smYw3DxWtFingihT1nkkb+9jaAF061Spk
         1TJg==
X-Gm-Message-State: APjAAAW9BcM3kouhc668tA6jOIObva5zhTJkqYZ3h9lg95p7xjTxrE5A
        deQPACuQ3oX1L/MoO4G66Rf3fnxCEdPI97TbFByFNtQM5YF0im1Ww71UcuZ5VEjjZfbls6wmrIE
        4PYClpPf/qFFLNGq5SAM4KgGk
X-Received: by 2002:a05:600c:214f:: with SMTP id v15mr6250051wml.110.1580912970305;
        Wed, 05 Feb 2020 06:29:30 -0800 (PST)
X-Google-Smtp-Source: APXvYqzkAdCD6Hpk/WS1zobus6iOZcw6x/75ou93FWiX8AkkLRXKfhDj79MljiGfxCPzfi8BFi5Tqw==
X-Received: by 2002:a05:600c:214f:: with SMTP id v15mr6250029wml.110.1580912970043;
        Wed, 05 Feb 2020 06:29:30 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id v8sm33615wrw.2.2020.02.05.06.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 06:29:29 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 01/26] KVM: x86: Remove superfluous brackets from case statement
In-Reply-To: <20200129234640.8147-2-sean.j.christopherson@intel.com>
References: <20200129234640.8147-1-sean.j.christopherson@intel.com> <20200129234640.8147-2-sean.j.christopherson@intel.com>
Date:   Wed, 05 Feb 2020 15:29:28 +0100
Message-ID: <87mu9xkszb.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> Remove unnecessary brackets from a case statement that unintentionally
> encapsulates unrelated case statements in the same switch statement.
> While technically legal and functionally correct syntax, the brackets
> are visually confusing and potentially dangerous, e.g. the last of the
> encapsulated case statements has an undocumented fall-through that isn't
> flagged by compilers due the encapsulation.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/kvm/x86.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 7e3f1d937224..24597526b5de 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -5260,7 +5260,7 @@ static void kvm_init_msr_list(void)
>  				 !intel_pt_validate_hw_cap(PT_CAP_single_range_output)))
>  				continue;
>  			break;
> -		case MSR_IA32_RTIT_ADDR0_A ... MSR_IA32_RTIT_ADDR3_B: {
> +		case MSR_IA32_RTIT_ADDR0_A ... MSR_IA32_RTIT_ADDR3_B:
>  			if (!kvm_x86_ops->pt_supported() ||
>  				msrs_to_save_all[i] - MSR_IA32_RTIT_ADDR0_A >=
>  				intel_pt_validate_hw_cap(PT_CAP_num_address_ranges) * 2)
> @@ -5275,7 +5275,7 @@ static void kvm_init_msr_list(void)
>  			if (msrs_to_save_all[i] - MSR_ARCH_PERFMON_EVENTSEL0 >=
>  			    min(INTEL_PMC_MAX_GENERIC, x86_pmu.num_counters_gp))
>  				continue;
> -		}
> +			break;
>  		default:
>  			break;
>  		}

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

