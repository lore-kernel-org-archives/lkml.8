Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 478B8C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 14:17:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21CA820801
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 14:17:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AxV/Sk0D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728163AbgFKOR3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 10:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726936AbgFKOR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 10:17:28 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 145EBC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 07:17:27 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id u13so5131664wml.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 07:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RNw0t5OF2i7drNguzCKs4BhL36r2VlgNY7GbFOTjqzw=;
        b=AxV/Sk0DEDT54gQbWwbuHMzsD6e/E7rOARS21Yrb+YqlY/aM5Ccc/oKi9TqQiGSafa
         H9j+XMp2do7JhHGU93olyhpUGKoWHDkgt21qI8IRXXvvFnxLEBNRt2Yt55Pvowjathtg
         7jandyKb8/7FIK5JeEn2ibq1k2C0PxlylKzYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RNw0t5OF2i7drNguzCKs4BhL36r2VlgNY7GbFOTjqzw=;
        b=Rr1SqjooNy0gdlwqWo1XWV7FluQ+zX7jMkVLjuZGRDYBjty2EX0k2qBO3VPo3oZGbI
         xVkcHqA8yc6r1CNxy2xV8FLYD1JFuK+SauxPJWRT817f5YqF7J5ymurRYHoV+poWlhbc
         CV1vjJWVl6yIxzDetpn+zcaN4lbw2lZyFCkHAnxuAIxmgZjIkxg7RHA2DVRkd5vDjmwK
         G3OpFmB+HWKiEejMUMSoIk7kjlKMSrsZ/+5dhL064Dl5eKlXHLzmGdHrL+ydxLtWe7xb
         /WZWmWQYSExL72lDWN3Fkl4N5ZaXScZ1F2X3qpC68bpHgIU9/HIW1WVL7JAu42b80pGR
         BnjA==
X-Gm-Message-State: AOAM53161DcfHsUMTc7BcApacGJUV3gSCDqaZ0je2+7y/25g0ARdntUm
        YPdFaCUmBp39rHrVWEAZ3L6tVg==
X-Google-Smtp-Source: ABdhPJwxfmfetZw9SoQatIxsaEyd3GfuKkNflglFUsvZOtyhVxP2C6KyLrgx+G/tzAa2Jda/IPxaig==
X-Received: by 2002:a1c:c3d7:: with SMTP id t206mr8521727wmf.69.1591885040174;
        Thu, 11 Jun 2020 07:17:20 -0700 (PDT)
Received: from chromium.org (205.215.190.35.bc.googleusercontent.com. [35.190.215.205])
        by smtp.gmail.com with ESMTPSA id t7sm4879946wrq.41.2020.06.11.07.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 07:17:19 -0700 (PDT)
Date:   Thu, 11 Jun 2020 14:17:18 +0000
From:   Tomasz Figa <tfiga@chromium.org>
To:     Xia Jiang <xia.jiang@mediatek.com>
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rick Chang <rick.chang@mediatek.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        srv_heupstream@mediatek.com, senozhatsky@chromium.org,
        mojahsu@chromium.org, drinkcat@chromium.org,
        maoguang.meng@mediatek.com, sj.huang@mediatek.com
Subject: Re: [PATCH RESEND v9 07/18] media: platform: Improve the
 implementation of the system PM ops
Message-ID: <20200611141718.GA158633@chromium.org>
References: <20200604090553.10861-1-xia.jiang@mediatek.com>
 <20200604090553.10861-9-xia.jiang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200604090553.10861-9-xia.jiang@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xia,

On Thu, Jun 04, 2020 at 05:05:42PM +0800, Xia Jiang wrote:
> Add v4l2_m2m_suspend() function call in mtk_jpeg_suspend() to make sure
> that the current frame is processed completely before suspend.
> Add v4l2_m2m_resume() function call in mtk_jpeg_resume() to unblock the
> driver from scheduling next frame.
> 
> Signed-off-by: Xia Jiang <xia.jiang@mediatek.com>
> ---
> v9: use v4l2_m2m_suspend() and v4l2_m2m_resume() to improve the
>     implemention of the system PM ops
> ---
>  drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Thank you for the patch. Please see my comments inline.

> diff --git a/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c b/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c
> index 7f74597262fc..49bdbf1c435f 100644
> --- a/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c
> +++ b/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c
> @@ -1208,10 +1208,13 @@ static __maybe_unused int mtk_jpeg_pm_resume(struct device *dev)
>  static __maybe_unused int mtk_jpeg_suspend(struct device *dev)
>  {
>  	int ret;
> +	struct mtk_jpeg_dev *jpeg = dev_get_drvdata(dev);
>  
>  	if (pm_runtime_suspended(dev))
>  		return 0;
>  
> +	v4l2_m2m_suspend(jpeg->m2m_dev);
> +
>  	ret = mtk_jpeg_pm_suspend(dev);
>  	return ret;
>  }

This could be simplified into:

{
	struct mtk_jpeg_dev *jpeg = dev_get_drvdata(dev);

	v4l2_m2m_suspend(jpeg->m2m_dev);
	return pm_runtime_force_suspend(dev);
}

> @@ -1219,12 +1222,15 @@ static __maybe_unused int mtk_jpeg_suspend(struct device *dev)
>  static __maybe_unused int mtk_jpeg_resume(struct device *dev)
>  {
>  	int ret;
> +	struct mtk_jpeg_dev *jpeg = dev_get_drvdata(dev);
>  
>  	if (pm_runtime_suspended(dev))
>  		return 0;
>  
>  	ret = mtk_jpeg_pm_resume(dev);
>  
> +	v4l2_m2m_resume(jpeg->m2m_dev);
> +
>  	return ret;
>  }

Similarly here:

{
	struct mtk_jpeg_dev *jpeg = dev_get_drvdata(dev);
	int ret;

	ret = pm_runtime_force_resume(dev);
	if (ret < 0)
		return ret;

	v4l2_m2m_resume(jpeg->m2m_dev);
}

The pm_runtime_force_*() helpers will make sure that the right runtime PM
state is restored.

Best regards,
Tomasz
