Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FFB7C33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 16:28:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E616D214AF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 16:28:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e9vHwv7y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbgAQQ2I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 11:28:08 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36708 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbgAQQ2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 11:28:08 -0500
Received: by mail-lj1-f195.google.com with SMTP id r19so27071601ljg.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 08:28:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DVtM7Y++Nwm669eZlqu0DoqcWAl43rRW+YNZE3sPUP8=;
        b=e9vHwv7ybLgbij5g6Q2KcM7YsfQ059X6BS9icm/fu8nBElEcJe+yzuu6tQkY7qHm3F
         1IlihmFQkNcL+l13D2z3wH1DrDe+z7yhzxhdhfhTG1x9mJAmP4NXMwsQT9+tQX+ppv5H
         rDvIDbsbHydaOi06Vuia/AwP6GFPw4509i6oo35ik/u6zK88GqrjPAjXPvZfSFDXXM0R
         UD6UD70Q5u5P2TZOCF/pI1hoBkxDZapmEp0UqOkoh5Arevbn8ZJLiFH/e8oOTGhs4RpD
         QUNWnGvX6VnzKrLdN/VBx1wp7IdHQ0pXhPJmY0HK40wBcXqNyg2BHAmLNgsa9DjK8Z90
         DjSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DVtM7Y++Nwm669eZlqu0DoqcWAl43rRW+YNZE3sPUP8=;
        b=HHjTagTnN8YmSfnB/J3HOmsU27J64aMvnlBhUPrw/mWULXQq8P6pZTNdIO3iepE6Vq
         LadlKh1GRYdgENuBBFSOgxGsxetR9YE0voXDsxNDfUJHMcitKxHxhXz0hzw20Rz0kHHU
         HssBCYhoyw9YwGf3mEh1QlxzlcOvXrwtPutJ75nYU8JK8wTMGnAC+2WRQIHqy2UErOO1
         a2udZQSaOnXl/ZI+svkWj2kfGUlYgJgV6aua/FYlvTshbl7Zk/G94vD9hRSPXvpj+Owe
         1YGWG6f2nSCqLFqiVMxWqZKeb3k9svHmXEnRv5FC7z/61pi6MCnd99HHC2GL6aK/jVKm
         JJ4A==
X-Gm-Message-State: APjAAAXgO148JWx/QiTriTAYDt2yPPwXrAtiUAhj48FWZ0uGg9xBol8I
        ZBURbB4nTYRLwefWWrwyNVQ=
X-Google-Smtp-Source: APXvYqyp5l6M071WDmx3fmtCoaBi+oH599+XsaULfk5uqgFdDmoff+Y1TDg5kshBK7FDMsdiieRdFQ==
X-Received: by 2002:a2e:880a:: with SMTP id x10mr6067949ljh.211.1579278486215;
        Fri, 17 Jan 2020 08:28:06 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id g15sm12459368ljn.32.2020.01.17.08.28.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jan 2020 08:28:05 -0800 (PST)
Subject: Re: [PATCH] regulator: vctrl-regulator: Avoid deadlock getting and
 setting the voltage
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Cc:     Collabora Kernel ML <kernel@collabora.com>, drinkcat@chromium.org,
        dianders@chromium.org, Liam Girdwood <lgirdwood@gmail.com>,
        mka@chromium.org
References: <20200116094543.2847321-1-enric.balletbo@collabora.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <1fdaed3c-05e0-4756-5013-5cc59a766e2f@gmail.com>
Date:   Fri, 17 Jan 2020 19:28:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200116094543.2847321-1-enric.balletbo@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

16.01.2020 12:45, Enric Balletbo i Serra пишет:
> `cat /sys/kernel/debug/regulator/regulator_summary` ends on a deadlock
> when you have a voltage controlled regulator (vctrl).
> 
> The problem is that the vctrl_get_voltage() and vctrl_set_voltage() calls the
> regulator_get_voltage() and regulator_set_voltage() and that will try to lock
> again the dependent regulators (the regulator supplying the control voltage).
> 
> Fix the issue by exporting the unlocked version of the regulator_get_voltage()
> and regulator_set_voltage() API so drivers that need it, like the voltage
> controlled regulator driver can use it.
> 
> Fixes: f8702f9e4aa7 ("regulator: core: Use ww_mutex for regulators locking")
> Reported-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> 
>  drivers/regulator/core.c            |  2 ++
>  drivers/regulator/vctrl-regulator.c | 38 +++++++++++++++++------------
>  2 files changed, 25 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
> index 03d79fee2987..e7d167ce326c 100644
> --- a/drivers/regulator/core.c
> +++ b/drivers/regulator/core.c
> @@ -3470,6 +3470,7 @@ int regulator_set_voltage_rdev(struct regulator_dev *rdev, int min_uV,
>  out:
>  	return ret;
>  }
> +EXPORT_SYMBOL(regulator_set_voltage_rdev);
>  
>  static int regulator_limit_voltage_step(struct regulator_dev *rdev,
>  					int *current_uV, int *min_uV)
> @@ -4034,6 +4035,7 @@ int regulator_get_voltage_rdev(struct regulator_dev *rdev)
>  		return ret;
>  	return ret - rdev->constraints->uV_offset;
>  }
> +EXPORT_SYMBOL(regulator_get_voltage_rdev);

I think it should be EXPORT_SYMBOL_GPL().
