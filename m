Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66268C33C9E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 03:44:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 364D8206ED
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 03:44:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RaPB4m0S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728229AbgAKDom (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 22:44:42 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36952 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728195AbgAKDom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 22:44:42 -0500
Received: by mail-pg1-f196.google.com with SMTP id q127so1924365pga.4;
        Fri, 10 Jan 2020 19:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mBiYrLLn4CQqHqFn9pLt/flCLBliZAIE+lKCsoDN4Kk=;
        b=RaPB4m0SJKvoQpEvysQzM+L7F2nP/u7HXPlDM40o9usWSCqxYWV1Ebsz7LI9r5SRdp
         XhHnM4S1tV6sNC7R9BqHAgpHppDuQFExDUR2i/jxtgjVu8AognM/OezjEkjPoYRQUh+H
         Dm53KYirKdUSi325d0Dy41lb1FNqiI4XSVX9NJ4wIIrCgFIYWsbiGvZbmkb9EulBSBpV
         QDg0kc1VD1Wt15g7Do3nQZvqCcqZl4hOaadxPzdfZXwXtdyvp6xmUJGstwG9iSB9SUVv
         NZT2yTXFSz9bgNK5DSaxLPLYZA87xTogxAPlrylkDahjrvqiyjhL7ykYwOXxqBORGkkf
         t3Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=mBiYrLLn4CQqHqFn9pLt/flCLBliZAIE+lKCsoDN4Kk=;
        b=cDU20rzbnS5WIwoA9jJr/NJIP8hnOXAC6O/pu1OMQos7TBj40qmBIS5HLuZqY3V3SY
         76UTHJpbQ3eGW81TCsvkr1fzOsEeQklWNU6Rq5reLjgjZ0iO+kia16FvrQO4Htr9oX7W
         Yv8zGqHETs1IdgTBmpMDj8ThukqFjHjbsJAg5hCUxyznMTU2YZqHNNFPohtGpLnKcUmE
         ARaCLMoa/IP3clGoMnAZNo4XFed37OToDsfr1iWiwdsOXSpCDCh8k4QKSm3mdqDPaSTA
         KHkFnL99u+ODmwlsh7dunebDO4JdBvMSQZF/120Srr47zf5IpHrsktFdfqohjiPObccq
         KLHw==
X-Gm-Message-State: APjAAAXojaEMwQ4jQluD5kBe9xPzMI8uMwVrTe+5BxP1/B02ClIe9EW2
        eQVOQR5+bSdjPObt533ZI1hmWhJd
X-Google-Smtp-Source: APXvYqwk/LkaPb8ZgkirwXfmn2pXUg1pTW5ovIJLQVhiUpDHLb6QBgHQxcSuIAXlICZ4Xkf0nlhAUg==
X-Received: by 2002:a63:289:: with SMTP id 131mr8641290pgc.149.1578714281397;
        Fri, 10 Jan 2020 19:44:41 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h11sm4280632pgv.38.2020.01.10.19.44.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 10 Jan 2020 19:44:40 -0800 (PST)
Date:   Fri, 10 Jan 2020 19:44:39 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Jean Delvare <jdelvare@suse.com>,
        "Dr . David Alan Gilbert" <linux@treblig.org>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH -next] hwmon: (w83627ehf) Remove set but not used
 variable 'fan4min'
Message-ID: <20200111034438.GA15669@roeck-us.net>
References: <20200108034514.50130-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200108034514.50130-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 08, 2020 at 03:45:14AM +0000, YueHaibing wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/hwmon/w83627ehf.c: In function 'w83627ehf_check_fan_inputs':
> drivers/hwmon/w83627ehf.c:1296:24: warning:
>  variable 'fan4min' set but not used [-Wunused-but-set-variable]
> 
> commit 62000264cfa8 ("hwmon: (w83627ehf) remove nct6775 and nct6776 support")
> left behind this unused variable.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/w83627ehf.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/hwmon/w83627ehf.c b/drivers/hwmon/w83627ehf.c
> index 5a7239eb1c15..7ffadc2da57b 100644
> --- a/drivers/hwmon/w83627ehf.c
> +++ b/drivers/hwmon/w83627ehf.c
> @@ -1293,7 +1293,7 @@ static void
>  w83627ehf_check_fan_inputs(const struct w83627ehf_sio_data *sio_data,
>  			   struct w83627ehf_data *data)
>  {
> -	int fan3pin, fan4pin, fan4min, fan5pin, regval;
> +	int fan3pin, fan4pin, fan5pin, regval;
>  
>  	/* The W83627UHG is simple, only two fan inputs, no config */
>  	if (sio_data->kind == w83627uhg) {
> @@ -1307,12 +1307,10 @@ w83627ehf_check_fan_inputs(const struct w83627ehf_sio_data *sio_data,
>  		fan3pin = 1;
>  		fan4pin = superio_inb(sio_data->sioreg, 0x27) & 0x40;
>  		fan5pin = superio_inb(sio_data->sioreg, 0x27) & 0x20;
> -		fan4min = fan4pin;
>  	} else {
>  		fan3pin = 1;
>  		fan4pin = !(superio_inb(sio_data->sioreg, 0x29) & 0x06);
>  		fan5pin = !(superio_inb(sio_data->sioreg, 0x24) & 0x02);
> -		fan4min = fan4pin;
>  	}
>  
>  	data->has_fan = data->has_fan_min = 0x03; /* fan1 and fan2 */
