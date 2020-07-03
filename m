Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A7CFC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 22:17:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9C3B208C7
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 22:17:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M/toDlrR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbgGCWRr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 18:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726188AbgGCWRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 18:17:47 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D98C061794;
        Fri,  3 Jul 2020 15:17:46 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id a9so3938883pjh.5;
        Fri, 03 Jul 2020 15:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sejNlP1ktqM/yqhWQBlfvEYEbrTSoZNaZ4fFsOcMXyo=;
        b=M/toDlrRcsBGClLXYYdtDWkvG3zMdTI3iAiO+yGwHaD7RuH8ssfG3JkLAjRNJ3GOgL
         emfRB5ok5rhARi30EPkLIJcne0S6+vyf89L+daajIxm+3jV32o1nm7IMWZ/2BXs17A+p
         ppSQXeUl+n57RSdqkEiPjuzk+ER8PF5bE8YfGaknJwHPyseEYDYisKCkHmRlQDZOnsGL
         8K8+SmPmDePzNISqaV0VptSe623mvWiiMHkXcNeuetOL1zOFL0SZe5EzlKSLuy1Dls1m
         hyKXBzq0ZbT6WFWRlmi0TVHcdRVB8zcnl2+L7kP7RXrRg8E8mti3kbXcTke3CVrClKei
         QYwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=sejNlP1ktqM/yqhWQBlfvEYEbrTSoZNaZ4fFsOcMXyo=;
        b=rIJKZtU6M1VQR4+ENI/8M+nELVzQo5CdtptW6zihiRlw1s3jToKiRjvYCfhT0o6N0d
         QYVuRfDWCMFXoApawpWQpKeEnhuSgky3YX1Qc3rZANJ2UMwwObZPD1oNlD52xOfA+XkJ
         dW3+lcmXTTULrCUK0pLj0IptEP7dhRwwL4gQU25QEw/Xb7igapM/fy1xgE8XB/xFhCDw
         S4JsuxsRYqSPHksZHpOZbcyK5MA50TUj4hT9epehv6GQSGXCmicsNenMx1NNgFxi16YK
         08Z1B3bwc2P3HyQEY6bO/WjIuI0Kwz53eCon9ajnatFZMO34eAPrkbNDK2/aoeMDiQQ+
         9aOQ==
X-Gm-Message-State: AOAM5330dq6pDoRykj5Dr3PnX8Um7XKX6DPhMdqgNmhq3p75r4pESdPU
        9GDKZeQQhLq6tSLHLmksV8zVk6nWOYQ=
X-Google-Smtp-Source: ABdhPJwd/f3TDfBVQj4VriwSYuAQ/lXojI58EaxlEBXVyYKB7TscoLWXYlzy0uHffDXMh89/mAefyQ==
X-Received: by 2002:a17:90a:718b:: with SMTP id i11mr37047631pjk.150.1593814665429;
        Fri, 03 Jul 2020 15:17:45 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k2sm12728448pgm.11.2020.07.03.15.17.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 Jul 2020 15:17:45 -0700 (PDT)
Date:   Fri, 3 Jul 2020 15:17:44 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Evgeny Novikov <novikov@ispras.ru>
Cc:     Jean Delvare <jdelvare@suse.com>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, linux-hwmon@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
Subject: Re: [PATCH] hwmon: (aspeed-pwm-tacho) Avoid possible buffer overflow
Message-ID: <20200703221744.GA34644@roeck-us.net>
References: <20200703111518.9644-1-novikov@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200703111518.9644-1-novikov@ispras.ru>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 03, 2020 at 02:15:18PM +0300, Evgeny Novikov wrote:
> aspeed_create_fan() reads a pwm_port value using of_property_read_u32().
> If pwm_port will be more than ARRAY_SIZE(pwm_port_params), there will be
> a buffer overflow in
> aspeed_create_pwm_port()->aspeed_set_pwm_port_enable(). The patch fixes
> the potential buffer overflow.
> 
> Found by Linux Driver Verification project (linuxtesting.org).
> 
> Signed-off-by: Evgeny Novikov <novikov@ispras.ru>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/aspeed-pwm-tacho.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/hwmon/aspeed-pwm-tacho.c b/drivers/hwmon/aspeed-pwm-tacho.c
> index 33fb54845bf6..3d8239fd66ed 100644
> --- a/drivers/hwmon/aspeed-pwm-tacho.c
> +++ b/drivers/hwmon/aspeed-pwm-tacho.c
> @@ -851,6 +851,8 @@ static int aspeed_create_fan(struct device *dev,
>  	ret = of_property_read_u32(child, "reg", &pwm_port);
>  	if (ret)
>  		return ret;
> +	if (pwm_port >= ARRAY_SIZE(pwm_port_params))
> +		return -EINVAL;
>  	aspeed_create_pwm_port(priv, (u8)pwm_port);
>  
>  	ret = of_property_count_u8_elems(child, "cooling-levels");
