Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A9D3C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 21:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48BF2206BE
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 21:28:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HX/TzAjb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728786AbgGGV2S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 17:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728184AbgGGV2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 17:28:17 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 855EAC061755;
        Tue,  7 Jul 2020 14:28:17 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id mn17so225911pjb.4;
        Tue, 07 Jul 2020 14:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gSkgBnt6WS8ekVEtq3KVzRldyBrMI9/O865dgSe8GaM=;
        b=HX/TzAjbEaCSzKdvbg2rNp4V8Cti0Nnp9afS7c2yV1XTTUUW65d6y7notgleLwqGQu
         UzcJJiVeGfLqIH4XVbGNwG9CiFOKp+yO1wc7KJbAvlVkb9s7FCNrNTscONcMmTW27KEd
         6h47rDQ6oXA2GZbJMNAsBj9bnXgxIudPTDa1ZZcOMRhUY/EoZOim+cTWVeI2uSo77+IE
         n8I+jWqXWBjj3Nns2th6HCZZhOwy6e/vK2kzItGTDzQZYU1q/LCuNQfWgdDzZHR75J+w
         nLo6N75YUJKBGI1IPdAj9htreykwMbgDq3LnLzgj80fW1vGaLpGx8IiBXM4z7Epokyfc
         dLLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=gSkgBnt6WS8ekVEtq3KVzRldyBrMI9/O865dgSe8GaM=;
        b=lFNVt99HSD15Ed2ejv91++/DHkulGSE2TokCY2T2qj5+toSNIfDh6xRpOW2pNvOM2U
         59ZYZr4b/uUlmCiIhgK6eOkgX7OsCVKlBSnuJZ2UFcynxsG1Y6LaiujH0AwQ55mcbw6n
         6juIkPjh2TLlz35x8hImyPieG70dZYwEk1Yn+GmOAME6OOarPVn48jHi+3kKDmshyDeg
         b+asEIw39AMCkkbV2TYe2c4lLfj1qz4adX3Z5/h+ydM/N9R7nHpDia70W2JdCK3UBMnW
         OViiYFZmNHKkuNjA3DAEm1HP8V3N8RBaW0mGuJpsLluvQ7cjqdg/UiH+txX6syThc0o9
         aI1A==
X-Gm-Message-State: AOAM531YNaRFHbEs62aIb1rAyc2GNWPN/o8+LIOTGm844cCHjY14QBLk
        Eab6FjPx5S9qGEOteQ7vtew=
X-Google-Smtp-Source: ABdhPJxseQCo/mbp3wysDsrgYax75Siu12bVpFcUlyb5tf/qNV9Q2lfb86L+/ZKHJvzQB4dynBqnVg==
X-Received: by 2002:a17:902:b187:: with SMTP id s7mr43189820plr.188.1594157296937;
        Tue, 07 Jul 2020 14:28:16 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c188sm23088732pfc.143.2020.07.07.14.28.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Jul 2020 14:28:16 -0700 (PDT)
Date:   Tue, 7 Jul 2020 14:28:14 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Chu Lin <linchuyuan@google.com>
Cc:     belgaied@google.com, jasonling@google.com, jdelvare@suse.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhongqil@google.com
Subject: Re: [PATCH v4] hwmon:max6697: Allow max6581 to create tempX_offset
Message-ID: <20200707212814.GA12721@roeck-us.net>
References: <20200707171528.2929275-1-linchuyuan@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200707171528.2929275-1-linchuyuan@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 07, 2020 at 05:15:28PM +0000, Chu Lin wrote:
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

Applied, after fixing a checkpatch warning (unnecessary { }).

Thanks,
Guenter

> ---
> ChangeLog v3 -> v4:
>   - Check if a particular channel is disabled/enabled before flipping
>     state
>   - Make sure the RW operation is mux protected to avoid the situation
>     where the user is able to modify the offset select value after it is
>     read
>   - indentation cleanup
>   - Use label to make sure the lock is released
>   - Fix a typo where the channel index should be /7 instead of /8
> 
> ChangeLog v2 -> v3:
>   - Use reverse christmas tree order convension
>   - Fix the type issue where comparision is always true
>   - Change the line limit to 100 char instead of 80 char
> 
> ChangeLog v1 -> v2:
>   - Simplify the offset reg raw value to milli ceisus conversion
>   - Substitute the temp1_offset with dummy attr
>   - Avoid using double negative in the macro definition
>   - Return the actual error when i2c read/write is failed
>   - clamp the value to MAX or MIN respectively if an out of range input is given
>   - Provide mux protection when multiple i2c accesses is required
> 
>  drivers/hwmon/max6697.c | 97 ++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 95 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwmon/max6697.c b/drivers/hwmon/max6697.c
> index 64122eb38060..5b4e72d8df00 100644
> --- a/drivers/hwmon/max6697.c
> +++ b/drivers/hwmon/max6697.c
> @@ -57,6 +57,8 @@ static const u8 MAX6697_REG_CRIT[] = {
>  #define MAX6581_REG_IDEALITY_SELECT	0x4c
>  #define MAX6581_REG_OFFSET		0x4d
>  #define MAX6581_REG_OFFSET_SELECT	0x4e
> +#define MAX6581_OFFSET_MIN		-31750
> +#define MAX6581_OFFSET_MAX		31750
>  
>  #define MAX6697_CONV_TIME		156	/* ms per channel, worst case */
>  
> @@ -172,6 +174,11 @@ static const struct max6697_chip_data max6697_chip_data[] = {
>  	},
>  };
>  
> +static inline int max6581_offset_to_millic(int val)
> +{
> +	return sign_extend32(val, 7) * 250;
> +}
> +
>  static struct max6697_data *max6697_update_device(struct device *dev)
>  {
>  	struct max6697_data *data = dev_get_drvdata(dev);
> @@ -317,6 +324,71 @@ static ssize_t temp_store(struct device *dev,
>  	return ret < 0 ? ret : count;
>  }
>  
> +static ssize_t offset_store(struct device *dev, struct device_attribute *devattr, const char *buf,
> +			    size_t count)
> +{
> +	int val, ret, index, select;
> +	struct max6697_data *data;
> +	bool channel_enabled;
> +	long temp;
> +
> +	index = to_sensor_dev_attr(devattr)->index;
> +	data = dev_get_drvdata(dev);
> +	ret = kstrtol(buf, 10, &temp);
> +	if (ret < 0)
> +		return ret;
> +
> +	mutex_lock(&data->update_lock);
> +	select = i2c_smbus_read_byte_data(data->client, MAX6581_REG_OFFSET_SELECT);
> +	if (select < 0) {
> +		ret = select;
> +		goto abort;
> +	}
> +	channel_enabled = (select & (1 << (index - 1)));
> +	temp = clamp_val(temp, MAX6581_OFFSET_MIN, MAX6581_OFFSET_MAX);
> +	val = DIV_ROUND_CLOSEST(temp, 250);
> +	/* disable the offset for channel if the new offset is 0 */
> +	if (val == 0) {
> +		if (channel_enabled)
> +			ret = i2c_smbus_write_byte_data(data->client, MAX6581_REG_OFFSET_SELECT,
> +							select & ~(1 << (index - 1)));
> +		ret = ret < 0 ? ret : count;
> +		goto abort;
> +	}
> +	if (!channel_enabled) {
> +		ret = i2c_smbus_write_byte_data(data->client, MAX6581_REG_OFFSET_SELECT,
> +						select | (1 << (index - 1)));
> +		if (ret < 0)
> +			goto abort;
> +	}
> +	ret = i2c_smbus_write_byte_data(data->client, MAX6581_REG_OFFSET, val);
> +	ret = ret < 0 ? ret : count;
> +
> +abort:
> +	mutex_unlock(&data->update_lock);
> +	return ret;
> +}
> +
> +static ssize_t offset_show(struct device *dev, struct device_attribute *devattr, char *buf)
> +{
> +	struct max6697_data *data;
> +	int select, ret, index;
> +
> +	index = to_sensor_dev_attr(devattr)->index;
> +	data = dev_get_drvdata(dev);
> +	mutex_lock(&data->update_lock);
> +	select = i2c_smbus_read_byte_data(data->client, MAX6581_REG_OFFSET_SELECT);
> +	if (select < 0) {
> +		ret = select;
> +	} else if (select & (1 << (index - 1))) {
> +		ret = i2c_smbus_read_byte_data(data->client, MAX6581_REG_OFFSET);
> +	} else {
> +		ret = 0;
> +	}
> +	mutex_unlock(&data->update_lock);
> +	return ret < 0 ? ret : sprintf(buf, "%d\n", max6581_offset_to_millic(ret));
> +}
> +
>  static SENSOR_DEVICE_ATTR_RO(temp1_input, temp_input, 0);
>  static SENSOR_DEVICE_ATTR_2_RW(temp1_max, temp, 0, MAX6697_TEMP_MAX);
>  static SENSOR_DEVICE_ATTR_2_RW(temp1_crit, temp, 0, MAX6697_TEMP_CRIT);
> @@ -375,6 +447,15 @@ static SENSOR_DEVICE_ATTR_RO(temp6_fault, alarm, 5);
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
> @@ -383,8 +464,8 @@ static umode_t max6697_is_visible(struct kobject *kobj, struct attribute *attr,
>  	struct device *dev = container_of(kobj, struct device, kobj);
>  	struct max6697_data *data = dev_get_drvdata(dev);
>  	const struct max6697_chip_data *chip = data->chip;
> -	int channel = index / 6;	/* channel number */
> -	int nr = index % 6;		/* attribute index within channel */
> +	int channel = index / 7;	/* channel number */
> +	int nr = index % 7;		/* attribute index within channel */
>  
>  	if (channel >= chip->channels)
>  		return 0;
> @@ -393,6 +474,10 @@ static umode_t max6697_is_visible(struct kobject *kobj, struct attribute *attr,
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
> @@ -409,6 +494,7 @@ static struct attribute *max6697_attributes[] = {
>  	&sensor_dev_attr_temp1_crit.dev_attr.attr,
>  	&sensor_dev_attr_temp1_crit_alarm.dev_attr.attr,
>  	&dev_attr_dummy.attr,
> +	&dev_attr_dummy.attr,
>  
>  	&sensor_dev_attr_temp2_input.dev_attr.attr,
>  	&sensor_dev_attr_temp2_max.dev_attr.attr,
> @@ -416,6 +502,7 @@ static struct attribute *max6697_attributes[] = {
>  	&sensor_dev_attr_temp2_crit.dev_attr.attr,
>  	&sensor_dev_attr_temp2_crit_alarm.dev_attr.attr,
>  	&sensor_dev_attr_temp2_fault.dev_attr.attr,
> +	&sensor_dev_attr_temp2_offset.dev_attr.attr,
>  
>  	&sensor_dev_attr_temp3_input.dev_attr.attr,
>  	&sensor_dev_attr_temp3_max.dev_attr.attr,
> @@ -423,6 +510,7 @@ static struct attribute *max6697_attributes[] = {
>  	&sensor_dev_attr_temp3_crit.dev_attr.attr,
>  	&sensor_dev_attr_temp3_crit_alarm.dev_attr.attr,
>  	&sensor_dev_attr_temp3_fault.dev_attr.attr,
> +	&sensor_dev_attr_temp3_offset.dev_attr.attr,
>  
>  	&sensor_dev_attr_temp4_input.dev_attr.attr,
>  	&sensor_dev_attr_temp4_max.dev_attr.attr,
> @@ -430,6 +518,7 @@ static struct attribute *max6697_attributes[] = {
>  	&sensor_dev_attr_temp4_crit.dev_attr.attr,
>  	&sensor_dev_attr_temp4_crit_alarm.dev_attr.attr,
>  	&sensor_dev_attr_temp4_fault.dev_attr.attr,
> +	&sensor_dev_attr_temp4_offset.dev_attr.attr,
>  
>  	&sensor_dev_attr_temp5_input.dev_attr.attr,
>  	&sensor_dev_attr_temp5_max.dev_attr.attr,
> @@ -437,6 +526,7 @@ static struct attribute *max6697_attributes[] = {
>  	&sensor_dev_attr_temp5_crit.dev_attr.attr,
>  	&sensor_dev_attr_temp5_crit_alarm.dev_attr.attr,
>  	&sensor_dev_attr_temp5_fault.dev_attr.attr,
> +	&sensor_dev_attr_temp5_offset.dev_attr.attr,
>  
>  	&sensor_dev_attr_temp6_input.dev_attr.attr,
>  	&sensor_dev_attr_temp6_max.dev_attr.attr,
> @@ -444,6 +534,7 @@ static struct attribute *max6697_attributes[] = {
>  	&sensor_dev_attr_temp6_crit.dev_attr.attr,
>  	&sensor_dev_attr_temp6_crit_alarm.dev_attr.attr,
>  	&sensor_dev_attr_temp6_fault.dev_attr.attr,
> +	&sensor_dev_attr_temp6_offset.dev_attr.attr,
>  
>  	&sensor_dev_attr_temp7_input.dev_attr.attr,
>  	&sensor_dev_attr_temp7_max.dev_attr.attr,
> @@ -451,6 +542,7 @@ static struct attribute *max6697_attributes[] = {
>  	&sensor_dev_attr_temp7_crit.dev_attr.attr,
>  	&sensor_dev_attr_temp7_crit_alarm.dev_attr.attr,
>  	&sensor_dev_attr_temp7_fault.dev_attr.attr,
> +	&sensor_dev_attr_temp7_offset.dev_attr.attr,
>  
>  	&sensor_dev_attr_temp8_input.dev_attr.attr,
>  	&sensor_dev_attr_temp8_max.dev_attr.attr,
> @@ -458,6 +550,7 @@ static struct attribute *max6697_attributes[] = {
>  	&sensor_dev_attr_temp8_crit.dev_attr.attr,
>  	&sensor_dev_attr_temp8_crit_alarm.dev_attr.attr,
>  	&sensor_dev_attr_temp8_fault.dev_attr.attr,
> +	&sensor_dev_attr_temp8_offset.dev_attr.attr,
>  	NULL
>  };
>  
