Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DABECC433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 08:05:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B16722074D
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 08:05:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T6FxFVn1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbgFPIFp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 04:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727090AbgFPIFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 04:05:33 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 519ABC03E96A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 01:05:32 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id j10so19703825wrw.8
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 01:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=nSbbk12sklznSzURmDgyRvyV4JyDaN7OpY0qUFnGrF0=;
        b=T6FxFVn1hxbyVOJ1IyLfuqYj92YRLnRIsyx3/oowDA+x3BzDhwFFmEeKEnPEP9MPEA
         Q4cmnsQT8k+IMgfrS+3spLNWSL06RqN5ebkLysnP6qXhcUQk9AGZtEgX1tRfPkNPU28/
         4jJVm8GVo0U9VldN1mn1ClAGq/x7SH0XL66fJeIzZRX/G6Q1xsok0Y2PUuquOkR1aBlj
         tApAtsDp/nIGk0fmm6PqW/vfj/Q4Rw28Yj9ozigY3qyY7ZyVtXEVHsL7xsk+ercb4Sqv
         UZEfOeVoDSU05JYPGHHufWHF007CvNHJQzCssmMv5YBp5l3UD2RZwRoXhJzjSl2+bRq7
         xLxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=nSbbk12sklznSzURmDgyRvyV4JyDaN7OpY0qUFnGrF0=;
        b=f9WEePo1j/1YDrL/W98n+sRNxQ0P/2LNWSIw/AMvO2DoDy1Zhj+ZkFM2dX3ltm6UkX
         O7/7rTD1IuazxjuzEbWn2/fTK0R21IM4UET1owXyq11wCSOEsMr6aliir0dvky8mq8sB
         7TD/+SHd+1sJE0Wp2PD4m38wJkHAxkClwooXPa6niq/9cxacItRE9T9DjD43lIXJitzM
         c3VRNFqb3YhfdGZ2Uq9gQfN4nS5GhsRjtD5LJjg/OhUkr70FluwGRu5hM6XPjYFOAv1c
         JtvREuxTNX0AORO2Xd7v5VSs5wAK82A3QvLEeWZZYYpSlFDIiduzNulED7mdDvj4NDBh
         WL3g==
X-Gm-Message-State: AOAM532W9RTNsSxsEGeQzwEvF2Oow98l9mGy39sZbOwTXoStotD+FIsB
        WO8mdEnd59+GpVwsIyBHJbmnOQ==
X-Google-Smtp-Source: ABdhPJxU65V0UN6yumv2HUuV4IN5upvbVb+ibQ9xncnrMwZn2lX2xkgru9+/gYpAYeYXxU41grhpcA==
X-Received: by 2002:adf:ec0a:: with SMTP id x10mr1682760wrn.130.1592294731087;
        Tue, 16 Jun 2020 01:05:31 -0700 (PDT)
Received: from dell ([109.180.115.156])
        by smtp.gmail.com with ESMTPSA id f2sm2679917wmj.39.2020.06.16.01.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 01:05:30 -0700 (PDT)
Date:   Tue, 16 Jun 2020 09:05:29 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Wang Qing <wangqing@vivo.com>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/video/backlight: Use kobj_to_dev() instead
Message-ID: <20200616080529.GK2608702@dell>
References: <1592211242-31683-1-git-send-email-wangqing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1592211242-31683-1-git-send-email-wangqing@vivo.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Jun 2020, Wang Qing wrote:

> Use kobj_to_dev() instead of container_of()
> 
> Signed-off-by: Wang Qing <wangqing@vivo.com>
> ---
>  drivers/video/backlight/lm3533_bl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>  mode change 100644 => 100755 drivers/video/backlight/lm3533_bl.c

I've fixed the broken subject line.

For future submissions, please use `git log --oneline -- <SUBSUSTEM>`
to view the expected formatting for any given <SUBSYSTEM>.

Applied, thanks.

> diff --git a/drivers/video/backlight/lm3533_bl.c b/drivers/video/backlight/lm3533_bl.c
> index ee09d1b..0c7830f
> --- a/drivers/video/backlight/lm3533_bl.c
> +++ b/drivers/video/backlight/lm3533_bl.c
> @@ -235,7 +235,7 @@ static struct attribute *lm3533_bl_attributes[] = {
>  static umode_t lm3533_bl_attr_is_visible(struct kobject *kobj,
>  					     struct attribute *attr, int n)
>  {
> -	struct device *dev = container_of(kobj, struct device, kobj);
> +	struct device *dev = kobj_to_dev(kobj);
>  	struct lm3533_bl *bl = dev_get_drvdata(dev);
>  	umode_t mode = attr->mode;
>  

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
