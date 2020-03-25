Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3B49C1975A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 10:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A3CD20714
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 10:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585131698;
	bh=m5Pq0eBhZeIfxtyF0xHTg4nDRhDM4RXP4sUZd+gwGv4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XCpzX8YbhUdUlcKRVxpWnWp4U6akT0f/1MDOj1c/+PF586gSV1tX62P+DIC77VTet
	 y/q8HgNeMYWy6ZRJ8uZJYRjZfH0WIkgbNs7RGE3M1Oee5tu3WHup7Xi+l37S7P7Kd9
	 Xh8OPA7FqZu2DA65BsO6EA0sKDlLJX2UGzb7gDRk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727634AbgCYKVh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 06:21:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:40794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726239AbgCYKVh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 06:21:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F8AC2078A;
        Wed, 25 Mar 2020 10:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585131696;
        bh=m5Pq0eBhZeIfxtyF0xHTg4nDRhDM4RXP4sUZd+gwGv4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zXwS+niLdj3whOFFg3NQmSspddaYWtcDSR6ZsApYkYR7fN1qv+YORhRwNzAeNKNBF
         OYlcLXk06crs3ABWkoc6M0FH5gW+eikAoSxafD22RKhez3CtTKt7YZHYMD88WxQ5cE
         TRr9x1K6jIRsPMUrSPejQR5yAAQBOzztOs5gAObo=
Date:   Wed, 25 Mar 2020 11:21:34 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        nicholas.johnson-opensource@outlook.com.au
Subject: Re: [PATCH v2 2/2] nvmem: core: use is_bin_visible for permissions
Message-ID: <20200325102134.GA3084470@kroah.com>
References: <20200325100138.17854-1-srinivas.kandagatla@linaro.org>
 <20200325100138.17854-3-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200325100138.17854-3-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 25, 2020 at 10:01:38AM +0000, Srinivas Kandagatla wrote:
> By using is_bin_visible callback to set permissions will remove a
> large list of attribute groups. These group permissions can be
> dynamically derived in the callback.
> 
> Also add checks for read/write callbacks and set permissions accordingly.
> 
> Suggested-by: Greg KH <gregkh@linuxfoundation.org>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
> Changes since v1:
> 	- Updated permissions setup logic as suggested by Greg
> 	- Added checks for callbacks.
> 
>  drivers/nvmem/nvmem-sysfs.c | 85 +++++++++++++------------------------
>  1 file changed, 29 insertions(+), 56 deletions(-)
> 
> diff --git a/drivers/nvmem/nvmem-sysfs.c b/drivers/nvmem/nvmem-sysfs.c
> index 8759c4470012..68ad8aef79d4 100644
> --- a/drivers/nvmem/nvmem-sysfs.c
> +++ b/drivers/nvmem/nvmem-sysfs.c
> @@ -104,6 +104,28 @@ static ssize_t bin_attr_nvmem_write(struct file *filp, struct kobject *kobj,
>  	return count;
>  }
>  
> +static umode_t nvmem_bin_attr_is_visible(struct kobject *kobj,
> +					 struct bin_attribute *attr, int i)
> +{
> +	struct device *dev = container_of(kobj, struct device, kobj);
> +	struct nvmem_device *nvmem = to_nvmem_device(dev);
> +	umode_t mode = 0400;
> +
> +	if (!nvmem->root_only)
> +		mode |= 0044;
> +
> +	if (!nvmem->read_only)
> +		mode |= 0200;
> +
> +	if (!nvmem->reg_write)
> +		mode &= ~0200;
> +
> +	if (!nvmem->reg_read)
> +		mode &= ~0444;
> +
> +	return mode;
> +}
> +
>  /* default read/write permissions */
>  static struct bin_attribute bin_attr_rw_nvmem = {
>  	.attr	= {
> @@ -114,18 +136,19 @@ static struct bin_attribute bin_attr_rw_nvmem = {
>  	.write	= bin_attr_nvmem_write,
>  };
>  
> -static struct bin_attribute *nvmem_bin_rw_attributes[] = {
> +static struct bin_attribute *nvmem_bin_attributes[] = {
>  	&bin_attr_rw_nvmem,
>  	NULL,
>  };
>  
> -static const struct attribute_group nvmem_bin_rw_group = {
> -	.bin_attrs	= nvmem_bin_rw_attributes,
> +static const struct attribute_group nvmem_bin_group = {
> +	.bin_attrs	= nvmem_bin_attributes,
>  	.attrs		= nvmem_attrs,
> +	.is_bin_visible = nvmem_bin_attr_is_visible,
>  };
>  
> -static const struct attribute_group *nvmem_rw_dev_groups[] = {
> -	&nvmem_bin_rw_group,
> +static const struct attribute_group *nvmem_dev_groups[] = {
> +	&nvmem_bin_group,
>  	NULL,
>  };
>  
> @@ -138,21 +161,6 @@ static struct bin_attribute bin_attr_ro_nvmem = {
>  	.read	= bin_attr_nvmem_read,
>  };
>  
> -static struct bin_attribute *nvmem_bin_ro_attributes[] = {
> -	&bin_attr_ro_nvmem,
> -	NULL,
> -};
> -
> -static const struct attribute_group nvmem_bin_ro_group = {
> -	.bin_attrs	= nvmem_bin_ro_attributes,
> -	.attrs		= nvmem_attrs,
> -};
> -
> -static const struct attribute_group *nvmem_ro_dev_groups[] = {
> -	&nvmem_bin_ro_group,
> -	NULL,
> -};
> -
>  /* default read/write permissions, root only */
>  static struct bin_attribute bin_attr_rw_root_nvmem = {
>  	.attr	= {
> @@ -163,21 +171,6 @@ static struct bin_attribute bin_attr_rw_root_nvmem = {
>  	.write	= bin_attr_nvmem_write,
>  };
>  
> -static struct bin_attribute *nvmem_bin_rw_root_attributes[] = {
> -	&bin_attr_rw_root_nvmem,
> -	NULL,
> -};
> -
> -static const struct attribute_group nvmem_bin_rw_root_group = {
> -	.bin_attrs	= nvmem_bin_rw_root_attributes,
> -	.attrs		= nvmem_attrs,
> -};
> -
> -static const struct attribute_group *nvmem_rw_root_dev_groups[] = {
> -	&nvmem_bin_rw_root_group,
> -	NULL,
> -};
> -
>  /* read only permission, root only */
>  static struct bin_attribute bin_attr_ro_root_nvmem = {
>  	.attr	= {
> @@ -187,31 +180,11 @@ static struct bin_attribute bin_attr_ro_root_nvmem = {
>  	.read	= bin_attr_nvmem_read,
>  };
>  
> -static struct bin_attribute *nvmem_bin_ro_root_attributes[] = {
> -	&bin_attr_ro_root_nvmem,
> -	NULL,
> -};
> -
> -static const struct attribute_group nvmem_bin_ro_root_group = {
> -	.bin_attrs	= nvmem_bin_ro_root_attributes,
> -	.attrs		= nvmem_attrs,
> -};
> -
> -static const struct attribute_group *nvmem_ro_root_dev_groups[] = {
> -	&nvmem_bin_ro_root_group,
> -	NULL,
> -};
> -
>  const struct attribute_group **nvmem_sysfs_get_groups(
>  					struct nvmem_device *nvmem,
>  					const struct nvmem_config *config)

You no longer need any parameters for this function, right?

Also, you really don't even need the function, just point to the
variable instead.

thanks,

greg k-h
