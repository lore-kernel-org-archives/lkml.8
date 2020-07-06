Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1076FC433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 19:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAB57206B6
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 19:33:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Njvjp/YF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbgGFTc7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 15:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbgGFTc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 15:32:58 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90899C061755;
        Mon,  6 Jul 2020 12:32:58 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id t11so12513870pfq.11;
        Mon, 06 Jul 2020 12:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=utd1A1y4ZOW0vYkwc9M65ImQkKMejnI+d5kMVprgyuc=;
        b=Njvjp/YF9MzRGHfBGhm9wIesUPkxO+3GNCqB1rN33Z8nrMOFbAySHZYUMouzrJ827G
         GrrqpTQe4ucKBuQZlsw/fxPPXtEOh60mZRuAmz31J20M/ExwcZ8NPlGOJRu3p9Hv40+I
         17krdw//m8jTCkoSwSgSH2b/e1ouUMv+K+fNAM8Avd7WXxjlPx2HA9uyF4+gJ1Asa1Qm
         RPSn8ORrFXLZ6hjYWgpt2/nw3IRqIAfpsFTZOQ62awnQtsznp1v0YoFN/6asF0a37ZFn
         iEImDtBUqo2d+k0yyzQLv6xVXTbVFmF09gSx9S+I2NP4UMgnJgQzCmPiKJZHhZ6hiEmk
         GlVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=utd1A1y4ZOW0vYkwc9M65ImQkKMejnI+d5kMVprgyuc=;
        b=C9yJJYGLKlQc5iyvI0AY/d+O23AsDDC0lY0+pwwebBZpDXfrV/rEVvdhOeURX6CLrL
         o50jMi8zwvDY2JYpttgjJ1QbIqNob012vk9oaVts8n6ovhnlYisw0w5XJhChCMSy7eWi
         khdNV0yhBbibcWINjo4NrkmHwnA0hrY9xhVzvAoDNHQpu0ucBSty5NHzCokvmBE0Ryxp
         RdmXs4cwJ7rgudgBEmysUCcXRDY4SGSuSiJdPIYJpPx1ne25GtXbax0uQqaAsjiv81wK
         M24Wc1sZFJzH/SlVbjBLpUk9tXP5WnYEEqrVOgKD6+ZnJ2kiL5w3uNwv/uMqIsAr8IE9
         7UAw==
X-Gm-Message-State: AOAM532/ezoTQHGpcFGPZiNufUtdBjYAXwQ649zsddh7Dv1D2Vxi93DI
        uXjFZfVahEUIDXqndpskqKFQhyZPDIs=
X-Google-Smtp-Source: ABdhPJw+kmgKsv2ncoW9b4bURagQbfi/sdMFpa2uy3kkNu1O6UojkWPMGELyzXphsUM4UoNNNLvygw==
X-Received: by 2002:a62:5c02:: with SMTP id q2mr46736544pfb.232.1594063978076;
        Mon, 06 Jul 2020 12:32:58 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g6sm4540548pfr.129.2020.07.06.12.32.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Jul 2020 12:32:57 -0700 (PDT)
Date:   Mon, 6 Jul 2020 12:32:56 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Chu Lin <linchuyuan@google.com>
Cc:     belgaied@google.com, jasonling@google.com, jdelvare@suse.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhongqil@google.com
Subject: Re: [PATCH] hwmon:max6697: Allow max6581 to create tempX_offset
Message-ID: <20200706193256.GA180826@roeck-us.net>
References: <20200703010611.GA100794@roeck-us.net>
 <20200706175433.1948648-1-linchuyuan@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200706175433.1948648-1-linchuyuan@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 06, 2020 at 05:54:33PM +0000, Chu Lin wrote:
> Per max6581, reg 4d and reg 4e is used for temperature read offset.
> This patch will let the user specify the temperature read offset for
> max6581. This patch is tested on max6581 and only applies to max6581.
> 

Please version your patches and provide a log of changes made.

Guenter

> Testing:
> echo 16250 > temp2_offset
> cat temp2_offset
> 16250
> 
> echo 17500 > temp3_offset
> cat temp3_offset
> 17500
> cat temp4_offset
> 0
> cat temp2_offset
> 17500
> 
> echo 0 > temp2_offset
> cat temp2_offset
> 0
> cat temp3_offset
> 17500
> 
> echo -0 > temp2_offset
> cat temp2_offset
> 0
> 
> echo -100000 > temp2_offset
> cat temp2_input
> 4875
> 
> echo 10000 > temp2_offset
> cat temp2_input
> 47125
> 
> echo -2000 > temp2_offset
> cat temp2_input
> 34875
> 
> echo -0 > temp2_offset
> cat temp2_input
> 37000
> 
> Signed-off-by: Chu Lin <linchuyuan@google.com>
> ---
>  drivers/hwmon/max6697.c | 100 ++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 96 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hwmon/max6697.c b/drivers/hwmon/max6697.c
> index da43f7ae3de1..4b71b3716f22 100644
> --- a/drivers/hwmon/max6697.c
> +++ b/drivers/hwmon/max6697.c
> @@ -65,6 +65,9 @@ static const u8 MAX6697_REG_CRIT[] = {
>  #define MAX6581_REG_IDEALITY_SELECT	0x4c
>  #define MAX6581_REG_OFFSET		0x4d
>  #define MAX6581_REG_OFFSET_SELECT	0x4e
> +#define MAX6581_OFFSET_MIN		-31750
> +#define MAX6581_OFFSET_MAX		31750
> +
>  
>  #define MAX6697_CONV_TIME		156	/* ms per channel, worst case */
>  
> @@ -180,6 +183,11 @@ static const struct max6697_chip_data max6697_chip_data[] = {
>  	},
>  };
>  
> +static inline int max6581_offset_to_millic(int val)
> +{
> +	return val & (1 << 7) ? (val | 0xffffff00) * 250 : val * 250;
> +}
> +
>  static struct max6697_data *max6697_update_device(struct device *dev)
>  {
>  	struct max6697_data *data = dev_get_drvdata(dev);
> @@ -325,6 +333,69 @@ static ssize_t temp_store(struct device *dev,
>  	return ret < 0 ? ret : count;
>  }
>  
> +static ssize_t offset_store(struct device *dev,
> +			    struct device_attribute *devattr, const char *buf,
> +			    size_t count)
> +{
> +	long temp;
> +	u8 val, select;
> +	int ret, index;
> +	struct max6697_data *data;
> +
> +	index = to_sensor_dev_attr(devattr)->index;
> +	data = dev_get_drvdata(dev);
> +	select = i2c_smbus_read_byte_data(data->client,
> +					  MAX6581_REG_OFFSET_SELECT);
> +	if (select < 0)
> +		return select;
> +	ret = kstrtol(buf, 10, &temp);
> +	if (ret < 0)
> +		return ret;
> +	/* disable the offset for channel */
> +	if (temp == 0) {
> +		ret = i2c_smbus_write_byte_data(data->client,
> +						MAX6581_REG_OFFSET_SELECT,
> +						select & ~(1 << (index - 1)));
> +		return ret < 0 ? ret : count;
> +	}
> +	temp = clamp_val(temp, MAX6581_OFFSET_MIN, MAX6581_OFFSET_MAX);
> +	val = DIV_ROUND_CLOSEST(temp, 250);
> +	mutex_lock(&data->update_lock);
> +	ret = i2c_smbus_write_byte_data(data->client,
> +					MAX6581_REG_OFFSET_SELECT,
> +					select | (1 << (index - 1)));
> +	if (ret < 0)
> +		return ret;
> +	ret = i2c_smbus_write_byte_data(data->client,
> +					MAX6581_REG_OFFSET,
> +					val);
> +	mutex_unlock(&data->update_lock);
> +	return ret < 0 ? ret : count;
> +}
> +
> +static ssize_t offset_show(struct device *dev, struct device_attribute *devattr,
> +			   char *buf)
> +{
> +	int select, ret, index;
> +	struct max6697_data *data;
> +
> +	index = to_sensor_dev_attr(devattr)->index;
> +	data = dev_get_drvdata(dev);
> +	select = i2c_smbus_read_byte_data(data->client,
> +					  MAX6581_REG_OFFSET_SELECT);
> +	if (select < 0)
> +		return select;
> +	if (select & (1 << (index - 1))) {
> +		ret = i2c_smbus_read_byte_data(data->client,
> +					       MAX6581_REG_OFFSET);
> +		if (ret < 0)
> +			return ret;
> +	} else {
> +		return sprintf(buf, "%d\n", 0);
> +	}
> +	return sprintf(buf, "%d\n", max6581_offset_to_millic(ret));
> +}
> +
>  static SENSOR_DEVICE_ATTR_RO(temp1_input, temp_input, 0);
>  static SENSOR_DEVICE_ATTR_2_RW(temp1_max, temp, 0, MAX6697_TEMP_MAX);
>  static SENSOR_DEVICE_ATTR_2_RW(temp1_crit, temp, 0, MAX6697_TEMP_CRIT);
> @@ -383,6 +454,15 @@ static SENSOR_DEVICE_ATTR_RO(temp6_fault, alarm, 5);
>  static SENSOR_DEVICE_ATTR_RO(temp7_fault, alarm, 6);
>  static SENSOR_DEVICE_ATTR_RO(temp8_fault, alarm, 7);
>  
> +/* There is no offset for local temperature so starting from temp2 */
> +static SENSOR_DEVICE_ATTR_RW(temp2_offset, offset, 1);
> +static SENSOR_DEVICE_ATTR_RW(temp3_offset, offset, 2);
> +static SENSOR_DEVICE_ATTR_RW(temp4_offset, offset, 3);
> +static SENSOR_DEVICE_ATTR_RW(temp5_offset, offset, 4);
> +static SENSOR_DEVICE_ATTR_RW(temp6_offset, offset, 5);
> +static SENSOR_DEVICE_ATTR_RW(temp7_offset, offset, 6);
> +static SENSOR_DEVICE_ATTR_RW(temp8_offset, offset, 7);
> +
>  static DEVICE_ATTR(dummy, 0, NULL, NULL);
>  
>  static umode_t max6697_is_visible(struct kobject *kobj, struct attribute *attr,
> @@ -391,8 +471,8 @@ static umode_t max6697_is_visible(struct kobject *kobj, struct attribute *attr,
>  	struct device *dev = container_of(kobj, struct device, kobj);
>  	struct max6697_data *data = dev_get_drvdata(dev);
>  	const struct max6697_chip_data *chip = data->chip;
> -	int channel = index / 6;	/* channel number */
> -	int nr = index % 6;		/* attribute index within channel */
> +	int channel = index / 8;	/* channel number */
> +	int nr = index % 7;		/* attribute index within channel */
>  
>  	if (channel >= chip->channels)
>  		return 0;
> @@ -401,6 +481,10 @@ static umode_t max6697_is_visible(struct kobject *kobj, struct attribute *attr,
>  		return 0;
>  	if (nr == 5 && !(chip->have_fault & (1 << channel)))
>  		return 0;
> +	/* offset reg is only supported on max6581 remote channels */
> +	if (nr == 6)
> +		if (data->type != max6581 || channel == 0)
> +			return 0;
>  
>  	return attr->mode;
>  }
> @@ -417,6 +501,7 @@ static struct attribute *max6697_attributes[] = {
>  	&sensor_dev_attr_temp1_crit.dev_attr.attr,
>  	&sensor_dev_attr_temp1_crit_alarm.dev_attr.attr,
>  	&dev_attr_dummy.attr,
> +	&dev_attr_dummy.attr,
>  
>  	&sensor_dev_attr_temp2_input.dev_attr.attr,
>  	&sensor_dev_attr_temp2_max.dev_attr.attr,
> @@ -424,6 +509,7 @@ static struct attribute *max6697_attributes[] = {
>  	&sensor_dev_attr_temp2_crit.dev_attr.attr,
>  	&sensor_dev_attr_temp2_crit_alarm.dev_attr.attr,
>  	&sensor_dev_attr_temp2_fault.dev_attr.attr,
> +	&sensor_dev_attr_temp2_offset.dev_attr.attr,
>  
>  	&sensor_dev_attr_temp3_input.dev_attr.attr,
>  	&sensor_dev_attr_temp3_max.dev_attr.attr,
> @@ -431,6 +517,7 @@ static struct attribute *max6697_attributes[] = {
>  	&sensor_dev_attr_temp3_crit.dev_attr.attr,
>  	&sensor_dev_attr_temp3_crit_alarm.dev_attr.attr,
>  	&sensor_dev_attr_temp3_fault.dev_attr.attr,
> +	&sensor_dev_attr_temp3_offset.dev_attr.attr,
>  
>  	&sensor_dev_attr_temp4_input.dev_attr.attr,
>  	&sensor_dev_attr_temp4_max.dev_attr.attr,
> @@ -438,6 +525,7 @@ static struct attribute *max6697_attributes[] = {
>  	&sensor_dev_attr_temp4_crit.dev_attr.attr,
>  	&sensor_dev_attr_temp4_crit_alarm.dev_attr.attr,
>  	&sensor_dev_attr_temp4_fault.dev_attr.attr,
> +	&sensor_dev_attr_temp4_offset.dev_attr.attr,
>  
>  	&sensor_dev_attr_temp5_input.dev_attr.attr,
>  	&sensor_dev_attr_temp5_max.dev_attr.attr,
> @@ -445,6 +533,7 @@ static struct attribute *max6697_attributes[] = {
>  	&sensor_dev_attr_temp5_crit.dev_attr.attr,
>  	&sensor_dev_attr_temp5_crit_alarm.dev_attr.attr,
>  	&sensor_dev_attr_temp5_fault.dev_attr.attr,
> +	&sensor_dev_attr_temp5_offset.dev_attr.attr,
>  
>  	&sensor_dev_attr_temp6_input.dev_attr.attr,
>  	&sensor_dev_attr_temp6_max.dev_attr.attr,
> @@ -452,6 +541,7 @@ static struct attribute *max6697_attributes[] = {
>  	&sensor_dev_attr_temp6_crit.dev_attr.attr,
>  	&sensor_dev_attr_temp6_crit_alarm.dev_attr.attr,
>  	&sensor_dev_attr_temp6_fault.dev_attr.attr,
> +	&sensor_dev_attr_temp6_offset.dev_attr.attr,
>  
>  	&sensor_dev_attr_temp7_input.dev_attr.attr,
>  	&sensor_dev_attr_temp7_max.dev_attr.attr,
> @@ -459,6 +549,7 @@ static struct attribute *max6697_attributes[] = {
>  	&sensor_dev_attr_temp7_crit.dev_attr.attr,
>  	&sensor_dev_attr_temp7_crit_alarm.dev_attr.attr,
>  	&sensor_dev_attr_temp7_fault.dev_attr.attr,
> +	&sensor_dev_attr_temp7_offset.dev_attr.attr,
>  
>  	&sensor_dev_attr_temp8_input.dev_attr.attr,
>  	&sensor_dev_attr_temp8_max.dev_attr.attr,
> @@ -466,6 +557,7 @@ static struct attribute *max6697_attributes[] = {
>  	&sensor_dev_attr_temp8_crit.dev_attr.attr,
>  	&sensor_dev_attr_temp8_crit_alarm.dev_attr.attr,
>  	&sensor_dev_attr_temp8_fault.dev_attr.attr,
> +	&sensor_dev_attr_temp8_offset.dev_attr.attr,
>  	NULL
>  };
>  
> @@ -502,8 +594,8 @@ static void max6697_get_config_of(struct device_node *node,
>  	}
>  	prop = of_get_property(node, "transistor-ideality", &len);
>  	if (prop && len == 2 * sizeof(u32)) {
> -			pdata->ideality_mask = be32_to_cpu(prop[0]);
> -			pdata->ideality_value = be32_to_cpu(prop[1]);
> +		pdata->ideality_mask = be32_to_cpu(prop[0]);
> +		pdata->ideality_value = be32_to_cpu(prop[1]);
>  	}
>  }
>  
> -- 
> 2.27.0.212.ge8ba1cc988-goog
> 
