Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 811D8C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 20:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 656522067B
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 20:27:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729723AbgFDU1Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 16:27:24 -0400
Received: from v6.sk ([167.172.42.174]:46350 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725883AbgFDU1Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 16:27:24 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id 0E4BC610D0;
        Thu,  4 Jun 2020 20:26:52 +0000 (UTC)
Date:   Thu, 4 Jun 2020 22:26:48 +0200
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [RESEND 2 PATCH] media: marvell-ccic: Add support for runtime PM
Message-ID: <20200604202648.GA565781@furthur.local>
References: <20200601192124.172650-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200601192124.172650-1-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc += Sakari. I'm wondering if you'd mind looking at this mmp ccic patch
too.

Thank you
Lubo

On Mon, Jun 01, 2020 at 09:21:24PM +0200, Lubomir Rintel wrote:
> On MMP3, the camera block lives on na separate power island. We want to
> turn it off if the CCIC is not in use to conserve power.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---
>  drivers/media/platform/marvell-ccic/mcam-core.c  |  3 +++
>  drivers/media/platform/marvell-ccic/mmp-driver.c | 12 ++++++++----
>  2 files changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/media/platform/marvell-ccic/mcam-core.c b/drivers/media/platform/marvell-ccic/mcam-core.c
> index 09775b6624c6b..c2cd1d461bd06 100644
> --- a/drivers/media/platform/marvell-ccic/mcam-core.c
> +++ b/drivers/media/platform/marvell-ccic/mcam-core.c
> @@ -24,6 +24,7 @@
>  #include <linux/clk.h>
>  #include <linux/clk-provider.h>
>  #include <linux/videodev2.h>
> +#include <linux/pm_runtime.h>
>  #include <media/v4l2-device.h>
>  #include <media/v4l2-ioctl.h>
>  #include <media/v4l2-ctrls.h>
> @@ -901,6 +902,7 @@ static void mcam_clk_enable(struct mcam_camera *mcam)
>  {
>  	unsigned int i;
>  
> +	pm_runtime_get_sync(mcam->dev);
>  	for (i = 0; i < NR_MCAM_CLK; i++) {
>  		if (!IS_ERR(mcam->clk[i]))
>  			clk_prepare_enable(mcam->clk[i]);
> @@ -915,6 +917,7 @@ static void mcam_clk_disable(struct mcam_camera *mcam)
>  		if (!IS_ERR(mcam->clk[i]))
>  			clk_disable_unprepare(mcam->clk[i]);
>  	}
> +	pm_runtime_put(mcam->dev);
>  }
>  
>  /* ---------------------------------------------------------------------- */
> diff --git a/drivers/media/platform/marvell-ccic/mmp-driver.c b/drivers/media/platform/marvell-ccic/mmp-driver.c
> index 92b92255dac66..eec482d16805b 100644
> --- a/drivers/media/platform/marvell-ccic/mmp-driver.c
> +++ b/drivers/media/platform/marvell-ccic/mmp-driver.c
> @@ -24,6 +24,7 @@
>  #include <linux/list.h>
>  #include <linux/pm.h>
>  #include <linux/clk.h>
> +#include <linux/pm_runtime.h>
>  
>  #include "mcam-core.h"
>  
> @@ -313,10 +314,12 @@ static int mmpcam_probe(struct platform_device *pdev)
>  	cam->irq = res->start;
>  	ret = devm_request_irq(&pdev->dev, cam->irq, mmpcam_irq, IRQF_SHARED,
>  					"mmp-camera", mcam);
> -	if (ret == 0) {
> -		mmpcam_add_device(cam);
> -		return 0;
> -	}
> +	if (ret)
> +		goto out;
> +
> +	mmpcam_add_device(cam);
> +	pm_runtime_enable(&pdev->dev);
> +	return 0;
>  
>  out:
>  	fwnode_handle_put(mcam->asd.match.fwnode);
> @@ -332,6 +335,7 @@ static int mmpcam_remove(struct mmp_camera *cam)
>  
>  	mmpcam_remove_device(cam);
>  	mccic_shutdown(mcam);
> +	pm_runtime_force_suspend(mcam->dev);
>  	return 0;
>  }
>  
> -- 
> 2.26.2
> 
