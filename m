Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECD7BC433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 03:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFE7C20758
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 03:01:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="daqEG873"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbgGGDBt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 23:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbgGGDBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 23:01:48 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B32D8C061755;
        Mon,  6 Jul 2020 20:01:48 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id 1so101653pfn.9;
        Mon, 06 Jul 2020 20:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OQCgUwM2ShP0/N0SvzdE3xadrflgQZrSD21eF9YrU/w=;
        b=daqEG873WEhgL7DYnv/QAZ0dpmVgfZYL4xpK7tZWZuugeu3veuHQ08hXLQXWfrupoL
         gb/UA4qCEIgL/1SmTJS5FUnNw+9dEAEvtVjjrbLZpci1XScv96d9buXdXySolztmJlCJ
         hCeF9Xps9K9ZUGrIx3olDIbA2wc5W4j24U6oBHu+tUCEmfyU3JykZlq82a16Zmn+zGF4
         DV8oJ9foFNVJ9LtvCXQ948Wj9tT19qn6iN48wyawxL3LrkUIX0iMS469Txejatkihect
         txNroVzN1XGM/BBi3Uu5O8XHazh3mZSgmP4+CVccqsWkjT6fS9Sh2CgyQDFMwll0+ceT
         JfSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=OQCgUwM2ShP0/N0SvzdE3xadrflgQZrSD21eF9YrU/w=;
        b=WPVXzPrD4y8qTlje8RaeWJ5FTOwh+G+m2mjGFBkgDgWxLjdhAGyM/cAjyphZaclTbj
         ka97nosyMX7UD+44p+QZZt4udqCo+sEE8O7QrFNRWBZ/YAknosQEq2rCJBLIieyQJgsk
         zOZX/SaHlwNxPxiOPyQEb1A991aPxMHrnIwcFfzsr9rPW9ZmkLlLSQ6AFvXAtnb/593k
         0gChylSHu5GPf2EI4s/AYuaAOtMjVvLFeJ+2VUMIdMSGeLEP/YTnnCTI49+TksAtoJBN
         ZpmXgugEKjskZpszfVqQOB5I6kJ/RiXiqxMST4WHHix/sPyrTV+4YcX9d5KA8iiLuzQ4
         olRA==
X-Gm-Message-State: AOAM532B/HBMblSSQoOzb99jiC69R2bmcX508+kQ7wohX/kCNnsWMLSM
        yIO3YF87w7p9tBeEky3dlblezeGwri8=
X-Google-Smtp-Source: ABdhPJyrPvjbAUbN7OSlkamQyjoyKeYpcxILuUspQfP2oTdlhers4m3hooh5MLifh/N7PUePIv0dPw==
X-Received: by 2002:a63:b90a:: with SMTP id z10mr41143374pge.277.1594090907669;
        Mon, 06 Jul 2020 20:01:47 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b4sm732646pjn.38.2020.07.06.20.01.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2020 20:01:46 -0700 (PDT)
Subject: Re: [PATCH v3 1/1] hwmon:max6697: Allows max6581 to create
 tempX_offset attributes
To:     Chu Lin <linchuyuan@google.com>
Cc:     belgaied@google.com, jasonling@google.com, jdelvare@suse.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhongqil@google.com
References: <20200707011810.2508233-1-linchuyuan@google.com>
 <20200707011810.2508233-2-linchuyuan@google.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <a36fc250-5387-7534-a8ff-2b5d5196d687@roeck-us.net>
Date:   Mon, 6 Jul 2020 20:01:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200707011810.2508233-2-linchuyuan@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/6/20 6:18 PM, Chu Lin wrote:
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

Technically this is patch v4, but never mind.

> ---
>  drivers/hwmon/max6697.c | 92 +++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 88 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hwmon/max6697.c b/drivers/hwmon/max6697.c
> index 64122eb38060..6b213e146fbe 100644
> --- a/drivers/hwmon/max6697.c
> +++ b/drivers/hwmon/max6697.c
> @@ -57,6 +57,9 @@ static const u8 MAX6697_REG_CRIT[] = {
>  #define MAX6581_REG_IDEALITY_SELECT	0x4c
>  #define MAX6581_REG_OFFSET		0x4d
>  #define MAX6581_REG_OFFSET_SELECT	0x4e
> +#define MAX6581_OFFSET_MIN		-31750
> +#define MAX6581_OFFSET_MAX		31750
> +
>  
Pease no double empty lines.

>  #define MAX6697_CONV_TIME		156	/* ms per channel, worst case */
>  
> @@ -172,6 +175,11 @@ static const struct max6697_chip_data max6697_chip_data[] = {
>  	},
>  };
>  
> +static inline int max6581_offset_to_millic(int val)
> +{
> +	return val & (1 << 7) ? (val | 0xffffff00) * 250 : val * 250;

	return sign_extend32(val, 7) * 250;

> +}
> +
>  static struct max6697_data *max6697_update_device(struct device *dev)
>  {
>  	struct max6697_data *data = dev_get_drvdata(dev);
> @@ -317,6 +325,61 @@ static ssize_t temp_store(struct device *dev,
>  	return ret < 0 ? ret : count;
>  }
>  
> +static ssize_t offset_store(struct device *dev,
> +			    struct device_attribute *devattr, const char *buf,
> +			    size_t count)

I don't think this needs three lines with the new line length limit.

> +{
> +	int val, ret, index, select;
> +	struct max6697_data *data;
> +	long temp;
> +
> +	index = to_sensor_dev_attr(devattr)->index;
> +	data = dev_get_drvdata(dev);
> +	select = i2c_smbus_read_byte_data(data->client, MAX6581_REG_OFFSET_SELECT);
> +	if (select < 0)
> +		return select;

Unfortunately, this is racy: The select register can be changed by another write
after it was read here. The kstrtol() can be outside the lock, but the entire
sequence of i2c reads and writes has to be mutex protected.

> +	ret = kstrtol(buf, 10, &temp);
> +	if (ret < 0)
> +		return ret;
> +	/* disable the offset for channel */

                                          ... if the new offset is 0.

> +	if (temp == 0) {

This now has to be after the assignment of val below, and must be "if (val == 0)".

> +		ret = i2c_smbus_write_byte_data(data->client, MAX6581_REG_OFFSET_SELECT,
> +						select & ~(1 << (index - 1)));
> +		return ret < 0 ? ret : count;
> +	}
> +	temp = clamp_val(temp, MAX6581_OFFSET_MIN, MAX6581_OFFSET_MAX);
> +	val = DIV_ROUND_CLOSEST(temp, 250);
> +	mutex_lock(&data->update_lock);
> +	ret = i2c_smbus_write_byte_data(data->client, MAX6581_REG_OFFSET_SELECT,> +					select | (1 << (index - 1)));

It might make sense to update the select register only if it actually changes
its value. The cost for checking this is much less than the cost of the additional
i2c write.

> +	if (ret < 0)
> +		return ret;

Forgot to release the lock - needs goto

> +	ret = i2c_smbus_write_byte_data(data->client, MAX6581_REG_OFFSET, val);
> +	mutex_unlock(&data->update_lock);
> +	return ret < 0 ? ret : count;
> +}
> +
> +static ssize_t offset_show(struct device *dev, struct device_attribute *devattr,
> +			   char *buf)

Single line should be sufficient.

> +{
> +	struct max6697_data *data;
> +	int select, ret, index;
> +
> +	index = to_sensor_dev_attr(devattr)->index;
> +	data = dev_get_drvdata(dev);
> +	select = i2c_smbus_read_byte_data(data->client, MAX6581_REG_OFFSET_SELECT);
> +	if (select < 0)
> +		return select;
> +	if (select & (1 << (index - 1))) {
> +		ret = i2c_smbus_read_byte_data(data->client, MAX6581_REG_OFFSET);
> +		if (ret < 0)
> +			return ret;
> +	} else {
> +		return sprintf(buf, "%d\n", 0);

Better make this "ret = 0;".

Also, this is racy: select can be changed after the first read.
Not sure if that matters much, though.

> +	}
> +	return sprintf(buf, "%d\n", max6581_offset_to_millic(ret));
> +}
> +
>  static SENSOR_DEVICE_ATTR_RO(temp1_input, temp_input, 0);
>  static SENSOR_DEVICE_ATTR_2_RW(temp1_max, temp, 0, MAX6697_TEMP_MAX);
>  static SENSOR_DEVICE_ATTR_2_RW(temp1_crit, temp, 0, MAX6697_TEMP_CRIT);
> @@ -375,6 +438,15 @@ static SENSOR_DEVICE_ATTR_RO(temp6_fault, alarm, 5);
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
> @@ -383,8 +455,8 @@ static umode_t max6697_is_visible(struct kobject *kobj, struct attribute *attr,
>  	struct device *dev = container_of(kobj, struct device, kobj);
>  	struct max6697_data *data = dev_get_drvdata(dev);
>  	const struct max6697_chip_data *chip = data->chip;
> -	int channel = index / 6;	/* channel number */
> -	int nr = index % 6;		/* attribute index within channel */
> +	int channel = index / 8;	/* channel number */
> +	int nr = index % 7;		/* attribute index within channel */

Something is wrong here: "/ 6" and "% 6" changed to "/ 8" and "% 7".
Why "/ 8" ?

>  
>  	if (channel >= chip->channels)
>  		return 0;
> @@ -393,6 +465,10 @@ static umode_t max6697_is_visible(struct kobject *kobj, struct attribute *attr,
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
> @@ -409,6 +485,7 @@ static struct attribute *max6697_attributes[] = {
>  	&sensor_dev_attr_temp1_crit.dev_attr.attr,
>  	&sensor_dev_attr_temp1_crit_alarm.dev_attr.attr,
>  	&dev_attr_dummy.attr,
> +	&dev_attr_dummy.attr,
>  
>  	&sensor_dev_attr_temp2_input.dev_attr.attr,
>  	&sensor_dev_attr_temp2_max.dev_attr.attr,
> @@ -416,6 +493,7 @@ static struct attribute *max6697_attributes[] = {
>  	&sensor_dev_attr_temp2_crit.dev_attr.attr,
>  	&sensor_dev_attr_temp2_crit_alarm.dev_attr.attr,
>  	&sensor_dev_attr_temp2_fault.dev_attr.attr,
> +	&sensor_dev_attr_temp2_offset.dev_attr.attr,
>  
>  	&sensor_dev_attr_temp3_input.dev_attr.attr,
>  	&sensor_dev_attr_temp3_max.dev_attr.attr,
> @@ -423,6 +501,7 @@ static struct attribute *max6697_attributes[] = {
>  	&sensor_dev_attr_temp3_crit.dev_attr.attr,
>  	&sensor_dev_attr_temp3_crit_alarm.dev_attr.attr,
>  	&sensor_dev_attr_temp3_fault.dev_attr.attr,
> +	&sensor_dev_attr_temp3_offset.dev_attr.attr,
>  
>  	&sensor_dev_attr_temp4_input.dev_attr.attr,
>  	&sensor_dev_attr_temp4_max.dev_attr.attr,
> @@ -430,6 +509,7 @@ static struct attribute *max6697_attributes[] = {
>  	&sensor_dev_attr_temp4_crit.dev_attr.attr,
>  	&sensor_dev_attr_temp4_crit_alarm.dev_attr.attr,
>  	&sensor_dev_attr_temp4_fault.dev_attr.attr,
> +	&sensor_dev_attr_temp4_offset.dev_attr.attr,
>  
>  	&sensor_dev_attr_temp5_input.dev_attr.attr,
>  	&sensor_dev_attr_temp5_max.dev_attr.attr,
> @@ -437,6 +517,7 @@ static struct attribute *max6697_attributes[] = {
>  	&sensor_dev_attr_temp5_crit.dev_attr.attr,
>  	&sensor_dev_attr_temp5_crit_alarm.dev_attr.attr,
>  	&sensor_dev_attr_temp5_fault.dev_attr.attr,
> +	&sensor_dev_attr_temp5_offset.dev_attr.attr,
>  
>  	&sensor_dev_attr_temp6_input.dev_attr.attr,
>  	&sensor_dev_attr_temp6_max.dev_attr.attr,
> @@ -444,6 +525,7 @@ static struct attribute *max6697_attributes[] = {
>  	&sensor_dev_attr_temp6_crit.dev_attr.attr,
>  	&sensor_dev_attr_temp6_crit_alarm.dev_attr.attr,
>  	&sensor_dev_attr_temp6_fault.dev_attr.attr,
> +	&sensor_dev_attr_temp6_offset.dev_attr.attr,
>  
>  	&sensor_dev_attr_temp7_input.dev_attr.attr,
>  	&sensor_dev_attr_temp7_max.dev_attr.attr,
> @@ -451,6 +533,7 @@ static struct attribute *max6697_attributes[] = {
>  	&sensor_dev_attr_temp7_crit.dev_attr.attr,
>  	&sensor_dev_attr_temp7_crit_alarm.dev_attr.attr,
>  	&sensor_dev_attr_temp7_fault.dev_attr.attr,
> +	&sensor_dev_attr_temp7_offset.dev_attr.attr,
>  
>  	&sensor_dev_attr_temp8_input.dev_attr.attr,
>  	&sensor_dev_attr_temp8_max.dev_attr.attr,
> @@ -458,6 +541,7 @@ static struct attribute *max6697_attributes[] = {
>  	&sensor_dev_attr_temp8_crit.dev_attr.attr,
>  	&sensor_dev_attr_temp8_crit_alarm.dev_attr.attr,
>  	&sensor_dev_attr_temp8_fault.dev_attr.attr,
> +	&sensor_dev_attr_temp8_offset.dev_attr.attr,
>  	NULL
>  };
>  
> @@ -494,8 +578,8 @@ static void max6697_get_config_of(struct device_node *node,
>  	}
>  	prop = of_get_property(node, "transistor-ideality", &len);
>  	if (prop && len == 2 * sizeof(u32)) {
> -			pdata->ideality_mask = be32_to_cpu(prop[0]);
> -			pdata->ideality_value = be32_to_cpu(prop[1]);
> +		pdata->ideality_mask = be32_to_cpu(prop[0]);
> +		pdata->ideality_value = be32_to_cpu(prop[1]);

Unrelated change. I don't mind if you want to make that change,
but it would have to be in a separate patch.

>  	}
>  }
>  
> 

