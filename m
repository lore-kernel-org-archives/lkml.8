Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96513C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 06:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7045E2078C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 06:47:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dyRK1laj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729051AbgE0Grq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 02:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbgE0Grq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 02:47:46 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F3BC061A0F;
        Tue, 26 May 2020 23:47:46 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id nu7so1136913pjb.0;
        Tue, 26 May 2020 23:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=K28VYoUvyBlkL4mV9s61C2RZppqi0asfM7SQP6yThb0=;
        b=dyRK1lajL1LyOG/WQ8b0aoFejbQGQA94a72KQ3ux6mk8Dvd7GE+rZUsFC+0viznFFx
         BZMcsKGg6NuSiR4REOXJGuIoj6dWZtbRXwOI/A5nHBiRFXPQJop86g9r6njMg2H2aI2m
         NlvR0Shr+r/gdcW79lQ8cqhkqb+P3cjMlasghkcW8U0uJ+AsSbH0kKfUcWRvH4sYTeZn
         Ctg+p1PZEbZHcgHEj/m5L6UKwh2pcZ+hDf1ADWpwhohH6vEI7RplLyCdpeB4FzFnqPtn
         TP3FKBrx0MXc9St4EViTcgJGEhtvyhW9y0xVRHrdKrhw+Gn8Or7GeBNXmCh2ScLWZOfd
         ONaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=K28VYoUvyBlkL4mV9s61C2RZppqi0asfM7SQP6yThb0=;
        b=YcnC2iL+Mg16lgDnMEYQvJnzMiV4j02UqGSxoNtXG/xutjotkb7j0XASDf4kd4nOcv
         OI8zap/anUOjsUnkNvFrGDs7IfB3upPLr0A3SYsWLBW2FxNlYsa+jO4+9Kmk9a8prSmC
         L0uqB00l0oZ7VYe1zhh9Y0gIBYi0V1PM2q+LPmUfx60pgpa0N4oR4R1g85wmT6L8TVYW
         q/0kxoH+1QNcYHe659F5kHDuxrC68bgNwlhZhhhjQy2YUorMAfWPpzv5QLi5hN7VcQ1S
         rowJR/imd2gs6q+fgW4YMpllip2yjv6VSxwFi8pDZzpX45kskiHV4Om5hK1Kp+PVDEXe
         rvTg==
X-Gm-Message-State: AOAM533snRbvhy3eHygQb50mYaZNauGUbrd3LS3MiChlEtX4GSrG/akg
        ceY9v59r4+jtA4NkmqzI6Rw=
X-Google-Smtp-Source: ABdhPJxiHENw5vJ+Rw/PRSfSZhwXO1CuZyXNAhwEh4gBcs//Ufg5rAtCnNlhwhv47KNzMVaXBvRbKg==
X-Received: by 2002:a17:90a:9604:: with SMTP id v4mr3289573pjo.198.1590562065732;
        Tue, 26 May 2020 23:47:45 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b15sm1388316pjb.18.2020.05.26.23.47.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 May 2020 23:47:45 -0700 (PDT)
Date:   Tue, 26 May 2020 23:47:43 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     yuechao.zhao@advantech.com.cn
Cc:     345351830@qq.com, amy.shih@advantech.com.tw,
        oakley.ding@advantech.com.tw, jia.sui@advantech.com.cn,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [v3,1/1] hwmon:(nct7904) Set default timeout
Message-ID: <20200527064743.GA10680@roeck-us.net>
References: <1590560219-41328-1-git-send-email-yuechao.zhao@advantech.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1590560219-41328-1-git-send-email-yuechao.zhao@advantech.com.cn>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 06:16:59AM +0000, yuechao.zhao@advantech.com.cn wrote:
> From: Yuechao Zhao <yuechao.zhao@advantech.com.cn>
> 
> The timeout module parameter should not be used for setting the default
> timeout. Because, if you set the timeout = 0, the default timeout will
> be meaningless. And the timeout module parameter of 0 means "no timeout
> module paraameter specified".
> 
> Signed-off-by: Yuechao Zhao <yuechao.zhao@advantech.com.cn>

Applied.

Thanks,
Guenter

> ---
> Change in v3:
> - replace 'static int timeout = WATCHDOG_TIMEOUT;' with 'static int timeout;'
> - fixed typo
> 
> Change in v2:
> - modify subject to 'hwmon:(nct7904) Set default timeout'
> ---
>  drivers/hwmon/nct7904.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hwmon/nct7904.c b/drivers/hwmon/nct7904.c
> index 18c95be..b042569 100644
> --- a/drivers/hwmon/nct7904.c
> +++ b/drivers/hwmon/nct7904.c
> @@ -111,14 +111,14 @@
>  #define MIN_TIMEOUT		(1 * 60)
>  #define MAX_TIMEOUT		(255 * 60)
>  
> -static int timeout = WATCHDOG_TIMEOUT;
> +static int timeout;
>  module_param(timeout, int, 0);
>  MODULE_PARM_DESC(timeout, "Watchdog timeout in minutes. 1 <= timeout <= 255, default="
> -			__MODULE_STRING(WATCHODOG_TIMEOUT) ".");
> +			__MODULE_STRING(WATCHDOG_TIMEOUT) ".");
>  
>  static bool nowayout = WATCHDOG_NOWAYOUT;
>  module_param(nowayout, bool, 0);
> -MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started once started (default="
> +MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
>  			__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
>  
>  static const unsigned short normal_i2c[] = {
> @@ -1147,7 +1147,7 @@ static int nct7904_probe(struct i2c_client *client,
>  	data->wdt.ops = &nct7904_wdt_ops;
>  	data->wdt.info = &nct7904_wdt_info;
>  
> -	data->wdt.timeout = timeout * 60; /* in seconds */
> +	data->wdt.timeout = WATCHDOG_TIMEOUT * 60; /* Set default timeout */
>  	data->wdt.min_timeout = MIN_TIMEOUT;
>  	data->wdt.max_timeout = MAX_TIMEOUT;
>  	data->wdt.parent = &client->dev;
