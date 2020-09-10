Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C63A0C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CEE320C09
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:34:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nyCSV4k1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730522AbgIJJeh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 05:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726600AbgIJJeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 05:34:17 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51105C061573;
        Thu, 10 Sep 2020 02:34:16 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id x69so5293859oia.8;
        Thu, 10 Sep 2020 02:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iTYj5hw1cSzU7xITsIBS3JjpmlVVz1nPn46xOM8arHo=;
        b=nyCSV4k1UkVnkE8Qn6t2ORaR3KozKtW8gOu09MPZQw+535HCoSHlQBZSNVUo0nYqWZ
         k6DIcMhCn4+ZSeqkJDunoC/HGtk2PNXSZ7Wf7KpoD9PekdoWzlTnijr/d9JXmtpPqjtm
         7oTxhZj8XyszkGZ2bi7x25TyoZozbcjhKMBpeuN5wQ8m409mWP82TOT/HfFJh0OkgpnT
         sdxI8Ihc4DGj/pSkpURRn9Y90GAv6WFKGY+NbK13NJv0Nz4DUkJImCsfa5LyeZ6u0FZ7
         I5Wmw5bAmBkTwgonwNTJZrxlWUhfPsvKuH+1EczxPcsqDbZr2imjJQEpxKcyWnQTGrIH
         6TrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=iTYj5hw1cSzU7xITsIBS3JjpmlVVz1nPn46xOM8arHo=;
        b=IjtpEXJlIygx5Om+LC4usCz/qHeij55N8UR6J4C3+NH1To27guhlJzjfw8bPDh2A74
         36SgRZXXRtnqrfFxYhUOpHeZuq5k3XbIJzHN2ulMRPf4wnAE6l3OQ2F8SwYSDbXAddjS
         i7UOZvzyCFOwl+5AnVB6BAT+zQ4vOSJCBmCirLHTQ6wjqNQPdzNAqa7/5mNBs2T0W5xM
         LXZZJBDUGoDcaNYtGMcWoDHhKwpKU18CS4j4OsSiheILGvoeSH6/uD5/ogR+7jyYakml
         ny7STUPQU+p+02SQhEQecqBLRqB4pfwniq5gw9fYCk8yOonYBfv3vMtbe43zMZihXnUU
         5Pww==
X-Gm-Message-State: AOAM530bAs9naOyCTClPeNsg35hKH5iw+vZayXDw+Ezk4Blg2XUBjQL1
        q3GdmqASD78Xa2nSVOnKW4M=
X-Google-Smtp-Source: ABdhPJx/4c3ojAIVuS241NZNwpNoqABrm3t5pd+u52DJKkJ3oHcTiT22u4bvG94FRIEpYbNRJhXKtw==
X-Received: by 2002:aca:abc2:: with SMTP id u185mr3236720oie.62.1599730455505;
        Thu, 10 Sep 2020 02:34:15 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 187sm840030oie.42.2020.09.10.02.34.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2020 02:34:14 -0700 (PDT)
Subject: Re: [PATCH 2/2] Add driver for Moortec MR75203 PVT controller
To:     "Tanwar, Rahul" <rahul.tanwar@linux.intel.com>, jdelvare@suse.com,
        p.zabel@pengutronix.de, linux-hwmon@vger.kernel.org,
        robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        andriy.shevchenko@intel.com, songjun.Wu@intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        rtanwar@maxlinear.com
References: <cover.1599634208.git.rahul.tanwar@linux.intel.com>
 <ecb6794a8f2ef6576421e6d5fbdf4e6a91f06b91.1599634208.git.rahul.tanwar@linux.intel.com>
 <a3b95ea8-372b-4f03-0c04-62ee9384fafb@roeck-us.net>
 <c72665ba-b594-bbb0-00c5-ed763233d609@linux.intel.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <43fa9032-a6fe-872d-c9a8-668d6e98e400@roeck-us.net>
Date:   Thu, 10 Sep 2020 02:34:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <c72665ba-b594-bbb0-00c5-ed763233d609@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/10/20 12:27 AM, Tanwar, Rahul wrote:
> 
> Hi Guenter,
> 
> Thanks for the review & feedback.
> 
> On 9/9/2020 11:05 pm, Guenter Roeck wrote:
>> On 9/8/20 11:52 PM, Rahul Tanwar wrote:
>>> PVT controller (MR75203) is used to configure & control
>>> Moortec embedded analog IP which contains temprature
>>> sensor(TS), voltage monitor(VM) & process detector(PD)
>>> modules. Add driver to support MR75203 PVT controller.
>>>
>> The subject needs to include a hint that this is a hardware monitoring
>> driver, and the above should be "Add hardware monitoring driver to ...".
>>
>>> Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>
>>> ---
>>>  drivers/hwmon/Kconfig   |  10 +
>>>  drivers/hwmon/Makefile  |   1 +
>>>  drivers/hwmon/mr75203.c | 617 ++++++++++++++++++++++++++++++++++++++++++++++++
>>>  3 files changed, 628 insertions(+)
>>>  create mode 100644 drivers/hwmon/mr75203.c
>>>
>>> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
>>> index 8dc28b26916e..2defb46677b4 100644
>>> --- a/drivers/hwmon/Kconfig
>>> +++ b/drivers/hwmon/Kconfig
>>> @@ -1112,6 +1112,16 @@ config SENSORS_MENF21BMC_HWMON
>>>  	  This driver can also be built as a module. If so the module
>>>  	  will be called menf21bmc_hwmon.
>>>  
>>> +config SENSORS_MR75203
>>> +	tristate "Moortec Semiconductor MR75203 PVT Controller"
>>> +	select REGMAP_MMIO
>>> +	help
>>> +	  If you say yes here you get support for Moortec MR75203
>>> +	  PVT controller.
>>> +
>>> +	  This driver can also be built as a module. If so, the module
>>> +	  will be called mr75203.
>>> +
>>>  config SENSORS_ADCXX
>>>  	tristate "National Semiconductor ADCxxxSxxx"
>>>  	depends on SPI_MASTER
>>> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
>>> index a8f4b35b136b..bb4bd92a5149 100644
>>> --- a/drivers/hwmon/Makefile
>>> +++ b/drivers/hwmon/Makefile
>>> @@ -142,6 +142,7 @@ obj-$(CONFIG_SENSORS_MCP3021)	+= mcp3021.o
>>>  obj-$(CONFIG_SENSORS_TC654)	+= tc654.o
>>>  obj-$(CONFIG_SENSORS_MLXREG_FAN) += mlxreg-fan.o
>>>  obj-$(CONFIG_SENSORS_MENF21BMC_HWMON) += menf21bmc_hwmon.o
>>> +obj-$(CONFIG_SENSORS_MR75203)	+= mr75203.o
>>>  obj-$(CONFIG_SENSORS_NCT6683)	+= nct6683.o
>>>  obj-$(CONFIG_SENSORS_NCT6775)	+= nct6775.o
>>>  obj-$(CONFIG_SENSORS_NCT7802)	+= nct7802.o
>>> diff --git a/drivers/hwmon/mr75203.c b/drivers/hwmon/mr75203.c
>>> new file mode 100644
>>> index 000000000000..8b616e53f27b
>>> --- /dev/null
>>> +++ b/drivers/hwmon/mr75203.c
>>> @@ -0,0 +1,617 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/*
>>> + * Copyright (C) 2020 MaxLinear, Inc.
>>> + *
>>> + * This driver is for PVT controller (MR75203) which is used
>>> + * to configure & control Moortec embedded analog IP to enable
>>> + * multiple embedded temprature sensor(TS), voltage monitor(VM)
>>> + * & process detector(PD) modules.
>>> + */
>>> +#include <linux/clk.h>
>>> +#include <linux/hwmon.h>
>>> +#include <linux/module.h>
>>> +#include <linux/mutex.h>
>>> +#include <linux/of.h>
>>> +#include <linux/platform_device.h>
>>> +#include <linux/regmap.h>
>>> +#include <linux/reset.h>
>>> +
>>> +/* PVT Common register */
>>> +#define PVT_IP_CONFIG	0x04
>>> +#define TS_NUM_MSK	GENMASK(4, 0)
>>> +#define TS_NUM_SFT	0
>>> +#define PD_NUM_MSK	GENMASK(12, 8)
>>> +#define PD_NUM_SFT	8
>>> +#define VM_NUM_MSK	GENMASK(20, 16)
>>> +#define VM_NUM_SFT	16
>>> +#define CH_NUM_MSK	GENMASK(31, 24)
>>> +#define CH_NUM_SFT	24
>>> +
>>> +/* Macro Common Register */
>>> +#define CLK_SYNTH		0x00
>>> +#define CLK_SYNTH_LO_SFT	0
>>> +#define CLK_SYNTH_HI_SFT	8
>>> +#define CLK_SYNTH_HOLD_SFT	16
>>> +#define CLK_SYNTH_EN		BIT(24)
>>> +
>>> +#define SDIF_DISABLE	0x04
>>> +
>>> +#define SDIF_STAT	0x08
>>> +#define SDIF_BUSY	BIT(0)
>>> +#define SDIF_LOCK	BIT(1)
>>> +
>>> +#define SDIF_W		0x0c
>>> +#define SDIF_PROG	BIT(31)
>>> +#define SDIF_WRN_W	BIT(27)
>>> +#define SDIF_WRN_R	0x00
>>> +#define SDIF_ADDR_SFT	24
>>> +
>>> +#define SDIF_HALT	0x10
>>> +#define SDIF_CTRL	0x14
>>> +#define SDIF_SMPL_CTRL	0x20
>>> +
>>> +/* TS & PD Individual Macro Register */
>>> +#define COM_REG_SIZE	0x40
>>> +
>>> +#define SDIF_DONE(n)	(COM_REG_SIZE + 0x14 + 0x40 * (n))
>>> +#define SDIF_SMPL_DONE	BIT(0)
>>> +
>>> +#define SDIF_DATA(n)	(COM_REG_SIZE + 0x18 + 0x40 * (n))
>>> +#define SAMPLE_DATA_MSK	GENMASK(15, 0)
>>> +
>>> +#define HILO_RESET(n)	(COM_REG_SIZE + 0x2c + 0x40 * (n))
>>> +
>>> +/* VM Individual Macro Register */
>>> +#define VM_COM_REG_SIZE	0x200
>>> +#define VM_SDIF_DONE(n)	(VM_COM_REG_SIZE + 0x34 + 0x200 * (n))
>>> +#define VM_SDIF_DATA(n)	(VM_COM_REG_SIZE + 0x40 + 0x200 * (n))
>>> +
>>> +/* SDA Slave Register */
>>> +#define IP_CTRL			0x00
>>> +#define IP_RST_REL		BIT(1)
>>> +#define IP_RUN_CONT		BIT(3)
>>> +#define IP_AUTO			BIT(8)
>>> +#define IP_VM_MODE		BIT(10)
>>> +
>>> +#define IP_CFG			0x01
>>> +#define CFG0_MODE_2		BIT(0)
>>> +#define CFG0_PARALLEL_OUT	0
>>> +#define CFG0_12_BIT		0
>>> +#define CFG1_VOL_MEAS_MODE	0
>>> +#define CFG1_PARALLEL_OUT	0
>>> +#define CFG1_14_BIT		0
>>> +
>>> +#define IP_DATA		0x03
>>> +
>>> +#define IP_POLL		0x04
>>> +#define VM_CH_INIT	BIT(20)
>>> +#define VM_CH_REQ	BIT(21)
>>> +
>>> +#define IP_TMR			0x05
>>> +#define POWER_DELAY_CYCLE_256	0x80
>>> +#define POWER_DELAY_CYCLE_64	0x40
>>> +
>>> +#define PVT_POLL_DELAY_US	20
>>> +#define PVT_POLL_TIMEOUT	20000
>>> +#define PVT_H_CONST		100000
>>> +#define PVT_CAL5_CONST		2047
>>> +#define PVT_G_CONST		40000
>>> +#define PVT_CONV_BITS		10
>>> +#define PVT_N_CONST		90
>>> +#define PVT_R_CONST		245805
>>> +
>>> +struct pvt_device {
>>> +	struct regmap		*c_map;
>>> +	struct regmap		*t_map;
>>> +	struct regmap		*p_map;
>>> +	struct regmap		*v_map;
>>> +	struct clk		*clk;
>>> +	struct reset_control	*rst;
>>> +	u32			t_num;
>>> +	u32			p_num;
>>> +	u32			v_num;
>>> +	u32			ip_freq;
>>> +	u8			*vm_idx;
>>> +	struct mutex		lock; /* lock to protect register */
>>> +};
>>> +
>>> +static umode_t pvt_is_visible(const void *data, enum hwmon_sensor_types type,
>>> +			      u32 attr, int channel)
>>> +{
>>> +	switch (type) {
>>> +	case hwmon_temp:
>>> +		if (attr == hwmon_temp_input)
>>> +			return 0444;
>>> +		else
>>> +			return 0;
>>> +	case hwmon_in:
>>> +		if (attr == hwmon_in_input)
>>> +			return 0444;
>>> +		else
>>> +			return 0;
>>> +	default:
>>> +		return 0;
>>> +	}
>>> +}
>>> +
>>> +static int pvt_read_temp(struct device *dev, u32 attr, int channel, long *val)
>>> +{
>>> +	struct pvt_device *pvt = dev_get_drvdata(dev);
>>> +	struct regmap *t_map = pvt->t_map;
>>> +	u32 stat, nbs;
>>> +	int ret;
>>> +	u64 tmp;
>>> +
>>> +	if (channel >= pvt->t_num)
>>> +		return -EINVAL;
>>> +
>>> +	switch (attr) {
>>> +	case hwmon_temp_input:
>>> +		mutex_lock(&pvt->lock);
>>> +		ret = regmap_read_poll_timeout(t_map, SDIF_DONE(channel),
>>> +					       stat, stat & SDIF_SMPL_DONE,
>>> +					       PVT_POLL_DELAY_US,
>>> +					       PVT_POLL_TIMEOUT);
>>> +		if (ret) {
>>> +			mutex_unlock(&pvt->lock);
>>> +			return ret;
>>> +		}
>>> +
>>> +		regmap_read(t_map, SDIF_DATA(channel), &nbs);
>>> +		nbs &= SAMPLE_DATA_MSK;
>>> +		mutex_unlock(&pvt->lock);
>>> +
>>> +		/*
>>> +		 * Convert the register value to
>>> +		 * degrees centigrade temperature
>>> +		 */
>>> +		tmp = nbs * PVT_H_CONST;
>>> +		do_div(tmp, PVT_CAL5_CONST);
>>> +		*val = tmp - PVT_G_CONST - pvt->ip_freq;
>>> +
>>> +		return 0;
>>> +	default:
>>> +		return -EOPNOTSUPP;
>>> +	}
>>> +}
>>> +
>>> +static int pvt_read_in(struct device *dev, u32 attr, int channel, long *val)
>>> +{
>>> +	struct pvt_device *pvt = dev_get_drvdata(dev);
>>> +	struct regmap *v_map = pvt->v_map;
>>> +	u32 n, stat;
>>> +	u8 vm_idx;
>>> +	int ret;
>>> +
>>> +	if (channel >= pvt->v_num)
>>> +		return -EINVAL;
>>> +
>>> +	vm_idx = pvt->vm_idx[channel];
>>> +
>>> +	switch (attr) {
>>> +	case hwmon_in_input:
>>> +		mutex_lock(&pvt->lock);
>>> +		ret = regmap_read_poll_timeout(v_map, VM_SDIF_DONE(vm_idx),
>>> +					       stat, stat & SDIF_SMPL_DONE,
>>> +					       PVT_POLL_DELAY_US,
>>> +					       PVT_POLL_TIMEOUT);
>>> +		if (ret) {
>>> +			mutex_unlock(&pvt->lock);
>>> +			return ret;
>>> +		}
>>> +
>>> +		regmap_read(v_map, VM_SDIF_DATA(vm_idx), &n);
>>> +		n &= SAMPLE_DATA_MSK;
>>> +		mutex_unlock(&pvt->lock);
>>> +
>>> +
>>> +		/* Convert the N bitstream count into voltage */
>>> +		*val = (PVT_N_CONST * n - PVT_R_CONST) >> PVT_CONV_BITS;
>>> +
>>> +		return 0;
>>> +	default:
>>> +		return -EOPNOTSUPP;
>>> +	}
>>> +}
>>> +
>>> +static int pvt_read(struct device *dev, enum hwmon_sensor_types type,
>>> +		    u32 attr, int channel, long *val)
>>> +{
>>> +	switch (type) {
>>> +	case hwmon_temp:
>>> +		return pvt_read_temp(dev, attr, channel, val);
>>> +	case hwmon_in:
>>> +		return pvt_read_in(dev, attr, channel, val);
>>> +	default:
>>> +		return -EOPNOTSUPP;
>>> +	}
>>> +}
>>> +
>>> +static const u32 pvt_chip_config[] = {
>>> +	HWMON_C_REGISTER_TZ,
>>> +	0
>>> +};
>>> +
>>> +static const struct hwmon_channel_info pvt_chip = {
>>> +	.type = hwmon_chip,
>>> +	.config = pvt_chip_config,
>>> +};
>>> +
>>> +static struct hwmon_channel_info pvt_temp = {
>>> +	.type = hwmon_temp,
>>> +};
>>> +
>>> +static struct hwmon_channel_info pvt_in = {
>>> +	.type = hwmon_in,
>>> +};
>>> +
>>> +static const struct hwmon_ops pvt_hwmon_ops = {
>>> +	.is_visible = pvt_is_visible,
>>> +	.read = pvt_read,
>>> +};
>>> +
>>> +static struct hwmon_chip_info pvt_chip_info = {
>>> +	.ops = &pvt_hwmon_ops,
>>> +};
>>> +
>>> +static int pvt_init(struct pvt_device *pvt)
>>> +{
>>> +	u16 sys_freq, key, middle, low = 4, high = 8;
>>> +	struct regmap *t_map = pvt->t_map;
>>> +	struct regmap *p_map = pvt->p_map;
>>> +	struct regmap *v_map = pvt->v_map;
>>> +	u32 t_num = pvt->t_num;
>>> +	u32 p_num = pvt->p_num;
>>> +	u32 v_num = pvt->v_num;
>>> +	u32 clk_synth, val;
>>> +	int ret;
>>> +
>>> +	sys_freq = clk_get_rate(pvt->clk) / 1000000;
>>> +	while (high >= low) {
>>> +		middle = DIV_ROUND_CLOSEST(low + high, 2);
>>> +		key = DIV_ROUND_CLOSEST(sys_freq, middle);
>>> +		if (key > 514) {
>>> +			low = middle + 1;
>>> +			continue;
>>> +		} else if (key < 2) {
>>> +			high = middle - 1;
>>> +			continue;
>>> +		}
>>> +
>>> +		break;
>>> +	}
>>> +
>>> +	key = clamp_val(key, 2, 514) - 2;
>>> +
>>> +	clk_synth = ((key + 1) >> 1) << CLK_SYNTH_LO_SFT |
>>> +		    (key >> 1) << CLK_SYNTH_HI_SFT |
>>> +		    (key >> 1) << CLK_SYNTH_HOLD_SFT | CLK_SYNTH_EN;
>>> +
>>> +	pvt->ip_freq = sys_freq * 100 / (key + 2);
>>> +
>>> +	if (t_num) {
>>> +		regmap_write(t_map, SDIF_SMPL_CTRL, 0x0);
>>> +		regmap_write(t_map, SDIF_HALT, 0x0);
>>> +		regmap_write(t_map, CLK_SYNTH, clk_synth);
>>> +		regmap_write(t_map, SDIF_DISABLE, 0);
>>> +
>>> +		ret = regmap_read_poll_timeout(t_map, SDIF_STAT,
>>> +					       val, !(val & SDIF_BUSY),
>>> +					       PVT_POLL_DELAY_US,
>>> +					       PVT_POLL_TIMEOUT);
>>> +		if (ret)
>>> +			return ret;
>>> +
>>> +		val = CFG0_MODE_2 | CFG0_PARALLEL_OUT | CFG0_12_BIT |
>>> +		      IP_CFG << SDIF_ADDR_SFT | SDIF_WRN_W | SDIF_PROG;
>>> +		regmap_write(t_map, SDIF_W, val);
>>> +
>>> +		ret = regmap_read_poll_timeout(t_map, SDIF_STAT,
>>> +					       val, !(val & SDIF_BUSY),
>>> +					       PVT_POLL_DELAY_US,
>>> +					       PVT_POLL_TIMEOUT);
>>> +		if (ret)
>>> +			return ret;
>>> +
>>> +		val = POWER_DELAY_CYCLE_256 | IP_TMR << SDIF_ADDR_SFT |
>>> +			      SDIF_WRN_W | SDIF_PROG;
>>> +		regmap_write(t_map, SDIF_W, val);
>>> +
>>> +		ret = regmap_read_poll_timeout(t_map, SDIF_STAT,
>>> +					       val, !(val & SDIF_BUSY),
>>> +					       PVT_POLL_DELAY_US,
>>> +					       PVT_POLL_TIMEOUT);
>>> +		if (ret)
>>> +			return ret;
>>> +
>>> +		val = IP_RST_REL | IP_RUN_CONT | IP_AUTO |
>>> +		      IP_CTRL << SDIF_ADDR_SFT |
>>> +		      SDIF_WRN_W | SDIF_PROG;
>>> +		regmap_write(t_map, SDIF_W, val);
>>> +	}
>>> +
>>> +	if (p_num) {
>>> +		regmap_write(p_map, SDIF_HALT, 0x0);
>>> +		regmap_write(p_map, SDIF_DISABLE, GENMASK(p_num - 1, 0));
>>> +		regmap_write(p_map, CLK_SYNTH, clk_synth);
>>> +	}
>>> +
>>> +	if (v_num) {
>>> +		regmap_write(v_map, SDIF_SMPL_CTRL, 0x0);
>>> +		regmap_write(v_map, SDIF_HALT, 0x0);
>>> +		regmap_write(v_map, CLK_SYNTH, clk_synth);
>>> +		regmap_write(v_map, SDIF_DISABLE, 0);
>>> +
>>> +		ret = regmap_read_poll_timeout(v_map, SDIF_STAT,
>>> +					       val, !(val & SDIF_BUSY),
>>> +					       PVT_POLL_DELAY_US,
>>> +					       PVT_POLL_TIMEOUT);
>>> +		if (ret)
>>> +			return ret;
>>> +
>>> +		val = CFG1_VOL_MEAS_MODE | CFG1_PARALLEL_OUT |
>>> +		      CFG1_14_BIT | IP_CFG << SDIF_ADDR_SFT |
>>> +		      SDIF_WRN_W | SDIF_PROG;
>>> +		regmap_write(v_map, SDIF_W, val);
>>> +
>>> +		ret = regmap_read_poll_timeout(v_map, SDIF_STAT,
>>> +					       val, !(val & SDIF_BUSY),
>>> +					       PVT_POLL_DELAY_US,
>>> +					       PVT_POLL_TIMEOUT);
>>> +		if (ret)
>>> +			return ret;
>>> +
>>> +		val = POWER_DELAY_CYCLE_64 | IP_TMR << SDIF_ADDR_SFT |
>>> +		      SDIF_WRN_W | SDIF_PROG;
>>> +		regmap_write(v_map, SDIF_W, val);
>>> +
>>> +		ret = regmap_read_poll_timeout(v_map, SDIF_STAT,
>>> +					       val, !(val & SDIF_BUSY),
>>> +					       PVT_POLL_DELAY_US,
>>> +					       PVT_POLL_TIMEOUT);
>>> +		if (ret)
>>> +			return ret;
>>> +
>>> +		val = IP_RST_REL | IP_RUN_CONT | IP_AUTO | IP_VM_MODE |
>>> +		      IP_CTRL << SDIF_ADDR_SFT |
>>> +		      SDIF_WRN_W | SDIF_PROG;
>>> +		regmap_write(v_map, SDIF_W, val);
>>> +	}
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static struct regmap_config pvt_regmap_config = {
>>> +	.reg_bits = 32,
>>> +	.reg_stride = 4,
>>> +	.val_bits = 32,
>>> +};
>>> +
>>> +static int pvt_get_regmap(struct platform_device *pdev, char *reg_name)
>>> +{
>>> +	struct device *dev = &pdev->dev;
>>> +	struct pvt_device *pvt = platform_get_drvdata(pdev);
>> I am quite at loss how this is supposed to work. Platform driver
>> data is not initialized with a pointer to struct pvt_device at this point.
>> How does this code not crash ? What am I missing ?
> 
> Big mistake on my part. Last minute change based on internal review feedback
> about moving platform_set_drvdata() at the end of probe. I will fix it in v2.
> Thanks.
> 
>>> +	struct regmap **reg_map;
>>> +	void __iomem *io_base;
>>> +	struct resource *res;
>>> +
>>> +	if (!strcmp(reg_name, "common"))
>>> +		reg_map = &pvt->c_map;
>>> +	else if (!strcmp(reg_name, "ts"))
>>> +		reg_map = &pvt->t_map;
>>> +	else if (!strcmp(reg_name, "pd"))
>>> +		reg_map = &pvt->p_map;
>>> +	else if (!strcmp(reg_name, "vm"))
>>> +		reg_map = &pvt->v_map;
>>> +	else
>>> +		return -EINVAL;
>>> +
>>> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, reg_name);
>>> +	io_base = devm_ioremap_resource(dev, res);
>>> +	if (IS_ERR(io_base))
>>> +		return PTR_ERR(io_base);
>>> +
>>> +	pvt_regmap_config.name = reg_name;
>>> +	*reg_map = devm_regmap_init_mmio(dev, io_base, &pvt_regmap_config);
>>> +	if (IS_ERR(*reg_map)) {
>>> +		dev_err(dev, "failed to init register map\n");
>>> +		return PTR_ERR(*reg_map);
>>> +	}
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static void pvt_clk_disable(void *data)
>>> +{
>>> +	struct pvt_device *pvt = data;
>>> +
>>> +	clk_disable_unprepare(pvt->clk);
>>> +}
>>> +
>>> +static int pvt_clk_enable(struct device *dev, struct pvt_device *pvt)
>>> +{
>>> +	int ret;
>>> +
>>> +	ret = clk_prepare_enable(pvt->clk);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	return devm_add_action_or_reset(dev, pvt_clk_disable, pvt);
>>> +}
>>> +
>>> +static void pvt_reset_control_assert(void *data)
>>> +{
>>> +	struct pvt_device *pvt = data;
>>> +
>>> +	reset_control_assert(pvt->rst);
>>> +}
>>> +
>>> +static int pvt_reset_control_deassert(struct device *dev, struct pvt_device *pvt)
>>> +{
>>> +	int ret;
>>> +
>>> +	ret = reset_control_deassert(pvt->rst);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	return devm_add_action_or_reset(dev, pvt_reset_control_assert, pvt);
>>> +}
>>> +
>>> +static int mr75203_probe(struct platform_device *pdev)
>>> +{
>>> +	const struct hwmon_channel_info **pvt_info;
>>> +	u32 ts_num, vm_num, pd_num, val, index, i;
>>> +	struct device *dev = &pdev->dev;
>>> +	u32 *temp_config, *in_config;
>>> +	struct device *hwmon_dev;
>>> +	struct pvt_device *pvt;
>>> +	int ret;
>>> +
>>> +	pvt = devm_kzalloc(dev, sizeof(*pvt), GFP_KERNEL);
>>> +	if (!pvt)
>>> +		return -ENOMEM;
>>> +
>>> +	ret = pvt_get_regmap(pdev, "common");
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	pvt->rst = devm_reset_control_get(dev, NULL);
>>> +	if (IS_ERR(pvt->rst))
>>> +		return dev_err_probe(dev, PTR_ERR(pvt->rst),
>>> +				     "failed to get reset control\n");
>>> +
>>> +	ret = pvt_reset_control_deassert(dev, pvt);
>>> +	if (ret)
>>> +		return dev_err_probe(dev, ret, "cannot deassert reset control\n");
>>> +
>>> +	pvt->clk = devm_clk_get(dev, NULL);
>>> +	if (IS_ERR(pvt->clk))
>>> +		return dev_err_probe(dev, PTR_ERR(pvt->clk), "failed to get clock\n");
>>> +
>>> +	ret = pvt_clk_enable(dev, pvt);
>>> +	if (ret) {
>>> +		dev_err(dev, "failed to enable clock\n");
>>> +		return ret;
>>> +	}
>>> +
>>> +	regmap_read(pvt->c_map, PVT_IP_CONFIG, &val);
>>> +	ts_num = (val & TS_NUM_MSK) >> TS_NUM_SFT;
>>> +	pd_num = (val & PD_NUM_MSK) >> PD_NUM_SFT;
>>> +	vm_num = (val & VM_NUM_MSK) >> VM_NUM_SFT;
>>> +	pvt->t_num = ts_num;
>>> +	pvt->p_num = pd_num;
>>> +	pvt->v_num = vm_num;
>>> +	val = 0;
>>> +	if (ts_num)
>>> +		val++;
>>> +	if (vm_num)
>>> +		val++;
>>> +	if (!val && !pd_num) {
>>> +		dev_err(dev, "None of TS, VM or PD configured\n");
>>> +		return -EINVAL;
>>> +	}
>> If ts_num and vm_num are both 0, the driver doesn't create any attributes and
>> would just sit there. What would be the point of that ?
> 
> ts_num and vm_num are read from a read only IP configuration register which
> is guaranteed to be non zero if the IP exists. So yes this check seems
> redundant. Are you suggesting to remove this check ?     
> 

No. From what you say, the check should be
	if (!val) {
		return -ENODEV;
	}

EINVAL it is not really appropriate - the user did nothing wrong.

Guenter

>>> +
>>> +	pvt_info = devm_kcalloc(dev, val + 2, sizeof(*pvt_info), GFP_KERNEL);
>>> +	if (!pvt_info)
>>> +		return -ENOMEM;
>>> +	pvt_info[0] = &pvt_chip;
>>> +	index = 1;
>>> +
>>> +	if (ts_num) {
>>> +		ret = pvt_get_regmap(pdev, "ts");
>>> +		if (ret)
>>> +			return ret;
>>> +
>>> +		temp_config = devm_kcalloc(dev, ts_num + 1,
>>> +					   sizeof(*temp_config), GFP_KERNEL);
>>> +		if (!temp_config)
>>> +			return -ENOMEM;
>>> +
>>> +		for (i = 0; i < ts_num; i++)
>>> +			temp_config[i] = HWMON_T_INPUT;
>>> +
>>> +		temp_config[ts_num] = 0;
>>> +		pvt_temp.config = temp_config;
>>> +
>>> +		pvt_info[index++] = &pvt_temp;
>>> +	}
>>> +
>>> +	if (pd_num) {
>>> +		ret = pvt_get_regmap(pdev, "pd");
>>> +		if (ret)
>>> +			return ret;
>>> +	}
>>> +
>>> +	if (vm_num) {
>>> +		u32 num = vm_num;
>>> +
>>> +		ret = pvt_get_regmap(pdev, "vm");
>>> +		if (ret)
>>> +			return ret;
>>> +
>>> +		pvt->vm_idx = devm_kcalloc(dev, vm_num, sizeof(*pvt->vm_idx),
>>> +					   GFP_KERNEL);
>>> +		if (!pvt->vm_idx)
>>> +			return -ENOMEM;
>>> +
>>> +		for (i = 0; i < vm_num; i++)
>>> +			pvt->vm_idx[i] = i;
>>> +
>>> +		ret = of_property_read_u8_array(dev->of_node, "vm-map",
>>> +						pvt->vm_idx, vm_num);
>>> +
>>> +		if (!ret)
>>> +			for (i = 0; i < vm_num; i++)
>>> +				if (pvt->vm_idx[i] >= vm_num ||
>>> +				    pvt->vm_idx[i] == 0xff) {
>>> +					num = i;
>>> +					break;
>>> +				}
>>> +
>>> +		in_config = devm_kcalloc(dev, num + 1,
>>> +					 sizeof(*in_config), GFP_KERNEL);
>>> +		if (!in_config)
>>> +			return -ENOMEM;
>>> +
>>> +		for (i = 0; i < num; i++)
>>> +			in_config[i] = HWMON_I_INPUT;
>>> +
>>> +		in_config[num] = 0;
>>> +		pvt_in.config = in_config;
>>> +
>>> +		pvt_info[index++] = &pvt_in;
>>> +	}
>>> +
>>> +	ret = pvt_init(pvt);
>>> +	if (ret) {
>>> +		dev_err(dev, "failed to init pvt: %d\n", ret);
>>> +		return ret;
>>> +	}
>>> +
>>> +	mutex_init(&pvt->lock);
>>> +
>>> +	pvt_info[index] = NULL;
>> Unnecessary.
> 
> Well noted.
> 
>>> +	pvt_chip_info.info = pvt_info;
>>> +	hwmon_dev = devm_hwmon_device_register_with_info(dev, "pvt",
>>> +							 pvt,
>>> +							 &pvt_chip_info,
>>> +							 NULL);
>>> +
>>> +	platform_set_drvdata(pdev, pvt);
>> Again, I fail to understand how this is supposed to work.
> 
> Yup, this was a mistake. This is supposed to be on the top of probe just after
> pvt_device allocation. Will fix it in v2.
> 

Seems to be pretty useless, though. It is only used from the probe function,
to avoid passing an extra parameter to pvt_get_regmap(). Why not just pass
this parameter ?

Guenter

>>> +	return PTR_ERR_OR_ZERO(hwmon_dev);
>>> +}
>>> +
>>> +static const struct of_device_id moortec_pvt_of_match[] = {
>>> +	{ .compatible = "moortec,mr75203" },
>>> +	{ }
>>> +};
>>> +MODULE_DEVICE_TABLE(of, moortec_pvt_of_match);
>>> +
>>> +static struct platform_driver moortec_pvt_driver = {
>>> +	.driver = {
>>> +		.name = "moortec-pvt",
>>> +		.of_match_table = moortec_pvt_of_match,
>>> +	},
>>> +	.probe = mr75203_probe,
>>> +};
>>> +module_platform_driver(moortec_pvt_driver);
>>>
> 
> Regards,
> Rahul
> 

