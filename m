Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DDE9C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 21:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39E0020671
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 21:05:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FrjZ1FqC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728250AbgETVFZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 17:05:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53121 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727115AbgETVFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 17:05:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590008722;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aLCT0TpScS+rOAwWMzjEcVXtzZd0pBk5KPLl7C2BIRA=;
        b=FrjZ1FqC+kbKq0Tm8frT4hpHORpm94cquKtKxSFA8NVLQUnn1MFSKBQJbGe/twl4iINSNi
        nGap65MtMPrDXsLNeazYbEnvx0qbILj5AHkko2jqHpkQHd87OHky06cuB9z5es2hMjOvc9
        tUjZNgIYlmc9HtqgNtPUwRbJo8a3Pyk=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-yD52mXhDNi-jTNyEjWrx3A-1; Wed, 20 May 2020 17:05:20 -0400
X-MC-Unique: yD52mXhDNi-jTNyEjWrx3A-1
Received: by mail-ej1-f70.google.com with SMTP id s7so1889037eji.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 14:05:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aLCT0TpScS+rOAwWMzjEcVXtzZd0pBk5KPLl7C2BIRA=;
        b=ZPKBqTC3Rpmynm8234+9Fh1LwnwC0rc/8Z+jkEFAcggKfR6hrbHVBPEKI9F6Ee9Bca
         J2uXXt3TfkKFIMRuF6mIse7pLiDfFHohm6eKUzQCNf7e5RodsoM9iHSthAio2Y/6Qswi
         OPhpf7yUBRBCXaNTgheM2UDcRdDyxTvz4i5PihGdiM2fO+/yqCz7pcvjOipJOfEInRCY
         9yu7KNo4Wt+29GBvKCy+B6x6bkW6KIP1AFMt3klMc7ovdt2R2BqYJm7nL6OU6TbhMK9R
         ld4ab2YaeHNkuxOtgNZlRYbDhYFmzfrbEOsMZTlrF3fZMjGsChxIh2zMmdw9+w8YPM1G
         VOaQ==
X-Gm-Message-State: AOAM533iocr2pqUQ5rTHUGiHlmIaewLynx+46oAFtNKaCQP6XGd6tSpK
        5hW//kfBw1424EkfwYqUcigvHJwKf+1BpIU7rNU1NXLCWHxhRbNmkSIVNNL34hMfrTlQ/uPsqa3
        cna3+QUTGjM6pgOq7pv8ZCZjO
X-Received: by 2002:aa7:d706:: with SMTP id t6mr5386525edq.210.1590008718998;
        Wed, 20 May 2020 14:05:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzdj0rEE7VOx55X3WVnq+v7TuIew2T9xwMKBujpNIgUudK+JoGBLTn0XSONUJWDNmsCh2/7Aw==
X-Received: by 2002:aa7:d706:: with SMTP id t6mr5386508edq.210.1590008718704;
        Wed, 20 May 2020 14:05:18 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:1c48:1dd8:fe63:e3da? ([2001:b07:6468:f312:1c48:1dd8:fe63:e3da])
        by smtp.gmail.com with ESMTPSA id dm23sm2518052edb.0.2020.05.20.14.05.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 May 2020 14:05:17 -0700 (PDT)
Subject: Re: [PATCH 2/2] kvm/x86: don't expose MSR_IA32_UMWAIT_CONTROL
 unconditionally
To:     Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20200520160740.6144-1-mlevitsk@redhat.com>
 <20200520160740.6144-3-mlevitsk@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b8ca9ea1-2958-3ab4-2e86-2edbee1ca9d9@redhat.com>
Date:   Wed, 20 May 2020 23:05:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200520160740.6144-3-mlevitsk@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/05/20 18:07, Maxim Levitsky wrote:
> This msr is only available when the host supports WAITPKG feature.
> 
> This breaks a nested guest, if the L1 hypervisor is set to ignore
> unknown msrs, because the only other safety check that the
> kernel does is that it attempts to read the msr and
> rejects it if it gets an exception.
> 
> Fixes: 6e3ba4abce KVM: vmx: Emulate MSR IA32_UMWAIT_CONTROL
> 
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  arch/x86/kvm/x86.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index fe3a24fd6b263..9c507b32b1b77 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -5314,6 +5314,10 @@ static void kvm_init_msr_list(void)
>  			if (msrs_to_save_all[i] - MSR_ARCH_PERFMON_EVENTSEL0 >=
>  			    min(INTEL_PMC_MAX_GENERIC, x86_pmu.num_counters_gp))
>  				continue;
> +			break;
> +		case MSR_IA32_UMWAIT_CONTROL:
> +			if (!kvm_cpu_cap_has(X86_FEATURE_WAITPKG))
> +				continue;
>  		default:
>  			break;
>  		}

The patch is correct, and matches what is done for the other entries of
msrs_to_save_all.  However, while looking at it I noticed that
X86_FEATURE_WAITPKG is actually never added, and that is because it was
also not added to the supported CPUID in commit e69e72faa3a0 ("KVM: x86:
Add support for user wait instructions", 2019-09-24), which was before
the kvm_cpu_cap mechanism was added.

So while at it you should also fix that.  The right way to do that is to
add a

        if (vmx_waitpkg_supported())
                kvm_cpu_cap_check_and_set(X86_FEATURE_WAITPKG);

in vmx_set_cpu_caps.

Thanks,

Paolo

