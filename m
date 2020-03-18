Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE43BC10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 11:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 925C2205ED
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 11:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584532273;
	bh=1Yb33p2EOgcIG+yF6C3ogUaPMdffTiWMrhOm8DQm7bM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XmHbNAzffFJiaVxuPid7wpAyqIOml2CpANngQKK4Ox8XlJpVYFTzoYvR4zb1SnC2P
	 WTbMaEuMNYY9oiIU7kx6JAHHHzWfc7IM5TiXVA5cpDEzjgmpNHO0aVXu9GuZtJLuz2
	 H7VfWmHVftitai4u5BeIvcoXCDvT/lRdtnvbCki4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbgCRLvM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 07:51:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:60732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726586AbgCRLvM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 07:51:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10DDE205ED;
        Wed, 18 Mar 2020 11:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584532269;
        bh=1Yb33p2EOgcIG+yF6C3ogUaPMdffTiWMrhOm8DQm7bM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qvb6ZWhVn28Qg7oOgvHErkfXXIlDizOs4yMIVZRaGpjLFjAU0jN2Qi+GJ9hdGt1x6
         oCZ6Wgq1P5omPGzSx7PyxGVaf+qptbxBgBSNrFd75c0lGPgTb6jYvByhE2kmnOs3VH
         F1dHYqNIgWq6TJh8cxtu/OexhJn8CDiSuyG3Nu1Q=
Date:   Wed, 18 Mar 2020 12:51:05 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jolly Shah <jolly.shah@xilinx.com>
Cc:     ard.biesheuvel@linaro.org, mingo@kernel.org,
        matt@codeblueprint.co.uk, sudeep.holla@arm.com,
        hkallweit1@gmail.com, keescook@chromium.org,
        dmitry.torokhov@gmail.com, michal.simek@xilinx.com,
        rajanv@xilinx.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rajan Vaja <rajan.vaja@xilinx.com>,
        Jolly Shah <jollys@xilinx.com>,
        Tejas Patel <tejas.patel@xilinx.com>
Subject: Re: [PATCH v3 21/24] firmware: xilinx: Add sysfs interface
Message-ID: <20200318115105.GA2472686@kroah.com>
References: <1583538452-1992-1-git-send-email-jolly.shah@xilinx.com>
 <1583538452-1992-22-git-send-email-jolly.shah@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1583538452-1992-22-git-send-email-jolly.shah@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 06, 2020 at 03:47:29PM -0800, Jolly Shah wrote:
> +/**
> + * ggs_store - Store global general storage (ggs) sysfs attribute
> + * @device: Device structure
> + * @attr: Device attribute structure
> + * @buf: User entered shutdown_scope attribute string
> + * @count: Size of buf
> + * @reg: Register number
> + *
> + * Return: count argument if request succeeds, the corresponding
> + * error code otherwise
> + *
> + * Helper function for storing a ggs register value.
> + *
> + * For example, the user-space interface for storing a value to the
> + * ggs0 register:
> + * echo 0xFFFFFFFF 0x1234ABCD > /sys/devices/platform/firmware\:zynqmp-firmware/ggs0
> + */

Do you really need a whole kernel_doc format for a static function?
Anyway...

> +static ssize_t ggs_store(struct device *device,
> +			 struct device_attribute *attr,
> +			 const char *buf, size_t count,
> +			 u32 reg)
> +{
> +	char *kern_buff, *inbuf, *tok;
> +	long mask, value;
> +	int ret;
> +	u32 ret_payload[PAYLOAD_ARG_CNT];
> +
> +	if (!device || !attr || !buf || !count || reg >= GSS_NUM_REGS)

How can !device, !attr, !buf, or !count ever happen?

Do not check for things that are impossible please.

> +		return -EINVAL;
> +
> +	kern_buff = kzalloc(count, GFP_KERNEL);
> +	if (!kern_buff)
> +		return -ENOMEM;
> +
> +	ret = strlcpy(kern_buff, buf, count);
> +	if (ret < 0) {
> +		count = -EFAULT;
> +		goto err;
> +	}
> +
> +	inbuf = kern_buff;
> +
> +	/* Read the write mask */
> +	tok = strsep(&inbuf, " ");
> +	if (!tok) {
> +		count = -EFAULT;
> +		goto err;
> +	}
> +
> +	ret = kstrtol(tok, 16, &mask);
> +	if (ret) {
> +		count = -EFAULT;
> +		goto err;
> +	}
> +
> +	/* Read the write value */
> +	tok = strsep(&inbuf, " ");
> +	if (!tok) {
> +		count = -EFAULT;
> +		goto err;
> +	}
> +
> +	ret = kstrtol(tok, 16, &value);
> +	if (ret) {
> +		count = -EFAULT;
> +		goto err;
> +	}

sysfs files are "one value per file" which prevents this string parsing
mess.  Please do not do that.

Again, one value per file, not X values.


> +
> +	ret = zynqmp_pm_read_ggs(reg, ret_payload);
> +	if (ret) {
> +		count = -EFAULT;
> +		goto err;
> +	}
> +	ret_payload[1] &= ~mask;
> +	value &= mask;
> +	value |= ret_payload[1];
> +
> +	ret = zynqmp_pm_write_ggs(reg, value);
> +	if (ret)
> +		count = -EFAULT;
> +
> +err:
> +	kfree(kern_buff);
> +
> +	return count;
> +}

> +/**
> + * pggs_store - Store persistent global general storage (pggs) sysfs attribute
> + * @device: Device structure
> + * @attr: Device attribute structure
> + * @buf: User entered shutdown_scope attribute string
> + * @count: Size of buf
> + * @reg: Register number
> + *
> + * Return: count argument if request succeeds, the corresponding
> + * error code otherwise
> + *
> + * Helper function for storing a pggs register value.
> + */
> +static ssize_t pggs_store(struct device *device,
> +			  struct device_attribute *attr,
> +			  const char *buf, size_t count,
> +			  u32 reg)
> +{
> +	char *kern_buff, *inbuf, *tok;
> +	long mask, value;
> +	int ret;
> +	u32 ret_payload[PAYLOAD_ARG_CNT];
> +
> +	if (!device || !attr || !buf || !count || reg >= GSS_NUM_REGS)
> +		return -EINVAL;

Again, clean this up.

> +
> +	kern_buff = kzalloc(count, GFP_KERNEL);
> +	if (!kern_buff)
> +		return -ENOMEM;
> +
> +	ret = strlcpy(kern_buff, buf, count);
> +	if (ret < 0) {
> +		count = -EFAULT;
> +		goto err;
> +	}
> +
> +	inbuf = kern_buff;
> +
> +	/* Read the write mask */
> +	tok = strsep(&inbuf, " ");

No need to parse when there is only one value.

> +	if (!tok) {
> +		count = -EFAULT;
> +		goto err;
> +	}
> +
> +	ret = kstrtol(tok, 16, &mask);
> +	if (ret) {
> +		count = -EFAULT;
> +		goto err;
> +	}
> +
> +	/* Read the write value */
> +	tok = strsep(&inbuf, " ");
> +	if (!tok) {
> +		count = -EFAULT;
> +		goto err;
> +	}
> +
> +	ret = kstrtol(tok, 16, &value);
> +	if (ret) {
> +		count = -EFAULT;
> +		goto err;
> +	}
> +
> +	ret = zynqmp_pm_read_pggs(reg, ret_payload);
> +	if (ret) {
> +		count = -EFAULT;
> +		goto err;
> +	}
> +	ret_payload[1] &= ~mask;
> +	value &= mask;
> +	value |= ret_payload[1];
> +
> +	ret = zynqmp_pm_write_pggs(reg, value);
> +	if (ret)
> +		count = -EFAULT;
> +
> +err:
> +	kfree(kern_buff);
> +
> +	return count;
> +}

> +static struct attribute *zynqmp_ggs_attrs[] = {
> +	&dev_attr_ggs0.attr,
> +	&dev_attr_ggs1.attr,
> +	&dev_attr_ggs2.attr,
> +	&dev_attr_ggs3.attr,
> +	&dev_attr_pggs0.attr,
> +	&dev_attr_pggs1.attr,
> +	&dev_attr_pggs2.attr,
> +	&dev_attr_pggs3.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group ggs_attribute_group = {
> +	.attrs = zynqmp_ggs_attrs,
> +};
> +
> +const struct attribute_group *firmware_attribute_groups[] = {
> +	&ggs_attribute_group,
> +	NULL,
> +};

ATTRIBUTE_GROUPS()?



> +
>  static int zynqmp_firmware_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -910,6 +1226,7 @@ static struct platform_driver zynqmp_firmware_driver = {
>  	.driver = {
>  		.name = "zynqmp_firmware",
>  		.of_match_table = zynqmp_firmware_of_match,
> +		.dev_groups = firmware_attribute_groups,
>  	},
>  	.probe = zynqmp_firmware_probe,
>  	.remove = zynqmp_firmware_remove,
> diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
> index 725dccf..8ccaa39 100644
> --- a/include/linux/firmware/xlnx-zynqmp.h
> +++ b/include/linux/firmware/xlnx-zynqmp.h
> @@ -13,6 +13,8 @@
>  #ifndef __FIRMWARE_ZYNQMP_H__
>  #define __FIRMWARE_ZYNQMP_H__
>  
> +#include <linux/device.h>

Why is this needed here?

> +
>  #define ZYNQMP_PM_VERSION_MAJOR	1
>  #define ZYNQMP_PM_VERSION_MINOR	0
>  
> @@ -42,6 +44,8 @@
>  
>  #define ZYNQMP_PM_MAX_QOS		100U
>  
> +#define GSS_NUM_REGS	(4)
> +
>  /* Node capabilities */
>  #define	ZYNQMP_PM_CAPABILITY_ACCESS	0x1U
>  #define	ZYNQMP_PM_CAPABILITY_CONTEXT	0x2U


You are not adding anything that depends on device.h in this file, so
just include the needed .h file in the .c file that needs it please.

Helps unwind .h include messes.

thanks,

greg k-h
