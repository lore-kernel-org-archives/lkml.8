Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C1F8C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 13:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A45020760
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 13:25:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XEpFdcXA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729298AbgFJNZG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 09:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726306AbgFJNZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 09:25:06 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE93DC03E96B;
        Wed, 10 Jun 2020 06:25:04 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id 23so1096327pfw.10;
        Wed, 10 Jun 2020 06:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FfKor7U0vt++yfBwrBnYdBw94nHhQ+oK4lCeZS+RVok=;
        b=XEpFdcXAC8lUmQMA4LZKUk42GCEPu5SfwDZhnnY7Y7Dtl0xnoDr692efQjav3p1u87
         jFjcBG+llTAssII/mof+5UneBOC2czmGyke+iuyBGBVSCvRs5/07PHj1aOqf1SX1wTfZ
         JNT1jop4fZ3CUye1QHaF2Q9LA/zBvJj1Tc5FyRG9TubNw0+/OaDFb9XzekeMA1+6B1EI
         tgDCzgz5e/hXEzj6nI9N9pl7Jvo4vC6Y5ny3pIduuDXKrxq0mJ3d/t7hRPlIPXZkq+VI
         es3xe+7Pvdw31WqKY1rsJApoU4Un3DSNruiShcNZfQymGC78W1v4P1jvJz3QQN218aoa
         5GZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=FfKor7U0vt++yfBwrBnYdBw94nHhQ+oK4lCeZS+RVok=;
        b=Ima9Q57fnoz7UennfjDtzqM80n+Y+ShfkV7gONR72mXMW8RkWGMkr0VTyR1XltQp2T
         V3yDNDrJEs2AtCSdg7OJhDp25JI+y0ZFExgUFRnO9F5VKDBlhn2q7C0GVL52r8ZNyBMV
         gAljo9YxCzPHqMAYHJ1ULt7C+bSpoZnAOskLd2dcUPrkygCLvJclQGsKRh+Y4dx6PaAQ
         9rr1PYHA3iolUydlPrpOR/MWyLIub17g5lvFCwC6ME0neH2v3ToXScP4CZTgoJTdOtSs
         aV8xbirChCr4VgZ4nPiWHzbuYrQeEQQ8sL8QwSLEaMTXtNxF/r4U+fqSUiF1Vdq0x9gw
         pH9A==
X-Gm-Message-State: AOAM533nmf70P+wpvY5lgkAxc8KZnNKjtYTduz6z8S0gx9RSgOeJWL4u
        DATM+XjdHM2MSlM5SMK+T8o=
X-Google-Smtp-Source: ABdhPJwIvkk87KsmwR6I07XB8/aAVqDMq5KVoIIQX5CDv3cotSqyh7b9ZM2QPx3gbDvvCbpyEPTHNA==
X-Received: by 2002:a63:ef09:: with SMTP id u9mr2807679pgh.406.1591795504119;
        Wed, 10 Jun 2020 06:25:04 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s197sm13379356pfc.188.2020.06.10.06.25.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Jun 2020 06:25:03 -0700 (PDT)
Date:   Wed, 10 Jun 2020 06:25:01 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Colin King <colin.king@canonical.com>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: i5k_amb: remove redundant assignment to variable
 res
Message-ID: <20200610132501.GA112976@roeck-us.net>
References: <20200610123638.1133428-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200610123638.1133428-1-colin.king@canonical.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 01:36:38PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The variable res is being initialized with a value that is
> never read and it is being updated later with a new value. The
> initialization is redundant and can be removed.
> 
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/i5k_amb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/i5k_amb.c b/drivers/hwmon/i5k_amb.c
> index eeac4b04df27..cd5b62905eee 100644
> --- a/drivers/hwmon/i5k_amb.c
> +++ b/drivers/hwmon/i5k_amb.c
> @@ -396,7 +396,7 @@ static int i5k_amb_hwmon_init(struct platform_device *pdev)
>  
>  static int i5k_amb_add(void)
>  {
> -	int res = -ENODEV;
> +	int res;
>  
>  	/* only ever going to be one of these */
>  	amb_pdev = platform_device_alloc(DRVNAME, 0);
