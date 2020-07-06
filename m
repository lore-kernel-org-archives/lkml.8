Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C4BC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 12:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DF2A20773
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 12:00:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZzQyI7Ze"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729155AbgGFMAc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 08:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729005AbgGFMAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 08:00:30 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA4DBC061794
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 05:00:29 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id q5so40517059wru.6
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 05:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=cuGTDi2NhkVw3mmqGaWPQRxsrhDmvfo7KxDL1eoQp+c=;
        b=ZzQyI7ZeERp6bZfVxZejJdkriojsnlM1v3Oio0hBntvgLEldwhqjSiS+A0AFGAzhml
         62iCXhdLeOagB8vjvNoG28lO8kcxKU3RW7g0ZJjPbzXr+/6wgaaNVsx53pAMSnl4lBti
         A1OwpjGRmzr3XSdJDbTKVq/4GbRE+/6NDBPuxfmCIAutev++aEDpyr+IeMVBklEhrRgc
         RLDbbQRZvdCYp5k9DH8PcaZvlqSD2E9pAcpBqJgNs34VrNV4CHfLBpOi6UPB5VbeQUp4
         FOHHtYqCOXyUYGkjBjRYfHHzLvW4c37guXoilXbPtvRI63zLHPagc21i+Ek7KYESCs+D
         Srpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cuGTDi2NhkVw3mmqGaWPQRxsrhDmvfo7KxDL1eoQp+c=;
        b=iUDcyPcGQy7A+guTp99VgW8ZcLvyWfU5VWBB61Os3UMWAMzyTMrgN/57eZ0AwbIPS5
         OP/aFeLqqK/aDGv5luESThbDS8dXWWE+XCXtauZTf0NVZBsUc1/h4liVsaVfmA9+f8ug
         1EW53DgRen3rYH2obRh2XMDcSdLBJgtxAwMpwuJ7LxtrvDUzeX10fo4TkOZ4AfwpD1TB
         BmibZKhhIPhXmvoq1g0I37rggSITtEcOVkVA3A4O6fkOx+Sw8RTQg1U5LdKrJkwF2HUo
         KwvBvgCLqERDM7UhH1Du2LURMQUMS0OY2zuf7oDqHWtzHwv9WejKByjkl9DBCOb6ZAkx
         VcIw==
X-Gm-Message-State: AOAM530yK7PHwgtJ8lmb6W1MUPqV+3ZuxS+yipg+jtyX7VqAV5ApeFO5
        O5ZYT3XDPR3icA8WchaUR8DdYOXnL71gNw==
X-Google-Smtp-Source: ABdhPJye5mNmYc/Xk87Zjv6Iz6E1298+yQTS+rVt9MMEVFNGMU19UsqCm5hBWp2ldw0bh4OKXfm/9A==
X-Received: by 2002:adf:82e1:: with SMTP id 88mr28227012wrc.376.1594036828116;
        Mon, 06 Jul 2020 05:00:28 -0700 (PDT)
Received: from [192.168.1.20] ([195.245.18.232])
        by smtp.gmail.com with ESMTPSA id f197sm6943695wme.33.2020.07.06.05.00.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2020 05:00:27 -0700 (PDT)
Subject: Re: [PATCH] Replace HTTP links with HTTPS ones: EP93XX
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        hsweeten@visionengravers.com, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20200706062749.18552-1-grandmaster@al2klimov.de>
From:   Alexander Sverdlin <alexander.sverdlin@gmail.com>
Message-ID: <854a28f6-29f3-6087-0e19-b1be21a67ef5@gmail.com>
Date:   Mon, 6 Jul 2020 13:57:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20200706062749.18552-1-grandmaster@al2klimov.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Alexander,

On 06/07/2020 08:27, Alexander A. Klimov wrote:
> Rationale:
> Reduces attack surface on kernel devs opening the links for MITM
> as HTTPS traffic is much harder to manipulate.
> 
> Deterministic algorithm:
> For each file:
>   If not .svg:
>     For each line:
>       If doesn't contain `\bxmlns\b`:
>         For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
>           If both the HTTP and HTTPS versions
>           return 200 OK and serve the same content:
>             Replace HTTP with HTTPS.
> 
> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>

Acked-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>

> ---
>  Continuing my work started at 93431e0607e5.
> 
>  If there are any URLs to be removed completely or at least not HTTPSified:
>  Just clearly say so and I'll *undo my change*.
>  See also https://lkml.org/lkml/2020/6/27/64
> 
>  If there are any valid, but yet not changed URLs:
>  See https://lkml.org/lkml/2020/6/26/837
> 
>  arch/arm/mach-ep93xx/clock.c | 2 +-
>  arch/arm/mach-ep93xx/soc.h   | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-ep93xx/clock.c b/arch/arm/mach-ep93xx/clock.c
> index 2810eb5b2aca..48efefbb54f8 100644
> --- a/arch/arm/mach-ep93xx/clock.c
> +++ b/arch/arm/mach-ep93xx/clock.c
> @@ -571,7 +571,7 @@ static int __init ep93xx_clock_init(void)
>  	/*
>  	 * EP93xx SSP clock rate was doubled in version E2. For more information
>  	 * see:
> -	 *     http://www.cirrus.com/en/pubs/appNote/AN273REV4.pdf
> +	 *     https://www.cirrus.com/en/pubs/appNote/AN273REV4.pdf
>  	 */
>  	if (ep93xx_chip_revision() < EP93XX_CHIP_REV_E2)
>  		clk_spi.rate /= 2;
> diff --git a/arch/arm/mach-ep93xx/soc.h b/arch/arm/mach-ep93xx/soc.h
> index f2dace1c9154..9e4a3b245434 100644
> --- a/arch/arm/mach-ep93xx/soc.h
> +++ b/arch/arm/mach-ep93xx/soc.h
> @@ -28,7 +28,7 @@
>   * Configurations.  Please refer to "AN273: EP93xx Silicon Rev E Design
>   * Guidelines" for more information.  This document can be found at:
>   *
> - *	http://www.cirrus.com/en/pubs/appNote/AN273REV4.pdf
> + *	https://www.cirrus.com/en/pubs/appNote/AN273REV4.pdf
>   */
>  
>  #define EP93XX_CS0_PHYS_BASE_ASYNC	0x00000000	/* ASDO Pin = 0 */
