Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 780AEC3F2D1
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 21:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4591A20728
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 21:05:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mk/ruRGm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732303AbgCCVFN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 16:05:13 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42080 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729880AbgCCVFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 16:05:12 -0500
Received: by mail-pg1-f194.google.com with SMTP id h8so2105425pgs.9;
        Tue, 03 Mar 2020 13:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Z2bljJyUKfKbXAwz+ZeHKNu8pqLfKGwQsLSAZQwgS/c=;
        b=Mk/ruRGmSOD7Z888pX93JazWTB+QzZPeVYhvVyYiAIEUD8ME9drxtADOHe1YR8Kqnf
         zLxHWPXh/h1M3Iz0DR2B6zI3e0lJJ8KVsF5wTa33UK244qfSv+g8qI2Arq0y/vTntYGw
         j3/uz7VwTOOScGwN6c41m7cSSCqXsVcejbBximPhJlZETBAFOFZuItGZO4otOwPX1FsU
         3ngCtX3culCDthejh05gf69lD/FnQN4Lsvki4czxjFmSdBxvlQaQgeV4BPPysslyKl93
         y0kyWNaRiaXSjxDtSyikhKxWkinmeAur0vkCCny+ic2oQ3rmfiHhEcJhJO0R4HHnqLpq
         ghzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Z2bljJyUKfKbXAwz+ZeHKNu8pqLfKGwQsLSAZQwgS/c=;
        b=nDt1EBQPcz6y2ywDjoH1ZuX3mGIOty0Fh7k4mVZuJoB+/+4zAsbR/7hg2gl5ujn/Wc
         NfKD3OJHzdK/YQGhBsndAlsxVQ5o/VYiOX02GWHOEp3QeF7gKb0jX3n5DNdjsjopQ+0j
         Mgoo2s+fNXOX3rjU5t2txjmDnYlXFIRx2pMUN6SyzORJsZ+dZwD0p+9qQoZmQXumWsXs
         QtT6mX8PfiM5D1GKslQjzTEErGrApWcnLC4iv9R+5Ow2ej4PBGTz+KF1KOCB/2b8/LcF
         9wiS5Fe/ZRKraTVLtlzXfDrpTSLgl9QjLlDcv+jGSfL5sym6h/QxSnnvNC17Gmp0hy6f
         YuIw==
X-Gm-Message-State: ANhLgQ2qlJtDF2FIjkNiWkXd+JrJSvV6CNxfinR+oapB0KghBvAMXdgS
        XvMX02QgRGWjqmrj2obmtrU=
X-Google-Smtp-Source: ADFU+vtZ82hL5/NHxNqLRKZHWqxFctDV/Jfsx6om7eB1Bt9n27ByyHqbVv4s0a6nQN6hJz9kGTFuFA==
X-Received: by 2002:a62:7594:: with SMTP id q142mr6253626pfc.130.1583269510846;
        Tue, 03 Mar 2020 13:05:10 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c15sm124753pja.30.2020.03.03.13.05.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Mar 2020 13:05:09 -0800 (PST)
Date:   Tue, 3 Mar 2020 13:05:08 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     jdelvare@suse.com, robh+dt@kernel.org, mark.rutland@arm.com,
        logan.shaw@alliedtelesis.co.nz, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/5] hwmon: (adt7475) Add attenuator bypass support
Message-ID: <20200303210508.GD14692@roeck-us.net>
References: <20200227084642.7057-1-chris.packham@alliedtelesis.co.nz>
 <20200227084642.7057-5-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200227084642.7057-5-chris.packham@alliedtelesis.co.nz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 09:46:41PM +1300, Chris Packham wrote:
> From: Logan Shaw <logan.shaw@alliedtelesis.co.nz>
> 
> Added support for reading DTS properties to set attenuators on
> device probe for the ADT7473, ADT7475, ADT7476, and ADT7490.
> 
> Signed-off-by: Logan Shaw <logan.shaw@alliedtelesis.co.nz>
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>

Applied, with two small changes; see inline.

Thanks,
Guenter

> ---
> 
> Notes:
>     Changes in v5:
>     - None
>     
>     Changes in v4:
>     - use vendor prefix for new property
>     
>     Changes in v3:
>     - move config2 to struct adt7475_data
>     - set_property_bit() new helper function to set/clear bit based on dt
>       property value.
>     - rename to use load_attenuators()
> 
>  drivers/hwmon/adt7475.c | 61 +++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 58 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hwmon/adt7475.c b/drivers/hwmon/adt7475.c
> index 01c2eeb02aa9..3649b18359dc 100644
> --- a/drivers/hwmon/adt7475.c
> +++ b/drivers/hwmon/adt7475.c
> @@ -19,6 +19,7 @@
>  #include <linux/hwmon-vid.h>
>  #include <linux/err.h>
>  #include <linux/jiffies.h>
> +#include <linux/of.h>
>  #include <linux/util_macros.h>
>  
>  /* Indexes for the sysfs hooks */
> @@ -193,6 +194,7 @@ struct adt7475_data {
>  	unsigned long measure_updated;
>  	bool valid;
>  
> +	u8 config2;
>  	u8 config4;
>  	u8 config5;
>  	u8 has_voltage;
> @@ -1458,6 +1460,55 @@ static int adt7475_update_limits(struct i2c_client *client)
>  	return 0;
>  }
>  
> +static int set_property_bit(const struct i2c_client *client, char *property,
> +			  u8 *config, u8 bit_index)

Aligned continuation line with '('.

> +{
> +	u32 prop_value = 0;
> +	int ret = of_property_read_u32(client->dev.of_node, property,
> +					&prop_value);
> +
> +	if (!ret) {
> +		if (prop_value)
> +			*config |= (1 << bit_index);
> +		else
> +			*config &= ~(1 << bit_index);
> +	}
> +
> +	return ret;
> +}
> +
> +static int load_attenuators(const struct i2c_client *client, int chip,
> +			    struct adt7475_data *data)
> +{
> +	int ret;
> +
> +	if (chip == adt7476 || chip == adt7490) {
> +		set_property_bit(client, "adi,bypass-attenuator-in0",
> +				 &data->config4, 4);
> +		set_property_bit(client, "adi,bypass-attenuator-in1",
> +				 &data->config4, 5);
> +		set_property_bit(client, "adi,bypass-attenuator-in3",
> +				 &data->config4, 6);
> +		set_property_bit(client, "adi,bypass-attenuator-in4",
> +				 &data->config4, 7);
> +
> +		ret = i2c_smbus_write_byte_data(client, REG_CONFIG4,
> +						data->config4);
> +		if (ret < 0)
> +			return ret;
> +	} else if (chip == adt7473 || chip == adt7475) {
> +		set_property_bit(client, "adi,bypass-attenuator-in1",
> +				 &data->config2, 5);
> +
> +		ret = i2c_smbus_write_byte_data(client, REG_CONFIG2,
> +						data->config2);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
>  static int adt7475_probe(struct i2c_client *client,
>  			 const struct i2c_device_id *id)
>  {
> @@ -1472,7 +1523,7 @@ static int adt7475_probe(struct i2c_client *client,
>  	struct adt7475_data *data;
>  	struct device *hwmon_dev;
>  	int i, ret = 0, revision, group_num = 0;
> -	u8 config2, config3;
> +	u8 config3;
>  
>  	data = devm_kzalloc(&client->dev, sizeof(*data), GFP_KERNEL);
>  	if (data == NULL)
> @@ -1546,8 +1597,12 @@ static int adt7475_probe(struct i2c_client *client,
>  	}
>  
>  	/* Voltage attenuators can be bypassed, globally or individually */
> -	config2 = adt7475_read(REG_CONFIG2);
> -	if (config2 & CONFIG2_ATTN) {
> +	data->config2 = adt7475_read(REG_CONFIG2);
> +	ret = load_attenuators(client, chip, data);
> +	if (ret)
> +		dev_err(&client->dev, "Error configuring attenuator bypass\n");

I would expect this to be a dev_warn() or to abort and return an error.
Assuming you want the code to continue in this case, I changed the message
to dev_warn(). If that is not what you want, please let me know.

> +
> +	if (data->config2 & CONFIG2_ATTN) {
>  		data->bypass_attn = (0x3 << 3) | 0x3;
>  	} else {
>  		data->bypass_attn = ((data->config4 & CONFIG4_ATTN_IN10) >> 4) |
