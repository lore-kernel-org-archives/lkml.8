Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FAKE_REPLY_C,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8022AC433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 18:04:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EFD7208B8
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 18:04:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tU9QNdGO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730247AbgFHSEY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 14:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729979AbgFHSEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 14:04:24 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A09D1C08C5C2;
        Mon,  8 Jun 2020 11:04:23 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id a127so8857720pfa.12;
        Mon, 08 Jun 2020 11:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=vy3WmLcTN1C9TwpCZlVK/k2jmSpqqmElcRpgtxdIswQ=;
        b=tU9QNdGOX7EhRI4izEZnPMk+dIet667Sn1H49wXjBsahqedcLrR2Ed9Was0NtItz+Q
         OhHZ1HOon0qszB+DS3pVonGWlCDyobR3+iECtEpUJk5ZatPVX3iGI8Mki8CjkwmfHODf
         xYqDGnmJrEAqKjbOY/ADn1YcTT5qZAwrm/JBiY8Z8jZ0MTBM6FaCvdfh/vdoZwAUDLjY
         aBN46WtCVW27QpkV0HgeQThk37WSKoWsxNBKUdWj2kSt4rVH12iVTChoCpoUDLuKAnix
         m+yUngrG8K4fHjLs+MPCa+EbDd/tvEwMHpFCAVHAtQ6mCMDVD5V5KCmkE7Es4E/tk2Tc
         353Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=vy3WmLcTN1C9TwpCZlVK/k2jmSpqqmElcRpgtxdIswQ=;
        b=ZTPHlXiY7bnWin53cH+PyIFi9O5P+jzyLnW0o4m/08BS/F/4CKeNIveyuFl5UQK26y
         32QDqCss6nHiyAkSmC5eZP4stagLhmW/cNrfQdQJyKDe4D3FnUMm+2JL97wEslEZiQXU
         D7+UBe+7hXwL+AowPRAWuEENKFsNP6YntYLIQ0dJV0cXGuKSR7kQRQZ9ZaZN6MZQACFj
         0W89Aipf0N9yz9ywiSrmMCDTTofUPrEzMGIDgn3rW5lMQ5bn17Mp/hjteq76DA+xEZxE
         Yd4gJmaNmbGw4v7Vo9YDjuIcUzB+O6MZLE/5k4IptniAe1A/wB9cu3z5SxPHYNz/7Ibb
         HiZw==
X-Gm-Message-State: AOAM531YyRSNTv+seNb7p5DKs94d2jrurBxxZmgSUUUBNFkGVu+jh0LO
        OnkHrfHyIIhDigAf8cnIFb0=
X-Google-Smtp-Source: ABdhPJwSZFtCX0X/ChGUh2y2uaj7qYI5ZishucIyaSmU2a8St4wozy1oqywQxQ/Wmi+91DEp4j/RsA==
X-Received: by 2002:a62:a510:: with SMTP id v16mr4640795pfm.154.1591639463137;
        Mon, 08 Jun 2020 11:04:23 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a27sm6615481pgn.62.2020.06.08.11.04.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Jun 2020 11:04:22 -0700 (PDT)
Date:   Mon, 8 Jun 2020 11:04:21 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Borislav Petkov <bp@alien8.de>
Cc:     X86 ML <x86@kernel.org>, Huang Rui <ray.huang@amd.com>,
        linux-hwmon@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/msr: Lift AMD family 0x15 power-specific MSRs
Message-ID: <20200608180421.GA32167@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 08, 2020 at 06:48:47PM +0200, Borislav Petkov wrote:
> From: Borislav Petkov <bp@suse.de>
> 
> ... into the global msr-index.h header because they're used in multiple
> compilation units. Sort the MSR list a bit. Update the msr-index.h copy
> in tools.
> 
> No functional changes.
> 
> Signed-off-by: Borislav Petkov <bp@suse.de>

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  arch/x86/events/amd/power.c            | 4 ----
>  arch/x86/include/asm/msr-index.h       | 5 ++++-
>  drivers/hwmon/fam15h_power.c           | 4 ----
>  tools/arch/x86/include/asm/msr-index.h | 5 ++++-
>  4 files changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/x86/events/amd/power.c b/arch/x86/events/amd/power.c
> index 43b09e9c93a2..16a2369c586e 100644
> --- a/arch/x86/events/amd/power.c
> +++ b/arch/x86/events/amd/power.c
> @@ -13,10 +13,6 @@
>  #include <asm/cpu_device_id.h>
>  #include "../perf_event.h"
>  
> -#define MSR_F15H_CU_PWR_ACCUMULATOR     0xc001007a
> -#define MSR_F15H_CU_MAX_PWR_ACCUMULATOR 0xc001007b
> -#define MSR_F15H_PTSC			0xc0010280
> -
>  /* Event code: LSB 8 bits, passed in attr->config any other bit is reserved. */
>  #define AMD_POWER_EVENT_MASK		0xFFULL
>  
> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
> index ef452b817f44..7dfd45bb6cdb 100644
> --- a/arch/x86/include/asm/msr-index.h
> +++ b/arch/x86/include/asm/msr-index.h
> @@ -414,15 +414,18 @@
>  #define MSR_AMD64_PATCH_LEVEL		0x0000008b
>  #define MSR_AMD64_TSC_RATIO		0xc0000104
>  #define MSR_AMD64_NB_CFG		0xc001001f
> -#define MSR_AMD64_CPUID_FN_1		0xc0011004
>  #define MSR_AMD64_PATCH_LOADER		0xc0010020
>  #define MSR_AMD_PERF_CTL		0xc0010062
>  #define MSR_AMD_PERF_STATUS		0xc0010063
>  #define MSR_AMD_PSTATE_DEF_BASE		0xc0010064
> +#define MSR_F15H_CU_PWR_ACCUMULATOR     0xc001007a
> +#define MSR_F15H_CU_MAX_PWR_ACCUMULATOR 0xc001007b
>  #define MSR_AMD64_OSVW_ID_LENGTH	0xc0010140
>  #define MSR_AMD64_OSVW_STATUS		0xc0010141
> +#define MSR_F15H_PTSC			0xc0010280
>  #define MSR_AMD_PPIN_CTL		0xc00102f0
>  #define MSR_AMD_PPIN			0xc00102f1
> +#define MSR_AMD64_CPUID_FN_1		0xc0011004
>  #define MSR_AMD64_LS_CFG		0xc0011020
>  #define MSR_AMD64_DC_CFG		0xc0011022
>  #define MSR_AMD64_BU_CFG2		0xc001102a
> diff --git a/drivers/hwmon/fam15h_power.c b/drivers/hwmon/fam15h_power.c
> index 267eac00a3fb..29f5fed28c2a 100644
> --- a/drivers/hwmon/fam15h_power.c
> +++ b/drivers/hwmon/fam15h_power.c
> @@ -41,10 +41,6 @@ MODULE_LICENSE("GPL");
>  /* set maximum interval as 1 second */
>  #define MAX_INTERVAL			1000
>  
> -#define MSR_F15H_CU_PWR_ACCUMULATOR	0xc001007a
> -#define MSR_F15H_CU_MAX_PWR_ACCUMULATOR	0xc001007b
> -#define MSR_F15H_PTSC			0xc0010280
> -
>  #define PCI_DEVICE_ID_AMD_15H_M70H_NB_F4 0x15b4
>  
>  struct fam15h_power_data {
> diff --git a/tools/arch/x86/include/asm/msr-index.h b/tools/arch/x86/include/asm/msr-index.h
> index ef452b817f44..7dfd45bb6cdb 100644
> --- a/tools/arch/x86/include/asm/msr-index.h
> +++ b/tools/arch/x86/include/asm/msr-index.h
> @@ -414,15 +414,18 @@
>  #define MSR_AMD64_PATCH_LEVEL		0x0000008b
>  #define MSR_AMD64_TSC_RATIO		0xc0000104
>  #define MSR_AMD64_NB_CFG		0xc001001f
> -#define MSR_AMD64_CPUID_FN_1		0xc0011004
>  #define MSR_AMD64_PATCH_LOADER		0xc0010020
>  #define MSR_AMD_PERF_CTL		0xc0010062
>  #define MSR_AMD_PERF_STATUS		0xc0010063
>  #define MSR_AMD_PSTATE_DEF_BASE		0xc0010064
> +#define MSR_F15H_CU_PWR_ACCUMULATOR     0xc001007a
> +#define MSR_F15H_CU_MAX_PWR_ACCUMULATOR 0xc001007b
>  #define MSR_AMD64_OSVW_ID_LENGTH	0xc0010140
>  #define MSR_AMD64_OSVW_STATUS		0xc0010141
> +#define MSR_F15H_PTSC			0xc0010280
>  #define MSR_AMD_PPIN_CTL		0xc00102f0
>  #define MSR_AMD_PPIN			0xc00102f1
> +#define MSR_AMD64_CPUID_FN_1		0xc0011004
>  #define MSR_AMD64_LS_CFG		0xc0011020
>  #define MSR_AMD64_DC_CFG		0xc0011022
>  #define MSR_AMD64_BU_CFG2		0xc001102a
> -- 
> 2.21.0
> 
