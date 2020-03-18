Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 315E7C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 11:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3B6920771
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 11:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584532447;
	bh=L9X+VrJlSHvHryCDWyCIYjaqgiWMJHd2xRjgHoDrUnc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bTF+dLkZ5vlZ/MQec6OoK90GiSE7wAgmw77t3i3uMXzJD8e+A4ZPL6eptbkT7wdPK
	 kW56ihpPhjSgiyin0jrWPFYReR+/0JbiJmfyj8+NySZYYK7nxyNRDsfbLkMxYV93t8
	 kefnP0MaiQhRza2gt+PvFZVVckz1Oil7D8L5T15s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbgCRLyF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 07:54:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:34486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726738AbgCRLyC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 07:54:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 963F52076D;
        Wed, 18 Mar 2020 11:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584532442;
        bh=L9X+VrJlSHvHryCDWyCIYjaqgiWMJHd2xRjgHoDrUnc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nBWYu8ErKBLAy75lRWkcPa5SdQBMw77hEoJ6xnVoyGil13sOFu3fNx8HI0VmEoGcM
         jC5lALrm+m+tuWKpFlI/lItovNV1RDNE7fjur1S7PxDLw1DMtMEgc50jVM5Ccypmv4
         JP8IzfxDCqHK4kpyVabjr+GmbFUBMwLqWXscbnJo=
Date:   Wed, 18 Mar 2020 12:53:58 +0100
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
Subject: Re: [PATCH v3 24/24] firmware: xilinx: Add sysfs and API to set boot
 health status
Message-ID: <20200318115358.GE2472686@kroah.com>
References: <1583538452-1992-1-git-send-email-jolly.shah@xilinx.com>
 <1583538452-1992-25-git-send-email-jolly.shah@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1583538452-1992-25-git-send-email-jolly.shah@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 06, 2020 at 03:47:32PM -0800, Jolly Shah wrote:
> From: Rajan Vaja <rajan.vaja@xilinx.com>
> 
> Add sysfs interface to set boot health status from user space.
> Add API used by this interface to communicate with firmware.
> 
> If PMUFW is compiled with CHECK_HEALTHY_BOOT, it will check the
> healthy bit on FPD WDT expiration. If healthy bit is set by a user
> application running in Linux, PMUFW will do APU only restart. If
> healthy bit is not set during FPD WDT expiration, PMUFW will do
> system restart.
> 
> Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> Signed-off-by: Jolly Shah <jollys@xilinx.com>
> Signed-off-by: Tejas Patel <tejas.patel@xilinx.com>
> Signed-off-by: Jolly Shah <jolly.shah@xilinx.com>
> ---
>  .../ABI/stable/sysfs-driver-firmware-zynqmp        | 21 ++++++++
>  drivers/firmware/xilinx/zynqmp.c                   | 63 ++++++++++++++++++++++
>  include/linux/firmware/xlnx-zynqmp.h               |  3 ++
>  3 files changed, 87 insertions(+)
> 
> diff --git a/Documentation/ABI/stable/sysfs-driver-firmware-zynqmp b/Documentation/ABI/stable/sysfs-driver-firmware-zynqmp
> index b46ec0c..a37b408 100644
> --- a/Documentation/ABI/stable/sysfs-driver-firmware-zynqmp
> +++ b/Documentation/ABI/stable/sysfs-driver-firmware-zynqmp
> @@ -80,3 +80,24 @@ Description:
>  		# echo "subsystem" > /sys/devices/platform/firmware\:zynqmp-firmware/shutdown_scope
>  
>  Users:		Xilinx
> +
> +What:		/sys/devices/platform/firmware\:zynqmp-firmware/health_status
> +Date:		March 2020
> +KernelVersion:	5.6
> +Contact:	"Jolly Shah" <jollys@xilinx.com>
> +Description:
> +		This sysfs interface allows to set the health status. If PMUFW
> +		is compiled with CHECK_HEALTHY_BOOT, it will check the healthy
> +		bit on FPD WDT expiration. If healthy bit is set by a user
> +		application running in Linux, PMUFW will do APU only restart. If
> +		healthy bit is not set during FPD WDT expiration, PMUFW will do
> +		system restart.
> +
> +		Usage:
> +		Set healthy bit
> +		# echo 1 > /sys/devices/platform/firmware\:zynqmp-firmware/health_status
> +
> +		Unset healthy bit
> +		# echo 0 > /sys/devices/platform/firmware\:zynqmp-firmware/health_status
> +
> +Users:		Xilinx
> diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
> index 9caf1cf..fc3aa4e 100644
> --- a/drivers/firmware/xilinx/zynqmp.c
> +++ b/drivers/firmware/xilinx/zynqmp.c
> @@ -667,6 +667,21 @@ int zynqmp_pm_read_pggs(u32 index, u32 *value)
>  EXPORT_SYMBOL_GPL(zynqmp_pm_read_pggs);
>  
>  /**
> + * zynqmp_pm_set_boot_health_status() - PM API for setting healthy boot status
> + * @value	Status value to be written
> + *
> + * This function sets healthy bit value to indicate boot health status
> + * to firmware.
> + *
> + * @return      Returns status, either success or error+reason
> + */
> +int zynqmp_pm_set_boot_health_status(u32 value)
> +{
> +	return zynqmp_pm_invoke_fn(PM_IOCTL, 0, IOCTL_SET_BOOT_HEALTH_STATUS,
> +				   value, 0, NULL);
> +}
> +
> +/**
>   * zynqmp_pm_reset_assert - Request setting of reset (1 - assert, 0 - release)
>   * @reset:		Reset to be configured
>   * @assert_flag:	Flag stating should reset be asserted (1) or
> @@ -995,6 +1010,53 @@ static const struct attribute_group shutdown_scope_attribute_group = {
>  };
>  
>  /**
> + * health_status_store - Store health_status sysfs attribute
> + * @device:	Device structure
> + * @attr:	Device attribute structure
> + * @buf:	User entered health_status attribute string
> + * @count:	Buffer size
> + *
> + * User-space interface for setting the boot health status.
> + * Usage: echo <value> > /sys/devices/platform/firmware\:zynqmp-firmware/health_status
> + *
> + * Value:
> + *	1 - Set healthy bit to 1
> + *	0 - Unset healthy bit
> + *
> + * Return:	count argument if request succeeds, the corresponding error
> + *		code otherwise
> + */
> +static ssize_t health_status_store(struct device *device,
> +				   struct device_attribute *attr,
> +				   const char *buf, size_t count)
> +{
> +	int ret;
> +	unsigned int value;
> +
> +	ret = kstrtouint(buf, 10, &value);
> +	if (ret)
> +		return ret;
> +
> +	ret = zynqmp_pm_set_boot_health_status(value);
> +	if (ret) {
> +		pr_err("unable to set healthy bit value to %u\n", value);

You have a valid struct device right there, use it!

dev_err() please...

thanks,

greg k-h
