Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7466AC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 15:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46ABB2064C
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 15:19:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UZLds2df"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728349AbgGIPTT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 11:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727978AbgGIPSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 11:18:30 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 227A9C08C5DD;
        Thu,  9 Jul 2020 08:18:30 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id k71so1264357pje.0;
        Thu, 09 Jul 2020 08:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5xl0XyGLiz621Hz7NTFNPX+jPGcTEmSc0n3IjULBj8o=;
        b=UZLds2df4+X4jjeJPcbXn87fx7lQomos6EyS0RzhIhBqJ0WGNjcWX3/OFgSg4QI42a
         JElxWtMJjnladNZIZsH9KyefLGsDvKP4Bb7hFtagJsGawKmJKnPhjVG2YvH5t4rDf+J2
         x0zgNFxCJmvLE1/2qmEYZh5cIm6g++4YeltyMuwmi4R3eDX1q1F0FyO5YDB7eUPNjAr9
         auFEISZQI7ShmR/O4vf56n4gjqHu+ZBf78QUhdapm8qgE1hZWfbMvF/STp1RnC1fM3WX
         eY4mJUmTczLAm5zJKx0S4Ed9npFRo0bQYOGJ0t6kQ3DBH6/WbM3khrRFw0VNmXPhW4mD
         QNDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=5xl0XyGLiz621Hz7NTFNPX+jPGcTEmSc0n3IjULBj8o=;
        b=URpwf4dFsZDK4H1mdfjyi8Qa3da6YYujTnmKlxUDz9zGhhW/g0/qAU/W2nAtvyo9O4
         qvVI4yQ3pUbZIdV2IxxfDGcjKovABgFd5fByXQgHSYsjmU8BZ5TOMm9gg4eniMnsZaju
         st4gqtii9wwBmMP5UVOYeMO4B5XnECfdAO9kHuYOceZ4SsX76RAU4dpuPA1R2Ljz8lgt
         iLkRhLQe0RY1KjXCoBH+HgzONKxIRPMe+lDhZ13bSAs/HM7LA45OQyFtp6GVtTuOnxV9
         /NMP4QGKXR1w/mIs96TQGWN88v/01LTIIxo4YH4Rs34UKWtGAIUe7KJbGzzBmmmjCV5J
         N9Ow==
X-Gm-Message-State: AOAM532EhTwLc8YyYztTppqVFTP32yXy61XLXcCoIk2nBvXcNR7/D02A
        slaof2LSL1oR0Hwcx121p4yH5AwPf98=
X-Google-Smtp-Source: ABdhPJw9Xl+8cevWRbwvodD7EwmFDvHxHyD3cFLKJC0/OnFN9mFcWxDnqyzz0z7Nb9WHcdx2bgvFLg==
X-Received: by 2002:a17:90a:a608:: with SMTP id c8mr527657pjq.114.1594307909539;
        Thu, 09 Jul 2020 08:18:29 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o12sm3241489pfu.188.2020.07.09.08.18.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Jul 2020 08:18:28 -0700 (PDT)
Date:   Thu, 9 Jul 2020 08:18:27 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Marius Zachmann <mail@mariuszachmann.de>
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] hwmon: corsair-cpro: add fan_target
Message-ID: <20200709151827.GA77769@roeck-us.net>
References: <20200709141413.30790-1-mail@mariuszachmann.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200709141413.30790-1-mail@mariuszachmann.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 09, 2020 at 04:14:13PM +0200, Marius Zachmann wrote:
> This adds fan_target entries to the corsair-cpro driver.
> Reading the attribute from the device does not seem possible, so
> it returns the last set value. (same as pwm)
> 
> send_usb_cmd now has one more argument, which is needed for the
>   fan_target command.
> 
> Signed-off-by: Marius Zachmann <mail@mariuszachmann.de>

Applied.

Thanks,
Guenter

> ---
> Change from v1:
> - use clamp_val instead of bounds checking
> 
> ---
>  Documentation/hwmon/corsair-cpro.rst |  3 ++
>  drivers/hwmon/corsair-cpro.c         | 61 ++++++++++++++++++++++------
>  2 files changed, 52 insertions(+), 12 deletions(-)
> 
> --
> 2.27.0
> 
> diff --git a/Documentation/hwmon/corsair-cpro.rst b/Documentation/hwmon/corsair-cpro.rst
> index 5913e23d764c..78820156f07d 100644
> --- a/Documentation/hwmon/corsair-cpro.rst
> +++ b/Documentation/hwmon/corsair-cpro.rst
> @@ -33,6 +33,9 @@ in2_input		Voltage on SATA 3.3v
>  temp[1-4]_input		Temperature on connected temperature sensors
>  fan[1-6]_input		Connected fan rpm.
>  fan[1-6]_label		Shows fan type as detected by the device.
> +fan[1-6]_target		Sets fan speed target rpm.
> +			When reading, it reports the last value if it was set by the driver.
> +			Otherwise returns 0.
>  pwm[1-6]		Sets the fan speed. Values from 0-255.
>  			When reading, it reports the last value if it was set by the driver.
>  			Otherwise returns 0.
> diff --git a/drivers/hwmon/corsair-cpro.c b/drivers/hwmon/corsair-cpro.c
> index a22583acc229..fe625190e3a1 100644
> --- a/drivers/hwmon/corsair-cpro.c
> +++ b/drivers/hwmon/corsair-cpro.c
> @@ -5,8 +5,8 @@
>   */
> 
>  #include <linux/bitops.h>
> -#include <linux/kernel.h>
>  #include <linux/hwmon.h>
> +#include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
>  #include <linux/slab.h>
> @@ -51,6 +51,12 @@
>  					 * send: byte 1 is fan number
>  					 * send: byte 2 is percentage from 0 - 100
>  					 */
> +#define CTL_SET_FAN_TARGET	0x24	/*
> +					 * set target rpm
> +					 * send: byte 1 is fan number
> +					 * send: byte 2-3 is target
> +					 * device accepts all values from 0x00 - 0xFFFF
> +					 */
> 
>  #define NUM_FANS		6
>  #define NUM_TEMP_SENSORS	4
> @@ -60,13 +66,14 @@ struct ccp_device {
>  	struct mutex mutex; /* whenever buffer is used, lock before send_usb_cmd */
>  	u8 *buffer;
>  	int pwm[6];
> +	int target[6];
>  	DECLARE_BITMAP(temp_cnct, NUM_TEMP_SENSORS);
>  	DECLARE_BITMAP(fan_cnct, NUM_FANS);
>  	char fan_label[6][LABEL_LENGTH];
>  };
> 
>  /* send command, check for error in response, response in ccp->buffer */
> -static int send_usb_cmd(struct ccp_device *ccp, u8 command, u8 byte1, u8 byte2)
> +static int send_usb_cmd(struct ccp_device *ccp, u8 command, u8 byte1, u8 byte2, u8 byte3)
>  {
>  	int actual_length;
>  	int ret;
> @@ -75,6 +82,7 @@ static int send_usb_cmd(struct ccp_device *ccp, u8 command, u8 byte1, u8 byte2)
>  	ccp->buffer[0] = command;
>  	ccp->buffer[1] = byte1;
>  	ccp->buffer[2] = byte2;
> +	ccp->buffer[3] = byte3;
> 
>  	ret = usb_bulk_msg(ccp->udev, usb_sndintpipe(ccp->udev, 2), ccp->buffer, OUT_BUFFER_SIZE,
>  			   &actual_length, 1000);
> @@ -103,7 +111,7 @@ static int get_data(struct ccp_device *ccp, int command, int channel)
> 
>  	mutex_lock(&ccp->mutex);
> 
> -	ret = send_usb_cmd(ccp, command, channel, 0);
> +	ret = send_usb_cmd(ccp, command, channel, 0, 0);
>  	if (ret)
>  		goto out_unlock;
> 
> @@ -128,7 +136,22 @@ static int set_pwm(struct ccp_device *ccp, int channel, long val)
> 
>  	mutex_lock(&ccp->mutex);
> 
> -	ret = send_usb_cmd(ccp, CTL_SET_FAN_FPWM, channel, val);
> +	ret = send_usb_cmd(ccp, CTL_SET_FAN_FPWM, channel, val, 0);
> +
> +	mutex_unlock(&ccp->mutex);
> +	return ret;
> +}
> +
> +static int set_target(struct ccp_device *ccp, int channel, long val)
> +{
> +	int ret;
> +
> +	val = clamp_val(val, 0, 0xFFFF);
> +	ccp->target[channel] = val;
> +
> +	mutex_lock(&ccp->mutex);
> +
> +	ret = send_usb_cmd(ccp, CTL_SET_FAN_TARGET, channel, val >> 8, val);
> 
>  	mutex_unlock(&ccp->mutex);
>  	return ret;
> @@ -183,6 +206,11 @@ static int ccp_read(struct device *dev, enum hwmon_sensor_types type,
>  				return ret;
>  			*val = ret;
>  			return 0;
> +		case hwmon_fan_target:
> +			/* how to read target values from the device is unknown */
> +			/* driver returns last set value or 0			*/
> +			*val = ccp->target[channel];
> +			return 0;
>  		default:
>  			break;
>  		}
> @@ -231,6 +259,13 @@ static int ccp_write(struct device *dev, enum hwmon_sensor_types type,
>  			break;
>  		}
>  		break;
> +	case hwmon_fan:
> +		switch (attr) {
> +		case hwmon_fan_target:
> +			return set_target(ccp, channel, val);
> +		default:
> +			break;
> +		}
>  	default:
>  		break;
>  	}
> @@ -266,6 +301,8 @@ static umode_t ccp_is_visible(const void *data, enum hwmon_sensor_types type,
>  			return 0444;
>  		case hwmon_fan_label:
>  			return 0444;
> +		case hwmon_fan_target:
> +			return 0644;
>  		default:
>  			break;
>  		}
> @@ -313,12 +350,12 @@ static const struct hwmon_channel_info *ccp_info[] = {
>  			   HWMON_T_INPUT
>  			   ),
>  	HWMON_CHANNEL_INFO(fan,
> -			   HWMON_F_INPUT | HWMON_F_LABEL,
> -			   HWMON_F_INPUT | HWMON_F_LABEL,
> -			   HWMON_F_INPUT | HWMON_F_LABEL,
> -			   HWMON_F_INPUT | HWMON_F_LABEL,
> -			   HWMON_F_INPUT | HWMON_F_LABEL,
> -			   HWMON_F_INPUT | HWMON_F_LABEL
> +			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_TARGET,
> +			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_TARGET,
> +			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_TARGET,
> +			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_TARGET,
> +			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_TARGET,
> +			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_TARGET
>  			   ),
>  	HWMON_CHANNEL_INFO(pwm,
>  			   HWMON_PWM_INPUT,
> @@ -348,7 +385,7 @@ static int get_fan_cnct(struct ccp_device *ccp)
>  	int mode;
>  	int ret;
> 
> -	ret = send_usb_cmd(ccp, CTL_GET_FAN_CNCT, 0, 0);
> +	ret = send_usb_cmd(ccp, CTL_GET_FAN_CNCT, 0, 0, 0);
>  	if (ret)
>  		return ret;
> 
> @@ -385,7 +422,7 @@ static int get_temp_cnct(struct ccp_device *ccp)
>  	int mode;
>  	int ret;
> 
> -	ret = send_usb_cmd(ccp, CTL_GET_TMP_CNCT, 0, 0);
> +	ret = send_usb_cmd(ccp, CTL_GET_TMP_CNCT, 0, 0, 0);
>  	if (ret)
>  		return ret;
