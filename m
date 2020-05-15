Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40FA5C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 10:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AD4B2074D
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 10:42:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oF4ghX0r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728288AbgEOKmF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 06:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728013AbgEOKmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 06:42:04 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A21C05BD09
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 03:42:03 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id e1so2970791wrt.5
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 03:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=bjsLk+xvwoPK0G6FS+rqzVpwz22QOVq1XR3jbpE7/uo=;
        b=oF4ghX0rPbPa/Z87RDmlwdJ6pHSvKwVW1YagBUpovf99JhgB7g/k+Kvu5Q0MG6xABZ
         NGAqob2CLU/hDVh0JaQskBSlDm+S4KHEl5Cwj43OmTSdIx+2HyaUlHdZ/7XM2Iaxn6kF
         2UlJgba7+3kHthk46ttiCO9bk0c4GPEVLcBd2ZQeFBh2+yV+Zipjz4ECUyih8B08z4jf
         AoVHcZluLTYxrWT0UL+pxsy/xh8qWvL8puwY55j2izxfe6Jm0lyQIvrpUcl2bCg/hNqL
         Km1vqo6X6K2cEG71XS8oZyXYbhJ2cOg8CZO1PmkVrGe783k6pWnL1lEbr9iZME9xzwgU
         7c2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=bjsLk+xvwoPK0G6FS+rqzVpwz22QOVq1XR3jbpE7/uo=;
        b=Nw7VzpW6hOewalxZyyVL86m4Ikls/ay5PCM794knuZpY2VMkwsdwFE9TrWgZydZnMN
         sXo2s3VjqXmLe6CDdgok4FzDDsvVBInpcO+UIFGUcBHFY/Nilw7j+g/25XlQajMpBDlK
         n1C3yatt3GtE8Gm7MdhaW1Qbh7CxEeQX5rE9/gjLLhFrbM3Jow9X3x9hPOcveIBoq1Ve
         hjN/U+vzShKND+0twFKwPAVsR+dprE78uloypnT9a5FpEMPO4kD7nFB/2eV6ljYYTkBx
         TojHvnMPuen1Yn5RRU+akpnuwAe6L7k+UA6JsM9BmzSch/p6b6iqBm5NJnO8lQMmbjno
         Ynuw==
X-Gm-Message-State: AOAM533/VAvS36PL0LGw2TxAv9qZMIdlLchd4kG6Vi9FrAxU3U76OWGC
        Lo/3PkWq6cq8uLkYGRNcS10ld74xOLA=
X-Google-Smtp-Source: ABdhPJzZupSPWCfBYmZ0VX+jYoFv2OSmyUPoNSIUI/GQWV66iibTP1agtwkN7aAbwSJcji6IXkvuJA==
X-Received: by 2002:a5d:49ca:: with SMTP id t10mr3326008wrs.285.1589539322111;
        Fri, 15 May 2020 03:42:02 -0700 (PDT)
Received: from dell ([2.31.163.63])
        by smtp.gmail.com with ESMTPSA id t22sm2900333wmj.37.2020.05.15.03.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 03:42:01 -0700 (PDT)
Date:   Fri, 15 May 2020 11:42:00 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     LKLM <linux-kernel@vger.kernel.org>,
        Gyungoh Yoo <jack.yoo@maxim-ic.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] mfd: remove max8907 wake_base
Message-ID: <20200515104200.GJ271301@dell>
References: <c97ca4ac78304a44587463584acaf1ba08f0d4ee.1588240814.git.fuyao@allwinnertech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c97ca4ac78304a44587463584acaf1ba08f0d4ee.1588240814.git.fuyao@allwinnertech.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Apr 2020, mjz wrote:

Please could you change your sender and SoB to your proper name and
ensure they match please.

> regmap irqchip should not use wake_base the same as mask_base.
> if use enable_irq_wake in drivers can cause mask_base write, cause
> the disabled irq to enable.

Could you please try to use correct grammar in commit messages.
Names of things should start with capital letters, as should
sentences.

> Signed-off-by: maijianzhang <maijianzhang@allwinnertech.com>
> ---
>  drivers/mfd/max8907.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/mfd/max8907.c b/drivers/mfd/max8907.c
> index d44baafd9d14..6346a3985088 100644
> --- a/drivers/mfd/max8907.c
> +++ b/drivers/mfd/max8907.c
> @@ -130,7 +130,6 @@ static const struct regmap_irq_chip max8907_chg_irq_chip = {
>  	.name = "max8907 chg",
>  	.status_base = MAX8907_REG_CHG_IRQ1,
>  	.mask_base = MAX8907_REG_CHG_IRQ1_MASK,
> -	.wake_base = MAX8907_REG_CHG_IRQ1_MASK,
>  	.irq_reg_stride = MAX8907_REG_CHG_IRQ2 - MAX8907_REG_CHG_IRQ1,
>  	.num_regs = 2,
>  	.irqs = max8907_chg_irqs,

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
