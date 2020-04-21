Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBDDFC55181
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 09:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B44B520857
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 09:24:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aLJd8H6A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728383AbgDUJYg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 05:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726120AbgDUJYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 05:24:34 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 050A4C061A0F;
        Tue, 21 Apr 2020 02:24:33 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id n24so5030905plp.13;
        Tue, 21 Apr 2020 02:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZGj2SR/tpmJ9eUFLsUH93RFW66eXhE5k6sntOR0R8xM=;
        b=aLJd8H6A+plpbdrJuJQqq3KEoCj/gHPWI3dwnlETlRwiQXyhjgB5rX+MhYtnFPQHxo
         L9MzAlH+RzklFU11BoCjEC+7fZzg7junPqF2PWMiybtgMwyIoWez7LABsKDUs6v0H1Kz
         Bkd6/59wAeh/wUPudj2n9qqhBelhrp+Lj98gjN8/yvt9cSVdaNqWrL6kjrTsNzfw3Srm
         qd503olfRFjMEy6pfZ1hnMEITfwPBcE5Q8cghi3Nv0NK/u2lgRrL4j7yAW5hYuBmYKzv
         K4fbnbOxiPmCj9NH6r/f3mkWiWME0fzNjysDyuf5moH63TJJto1onwXc4WVP2sX1A7A1
         u0Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ZGj2SR/tpmJ9eUFLsUH93RFW66eXhE5k6sntOR0R8xM=;
        b=M5Ki7hvG2gVxI7RLNLml7rL4976O13Hp4ePtn+Ypkn04R5nlePJsio2DskaSVt3lXs
         H3f1+w+R9b1khSLqmtn308PoV900YfEAogM80RSq8XHz1qVRJOVsjsyb7uz/mzcChaV8
         y7ehQY0HtjaQaeNRT+OEo9HJe1cuwIRgQAHE8ojcYp1WeC4eG7oHfqpm3GuZZ61VO1Cu
         dExjXnaR/CxvgOEvQUEnhQFxC67zteZhPD9LxqYJBBxnqBRZo1mTctwQdRKj9yCEhgei
         2FdsSbXDO0UQSgCeSo79OskqDpDU3KJP6o2eIBQdbzuxy80AVlSX5PM4YR9bGqipvRTi
         4NpQ==
X-Gm-Message-State: AGi0PubKSIHIzsRy2V0nQSGCsywHIfT/fLj/q6rtQ4NW/ePxsL0u95xr
        fjXLeCGAQrJk/Il7K5gb1QHNBRJH
X-Google-Smtp-Source: APiQypJzrms+vnoUNREYegbISHscFldNrHf80LJVGyxRiUEWeGF6Jp/lE+vyRwqSQu3zXzUx50aNhg==
X-Received: by 2002:a17:90a:ea07:: with SMTP id w7mr4467278pjy.172.1587461072289;
        Tue, 21 Apr 2020 02:24:32 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 1sm1884717pff.151.2020.04.21.02.24.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2020 02:24:31 -0700 (PDT)
Subject: Re: [RFC 3/8] hwmon: add support for the MCU controlled FAN on Khadas
 boards
To:     Neil Armstrong <narmstrong@baylibre.com>, lee.jones@linaro.org,
        jdelvare@suse.com, srinivas.kandagatla@linaro.org
Cc:     nick@khadas.com, art@khadas.com, linux-amlogic@lists.infradead.org,
        linux-hwmon@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20200421080102.22796-1-narmstrong@baylibre.com>
 <20200421080102.22796-4-narmstrong@baylibre.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 xsFNBE6H1WcBEACu6jIcw5kZ5dGeJ7E7B2uweQR/4FGxH10/H1O1+ApmcQ9i87XdZQiB9cpN
 RYHA7RCEK2dh6dDccykQk3bC90xXMPg+O3R+C/SkwcnUak1UZaeK/SwQbq/t0tkMzYDRxfJ7
 nyFiKxUehbNF3r9qlJgPqONwX5vJy4/GvDHdddSCxV41P/ejsZ8PykxyJs98UWhF54tGRWFl
 7i1xvaDB9lN5WTLRKSO7wICuLiSz5WZHXMkyF4d+/O5ll7yz/o/JxK5vO/sduYDIlFTvBZDh
 gzaEtNf5tQjsjG4io8E0Yq0ViobLkS2RTNZT8ICq/Jmvl0SpbHRvYwa2DhNsK0YjHFQBB0FX
 IdhdUEzNefcNcYvqigJpdICoP2e4yJSyflHFO4dr0OrdnGLe1Zi/8Xo/2+M1dSSEt196rXaC
 kwu2KgIgmkRBb3cp2vIBBIIowU8W3qC1+w+RdMUrZxKGWJ3juwcgveJlzMpMZNyM1jobSXZ0
 VHGMNJ3MwXlrEFPXaYJgibcg6brM6wGfX/LBvc/haWw4yO24lT5eitm4UBdIy9pKkKmHHh7s
 jfZJkB5fWKVdoCv/omy6UyH6ykLOPFugl+hVL2Prf8xrXuZe1CMS7ID9Lc8FaL1ROIN/W8Vk
 BIsJMaWOhks//7d92Uf3EArDlDShwR2+D+AMon8NULuLBHiEUQARAQABzTJHdWVudGVyIFJv
 ZWNrIChMaW51eCBhY2NvdW50KSA8bGludXhAcm9lY2stdXMubmV0PsLBgQQTAQIAKwIbAwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4ACGQEFAlVcphcFCRmg06EACgkQyx8mb86fmYFg0RAA
 nzXJzuPkLJaOmSIzPAqqnutACchT/meCOgMEpS5oLf6xn5ySZkl23OxuhpMZTVX+49c9pvBx
 hpvl5bCWFu5qC1jC2eWRYU+aZZE4sxMaAGeWenQJsiG9lP8wkfCJP3ockNu0ZXXAXwIbY1O1
 c+l11zQkZw89zNgWgKobKzrDMBFOYtAh0pAInZ9TSn7oA4Ctejouo5wUugmk8MrDtUVXmEA9
 7f9fgKYSwl/H7dfKKsS1bDOpyJlqhEAH94BHJdK/b1tzwJCFAXFhMlmlbYEk8kWjcxQgDWMu
 GAthQzSuAyhqyZwFcOlMCNbAcTSQawSo3B9yM9mHJne5RrAbVz4TWLnEaX8gA5xK3uCNCeyI
 sqYuzA4OzcMwnnTASvzsGZoYHTFP3DQwf2nzxD6yBGCfwNGIYfS0i8YN8XcBgEcDFMWpOQhT
 Pu3HeztMnF3HXrc0t7e5rDW9zCh3k2PA6D2NV4fews9KDFhLlTfCVzf0PS1dRVVWM+4jVl6l
 HRIAgWp+2/f8dx5vPc4Ycp4IsZN0l1h9uT7qm1KTwz+sSl1zOqKD/BpfGNZfLRRxrXthvvY8
 BltcuZ4+PGFTcRkMytUbMDFMF9Cjd2W9dXD35PEtvj8wnEyzIos8bbgtLrGTv/SYhmPpahJA
 l8hPhYvmAvpOmusUUyB30StsHIU2LLccUPPOwU0ETofVZwEQALlLbQeBDTDbwQYrj0gbx3bq
 7kpKABxN2MqeuqGr02DpS9883d/t7ontxasXoEz2GTioevvRmllJlPQERVxM8gQoNg22twF7
 pB/zsrIjxkE9heE4wYfN1AyzT+AxgYN6f8hVQ7Nrc9XgZZe+8IkuW/Nf64KzNJXnSH4u6nJM
 J2+Dt274YoFcXR1nG76Q259mKwzbCukKbd6piL+VsT/qBrLhZe9Ivbjq5WMdkQKnP7gYKCAi
 pNVJC4enWfivZsYupMd9qn7Uv/oCZDYoBTdMSBUblaLMwlcjnPpOYK5rfHvC4opxl+P/Vzyz
 6WC2TLkPtKvYvXmdsI6rnEI4Uucg0Au/Ulg7aqqKhzGPIbVaL+U0Wk82nz6hz+WP2ggTrY1w
 ZlPlRt8WM9w6WfLf2j+PuGklj37m+KvaOEfLsF1v464dSpy1tQVHhhp8LFTxh/6RWkRIR2uF
 I4v3Xu/k5D0LhaZHpQ4C+xKsQxpTGuYh2tnRaRL14YMW1dlI3HfeB2gj7Yc8XdHh9vkpPyuT
 nY/ZsFbnvBtiw7GchKKri2gDhRb2QNNDyBnQn5mRFw7CyuFclAksOdV/sdpQnYlYcRQWOUGY
 HhQ5eqTRZjm9z+qQe/T0HQpmiPTqQcIaG/edgKVTUjITfA7AJMKLQHgp04Vylb+G6jocnQQX
 JqvvP09whbqrABEBAAHCwWUEGAECAA8CGwwFAlVcpi8FCRmg08MACgkQyx8mb86fmYHNRQ/+
 J0OZsBYP4leJvQF8lx9zif+v4ZY/6C9tTcUv/KNAE5leyrD4IKbnV4PnbrVhjq861it/zRQW
 cFpWQszZyWRwNPWUUz7ejmm9lAwPbr8xWT4qMSA43VKQ7ZCeTQJ4TC8kjqtcbw41SjkjrcTG
 wF52zFO4bOWyovVAPncvV9eGA/vtnd3xEZXQiSt91kBSqK28yjxAqK/c3G6i7IX2rg6pzgqh
 hiH3/1qM2M/LSuqAv0Rwrt/k+pZXE+B4Ud42hwmMr0TfhNxG+X7YKvjKC+SjPjqp0CaztQ0H
 nsDLSLElVROxCd9m8CAUuHplgmR3seYCOrT4jriMFBtKNPtj2EE4DNV4s7k0Zy+6iRQ8G8ng
 QjsSqYJx8iAR8JRB7Gm2rQOMv8lSRdjva++GT0VLXtHULdlzg8VjDnFZ3lfz5PWEOeIMk7Rj
 trjv82EZtrhLuLjHRCaG50OOm0hwPSk1J64R8O3HjSLdertmw7eyAYOo4RuWJguYMg5DRnBk
 WkRwrSuCn7UG+qVWZeKEsFKFOkynOs3pVbcbq1pxbhk3TRWCGRU5JolI4ohy/7JV1TVbjiDI
 HP/aVnm6NC8of26P40Pg8EdAhajZnHHjA7FrJXsy3cyIGqvg9os4rNkUWmrCfLLsZDHD8FnU
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <37d7db98-cae8-4d97-8e39-88602756dd62@roeck-us.net>
Date:   Tue, 21 Apr 2020 02:24:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200421080102.22796-4-narmstrong@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/21/20 1:00 AM, Neil Armstrong wrote:
> The new Khadas VIM2 and VIM3 boards controls the cooling fan via the
> on-board microcontroller.
> 
> This implements the FAN control as HWMON devices as cell of the Khadas
> MCU MFD driver.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

This should be a thermal driver, not a hwmon driver.
I don't see a single standard hwmon attribute, making
the driver quite pointless as hwmon device.

Guenter

> ---
>  drivers/hwmon/Kconfig          |   9 ++
>  drivers/hwmon/Makefile         |   1 +
>  drivers/hwmon/khadas-mcu-fan.c | 230 +++++++++++++++++++++++++++++++++
>  3 files changed, 240 insertions(+)
>  create mode 100644 drivers/hwmon/khadas-mcu-fan.c
> 
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 4c62f900bf7e..7f63ff7bb732 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -1997,6 +1997,15 @@ config SENSORS_XGENE
>  	  If you say yes here you get support for the temperature
>  	  and power sensors for APM X-Gene SoC.
>  
> +config SENSORS_KHADAS_MCU_FAN
> +	tristate "Khadas MCU controller FAN driver"
> +	depends on OF || COMPILE_TEST
> +	select MFD_CORE
> +	select REGMAP
> +	help
> +	  If you say yes here you get support for the FAN controlled
> +	  by the Microcontroller found on the Khadas VIM boards.
> +
>  if ACPI
>  
>  comment "ACPI drivers"
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index b0b9c8e57176..20db40f6d57f 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -185,6 +185,7 @@ obj-$(CONFIG_SENSORS_W83L786NG)	+= w83l786ng.o
>  obj-$(CONFIG_SENSORS_WM831X)	+= wm831x-hwmon.o
>  obj-$(CONFIG_SENSORS_WM8350)	+= wm8350-hwmon.o
>  obj-$(CONFIG_SENSORS_XGENE)	+= xgene-hwmon.o
> +obj-$(CONFIG_SENSORS_KHADAS_MCU_FAN)	+= khadas-mcu-fan.o
>  
>  obj-$(CONFIG_SENSORS_OCC)	+= occ/
>  obj-$(CONFIG_PMBUS)		+= pmbus/
> diff --git a/drivers/hwmon/khadas-mcu-fan.c b/drivers/hwmon/khadas-mcu-fan.c
> new file mode 100644
> index 000000000000..dd92b2bcb7e3
> --- /dev/null
> +++ b/drivers/hwmon/khadas-mcu-fan.c
> @@ -0,0 +1,230 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Khadas MCU Controlled FAN driver
> + *
> + * Copyright (C) 2020 BayLibre SAS
> + * Author(s): Neil Armstrong <narmstrong@baylibre.com>
> + */
> +
> +#include <linux/hwmon.h>
> +#include <linux/hwmon-sysfs.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/mfd/khadas-mcu.h>
> +#include <linux/regmap.h>
> +#include <linux/sysfs.h>
> +#include <linux/thermal.h>
> +
> +#define MAX_LEVEL 3
> +
> +struct khadas_mcu_fan_ctx {
> +	struct khadas_mcu *mcu;
> +	unsigned int level;
> +	struct thermal_cooling_device *cdev;
> +};
> +
> +static int khadas_mcu_fan_set_level(struct khadas_mcu_fan_ctx *ctx,
> +				    unsigned int level)
> +{
> +	int ret;
> +
> +	ret = regmap_write(ctx->mcu->map, KHADAS_MCU_CMD_FAN_STATUS_CTRL_REG,
> +			   level);
> +	if (ret)
> +		return ret;
> +
> +	ctx->level = level;
> +
> +	return 0;
> +}
> +
> +static ssize_t level_store(struct device *dev, struct device_attribute *attr,
> +			   const char *buf, size_t count)
> +{
> +	struct khadas_mcu_fan_ctx *ctx = dev_get_drvdata(dev);
> +	unsigned long level;
> +	int ret;
> +
> +	if (kstrtoul(buf, 10, &level) || level > MAX_LEVEL)
> +		return -EINVAL;
> +
> +	ret = khadas_mcu_fan_set_level(ctx, level);
> +	if (ret < 0)
> +		return ret;
> +
> +	return count;
> +}
> +
> +static ssize_t level_show(struct device *dev, struct device_attribute *attr,
> +			  char *buf)
> +{
> +	struct khadas_mcu_fan_ctx *ctx = dev_get_drvdata(dev);
> +
> +	return sprintf(buf, "%u\n", ctx->level);
> +}
> +
> +static SENSOR_DEVICE_ATTR_RW(level1, level, 0);
> +
> +static struct attribute *khadas_mcu_fan_attrs[] = {
> +	&sensor_dev_attr_level1.dev_attr.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group khadas_mcu_fan_group = {
> +	.attrs = khadas_mcu_fan_attrs,
> +};
> +
> +static const struct attribute_group *khadas_mcu_fan_groups[] = {
> +	&khadas_mcu_fan_group,
> +	NULL,
> +};
> +
> +/* thermal cooling device callbacks */
> +static int khadas_mcu_fan_get_max_state(struct thermal_cooling_device *cdev,
> +					unsigned long *state)
> +{
> +	struct khadas_mcu_fan_ctx *ctx = cdev->devdata;
> +
> +	if (!ctx)
> +		return -EINVAL;
> +
> +	*state = MAX_LEVEL;
> +
> +	return 0;
> +}
> +
> +static int khadas_mcu_fan_get_cur_state(struct thermal_cooling_device *cdev,
> +					unsigned long *state)
> +{
> +	struct khadas_mcu_fan_ctx *ctx = cdev->devdata;
> +
> +	if (!ctx)
> +		return -EINVAL;
> +
> +	*state = ctx->level;
> +
> +	return 0;
> +}
> +
> +static int
> +khadas_mcu_fan_set_cur_state(struct thermal_cooling_device *cdev,
> +			     unsigned long state)
> +{
> +	struct khadas_mcu_fan_ctx *ctx = cdev->devdata;
> +
> +	if (!ctx || (state > MAX_LEVEL))
> +		return -EINVAL;
> +
> +	if (state == ctx->level)
> +		return 0;
> +
> +	return khadas_mcu_fan_set_level(ctx, state);
> +}
> +
> +static const struct thermal_cooling_device_ops khadas_mcu_fan_cooling_ops = {
> +	.get_max_state = khadas_mcu_fan_get_max_state,
> +	.get_cur_state = khadas_mcu_fan_get_cur_state,
> +	.set_cur_state = khadas_mcu_fan_set_cur_state,
> +};
> +
> +static int khadas_mcu_fan_probe(struct platform_device *pdev)
> +{
> +	struct khadas_mcu *mcu = dev_get_drvdata(pdev->dev.parent);
> +	struct thermal_cooling_device *cdev;
> +	struct device *dev = &pdev->dev;
> +	struct khadas_mcu_fan_ctx *ctx;
> +	struct device *hwmon;
> +	int ret;
> +
> +	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
> +	if (!ctx)
> +		return -ENOMEM;
> +	ctx->mcu = mcu;
> +	platform_set_drvdata(pdev, ctx);
> +
> +	hwmon = devm_hwmon_device_register_with_groups(dev, "khadas-mcu-fan",
> +						       ctx,
> +						       khadas_mcu_fan_groups);
> +	if (IS_ERR(hwmon)) {
> +		dev_err(dev, "Failed to register hwmon device\n");
> +		return PTR_ERR(hwmon);
> +	}
> +
> +	if (IS_ENABLED(CONFIG_THERMAL)) {
> +		cdev = devm_thermal_of_cooling_device_register(dev->parent,
> +			dev->parent->of_node, "khadas-mcu-fan", ctx,
> +			&khadas_mcu_fan_cooling_ops);
> +		if (IS_ERR(cdev)) {
> +			ret = PTR_ERR(cdev);
> +			dev_err(dev,
> +				"Failed to register khadas-mcu-fan as cooling device: %d\n",
> +				ret);
> +			return ret;
> +		}
> +		ctx->cdev = cdev;
> +		thermal_cdev_update(cdev);
> +	}
> +
> +	return 0;
> +}
> +
> +static int khadas_mcu_fan_disable(struct device *dev)
> +{
> +	struct khadas_mcu_fan_ctx *ctx = dev_get_drvdata(dev);
> +	unsigned int level_save = ctx->level;
> +	int ret;
> +
> +	ret = khadas_mcu_fan_set_level(ctx, 0);
> +	if (ret)
> +		return ret;
> +
> +	ctx->level = level_save;
> +
> +	return 0;
> +}
> +
> +static void khadas_mcu_fan_shutdown(struct platform_device *pdev)
> +{
> +	khadas_mcu_fan_disable(&pdev->dev);
> +}
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int khadas_mcu_fan_suspend(struct device *dev)
> +{
> +	return khadas_mcu_fan_disable(dev);
> +}
> +
> +static int khadas_mcu_fan_resume(struct device *dev)
> +{
> +	struct khadas_mcu_fan_ctx *ctx = dev_get_drvdata(dev);
> +
> +	return khadas_mcu_fan_set_level(ctx, ctx->level);
> +}
> +#endif
> +
> +static SIMPLE_DEV_PM_OPS(khadas_mcu_fan_pm, khadas_mcu_fan_suspend,
> +			 khadas_mcu_fan_resume);
> +
> +static const struct platform_device_id khadas_mcu_fan_id_table[] = {
> +	{ .name = "khadas-mcu-fan-ctrl", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(platform, khadas_mcu_fan_id_table);
> +
> +static struct platform_driver khadas_mcu_fan_driver = {
> +	.probe		= khadas_mcu_fan_probe,
> +	.shutdown	= khadas_mcu_fan_shutdown,
> +	.driver	= {
> +		.name		= "khadas-mcu-fan-ctrl",
> +		.pm		= &khadas_mcu_fan_pm,
> +	},
> +	.id_table	= khadas_mcu_fan_id_table,
> +};
> +
> +module_platform_driver(khadas_mcu_fan_driver);
> +
> +MODULE_AUTHOR("Neil Armstrong <narmstrong@baylibre.com>");
> +MODULE_DESCRIPTION("Khadas MCU FAN driver");
> +MODULE_LICENSE("GPL");
> 

