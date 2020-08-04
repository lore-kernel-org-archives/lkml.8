Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1EDCC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 21:28:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5B0022B45
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 21:28:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p+L9JVoy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbgHDV2T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 17:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbgHDV2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 17:28:19 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E23C06174A;
        Tue,  4 Aug 2020 14:28:19 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id bh1so10954656plb.12;
        Tue, 04 Aug 2020 14:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ggvbd4yb4yZZWZAfp92u/eOPZRUvUZZpx7BWp1lHVnw=;
        b=p+L9JVoyEFAoLRBnXSekOz72MtMLgddZlandkFfEIj5oEcMGGSIsbjNjrIkQ0XgNyC
         IE+iIr2+dejI7VzIoQxHTJk++Bymo3Ki2HNcsC4aCAc4AURiFfC2cnd56pMzC6Tdkyv6
         y/D36mtvVHLOSaJnZmB8BdzVwKp2guOdcVNjVSnjCcgRLJpXZoZRI/70/4VbEhky1v07
         MwQdnWRi7uK+WxxfKlbTWabb945Y5Yq46dSFvxdTK2QdJRS0y2Vu2d8hypj4yETpH/5a
         QpkOW4pEIhArK7ErSAj5E7gS2BqTirQUlRvkBJrHysaq4eUJUqBTmRKHqoCeY+IrcGW+
         BYbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ggvbd4yb4yZZWZAfp92u/eOPZRUvUZZpx7BWp1lHVnw=;
        b=jc52TYuzvqe0IbG4METT4zGl8lOoo5e8++w1e50+OJcCCf3gr8ZdX59RW6blbrCC7N
         P9MVVJor2f+CV53jt1C8dFR+lYXadd/NG00bpZH6Gu6VhP8KVrKZ7BQ+2pMhVyBcOmdK
         kpof9cWrhxLkfdk6221ZMIpbY3u3VKh2C75wqZTt6I6Yd9zBCU5+/3eYfvFWA6VVvh2p
         6idRZMKvbIPZUSdQuS4bySflIcRbGucvhQUA0CyzrXxlSVoBVUO+Y4PaUR4h/G4YaHVK
         ICUBMnuYhFgNgP6Jnwb5pk1lBUDLe/44CrDaq8yOghMcccNzT6j27BHJCLputRuYMHjG
         g0og==
X-Gm-Message-State: AOAM5300GeJCpbznnC4AlaqrrU80WkPm09cFFyyGnXhpRfKJ7nWfutWN
        oZVpgQVKgrllLViA0Lvfek3EPFO+
X-Google-Smtp-Source: ABdhPJx3efPVC6X9dF9EOKcrUStINMOYzkEKonxpnlQDfr4GtOuVHK55NBHklsxL6vGjK4aw5aohTA==
X-Received: by 2002:a17:902:7c03:: with SMTP id x3mr229907pll.178.1596576498609;
        Tue, 04 Aug 2020 14:28:18 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r15sm15849751pfq.189.2020.08.04.14.28.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Aug 2020 14:28:18 -0700 (PDT)
Date:   Tue, 4 Aug 2020 14:28:16 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Roy van Doormaal <roy.van.doormaal@prodrive-technologies.com>
Cc:     linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] hwmon: (adc128d818) Fix advanced configuration register
 init
Message-ID: <20200804212816.GA218922@roeck-us.net>
References: <20200728151846.231785-1-roy.van.doormaal@prodrive-technologies.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200728151846.231785-1-roy.van.doormaal@prodrive-technologies.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 28, 2020 at 05:18:45PM +0200, Roy van Doormaal wrote:
> If the operation mode is non-zero and an external reference voltage is set,
> first the operation mode is written to the advanced configuration register,
> followed by the externel reference enable bit,
> resetting the configuration mode to 0.
> 
> To fix this, first compose the value of the advanced configuration register
> based on the configuration mode and the external reference voltage.
> The advanced configuration register is then written to the device,
> if it is different from the default register value (0x0).
> 
> Signed-off-by: Roy van Doormaal <roy.van.doormaal@prodrive-technologies.com>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/adc128d818.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/hwmon/adc128d818.c b/drivers/hwmon/adc128d818.c
> index f9edec195c35..571d5454c6b2 100644
> --- a/drivers/hwmon/adc128d818.c
> +++ b/drivers/hwmon/adc128d818.c
> @@ -393,6 +393,7 @@ static int adc128_init_client(struct adc128_data *data)
>  {
>  	struct i2c_client *client = data->client;
>  	int err;
> +	u8 regval = 0x0;
>  
>  	/*
>  	 * Reset chip to defaults.
> @@ -403,10 +404,17 @@ static int adc128_init_client(struct adc128_data *data)
>  		return err;
>  
>  	/* Set operation mode, if non-default */
> -	if (data->mode != 0) {
> -		err = i2c_smbus_write_byte_data(client,
> -						ADC128_REG_CONFIG_ADV,
> -						data->mode << 1);
> +	if (data->mode != 0)
> +		regval |= data->mode << 1;
> +
> +	/* If external vref is selected, configure the chip to use it */
> +	if (data->regulator)
> +		regval |= 0x01;
> +
> +	/* Write advanced configuration register */
> +	if (regval != 0x0) {
> +		err = i2c_smbus_write_byte_data(client, ADC128_REG_CONFIG_ADV,
> +						regval);
>  		if (err)
>  			return err;
>  	}
> @@ -416,14 +424,6 @@ static int adc128_init_client(struct adc128_data *data)
>  	if (err)
>  		return err;
>  
> -	/* If external vref is selected, configure the chip to use it */
> -	if (data->regulator) {
> -		err = i2c_smbus_write_byte_data(client,
> -						ADC128_REG_CONFIG_ADV, 0x01);
> -		if (err)
> -			return err;
> -	}
> -
>  	return 0;
>  }
>  
