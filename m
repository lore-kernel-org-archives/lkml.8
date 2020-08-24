Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15BE5C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 10:52:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4ADA2071E
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 10:52:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbgHXKv7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 06:51:59 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:56325 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbgHXKv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 06:51:57 -0400
Received: from [2001:67c:670:201:5054:ff:fe8d:eefb] (helo=localhost)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1kAA4y-0007Go-OV; Mon, 24 Aug 2020 12:51:56 +0200
Message-ID: <588560659bdb00a99897eb1685d3b85e82d48164.camel@pengutronix.de>
Subject: Re: [PATCH v2] drm/etnaviv: fix external abort seen on GC600 rev
 0x19
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Christian Gmeiner <christian.gmeiner@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     josua.mayer@jm0.eu, stable@vger.kernel.org,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Date:   Mon, 24 Aug 2020 12:51:15 +0200
In-Reply-To: <20200823190924.6437-1-christian.gmeiner@gmail.com>
References: <20200823190924.6437-1-christian.gmeiner@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, den 23.08.2020, 21:09 +0200 schrieb Christian Gmeiner:
> It looks like that this GPU core triggers an abort when
> reading VIVS_HI_CHIP_PRODUCT_ID and/or VIVS_HI_CHIP_ECO_ID.
> 
> I looked at different versions of Vivante's kernel driver and did
> not found anything about this issue or what feature flag can be
> used. So go the simplest route and do not read these two registers
> on the affected GPU core.
> 
> Signed-off-by: Christian Gmeiner <christian.gmeiner@gmail.com>
> Reported-by: Josua Mayer <josua.mayer@jm0.eu>
> Fixes: 815e45bbd4d3 ("drm/etnaviv: determine product, customer and eco id")
> Cc: stable@vger.kernel.org
> ---
> Changelog:
> 
> V2:
>  - use correct register for conditional reads.

Thanks, I applied this patch to my etnaviv/fixes branch.

Regards,
Lucas

> ---
>  drivers/gpu/drm/etnaviv/etnaviv_gpu.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> index d5a4cd85a0f6..c6404b8d067f 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> @@ -337,9 +337,16 @@ static void etnaviv_hw_identify(struct etnaviv_gpu *gpu)
>  
>  		gpu->identity.model = gpu_read(gpu, VIVS_HI_CHIP_MODEL);
>  		gpu->identity.revision = gpu_read(gpu, VIVS_HI_CHIP_REV);
> -		gpu->identity.product_id = gpu_read(gpu, VIVS_HI_CHIP_PRODUCT_ID);
>  		gpu->identity.customer_id = gpu_read(gpu, VIVS_HI_CHIP_CUSTOMER_ID);
> -		gpu->identity.eco_id = gpu_read(gpu, VIVS_HI_CHIP_ECO_ID);
> +
> +		/*
> +		 * Reading these two registers on GC600 rev 0x19 result in a
> +		 * unhandled fault: external abort on non-linefetch
> +		 */
> +		if (!etnaviv_is_model_rev(gpu, GC600, 0x19)) {
> +			gpu->identity.product_id = gpu_read(gpu, VIVS_HI_CHIP_PRODUCT_ID);
> +			gpu->identity.eco_id = gpu_read(gpu, VIVS_HI_CHIP_ECO_ID);
> +		}
>  
>  		/*
>  		 * !!!! HACK ALERT !!!!

