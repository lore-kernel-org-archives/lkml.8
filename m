Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C73F4C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 10:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8589F2078B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 10:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599559281;
	bh=1i+wvCzNrbPS3ln0cjAdGq4HdXMPmpzlavSBr0WrFEg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kVHKo9SR2ukzQcX8xEXJLnhnQCbK+83u0vouuryOie4uNf4BAyjddZDk/GmnLkCVo
	 q6RX+7WTlkKwaDt7v3pXO2hJZcVG/kjPm77/36FG5xhvhyv9LtxTLBLNnKDBlYnKtb
	 vqGiB5zS2SF7OzENl9xIQpJiS/dvV82eXIoxpZiM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729200AbgIHKBR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 06:01:17 -0400
Received: from mail-ed1-f41.google.com ([209.85.208.41]:43122 "EHLO
        mail-ed1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729023AbgIHKBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 06:01:09 -0400
Received: by mail-ed1-f41.google.com with SMTP id n13so15361501edo.10
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 03:01:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=l7R/rH5erV0ZByrqZZWnw2v82qq9UEV9OhZm+OXDSvo=;
        b=HCDsmG7zB8eLH02ARLnMiBJ2l5GTYORpP52nbCiRlbTwZM1yCnoyxLjHCKgyG8jklL
         KUrq/z5gEefFm1i+zZ5/5KODByeMcLNTVguPL7/0BCdg063f1uNIGjNsAQprA5/jVFXj
         FDpXWkOsSpS5TsPzvztoNX2ZbzKTrj+tpAXibl++doP3bUqhqC0yed9u8FRNtzgxK8if
         TS1udV+tC6i+5+mM79iP7S+Xj1oqNLOs6SP8+pEttgh55H/m+xh+pFqri1fUOwYZA7MH
         fixieetUBn49mhBvxLwgHcSF0brRyhTwh2RHvq7FNbLmEu8rEsQUXmxSkH6RuScGZ/nX
         mHTg==
X-Gm-Message-State: AOAM5325zLXynoCZisp8QZfmjoOw+Joz5Kd0KhL90mCzm8hkoJiLAegg
        R3hU6yONvRUZqFJYeLWdu08=
X-Google-Smtp-Source: ABdhPJxQEDdYB5mOtVFhRTNjkUrPee43OO5Yquk8kraWtdt+lA0WPmreP0NrrLkJFp0ox8h2vifgHg==
X-Received: by 2002:a50:8f85:: with SMTP id y5mr26198115edy.233.1599559266097;
        Tue, 08 Sep 2020 03:01:06 -0700 (PDT)
Received: from pi3 ([194.230.155.174])
        by smtp.googlemail.com with ESMTPSA id re19sm17390119ejb.86.2020.09.08.03.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 03:01:05 -0700 (PDT)
Date:   Tue, 8 Sep 2020 12:01:02 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     mdf@kernel.org, linux-kernel@vger.kernel.org, trix@redhat.com,
        matthew.gerlach@linux.intel.com, russell.h.weight@intel.com,
        lgoncalv@redhat.com, hao.wu@intel.com
Subject: Re: [PATCH] memory: dfl-emif: add the DFL EMIF private feature driver
Message-ID: <20200908100102.GB24693@pi3>
References: <1599553645-26928-1-git-send-email-yilun.xu@intel.com>
 <1599553645-26928-2-git-send-email-yilun.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1599553645-26928-2-git-send-email-yilun.xu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 08, 2020 at 04:27:25PM +0800, Xu Yilun wrote:
> This driver is for the EMIF private feature implemented under FPGA
> Device Feature List (DFL) framework. It is used to expose memory
> interface status information as well as memory clearing control.
> 
> The purpose of memory clearing block is to zero out all private memory
> when FPGA is to be reprogrammed. This gives users a reliable method to
> prevent potential data leakage.
> 
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> ---
>  .../ABI/testing/sysfs-bus-dfl-devices-emif         |  25 +++
>  drivers/memory/Kconfig                             |   9 +
>  drivers/memory/Makefile                            |   2 +
>  drivers/memory/dfl-emif.c                          | 211 +++++++++++++++++++++
>  4 files changed, 247 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-dfl-devices-emif
>  create mode 100644 drivers/memory/dfl-emif.c
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-dfl-devices-emif b/Documentation/ABI/testing/sysfs-bus-dfl-devices-emif
> new file mode 100644
> index 0000000..33d557e
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-dfl-devices-emif
> @@ -0,0 +1,25 @@
> +What:		/sys/bus/dfl/devices/dfl_dev.X/infX_cal_fail
> +Date:		Sep 2020
> +KernelVersion:	5.10
> +Contact:	Xu Yilun <yilun.xu@intel.com>
> +Description:	Read-only. It indicates if the calibration is failed on this
> +		memory interface. "1" for calibration failure, "0" for OK.

"if the calibration failed"

> +		Format: %u
> +
> +What:		/sys/bus/dfl/devices/dfl_dev.X/infX_init_done
> +Date:		Sep 2020
> +KernelVersion:	5.10
> +Contact:	Xu Yilun <yilun.xu@intel.com>
> +Description:	Read-only. It indicates if the initialization is complete on
> +		this memory interface. "1" for initialization complete, "0"
> +		for not yet.
> +		Format: %u

"if the initialization completed"

> +
> +What:		/sys/bus/dfl/devices/dfl_dev.X/infX_clear
> +Date:		Sep 2020
> +KernelVersion:	5.10
> +Contact:	Xu Yilun <yilun.xu@intel.com>
> +Description:	Write-only. Writing "1" to this file will zero out all memory
> +		data in this memory interface. Writing other values are
> +		invalid.

"Writing of other values is invalid."

> +		Format: %u
> diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
> index 8072204..fb0858f 100644
> --- a/drivers/memory/Kconfig
> +++ b/drivers/memory/Kconfig
> @@ -215,6 +215,15 @@ config STM32_FMC2_EBI
>  	  devices (like SRAM, ethernet adapters, FPGAs, LCD displays, ...) on
>  	  SOCs containing the FMC2 External Bus Interface.
>  
> +config FPGA_DFL_EMIF
> +	tristate "DFL EMIF private feature support"
> +	depends on FPGA_DFL && HAS_IOMEM

Cannot be compile tested without FPGA_DFL?

> +	help
> +	  This driver is for the EMIF private feature implemented under
> +	  FPGA Device Feature List (DFL) framework. It is used to expose
> +	  memory interface status information as well as memory clearing
> +	  control.

Don't add new entries in Makefiles and Kconfig at the end of file, but
rather find appropriate place. Since in Makefile this is next to
CONFIG_TI_EMIF_SRAM, add it also next to it in Kconfig.

> +
>  source "drivers/memory/samsung/Kconfig"
>  source "drivers/memory/tegra/Kconfig"
>  
> diff --git a/drivers/memory/Makefile b/drivers/memory/Makefile
> index e71cf7b..0afbf39 100644
> --- a/drivers/memory/Makefile
> +++ b/drivers/memory/Makefile
> @@ -39,3 +39,5 @@ $(obj)/ti-emif-asm-offsets.h: $(obj)/emif-asm-offsets.s FORCE
>  
>  targets += emif-asm-offsets.s
>  clean-files += ti-emif-asm-offsets.h
> +
> +obj-$(CONFIG_FPGA_DFL_EMIF)	+= dfl-emif.o
> diff --git a/drivers/memory/dfl-emif.c b/drivers/memory/dfl-emif.c
> new file mode 100644
> index 0000000..442137f
> --- /dev/null
> +++ b/drivers/memory/dfl-emif.c
> @@ -0,0 +1,211 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Driver for DFL EMIF private feature
> + *
> + * Copyright (C) 2020 Intel Corporation, Inc.
> + *
> + */
> +#include <linux/bitfield.h>
> +#include <linux/errno.h>
> +#include <linux/fpga/dfl-bus.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/io-64-nonatomic-lo-hi.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/spinlock.h>
> +#include <linux/stddef.h>

Why do you need this header?

> +#include <linux/types.h>
> +
> +#define EMIF_STAT			0x8
> +#define EMIF_STAT_INIT_DONE_SFT		0
> +#define EMIF_STAT_CALC_FAIL_SFT		8
> +#define EMIF_STAT_CLEAR_BUSY_SFT	16
> +#define EMIF_CTRL			0x10
> +#define EMIF_CTRL_CLEAR_EN_SFT		0
> +#define EMIF_CTRL_CLEAR_EN_MSK		GENMASK_ULL(3, 0)
> +
> +#define EMIF_POLL_INVL			10000 /* us */
> +#define EMIF_POLL_TIMEOUT		5000000 /* us */
> +
> +struct dfl_emif {
> +	struct device *dev;
> +	void __iomem *base;
> +	spinlock_t lock;	/* Serialises access to EMIF_CTRL reg */
> +};
> +
> +struct emif_attr {
> +	struct device_attribute attr;
> +	u32 shift;
> +	u32 index;
> +};
> +
> +#define to_emif_attr(dev_attr) \
> +	container_of(dev_attr, struct emif_attr, attr)
> +
> +static ssize_t emif_state_show(struct device *dev,
> +			       struct device_attribute *attr, char *buf)
> +{
> +	struct emif_attr *eattr = to_emif_attr(attr);
> +	struct dfl_emif *de = dev_get_drvdata(dev);
> +	u64 val;
> +
> +	val = readq(de->base + EMIF_STAT);
> +
> +	return sprintf(buf, "%u\n",
> +		       !!(val & BIT_ULL(eattr->shift + eattr->index)));
> +}
> +
> +static ssize_t emif_clear_store(struct device *dev,
> +				struct device_attribute *attr,
> +				const char *buf, size_t count)
> +{
> +	struct emif_attr *eattr = to_emif_attr(attr);
> +	struct dfl_emif *de = dev_get_drvdata(dev);
> +	u64 clear_busy_msk, clear_en_msk, val;
> +	void __iomem *base = de->base;
> +
> +	if (!sysfs_streq(buf, "1"))
> +		return -EINVAL;
> +
> +	clear_busy_msk = BIT_ULL(EMIF_STAT_CLEAR_BUSY_SFT + eattr->index);
> +	clear_en_msk = BIT_ULL(EMIF_CTRL_CLEAR_EN_SFT + eattr->index);
> +
> +	spin_lock(&de->lock);
> +	/* The CLEAR_EN field is WO, but other fields are RW */
> +	val = readq(base + EMIF_CTRL);
> +	val &= ~EMIF_CTRL_CLEAR_EN_MSK;
> +	val |= clear_en_msk;
> +	writeq(val, base + EMIF_CTRL);
> +	spin_unlock(&de->lock);
> +
> +	if (readq_poll_timeout(base + EMIF_STAT, val,
> +			       !(val & clear_busy_msk),
> +			       EMIF_POLL_INVL, EMIF_POLL_TIMEOUT)) {
> +		dev_err(de->dev, "timeout, fail to clear\n");
> +		return -ETIMEDOUT;
> +	}
> +
> +	return count;
> +}
> +
> +#define emif_state_attr(_name, _shift, _index)				\
> +	struct emif_attr emif_attr_##inf##_index##_##_name =		\
> +		{ .attr = __ATTR(inf##_index##_##_name, 0444,		\
> +				 emif_state_show, NULL),		\
> +		  .shift = (_shift), .index = (_index) }
> +
> +#define emif_clear_attr(_index)						\
> +	struct emif_attr emif_attr_##inf##_index##_clear =		\
> +		{ .attr = __ATTR(inf##_index##_clear, 0200,		\
> +				 NULL, emif_clear_store),		\
> +		  .index = (_index) }
> +
> +emif_state_attr(init_done, EMIF_STAT_INIT_DONE_SFT, 0);
> +emif_state_attr(init_done, EMIF_STAT_INIT_DONE_SFT, 1);
> +emif_state_attr(init_done, EMIF_STAT_INIT_DONE_SFT, 2);
> +emif_state_attr(init_done, EMIF_STAT_INIT_DONE_SFT, 3);
> +
> +emif_state_attr(cal_fail, EMIF_STAT_CALC_FAIL_SFT, 0);
> +emif_state_attr(cal_fail, EMIF_STAT_CALC_FAIL_SFT, 1);
> +emif_state_attr(cal_fail, EMIF_STAT_CALC_FAIL_SFT, 2);
> +emif_state_attr(cal_fail, EMIF_STAT_CALC_FAIL_SFT, 3);
> +
> +emif_clear_attr(0);
> +emif_clear_attr(1);
> +emif_clear_attr(2);
> +emif_clear_attr(3);
> +
> +static struct attribute *dfl_emif_attrs[] = {
> +	&emif_attr_inf0_init_done.attr.attr,
> +	&emif_attr_inf0_cal_fail.attr.attr,
> +	&emif_attr_inf0_clear.attr.attr,
> +
> +	&emif_attr_inf1_init_done.attr.attr,
> +	&emif_attr_inf1_cal_fail.attr.attr,
> +	&emif_attr_inf1_clear.attr.attr,
> +
> +	&emif_attr_inf2_init_done.attr.attr,
> +	&emif_attr_inf2_cal_fail.attr.attr,
> +	&emif_attr_inf2_clear.attr.attr,
> +
> +	&emif_attr_inf3_init_done.attr.attr,
> +	&emif_attr_inf3_cal_fail.attr.attr,
> +	&emif_attr_inf3_clear.attr.attr,
> +
> +	NULL,
> +};
> +
> +static umode_t dfl_emif_visible(struct kobject *kobj,
> +				struct attribute *attr, int n)
> +{
> +	struct dfl_emif *de = dev_get_drvdata(kobj_to_dev(kobj));
> +	struct emif_attr *eattr = container_of(attr, struct emif_attr,
> +					       attr.attr);
> +	u64 val;
> +
> +	/*
> +	 * This device supports upto 4 memory interfaces, but not all
> +	 * interfaces are used on different platforms. The read out value of
> +	 * CLEAN_EN field (which is a bitmap) could tell how many interfaces
> +	 * are available.
> +	 */
> +	val = FIELD_GET(EMIF_CTRL_CLEAR_EN_MSK, readq(de->base + EMIF_CTRL));
> +
> +	return (val & BIT_ULL(eattr->index)) ? attr->mode : 0;
> +}
> +
> +static const struct attribute_group dfl_emif_group = {
> +	.is_visible = dfl_emif_visible,
> +	.attrs = dfl_emif_attrs,
> +};
> +
> +static const struct attribute_group *dfl_emif_groups[] = {
> +	&dfl_emif_group,
> +	NULL,
> +};
> +
> +static int dfl_emif_probe(struct dfl_device *dfl_dev)
> +{
> +	struct device *dev = &dfl_dev->dev;
> +	struct dfl_emif *de;
> +
> +	de = devm_kzalloc(dev, sizeof(*de), GFP_KERNEL);
> +	if (!de)
> +		return -ENOMEM;
> +
> +	de->base = devm_ioremap_resource(&dfl_dev->dev, &dfl_dev->mmio_res);

You just stored device under *dev.

> +	if (IS_ERR(de->base)) {
> +		dev_err(dev, "get mem resource fail!\n");

No need for printing error. Core will handle it.

> +		return PTR_ERR(de->base);
> +	}
> +
> +	de->dev = dev;
> +	spin_lock_init(&de->lock);
> +	dev_set_drvdata(dev, de);
> +
> +	return 0;
> +}
> +
> +#define FME_FEATURE_ID_EMIF	0x9

Put defines at the beginning of file.

> +
> +static const struct dfl_device_id dfl_emif_ids[] = {
> +	{ FME_ID, FME_FEATURE_ID_EMIF },
> +	{ }
> +};
> +
> +static struct dfl_driver dfl_emif_driver = {
> +	.drv	= {
> +		.name       = "dfl-emif",
> +		.dev_groups = dfl_emif_groups,
> +	},
> +	.id_table = dfl_emif_ids,
> +	.probe   = dfl_emif_probe,
> +};
> +
> +module_dfl_driver(dfl_emif_driver);
> +
> +MODULE_DEVICE_TABLE(dfl, dfl_emif_ids);

This always goes next to the table.

Best regards,
Krzysztof
