Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE328C433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 16:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8068C20767
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 16:55:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ckoL68k4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbgIBQzM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 12:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728152AbgIBQzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 12:55:09 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4BDBC061245
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 09:55:08 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id m8so3168262pfh.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 09:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+Y0rjP2iRr424s96psUmYnoN7aoVH40URoisUkWEVKM=;
        b=ckoL68k4N/ik2ZM3N7/wFHn1WzW9q/41PJ3NFI8LjEBIY08L/A2DWIaIWQ7xQaq8p+
         w6cREHr7FtQseHeaxYE/mA/A7YNIb28ZQcQFTuKRtQTv3lBcWErJv8onhO+AN3cBl+ae
         9fYw6oars+ro982BewlZThDi3ZBaLtBqUNcrOLh17FpQkL/1IHBZrNuciWBbqEpZ5RDz
         6efXbrOEyKZvfeyQugwu4FiV80Y5r4t5gGJZAAIQBGeAKtNPEOXoSpNwlpqviKS3yv9f
         CVti1fm5+5KCFF3rAMZDfzLOj+wAkbm58GzierLsh3rH/ZTYcUp5Me/q518fUlfP7huu
         6qLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+Y0rjP2iRr424s96psUmYnoN7aoVH40URoisUkWEVKM=;
        b=pAq9NvSUchAT7YvTIhm68x9tqytTYGmdklHbAgUJBFenYQFwb1y9FWAJRvOBIx0UMx
         0BWtecUJnDPV1d32TZE4ZtELwCBr4InwFskSgsnngj/7B4QABJXJldeiRaFzTuTaqQjF
         Eo7HoDSYVO2vTwvHZQFYLELmx6DZNTvhdQEUry0etvy44pvzaSkOI/4YzBVxWMLUXDWZ
         O49os6ZSwaxsywHvIOY8l3J0quTBcbeMJZr22fygxHzsXq2zcXoVPUXBzDT3rRhZSaBh
         WVOboTJxVb3JyfWywLiu1sNM4Isf1+I/R2D5WxNRgk0Ov0YtYgAPnuH+6AhRfj+PGR4Z
         5hvw==
X-Gm-Message-State: AOAM5306udFQ3ZYQYO5E0kmLpj5L9oO0L5jQ6itm/W+W6oiYobGW1Rmy
        Dy+YdhcUMn5o6DiUlbA1MpmrCg==
X-Google-Smtp-Source: ABdhPJwEIpsuErTO/bWqZFc6vuzEv2QNL7ehNrDIKdUja/jaTX8OxvJGXpuesTYh+HH/mviug93JAg==
X-Received: by 2002:a63:e015:: with SMTP id e21mr2682319pgh.264.1599065707722;
        Wed, 02 Sep 2020 09:55:07 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id ca6sm2763262pjb.53.2020.09.02.09.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2020 09:55:07 -0700 (PDT)
Date:   Wed, 2 Sep 2020 10:55:05 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Nicolas Boichat <drinkcat@chromium.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH v2] rpmsg: Avoid double-free in mtk_rpmsg_register_device
Message-ID: <20200902165505.GA280378@xps15>
References: <20200902190709.v2.1.I56cf27cd59f4013bd074dc622c8b8248b034a4cc@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200902190709.v2.1.I56cf27cd59f4013bd074dc622c8b8248b034a4cc@changeid>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 02, 2020 at 07:07:15PM +0800, Nicolas Boichat wrote:
> If rpmsg_register_device fails, it will call
> mtk_rpmsg_release_device which already frees mdev.
> 
> Fixes: 7017996951fde84 ("rpmsg: add rpmsg support for mt8183 SCP.")

The SHA should be 12 characters instead of 15.  With that:

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

> Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> ---
> 
> Changes in v2:
>  - Drop useless if and ret variable (Markus Elfring)
> 
>  drivers/rpmsg/mtk_rpmsg.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/drivers/rpmsg/mtk_rpmsg.c b/drivers/rpmsg/mtk_rpmsg.c
> index 83f2b8804ee989d..96a17ec2914011d 100644
> --- a/drivers/rpmsg/mtk_rpmsg.c
> +++ b/drivers/rpmsg/mtk_rpmsg.c
> @@ -200,7 +200,6 @@ static int mtk_rpmsg_register_device(struct mtk_rpmsg_rproc_subdev *mtk_subdev,
>  	struct rpmsg_device *rpdev;
>  	struct mtk_rpmsg_device *mdev;
>  	struct platform_device *pdev = mtk_subdev->pdev;
> -	int ret;
>  
>  	mdev = kzalloc(sizeof(*mdev), GFP_KERNEL);
>  	if (!mdev)
> @@ -219,13 +218,7 @@ static int mtk_rpmsg_register_device(struct mtk_rpmsg_rproc_subdev *mtk_subdev,
>  	rpdev->dev.parent = &pdev->dev;
>  	rpdev->dev.release = mtk_rpmsg_release_device;
>  
> -	ret = rpmsg_register_device(rpdev);
> -	if (ret) {
> -		kfree(mdev);
> -		return ret;
> -	}
> -
> -	return 0;
> +	return rpmsg_register_device(rpdev);
>  }
>  
>  static void mtk_register_device_work_function(struct work_struct *register_work)
> -- 
> 2.28.0.402.g5ffc5be6b7-goog
> 
