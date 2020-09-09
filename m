Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78262C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 13:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 254F22087C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 13:15:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X2yJ+FRX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730278AbgIINPj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 09:15:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23610 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727893AbgIINM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 09:12:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599657178;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0Ss0bDyzSRTte7sY8TzaKQQKHaTIs8r9CpS8l9G6wR4=;
        b=X2yJ+FRX2VGxv4/tZHZgAWbznREqKWRobjv7revXCdOV2+pPm9dUcmU+Mk62epaOBJEQDJ
        3NnVEmvLtGLo7zaGJNkQfmzJus+ThB6c5W4BvnZtJd8jdugVhC/CKHKCwwuL5NrV3p1l60
        wXk9paqq97PZ/z0SJWzqmHf3ZxqF2/M=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-330-E234K8C3OVaV6mrdBOEwZw-1; Wed, 09 Sep 2020 09:12:56 -0400
X-MC-Unique: E234K8C3OVaV6mrdBOEwZw-1
Received: by mail-qt1-f200.google.com with SMTP id z27so1748783qtu.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 06:12:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=0Ss0bDyzSRTte7sY8TzaKQQKHaTIs8r9CpS8l9G6wR4=;
        b=dxn3NY9sZhzT3+5MOEpDsiK6LAmVr7gKi5vRgvZctn3Hqr419M9/fKE6RULV5f+HOR
         MW8N1OgKLCJMvg9HfmMR54XCci8N3hD06Z3PzPpLfitTsJejWsyXB0SzRiIS4z3VqRyi
         GYIU9eIo2pL++0mMcB3wlKKEfghjiKq4dVR2a8o7cWcxQ6r/gKizLkbgawBhQ84em+DW
         YEsajemfSSiAOCXxB1hqVv8eZie2o7Wytav6+BLUHWj1oCQihB6Yy3FaCgzZfxzPaEfe
         OX4xF+H6IbfpsBdt5AaPhnbNXJrGwcvm4xfiIrqyBTqI1u3Ybfq/Oohz4cToznj+w2kd
         26tw==
X-Gm-Message-State: AOAM531u4wLseKXsxF4WhKnJFPdb1qYftRqCEXT/KyMHasSNgc5G0j2k
        ANkMwaWsIVL0qbgr6rvrRAJg45fgsme87UZx46Yme2Dl7W/CZfncoiyx/E3RPlappP/QiIM4VAE
        Dvwy87wTaRZA586EVmZZ0+GZD
X-Received: by 2002:ac8:24f1:: with SMTP id t46mr3009727qtt.93.1599657175771;
        Wed, 09 Sep 2020 06:12:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzf/mAz+SaluP1QMj9fytTHvaqzIRm5F01RDCfwdBH2et1fDFWzU4ENV3g1kpfW219he82AqQ==
X-Received: by 2002:ac8:24f1:: with SMTP id t46mr3009695qtt.93.1599657175366;
        Wed, 09 Sep 2020 06:12:55 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id u18sm2923943qtk.61.2020.09.09.06.12.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2020 06:12:54 -0700 (PDT)
Subject: Re: [PATCH 3/3] fpga: dfl: move dfl-bus related APIs to
 include/linux/fpga/dfl-bus.h
To:     Xu Yilun <yilun.xu@intel.com>, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        masahiroy@kernel.org
Cc:     lgoncalv@redhat.com
References: <1599544129-17594-1-git-send-email-yilun.xu@intel.com>
 <1599544129-17594-4-git-send-email-yilun.xu@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <b8242b42-6db1-63ae-6207-ac85766a7c9c@redhat.com>
Date:   Wed, 9 Sep 2020 06:12:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1599544129-17594-4-git-send-email-yilun.xu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/7/20 10:48 PM, Xu Yilun wrote:
> The patch moves dfl-bus related APIs to include/linux/fpga/dfl-bus.h

Should add a line in the MAINTAINERS under FPGA DFL DRIVERS

F:      include/linux/fpga/dfl-bus.h

Otherwise a straight forward move.

Looks good to me.

Reviewed-by: Tom Rix <trix@redhat.com>

>
> Now the DFL sub feature drivers could be made as independent modules and
> put in different folders according to their functionality. In order for
> scattered sub feature drivers to include dfl bus APIs, move the dfl bus
> APIs to a new header file in the public folder.
>
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> ---
>  drivers/fpga/dfl-n3000-nios.c |  3 +-
>  drivers/fpga/dfl.c            |  1 +
>  drivers/fpga/dfl.h            | 73 ------------------------------------
>  include/linux/fpga/dfl-bus.h  | 86 +++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 88 insertions(+), 75 deletions(-)
>  create mode 100644 include/linux/fpga/dfl-bus.h
>
> diff --git a/drivers/fpga/dfl-n3000-nios.c b/drivers/fpga/dfl-n3000-nios.c
> index 70b44c3..d5f8b5b 100644
> --- a/drivers/fpga/dfl-n3000-nios.c
> +++ b/drivers/fpga/dfl-n3000-nios.c
> @@ -11,6 +11,7 @@
>   */
>  #include <linux/bitfield.h>
>  #include <linux/errno.h>
> +#include <linux/fpga/dfl-bus.h>
>  #include <linux/io.h>
>  #include <linux/io-64-nonatomic-lo-hi.h>
>  #include <linux/kernel.h>
> @@ -22,8 +23,6 @@
>  #include <linux/spi/spi.h>
>  #include <linux/types.h>
>  
> -#include "dfl.h"
> -
>  static char *fec_mode = "rs";
>  module_param(fec_mode, charp, 0444);
>  MODULE_PARM_DESC(fec_mode, "FEC mode of the ethernet retimer on Intel PAC N3000");
> diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
> index b450870..02a6780 100644
> --- a/drivers/fpga/dfl.c
> +++ b/drivers/fpga/dfl.c
> @@ -11,6 +11,7 @@
>   *   Xiao Guangrong <guangrong.xiao@linux.intel.com>
>   */
>  #include <linux/fpga-dfl.h>
> +#include <linux/fpga/dfl-bus.h>
>  #include <linux/module.h>
>  #include <linux/uaccess.h>
>  
> diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
> index d5b0760..03f73d9 100644
> --- a/drivers/fpga/dfl.h
> +++ b/drivers/fpga/dfl.h
> @@ -26,7 +26,6 @@
>  #include <linux/slab.h>
>  #include <linux/uuid.h>
>  #include <linux/fpga/fpga-region.h>
> -#include <linux/mod_devicetable.h>
>  
>  /* maximum supported number of ports */
>  #define MAX_DFL_FPGA_PORT_NUM 4
> @@ -517,76 +516,4 @@ long dfl_feature_ioctl_set_irq(struct platform_device *pdev,
>  			       struct dfl_feature *feature,
>  			       unsigned long arg);
>  
> -/**
> - * enum dfl_id_type - define the DFL FIU types
> - */
> -enum dfl_id_type {
> -	FME_ID,
> -	PORT_ID,
> -	DFL_ID_MAX,
> -};
> -
> -/**
> - * struct dfl_device - represent an dfl device on dfl bus
> - *
> - * @dev: generic device interface.
> - * @id: id of the dfl device.
> - * @type: type of DFL FIU of the device. See enum dfl_id_type.
> - * @feature_id: 16 bits feature identifier local to its DFL FIU type.
> - * @mmio_res: mmio resource of this dfl device.
> - * @irqs: list of Linux IRQ numbers of this dfl device.
> - * @num_irqs: number of IRQs supported by this dfl device.
> - * @cdev: pointer to DFL FPGA container device this dfl device belongs to.
> - * @id_entry: matched id entry in dfl driver's id table.
> - */
> -struct dfl_device {
> -	struct device dev;
> -	int id;
> -	u8 type;
> -	u16 feature_id;
> -	struct resource mmio_res;
> -	int *irqs;
> -	unsigned int num_irqs;
> -	struct dfl_fpga_cdev *cdev;
> -	const struct dfl_device_id *id_entry;
> -};
> -
> -/**
> - * struct dfl_driver - represent an dfl device driver
> - *
> - * @drv: driver model structure.
> - * @id_table: pointer to table of device IDs the driver is interested in.
> - *	      { } member terminated.
> - * @probe: mandatory callback for device binding.
> - * @remove: callback for device unbinding.
> - */
> -struct dfl_driver {
> -	struct device_driver drv;
> -	const struct dfl_device_id *id_table;
> -
> -	int (*probe)(struct dfl_device *dfl_dev);
> -	void (*remove)(struct dfl_device *dfl_dev);
> -};
> -
> -#define to_dfl_dev(d) container_of(d, struct dfl_device, dev)
> -#define to_dfl_drv(d) container_of(d, struct dfl_driver, drv)
> -
> -/*
> - * use a macro to avoid include chaining to get THIS_MODULE.
> - */
> -#define dfl_driver_register(drv) \
> -	__dfl_driver_register(drv, THIS_MODULE)
> -int __dfl_driver_register(struct dfl_driver *dfl_drv, struct module *owner);
> -void dfl_driver_unregister(struct dfl_driver *dfl_drv);
> -
> -/*
> - * module_dfl_driver() - Helper macro for drivers that don't do
> - * anything special in module init/exit.  This eliminates a lot of
> - * boilerplate.  Each module may only use this macro once, and
> - * calling it replaces module_init() and module_exit().
> - */
> -#define module_dfl_driver(__dfl_driver) \
> -	module_driver(__dfl_driver, dfl_driver_register, \
> -		      dfl_driver_unregister)
> -
>  #endif /* __FPGA_DFL_H */
> diff --git a/include/linux/fpga/dfl-bus.h b/include/linux/fpga/dfl-bus.h
> new file mode 100644
> index 0000000..2a2b283
> --- /dev/null
> +++ b/include/linux/fpga/dfl-bus.h
> @@ -0,0 +1,86 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Header File for DFL driver and device API
> + *
> + * Copyright (C) 2020 Intel Corporation, Inc.
> + */
> +
> +#ifndef __FPGA_DFL_BUS_H
> +#define __FPGA_DFL_BUS_H
> +
> +#include <linux/device.h>
> +#include <linux/mod_devicetable.h>
> +
> +/**
> + * enum dfl_id_type - define the DFL FIU types
> + */
> +enum dfl_id_type {
> +	FME_ID,
> +	PORT_ID,
> +	DFL_ID_MAX,
> +};
> +
> +/**
> + * struct dfl_device - represent an dfl device on dfl bus
> + *
> + * @dev: generic device interface.
> + * @id: id of the dfl device.
> + * @type: type of DFL FIU of the device. See enum dfl_id_type.
> + * @feature_id: 16 bits feature identifier local to its DFL FIU type.
> + * @mmio_res: mmio resource of this dfl device.
> + * @irqs: list of Linux IRQ numbers of this dfl device.
> + * @num_irqs: number of IRQs supported by this dfl device.
> + * @cdev: pointer to DFL FPGA container device this dfl device belongs to.
> + * @id_entry: matched id entry in dfl driver's id table.
> + */
> +struct dfl_device {
> +	struct device dev;
> +	int id;
> +	u8 type;
> +	u16 feature_id;
> +	struct resource mmio_res;
> +	int *irqs;
> +	unsigned int num_irqs;
> +	struct dfl_fpga_cdev *cdev;
> +	const struct dfl_device_id *id_entry;
> +};
> +
> +/**
> + * struct dfl_driver - represent an dfl device driver
> + *
> + * @drv: driver model structure.
> + * @id_table: pointer to table of device IDs the driver is interested in.
> + *	      { } member terminated.
> + * @probe: mandatory callback for device binding.
> + * @remove: callback for device unbinding.
> + */
> +struct dfl_driver {
> +	struct device_driver drv;
> +	const struct dfl_device_id *id_table;
> +
> +	int (*probe)(struct dfl_device *dfl_dev);
> +	void (*remove)(struct dfl_device *dfl_dev);
> +};
> +
> +#define to_dfl_dev(d) container_of(d, struct dfl_device, dev)
> +#define to_dfl_drv(d) container_of(d, struct dfl_driver, drv)
> +
> +/*
> + * use a macro to avoid include chaining to get THIS_MODULE.
> + */
> +#define dfl_driver_register(drv) \
> +	__dfl_driver_register(drv, THIS_MODULE)
> +int __dfl_driver_register(struct dfl_driver *dfl_drv, struct module *owner);
> +void dfl_driver_unregister(struct dfl_driver *dfl_drv);
> +
> +/*
> + * module_dfl_driver() - Helper macro for drivers that don't do
> + * anything special in module init/exit.  This eliminates a lot of
> + * boilerplate.  Each module may only use this macro once, and
> + * calling it replaces module_init() and module_exit().
> + */
> +#define module_dfl_driver(__dfl_driver) \
> +	module_driver(__dfl_driver, dfl_driver_register, \
> +		      dfl_driver_unregister)
> +
> +#endif /* __FPGA_DFL_BUS_H */

