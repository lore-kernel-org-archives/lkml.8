Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4243C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 04:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83ECA20738
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 04:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591071850;
	bh=sgwt4wu4ovM7Au/m6y7eibwKEZOw6hctJEhJzRNy5qA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IkPqKt57Av3bWFkRMWCKh2BFkjoB3fCGqXjH7YGHsVXtnlLc3Y9Zx3kiG0EhpJG+z
	 v6N52afQETdpx0T/0erTSoqF+9dwmV3uWW8QpGe+sgNPzersWSeZGPxONO/T1uCEDS
	 YJlIB8uWeeMIgQymgz3GYdpqrLehdqZ9x1bkF5ss=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbgFBEYK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 00:24:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:56778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725781AbgFBEYJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 00:24:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51BA2206C3;
        Tue,  2 Jun 2020 04:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591071849;
        bh=sgwt4wu4ovM7Au/m6y7eibwKEZOw6hctJEhJzRNy5qA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2mCrwM+OCoJJbKpsOl7IzXvXzqSIQvvzFDvcgtE/h+tT1HxckMVCL8VlHx2bSKnFx
         qsZrZBk4RHyOzcOhWU8mvrbQCoOr6y7DjO19yKjTjIUYtAoedpIqKfRCx0SoSyLXoO
         7lFEOomn5NuR+TYks3LHPF5hQVc9Iq/BWxQkloLg=
Date:   Tue, 2 Jun 2020 06:24:06 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Barry Song <song.bao.hua@hisilicon.com>
Cc:     rafael@kernel.org, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, Prime Zeng <prime.zeng@hisilicon.com>,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] driver core: platform: expose numa_node to users in sysfs
Message-ID: <20200602042406.GB2130884@kroah.com>
References: <20200602030139.73012-1-song.bao.hua@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200602030139.73012-1-song.bao.hua@hisilicon.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 02, 2020 at 03:01:39PM +1200, Barry Song wrote:
> For some platform devices like iommu, particually ARM smmu, users may
> care about the numa locality. for example, if threads and drivers run
> near iommu, they may get much better performance on dma_unmap_sg.
> For other platform devices, users may still want to know the hardware
> topology.
> 
> Cc: Prime Zeng <prime.zeng@hisilicon.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
> ---
>  drivers/base/platform.c | 26 +++++++++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index b27d0f6c18c9..7794b9a38d82 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -1062,13 +1062,37 @@ static ssize_t driver_override_show(struct device *dev,
>  }
>  static DEVICE_ATTR_RW(driver_override);
>  
> +static ssize_t numa_node_show(struct device *dev,
> +		struct device_attribute *attr, char *buf)
> +{
> +	return sprintf(buf, "%d\n", dev_to_node(dev));
> +}
> +static DEVICE_ATTR_RO(numa_node);
> +
> +static umode_t platform_dev_attrs_visible(struct kobject *kobj, struct attribute *a,
> +		int n)
> +{
> +	struct device *dev = container_of(kobj, typeof(*dev), kobj);
> +
> +	if (a == &dev_attr_numa_node.attr &&
> +			dev_to_node(dev) == NUMA_NO_NODE)
> +		return 0;
> +
> +	return a->mode;
> +}
>  
>  static struct attribute *platform_dev_attrs[] = {
>  	&dev_attr_modalias.attr,
> +	&dev_attr_numa_node.attr,
>  	&dev_attr_driver_override.attr,
>  	NULL,
>  };
> -ATTRIBUTE_GROUPS(platform_dev);
> +
> +static struct attribute_group platform_dev_group = {
> +	.attrs = platform_dev_attrs,
> +	.is_visible = platform_dev_attrs_visible,
> +};
> +__ATTRIBUTE_GROUPS(platform_dev);
>  
>  static int platform_uevent(struct device *dev, struct kobj_uevent_env *env)
>  {

Also you forgot a new entry in Documentation/ABI/ :(

