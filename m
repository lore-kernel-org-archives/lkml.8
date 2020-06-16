Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B32CC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 02:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D0172071A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 02:07:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="okB8LYmH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbgFPCH6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 22:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbgFPCH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 22:07:57 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF09EC061A0E;
        Mon, 15 Jun 2020 19:07:56 -0700 (PDT)
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id F1E75F9;
        Tue, 16 Jun 2020 04:07:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1592273275;
        bh=xYElGteoaj0H9zLGTP6RnYkFontC7H09EZpYQcLGUtM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=okB8LYmHYqilwBUAYyvrfQ8bW0QAZyYKM6eyUYx/nrm21scB5YMBKSQYZ1vtTbfyG
         3aB2gQ73t4FEa5lDTz9s5RTQ1UDF7/TRujuLWEr0X3HErtSH3HRtE6/WK3lgf1mFXW
         mzAhcKHvXnUVNu8akz1Y2/cdsrgG/Dm+PsjrCjmo=
Date:   Tue, 16 Jun 2020 05:07:32 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     wu000273@umn.edu
Cc:     kjlu@umn.edu,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-media@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: vsp1: Fix a reference count leak.
Message-ID: <20200616020732.GK1629@pendragon.ideasonboard.com>
References: <20200613232357.18155-1-wu000273@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200613232357.18155-1-wu000273@umn.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qiushi,

(CC'ing Rafael and Geert)

Thank you for the patch.

On Sat, Jun 13, 2020 at 06:23:57PM -0500, wu000273@umn.edu wrote:
> From: Qiushi Wu <wu000273@umn.edu>
> 
> pm_runtime_get_sync() increments the runtime PM usage counter even
> when it returns an error code, causing incorrect ref count if
> pm_runtime_put_noidle() is not called in error handling paths.
> Thus call pm_runtime_put_noidle() if pm_runtime_get_sync() fails.
> 
> Fixes: 1e6af546ee66 ("[media] v4l: vsp1: Implement runtime PM support")
> Signed-off-by: Qiushi Wu <wu000273@umn.edu>

https://lore.kernel.org/dri-devel/20200614134655.GA5960@pendragon.ideasonboard.com/

I really wonder if mass-patching all drivers is the best way forward.

> ---
>  drivers/media/platform/vsp1/vsp1_drv.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/vsp1/vsp1_drv.c b/drivers/media/platform/vsp1/vsp1_drv.c
> index c650e45bb0ad..222c9e1261a0 100644
> --- a/drivers/media/platform/vsp1/vsp1_drv.c
> +++ b/drivers/media/platform/vsp1/vsp1_drv.c
> @@ -846,8 +846,10 @@ static int vsp1_probe(struct platform_device *pdev)
>  	pm_runtime_enable(&pdev->dev);
>  
>  	ret = pm_runtime_get_sync(&pdev->dev);
> -	if (ret < 0)
> +	if (ret < 0) {
> +		pm_runtime_put_noidle(&pdev->dev);
>  		goto done;
> +	}
>  
>  	vsp1->version = vsp1_read(vsp1, VI6_IP_VERSION);
>  	pm_runtime_put_sync(&pdev->dev);

-- 
Regards,

Laurent Pinchart
