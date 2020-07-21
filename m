Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FAKE_REPLY_C,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3052C433E5
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 13:29:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D28A20792
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 13:29:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BHJfdxLC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727898AbgGUN3A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 09:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbgGUN27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 09:28:59 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73818C061794;
        Tue, 21 Jul 2020 06:28:59 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id m9so10739133pfh.0;
        Tue, 21 Jul 2020 06:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=zgqmIhx0YcKw4+C4bxLnSQpYZb5tzK0BJ+2edyxVkG4=;
        b=BHJfdxLCSUra/VXuy/hCTVKZN4ot94rnRLHDvbl2EGc4gu/u4e4dIOUILTsKeE08bX
         7afuY98QhuwWcR8U2qgd7u/47+HVMSL8YFAPsz8kOjh1f+5zxXKTVQOp1RPqrlHCw0yB
         GDYS9BslZGaVzMMLoPkMXk5egpOCEzw3yWiT6Ovf+EmOTXQFxTDztLcECCsQLEU+hGkV
         /vA/yuhMTPN/sXLJd9fI9zfkW9neQxs7fYeo8DFNkdlHgukmxTlLYdojrJsUudMw3+wN
         p+6pmygSCGswYe+haw5odTz+0NCcmFhSc58g7to2pQyzKKBduoPRkIrNKZ/pf6y4D2wl
         8maQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=zgqmIhx0YcKw4+C4bxLnSQpYZb5tzK0BJ+2edyxVkG4=;
        b=GZ6r27+R12iwqMAHxi2ARV7OidhetyPyl5QmOATfQr2KJ/VUzuY/mCwx0pRAOpCHgZ
         JwDXjrfaBEJfUVuTfmz97Ds0lyie+hYlVxyUXTHBduqVmr6B2mqmCy00E1eGEegyGcS/
         mgglHdkKQZwXakicpoo2EET5tXRk/GDeFjFRAK23RZCTPt+O1LJ0Xwfe4d9/Ef/2dgvI
         efeLy56CF6v1fyhoYx/9KyaJqLrOUq62jE2mz3bF7nf2TmD2NH8NqvhT3T/27xMBGCNc
         qpwf/7KNg/BlFK6UBGuV81lK9wo7GW0ziMb8xXQwQBlqeYDV0D8cPZICu/lALiHYTqUg
         knYw==
X-Gm-Message-State: AOAM531Ypkep/NqXk6EPynULj58495yHEy1KVXHO6nim2kzrl7sVx5NB
        Jzu2Rv8+o6rEQ+8Cwg3Gcro=
X-Google-Smtp-Source: ABdhPJw1uZHI7Nkj6RkoZ1b4wY/jydz5WXahPIeTkp2KaKMclJwNu40cGa1ML0/q8saxHliAQ5L3YA==
X-Received: by 2002:a62:1c8b:: with SMTP id c133mr25155694pfc.134.1595338138962;
        Tue, 21 Jul 2020 06:28:58 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s6sm20671677pfd.20.2020.07.21.06.28.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 Jul 2020 06:28:58 -0700 (PDT)
Date:   Tue, 21 Jul 2020 06:28:56 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Marius Zachmann <mail@mariuszachmann.de>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: corsair-cpro: add reading pwm values
Message-ID: <20200721132856.GA162181@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 21, 2020 at 10:54:47AM +0200, Marius Zachmann wrote:
> This adds the possibility for reading pwm values.
> These can not be read if the device is controlled via
> fan_target or a fan curve and will return an error in
> this case. Since an error is expected, this adds some
> rudimentary error handling.
> 
> Changes:
> - add CTL_GET_FAN_PWM and use it via get_data
> - pwm returns -ENODATA if the device returns error 0x12
> - fan_target now returns -ENODATA when the driver is
>   started or a pwm value is set.
> - add ccp_get_errno to determine errno from device error.
> - get_data now has a parameter to determine whether
>   to read one or two bytes of data.
> - update documentation
> - fix missing surname in MAINTAINERS
> 
> Signed-off-by: Marius Zachmann <mail@mariuszachmann.de>

Applied.

Thanks,
Guenter

> ---
>  Documentation/hwmon/corsair-cpro.rst |  7 ++-
>  MAINTAINERS                          |  2 +-
>  drivers/hwmon/corsair-cpro.c         | 64 +++++++++++++++++++---------
>  3 files changed, 48 insertions(+), 25 deletions(-)
> 
> diff --git a/Documentation/hwmon/corsair-cpro.rst b/Documentation/hwmon/corsair-cpro.rst
> index 78820156f07d..751f95476b57 100644
> --- a/Documentation/hwmon/corsair-cpro.rst
> +++ b/Documentation/hwmon/corsair-cpro.rst
> @@ -35,8 +35,7 @@ fan[1-6]_input		Connected fan rpm.
>  fan[1-6]_label		Shows fan type as detected by the device.
>  fan[1-6]_target		Sets fan speed target rpm.
>  			When reading, it reports the last value if it was set by the driver.
> -			Otherwise returns 0.
> -pwm[1-6]		Sets the fan speed. Values from 0-255.
> -			When reading, it reports the last value if it was set by the driver.
> -			Otherwise returns 0.
> +			Otherwise returns an error.
> +pwm[1-6]		Sets the fan speed. Values from 0-255. Can only be read if pwm
> +			was set directly.
>  ======================= =====================================================================
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 06607125b793..a93aefab91f1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4402,7 +4402,7 @@ F:	Documentation/hwmon/coretemp.rst
>  F:	drivers/hwmon/coretemp.c
> 
>  CORSAIR-CPRO HARDWARE MONITOR DRIVER
> -M:	Marius  <mail@mariuszachmann.de>
> +M:	Marius Zachmann <mail@mariuszachmann.de>
>  L:	linux-hwmon@vger.kernel.org
>  S:	Maintained
>  F:	drivers/hwmon/corsair-cpro.c
> diff --git a/drivers/hwmon/corsair-cpro.c b/drivers/hwmon/corsair-cpro.c
> index e8504267d0e8..591929ec217a 100644
> --- a/drivers/hwmon/corsair-cpro.c
> +++ b/drivers/hwmon/corsair-cpro.c
> @@ -36,11 +36,12 @@
>  					 * send: byte 1 is channel, rest zero
>  					 * rcv:  returns temp for channel in centi-degree celsius
>  					 * in bytes 1 and 2
> -					 * returns 17 in byte 0 if no sensor is connected
> +					 * returns 0x11 in byte 0 if no sensor is connected
>  					 */
>  #define CTL_GET_VOLT		0x12	/*
>  					 * send: byte 1 is rail number: 0 = 12v, 1 = 5v, 2 = 3.3v
>  					 * rcv:  returns millivolt in bytes 1,2
> +					 * returns error 0x10 if request is invalid
>  					 */
>  #define CTL_GET_FAN_CNCT	0x20	/*
>  					 * returns in bytes 1-6 for each fan:
> @@ -52,6 +53,12 @@
>  					 * send: byte 1 is channel, rest zero
>  					 * rcv:  returns rpm in bytes 1,2
>  					 */
> +#define CTL_GET_FAN_PWM		0x22	/*
> +					 * send: byte 1 is channel, rest zero
> +					 * rcv:  returns pwm in byte 1 if it was set
> +					 *	 returns error 0x12 if fan is controlled via
> +					 *	 fan_target or fan curve
> +					 */
>  #define CTL_SET_FAN_FPWM	0x23	/*
>  					 * set fixed pwm
>  					 * send: byte 1 is fan number
> @@ -73,13 +80,31 @@ struct ccp_device {
>  	struct completion wait_input_report;
>  	struct mutex mutex; /* whenever buffer is used, lock before send_usb_cmd */
>  	u8 *buffer;
> -	int pwm[6];
>  	int target[6];
>  	DECLARE_BITMAP(temp_cnct, NUM_TEMP_SENSORS);
>  	DECLARE_BITMAP(fan_cnct, NUM_FANS);
>  	char fan_label[6][LABEL_LENGTH];
>  };
> 
> +/* converts response error in buffer to errno */
> +static int ccp_get_errno(struct ccp_device *ccp)
> +{
> +	switch (ccp->buffer[0]) {
> +	case 0x00: /* success */
> +		return 0;
> +	case 0x01: /* called invalid command */
> +		return -EOPNOTSUPP;
> +	case 0x10: /* called GET_VOLT / GET_TMP with invalid arguments */
> +		return -EINVAL;
> +	case 0x11: /* requested temps of disconnected sensors */
> +	case 0x12: /* requested pwm of not pwm controlled channels */
> +		return -ENODATA;
> +	default:
> +		hid_dbg(ccp->hdev, "unknown device response error: %d", ccp->buffer[0]);
> +		return -EIO;
> +	}
> +}
> +
>  /* send command, check for error in response, response in ccp->buffer */
>  static int send_usb_cmd(struct ccp_device *ccp, u8 command, u8 byte1, u8 byte2, u8 byte3)
>  {
> @@ -102,13 +127,7 @@ static int send_usb_cmd(struct ccp_device *ccp, u8 command, u8 byte1, u8 byte2,
>  	if (!t)
>  		return -ETIMEDOUT;
> 
> -	/* first byte of response is error code */
> -	if (ccp->buffer[0] != 0x00) {
> -		hid_dbg(ccp->hdev, "device response error: %d", ccp->buffer[0]);
> -		return -EIO;
> -	}
> -
> -	return 0;
> +	return ccp_get_errno(ccp);
>  }
> 
>  static int ccp_raw_event(struct hid_device *hdev, struct hid_report *report, u8 *data, int size)
> @@ -126,7 +145,7 @@ static int ccp_raw_event(struct hid_device *hdev, struct hid_report *report, u8
>  }
> 
>  /* requests and returns single data values depending on channel */
> -static int get_data(struct ccp_device *ccp, int command, int channel)
> +static int get_data(struct ccp_device *ccp, int command, int channel, bool two_byte_data)
>  {
>  	int ret;
> 
> @@ -136,7 +155,9 @@ static int get_data(struct ccp_device *ccp, int command, int channel)
>  	if (ret)
>  		goto out_unlock;
> 
> -	ret = (ccp->buffer[1] << 8) + ccp->buffer[2];
> +	ret = ccp->buffer[1];
> +	if (two_byte_data)
> +		ret = (ret << 8) + ccp->buffer[2];
> 
>  out_unlock:
>  	mutex_unlock(&ccp->mutex);
> @@ -150,14 +171,14 @@ static int set_pwm(struct ccp_device *ccp, int channel, long val)
>  	if (val < 0 || val > 255)
>  		return -EINVAL;
> 
> -	ccp->pwm[channel] = val;
> -
>  	/* The Corsair Commander Pro uses values from 0-100 */
>  	val = DIV_ROUND_CLOSEST(val * 100, 255);
> 
>  	mutex_lock(&ccp->mutex);
> 
>  	ret = send_usb_cmd(ccp, CTL_SET_FAN_FPWM, channel, val, 0);
> +	if (!ret)
> +		ccp->target[channel] = -ENODATA;
> 
>  	mutex_unlock(&ccp->mutex);
>  	return ret;
> @@ -171,7 +192,6 @@ static int set_target(struct ccp_device *ccp, int channel, long val)
>  	ccp->target[channel] = val;
> 
>  	mutex_lock(&ccp->mutex);
> -
>  	ret = send_usb_cmd(ccp, CTL_SET_FAN_TARGET, channel, val >> 8, val);
> 
>  	mutex_unlock(&ccp->mutex);
> @@ -210,7 +230,7 @@ static int ccp_read(struct device *dev, enum hwmon_sensor_types type,
>  	case hwmon_temp:
>  		switch (attr) {
>  		case hwmon_temp_input:
> -			ret = get_data(ccp, CTL_GET_TMP, channel);
> +			ret = get_data(ccp, CTL_GET_TMP, channel, true);
>  			if (ret < 0)
>  				return ret;
>  			*val = ret * 10;
> @@ -222,7 +242,7 @@ static int ccp_read(struct device *dev, enum hwmon_sensor_types type,
>  	case hwmon_fan:
>  		switch (attr) {
>  		case hwmon_fan_input:
> -			ret = get_data(ccp, CTL_GET_FAN_RPM, channel);
> +			ret = get_data(ccp, CTL_GET_FAN_RPM, channel, true);
>  			if (ret < 0)
>  				return ret;
>  			*val = ret;
> @@ -230,6 +250,8 @@ static int ccp_read(struct device *dev, enum hwmon_sensor_types type,
>  		case hwmon_fan_target:
>  			/* how to read target values from the device is unknown */
>  			/* driver returns last set value or 0			*/
> +			if (ccp->target[channel] < 0)
> +				return -ENODATA;
>  			*val = ccp->target[channel];
>  			return 0;
>  		default:
> @@ -239,9 +261,10 @@ static int ccp_read(struct device *dev, enum hwmon_sensor_types type,
>  	case hwmon_pwm:
>  		switch (attr) {
>  		case hwmon_pwm_input:
> -			/* how to read pwm values from the device is currently unknown */
> -			/* driver returns last set value or 0		               */
> -			*val = ccp->pwm[channel];
> +			ret = get_data(ccp, CTL_GET_FAN_PWM, channel, false);
> +			if (ret < 0)
> +				return ret;
> +			*val = DIV_ROUND_CLOSEST(ret * 255, 100);
>  			return 0;
>  		default:
>  			break;
> @@ -250,7 +273,7 @@ static int ccp_read(struct device *dev, enum hwmon_sensor_types type,
>  	case hwmon_in:
>  		switch (attr) {
>  		case hwmon_in_input:
> -			ret = get_data(ccp, CTL_GET_VOLT, channel);
> +			ret = get_data(ccp, CTL_GET_VOLT, channel, true);
>  			if (ret < 0)
>  				return ret;
>  			*val = ret;
> @@ -416,6 +439,7 @@ static int get_fan_cnct(struct ccp_device *ccp)
>  			continue;
> 
>  		set_bit(channel, ccp->fan_cnct);
> +		ccp->target[channel] = -ENODATA;
> 
>  		switch (mode) {
>  		case 1:
> --
> 2.27.0
