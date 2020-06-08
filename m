Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1D91C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 01:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C5002063A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 01:55:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="NPCCtVM9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728840AbgFHBzT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jun 2020 21:55:19 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:48562 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727871AbgFHBzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 21:55:18 -0400
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id C25B024F;
        Mon,  8 Jun 2020 03:55:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1591581316;
        bh=CthNpIqftGchRHdnCTWbVdTQG6Z9SbHT2rIpOWme35Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NPCCtVM9aMDQy37szWgmy93G2oQZoDzXt/F+u94gKh9NLoxp/WmJEHRJm4uhvvj4N
         oLbIYFQ4qn34ZFbvwJJr9X8z3fv1aF+ByGknhxh8jTBv9yo6BfrVywpmWixvrG6JJb
         lTpC3fFDr7YydWN+Pkef67H5fijOZ3YliO9UKVB8=
Date:   Mon, 8 Jun 2020 04:54:56 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc:     kjlu@umn.edu,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: vsp1: Fix runtime PM imbalance in vsp1_probe
Message-ID: <20200608015456.GJ22208@pendragon.ideasonboard.com>
References: <20200523115426.19285-1-dinghao.liu@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200523115426.19285-1-dinghao.liu@zju.edu.cn>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dinghao,

Thank you for the patch.

On Sat, May 23, 2020 at 07:54:26PM +0800, Dinghao Liu wrote:
> pm_runtime_get_sync() increments the runtime PM usage counter even
> when it returns an error code. Thus a pairing decrement is needed on
> the error handling path to keep the counter balanced.

I wonder how many bugs we have today, and how many bugs will keep
appearing in the future, due to this historical design mistake :-( 

> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> ---
>  drivers/media/platform/vsp1/vsp1_drv.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/vsp1/vsp1_drv.c b/drivers/media/platform/vsp1/vsp1_drv.c
> index c650e45bb0ad..017a54f2fdd8 100644
> --- a/drivers/media/platform/vsp1/vsp1_drv.c
> +++ b/drivers/media/platform/vsp1/vsp1_drv.c
> @@ -846,8 +846,10 @@ static int vsp1_probe(struct platform_device *pdev)
>  	pm_runtime_enable(&pdev->dev);
>  
>  	ret = pm_runtime_get_sync(&pdev->dev);
> -	if (ret < 0)
> +	if (ret < 0) {
> +		pm_runtime_put_sync(&pdev->dev);
>  		goto done;
> +	}

This change looks good to me, but we also need a similar change in the
vsp1_device_get() function if I'm not mistaken. Could you combine both
in the same patch ?

>  
>  	vsp1->version = vsp1_read(vsp1, VI6_IP_VERSION);
>  	pm_runtime_put_sync(&pdev->dev);

-- 
Regards,

Laurent Pinchart
