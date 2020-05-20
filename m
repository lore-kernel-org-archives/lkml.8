Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F53BC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 16:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7020320709
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 16:33:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PzmLpPEy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbgETQdr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 12:33:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39576 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726548AbgETQdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 12:33:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589992425;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bAZr9JpGFpcuu3XfWQIxwcbd9+r9VJYRanbh/qrJCdA=;
        b=PzmLpPEy9Ms7KFQ4McaMei57TrQcdmyLdDh7WL5pYwhCVRWBV+hBl3BGg1Wse2voaZcvc3
        ygg0ReAhIOnYLxYvbpAuJyNfcZ+Z+dfAeoBedmkCio3j5ovcY3c5U72zunV6ZdjwtqMab1
        DuXxK2inNKleTV/m4mYAHyUQxd13HBg=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-73-Nf2LA8oPOnKIaQdlIAnrig-1; Wed, 20 May 2020 12:33:43 -0400
X-MC-Unique: Nf2LA8oPOnKIaQdlIAnrig-1
Received: by mail-ej1-f71.google.com with SMTP id t26so1557348ejs.19
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 09:33:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=bAZr9JpGFpcuu3XfWQIxwcbd9+r9VJYRanbh/qrJCdA=;
        b=QtmsB9V0Oe9UO+jxZAtwOwTfOsodhhNbYrt825x7YNjNaoAT3xjX8P8csczTf3uOmP
         a2PbOcay1kkO2pMt+n/O+32Xmg3mUmjRmXYT6bxzQaYNMuZrdQ0JS+fqvdBl1TmPz7V0
         x9tI1bIzcK5P9obZCwU6T1BuuDmsqk+pCOBmFd00a/Qh942f1hvgzvSJsAm6A66NGh3B
         8rP2keSUpSExf8YCA3JqTx+qZoOurWrS13BqNoMPX/ZqBMXpqEH2W4AsPd5obCowYmZP
         rtdkQWn/2X8ELA4TWMCAyeyBEmUyG4oGk1kHnyK+SoPmDskgYXQjHaP3hPKyiyOTogar
         BI5A==
X-Gm-Message-State: AOAM533v87CeViGeVFub5GhXS3LQWGUDpbncyAISYhovAcvyWo9UOiF4
        RQyX+LVDfGGD3r5KvzcxEwxwsCOsFpJPOQi83BAUPxVNLxIHpcau4wxIjJittbyGZ3mhtOBGr4K
        0nHPGlPeFHqWwCNIBpbUFkCk9
X-Received: by 2002:a17:906:6bc5:: with SMTP id t5mr4270295ejs.459.1589992422409;
        Wed, 20 May 2020 09:33:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx7yvH7d/edQcZjZSz0U8YMWI3hpcZy/hW1aUOvFSWb9mTe9xQ9+gEka1tRNCnBYytolrP33w==
X-Received: by 2002:a17:906:6bc5:: with SMTP id t5mr4270277ejs.459.1589992422203;
        Wed, 20 May 2020 09:33:42 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id 13sm2347728ejw.88.2020.05.20.09.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 09:33:41 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [PATCH 2/2] kvm/x86: don't expose MSR_IA32_UMWAIT_CONTROL unconditionally
In-Reply-To: <20200520160740.6144-3-mlevitsk@redhat.com>
References: <20200520160740.6144-1-mlevitsk@redhat.com> <20200520160740.6144-3-mlevitsk@redhat.com>
Date:   Wed, 20 May 2020 18:33:40 +0200
Message-ID: <874ksatvkr.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maxim Levitsky <mlevitsk@redhat.com> writes:

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

I'm probably missing something but (if I understand correctly) the only
effect of dropping MSR_IA32_UMWAIT_CONTROL from msrs_to_save would be
that KVM userspace won't see it in e.g. KVM_GET_MSR_INDEX_LIST. But why
is this causing an issue? I see both vmx_get_msr()/vmx_set_msr() have
'host_initiated' check:

       case MSR_IA32_UMWAIT_CONTROL:
                if (!msr_info->host_initiated && !vmx_has_waitpkg(vmx))
                        return 1;

so KVM userspace should be able to read/write this MSR even when there's
no hardware support for it. Or who's trying to read/write it?

Also, kvm_cpu_cap_has() check is not equal to vmx_has_waitpkg() which
checks secondary execution controls.

>  		default:
>  			break;
>  		}

-- 
Vitaly

