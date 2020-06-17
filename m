Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E3FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 10:56:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2104E214DB
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 10:56:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech-se.20150623.gappssmtp.com header.i=@ragnatech-se.20150623.gappssmtp.com header.b="amlLk7I9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbgFQK4v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 06:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725967AbgFQK4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 06:56:49 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D98C061573
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 03:56:49 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id o4so1014626lfi.7
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 03:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=wv4JOEkgSAQcpHqAPZTS4UyV/xPjl9B1rLAD9aD3HsM=;
        b=amlLk7I9V/pqwCREH3yz2rxJEmwjHGeyegaXNzu5jaaQeFkFRMbRK3Mmf6GJ7QJZi+
         YUJNxYC+ONqULDbKASu4uhvdqpHMCM/jRAHKBqzTQoj9ODZPeMFlYrq6HXQu8qIXsEmD
         PJiux/GaQmm5B+U4UrBQdzFkwhoHymKTxXdL1TnZu3Nx5h2UN9eWLbUtG4F7hZW3Pktm
         knlDkmDJrwb1gwNx18BjN6Z9ntJF/SPdFBy3Yw090cg3VyPcOsNo/7vUQC95LOWR2VRE
         02N/PydJlavKus/JhceWzWec9kudM9PjpiYLzp+LkIGjrXPG0qHoY2ZFBFN6ZP1lSjjb
         w5fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=wv4JOEkgSAQcpHqAPZTS4UyV/xPjl9B1rLAD9aD3HsM=;
        b=bjS5JD/wVR4iMZLELGNia5VGqg4IvyS9m8GpBuH5AF9DTxalCVHUd45FOU3HzdrT/9
         kFJY9moOd0w6nc0bGKscl3+ybSllrvE4obMaZ9ORi/auKqqEpL41OO2Ph59iGK8+ieyC
         fxsZeH9lXbrlTGs2BLj4zXva6dQXUkKFox/WThbZOnb5oT689KgcOjWrR8RwkItIzAG3
         6N024X+8v9YbeJAJFq0INF14+tGAEMCkEp5BukSp1027wKcNyuCprOx4SYTU/PhYryKc
         alJDOnzkKBH4FsTJ3qFNZ51GNBKmnBKuk8jOPkJX5hNgqkuIWJhUBbmSghSJCQ4ViIge
         oMlQ==
X-Gm-Message-State: AOAM5323Neqi2HwC/rjy2BfVz0g0f90Le3SUuK4rP6PZLsbaFfP6QUaK
        Pxo75UGCZaIYEfpf2pahOc2UgqxKR0Y=
X-Google-Smtp-Source: ABdhPJxlYDudMVQs6ZzCpFXlJvtWQUM6NPvJdG9LwvIWLjANVX4mh5TmAtC3Li855C0bHMRM2CCY0A==
X-Received: by 2002:ac2:4829:: with SMTP id 9mr4214933lft.41.1592391407539;
        Wed, 17 Jun 2020 03:56:47 -0700 (PDT)
Received: from localhost (h-209-203.A463.priv.bahnhof.se. [155.4.209.203])
        by smtp.gmail.com with ESMTPSA id w20sm5942622lfk.56.2020.06.17.03.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 03:56:46 -0700 (PDT)
Date:   Wed, 17 Jun 2020 12:56:46 +0200
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>
To:     Michael Rodin <mrodin@de.adit-jv.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, michael@rodin.online,
        efriedrich@de.adit-jv.com, erosca@de.adit-jv.com,
        Steve Longerbeam <steve_longerbeam@mentor.com>
Subject: Re: [PATCH] media: rcar-vin: Move media_device_register to async
 completion
Message-ID: <20200617105646.GB2850317@oden.dyn.berto.se>
References: <1592328696-84533-1-git-send-email-mrodin@de.adit-jv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1592328696-84533-1-git-send-email-mrodin@de.adit-jv.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael and Steve,

On 2020-06-16 19:31:36 +0200, Michael Rodin wrote:
> From: Steve Longerbeam <steve_longerbeam@mentor.com>
> 
> The media_device is registered during driver probe, before async
> completion, so it is possible for .link_notify to be called before
> all devices are bound.
> 
> Fix this by moving media_device_register() to rvin_group_notify_complete().
> This ensures that all devices are now bound (the rcar-csi2 subdevices and
> and video capture devices) before .link_notify can be called.

I'm curious to what situation created the need for this change. I'm 
currently trying to take the VIN driver in the opposite direction [1] 
with the end goal of registering video devices at probe time and then 
allow the media graph to populate as devices becomes available.

My reason for this is that we could have a functional pipeline inside 
the graph even if it's not complete. This came out of the GMSL work done
a while pack where I had a faulty camera that would prevent the other 7 
in the system to function.

1. [PATCH 0/5] media-device: Report if graph is complete

> 
> Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
> Signed-off-by: Michael Rodin <mrodin@de.adit-jv.com>
> ---
>  drivers/media/platform/rcar-vin/rcar-core.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/media/platform/rcar-vin/rcar-core.c b/drivers/media/platform/rcar-vin/rcar-core.c
> index 7440c89..e70f83b 100644
> --- a/drivers/media/platform/rcar-vin/rcar-core.c
> +++ b/drivers/media/platform/rcar-vin/rcar-core.c
> @@ -253,7 +253,6 @@ static int rvin_group_init(struct rvin_group *group, struct rvin_dev *vin)
>  	struct media_device *mdev = &group->mdev;
>  	const struct of_device_id *match;
>  	struct device_node *np;
> -	int ret;
>  
>  	mutex_init(&group->lock);
>  
> @@ -266,7 +265,6 @@ static int rvin_group_init(struct rvin_group *group, struct rvin_dev *vin)
>  	vin_dbg(vin, "found %u enabled VIN's in DT", group->count);
>  
>  	mdev->dev = vin->dev;
> -	mdev->ops = &rvin_media_ops;
>  
>  	match = of_match_node(vin->dev->driver->of_match_table,
>  			      vin->dev->of_node);
> @@ -278,11 +276,7 @@ static int rvin_group_init(struct rvin_group *group, struct rvin_dev *vin)
>  
>  	media_device_init(mdev);
>  
> -	ret = media_device_register(&group->mdev);
> -	if (ret)
> -		rvin_group_cleanup(group);
> -
> -	return ret;
> +	return 0;
>  }
>  
>  static void rvin_group_release(struct kref *kref)
> @@ -688,6 +682,8 @@ static int rvin_group_notify_complete(struct v4l2_async_notifier *notifier)
>  		return ret;
>  	}
>  
> +	vin->group->mdev.ops = &rvin_media_ops;
> +
>  	/* Register all video nodes for the group. */
>  	for (i = 0; i < RCAR_VIN_NUM; i++) {
>  		if (vin->group->vin[i] &&
> @@ -736,8 +732,10 @@ static int rvin_group_notify_complete(struct v4l2_async_notifier *notifier)
>  		}
>  	}
>  	mutex_unlock(&vin->group->lock);
> +	if (ret)
> +		return ret;
>  
> -	return ret;
> +	return media_device_register(&vin->group->mdev);
>  }
>  
>  static void rvin_group_notify_unbind(struct v4l2_async_notifier *notifier,
> -- 
> 2.7.4
> 

-- 
Regards,
Niklas Söderlund
