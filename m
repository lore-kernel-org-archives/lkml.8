Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 578D5C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 18:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 357DB20724
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 18:35:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NBu/8zoc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbgHUSfC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 14:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbgHUSfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 14:35:01 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6AC0C061573;
        Fri, 21 Aug 2020 11:35:00 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id h2so1275454plr.0;
        Fri, 21 Aug 2020 11:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JoIejRu3GXVmKj8cMY9UV1I6PbZ8S3Q6ft2ghX7hxTw=;
        b=NBu/8zocZGDiGrG4E9Aunx3MiMWHQ/DbqnIZIIGUKj+gwLiaY5Zm3Tzsr6kkC34xZ8
         vQdXF4/3m2OJs4+OSFUKebs+ayxf+nJB99UAL647l4jH5SXXstv/qQgLQqLMpP5daEyQ
         wwYPxPCSE+fwFwXWRPTzqgwfznjCR0dMgQrDdPchjISPXdmBamy3qNywXA/EvN6As5+h
         TNN7NWQuobO8fKNuyUpQOzePfjQDttdyBz5j1C6uT/h8qYLjQ5xJ87ofFhfQIncCL8ts
         1wz18zn/Y/sM8Bw+/KIqWqssMkpdWswLCOQ3GCihK+nhzjduPnsKtw9xt/kKb6kP5i3m
         /9ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=JoIejRu3GXVmKj8cMY9UV1I6PbZ8S3Q6ft2ghX7hxTw=;
        b=Q3R8yMnVYL7HFUbBXIRW/WqcYevVt8MpjD0sZMC5sX9b0xbVcfLyoDxHlNiYNYh3LW
         WuiB5cIBHQjo6BUauFz1blS54KfNJa5nAh5V2h2MWGicinI6aov8vVxNR552de16aRau
         DPd+HOu+FTl/BPoZgOCJP8f1ObuaAUicSdHFYQ5Mfd04w9pak/KxJ4YQtYoJGfvwd6Bf
         CWSUqcobTQhu+q+wWunFVWbA1rJznF8tjgjrHKmQyAZrLt3b0CVTuH+wfF9veq1uXq4z
         hwDB3fpIxyCodPXqpj9m5zDtL05GP4sLpHOLdWpAK33t7ldmktxN9BdL39ktletZjcqz
         tcfg==
X-Gm-Message-State: AOAM5329eOQr7gGc1di75yenfwQgpj+Uq9yMc+MJEXda1gJlR59oLxgm
        h4WG5hIe74gIOBqNzUvYESSe3emsQ9k=
X-Google-Smtp-Source: ABdhPJwMME1R8UpmQwpatqgtNJLOgW7AEaHEo7Fv5uD2w2wCDXArBFMv6cumaqUQigIUpIOeQiPcVA==
X-Received: by 2002:a17:902:ed4a:: with SMTP id y10mr3496148plb.106.1598034900348;
        Fri, 21 Aug 2020 11:35:00 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t28sm2841570pgn.81.2020.08.21.11.34.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Aug 2020 11:34:59 -0700 (PDT)
Date:   Fri, 21 Aug 2020 11:34:59 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     kamil@wypas.org, b.zolnierkie@samsung.com, jdelvare@suse.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH] hwmon: pwm-fan: Use dev_err_probe() to simplify error
 handling
Message-ID: <20200821183459.GA198234@roeck-us.net>
References: <1597649673-22329-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1597649673-22329-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 17, 2020 at 03:34:33PM +0800, Anson Huang wrote:
> dev_err_probe() can reduce code size, uniform error handling and record the
> defer probe reason etc., use it to simplify the code.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/pwm-fan.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
> index 17bb642..bdba214 100644
> --- a/drivers/hwmon/pwm-fan.c
> +++ b/drivers/hwmon/pwm-fan.c
> @@ -293,14 +293,8 @@ static int pwm_fan_probe(struct platform_device *pdev)
>  	mutex_init(&ctx->lock);
>  
>  	ctx->pwm = devm_of_pwm_get(dev, dev->of_node, NULL);
> -	if (IS_ERR(ctx->pwm)) {
> -		ret = PTR_ERR(ctx->pwm);
> -
> -		if (ret != -EPROBE_DEFER)
> -			dev_err(dev, "Could not get PWM: %d\n", ret);
> -
> -		return ret;
> -	}
> +	if (IS_ERR(ctx->pwm))
> +		return dev_err_probe(dev, PTR_ERR(ctx->pwm), "Could not get PWM\n");
>  
>  	platform_set_drvdata(pdev, ctx);
>  
