Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B8CC3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 20:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9F2E207FD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 20:47:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech-se.20150623.gappssmtp.com header.i=@ragnatech-se.20150623.gappssmtp.com header.b="1LquHOcq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388255AbgCDUrU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 15:47:20 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34007 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728539AbgCDUrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 15:47:20 -0500
Received: by mail-lj1-f195.google.com with SMTP id j19so1295924lji.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 12:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=xnoGvoXhhUyFFcGXnJkM1A4TM1bJ6CuJ9H64XlhnlOw=;
        b=1LquHOcq5PsAyYYx83eHq1FpCaxYL1QI5FlA68WKx+OVumex24OC0twL/ml3AN22xk
         0ciIoM9TNXZbvIG5JZtnLDaSX+MP/ss5yfAp0QYfGJ4Ro7Hvg1q7zk6I+wHa3ZQN3Tvq
         hpsFCGE2FI7R1D1x+DL8fc6bM1IflcDfh9NhCfoaF7jBqzhQlzsparXZTggRZkI1Nwve
         JOp2YeKRUiA94s9mSgGXfK+YsSmPnycl3NRrckOsY/6L9b6iJaEbVCnJAkcQJWpvcGuR
         KKlPYDeyi7jMwBaInhoFwPME5oWBS58QpCqiVtpO4EnsxJow8EA//sS27pc0ymCycg4Q
         nIMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=xnoGvoXhhUyFFcGXnJkM1A4TM1bJ6CuJ9H64XlhnlOw=;
        b=et2xQmIuDRTVXjaA8Z4GqX2Jm+z465LZ/wN1QVUsicFEmamtB/9dgEgmcJ/Yy75LwV
         ryyDTQeCYrswn9l6rC8CcFSwHVL8qAMk5eX2pmyZvGGOS46yrEgv3RhPBkcNTnpOynfe
         Ve/7OxnsaeCu+LUVzQSDcEPDx4pJLGpkKkR3eyhceTDxp15gS3MHGmG/TN6Bc2UqZ2zt
         Dmi75f0nHP0URiDs2eBwNyki5ijSy5nSC2U0NVGpM+y/HefqEFfbdS4noHP6T1LdnJvu
         Q5czO/IA9tpaA4JLzPcvv3njD5ZbxcHX4cEOSmQyuBJBnMFMKxuW+Ik3db9GKwq091t8
         FlSg==
X-Gm-Message-State: ANhLgQ1smmcSmTTtg6aU38lZDVb40TNm+wYu91c96YrtG32qdIF4UVB6
        9zbjC2HyfaCiV9aq/m2yrCcsDQ==
X-Google-Smtp-Source: ADFU+vvtYhrrY6pxQNgxw1MamsBY5xDsAr9yVhDE+RLJxIWVJi2I5cmLL8RckGW0gbd7ccsxcyDo+A==
X-Received: by 2002:a2e:80cc:: with SMTP id r12mr2860946ljg.154.1583354836747;
        Wed, 04 Mar 2020 12:47:16 -0800 (PST)
Received: from localhost (h-200-138.A463.priv.bahnhof.se. [176.10.200.138])
        by smtp.gmail.com with ESMTPSA id t4sm6101628ljk.14.2020.03.04.12.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 12:47:15 -0800 (PST)
Date:   Wed, 4 Mar 2020 21:47:15 +0100
From:   Niklas <niklas.soderlund@ragnatech.se>
To:     Lad Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 1/2] media: rcar-csi2: Fix registering camera endpoint to
 VIN
Message-ID: <20200304204715.GC1791497@oden.dyn.berto.se>
References: <20200228165011.17898-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20200228165011.17898-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200228165011.17898-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lad,

Thanks for your work.

On 2020-02-28 16:50:10 +0000, Lad Prabhakar wrote:
> CSI2 registers camera/sensor as v4l2 async sub device with fwnode is
> remote endpoint and the camera/sensor register itself as v4l2 sub device
> with fwnode is remote device as a result the match.fwnode should be
> fwnode_graph_get_remote_port_parent and not
> fwnode_graph_get_remote_endpoint.
> 
> This patch makes use of v4l2 helper function
> v4l2_async_notifier_add_fwnode_remote_subdev() which uses
> fwnode_graph_get_remote_port_parent as match.fwnode fixing the issue
> of registering camera endpoint to the driver.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

I'm afraid this is not the right solution. The rcar-csi2 driver uses the 
v4l2-async framework to do endpoint matching instead of node matching.  
This is needed as it needs to work with the adv748x driver which 
register it self in v4l2-async using endpoints instead of nodes. The 
reason for this is that from a single DT node it creates multiple 
subdevices, one for each endpoint IIRC.

Without this patch the two CSI-2 receivers on R-Car M3-n registers the 
two following 'paths' in v4l2 to be able to find the two subdevice CSI-2 
transmitters created by the ADV748x.

rcar-csi2 fea80000.csi2: '/soc/i2c@e66d8000/video-receiver@70/port@b/endpoint'
rcar-csi2 feaa0000.csi2: '/soc/i2c@e66d8000/video-receiver@70/port@a/endpoint'

With this patch applied it registers the following which can't be found 
as they are not present in the v4l2-async list of subdevices (as they 
are registerd as above).

rcar-csi2 fea80000.csi2: '/soc/i2c@e66d8000/video-receiver@70'
rcar-csi2 feaa0000.csi2: '/soc/i2c@e66d8000/video-receiver@70'
rcar-csi2: probe of feaa0000.csi2 failed with error -17

This patch may unlock your use-case as it's a known problem that 
endpoint and node matching do not mix. But it will break the already 
upstream use-case and for that reason, I'm really sorry about this.

Nacked-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

The real solution to this problem IMHO is to make all of v4l2-async 
operate using endpoint matching or possibly some kind of fallback to 
node matching if no endpoint can be found. Never the less some work is 
required in the v4l2-async core to sort out node and endpoint matching 
coexistence.

> ---
>  drivers/media/platform/rcar-vin/rcar-csi2.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/media/platform/rcar-vin/rcar-csi2.c b/drivers/media/platform/rcar-vin/rcar-csi2.c
> index faa9fb23a2e9..5b04e4768eb1 100644
> --- a/drivers/media/platform/rcar-vin/rcar-csi2.c
> +++ b/drivers/media/platform/rcar-vin/rcar-csi2.c
> @@ -833,20 +833,18 @@ static int rcsi2_parse_dt(struct rcar_csi2 *priv)
>  		return ret;
>  	}
>  
> -	priv->asd.match.fwnode =
> -		fwnode_graph_get_remote_endpoint(of_fwnode_handle(ep));
> -	priv->asd.match_type = V4L2_ASYNC_MATCH_FWNODE;
> -
> -	of_node_put(ep);
> -
>  	v4l2_async_notifier_init(&priv->notifier);
>  
> -	ret = v4l2_async_notifier_add_subdev(&priv->notifier, &priv->asd);
> +	ret = v4l2_async_notifier_add_fwnode_remote_subdev(&priv->notifier,
> +							   of_fwnode_handle(ep),
> +							   &priv->asd);
>  	if (ret) {
> -		fwnode_handle_put(priv->asd.match.fwnode);
> +		of_node_put(ep);
>  		return ret;
>  	}
>  
> +	of_node_put(ep);
> +
>  	priv->notifier.ops = &rcar_csi2_notify_ops;
>  
>  	dev_dbg(priv->dev, "Found '%pOF'\n",
> -- 
> 2.20.1
> 

-- 
Regards,
Niklas Söderlund
