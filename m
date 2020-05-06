Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A915C47256
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28AB720708
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:54:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kI1OL9TG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729841AbgEFPyz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 11:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728991AbgEFPyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 11:54:54 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C169CC061A0F;
        Wed,  6 May 2020 08:54:54 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id a32so1094333pje.5;
        Wed, 06 May 2020 08:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oj5IPbhmqssdAfqNx5StxpYP2G7pyEkKBU7FcMWIgfM=;
        b=kI1OL9TG/f/VjVz1rY/Omul7eFLv44yR2GlyC+qH8ZJEfvnoVW4l+5cCrIwUi0eC3E
         tm5fLsqOWeOxCT9BTLgjfd+vwV5juYEG6ep1lmQRJLSLBtIHvakLQnWUCDdQzj+aOcJy
         zadM5jF/N9AYw2YczAu773y1vJnwadukYOd5t51CydJ4p3/C45X8TFdUJhGWHlFFUsbX
         I0VdRgyk82TJOLMbHe/2LlCX9Lfv68KoYr8Wra7fx+DQzzbAivDT1vmm3oBjvVS+nchs
         xcsWP7jFs2BWLb+P5PxgwblYt/UU71hWo6A59dKYkrHbwI0wPqh5vhWNLyVV7lsZgxbm
         uwNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=oj5IPbhmqssdAfqNx5StxpYP2G7pyEkKBU7FcMWIgfM=;
        b=mnGILTIgeJu2HwQkuEeTb7HCtZ2PLbVmcihJAKZD3TEWmA7xVCwCr81AAHAiCXFoKx
         QwaQue1TxMJPVo+MVqHUR39yIj11U4V+MgXSULV/2dfCfh2sVemt/0SElf2CJUj2kyam
         sqiuouqJ0Qp6VRnY5CNDFjVA62kQGlbZ/CBM6T7d4hvpV71+Q4C99G7lamTYcq4sD/5M
         DAujE4rIuQR+jY9ldjdVOIzCObAH3cYSXZnKj2+3vFXDLE92VuJgMG1RrzURWq9zY9yg
         uqMVbFhaPfkR7SXIG3ywTmrdLcpeaYd+GGW5UAj/HggyJQaOAN6/9aXMdLLbIzwdt8Gd
         jwgA==
X-Gm-Message-State: AGi0PuZjKGFWy/kxH18YS1O0EjleDnDxTQDfNoAjGSHV9WsVSufV45Ro
        Hj2Uov5fPSbrYxfNRaBIO6c=
X-Google-Smtp-Source: APiQypIsJ165wI8qSWOP7w9JHOxs1R4H0GK0DDlrPg/3yM2r+hY5wFT6D2pp1pZUIuiV2g2TVs707w==
X-Received: by 2002:a17:90a:35f0:: with SMTP id r103mr10529961pjb.167.1588780494358;
        Wed, 06 May 2020 08:54:54 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g14sm2199196pfh.49.2020.05.06.08.54.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 May 2020 08:54:53 -0700 (PDT)
Date:   Wed, 6 May 2020 08:54:52 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wolfram Sang <wsa@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH] hwmon: adt7411: update contact email
Message-ID: <20200506155452.GA30343@roeck-us.net>
References: <20200502142700.19254-1-wsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200502142700.19254-1-wsa@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 02, 2020 at 04:27:00PM +0200, Wolfram Sang wrote:
> My 'pengutronix' address is defunct for years. Merge the entries and use
> the proper contact address.
> 
> Signed-off-by: Wolfram Sang <wsa@kernel.org>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/adt7411.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/hwmon/adt7411.c b/drivers/hwmon/adt7411.c
> index c7010b91bc13..5a839cc2ed1c 100644
> --- a/drivers/hwmon/adt7411.c
> +++ b/drivers/hwmon/adt7411.c
> @@ -716,7 +716,6 @@ static struct i2c_driver adt7411_driver = {
>  
>  module_i2c_driver(adt7411_driver);
>  
> -MODULE_AUTHOR("Sascha Hauer <s.hauer@pengutronix.de> and "
> -	"Wolfram Sang <w.sang@pengutronix.de>");
> +MODULE_AUTHOR("Sascha Hauer, Wolfram Sang <kernel@pengutronix.de>");
>  MODULE_DESCRIPTION("ADT7411 driver");
>  MODULE_LICENSE("GPL v2");
