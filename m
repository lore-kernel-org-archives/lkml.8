Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE5DC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 16:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BCE320771
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 16:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597250404;
	bh=tKEbUyJPjyerKiH4SY07mPFHoaydzR9owIqx719VQ6o=;
	h=Date:From:List-Id:To:Subject:References:In-Reply-To:List-ID:From;
	b=ZUyXD2vyBE2lpGmGqOy8oQqw053MbLXff/Y+xODMoxXFZSDyvAJNOEsPlcpXR8+Ie
	 oEDitLBQL4KSXx17a9fU+E9HpsLzQJrjVw52ahDYdTlApbKnuDNRoI5UWcYahe+oO4
	 gj9jdqKWfnycRbVnUdPAY7qUH1CVHI4vHMBMqjwQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgHLQkD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 12:40:03 -0400
Received: from mail-ej1-f67.google.com ([209.85.218.67]:38801 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbgHLQkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 12:40:01 -0400
Received: by mail-ej1-f67.google.com with SMTP id d6so2982530ejr.5;
        Wed, 12 Aug 2020 09:40:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kqb+z+n2O8TgGdU2lWAIFhyS4madYGtJhunwQOIFMyY=;
        b=Wc51kWBh6XYfhiOJYJlntX0Tk1WqB61Rtm1dt/NJVJu+Z95hElvEwrXSklUgED8bd5
         yAcwYbUwfrzjsojpL6dc0vypn/2ODMvp//8Os4wXC/6t0Lz415jslQ/f3QojRy7YQ+vp
         t04Ncj/xjrKIfVlNzyN0rZX7ZXcCfecvsIP5xroIaPkBkKw/EOSzzH/XL1vzlpixGJ9q
         RIf76AcK2qPQPhinJfTAZjIBwQd3M9Ur1me12JI6juOUuag3yTnrEPLZl+RnjVr2l0EE
         VNkFj0RfsWmro/mQ91oBoyHoHhG4Nn0KwnvymWv18Sb2HRT4mVMdfOnmoiggJp2nfU/S
         XLcg==
X-Gm-Message-State: AOAM533FuaSYCEo2Gi+PAK6+AnwnQirM/zMzyhHH/8TtIXyCRPEFHAUC
        53R0bDuEabSBUeEmF3l9P5I=
X-Google-Smtp-Source: ABdhPJwdDcW+PWhhWe9wnBA/x6C3X1Y8Io+HJJcvcomMj8IZ5Nyk+XHJJfij1ezdNPM2WOnkSJkA2w==
X-Received: by 2002:a17:906:1f88:: with SMTP id t8mr616839ejr.241.1597250399466;
        Wed, 12 Aug 2020 09:39:59 -0700 (PDT)
Received: from kozik-lap ([194.230.155.117])
        by smtp.googlemail.com with ESMTPSA id f23sm1875212ejd.30.2020.08.12.09.39.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Aug 2020 09:39:58 -0700 (PDT)
Date:   Wed, 12 Aug 2020 18:39:56 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
List-Id: <soc.lore.kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Li Yang <leoyang.li@nxp.com>, Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Olof Johansson <olof@lixom.net>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        arm@kernel.org, soc@kernel.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH 2/2] arm64: defconfig: Enable ptn5150 extcon driver
Message-ID: <20200812163956.GA6644@kozik-lap>
References: <20200812163342.6547-1-krzk@kernel.org>
 <20200812163342.6547-2-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200812163342.6547-2-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 12, 2020 at 06:33:42PM +0200, Krzysztof Kozlowski wrote:
> Enable the extcon driver for NXP PTN5150A chips (CC logic for USB Type-C
> applications) present on some of i.MX8 evaluation boards (e.g. Variscite
> Symphony board).
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 2b02a5a179d7..e2346ad6ba90 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -926,6 +926,7 @@ CONFIG_ARCH_TEGRA_194_SOC=y
>  CONFIG_ARCH_K3_AM6_SOC=y
>  CONFIG_ARCH_K3_J721E_SOC=y
>  CONFIG_TI_SCI_PM_DOMAINS=y
> +CONFIG_EXTCON_PTN5150=y

Ah, this should be a module. Works as =m as well, so either this could
be fixed while applying or I can send a v2.

Best regards,
Krzysztof


>  CONFIG_EXTCON_USB_GPIO=y
>  CONFIG_EXTCON_USBC_CROS_EC=y
>  CONFIG_IIO=y
> -- 
> 2.17.1
> 
