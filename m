Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2F61C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 16:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E9A620709
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 16:23:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fBA1I2vD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbgETQXc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 12:23:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58925 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726439AbgETQXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 12:23:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589991810;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NoVochZcFS3v4/Dvw5anGBO9w8j/2/n96KgXu49AdWA=;
        b=fBA1I2vDSI++blRuLzWQ6n1KmOJxsuvpokd4J1OHsAwcZIOlMAQDwmdltJTBFnx+4ywKiC
        WImAdbkZF1DAW6W1vMCmKVuG43r9pQdOuvrXUFAFUomtdIVR0n3gs8i98J9f9PHofZUieJ
        xSW6vcyL5mJGW6qjZq+agNOy2MOhGtg=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-215-RoFfOyw0P-emptd0IEJ3Ug-1; Wed, 20 May 2020 12:23:29 -0400
X-MC-Unique: RoFfOyw0P-emptd0IEJ3Ug-1
Received: by mail-ed1-f70.google.com with SMTP id a14so1475302edx.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 09:23:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=NoVochZcFS3v4/Dvw5anGBO9w8j/2/n96KgXu49AdWA=;
        b=gpaCU6046wnTV3KA2K8Ysbjj4hfyut8gPVmxjmvsBCEVF5lNjOmovMcI8OW208DxtY
         p5O4+Gme0lKMfQzj7WPgcBF89PuNpjbUy4PXEXsbtVUzZZIF94suMaNgdbmYk+7t2/9m
         V82tj+ZlIkH/3aO8p/60PcK7ulJdf0I/mESiPbFsO4Y/E3TCBSpsFMiyhLb6hZ8rXRI/
         dXyWII/FcOngFQhQDbY1tNdvfLEhoExJLX3q81QTghIo2IdgWS+yp48NPIvZDYYMX1fZ
         oYWEkuB0DJdPqxYwmVsYMN0+bRCc6v0UWa9DG/dj/TEw0ALWAj8wipMra8iznYumhBkf
         ZpDQ==
X-Gm-Message-State: AOAM531R2uaM/qBWek56XuyOmRLBknkLw12+AZE5dNMdCoy/rYloXGs3
        ezhppGuopmH8axcUPaBf5Hpa/XFV1MvHTXePci8MjSJklVhVhLqf1Eh+tX/MFtIQS/ElcNfVtNX
        8ludyMoR2sURVPYhstdJauVTJ
X-Received: by 2002:a17:906:415b:: with SMTP id l27mr4584383ejk.240.1589991807365;
        Wed, 20 May 2020 09:23:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy6D8uFHurXAxp3TFzy/tn3+V3RRSaJtWT2otMOBsMiXStjME+hqZObXrQKm8bEIzEbD/QnGQ==
X-Received: by 2002:a17:906:415b:: with SMTP id l27mr4584369ejk.240.1589991807185;
        Wed, 20 May 2020 09:23:27 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id s1sm2369800ejh.81.2020.05.20.09.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 09:23:26 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [PATCH 1/2] kvm: cosmetic: remove wrong braces in kvm_init_msr_list switch
In-Reply-To: <20200520160740.6144-2-mlevitsk@redhat.com>
References: <20200520160740.6144-1-mlevitsk@redhat.com> <20200520160740.6144-2-mlevitsk@redhat.com>
Date:   Wed, 20 May 2020 18:23:25 +0200
Message-ID: <877dx6tw1u.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maxim Levitsky <mlevitsk@redhat.com> writes:

> I think these were added accidentally.
>
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  arch/x86/kvm/x86.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 471fccf7f8501..fe3a24fd6b263 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -5299,7 +5299,7 @@ static void kvm_init_msr_list(void)
>  				 !intel_pt_validate_hw_cap(PT_CAP_single_range_output)))
>  				continue;
>  			break;
> -		case MSR_IA32_RTIT_ADDR0_A ... MSR_IA32_RTIT_ADDR3_B: {
> +		case MSR_IA32_RTIT_ADDR0_A ... MSR_IA32_RTIT_ADDR3_B:
>  			if (!kvm_cpu_cap_has(X86_FEATURE_INTEL_PT) ||
>  				msrs_to_save_all[i] - MSR_IA32_RTIT_ADDR0_A >=
>  				intel_pt_validate_hw_cap(PT_CAP_num_address_ranges) * 2)
> @@ -5314,7 +5314,6 @@ static void kvm_init_msr_list(void)
>  			if (msrs_to_save_all[i] - MSR_ARCH_PERFMON_EVENTSEL0 >=
>  			    min(INTEL_PMC_MAX_GENERIC, x86_pmu.num_counters_gp))
>  				continue;
> -		}
>  		default:
>  			break;
>  		}

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

