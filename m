Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FFCBC4332D
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 22:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A8F320739
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 22:09:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="atBoSCjd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728144AbgCUWJr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 18:09:47 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41029 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728044AbgCUWJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 18:09:46 -0400
Received: by mail-pf1-f193.google.com with SMTP id z65so5348238pfz.8;
        Sat, 21 Mar 2020 15:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IdqBWeqHBM2VQM72lf3mMQkySbvn1pz4kfLceH613LQ=;
        b=atBoSCjdwsyBtICaMtOyo3vvMc4lWzmKQggLXhOUC9+jkqhcro/mNjiH+ZLwEyHU2t
         f8oz2ir1JpmkgvyqIQHicKDvTcN/8SVxg4FszL+woYHq/DbGFavjLQFQKzhkqwLs5MJL
         nFETrufVqYlK+Xkzn1AKryz0A/YV8NiWd+ZDAhLihD9XiLGk9g6vK0EtPJXLvT9B4/WI
         Oz9vAFWWIIvSoGsI2ehG4R7yhqEGLPPwWv36CIwVn+kS0IReVwqJGD1nfA2XqPSiF240
         sp5r3NiI+psSSarZvbYxwtjGot15IwkJwtpqcnYBAiF6dttrj2AeHuClMWCSx4pRoY+4
         UQ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=IdqBWeqHBM2VQM72lf3mMQkySbvn1pz4kfLceH613LQ=;
        b=oKeMM5JnzDbLcnmA0mh62aqBsAPrkB2o9p4RZs38FHJ3V+h/wzZ6l+DtgoDbnE6tMz
         Ue+s9aRWfFahJQD0Ob8zKYVzD5WRS3qPzauAuaEvIXBEyH+anMQSZNI4/amxq4LbChyS
         j2LEKua1QwcnpkscR5jVNoz/T2W+ofU8tpWnaxzGFkkN43zogGZCpy0TDzXe046MZ//N
         r8P7Q0H/yko5U2JwJJkzAU4vr/tbjII8/6RodZJfNrTWwinKoXCJKfigCiw0tOdpNulz
         1TCvLV7Y1z3ClowS70FNtRCKJiX7fhHu6sa+1J0t1jaeCQlNAx8Y+kgJgYeYRQMCYC3r
         KSlg==
X-Gm-Message-State: ANhLgQ1cyiCAVYL9h31cKeylz8oMTGRBC7SV5b2uD6d/bTxu61Ot4qE0
        UdmXuhizGi4VvhEe6gkbCLK39lbZ
X-Google-Smtp-Source: ADFU+vskwW1mk/P5nLozrqpgjggfa/69haqZYHIPH+FYRReyIfqaR7sQo4kTb6sb3r+RzyLscr+Icw==
X-Received: by 2002:a62:a515:: with SMTP id v21mr16594280pfm.128.1584828585601;
        Sat, 21 Mar 2020 15:09:45 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u14sm8383748pgg.67.2020.03.21.15.09.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 21 Mar 2020 15:09:44 -0700 (PDT)
Date:   Sat, 21 Mar 2020 15:09:43 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Grant Peltier <grantpeltier93@gmail.com>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        adam.vaughn.xh@renesas.com
Subject: Re: [PATCH v3 1/2] hwmon: (pmbus) add support for 2nd Gen Renesas
 digital multiphase
Message-ID: <20200321220943.GA22233@roeck-us.net>
References: <cover.1584720563.git.grantpeltier93@gmail.com>
 <62c000adf0108aeb65d3f275f28eb26b690384aa.1584720563.git.grantpeltier93@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62c000adf0108aeb65d3f275f28eb26b690384aa.1584720563.git.grantpeltier93@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 20, 2020 at 11:16:21AM -0500, Grant Peltier wrote:
> Extend the isl68137 driver to provide support for 2nd generation Renesas
> digital multiphase voltage regulators.
> 
> Signed-off-by: Grant Peltier <grantpeltier93@gmail.com>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/pmbus/Kconfig    |   6 +-
>  drivers/hwmon/pmbus/isl68137.c | 110 ++++++++++++++++++++++++++++-----
>  2 files changed, 98 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
> index a9ea06204767..1e3e5a61ed9c 100644
> --- a/drivers/hwmon/pmbus/Kconfig
> +++ b/drivers/hwmon/pmbus/Kconfig
> @@ -92,10 +92,10 @@ config SENSORS_IRPS5401
>  	  be called irps5401.
>  
>  config SENSORS_ISL68137
> -	tristate "Intersil ISL68137"
> +	tristate "Renesas Digital Multiphase Voltage Regulators"
>  	help
> -	  If you say yes here you get hardware monitoring support for Intersil
> -	  ISL68137.
> +	  If you say yes here you get hardware monitoring support for Renesas
> +	  digital multiphase voltage regulators.
>  
>  	  This driver can also be built as a module. If so, the module will
>  	  be called isl68137.
> diff --git a/drivers/hwmon/pmbus/isl68137.c b/drivers/hwmon/pmbus/isl68137.c
> index 515596c92fe1..47f6cce1da58 100644
> --- a/drivers/hwmon/pmbus/isl68137.c
> +++ b/drivers/hwmon/pmbus/isl68137.c
> @@ -1,8 +1,9 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
> - * Hardware monitoring driver for Intersil ISL68137
> + * Hardware monitoring driver for Renesas Digital Multiphase Voltage Regulators
>   *
>   * Copyright (c) 2017 Google Inc
> + * Copyright (c) 2020 Renesas Electronics America
>   *
>   */
>  
> @@ -14,9 +15,19 @@
>  #include <linux/module.h>
>  #include <linux/string.h>
>  #include <linux/sysfs.h>
> +
>  #include "pmbus.h"
>  
>  #define ISL68137_VOUT_AVS	0x30
> +#define RAA_DMPVR2_READ_VMON	0xc8
> +
> +enum versions {
> +	isl68137,
> +	raa_dmpvr2_1rail,
> +	raa_dmpvr2_2rail,
> +	raa_dmpvr2_3rail,
> +	raa_dmpvr2_hv,
> +};
>  
>  static ssize_t isl68137_avs_enable_show_page(struct i2c_client *client,
>  					     int page,
> @@ -98,13 +109,30 @@ static const struct attribute_group enable_group = {
>  	.attrs = enable_attrs,
>  };
>  
> -static const struct attribute_group *attribute_groups[] = {
> +static const struct attribute_group *isl68137_attribute_groups[] = {
>  	&enable_group,
>  	NULL,
>  };
>  
> -static struct pmbus_driver_info isl68137_info = {
> -	.pages = 2,
> +static int raa_dmpvr2_read_word_data(struct i2c_client *client, int page,
> +				     int reg)
> +{
> +	int ret;
> +
> +	switch (reg) {
> +	case PMBUS_VIRT_READ_VMON:
> +		ret = pmbus_read_word_data(client, page, RAA_DMPVR2_READ_VMON);
> +		break;
> +	default:
> +		ret = -ENODATA;
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +static struct pmbus_driver_info raa_dmpvr_info = {
> +	.pages = 3,
>  	.format[PSC_VOLTAGE_IN] = direct,
>  	.format[PSC_VOLTAGE_OUT] = direct,
>  	.format[PSC_CURRENT_IN] = direct,
> @@ -113,7 +141,7 @@ static struct pmbus_driver_info isl68137_info = {
>  	.format[PSC_TEMPERATURE] = direct,
>  	.m[PSC_VOLTAGE_IN] = 1,
>  	.b[PSC_VOLTAGE_IN] = 0,
> -	.R[PSC_VOLTAGE_IN] = 3,
> +	.R[PSC_VOLTAGE_IN] = 2,
>  	.m[PSC_VOLTAGE_OUT] = 1,
>  	.b[PSC_VOLTAGE_OUT] = 0,
>  	.R[PSC_VOLTAGE_OUT] = 3,
> @@ -133,24 +161,76 @@ static struct pmbus_driver_info isl68137_info = {
>  	    | PMBUS_HAVE_STATUS_INPUT | PMBUS_HAVE_TEMP | PMBUS_HAVE_TEMP2
>  	    | PMBUS_HAVE_TEMP3 | PMBUS_HAVE_STATUS_TEMP
>  	    | PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT
> -	    | PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT | PMBUS_HAVE_POUT,
> -	.func[1] = PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT
> -	    | PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT | PMBUS_HAVE_POUT,
> -	.groups = attribute_groups,
> +	    | PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT | PMBUS_HAVE_POUT
> +		| PMBUS_HAVE_VMON,
> +	.func[1] = PMBUS_HAVE_IIN | PMBUS_HAVE_PIN | PMBUS_HAVE_STATUS_INPUT
> +	    | PMBUS_HAVE_TEMP | PMBUS_HAVE_TEMP3 | PMBUS_HAVE_STATUS_TEMP
> +	    | PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT | PMBUS_HAVE_IOUT
> +	    | PMBUS_HAVE_STATUS_IOUT | PMBUS_HAVE_POUT,
> +	.func[2] = PMBUS_HAVE_IIN | PMBUS_HAVE_PIN | PMBUS_HAVE_STATUS_INPUT
> +	    | PMBUS_HAVE_TEMP | PMBUS_HAVE_TEMP3 | PMBUS_HAVE_STATUS_TEMP
> +	    | PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT | PMBUS_HAVE_IOUT
> +	    | PMBUS_HAVE_STATUS_IOUT | PMBUS_HAVE_POUT,
>  };
>  
>  static int isl68137_probe(struct i2c_client *client,
>  			  const struct i2c_device_id *id)
>  {
> -	return pmbus_do_probe(client, id, &isl68137_info);
> +	struct pmbus_driver_info *info;
> +
> +	info = devm_kzalloc(&client->dev, sizeof(*info), GFP_KERNEL);
> +	if (!info)
> +		return -ENOMEM;
> +	memcpy(info, &raa_dmpvr_info, sizeof(*info));
> +
> +	switch (id->driver_data) {
> +	case isl68137:
> +		info->pages = 2;
> +		info->R[PSC_VOLTAGE_IN] = 3;
> +		info->func[0] &= ~PMBUS_HAVE_VMON;
> +		info->func[1] = PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT
> +		    | PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT
> +		    | PMBUS_HAVE_POUT;
> +		info->groups = isl68137_attribute_groups;
> +		break;
> +	case raa_dmpvr2_1rail:
> +		info->pages = 1;
> +		info->read_word_data = raa_dmpvr2_read_word_data;
> +		break;
> +	case raa_dmpvr2_2rail:
> +		info->pages = 2;
> +		info->read_word_data = raa_dmpvr2_read_word_data;
> +		break;
> +	case raa_dmpvr2_3rail:
> +		info->read_word_data = raa_dmpvr2_read_word_data;
> +		break;
> +	case raa_dmpvr2_hv:
> +		info->pages = 1;
> +		info->R[PSC_VOLTAGE_IN] = 1;
> +		info->m[PSC_VOLTAGE_OUT] = 2;
> +		info->R[PSC_VOLTAGE_OUT] = 2;
> +		info->m[PSC_CURRENT_IN] = 2;
> +		info->m[PSC_POWER] = 2;
> +		info->R[PSC_POWER] = -1;
> +		info->read_word_data = raa_dmpvr2_read_word_data;
> +		break;
> +	default:
> +		return -ENODEV;
> +	}
> +
> +	return pmbus_do_probe(client, id, info);
>  }
>  
> -static const struct i2c_device_id isl68137_id[] = {
> -	{"isl68137", 0},
> +static const struct i2c_device_id raa_dmpvr_id[] = {
> +	{"isl68137", isl68137},
> +	{"raa_dmpvr2_1rail", raa_dmpvr2_1rail},
> +	{"raa_dmpvr2_2rail", raa_dmpvr2_2rail},
> +	{"raa_dmpvr2_3rail", raa_dmpvr2_3rail},
> +	{"raa_dmpvr2_hv", raa_dmpvr2_hv},
>  	{}
>  };
>  
> -MODULE_DEVICE_TABLE(i2c, isl68137_id);
> +MODULE_DEVICE_TABLE(i2c, raa_dmpvr_id);
>  
>  /* This is the driver that will be inserted */
>  static struct i2c_driver isl68137_driver = {
> @@ -159,11 +239,11 @@ static struct i2c_driver isl68137_driver = {
>  		   },
>  	.probe = isl68137_probe,
>  	.remove = pmbus_do_remove,
> -	.id_table = isl68137_id,
> +	.id_table = raa_dmpvr_id,
>  };
>  
>  module_i2c_driver(isl68137_driver);
>  
>  MODULE_AUTHOR("Maxim Sloyko <maxims@google.com>");
> -MODULE_DESCRIPTION("PMBus driver for Intersil ISL68137");
> +MODULE_DESCRIPTION("PMBus driver for Renesas digital multiphase voltage regulators");
>  MODULE_LICENSE("GPL");
