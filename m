Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0314AC433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 08:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D83F521775
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 08:53:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="OCcsuc3l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbgGTIxN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 04:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbgGTIxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 04:53:12 -0400
Received: from mail.kmu-office.ch (mail.kmu-office.ch [IPv6:2a02:418:6a02::a2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF58EC061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 01:53:12 -0700 (PDT)
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id AD23D5C0103;
        Mon, 20 Jul 2020 10:53:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1595235189;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2psVOuBfQWzNlIeqUe0VNRfz3qCiweMFCB6YaVzx7DQ=;
        b=OCcsuc3lZe9WmOlUEF6jEi7nyes6LSwQy5g5TopNZORtWr0Ep51yf1sE3mU6HqZiwbvyuA
        9JypdNValYZNBHBHP8I2XVqQdnKwMr89UmWEvcqoJzoVj0Exy4JP0r03seyx/B5LHnR1dE
        pTh2v+BbFszjKF4Zv6DUdzrPHr8EW+g=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Mon, 20 Jul 2020 10:53:09 +0200
From:   Stefan Agner <stefan@agner.ch>
To:     Bernard Zhao <bernard@vivo.com>
Cc:     Marek Vasut <marex@denx.de>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        opensource.kernel@vivo.com
Subject: Re: [PATCH] drm/mxsfb: miss err handle in probe
In-Reply-To: <20200611122311.20847-1-bernard@vivo.com>
References: <20200611122311.20847-1-bernard@vivo.com>
User-Agent: Roundcube Webmail/1.4.1
Message-ID: <4d83b3dfcd3efb0c639dacadd5b69619@agner.ch>
X-Sender: stefan@agner.ch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-11 14:23, Bernard Zhao wrote:
> There are three err return values in drm_fbdev_generic_setup.
> In mxsfb_probe we called this function, but didn`t handle the
> return value, this change is to add err handle, maybe make code
> a bit more readable.

This got recently changed, so I guess checking the return value isn't
required anymore:
https://patchwork.freedesktop.org/patch/msgid/20200408082641.590-11-tzimmermann@suse.de

--
Stefan

> 
> Signed-off-by: Bernard Zhao <bernard@vivo.com>
> ---
>  drivers/gpu/drm/mxsfb/mxsfb_drv.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.c
> b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
> index 497cf443a9af..a45f3b85f725 100644
> --- a/drivers/gpu/drm/mxsfb/mxsfb_drv.c
> +++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
> @@ -415,7 +415,9 @@ static int mxsfb_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto err_unload;
>  
> -	drm_fbdev_generic_setup(drm, 32);
> +	ret = drm_fbdev_generic_setup(drm, 32);
> +	if (ret)
> +		goto err_unload;
>  
>  	return 0;
