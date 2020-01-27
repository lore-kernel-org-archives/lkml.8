Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB06C33CB7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 13:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F132D207FD
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 13:52:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="clFzisZW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbgA0NwF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 08:52:05 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:34938 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbgA0NwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 08:52:04 -0500
Received: by mail-yw1-f66.google.com with SMTP id i190so4744085ywc.2;
        Mon, 27 Jan 2020 05:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=U+4tlbg+5b0f0SEB/qwqbokPD/ku3jCQrVSjB/lGf8w=;
        b=clFzisZWm2lSrM1eSwt+2B6GRe74ll4/3nkskoUhpPM/azftS7wthDg/zStL6pNH0k
         T8Np7x16Nnn4aKXm2uVVPr0Dhkja1v4exizxH1C7a8A0c+7/gQ6CqJpEXzhy1WyXhUHj
         0E3n5Fs+/Y7bcvTrPlM+DPll4NA7TbY0x+K8ztehSRamqyrl8QzM4PiUbnPP1mDBTeX1
         jTDn9MkSqXn4TDzSr0JO0HRNajvfX9JNkJ8OiyDPEiOMmRXjWmyheN68a9g4YPxLlVaL
         HhQMWgDq/UB8zaEdtt0zrQq0il/HIJUd98TLkBLUIVOmQk1oBJ456Vmc5OCABjPYhLBx
         eEcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=U+4tlbg+5b0f0SEB/qwqbokPD/ku3jCQrVSjB/lGf8w=;
        b=XfMZalKzsRROPQC2wHuurcl1FX3UoW4R146woSFvMZNDciNCHUBcF5ik7pyyWTTVaA
         WRUyAUGW/ygLwIs9zpdren0WQ5TQAyCWNmBFauDbCEnse8zKEbtkYaW9rXqd3zsabfC3
         OkjVKdbUhSvaFWVBIgc1KRRqdGYR1/j37Oj1YMGAH3rUthwS6z/8jngTHNZMDgQ5w9i9
         C/e339FVLHcNjLHUWYf9S5iMqlp7yMIHy9jA6IoXktfNT6bsUHCvDDtQyB1T5jNOK4fU
         XAHDuBNOTIMhPIN/ZbiqwPejBxFa64iavw3U+n43WYO2QMWBHJI8jd8ZZSj7snwI6WyA
         h6UQ==
X-Gm-Message-State: APjAAAWWoo6fQtAtH0dpwaX6lkRKKEU3KyaUz9Uewi6mq2GW0qxRuBSP
        ZK1FtNx9fD9IBqF52H3ouuM0rNK4
X-Google-Smtp-Source: APXvYqxSKgBxI3+lmjDfN+gqTCL3PZaclcgqgJgoLNHvmkUVJd2ZwpgIs57l5kYL5C5Cy6q85/Tbuw==
X-Received: by 2002:a0d:cb48:: with SMTP id n69mr11810322ywd.48.1580133123239;
        Mon, 27 Jan 2020 05:52:03 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g190sm6635492ywd.85.2020.01.27.05.52.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jan 2020 05:52:02 -0800 (PST)
Subject: Re: [PATCH V1 2/2] hwmon: (powr1220) add scaled voltage support
To:     Oleksij Rempel <o.rempel@pengutronix.de>,
        Jean Delvare <jdelvare@suse.com>,
        Markus Pietrek <mpie@msc-ge.com>
Cc:     kernel@pengutronix.de, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200127102540.31742-1-o.rempel@pengutronix.de>
 <20200127102540.31742-2-o.rempel@pengutronix.de>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <f7a357d3-c8c3-a71a-ebc8-bc2d37c7c086@roeck-us.net>
Date:   Mon, 27 Jan 2020 05:52:00 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200127102540.31742-2-o.rempel@pengutronix.de>
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
> On some (or may be all?) boards, voltage measured by powr1220 do not
> reflect real system configuration. This patch provides scale option to
> set board specific configuration.
> 
> Signed-off-by: Markus Pietrek <mpie@msc-ge.com>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---

NACK; scaling is what sensors3.conf is for. Also, we most definintely
won't permit out-of-ABI attributes for something like this.

Guenter

>   drivers/hwmon/powr1220.c | 155 +++++++++++++++++++++++++++++++++++++++
>   1 file changed, 155 insertions(+)
> 
> diff --git a/drivers/hwmon/powr1220.c b/drivers/hwmon/powr1220.c
> index ad7a82f132e6..7cb2a6d3b3d8 100644
> --- a/drivers/hwmon/powr1220.c
> +++ b/drivers/hwmon/powr1220.c
> @@ -74,6 +74,14 @@ enum powr1220_adc_values {
>   	MAX_POWR1220_ADC_VALUES
>   };
>   
> +/* Real value = (measured-value * factor) / divisor.
> + * A divisor of 0 disables scaling and is identical to factor==1 && divisor==1.
> + */
> +struct adc_scale {
> +	int factor;
> +	int divisor;
> +};
> +
>   struct powr1220_data {
>   	struct i2c_client *client;
>   	struct mutex update_lock;
> @@ -84,6 +92,7 @@ struct powr1220_data {
>   	/* values */
>   	int adc_maxes[MAX_POWR1220_ADC_VALUES];
>   	int adc_values[MAX_POWR1220_ADC_VALUES];
> +	struct adc_scale adc_scales[MAX_POWR1220_ADC_VALUES];
>   };
>   
>   static const char * const input_names[] = {
> @@ -184,6 +193,29 @@ static ssize_t powr1220_voltage_show(struct device *dev,
>   	return sprintf(buf, "%d\n", adc_val);
>   }
>   
> +static ssize_t powr1220_scaled_voltage_show(struct device *dev,
> +	struct device_attribute *dev_attr, char *buf)
> +{
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
> +	struct powr1220_data *data = dev_get_drvdata(dev);
> +	int adc_val = powr1220_read_adc(dev, attr->index);
> +	struct adc_scale *scale;
> +
> +	if (adc_val < 0)
> +		return adc_val;
> +
> +	scale = &data->adc_scales[attr->index];
> +	if (scale->divisor) {
> +		int64_t lscaled = adc_val;
> +
> +		lscaled *= scale->factor;
> +		lscaled /= scale->divisor;
> +		adc_val = (int) lscaled;
> +	}
> +
> +	return sprintf(buf, "%d\n", adc_val);
> +}
> +
>   /* Shows the maximum setting associated with the specified ADC channel */
>   static ssize_t powr1220_max_show(struct device *dev,
>   				 struct device_attribute *dev_attr, char *buf)
> @@ -204,6 +236,38 @@ static ssize_t powr1220_label_show(struct device *dev,
>   	return sprintf(buf, "%s\n", input_names[attr->index]);
>   }
>   
> +/* Shows the scale for the read value.
> + * real value = (measured value * factor) / divisor. n/0 means scaling disabled
> + * and raw values are printed.
> + */
> +static ssize_t powr1220_scale_show(struct device *dev,
> +	struct device_attribute *dev_attr, char *buf)
> +{
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
> +	struct powr1220_data *data = dev_get_drvdata(dev);
> +
> +	return sprintf(buf, "%d/%d\n", data->adc_scales[attr->index].factor,
> +		       data->adc_scales[attr->index].divisor);
> +}
> +
> +static ssize_t powr1220_scale_store(struct device *dev,
> +				    struct device_attribute *dev_attr,
> +				    const char *buf, size_t count)
> +{
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
> +	struct powr1220_data *data = dev_get_drvdata(dev);
> +	int factor;
> +	int divisor;
> +
> +	if (sscanf(buf, "%d/%d", &factor, &divisor) != 2)
> +		return -EINVAL;
> +
> +	data->adc_scales[attr->index].factor = factor;
> +	data->adc_scales[attr->index].divisor = divisor;
> +
> +	return count;
> +}
> +
>   static SENSOR_DEVICE_ATTR_RO(in0_input, powr1220_voltage, VMON1);
>   static SENSOR_DEVICE_ATTR_RO(in1_input, powr1220_voltage, VMON2);
>   static SENSOR_DEVICE_ATTR_RO(in2_input, powr1220_voltage, VMON3);
> @@ -219,6 +283,26 @@ static SENSOR_DEVICE_ATTR_RO(in11_input, powr1220_voltage, VMON12);
>   static SENSOR_DEVICE_ATTR_RO(in12_input, powr1220_voltage, VCCA);
>   static SENSOR_DEVICE_ATTR_RO(in13_input, powr1220_voltage, VCCINP);
>   
> +static SENSOR_DEVICE_ATTR_RO(in0_scaled_input, powr1220_scaled_voltage, VMON1);
> +static SENSOR_DEVICE_ATTR_RO(in1_scaled_input, powr1220_scaled_voltage, VMON2);
> +static SENSOR_DEVICE_ATTR_RO(in2_scaled_input, powr1220_scaled_voltage, VMON3);
> +static SENSOR_DEVICE_ATTR_RO(in3_scaled_input, powr1220_scaled_voltage, VMON4);
> +static SENSOR_DEVICE_ATTR_RO(in4_scaled_input, powr1220_scaled_voltage, VMON5);
> +static SENSOR_DEVICE_ATTR_RO(in5_scaled_input, powr1220_scaled_voltage, VMON6);
> +static SENSOR_DEVICE_ATTR_RO(in6_scaled_input, powr1220_scaled_voltage, VMON7);
> +static SENSOR_DEVICE_ATTR_RO(in7_scaled_input, powr1220_scaled_voltage, VMON8);
> +static SENSOR_DEVICE_ATTR_RO(in8_scaled_input, powr1220_scaled_voltage, VMON9);
> +static SENSOR_DEVICE_ATTR_RO(in9_scaled_input, powr1220_scaled_voltage,
> +			     VMON10);
> +static SENSOR_DEVICE_ATTR_RO(in10_scaled_input, powr1220_scaled_voltage,
> +			     VMON11);
> +static SENSOR_DEVICE_ATTR_RO(in11_scaled_input, powr1220_scaled_voltage,
> +			     VMON12);
> +static SENSOR_DEVICE_ATTR_RO(in12_scaled_input, powr1220_scaled_voltage,
> +			     VCCA);
> +static SENSOR_DEVICE_ATTR_RO(in13_scaled_input, powr1220_scaled_voltage,
> +			     VCCINP);
> +
>   static SENSOR_DEVICE_ATTR_RO(in0_highest, powr1220_max, VMON1);
>   static SENSOR_DEVICE_ATTR_RO(in1_highest, powr1220_max, VMON2);
>   static SENSOR_DEVICE_ATTR_RO(in2_highest, powr1220_max, VMON3);
> @@ -249,6 +333,21 @@ static SENSOR_DEVICE_ATTR_RO(in11_label, powr1220_label, VMON12);
>   static SENSOR_DEVICE_ATTR_RO(in12_label, powr1220_label, VCCA);
>   static SENSOR_DEVICE_ATTR_RO(in13_label, powr1220_label, VCCINP);
>   
> +static SENSOR_DEVICE_ATTR_RW(in0_scale, powr1220_scale, VMON1);
> +static SENSOR_DEVICE_ATTR_RW(in1_scale, powr1220_scale, VMON2);
> +static SENSOR_DEVICE_ATTR_RW(in2_scale, powr1220_scale, VMON3);
> +static SENSOR_DEVICE_ATTR_RW(in3_scale, powr1220_scale, VMON4);
> +static SENSOR_DEVICE_ATTR_RW(in4_scale, powr1220_scale, VMON5);
> +static SENSOR_DEVICE_ATTR_RW(in5_scale, powr1220_scale, VMON6);
> +static SENSOR_DEVICE_ATTR_RW(in6_scale, powr1220_scale, VMON7);
> +static SENSOR_DEVICE_ATTR_RW(in7_scale, powr1220_scale, VMON8);
> +static SENSOR_DEVICE_ATTR_RW(in8_scale, powr1220_scale, VMON9);
> +static SENSOR_DEVICE_ATTR_RW(in9_scale, powr1220_scale, VMON10);
> +static SENSOR_DEVICE_ATTR_RW(in10_scale, powr1220_scale, VMON11);
> +static SENSOR_DEVICE_ATTR_RW(in11_scale, powr1220_scale, VMON12);
> +static SENSOR_DEVICE_ATTR_RW(in12_scale, powr1220_scale, VCCA);
> +static SENSOR_DEVICE_ATTR_RW(in13_scale, powr1220_scale, VCCINP);
> +
>   static struct attribute *powr1014_attrs[] = {
>   	&sensor_dev_attr_in0_input.dev_attr.attr,
>   	&sensor_dev_attr_in1_input.dev_attr.attr,
> @@ -263,6 +362,19 @@ static struct attribute *powr1014_attrs[] = {
>   	&sensor_dev_attr_in12_input.dev_attr.attr,
>   	&sensor_dev_attr_in13_input.dev_attr.attr,
>   
> +	&sensor_dev_attr_in0_scaled_input.dev_attr.attr,
> +	&sensor_dev_attr_in1_scaled_input.dev_attr.attr,
> +	&sensor_dev_attr_in2_scaled_input.dev_attr.attr,
> +	&sensor_dev_attr_in3_scaled_input.dev_attr.attr,
> +	&sensor_dev_attr_in4_scaled_input.dev_attr.attr,
> +	&sensor_dev_attr_in5_scaled_input.dev_attr.attr,
> +	&sensor_dev_attr_in6_scaled_input.dev_attr.attr,
> +	&sensor_dev_attr_in7_scaled_input.dev_attr.attr,
> +	&sensor_dev_attr_in8_scaled_input.dev_attr.attr,
> +	&sensor_dev_attr_in9_scaled_input.dev_attr.attr,
> +	&sensor_dev_attr_in12_scaled_input.dev_attr.attr,
> +	&sensor_dev_attr_in13_scaled_input.dev_attr.attr,
> +
>   	&sensor_dev_attr_in0_highest.dev_attr.attr,
>   	&sensor_dev_attr_in1_highest.dev_attr.attr,
>   	&sensor_dev_attr_in2_highest.dev_attr.attr,
> @@ -289,6 +401,19 @@ static struct attribute *powr1014_attrs[] = {
>   	&sensor_dev_attr_in12_label.dev_attr.attr,
>   	&sensor_dev_attr_in13_label.dev_attr.attr,
>   
> +	&sensor_dev_attr_in0_scale.dev_attr.attr,
> +	&sensor_dev_attr_in1_scale.dev_attr.attr,
> +	&sensor_dev_attr_in2_scale.dev_attr.attr,
> +	&sensor_dev_attr_in3_scale.dev_attr.attr,
> +	&sensor_dev_attr_in4_scale.dev_attr.attr,
> +	&sensor_dev_attr_in5_scale.dev_attr.attr,
> +	&sensor_dev_attr_in6_scale.dev_attr.attr,
> +	&sensor_dev_attr_in7_scale.dev_attr.attr,
> +	&sensor_dev_attr_in8_scale.dev_attr.attr,
> +	&sensor_dev_attr_in9_scale.dev_attr.attr,
> +	&sensor_dev_attr_in12_scale.dev_attr.attr,
> +	&sensor_dev_attr_in13_scale.dev_attr.attr,
> +
>   	NULL
>   };
>   
> @@ -310,6 +435,21 @@ static struct attribute *powr1220_attrs[] = {
>   	&sensor_dev_attr_in12_input.dev_attr.attr,
>   	&sensor_dev_attr_in13_input.dev_attr.attr,
>   
> +	&sensor_dev_attr_in0_scaled_input.dev_attr.attr,
> +	&sensor_dev_attr_in1_scaled_input.dev_attr.attr,
> +	&sensor_dev_attr_in2_scaled_input.dev_attr.attr,
> +	&sensor_dev_attr_in3_scaled_input.dev_attr.attr,
> +	&sensor_dev_attr_in4_scaled_input.dev_attr.attr,
> +	&sensor_dev_attr_in5_scaled_input.dev_attr.attr,
> +	&sensor_dev_attr_in6_scaled_input.dev_attr.attr,
> +	&sensor_dev_attr_in7_scaled_input.dev_attr.attr,
> +	&sensor_dev_attr_in8_scaled_input.dev_attr.attr,
> +	&sensor_dev_attr_in9_scaled_input.dev_attr.attr,
> +	&sensor_dev_attr_in10_scaled_input.dev_attr.attr,
> +	&sensor_dev_attr_in11_scaled_input.dev_attr.attr,
> +	&sensor_dev_attr_in12_scaled_input.dev_attr.attr,
> +	&sensor_dev_attr_in13_scaled_input.dev_attr.attr,
> +
>   	&sensor_dev_attr_in0_highest.dev_attr.attr,
>   	&sensor_dev_attr_in1_highest.dev_attr.attr,
>   	&sensor_dev_attr_in2_highest.dev_attr.attr,
> @@ -340,6 +480,21 @@ static struct attribute *powr1220_attrs[] = {
>   	&sensor_dev_attr_in12_label.dev_attr.attr,
>   	&sensor_dev_attr_in13_label.dev_attr.attr,
>   
> +	&sensor_dev_attr_in0_scale.dev_attr.attr,
> +	&sensor_dev_attr_in1_scale.dev_attr.attr,
> +	&sensor_dev_attr_in2_scale.dev_attr.attr,
> +	&sensor_dev_attr_in3_scale.dev_attr.attr,
> +	&sensor_dev_attr_in4_scale.dev_attr.attr,
> +	&sensor_dev_attr_in5_scale.dev_attr.attr,
> +	&sensor_dev_attr_in6_scale.dev_attr.attr,
> +	&sensor_dev_attr_in7_scale.dev_attr.attr,
> +	&sensor_dev_attr_in8_scale.dev_attr.attr,
> +	&sensor_dev_attr_in9_scale.dev_attr.attr,
> +	&sensor_dev_attr_in10_scale.dev_attr.attr,
> +	&sensor_dev_attr_in11_scale.dev_attr.attr,
> +	&sensor_dev_attr_in12_scale.dev_attr.attr,
> +	&sensor_dev_attr_in13_scale.dev_attr.attr,
> +
>   	NULL
>   };
>   
> 

