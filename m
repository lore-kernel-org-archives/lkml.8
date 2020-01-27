Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFEE6C33CB7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 13:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E2AF205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 13:55:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DQHWSyB6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728512AbgA0Nz4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 08:55:56 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:37442 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbgA0Nz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 08:55:56 -0500
Received: by mail-yb1-f196.google.com with SMTP id o199so4915184ybc.4;
        Mon, 27 Jan 2020 05:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Sj5wqrITXv648oeDVHTzuVtybuGSot0BUrFpozXj91I=;
        b=DQHWSyB62AUaTbbD2IbSJ7bM5FFoGOAf2Guu3doNjyh10jnsURvzmL/nvsWXIBzqNO
         r0ss7auYa4iSX1KaGR6TMEUJZzBZEDcWCqkqexATJgkgRcVye5Vi38MlvouTtEjyfab6
         0ZxeDb6dMYhqx2XISdEwIhIGpLzzkY94Tkmv/Nor20BS6uBR+/Kekb0JdFKxbUFG8A3W
         AKwlVrdPaF+raotTav64q4dN9N1YNzxxaAOnhKMtYaolsJxSbmLB/tm4uPDJVFIZayfK
         0gwmvk0eM68IwwUmhCb3oQY448tTcO83GJGPyinM92amONMReqR0qPY7zcDzWOLTBkkp
         mVbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Sj5wqrITXv648oeDVHTzuVtybuGSot0BUrFpozXj91I=;
        b=mdIZXxATKa8g1Plo4KLKbasCYyWbNQyc5PNfQDzWBQh3o93H8u5HCp9P+qSe2X4zK8
         CasiVYRdQb9NG/u3oo9w0K4W+n26JF12v6BtWSvOL7Qzwq43S5Es5HA+bMryzLx81dlg
         TkYyKYndYN5nAoFzRDVGPE2AISPJX+7p79wPVBDsNKYsDKQfaqIT/8B5UxxTqnHEUrdd
         T8VXglF+5AVMZg5LUtjPlDGDblJahCuSw0/7qnye5tAAZsb2AwFs+hZNxVS3tVVGeqRu
         15Ug9rj6h7COOwJbKBr9MON29ALqt7V/jrCy5Px2Lio1Dvts8AxUm2jXYwxuKdsl1Axa
         cLdg==
X-Gm-Message-State: APjAAAXlMLrcORxbSoXXvlW73Pir/qUghf0m/GssQMlBrYan5Umz7nvn
        E4oNMQ5duIqSQai38CWMLeYWEFGI
X-Google-Smtp-Source: APXvYqxx/C9Ih7a3SKmxKUkzaJzJ1czbV1RYhgcuIjR5Yz3vglv7X/5/TVCgB59ehqUoec5BB/kqwA==
X-Received: by 2002:a25:bc85:: with SMTP id e5mr12717277ybk.184.1580133354494;
        Mon, 27 Jan 2020 05:55:54 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d199sm6565592ywh.83.2020.01.27.05.55.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jan 2020 05:55:53 -0800 (PST)
Subject: Re: [PATCH V1 1/2] hwmon: (powr1220) Add support for Lattice's
 POWR1014 power manager IC
To:     Oleksij Rempel <o.rempel@pengutronix.de>,
        Jean Delvare <jdelvare@suse.com>,
        Markus Pietrek <mpie@msc-ge.com>
Cc:     kernel@pengutronix.de, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200127102540.31742-1-o.rempel@pengutronix.de>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <7f613e41-26eb-e44b-f54a-47f972077bfa@roeck-us.net>
Date:   Mon, 27 Jan 2020 05:55:52 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200127102540.31742-1-o.rempel@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/27/20 2:25 AM, Oleksij Rempel wrote:
> From: Markus Pietrek <mpie@msc-ge.com>
> 
> This patch adds support for Lattice's POWR1014 power manager IC. Read
> access to all the ADCs on the chip are supported through the hwmon
> sysfs files.
> 
> The main difference of POWR1014 compared to POWR1220 is amount of VMON
> input lines: 10 on POWR1014 and 12 lines on POWR1220.
> 

Please use an is_visible function instead of duplicating the attribute
pointer arrays.

Thanks,
Guenter

> Signed-off-by: Markus Pietrek <mpie@msc-ge.com>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>   drivers/hwmon/powr1220.c | 65 ++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 63 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwmon/powr1220.c b/drivers/hwmon/powr1220.c
> index 65997421ee3c..ad7a82f132e6 100644
> --- a/drivers/hwmon/powr1220.c
> +++ b/drivers/hwmon/powr1220.c
> @@ -19,6 +19,9 @@
>   #include <linux/mutex.h>
>   #include <linux/delay.h>
>   
> +#define I2C_CLIENT_DATA_1014 1014
> +#define I2C_CLIENT_DATA_1220 1220
> +
>   #define ADC_STEP_MV			2
>   #define ADC_MAX_LOW_MEASUREMENT_MV	2000
>   
> @@ -246,6 +249,51 @@ static SENSOR_DEVICE_ATTR_RO(in11_label, powr1220_label, VMON12);
>   static SENSOR_DEVICE_ATTR_RO(in12_label, powr1220_label, VCCA);
>   static SENSOR_DEVICE_ATTR_RO(in13_label, powr1220_label, VCCINP);
>   
> +static struct attribute *powr1014_attrs[] = {
> +	&sensor_dev_attr_in0_input.dev_attr.attr,
> +	&sensor_dev_attr_in1_input.dev_attr.attr,
> +	&sensor_dev_attr_in2_input.dev_attr.attr,
> +	&sensor_dev_attr_in3_input.dev_attr.attr,
> +	&sensor_dev_attr_in4_input.dev_attr.attr,
> +	&sensor_dev_attr_in5_input.dev_attr.attr,
> +	&sensor_dev_attr_in6_input.dev_attr.attr,
> +	&sensor_dev_attr_in7_input.dev_attr.attr,
> +	&sensor_dev_attr_in8_input.dev_attr.attr,
> +	&sensor_dev_attr_in9_input.dev_attr.attr,
> +	&sensor_dev_attr_in12_input.dev_attr.attr,
> +	&sensor_dev_attr_in13_input.dev_attr.attr,
> +
> +	&sensor_dev_attr_in0_highest.dev_attr.attr,
> +	&sensor_dev_attr_in1_highest.dev_attr.attr,
> +	&sensor_dev_attr_in2_highest.dev_attr.attr,
> +	&sensor_dev_attr_in3_highest.dev_attr.attr,
> +	&sensor_dev_attr_in4_highest.dev_attr.attr,
> +	&sensor_dev_attr_in5_highest.dev_attr.attr,
> +	&sensor_dev_attr_in6_highest.dev_attr.attr,
> +	&sensor_dev_attr_in7_highest.dev_attr.attr,
> +	&sensor_dev_attr_in8_highest.dev_attr.attr,
> +	&sensor_dev_attr_in9_highest.dev_attr.attr,
> +	&sensor_dev_attr_in12_highest.dev_attr.attr,
> +	&sensor_dev_attr_in13_highest.dev_attr.attr,
> +
> +	&sensor_dev_attr_in0_label.dev_attr.attr,
> +	&sensor_dev_attr_in1_label.dev_attr.attr,
> +	&sensor_dev_attr_in2_label.dev_attr.attr,
> +	&sensor_dev_attr_in3_label.dev_attr.attr,
> +	&sensor_dev_attr_in4_label.dev_attr.attr,
> +	&sensor_dev_attr_in5_label.dev_attr.attr,
> +	&sensor_dev_attr_in6_label.dev_attr.attr,
> +	&sensor_dev_attr_in7_label.dev_attr.attr,
> +	&sensor_dev_attr_in8_label.dev_attr.attr,
> +	&sensor_dev_attr_in9_label.dev_attr.attr,
> +	&sensor_dev_attr_in12_label.dev_attr.attr,
> +	&sensor_dev_attr_in13_label.dev_attr.attr,
> +
> +	NULL
> +};
> +
> +ATTRIBUTE_GROUPS(powr1014);
> +
>   static struct attribute *powr1220_attrs[] = {
>   	&sensor_dev_attr_in0_input.dev_attr.attr,
>   	&sensor_dev_attr_in1_input.dev_attr.attr,
> @@ -300,9 +348,21 @@ ATTRIBUTE_GROUPS(powr1220);
>   static int powr1220_probe(struct i2c_client *client,
>   		const struct i2c_device_id *id)
>   {
> +	const struct attribute_group **attr_groups = NULL;
>   	struct powr1220_data *data;
>   	struct device *hwmon_dev;
>   
> +	switch (id->driver_data) {
> +	case I2C_CLIENT_DATA_1014:
> +		attr_groups = powr1014_groups;
> +		break;
> +	case I2C_CLIENT_DATA_1220:
> +		attr_groups = powr1220_groups;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
>   	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_BYTE_DATA))
>   		return -ENODEV;
>   
> @@ -314,13 +374,14 @@ static int powr1220_probe(struct i2c_client *client,
>   	data->client = client;
>   
>   	hwmon_dev = devm_hwmon_device_register_with_groups(&client->dev,
> -			client->name, data, powr1220_groups);
> +			client->name, data, attr_groups);
>   
>   	return PTR_ERR_OR_ZERO(hwmon_dev);
>   }
>   
>   static const struct i2c_device_id powr1220_ids[] = {
> -	{ "powr1220", 0, },
> +	{ "powr1014", I2C_CLIENT_DATA_1014, },
> +	{ "powr1220", I2C_CLIENT_DATA_1220, },
>   	{ }
>   };
>   
> 

