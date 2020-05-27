Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B838C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 05:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 474782078C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 05:02:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Plwh6gvE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbgE0FCz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 01:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725294AbgE0FCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 01:02:55 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F57C061A0F;
        Tue, 26 May 2020 22:02:53 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id e11so10355197pfn.3;
        Tue, 26 May 2020 22:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8bElIwlLcxBa2p2mrgEjCxqLeCmJ7w/ViW/yu1ziFkI=;
        b=Plwh6gvE6jlUISumm8BdAcJCoeOeJ2vAjCnRsBDuAZIztQFMvNCQQDFPfsxhtcvpjl
         hk3/dFwajdYGna1ns3GnblTHNzPKfKaxnAI9qLS+a7YKUxSbcmJcVFZ7NpMgc4pa6LfQ
         YeHoF24i/65mmgNlHXca2PsC199Khjc/Oia7RiREptp34cgrGrmZ5zHiKRFRLvVVn8Pu
         6XilIV5ItpOK6WpQp8SHLueTiUnEfnJjmizFkX/YlBqSqmyoYvTVhu26xeEOaTcMXtnh
         wO5C3zPpPwA3EIMlNgItzLbOfrosfBBZ2TGZNGwnsjTDUx9mL1C4clkNcej4HSVAZ9G9
         udAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=8bElIwlLcxBa2p2mrgEjCxqLeCmJ7w/ViW/yu1ziFkI=;
        b=WltRsI625RwOHNJktfJtjQIqh81AZnJX4QmhpPsw7p+TDZxq3EmNt5j0YkQc5B6Iiw
         jv21s3nim30VBN9QJuwsyMfBGoK2Kzu2OoZ90it6y1MuEIvBpXKHdqKNStQZ/UrKWjm9
         vdtaN8z3Af9qiB8gX7pkE4+52x1J5/plptxcOEwiUwJczRFAsYrtqFHD0X95T/GxE/9g
         xTT301tm1oK4OwYszPZ9IuMhy32C/dsmO/GmOaL1R908xj/wd+AhSrPAkxYtoNo5Ecxm
         T0Kqn5bSoRW1kvYsSOfu5K0S7gy/PwDKHnElF1q83ZGbTdYDb6YMJX/rGisgPNXxX9NO
         MS8Q==
X-Gm-Message-State: AOAM531zYP4Ke1Pa/Vk9IdpKs7v2cfOatJ72qPr1LLKQW7hMGmY0wYH0
        jWHk3R+DyDJJWEH+BPgwv+LRl7NS
X-Google-Smtp-Source: ABdhPJxBico4qWwpg7T0HEo+UNDwXk04rtGI8RuIzXV3fy7oL01zGsDTtOpJD7NP2UyFo9qODzYkBQ==
X-Received: by 2002:a63:4c0b:: with SMTP id z11mr2300834pga.348.1590555773430;
        Tue, 26 May 2020 22:02:53 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m15sm1006382pgv.45.2020.05.26.22.02.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 May 2020 22:02:53 -0700 (PDT)
Date:   Tue, 26 May 2020 22:02:52 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     yuechao.zhao@advantech.com.cn
Cc:     345351830@qq.com, amy.shih@advantech.com.tw,
        oakley.ding@advantech.com.tw, jia.sui@advantech.com.cn,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [v2,1/1] hwmon:(nct7904) Set default timeout
Message-ID: <20200527050252.GA2934@roeck-us.net>
References: <1590551390-40177-1-git-send-email-yuechao.zhao@advantech.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1590551390-40177-1-git-send-email-yuechao.zhao@advantech.com.cn>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 03:49:50AM +0000, yuechao.zhao@advantech.com.cn wrote:
> From: Yuechao Zhao <yuechao.zhao@advantech.com.cn>
> 
> The timeout module parameter should not be used for setting the default
> timeout. Because, if you set the timeout = 0, the default timeout will
> be meaningless. And the timeout module parameter of 0 means "no timeout
> module paraameter specified".
> 
> Signed-off-by: Yuechao Zhao <yuechao.zhao@advantech.com.cn>

You should also replace

static int timeout = WATCHDOG_TIMEOUT;

with

static int timeout;

to ensure that the module parameter is only evaluated if it is actually
set. Otherwise your patch has no real impact except if someone explicitly
specifies a timeout parameter of 0 which doesn't really make much sense.

Thanks,
Guenter

> ---
> - modify subject to 'hwmon:(nct7904) Set default timeout'
> ---
>  drivers/hwmon/nct7904.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/nct7904.c b/drivers/hwmon/nct7904.c
> index 18c95be..27eb276 100644
> --- a/drivers/hwmon/nct7904.c
> +++ b/drivers/hwmon/nct7904.c
> @@ -1147,7 +1147,7 @@ static int nct7904_probe(struct i2c_client *client,
>  	data->wdt.ops = &nct7904_wdt_ops;
>  	data->wdt.info = &nct7904_wdt_info;
>  
> -	data->wdt.timeout = timeout * 60; /* in seconds */
> +	data->wdt.timeout = WATCHDOG_TIMEOUT * 60; /* Set default timeout */
>  	data->wdt.min_timeout = MIN_TIMEOUT;
>  	data->wdt.max_timeout = MAX_TIMEOUT;
>  	data->wdt.parent = &client->dev;
> -- 
> 1.8.3.1
> 
