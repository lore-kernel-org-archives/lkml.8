Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6389EC3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 21:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3855F20870
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 21:08:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lBTb4pfw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732400AbgCCVI3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 16:08:29 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43438 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732305AbgCCVI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 16:08:28 -0500
Received: by mail-pf1-f195.google.com with SMTP id s1so2097991pfh.10;
        Tue, 03 Mar 2020 13:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tRnA9gsq61Jh7dxXvs0qNF+P6/PxC+dpo1WJdbrhTdo=;
        b=lBTb4pfwS6M6tvdUtTKWO0pk/OE9IsCfEZSx9aXlLwD8oKDjxnafFMfCRwyJrBPuzc
         YAAqsmERKuiJixQKCBp4pxpkHympc07N3kGP+MgW0BQ/ghX/7Svq9ZutY/IwoYZa3e4e
         L3g5o5oLmpZqmCBRLkSyp+GFGtTIO2kKyMTZA+sfONya0SjPQENUh9f2XvyDkLbpeAMV
         kW0k6SYgwMMv4hhXKNlj1SHB9jXalx2NsO1xl2wzHcIckPKwaMIVVOUpvAL8Jd6hmStN
         zr71JcqYl/P4M7vikVzQ5mbHFhxnX6IXrv1nIkK3EKc6KSHfb2S2Ln91D4sJtIf1POkn
         fTUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=tRnA9gsq61Jh7dxXvs0qNF+P6/PxC+dpo1WJdbrhTdo=;
        b=JJt7hH551PMjryxAgPe0UVCBvp2p05UfMi6ChrkpJSiz7XdIANNiFKJ4TdgpPMbkGJ
         gTD0zLD45t7ykcUtk1pL9yAFut1WH0Aw+TQiRjKKkMYLX/LC0p8U9Lo6yJq75w31qBvx
         jPTFlC9ou6JOK/4Il8RyL0CTkkltvqDf7BgckSnsqncqBHt7wgdpvrJn59o9MacLtC0Q
         UtwbNH2MGp6Rr2vhuXYZJbJbGNBR59jKJQtrFeSe8XknrWJomQjLYlBL6XaljMxT59vs
         0VqolOEi293Jp91zRyeZeAVpwkkmbi7hrl8naPwnjiBebU6enFKPbO3up2jpILmdnJlA
         m5fQ==
X-Gm-Message-State: ANhLgQ19k/0/8anqwBIyQvFn6rXO8SEEIWcv3d+UACAZ/OAZHUPiu4Ks
        iwULtPFR1oLcRNjdHaXcjUI=
X-Google-Smtp-Source: ADFU+vs9qw5IJKjsfY9djOC7mpzpIVMRZ3OFGciTJwpjdbqAQKIxUT5j4Tu6zOrWOAI47BsnxM5YXg==
X-Received: by 2002:a62:e111:: with SMTP id q17mr5873943pfh.242.1583269705838;
        Tue, 03 Mar 2020 13:08:25 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id jx10sm122931pjb.33.2020.03.03.13.08.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Mar 2020 13:08:25 -0800 (PST)
Date:   Tue, 3 Mar 2020 13:08:24 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     jdelvare@suse.com, robh+dt@kernel.org, mark.rutland@arm.com,
        logan.shaw@alliedtelesis.co.nz, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 5/5] hwmon: (adt7475) Add support for inverting pwm
 output
Message-ID: <20200303210824.GE14692@roeck-us.net>
References: <20200227084642.7057-1-chris.packham@alliedtelesis.co.nz>
 <20200227084642.7057-6-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200227084642.7057-6-chris.packham@alliedtelesis.co.nz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 09:46:42PM +1300, Chris Packham wrote:
> Add a "adi,pwm-active-state" device-tree property to allow hardware
> designs to use inverted logic on the PWM output.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>

Applied, with change described below. Please let me know if ignoring
the error is not what you wanted.

Thanks,
Guenter

> ---
> 
> Notes:
>     Changes in v5:
>     - change to adi,pwm-active-state
>     - uint32 array
>     
>     Changes in v4:
>     - use vendor prefix for new property
>     
>     Changes in v3:
>     - New
> 
>  drivers/hwmon/adt7475.c | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/drivers/hwmon/adt7475.c b/drivers/hwmon/adt7475.c
> index 3649b18359dc..142a4fec688b 100644
> --- a/drivers/hwmon/adt7475.c
> +++ b/drivers/hwmon/adt7475.c
> @@ -1509,6 +1509,36 @@ static int load_attenuators(const struct i2c_client *client, int chip,
>  	return 0;
>  }
>  
> +static int adt7475_set_pwm_polarity(struct i2c_client *client)
> +{
> +	u32 states[ADT7475_PWM_COUNT];
> +	int ret, i;
> +	u8 val;
> +
> +	ret = of_property_read_u32_array(client->dev.of_node,
> +					 "adi,pwm-active-state", states,
> +					 ARRAY_SIZE(states));
> +	if (ret)
> +		return ret;
> +
> +	for (i = 0; i < ADT7475_PWM_COUNT; i++) {
> +		ret = adt7475_read(PWM_CONFIG_REG(i));
> +		if (ret < 0)
> +			return ret;
> +		val = ret;
> +		if (states[i])
> +			val &= ~BIT(4);
> +		else
> +			val |= BIT(4);
> +
> +		ret = i2c_smbus_write_byte_data(client, PWM_CONFIG_REG(i), val);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
>  static int adt7475_probe(struct i2c_client *client,
>  			 const struct i2c_device_id *id)
>  {
> @@ -1617,6 +1647,10 @@ static int adt7475_probe(struct i2c_client *client,
>  	for (i = 0; i < ADT7475_PWM_COUNT; i++)
>  		adt7475_read_pwm(client, i);
>  
> +	ret = adt7475_set_pwm_polarity(client);
> +	if (ret && ret != -EINVAL)
> +		dev_err(&client->dev, "Error configuring pwm polarity\n");

		dev_err -> dev_warn

> +
>  	/* Start monitoring */
>  	switch (chip) {
>  	case adt7475:
