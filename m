Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB28C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 124CA20639
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:38:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YUCUJvfr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731929AbgHTKiv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 06:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730963AbgHTKSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 06:18:03 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 376A1C061757;
        Thu, 20 Aug 2020 03:18:01 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id w14so1470935ljj.4;
        Thu, 20 Aug 2020 03:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kYwjflgRQVoui32eapBhBFxV9IoHyH7UykeWpPqQmtM=;
        b=YUCUJvfrTEooGe2XmrcE5ooa0JrwV+Mh0xPCIgP0m4H3+6vDf4NkhTLQmKh322gIa7
         y5EdIV0jnmdsV/BsN9zhxZBk2UnrRxTTKYU5Fg6pOXUGkEceJt3FK1uBmEPe0O6EZD4m
         jxVmBi6A2rR492QA2Kdce72+QUA0XLeh3l8kHpIMy7NZqGq4p/CkGsw5SyRqov6ydrgh
         26i3+kV0DS2CEoMpWYwj/l48eLpF6QMwCJXFt0nknR51Kf3yLPmkDbXbrC8/wSDimJ0R
         pzOk4cjzaQzSm1E68kujkeGofsy0Z0JFM490+h698hLK6ZQznCqJzw7XTZwvqEig0QG1
         gQTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=kYwjflgRQVoui32eapBhBFxV9IoHyH7UykeWpPqQmtM=;
        b=XB/db52PCEVlUKXtqjdd5u6ItwEonbhOWKMqrE4vS719nR3Wl5fUsAT17K2+ZxJt/+
         LeqEnMxGMMvJIXWTb9wlApO8Qa9ayG5SK+OQCfEpx5MkPJ4uwY8xqqvIPc4yuW78Ki+Y
         xwoDGE2/c0qBRc38XOCTiDD4tKl15PBe5/NHZY8RYaa7q8M/OXQ3F3Rgieyu0TtXzBzz
         dJfZ3LeSOFQIkNS87gNDaeU+6zmxlZXU+qTz4WZaf1vBmmOpKYx02JMyW2baCpxMmboW
         bPV/NHnOE3ElHWbA2gCDae/eKPpLFagMWA/JiMJKMTB8wnSlCfT5FPGl2iRWYAqVxzMq
         DNaQ==
X-Gm-Message-State: AOAM532H1gMXCG/wjpEpmRrGhHlsdUMHpL3FAwNalARYkVrzg5RDc98K
        mT5NHUXADjxHmxKxdWQ4ZF0=
X-Google-Smtp-Source: ABdhPJwjqkY0cuKDRZWTWyb21YTWtVQeguRgHHXFYAGtSOBhfdTWpQwdx2DJIDTAdHIjmI9++VNqjw==
X-Received: by 2002:a2e:9d17:: with SMTP id t23mr1247335lji.456.1597918679697;
        Thu, 20 Aug 2020 03:17:59 -0700 (PDT)
Received: from ?IPv6:2a00:1fa0:42ab:a165:4cb2:5f04:a1e8:63b? ([2a00:1fa0:42ab:a165:4cb2:5f04:a1e8:63b])
        by smtp.gmail.com with ESMTPSA id p8sm403098lfh.64.2020.08.20.03.17.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2020 03:17:59 -0700 (PDT)
Subject: Re: [PATCH v2 09/11] usb: phy: phy-mv-usb: convert to
 readl_poll_timeout_atomic()
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Lee Jones <lee.jones@linaro.org>
References: <1597902349-8998-1-git-send-email-chunfeng.yun@mediatek.com>
 <1597902349-8998-9-git-send-email-chunfeng.yun@mediatek.com>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Organization: Brain-dead Software
Message-ID: <c28a906c-ed1a-8884-3016-b8664a313331@gmail.com>
Date:   Thu, 20 Aug 2020 13:17:49 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <1597902349-8998-9-git-send-email-chunfeng.yun@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.08.2020 8:45, Chunfeng Yun wrote:

> Use readl_poll_timeout_atomic() to simplify code
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
> v2: udelay 10us instead of 20us according to kerneldoc
> ---
>   drivers/usb/phy/phy-mv-usb.c | 16 +++++++---------
>   1 file changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/usb/phy/phy-mv-usb.c b/drivers/usb/phy/phy-mv-usb.c
> index ce767ec..e801569 100644
> --- a/drivers/usb/phy/phy-mv-usb.c
> +++ b/drivers/usb/phy/phy-mv-usb.c
> @@ -8,6 +8,7 @@
>   #include <linux/module.h>
>   #include <linux/kernel.h>
>   #include <linux/io.h>
> +#include <linux/iopoll.h>
>   #include <linux/uaccess.h>
>   #include <linux/device.h>
>   #include <linux/proc_fs.h>
> @@ -135,8 +136,8 @@ static int mv_otg_set_timer(struct mv_otg *mvotg, unsigned int id,
>   
>   static int mv_otg_reset(struct mv_otg *mvotg)
>   {
> -	unsigned int loops;
>   	u32 tmp;
> +	int ret;
>   
>   	/* Stop the controller */
>   	tmp = readl(&mvotg->op_regs->usbcmd);
> @@ -146,15 +147,12 @@ static int mv_otg_reset(struct mv_otg *mvotg)
>   	/* Reset the controller to get default values */
>   	writel(USBCMD_CTRL_RESET, &mvotg->op_regs->usbcmd);
>   
> -	loops = 500;
> -	while (readl(&mvotg->op_regs->usbcmd) & USBCMD_CTRL_RESET) {
> -		if (loops == 0) {
> -			dev_err(&mvotg->pdev->dev,
> +	ret = readl_poll_timeout_atomic(&mvotg->op_regs->usbcmd, tmp,
> +				(tmp & USBCMD_CTRL_RESET), 10, 10000);
> +	if (ret < 0) {
> +		dev_err(&mvotg->pdev->dev,
>   				"Wait for RESET completed TIMEOUT\n");

    You forgot to re-align this argument, it should start under & on the 
previous line...

[...]

MBR, Sergei
