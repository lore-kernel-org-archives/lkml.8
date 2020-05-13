Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FAKE_REPLY_C,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D01D6C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 15:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBB01207EA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 15:24:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LUpFchK3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730938AbgEMPYy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 11:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729327AbgEMPYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 11:24:53 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07118C061A0C;
        Wed, 13 May 2020 08:24:52 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id f23so7258252pgj.4;
        Wed, 13 May 2020 08:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=6pqylq2mJRRnJ3OtxMfBq/4+9IHb3bQWs5VJmb4jLzY=;
        b=LUpFchK32Wa2yszb+R5OWeNH8gD9nXMD7q9arCOmbctL5fddILmYhw+QDmubHFnDB8
         f4kH4c3tdymhUtid6EZvyKn1K5gQoGI1v7isgXokRN2S0SenPFpsANSdVG/SSuhV7k5U
         vs/LEhgPaDXkvvbRhpL8EGuKlMv2f3yBu0ehdrrOHh7nAKDR8vR3YrLG/BPwjPuZDGHl
         ndDoLrcBtyjlpT+76rddkAGnGak45h6QaAXbJK455zOMAxQ7Kc6xGVH1zTwdl2goe7V9
         kpxN2LSUnW5d1KmZJoDw92vgrzmYwTvskkd0TD4oF43Nnk+PKLxW63Y7FLviM+36byyA
         4k0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=6pqylq2mJRRnJ3OtxMfBq/4+9IHb3bQWs5VJmb4jLzY=;
        b=HwWdB9lV1m09UZ4VNrzmgbKCuP+sNqBn4qfueVpLtKBi8yd8Rc8CmXmPzR5uzP0mWm
         fvgy/jAhTcxrPgR7FfGBkumyH9LWSgFawPwR0/J8qGMiB0rC4cBtuheyHDB0Udvddb5j
         Zlc3xJz79CkLYlEgU5Q0G/Wjsp0MdTLqoUtl6TSKrsIv26mIMtV8lGce0R7UjnaHukbo
         xf+rARcPhhF2Z5oeOhhuCdNA+DV3vE7BSs1ajEd1E0K/lEZl//FTRSwhNkRp+OBjRwRo
         vDywU4G33IjzrMVyyK0DKihWOXh1h7OsSo4COSB7W3DKePyZINrVWXr/7aUtWEmQoh/9
         063w==
X-Gm-Message-State: AOAM530aH1Y/sSLrmL0k5UsV0zqi10sxD4mWS9dDse1WlMg7DKda/cuY
        jL7Eivfj9D4H/9zgdQ6l1Ig=
X-Google-Smtp-Source: ABdhPJydcRkZCD7kK2hsZCNxScAagHKMAeqZ7bDH7QsAVgAHqQc2ZgcR17gnP7KU0nG1QdYVuEWadA==
X-Received: by 2002:a65:6790:: with SMTP id e16mr6762655pgr.145.1589383491661;
        Wed, 13 May 2020 08:24:51 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j5sm16256111pjf.0.2020.05.13.08.24.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 May 2020 08:24:51 -0700 (PDT)
Date:   Wed, 13 May 2020 08:24:50 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     yuechao.zhao@advantech.com.cn
Cc:     345351830@qq.com, amy.shih@advantech.com.tw,
        oakley.ding@advantech.com.tw, jia.sui@advantech.com.cn,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [v1,1/1] watchdog: (nct7904) Fix enable watchdog incorrectly
Message-ID: <20200513152450.GA180616@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 11:00:15AM +0000, yuechao.zhao@advantech.com.cn wrote:
> From: Yuechao Zhao <yuechao.zhao@advantech.com.cn>
> 
> Use incorrect register to enable watchdog in nct7904_wdt_ping()
> 
> Signed-off-by: Yuechao Zhao <yuechao.zhao@advantech.com.cn>

I merged this patch into the patch introducing watchdog support.

Thanks,
Guenter

> ---
>  drivers/hwmon/nct7904.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/nct7904.c b/drivers/hwmon/nct7904.c
> index 04f2a8e..18c95be 100644
> --- a/drivers/hwmon/nct7904.c
> +++ b/drivers/hwmon/nct7904.c
> @@ -979,7 +979,7 @@ static int nct7904_wdt_ping(struct watchdog_device *wdt)
>  		return ret;
>  
>  	/* Enable soft watchdog timer */
> -	return nct7904_write_reg(data, BANK_0, WDT_TIMER_REG, WDT_SOFT_EN);
> +	return nct7904_write_reg(data, BANK_0, WDT_LOCK_REG, WDT_SOFT_EN);
>  }
>  
>  static unsigned int nct7904_wdt_get_timeleft(struct watchdog_device *wdt)
> -- 
> 1.8.3.1
> 
