Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD298C761A0
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 23:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9500C208C4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 23:07:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LVlwwu2r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbgBSXH3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 18:07:29 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:33019 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbgBSXH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 18:07:29 -0500
Received: by mail-pj1-f66.google.com with SMTP id m7so532902pjs.0;
        Wed, 19 Feb 2020 15:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=B5o43CHmKfB5WT/Bs5/VID/7xQx6JihjpasEkUB+yOs=;
        b=LVlwwu2rkRP+U/gcnGAWlcNcfA+6JKORjE8/L38OpwdFiGelOmo6w17KS+7ibVNib2
         rEyBcUnyu5fthGLWHrZsPjtnO1icAuRgSCTOSGdE/d0RWlwE/4WiCfTL93rXLjvtmoLs
         RkJ6avsnpFwhyQG9SW2ds6ZwKele4dS+ss1AtZGSc5ODWtSgW7hFCbeRpSIDFMJpX7Nn
         sMRRwSwOMgsqE/4sR4XZQUol5oo/XDaEdeJCSxKPGyubYoYUyh9dXdRWFddflhaIz7tI
         0tEyDjJjpUHCvJMLUlFJdz+NlJTmrYShgBw6Rb/6H8h0YV8WEucnjczz+r0TgP7mAYFQ
         aZdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=B5o43CHmKfB5WT/Bs5/VID/7xQx6JihjpasEkUB+yOs=;
        b=b9xQtNxuer3jjPS33X3Vy85/x8iZfzZr8Q7tGevx40zr4/Pz08iat7ZRSFHdQhKmXE
         i2R4S3Xwx1X2vtklj4zeRqehlPWLD6MoBbhPVH43q1+83J1emduC2AL0HX47uY2H/0mY
         waMeRt0aZ1rW3fmGO1xCa/1wS0Ry7fkk1oa9PSlVAvUNRACvazp0cQA0YCjR3fAoUtV1
         +i89V4L3lR5mA9gkbCv4YZK0YT6Ugcwj7wTtzYjRpqfFTRHrmiAdO4SM1Ta7wqlUkP6B
         6cfX/tF+I92Bfc6WHVSbyATcnGa1vwTFrKoOsIMUJMLtCI26CSPJO5xXKe2hVIxHF3vm
         dPuA==
X-Gm-Message-State: APjAAAUJcBo/Yt6w7CqInmAR8CnYFZCCXa+ccCfPjwqSjYD03VjIeNR6
        dAY0yNzWEKEcoSyoCHrvG/vvnaOE
X-Google-Smtp-Source: APXvYqwpMjAjqEhaKlm6LiE6pYaPBSJevu7vlGaTS9CdaYgi3tTDQegz/tQhdvJCwx8x1LHozv9rEQ==
X-Received: by 2002:a17:902:9a8f:: with SMTP id w15mr29521500plp.30.1582153648341;
        Wed, 19 Feb 2020 15:07:28 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 76sm679118pfx.97.2020.02.19.15.07.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Feb 2020 15:07:27 -0800 (PST)
Date:   Wed, 19 Feb 2020 15:07:27 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Henry Shen <henry.shen@alliedtelesis.co.nz>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        guillaume.ligneul@gmail.com, jdelvare@suse.com, trivial@kernel.org,
        venture@google.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v2 2/2] hwmon: (lm73) Add support for of_match_table
Message-ID: <20200219230726.GA9285@roeck-us.net>
References: <20200212030615.28537-1-henry.shen@alliedtelesis.co.nz>
 <20200212030615.28537-3-henry.shen@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212030615.28537-3-henry.shen@alliedtelesis.co.nz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 04:06:15PM +1300, Henry Shen wrote:
> Add the of_match_table.
> 
> Signed-off-by: Henry Shen <henry.shen@alliedtelesis.co.nz>

Applied to hwmon-next.

Thanks,
Guenter

> ---
> Change in v2:
> - add missing sign-off
> 
>  drivers/hwmon/lm73.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/hwmon/lm73.c b/drivers/hwmon/lm73.c
> index 1eeb9d7de2a0..733c48bf6c98 100644
> --- a/drivers/hwmon/lm73.c
> +++ b/drivers/hwmon/lm73.c
> @@ -262,10 +262,20 @@ static int lm73_detect(struct i2c_client *new_client,
>  	return 0;
>  }
>  
> +static const struct of_device_id lm73_of_match[] = {
> +	{
> +		.compatible = "ti,lm73",
> +	},
> +	{ },
> +};
> +
> +MODULE_DEVICE_TABLE(of, lm73_of_match);
> +
>  static struct i2c_driver lm73_driver = {
>  	.class		= I2C_CLASS_HWMON,
>  	.driver = {
>  		.name	= "lm73",
> +		.of_match_table = lm73_of_match,
>  	},
>  	.probe		= lm73_probe,
>  	.id_table	= lm73_ids,
