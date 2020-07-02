Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C21ACC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 12:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94A8F20890
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 12:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593693777;
	bh=5Id979Qu+TbMvFs3bdzAkBCYv828DS3FPkCk09ao5tA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1+jWYf+kTfX+c43JKcOSgLRhXxA7xsCcwMWsqisODUAG0qdkjqlaH7YHtockb4N80
	 CE6pur9G4Lo3PKnMzdKlP+uh9Xb1oUdYqtA0JweURl9b4tLzUKX/e8Q1IA1Q7MWBRK
	 yZNgSWy2ykUPMA7WIM8beI16opKxO4QR1WwXkLHs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729029AbgGBMm4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 08:42:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:48304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728808AbgGBMmz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 08:42:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08AA820885;
        Thu,  2 Jul 2020 12:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593693774;
        bh=5Id979Qu+TbMvFs3bdzAkBCYv828DS3FPkCk09ao5tA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NnEiOIpme/oFl0LG5LH6yJgz74OeVj3OGC7bfMvt0oxzcNXw+2nUkp3q2zvGrrPGq
         UsSwLsIAvHHV+/6JJLtgHnigNwQNASJFS46tZVN8u14zfgkXkyxA9J5vACUSl8en8a
         NkSQAtlPXwcKyiBMDvyEfJKL+vgGQz13nystJm24=
Date:   Thu, 2 Jul 2020 14:42:58 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v2 5/6] devres: provide devm_krealloc()
Message-ID: <20200702124258.GA1882489@kroah.com>
References: <20200629065008.27620-1-brgl@bgdev.pl>
 <20200629065008.27620-6-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200629065008.27620-6-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 08:50:07AM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Implement the managed variant of krealloc(). This function works with
> all memory allocated by devm_kmalloc() (or devres functions using it
> implicitly like devm_kmemdup(), devm_kstrdup() etc.).
> 
> Managed realloc'ed chunks can be manually released with devm_kfree().
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  .../driver-api/driver-model/devres.rst        |  1 +
>  drivers/base/devres.c                         | 50 +++++++++++++++++++
>  include/linux/device.h                        |  2 +
>  3 files changed, 53 insertions(+)
> 
> diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
> index e0b58c392e4f..0a2572c3813c 100644
> --- a/Documentation/driver-api/driver-model/devres.rst
> +++ b/Documentation/driver-api/driver-model/devres.rst
> @@ -352,6 +352,7 @@ MEM
>    devm_kfree()
>    devm_kmalloc()
>    devm_kmalloc_array()
> +  devm_krealloc()
>    devm_kmemdup()
>    devm_kstrdup()
>    devm_kvasprintf()
> diff --git a/drivers/base/devres.c b/drivers/base/devres.c
> index ed615d3b9cf1..4b8870ef6a3f 100644
> --- a/drivers/base/devres.c
> +++ b/drivers/base/devres.c
> @@ -837,6 +837,56 @@ void *devm_kmalloc(struct device *dev, size_t size, gfp_t gfp)
>  }
>  EXPORT_SYMBOL_GPL(devm_kmalloc);
>  
> +void *devm_krealloc(struct device *dev, void *ptr, size_t new_size, gfp_t gfp)
> +{
> +	struct devres *old_dr, *new_dr;
> +	struct list_head old_head;
> +	unsigned long flags;
> +	void *ret = NULL;
> +	size_t tot_size;
> +
> +	if (unlikely(!new_size)) {
> +		devm_kfree(dev, ptr);
> +		return ZERO_SIZE_PTR;
> +	}
> +
> +	if (unlikely(ZERO_OR_NULL_PTR(ptr)))
> +		return devm_kmalloc(dev, new_size, gfp);
> +
> +	if (WARN_ON(is_kernel_rodata((unsigned long)ptr)))
> +		/*
> +		 * We cannot reliably realloc a const string returned by
> +		 * devm_kstrdup_const().
> +		 */
> +		return NULL;
> +
> +	if (!check_dr_size(new_size, &tot_size))
> +		return NULL;
> +
> +	spin_lock_irqsave(&dev->devres_lock, flags);
> +
> +	old_dr = find_dr(dev, devm_kmalloc_release, devm_kmalloc_match, ptr);
> +	if (WARN_ON(!old_dr))
> +		/* Memory chunk not managed or managed by a different device. */
> +		goto out;
> +
> +	old_head = old_dr->node.entry;
> +
> +	new_dr = krealloc(old_dr, tot_size, gfp);
> +	if (!new_dr)
> +		goto out;
> +
> +	if (new_dr != old_dr)
> +		list_replace(&old_head, &new_dr->node.entry);
> +
> +	ret = new_dr->data;
> +
> +out:
> +	spin_unlock_irqrestore(&dev->devres_lock, flags);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(devm_krealloc);

That's a lot of logic that does not seem to match up with the krealloc()
logic in mm/slab_common.c, are you sure we need to do all of that?

Who wants this?

thanks,

greg k-h
