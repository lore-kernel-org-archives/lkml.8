Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E44CC47247
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 19:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28C55206B8
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 19:56:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="U2ubukdf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbgEDT4t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 15:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726111AbgEDT4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 15:56:49 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D8DAC061A0E;
        Mon,  4 May 2020 12:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=fRTAxMt+wwPpjAy5FUGbHC1yS2mrXc5N6zswIhz2qFU=; b=U2ubukdfAiDbK2ZjfknkSdIZZj
        AjopC+jkvMrXQ9FVjXXnq53WZIm9n3N/S2YQJnm/RKG/G+EQXXmsgzYD8d/VGzsFRGW6pbOTUSkis
        r5/Y2LaI40jPhkDuA357fVfgK3JufLYz/3iKIUWzdpi4apH2qJXL1DazqpydEoq1ixm2HuCjWAcAx
        /o+oh/BUZjVvqQgv0o6VmJggTTbI/eCgxIJ0OJZ592aAU5rNH3lcnY1bFd+JYoRIHEi5MpwxdtC1D
        N3crodKkBqcxylqmYqSVgaBvnUIxJqQnh7XoF4NWM2ikctoH4dUqcptCDvUTtK/FY0aIdAXirGDRy
        +MGsWUGQ==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jVhCm-0007RJ-5H; Mon, 04 May 2020 19:56:44 +0000
Subject: Re: [v2 PATCH 1/2] drivers: drm: panel: Add ASUS TM5P5 NT35596 panel
 driver
To:     Konrad Dybcio <konradybcio@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200504193816.126299-1-konradybcio@gmail.com>
 <20200504193816.126299-2-konradybcio@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <a9a381eb-6d85-5c6e-f377-0b9815bd36a5@infradead.org>
Date:   Mon, 4 May 2020 12:56:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200504193816.126299-2-konradybcio@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/4/20 12:38 PM, Konrad Dybcio wrote:
> diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
> index a1723c1b5fbf8..3aa57a927c4bd 100644
> --- a/drivers/gpu/drm/panel/Kconfig
> +++ b/drivers/gpu/drm/panel/Kconfig
> @@ -18,6 +18,16 @@ config DRM_PANEL_ARM_VERSATILE
>  	  reference designs. The panel is detected using special registers
>  	  in the Versatile family syscon registers.
>  
> +config DRM_PANEL_ASUS_Z00T_TM5P5_NT35596
> +        tristate "ASUS Z00T TM5P5 NT35596 panel"
> +        depends on GPIOLIB && OF
> +        depends on DRM_MIPI_DSI
> +	depends on BACKLIGHT_CLASS_DEVICE
> +        help
> +          Say Y here if you want to enable support for the ASUS TMP5P5
> +          NT35596 1080x1920 video mode panel as found in some Asus
> +          Zenfone 2 Laser Z00T devices.
> +
>  config DRM_PANEL_BOE_HIMAX8279D
>  	tristate "Boe Himax8279d panel"
>  	depends on OF

Hi,

Please clean up the config entry indentation.
The keywords (tristate, depends, help) should all be indented with
one tab (not spaces) and the help text should be indented with
one tab + 2 spaces.

thanks.
-- 
~Randy
