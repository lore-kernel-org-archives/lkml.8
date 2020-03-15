Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD6D0C2BB1D
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 13:37:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95562205C9
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 13:37:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KJst+aJu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728632AbgCONht (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 09:37:49 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33495 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbgCONhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 09:37:48 -0400
Received: by mail-pg1-f195.google.com with SMTP id m5so8023283pgg.0;
        Sun, 15 Mar 2020 06:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sGsiabnvYJgDg5bMlZVXSiwfT9aWoEex6cdeiesm9ec=;
        b=KJst+aJutKoD+SX2/hrgjRtvVoJwOraSJcsiJF+SUJura0MEmRNHj3PaKthSwF08SN
         oO28t6Zim6Rt6UBai41Yjc3ENoUmpYUA8qAyCd1FcQRBIdaYlHO2NrIHkYGZD/7R0fdV
         ppc1AA4cl0Jdi+VXaRGctx0YC8cCuveC1FAQtFjogYhlGB6u6F+uES1Oc9VbkKKbkeT4
         agbpE8phexvFDt3UrHmYAT026G468SF+Amqywcgc9vR5CK5aTkHomAwZhXnOY1YtKtFv
         CYyFld0z0ICYhgJ98fEB9FdWYusIxUa4DsL9lO7Hber4We7OK2gO2xGwhtVZIhfcPwaV
         CIEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=sGsiabnvYJgDg5bMlZVXSiwfT9aWoEex6cdeiesm9ec=;
        b=sYlySQzKCdNBgliWwWjx82PNvGfCuOM0FfKxSzzgGFa3QfZewrqn0qJCxcAOww16NT
         pxSi1T3BusEM5ZBrPyt44L7lEMP++uipVQqA2SRA1/ZHVM69szX16G5c9dO4kuPeRXJs
         GB1DX8AVu/O+bAHdFTATfR9Z4+NXpd6qF/M4QOZsU7KKAyvw69zxTjxvpx8mmfrRIJAH
         s8CvjGajqJRoY/cFnqTLJ2oNa4y6GmDO2nGqcFlI03s3kE0uh7zN1jx8PQlTQo5vF9Op
         Hk/hHcItUYfzsDIZquaPPqZPWlRh15nt5jQGI51L8P/NeApYa6pi1IzOdQPmgd8m2C0n
         w+aw==
X-Gm-Message-State: ANhLgQ0jIav2BkGlON3XzrCA0hOtJ4zmDuipjXfXoFF9GGB8sC5OBKdn
        C5a7wk1dKtZ6DpobOnZD4LE=
X-Google-Smtp-Source: ADFU+vuxMefB6GRJAXG9rvoVrO2J5AcWaeJAoVfmHdT5mJVo+eSlzuzIGCH/asMFs7298rzG3SHZ7Q==
X-Received: by 2002:aa7:99c8:: with SMTP id v8mr8166051pfi.151.1584279467732;
        Sun, 15 Mar 2020 06:37:47 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d6sm12744301pfn.214.2020.03.15.06.37.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 15 Mar 2020 06:37:47 -0700 (PDT)
Date:   Sun, 15 Mar 2020 06:37:45 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Amy.Shih@advantech.com.tw
Cc:     she90122@gmail.com, Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        oakley.ding@advantech.com.tw, jia.sui@advantech.com.cn,
        yuechao.zhao@advantech.com.cn
Subject: Re: [v1,1/1] Fix the incorrect quantity for fan & temp attributes.
Message-ID: <20200315133745.GA6049@roeck-us.net>
References: <20200312024934.3533-1-Amy.Shih@advantech.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200312024934.3533-1-Amy.Shih@advantech.com.tw>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 02:49:34AM +0000, Amy.Shih@advantech.com.tw wrote:
> From: Amy Shih <amy.shih@advantech.com.tw>
> 
> nct7904d supports 12 fan tachometers input and 13 temperatures
> (TEMP_CH1~4 and LTD + DTS TCPU1~8), fix the quantity for fan & temp
> attributes.
> 
> Signed-off-by: Amy Shih <amy.shih@advantech.com.tw>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/nct7904.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/drivers/hwmon/nct7904.c b/drivers/hwmon/nct7904.c
> index 281c81e..1f5743d 100644
> --- a/drivers/hwmon/nct7904.c
> +++ b/drivers/hwmon/nct7904.c
> @@ -7,6 +7,11 @@
>   *
>   * Copyright (c) 2019 Advantech
>   * Author: Amy.Shih <amy.shih@advantech.com.tw>
> + *
> + * Supports the following chips:
> + *
> + * Chip        #vin  #fan  #pwm  #temp  #dts  chip ID
> + * nct7904d     20    12    4     5      8    0xc5
>   */
>  
>  #include <linux/module.h>
> @@ -820,6 +825,10 @@ static int nct7904_detect(struct i2c_client *client,
>  			   HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_ALARM,
>  			   HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_ALARM,
>  			   HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_ALARM,
> +			   HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_ALARM,
> +			   HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_ALARM,
> +			   HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_ALARM,
> +			   HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_ALARM,
>  			   HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_ALARM),
>  	HWMON_CHANNEL_INFO(pwm,
>  			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
> @@ -853,6 +862,18 @@ static int nct7904_detect(struct i2c_client *client,
>  			   HWMON_T_CRIT_HYST,
>  			   HWMON_T_INPUT | HWMON_T_ALARM | HWMON_T_MAX |
>  			   HWMON_T_MAX_HYST | HWMON_T_TYPE | HWMON_T_CRIT |
> +			   HWMON_T_CRIT_HYST,
> +			   HWMON_T_INPUT | HWMON_T_ALARM | HWMON_T_MAX |
> +			   HWMON_T_MAX_HYST | HWMON_T_TYPE | HWMON_T_CRIT |
> +			   HWMON_T_CRIT_HYST,
> +			   HWMON_T_INPUT | HWMON_T_ALARM | HWMON_T_MAX |
> +			   HWMON_T_MAX_HYST | HWMON_T_TYPE | HWMON_T_CRIT |
> +			   HWMON_T_CRIT_HYST,
> +			   HWMON_T_INPUT | HWMON_T_ALARM | HWMON_T_MAX |
> +			   HWMON_T_MAX_HYST | HWMON_T_TYPE | HWMON_T_CRIT |
> +			   HWMON_T_CRIT_HYST,
> +			   HWMON_T_INPUT | HWMON_T_ALARM | HWMON_T_MAX |
> +			   HWMON_T_MAX_HYST | HWMON_T_TYPE | HWMON_T_CRIT |
>  			   HWMON_T_CRIT_HYST),
>  	NULL
>  };
