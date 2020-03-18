Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC09EC5ACD8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 11:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7908820773
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 11:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584532402;
	bh=m9FmbwR3S9CLC9zLKu9zuaEdpr6gT37kN2ogRUDA0VI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UgZ0FirtDco4xMKx2CNYsHKdu+LrtVuSRSyT3ok9+Xh58uQiFYshK0fxSqIwLHC8G
	 lrn55UZoY/r3AYeQvGPxDm5zoVA4lHGbHQWs9qPlXKPDMy4DuCm734OfRVWYbusmnt
	 yy0aUmCIDDGidD/v6dyCF6AniBv8oGpKrsl6RXS4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbgCRLxV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 07:53:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:33836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726473AbgCRLxV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 07:53:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43BAC2076D;
        Wed, 18 Mar 2020 11:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584532399;
        bh=m9FmbwR3S9CLC9zLKu9zuaEdpr6gT37kN2ogRUDA0VI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HQcKfhLwnK+HV659sYu/fUTj2VTa0miJBbFZrmAzGEIQVIaHNUlRakPsGiufzom7Z
         PdoL34HsBA5gF5fPzIMLBoyJiI/bgzOeFiRyT7XsSimp9Efcy6KS7by7eyU9tfAwMf
         VTPlix9VHdwO9q8plCNjWhTohMZl64sXq5vUtwWs=
Date:   Wed, 18 Mar 2020 12:53:17 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jolly Shah <jolly.shah@xilinx.com>
Cc:     ard.biesheuvel@linaro.org, mingo@kernel.org,
        matt@codeblueprint.co.uk, sudeep.holla@arm.com,
        hkallweit1@gmail.com, keescook@chromium.org,
        dmitry.torokhov@gmail.com, michal.simek@xilinx.com,
        rajanv@xilinx.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rajan Vaja <rajan.vaja@xilinx.com>,
        Stefan Krsmanovic <stefan.krsmanovic@aggios.com>,
        Jolly Shah <jollys@xilinx.com>,
        Tejas Patel <tejas.patel@xilinx.com>
Subject: Re: [PATCH v3 23/24] firmware: xilinx: Add sysfs to set shutdown
 scope
Message-ID: <20200318115317.GD2472686@kroah.com>
References: <1583538452-1992-1-git-send-email-jolly.shah@xilinx.com>
 <1583538452-1992-24-git-send-email-jolly.shah@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1583538452-1992-24-git-send-email-jolly.shah@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 06, 2020 at 03:47:31PM -0800, Jolly Shah wrote:
> From: Rajan Vaja <rajan.vaja@xilinx.com>
> 
> The Linux shutdown functionality implemented via PSCI system_off does
> not include an option to set a scope, i.e. which parts of the system to
> shut down.
> 
> This patch creates sysfs that allows to set the shutdown scope for the
> next shutdown request. When the next shutdown is performed, the platform
> specific portion of PSCI-system_off can use the chosen shutdown scope.
> 
> Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
> Signed-off-by: Stefan Krsmanovic <stefan.krsmanovic@aggios.com>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> Signed-off-by: Jolly Shah <jollys@xilinx.com>
> Signed-off-by: Tejas Patel <tejas.patel@xilinx.com>
> Signed-off-by: Jolly Shah <jolly.shah@xilinx.com>
> ---
>  .../ABI/stable/sysfs-driver-firmware-zynqmp        |  32 +++++
>  drivers/firmware/xilinx/zynqmp.c                   | 150 ++++++++++++++++++++-
>  include/linux/firmware/xlnx-zynqmp.h               |  12 ++
>  3 files changed, 193 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/stable/sysfs-driver-firmware-zynqmp b/Documentation/ABI/stable/sysfs-driver-firmware-zynqmp
> index 7fd6e70..b46ec0c 100644
> --- a/Documentation/ABI/stable/sysfs-driver-firmware-zynqmp
> +++ b/Documentation/ABI/stable/sysfs-driver-firmware-zynqmp
> @@ -48,3 +48,35 @@ Description:
>  		# echo 0xFFFFFFFF 0x1234ABCD > /sys/devices/platform/firmware\:zynqmp-firmware/pggs0
>  
>  Users:		Xilinx
> +
> +What:		/sys/devices/platform/firmware\:zynqmp-firmware/shutdown_scope
> +Date:		March 2020
> +KernelVersion:	5.6
> +Contact:	"Jolly Shah" <jollys@xilinx.com>
> +Description:
> +		This sysfs interface allows to set the shutdown scope for the
> +		next shutdown request. When the next shutdown is performed, the
> +		platform specific portion of PSCI-system_off can use the chosen
> +		shutdown scope.
> +
> +		Following are available shutdown scopes(subtypes):
> +
> +		subsystem:	Only the APU along with all of its peripherals
> +				not used by other processing units will be
> +				shut down. This may result in the FPD power
> +				domain being shut down provided that no other
> +				processing unit uses FPD peripherals or DRAM.
> +		ps_only:	The complete PS will be shut down, including the
> +				RPU, PMU, etc.  Only the PL domain (FPGA)
> +				remains untouched.
> +		system:		The complete system/device is shut down.
> +
> +		Usage:
> +		# cat /sys/devices/platform/firmware\:zynqmp-firmware/shutdown_scope
> +		# echo <scope> > /sys/devices/platform/firmware\:zynqmp-firmware/shutdown_scope
> +
> +		Example:
> +		# cat /sys/devices/platform/firmware\:zynqmp-firmware/shutdown_scope
> +		# echo "subsystem" > /sys/devices/platform/firmware\:zynqmp-firmware/shutdown_scope
> +
> +Users:		Xilinx
> diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
> index d3f637b..9caf1cf 100644
> --- a/drivers/firmware/xilinx/zynqmp.c
> +++ b/drivers/firmware/xilinx/zynqmp.c
> @@ -847,6 +847,154 @@ int zynqmp_pm_system_shutdown(const u32 type, const u32 subtype)
>  }
>  
>  /**
> + * struct zynqmp_pm_shutdown_scope - Struct for shutdown scope
> + * @subtype:	Shutdown subtype
> + * @name:	Matching string for scope argument
> + *
> + * This struct encapsulates mapping between shutdown scope ID and string.
> + */
> +struct zynqmp_pm_shutdown_scope {
> +	const enum zynqmp_pm_shutdown_subtype subtype;
> +	const char *name;
> +};
> +
> +static struct zynqmp_pm_shutdown_scope shutdown_scopes[] = {
> +	[ZYNQMP_PM_SHUTDOWN_SUBTYPE_SUBSYSTEM] = {
> +		.subtype = ZYNQMP_PM_SHUTDOWN_SUBTYPE_SUBSYSTEM,
> +		.name = "subsystem",
> +	},
> +	[ZYNQMP_PM_SHUTDOWN_SUBTYPE_PS_ONLY] = {
> +		.subtype = ZYNQMP_PM_SHUTDOWN_SUBTYPE_PS_ONLY,
> +		.name = "ps_only",
> +	},
> +	[ZYNQMP_PM_SHUTDOWN_SUBTYPE_SYSTEM] = {
> +		.subtype = ZYNQMP_PM_SHUTDOWN_SUBTYPE_SYSTEM,
> +		.name = "system",
> +	},
> +};
> +
> +static struct zynqmp_pm_shutdown_scope *selected_scope =
> +		&shutdown_scopes[ZYNQMP_PM_SHUTDOWN_SUBTYPE_SYSTEM];
> +
> +/**
> + * zynqmp_pm_is_shutdown_scope_valid - Check if shutdown scope string is valid
> + * @scope_string:	Shutdown scope string
> + *
> + * Return:		Return pointer to matching shutdown scope struct from
> + *			array of available options in system if string is valid,
> + *			otherwise returns NULL.
> + */
> +static struct zynqmp_pm_shutdown_scope*
> +		zynqmp_pm_is_shutdown_scope_valid(const char *scope_string)
> +{
> +	int count;
> +
> +	for (count = 0; count < ARRAY_SIZE(shutdown_scopes); count++)
> +		if (sysfs_streq(scope_string, shutdown_scopes[count].name))
> +			return &shutdown_scopes[count];
> +
> +	return NULL;
> +}
> +
> +/**
> + * shutdown_scope_show - Show shutdown_scope sysfs attribute
> + * @device:	Device structure
> + * @attr:	Device attribute structure
> + * @buf:	Requested available shutdown_scope attributes string
> + *
> + * User-space interface for viewing the available scope options for system
> + * shutdown. Scope option for next shutdown call is marked with [].
> + *
> + * Usage: cat /sys/devices/platform/firmware\:zynqmp-firmware/shutdown_scope
> + *
> + * Return:	Number of bytes printed into the buffer.
> + */
> +static ssize_t shutdown_scope_show(struct device *device,
> +				   struct device_attribute *attr,
> +				   char *buf)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(shutdown_scopes); i++) {
> +		if (&shutdown_scopes[i] == selected_scope) {
> +			strcat(buf, "[");
> +			strcat(buf, shutdown_scopes[i].name);
> +			strcat(buf, "]");
> +		} else {
> +			strcat(buf, shutdown_scopes[i].name);
> +		}
> +		strcat(buf, " ");
> +	}
> +	strcat(buf, "\n");
> +
> +	return strlen(buf);
> +}
> +
> +/**
> + * shutdown_scope_store - Store shutdown_scope sysfs attribute
> + * @device:	Device structure
> + * @attr:	Device attribute structure
> + * @buf:	User entered shutdown_scope attribute string
> + * @count:	Buffer size
> + *
> + * User-space interface for setting the scope for the next system shutdown.
> + * Usage: echo <scope> > /sys/devices/platform/firmware\:zynqmp-firmware/shutdown_scope
> + *
> + * The Linux shutdown functionality implemented via PSCI system_off does not
> + * include an option to set a scope, i.e. which parts of the system to shut
> + * down.
> + *
> + * This API function allows to set the shutdown scope for the next shutdown
> + * request by passing it to the ATF running in EL3. When the next shutdown
> + * is performed, the platform specific portion of PSCI-system_off can use
> + * the chosen shutdown scope.
> + *
> + * subsystem:	Only the APU along with all of its peripherals not used by other
> + *		processing units will be shut down. This may result in the FPD
> + *		power domain being shut down provided that no other processing
> + *		unit uses FPD peripherals or DRAM.
> + * ps_only:	The complete PS will be shut down, including the RPU, PMU, etc.
> + *		Only the PL domain (FPGA) remains untouched.
> + * system:	The complete system/device is shut down.
> + *
> + * Return:	count argument if request succeeds, the corresponding error
> + *		code otherwise
> + */
> +static ssize_t shutdown_scope_store(struct device *device,
> +				    struct device_attribute *attr,
> +				    const char *buf, size_t count)
> +{
> +	int ret;
> +	struct zynqmp_pm_shutdown_scope *scope;
> +
> +	scope = zynqmp_pm_is_shutdown_scope_valid(buf);
> +	if (!scope)
> +		return -EINVAL;
> +
> +	ret = zynqmp_pm_system_shutdown(ZYNQMP_PM_SHUTDOWN_TYPE_SETSCOPE_ONLY,
> +					scope->subtype);
> +	if (ret) {
> +		pr_err("unable to set shutdown scope %s\n", buf);
> +		return ret;
> +	}
> +
> +	selected_scope = scope;
> +
> +	return count;
> +}
> +
> +static DEVICE_ATTR_RW(shutdown_scope);
> +
> +static struct attribute *zynqmp_shutdown_scope_attrs[] = {
> +	&dev_attr_shutdown_scope.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group shutdown_scope_attribute_group = {
> +	.attrs = zynqmp_shutdown_scope_attrs,
> +};

ATTRIBUTE_GROUPS()?

thanks,

greg k-h
