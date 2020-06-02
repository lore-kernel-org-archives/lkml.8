Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7493DC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 04:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 472632074B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 04:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591071827;
	bh=KForfwzUUC3Tk8fGSUSDwVHsxPKPlXtsHIFrysGM4iY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=K7/9fhuBd+9qEnK6KsJZURjrNn3H+ylI95pbzcw5QRlcyqKHzH60NqbGlIrBnsLsH
	 ZQPg3mDhNR2a1lCMXCKDxxPTmwytLzeBIoxbqZfzwifM3cYPX8XGT8490uDgqLJzJS
	 g6Fei9KWLuGDiJFexazEXfUFXf8C1hEu3oxFdk6g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbgFBEXq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 00:23:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:56474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725841AbgFBEXq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 00:23:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99144206C3;
        Tue,  2 Jun 2020 04:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591071825;
        bh=KForfwzUUC3Tk8fGSUSDwVHsxPKPlXtsHIFrysGM4iY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V45ZYtoL70LH0+jjtU6K2Pm6h5EN5dcw3LAqGkCFEUvGLepwp/RzbDsv1tm9nbE8X
         IKfw5CNMxoDntLxKInDAvmDaDJ9slDOOgr5WQi4LT/HYwuAb815pAredk+uHwsM3gx
         Wz/hBz4BIW9vvksL95NAPm/tvL3WM12JokdvE9Lo=
Date:   Tue, 2 Jun 2020 06:23:40 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Barry Song <song.bao.hua@hisilicon.com>
Cc:     rafael@kernel.org, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, Prime Zeng <prime.zeng@hisilicon.com>,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] driver core: platform: expose numa_node to users in sysfs
Message-ID: <20200602042340.GA2130884@kroah.com>
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

Platform devices are NUMA?  That's crazy, and feels like a total abuse
of platform devices and drivers that really should belong on a "real"
bus.

What drivers in the kernel today have this issue?

thanks,

greg k-h
