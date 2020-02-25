Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E12B3C35DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 12:51:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDEDC21556
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 12:51:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729843AbgBYMvq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 07:51:46 -0500
Received: from mga02.intel.com ([134.134.136.20]:47567 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728913AbgBYMvq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 07:51:46 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Feb 2020 04:51:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,484,1574150400"; 
   d="scan'208";a="350143106"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 25 Feb 2020 04:51:42 -0800
Received: by lahna (sSMTP sendmail emulation); Tue, 25 Feb 2020 14:51:41 +0200
Date:   Tue, 25 Feb 2020 14:51:41 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v1 1/3] nvmem: Add support for write-only instances
Message-ID: <20200225125141.GA2667@lahna.fi.intel.com>
References: <PSXP216MB043899D4B8F693E1E5C3ECCE80EC0@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
 <PSXP216MB043820B6E11AE4E78374C7F980EC0@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PSXP216MB043820B6E11AE4E78374C7F980EC0@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2020 at 05:42:33PM +0000, Nicholas Johnson wrote:
> Mika Westerberg requires write-only nvmem for the Thunderbolt driver.
> Refer to 03cd45d2e219 ("thunderbolt: Prevent crash if non-active NVMem
> file is read"). Hence, there is at least one real-world use for
> write-only nvmem instances.

Well, I don't require anything ;-) It is the thunderbolt driver that has
one nvmem device that is write-only and it may take advantage of this.

> Add support for write-only nvmem instances by changing the nvmem attrs
> to 0222 if the .reg_read callback is not populated.
> 
> Add a WARN_ON in case a driver populates neither .reg_read nor
> .reg_write because this behaviour should clearly never occur.
> 
> Signed-off-by: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
> ---
>  drivers/nvmem/nvmem-sysfs.c | 77 +++++++++++++++++++++++++++++++++----
>  1 file changed, 70 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/nvmem/nvmem-sysfs.c b/drivers/nvmem/nvmem-sysfs.c
> index 9e0c429cd..be3b94f0b 100644
> --- a/drivers/nvmem/nvmem-sysfs.c
> +++ b/drivers/nvmem/nvmem-sysfs.c
> @@ -147,6 +147,30 @@ static const struct attribute_group *nvmem_ro_dev_groups[] = {
>  	NULL,
>  };
>  
> +/* write only permission */
> +static struct bin_attribute bin_attr_wo_nvmem = {
> +	.attr	= {
> +		.name	= "nvmem",
> +		.mode	= 0222,

I would say no sysfs attribute should ever be writable by the world.

Actually I think maybe we make this one only writeable by root, in other
words it would always require ->root_only to be set.

> +	},
> +	.write	= bin_attr_nvmem_write,
> +};
> +
> +static struct bin_attribute *nvmem_bin_wo_attributes[] = {
> +	&bin_attr_wo_nvmem,
> +	NULL,
> +};
> +
> +static const struct attribute_group nvmem_bin_wo_group = {
> +	.bin_attrs	= nvmem_bin_wo_attributes,
> +	.attrs		= nvmem_attrs,
> +};
> +
> +static const struct attribute_group *nvmem_wo_dev_groups[] = {
> +	&nvmem_bin_wo_group,
> +	NULL,
> +};
> +
>  /* default read/write permissions, root only */
>  static struct bin_attribute bin_attr_rw_root_nvmem = {
>  	.attr	= {
> @@ -196,16 +220,50 @@ static const struct attribute_group *nvmem_ro_root_dev_groups[] = {
>  	NULL,
>  };
>  
> +/* write only permission, root only */
> +static struct bin_attribute bin_attr_wo_root_nvmem = {
> +	.attr	= {
> +		.name	= "nvmem",
> +		.mode	= 0200,
> +	},
> +	.write	= bin_attr_nvmem_write,
> +};
> +
> +static struct bin_attribute *nvmem_bin_wo_root_attributes[] = {
> +	&bin_attr_wo_root_nvmem,
> +	NULL,
> +};
> +
> +static const struct attribute_group nvmem_bin_wo_root_group = {
> +	.bin_attrs	= nvmem_bin_wo_root_attributes,
> +	.attrs		= nvmem_attrs,
> +};
> +
> +static const struct attribute_group *nvmem_wo_root_dev_groups[] = {
> +	&nvmem_bin_wo_root_group,
> +	NULL,
> +};
> +
>  const struct attribute_group **nvmem_sysfs_get_groups(
>  					struct nvmem_device *nvmem,
>  					const struct nvmem_config *config)
>  {
> -	if (config->root_only)
> -		return nvmem->read_only ?
> -			nvmem_ro_root_dev_groups :
> -			nvmem_rw_root_dev_groups;
> -
> -	return nvmem->read_only ? nvmem_ro_dev_groups : nvmem_rw_dev_groups;
> +	/*
> +	 * If neither reg_read nor reg_write are provided, we cannot use this
> +	 * nvmem entry, as any operation will cause kernel mode NULL reference.
> +	 */
> +	WARN_ON(!nvmem->reg_read && !nvmem->reg_write);

This should also be documented in kernel-doc of struct nvmem_config.

> +
> +	if (nvmem->reg_read && nvmem->reg_write)
> +		return config->root_only ?
> +			nvmem_rw_root_dev_groups : nvmem_rw_dev_groups;
> +
> +	if (nvmem->reg_read && !nvmem->reg_write)
> +		return config->root_only ?
> +			nvmem_ro_root_dev_groups : nvmem_ro_dev_groups;
> +
> +	return config->root_only ?
> +		nvmem_wo_root_dev_groups : nvmem_wo_dev_groups;
>  }
>  
>  /*
> @@ -224,11 +282,16 @@ int nvmem_sysfs_setup_compat(struct nvmem_device *nvmem,
>  	if (!config->base_dev)
>  		return -EINVAL;
>  
> -	if (nvmem->read_only) {
> +	if (nvmem->reg_read && !nvmem->reg_write) {
>  		if (config->root_only)
>  			nvmem->eeprom = bin_attr_ro_root_nvmem;
>  		else
>  			nvmem->eeprom = bin_attr_ro_nvmem;
> +	} else if (!nvmem->reg_read && nvmem->reg_write) {
> +		if (config->root_only)
> +			nvmem->eeprom = bin_attr_wo_root_nvmem;
> +		else
> +			nvmem->eeprom = bin_attr_wo_nvmem;
>  	} else {
>  		if (config->root_only)
>  			nvmem->eeprom = bin_attr_rw_root_nvmem;
> -- 
> 2.25.1
