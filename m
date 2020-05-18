Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B76B4C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A29BB20715
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:12:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733041AbgERSMj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 14:12:39 -0400
Received: from smtprelay0108.hostedemail.com ([216.40.44.108]:50162 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732632AbgERSDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 14:03:17 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id BA469837F24C;
        Mon, 18 May 2020 18:03:15 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: help47_9096ad8ae3547
X-Filterd-Recvd-Size: 2150
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Mon, 18 May 2020 18:03:13 +0000 (UTC)
Message-ID: <8007a07f354b9f5ff714914f3696e185078c27c3.camel@perches.com>
Subject: Re: [PATCH] drm/exynos: Remove dev_err() on platform_get_irq()
 failure
From:   Joe Perches <joe@perches.com>
To:     Tamseel Shams <m.shams@samsung.com>, inki.dae@samsung.com,
        jy0922.shim@samsung.com, sw0312.kim@samsung.com,
        kyungmin.park@samsung.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        shaik.ameer@samsung.com, krzk@kernel.org, alim.akhtar@samsung.com
Date:   Mon, 18 May 2020 11:03:12 -0700
In-Reply-To: <20200518172708.48600-1-m.shams@samsung.com>
References: <CGME20200518174120epcas5p1fb5f832c7874a9d367eb9c9ea4e69d53@epcas5p1.samsung.com>
         <20200518172708.48600-1-m.shams@samsung.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-05-18 at 22:57 +0530, Tamseel Shams wrote:
> platform_get_irq() will call dev_err() itself on failure,
> so there is no need for the driver to also do this.
> This is detected by coccinelle.

trivia:

> diff --git a/drivers/gpu/drm/exynos/exynos_drm_dsi.c b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
[]
> @@ -1810,7 +1810,6 @@ static int exynos_dsi_probe(struct platform_device *pdev)
>  
>  	dsi->irq = platform_get_irq(pdev, 0);
>  	if (dsi->irq < 0) {
> -		dev_err(dev, "failed to request dsi irq resource\n");
>  		return dsi->irq;
>  	}

You could also remove the now atypical braces

	if (dsi->irq < 0)
		return dsi->irq;

> diff --git a/drivers/gpu/drm/exynos/exynos_drm_rotator.c b/drivers/gpu/drm/exynos/exynos_drm_rotator.c
[]
> @@ -294,7 +294,6 @@ static int rotator_probe(struct platform_device *pdev)
>  
>  	irq = platform_get_irq(pdev, 0);
>  	if (irq < 0) {
> -		dev_err(dev, "failed to get irq\n");
>  		return irq;
>  	}

etc...


