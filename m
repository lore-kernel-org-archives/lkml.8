Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D99C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 03:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFD1C2068F
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 03:53:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VoY/vrzI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728721AbgGMDxI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 23:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbgGMDxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 23:53:07 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB212C061794;
        Sun, 12 Jul 2020 20:53:07 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id u185so5436952pfu.1;
        Sun, 12 Jul 2020 20:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=P/uMBAFsJSFsMe0s271yKJa7p3nRkmMFxcASFVx3X9s=;
        b=VoY/vrzIzoUvpLLOWgA04fLa3of+ub+owBKbOFPm4LdVdlbMRJRIXMVMWrrc9BNOKF
         r1GKF4a3rcQ658wT6pYylfRqzRAtJ0LnTHrzrbJj/RDqE/thsXDNuW6RBEHCF42iA3fG
         xxO+aGacyGOZsWbLTZosotOjPPtD7nZhnnRp2HdoV1MNWNt3v5+07vL98jQ7SEDH37sY
         MbzM0SBQhhYgZpuY/z2NCAsBS4v+BJ/xEnbSN7Axq0kCWAa79y7aPFHi/kmMj0PizaT1
         a9XKlAFkkDACZCXA04uEUl2HNmTg9eaIZMBmmIGD4Qez8apholVrmNLQL7Ak2DfrBBkp
         8Odg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=P/uMBAFsJSFsMe0s271yKJa7p3nRkmMFxcASFVx3X9s=;
        b=DRfLaprybVqQ+egJ80tX4kPXJe2tldBy57Ky41KnSfNMz65qZoJcCyn1M+neDhV8+F
         GAdDZezi5+Qh2RnivFTMzffXpOIdC68mH+o9n1zhgIrB20B4btvlLki39ijVElvN8nKY
         pfTaQ7UE58j2ZDuwr1G0BB6PofrWxc5OKNMifZLJ2zb/dpRlzDbIN2wPNQHc2pS2tEdN
         3RBi2iW/R2tRjjwcF8khCYPf1YsRdDY8zwjryRutwC5BGRNGZ2XMYgoY9UrWB0ng8N8/
         ZHRYpCJZmUpnUKWE+uVJ9XmfjcZtJh/sNk1s77YOpOuxI7iz5MTaFmOQVrcYTPWMTWnG
         kh6g==
X-Gm-Message-State: AOAM530o9K5/MfzcaFeiFuuiiOAxW+aZo4f5UtmUNElz2lQka9aZnxTf
        5bEb4WVCNVPZyrmK4jhTDV4=
X-Google-Smtp-Source: ABdhPJwyduixaPXyl9nsR8wsh7T30kYdCLoB5U/CwQARqKP0/h/EygceJsHfNzJNv902tkQp43X7rA==
X-Received: by 2002:a63:f50b:: with SMTP id w11mr66510839pgh.157.1594612387120;
        Sun, 12 Jul 2020 20:53:07 -0700 (PDT)
Received: from ?IPv6:2001:470:67:5b9:5dec:e971:4cde:a128? ([2001:470:67:5b9:5dec:e971:4cde:a128])
        by smtp.gmail.com with ESMTPSA id 207sm13052897pfa.100.2020.07.12.20.53.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jul 2020 20:53:06 -0700 (PDT)
Subject: Re: [v2 PATCH] usb: gadget: bdc: use readl_poll_timeout() to simplify
 code
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Felipe Balbi <balbi@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Stephen Boyd <swboyd@chromium.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <1594611017-4535-1-git-send-email-chunfeng.yun@mediatek.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <b73d8a90-96cd-42b5-bbc2-26e300da0603@gmail.com>
Date:   Sun, 12 Jul 2020 20:53:04 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1594611017-4535-1-git-send-email-chunfeng.yun@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/12/2020 8:30 PM, Chunfeng Yun wrote:
> Use readl_poll_timeout() to poll register status
> 
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
> v2 changes, suggested by Stephen:
>   1. use unsigned int instead of int for @usec parameter
>   2. add dev_log() back
>   3. drop "Err" in error log
> ---
>  drivers/usb/gadget/udc/bdc/bdc_core.c | 26 +++++++++++---------------
>  1 file changed, 11 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/usb/gadget/udc/bdc/bdc_core.c b/drivers/usb/gadget/udc/bdc/bdc_core.c
> index 02a3a77..53dccb1 100644
> --- a/drivers/usb/gadget/udc/bdc/bdc_core.c
> +++ b/drivers/usb/gadget/udc/bdc/bdc_core.c
> @@ -12,6 +12,7 @@
>  #include <linux/spinlock.h>
>  #include <linux/platform_device.h>
>  #include <linux/interrupt.h>
> +#include <linux/iopoll.h>
>  #include <linux/ioport.h>
>  #include <linux/io.h>
>  #include <linux/list.h>
> @@ -29,24 +30,19 @@
>  #include "bdc_dbg.h"
>  
>  /* Poll till controller status is not OIP */
> -static int poll_oip(struct bdc *bdc, int usec)
> +static int poll_oip(struct bdc *bdc, u32 usec)
>  {
>  	u32 status;
> -	/* Poll till STS!= OIP */
> -	while (usec) {
> -		status = bdc_readl(bdc->regs, BDC_BDCSC);
> -		if (BDC_CSTS(status) != BDC_OIP) {
> -			dev_dbg(bdc->dev,
> -				"poll_oip complete status=%d",
> -				BDC_CSTS(status));
> -			return 0;
> -		}
> -		udelay(10);
> -		usec -= 10;
> -	}
> -	dev_err(bdc->dev, "Err: operation timedout BDCSC: 0x%08x\n", status);
> +	int ret;
>  
> -	return -ETIMEDOUT;
> +	ret = readl_poll_timeout(bdc->regs + BDC_BDCSC, status,
> +		(BDC_CSTS(status) != BDC_OIP), 10, usec);

You could probably indent this to the opening parenthesis, but with or
without it:

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>

and thanks for picking up the MAINTAINERS file update ;)

> +	if (ret)
> +		dev_err(bdc->dev, "operation timedout BDCSC: 0x%08x\n", status);
> +	else
> +		dev_dbg(bdc->dev, "%s complete status=%d", __func__, BDC_CSTS(status));
> +
> +	return ret;
>  }
>  
>  /* Stop the BDC controller */
> 

-- 
Florian
