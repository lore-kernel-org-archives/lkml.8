Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7422C433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 14:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF30E2074B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 14:01:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oGfdVkPa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbgGIOBi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 10:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbgGIOBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 10:01:37 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FEBBC08C5CE;
        Thu,  9 Jul 2020 07:01:37 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id l63so1004493pge.12;
        Thu, 09 Jul 2020 07:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NEOz/+dYEKltf/Afv4NXx7vYr8cUcobGnfdo+jwjuq4=;
        b=oGfdVkPaw/KVerbh/jwrh5Eme6+UE1Ov0hPrcL19asfiB/KB0mojMzOfIi0KOJTrok
         YgJfE0PKCiIy/lRsqNK5UA5pS5ShxYq6kVriDbfqQQq+Q0X3zy/nd5ScZZQdP81aEMrY
         rM1Qip557Zlw2/VV2Eb1lmmsHW54OiBUYRW6ejHs/25FpRCPFU4Qy24Bp75CpAiHfWhh
         VtNNDEH88yfWktYRTNBDbaoSdbXRr1lACNDPE5LOq3Fq22P+kphzTyycybGcaYeeo7KQ
         oCXhr1oeth8VmEg+hbS7xR9Ay1j1v6By0xdOmyyJgzCrknE4xc1qKReGa5/xRJ/0vt7c
         KRBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=NEOz/+dYEKltf/Afv4NXx7vYr8cUcobGnfdo+jwjuq4=;
        b=FfSJ0UMg0/4ptf5yk0CgsY2nPHWPtBXXLZdQLGo0totJcWY499RR4fAqZVNt5JBZag
         5e7CEnjiEYEMWUdeawkVxsFzDmMdk5l7n0D3qy3TSYyfgVY1N9KhwXkT/QkRn6WsUdjo
         z7WAG/3/+R4A5Yp3kZH+aTD1qHjO5VjXWkg/C1pUZxO0/pweqhpeLY0E2deVVTXLri2B
         77Yi4JUkydi/IVaiPmn3ZBjfnEzd0wlooVWiwrlGCueZgp+nkswd2761r7icV12LrZvu
         wtzfmECndPwer80VowOD5SMczkF+Y9MvHBj3iooyh0ZkqxSz/JCwofUIRGrL5bohm0wP
         MgJA==
X-Gm-Message-State: AOAM533W4oEtqdWg0ceZdbeOPXQF1ocorvkbasiMsf+vWtC99iIeMsBo
        TqBNVrP3M+Q5EC0hDtR2YLykEU1op7s=
X-Google-Smtp-Source: ABdhPJwhBJ/xOmahcpLOzDy/gF/KFTidiBfk1GEmueonBgle1sab7N4bvPQKS6F4yjkeMR2AKEjvTw==
X-Received: by 2002:a63:417:: with SMTP id 23mr51185366pge.44.1594303296787;
        Thu, 09 Jul 2020 07:01:36 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f14sm2926191pgj.62.2020.07.09.07.01.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Jul 2020 07:01:35 -0700 (PDT)
Date:   Thu, 9 Jul 2020 07:01:34 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Marius Zachmann <mail@mariuszachmann.de>
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: corsair-cpro: add fan_target
Message-ID: <20200709140134.GA61434@roeck-us.net>
References: <20200709112439.6069-1-mail@mariuszachmann.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200709112439.6069-1-mail@mariuszachmann.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 09, 2020 at 01:24:39PM +0200, Marius Zachmann wrote:
> This adds fan_target entries to the corsair-cpro driver.
> Reading the attribute from the device does not seem possible, so
> it returns the last set value. (same as pwm)
> 
> Furthermore:
> - removes unnecessary kernel.h include.
> - send_usb_cmd now has one more argument which is needed for the
>   fan_target command.
> 
> Signed-off-by: Marius Zachmann <mail@mariuszachmann.de>
> ---
>  Documentation/hwmon/corsair-cpro.rst |  3 ++
>  drivers/hwmon/corsair-cpro.c         | 62 ++++++++++++++++++++++------
>  2 files changed, 53 insertions(+), 12 deletions(-)
> 
> --
> 2.27.0
> 
> diff --git a/Documentation/hwmon/corsair-cpro.rst b/Documentation/hwmon/corsair-cpro.rst
> index 5913e23d764c..080f063d74b6 100644
> --- a/Documentation/hwmon/corsair-cpro.rst
> +++ b/Documentation/hwmon/corsair-cpro.rst
> @@ -33,6 +33,9 @@ in2_input		Voltage on SATA 3.3v
>  temp[1-4]_input		Temperature on connected temperature sensors
>  fan[1-6]_input		Connected fan rpm.
>  fan[1-6]_label		Shows fan type as detected by the device.
> +fan[1-6]_set_target	Sets fan speed target rpm. Values from 0-65535.
> +			When reading, it reports the last value if it was set by the driver.
> +			Otherwise returns 0.
>  pwm[1-6]		Sets the fan speed. Values from 0-255.
>  			When reading, it reports the last value if it was set by the driver.
>  			Otherwise returns 0.
> diff --git a/drivers/hwmon/corsair-cpro.c b/drivers/hwmon/corsair-cpro.c
> index a22583acc229..a2cb2b474f08 100644
> --- a/drivers/hwmon/corsair-cpro.c
> +++ b/drivers/hwmon/corsair-cpro.c
> @@ -5,7 +5,6 @@
>   */
> 
>  #include <linux/bitops.h>
> -#include <linux/kernel.h>
>  #include <linux/hwmon.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
> @@ -51,6 +50,12 @@
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
> @@ -60,13 +65,14 @@ struct ccp_device {
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
> @@ -75,6 +81,7 @@ static int send_usb_cmd(struct ccp_device *ccp, u8 command, u8 byte1, u8 byte2)
>  	ccp->buffer[0] = command;
>  	ccp->buffer[1] = byte1;
>  	ccp->buffer[2] = byte2;
> +	ccp->buffer[3] = byte3;
> 
>  	ret = usb_bulk_msg(ccp->udev, usb_sndintpipe(ccp->udev, 2), ccp->buffer, OUT_BUFFER_SIZE,
>  			   &actual_length, 1000);
> @@ -103,7 +110,7 @@ static int get_data(struct ccp_device *ccp, int command, int channel)
> 
>  	mutex_lock(&ccp->mutex);
> 
> -	ret = send_usb_cmd(ccp, command, channel, 0);
> +	ret = send_usb_cmd(ccp, command, channel, 0, 0);
>  	if (ret)
>  		goto out_unlock;
> 
> @@ -128,7 +135,24 @@ static int set_pwm(struct ccp_device *ccp, int channel, long val)
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
> +	if (val < 0 || val > 0xFFFF)
> +		return -EINVAL;

Please use clamp_val() here. We don't expect users to know the limits.
That is different to pwm, which has a well known range of 0..255.
Of course, that means you still need the kernel.h include.

> +
> +	ccp->target[channel] = val;
> +
> +	mutex_lock(&ccp->mutex);
> +
> +	ret = send_usb_cmd(ccp, CTL_SET_FAN_TARGET, channel, val >> 8, val);
> 
>  	mutex_unlock(&ccp->mutex);
>  	return ret;
> @@ -183,6 +207,11 @@ static int ccp_read(struct device *dev, enum hwmon_sensor_types type,
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
> @@ -231,6 +260,13 @@ static int ccp_write(struct device *dev, enum hwmon_sensor_types type,
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
> @@ -266,6 +302,8 @@ static umode_t ccp_is_visible(const void *data, enum hwmon_sensor_types type,
>  			return 0444;
>  		case hwmon_fan_label:
>  			return 0444;
> +		case hwmon_fan_target:
> +			return 0644;
>  		default:
>  			break;
>  		}
> @@ -313,12 +351,12 @@ static const struct hwmon_channel_info *ccp_info[] = {
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
> @@ -348,7 +386,7 @@ static int get_fan_cnct(struct ccp_device *ccp)
>  	int mode;
>  	int ret;
> 
> -	ret = send_usb_cmd(ccp, CTL_GET_FAN_CNCT, 0, 0);
> +	ret = send_usb_cmd(ccp, CTL_GET_FAN_CNCT, 0, 0, 0);
>  	if (ret)
>  		return ret;
> 
> @@ -385,7 +423,7 @@ static int get_temp_cnct(struct ccp_device *ccp)
>  	int mode;
>  	int ret;
> 
> -	ret = send_usb_cmd(ccp, CTL_GET_TMP_CNCT, 0, 0);
> +	ret = send_usb_cmd(ccp, CTL_GET_TMP_CNCT, 0, 0, 0);
>  	if (ret)
>  		return ret;
