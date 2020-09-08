Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E221C2D0E1
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 20:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFB63204FD
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 20:05:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QilGWhhI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732636AbgIHUFr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 16:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730339AbgIHPV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:21:57 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F5FC0610E7;
        Tue,  8 Sep 2020 07:13:57 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id g10so14937418otq.9;
        Tue, 08 Sep 2020 07:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QuCdJp7fuF3IlctDr5pW61taqFMBuAP7yj9Twes+C6k=;
        b=QilGWhhIew5U04Xe/0pm3ijt99NemNcN+h0pefsfay4n1+9VtHRTQ97DyX5Xh8UkfF
         ti6DohhsDrjY2432MnuxffSJLPdMqo9SnxPA+sZ5NZnDmeJZBfGhv4FZRoH9Zc0qHm1l
         ogVj5F1i/XDO57JvJBKV1vuDIcf+QWV5Qr8MtwElj3BXzDCWbJoPUpHtVxdjk02k2Mya
         zxkrWjAifTSPQHnmIIqyAq/rapLD7WUNB+57x/q383im9BY+BHdsgP+1TPJn6BEiucop
         xVD+plSmhYpSb12yOdAgfoqkbSZupu8AH0bDjTr5UTJpvD9XcU9ZHh+iOHXClQfshWwO
         rliw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=QuCdJp7fuF3IlctDr5pW61taqFMBuAP7yj9Twes+C6k=;
        b=czpEQdBerKxpAf8hibPNBhpZzMLSFMA035g1M9mT5vuswfG+oQ6QAz7KOulyuV2d0+
         ZJR1WK/3lC/DP0DI/dNbFf1Aava01RzOsroXS3O0bvDACEraNx0wnJFupTzjBvab3G8y
         0f/3NV27UiGk9Y9pY2KNMG/D47VsFW1m+Rm19qtNWsKccUCXqgdyEp0Rt5bkgwYLHVHP
         Yb1Ie9KODW/E7GGM6+IuMlfy5YMW+e/r6smQELy56CsJYN9VJyjKYSI6fQkbdRMXAU34
         ZfQtEPO1lq8XyoVihm+ft3CjHMeP86D8WUWQVNIZbgXnvqxArk+S0U6cBISJfLQy0haV
         ooqA==
X-Gm-Message-State: AOAM5305UG17wuPQKomgwgCZifW7I1qrQjGH1S8UrprlEzmft3r4uhnJ
        cWH70knZypvC+wXync135Rc=
X-Google-Smtp-Source: ABdhPJxTffbm+3bmB4JlBUS+4TXHg8MjK/Ckajkr3dOD5bb9YaMCgbIqMOQYUzVQeEdfU/yLLtR69A==
X-Received: by 2002:a05:6830:1e39:: with SMTP id t25mr13760996otr.8.1599574437095;
        Tue, 08 Sep 2020 07:13:57 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f94sm3468570otb.29.2020.09.08.07.13.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Sep 2020 07:13:56 -0700 (PDT)
Subject: Re: [PATCH] hwmon: intel-m10-bmc-hwmon: add hwmon support for Intel
 MAX 10 BMC
To:     Xu Yilun <yilun.xu@intel.com>, jdelvare@suse.com,
        lee.jones@linaro.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, matthew.gerlach@linux.intel.com,
        russell.h.weight@intel.com, lgoncalv@redhat.com, hao.wu@intel.com,
        mdf@kernel.org
References: <1599546140-18804-1-git-send-email-yilun.xu@intel.com>
 <1599546140-18804-2-git-send-email-yilun.xu@intel.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <7db3f229-e39e-50fa-1647-1da09471d785@roeck-us.net>
Date:   Tue, 8 Sep 2020 07:13:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1599546140-18804-2-git-send-email-yilun.xu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/7/20 11:22 PM, Xu Yilun wrote:
> This patch adds hwmon functionality for Intel MAX 10 BMC chip. This BMC
> chip connects to a set of sensor chips to monitor current, voltage,
> thermal and power of different components on board. The BMC firmware is
> responsible for sensor data sampling and recording in shared registers.
> Host driver reads the sensor data from these shared registers and
> exposes them to users as hwmon interfaces.
> 
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> Signed-off-by: Wu Hao <hao.wu@intel.com>
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/hwmon/Kconfig               |  11 +
>  drivers/hwmon/Makefile              |   1 +
>  drivers/hwmon/intel-m10-bmc-hwmon.c | 516 ++++++++++++++++++++++++++++++++++++

Documentation/hwmon/intel-m10-bmc-hwmon is missing

>  3 files changed, 528 insertions(+)
>  create mode 100644 drivers/hwmon/intel-m10-bmc-hwmon.c
> 
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 8dc28b2..53af15c 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -2064,6 +2064,17 @@ config SENSORS_XGENE
>  	  If you say yes here you get support for the temperature
>  	  and power sensors for APM X-Gene SoC.
>  
> +config SENSORS_INTEL_M10_BMC_HWMON
> +	tristate "Intel MAX10 BMC Hardware Monitoring"
> +	depends on MFD_INTEL_M10_BMC
> +	help
> +	  This driver provides support for the hardware monitoring functionality
> +	  on Intel MAX10 BMC chip.
> +
> +	  This BMC Chip is used on Intel FPGA PCIe Acceleration Cards (PAC). Its
> +	  sensors monitor various telemetry data of different components on the
> +	  card, e.g. board temperature, FPGA core temperature/voltage/current.
> +
>  if ACPI
>  
>  comment "ACPI drivers"
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index a8f4b35..ba5a25a 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -90,6 +90,7 @@ obj-$(CONFIG_SENSORS_IIO_HWMON) += iio_hwmon.o
>  obj-$(CONFIG_SENSORS_INA209)	+= ina209.o
>  obj-$(CONFIG_SENSORS_INA2XX)	+= ina2xx.o
>  obj-$(CONFIG_SENSORS_INA3221)	+= ina3221.o
> +obj-$(CONFIG_SENSORS_INTEL_M10_BMC_HWMON) += intel-m10-bmc-hwmon.o
>  obj-$(CONFIG_SENSORS_IT87)	+= it87.o
>  obj-$(CONFIG_SENSORS_JC42)	+= jc42.o
>  obj-$(CONFIG_SENSORS_K8TEMP)	+= k8temp.o
> diff --git a/drivers/hwmon/intel-m10-bmc-hwmon.c b/drivers/hwmon/intel-m10-bmc-hwmon.c
> new file mode 100644
> index 0000000..43e55e7
> --- /dev/null
> +++ b/drivers/hwmon/intel-m10-bmc-hwmon.c
> @@ -0,0 +1,516 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Intel MAX 10 BMC HWMON Driver
> + *
> + * Copyright (C) 2018-2020 Intel Corporation. All rights reserved.
> + *
> + */
> +#include <linux/device.h>
> +#include <linux/hwmon.h>
> +#include <linux/hwmon-sysfs.h>

Unnecessary include file.

> +#include <linux/mfd/intel-m10-bmc.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/platform_device.h>
> +
> +enum m10bmc_channel_type {
> +	M10BMC_CHT_TEMP,
> +	M10BMC_CHT_IN,
> +	M10BMC_CHT_CURR,
> +	M10BMC_CHT_POWER,
> +	M10BMC_CHT_MAX,
> +};
> +
> +struct m10bmc_sdata {
> +	unsigned int type;
> +	unsigned int reg_input;
> +	unsigned int reg_max;
> +	unsigned int reg_crit;
> +	unsigned int reg_hyst;
> +	unsigned int reg_min;
> +	unsigned int multiplier;
> +	const char *label;
> +};
> +
> +static struct m10bmc_sdata n3000bmc_sensor_tbl[] = {

Can be const

> +	{ M10BMC_CHT_TEMP, 0x100, 0x104, 0x108, 0x10c, 0x0, 500,
> +	 "Board Temperature" },
> +	{ M10BMC_CHT_TEMP, 0x110, 0x114, 0x118, 0x0, 0x0, 500,
> +	 "FPGA Die Temperature" },
> +	{ M10BMC_CHT_TEMP, 0x11c, 0x120, 0x124, 0x0, 0x0, 500,
> +	 "QSFP0 Temperature" },
> +	{ M10BMC_CHT_IN, 0x128, 0x0, 0x0, 0x0, 0x0, 1,
> +	 "QSFP0 Supply Voltage" },
> +	{ M10BMC_CHT_TEMP, 0x12c, 0x130, 0x134, 0x0, 0x0, 500,
> +	 "QSFP1 Temperature" },
> +	{ M10BMC_CHT_IN, 0x138, 0x0, 0x0, 0x0, 0x0, 1,
> +	 "QSFP1 Supply Voltage" },
> +	{ M10BMC_CHT_IN, 0x13c, 0x0, 0x0, 0x0, 0x0, 1,
> +	 "FPGA Core Voltage" },
> +	{ M10BMC_CHT_CURR, 0x140, 0x0, 0x0, 0x0, 0x0, 1,
> +	 "FPGA Core Current" },
> +	{ M10BMC_CHT_IN, 0x144, 0x0, 0x0, 0x0, 0x0, 1,
> +	 "12V Backplane Voltage" },
> +	{ M10BMC_CHT_CURR, 0x148, 0x0, 0x0, 0x0, 0x0, 1,
> +	 "12V Backplane Current" },
> +	{ M10BMC_CHT_IN, 0x14c, 0x0, 0x0, 0x0, 0x0, 1,
> +	 "1.2V Voltage" },
> +	{M10BMC_CHT_IN, 0x150, 0x0, 0x0, 0x0, 0x0, 1,
> +	 "12V AUX Voltage" },
> +	{ M10BMC_CHT_CURR, 0x154, 0x0, 0x0, 0x0, 0x0, 1,
> +	 "12V AUX Current" },
> +	{ M10BMC_CHT_IN, 0x158, 0x0, 0x0, 0x0, 0x0, 1,
> +	 "1.8V Voltage" },
> +	{ M10BMC_CHT_IN, 0x15c, 0x0, 0x0, 0x0, 0x0, 1,
> +	 "3.3V Voltage" },
> +	{ M10BMC_CHT_POWER, 0x160, 0x0, 0x0, 0x0, 0x0, 1000,
> +	 "Board Power" },
> +	{ M10BMC_CHT_TEMP, 0x168, 0x0, 0x0, 0x0, 0x0, 500,
> +	 "Retimer A Temperature" },
> +	{ M10BMC_CHT_TEMP, 0x16c, 0x0, 0x0, 0x0, 0x0, 500,
> +	 "Retimer A SerDes Temperature" },
> +	{ M10BMC_CHT_TEMP, 0x170, 0x0, 0x0, 0x0, 0x0, 500,
> +	 "Retimer B Temperature" },
> +	{ M10BMC_CHT_TEMP, 0x174, 0x0, 0x0, 0x0, 0x0, 500,
> +	 "Retimer B SerDes Temperature" },
> +	{ M10BMC_CHT_MAX } /* sentinel */
> +};
> +
> +struct m10bmc_ch_group {
> +	int num_channels;
> +	struct m10bmc_sdata **data_list;
> +	u32 *config;
> +	struct hwmon_channel_info info;
> +};
> +
> +struct m10bmc_hwmon {
> +	struct device *dev;
> +	struct m10bmc_ch_group chgs[M10BMC_CHT_MAX];
> +	/* This is a NULL terminated array required by the HWMON interface */
> +	const struct hwmon_channel_info *info[M10BMC_CHT_MAX + 1];
> +	struct hwmon_chip_info chip;
> +	char *hw_name;
> +	struct intel_m10bmc *m10bmc;
> +	struct m10bmc_sdata *data_tbl;
> +};
> +
> +static enum m10bmc_channel_type
> +htype_to_ctype(enum hwmon_sensor_types htype)
> +{
> +	switch (htype) {
> +	case hwmon_temp:
> +		return M10BMC_CHT_TEMP;
> +	case hwmon_in:
> +		return M10BMC_CHT_IN;
> +	case hwmon_curr:
> +		return M10BMC_CHT_CURR;
> +	case hwmon_power:
> +		return M10BMC_CHT_POWER;
> +	default:
> +		return M10BMC_CHT_MAX;
> +	}
> +}
> +
> +static enum hwmon_sensor_types
> +ctype_to_htype(enum m10bmc_channel_type ctype)
> +{
> +	switch (ctype) {
> +	case M10BMC_CHT_TEMP:
> +		return hwmon_temp;
> +	case M10BMC_CHT_IN:
> +		return hwmon_in;
> +	case M10BMC_CHT_CURR:
> +		return hwmon_curr;
> +	case M10BMC_CHT_POWER:
> +		return hwmon_power;
> +	default:
> +		return hwmon_max;
> +	}
> +}
> +
> +static umode_t
> +m10bmc_hwmon_is_visible(const void *data, enum hwmon_sensor_types type,
> +			u32 attr, int channel)
> +{
> +	return 0444;

It is quite unusual that limit attributes are read-only, but I guess
that is your call.

> +}
> +
> +static struct m10bmc_sdata *
> +find_sensor_data(struct m10bmc_hwmon *hw, enum hwmon_sensor_types htype,
> +		 int channel)
> +{
> +	enum m10bmc_channel_type ctype = htype_to_ctype(htype);
> +	struct m10bmc_ch_group *ch_group;
> +
> +	if (ctype >= M10BMC_CHT_MAX)
> +		return ERR_PTR(-EOPNOTSUPP);
> +
> +	ch_group = &hw->chgs[ctype];
> +
> +	if (channel >= ch_group->num_channels)
> +		return ERR_PTR(-EOPNOTSUPP);
> +
> +	return ch_group->data_list[channel];
> +}
> +
> +static int do_sensor_read(struct m10bmc_hwmon *hw, struct m10bmc_sdata *data,
> +			  unsigned int regoff, long *val)
> +{
> +	unsigned int regval;
> +	int ret;
> +
> +	ret = m10bmc_sys_read(hw->m10bmc, regoff, &regval);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * BMC Firmware will return 0xdeadbeef if the sensor value is invalid
> +	 * at that time. This usually happens on sensor channels which connect
> +	 * to external pluggable modules, e.g. QSFP temperature and voltage.
> +	 * When the QSFP is unplugged from cage, driver will get 0xdeadbeef
> +	 * from their registers.
> +	 */
> +	if (regval == 0xdeadbeef)
> +		return -EBUSY;
> +
> +	*val = regval * data->multiplier;
> +
> +	return 0;
> +}
> +
> +static int m10bmc_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
> +			     u32 attr, int channel, long *val)
> +{
> +	struct m10bmc_hwmon *hw = dev_get_drvdata(dev);
> +	unsigned int reg, reg_hyst = 0;
> +	struct m10bmc_sdata *data;
> +	long hyst, value;
> +	int ret;
> +
> +	data = find_sensor_data(hw, type, channel);
> +	if (IS_ERR(data))
> +		return PTR_ERR(data);
> +
> +	switch (type) {
> +	case hwmon_temp:
> +		switch (attr) {
> +		case hwmon_temp_input:
> +			reg = data->reg_input;
> +			break;
> +		case hwmon_temp_max_hyst:
> +			reg_hyst = data->reg_hyst;
> +			fallthrough;
> +		case hwmon_temp_max:
> +			reg = data->reg_max;
> +			break;
> +		case hwmon_temp_crit_hyst:
> +			reg_hyst = data->reg_hyst;
> +			fallthrough;
> +		case hwmon_temp_crit:
> +			reg = data->reg_crit;
> +			break;
> +		default:
> +			return -EOPNOTSUPP;
> +		}
> +		break;
> +	case hwmon_in:
> +		switch (attr) {
> +		case hwmon_in_input:
> +			reg = data->reg_input;
> +			break;
> +		case hwmon_in_max:
> +			reg = data->reg_max;
> +			break;
> +		case hwmon_in_crit:
> +			reg = data->reg_crit;
> +			break;
> +		case hwmon_in_min:
> +			reg = data->reg_min;
> +			break;
> +		default:
> +			return -EOPNOTSUPP;
> +		}
> +		break;
> +	case hwmon_curr:
> +		switch (attr) {
> +		case hwmon_curr_input:
> +			reg = data->reg_input;
> +			break;
> +		case hwmon_curr_max:
> +			reg = data->reg_max;
> +			break;
> +		case hwmon_curr_crit:
> +			reg = data->reg_crit;
> +			break;
> +		default:
> +			return -EOPNOTSUPP;
> +		}
> +		break;
> +	case hwmon_power:
> +		switch (attr) {
> +		case hwmon_power_input:
> +			reg = data->reg_input;
> +			break;
> +		default:
> +			return -EOPNOTSUPP;
> +		}
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	ret = do_sensor_read(hw, data, reg, &value);
> +	if (ret)
> +		return ret;
> +
> +	if (reg_hyst) {
> +		ret = do_sensor_read(hw, data, reg_hyst, &hyst);
> +		if (ret)
> +			return ret;
> +
> +		value -= hyst;
> +	}
> +
> +	*val = value;
> +
> +	return ret;
> +}
> +
> +static int m10bmc_hwmon_read_string(struct device *dev,
> +				    enum hwmon_sensor_types type,
> +				    u32 attr, int channel, const char **str)
> +{
> +	struct m10bmc_hwmon *hw = dev_get_drvdata(dev);
> +	struct m10bmc_sdata *data;
> +
> +	data = find_sensor_data(hw, type, channel);
> +	if (!data)
> +		return -EOPNOTSUPP;
> +
> +	*str = data->label;
> +
> +	return 0;
> +}
> +
> +static const struct hwmon_ops m10bmc_hwmon_ops = {
> +	.is_visible = m10bmc_hwmon_is_visible,
> +	.read = m10bmc_hwmon_read,
> +	.read_string = m10bmc_hwmon_read_string,
> +};
> +
> +static int m10bmc_malloc_channels(struct device *dev,
> +				  struct m10bmc_ch_group *chg, int num_ch)
> +{
> +	chg->config = devm_kcalloc(dev, num_ch + 1,
> +				   sizeof(*chg->config), GFP_KERNEL);
> +	if (!chg->config)
> +		return -ENOMEM;
> +
> +	chg->data_list = devm_kcalloc(dev, num_ch, sizeof(*chg->data_list),
> +				      GFP_KERNEL);
> +	if (!chg->data_list)
> +		return -ENOMEM;
> +
> +	chg->info.config = chg->config;
> +	chg->num_channels = num_ch;
> +
> +	return 0;
> +}
> +
> +static void m10bmc_fill_temp_channel(struct m10bmc_hwmon *hwmon, int ch_idx,
> +				     struct m10bmc_sdata *data)
> +{
> +	struct m10bmc_ch_group *chg = &hwmon->chgs[M10BMC_CHT_TEMP];
> +
> +	if (data->reg_input)
> +		chg->config[ch_idx] |= HWMON_T_INPUT;
> +
> +	if (data->reg_max) {
> +		chg->config[ch_idx] |= HWMON_T_MAX;
> +		if (data->reg_hyst)
> +			chg->config[ch_idx] |= HWMON_T_MAX_HYST;
> +	}
> +
> +	if (data->reg_crit) {
> +		chg->config[ch_idx] |= HWMON_T_CRIT;
> +		if (data->reg_hyst)
> +			chg->config[ch_idx] |= HWMON_T_CRIT_HYST;
> +	}
> +
> +	if (data->label)
> +		chg->config[ch_idx] |= HWMON_T_LABEL;
> +
> +	chg->data_list[ch_idx] = data;
> +}
> +
> +static void m10bmc_fill_in_channel(struct m10bmc_hwmon *hwmon, int ch_idx,
> +				   struct m10bmc_sdata *data)
> +{
> +	struct m10bmc_ch_group *chg = &hwmon->chgs[M10BMC_CHT_IN];
> +
> +	if (data->reg_input)
> +		chg->config[ch_idx] |= HWMON_I_INPUT;
> +
> +	if (data->reg_max)
> +		chg->config[ch_idx] |= HWMON_I_MAX;
> +
> +	if (data->reg_crit)
> +		chg->config[ch_idx] |= HWMON_I_CRIT;
> +
> +	if (data->reg_min)
> +		chg->config[ch_idx] |= HWMON_I_MIN;
> +
> +	if (data->label)
> +		chg->config[ch_idx] |= HWMON_I_LABEL;
> +
> +	chg->data_list[ch_idx] = data;
> +}
> +
> +static void m10bmc_fill_curr_channel(struct m10bmc_hwmon *hwmon, int ch_idx,
> +				     struct m10bmc_sdata *data)
> +{
> +	struct m10bmc_ch_group *chg = &hwmon->chgs[M10BMC_CHT_CURR];
> +
> +	if (data->reg_input)
> +		chg->config[ch_idx] |= HWMON_C_INPUT;
> +
> +	if (data->reg_max)
> +		chg->config[ch_idx] |= HWMON_C_MAX;
> +
> +	if (data->reg_crit)
> +		chg->config[ch_idx] |= HWMON_C_CRIT;
> +
> +	if (data->label)
> +		chg->config[ch_idx] |= HWMON_C_LABEL;
> +
> +	chg->data_list[ch_idx] = data;
> +}
> +
> +static void m10bmc_fill_power_channel(struct m10bmc_hwmon *hwmon, int ch_idx,
> +				      struct m10bmc_sdata *data)
> +{
> +	struct m10bmc_ch_group *chg = &hwmon->chgs[M10BMC_CHT_POWER];
> +
> +	if (data->reg_input)
> +		chg->config[ch_idx] |= HWMON_P_INPUT;
> +
> +	if (data->label)
> +		chg->config[ch_idx] |= HWMON_P_LABEL;
> +
> +	chg->data_list[ch_idx] = data;
> +}

A substantial amount of code in this driver busies itself to convert
n3000bmc_sensor_tbl[] into the hwmon_channel_info data. What is the point
of doing that instead of providing struct hwmon_channel_info statically ?
One could write a little helper program to convert one into the other,
and avoid all this unnecessary code.

> +
> +static int m10bmc_hwmon_init(struct device *dev, struct intel_m10bmc *m10bmc,
> +			     const char *dev_name,
> +			     struct m10bmc_sdata *data_tbl)
> +{
> +	int num_ch[M10BMC_CHT_MAX] = { 0 }, ret, i, j;
> +	struct m10bmc_sdata *data = data_tbl;
> +	struct device *hwmon_dev;
> +	struct m10bmc_hwmon *hw;
> +
> +	hw = devm_kzalloc(dev, sizeof(*hw), GFP_KERNEL);
> +	if (!hw)
> +		return -ENOMEM;
> +
> +	hw->dev = dev;
> +	hw->m10bmc = m10bmc;
> +	hw->data_tbl = data_tbl;
> +
> +	while (data->type != M10BMC_CHT_MAX) {
> +		if (data->type > M10BMC_CHT_MAX)
> +			return -EINVAL;
> +
> +		++num_ch[data->type];
> +		++data;
> +	}
> +
> +	for (i = 0; i < M10BMC_CHT_MAX; i++) {
> +		if (!num_ch[i])
> +			continue;
> +
> +		ret = m10bmc_malloc_channels(dev, &hw->chgs[i],
> +					     num_ch[i]);
> +		if (ret)
> +			return ret;
> +
> +		hw->chgs[i].info.type = ctype_to_htype(i);
> +	}
> +
> +	data = data_tbl;
> +	memset(&num_ch, 0, sizeof(num_ch));
> +	while (data->type != M10BMC_CHT_MAX) {
> +		switch (data->type) {
> +		case M10BMC_CHT_TEMP:
> +			m10bmc_fill_temp_channel(hw, num_ch[data->type],
> +						 data);
> +			break;
> +		case M10BMC_CHT_IN:
> +			m10bmc_fill_in_channel(hw, num_ch[data->type],
> +					       data);
> +			break;
> +		case M10BMC_CHT_CURR:
> +			m10bmc_fill_curr_channel(hw, num_ch[data->type],
> +						 data);
> +			break;
> +		case M10BMC_CHT_POWER:
> +			m10bmc_fill_power_channel(hw, num_ch[data->type],
> +						  data);
> +			break;
> +		}
> +
> +		++num_ch[data->type];
> +		++data;
> +	}
> +
> +	for (i = 0, j = 0; i < M10BMC_CHT_MAX; i++) {
> +		if (num_ch[i])
> +			hw->info[j++] = &hw->chgs[i].info;
> +	}
> +
> +	hw->chip.info = hw->info;
> +	hw->chip.ops = &m10bmc_hwmon_ops;
> +
> +	hw->hw_name = devm_kstrdup(dev, dev_name, GFP_KERNEL);
> +	if (!hw->hw_name)
> +		return -ENOMEM;
> +
> +	for (i = 0; hw->hw_name[i]; i++)
> +		if (hwmon_is_bad_char(hw->hw_name[i]))
> +			hw->hw_name[i] = '_';
> +
> +	hwmon_dev = devm_hwmon_device_register_with_info(dev, hw->hw_name,
> +							 hw, &hw->chip, NULL);
> +	return PTR_ERR_OR_ZERO(hwmon_dev);
> +}
> +
> +static int m10bmc_hwmon_probe(struct platform_device *pdev)
> +{
> +	const struct platform_device_id *id = platform_get_device_id(pdev);
> +	struct intel_m10bmc *m10bmc = dev_get_drvdata(pdev->dev.parent);
> +
> +	return m10bmc_hwmon_init(&pdev->dev, m10bmc, id->name,
> +				 (struct m10bmc_sdata *)id->driver_data);
> +}
> +
> +static const struct platform_device_id intel_m10bmc_hwmon_ids[] = {
> +	{
> +		.name = "n3000bmc-hwmon",
> +		.driver_data = (unsigned long)&n3000bmc_sensor_tbl,
> +	},
> +	{ }
> +};
> +
> +static struct platform_driver intel_m10bmc_hwmon_driver = {
> +	.probe = m10bmc_hwmon_probe,
> +	.driver = {
> +		.name = "intel-m10-bmc-hwmon",
> +	},
> +	.id_table = intel_m10bmc_hwmon_ids,
> +};
> +module_platform_driver(intel_m10bmc_hwmon_driver);
> +
> +MODULE_DEVICE_TABLE(platform, intel_m10bmc_hwmon_ids);
> +MODULE_AUTHOR("Intel Corporation");
> +MODULE_DESCRIPTION("Intel MAX 10 BMC hardware monitor");
> +MODULE_LICENSE("GPL");
> 

