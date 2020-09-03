Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21571C433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 15:00:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D76F520658
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 14:59:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iZL9m4OR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729089AbgICO75 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 10:59:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31354 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729095AbgICOHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 10:07:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599142010;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H1eukUSRkTy9LUMpHN/gQq0Bjq2cu9TQ8sjGHwxC4No=;
        b=iZL9m4ORkpwpPlYSSkrGMpDwbuJYs9dN4OmcIc93bVPqDtv6I9Qi960ldkXaqIhOoLHrQX
        mn7+R3VP0X3ImeZ2L/9SjaNM168WC8na2pwdt06coqQuPGYYFgD7GpofLHLXt2fh7jERX6
        6ESVuwSikPdx9/+jE9PV3/zphzXHXEg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-579-On4Eck8jNLO613Pxjvqa2A-1; Thu, 03 Sep 2020 10:06:46 -0400
X-MC-Unique: On4Eck8jNLO613Pxjvqa2A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 316C4CE225;
        Thu,  3 Sep 2020 14:06:44 +0000 (UTC)
Received: from [10.36.112.51] (ovpn-112-51.ams2.redhat.com [10.36.112.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EBC281055833;
        Thu,  3 Sep 2020 14:06:38 +0000 (UTC)
Subject: Re: [PATCH v4 01/10] vfio/fsl-mc: Add VFIO framework skeleton for
 fsl-mc devices
To:     Diana Craciun <diana.craciun@oss.nxp.com>,
        alex.williamson@redhat.com, kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, bharatb.linux@gmail.com,
        laurentiu.tudor@nxp.com, Bharat Bhushan <Bharat.Bhushan@nxp.com>
References: <20200826093315.5279-1-diana.craciun@oss.nxp.com>
 <20200826093315.5279-2-diana.craciun@oss.nxp.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <4636da7d-0c97-4c14-cfac-bdb4c9e6cd83@redhat.com>
Date:   Thu, 3 Sep 2020 16:06:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200826093315.5279-2-diana.craciun@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Diana,

On 8/26/20 11:33 AM, Diana Craciun wrote:
> From: Bharat Bhushan <Bharat.Bhushan@nxp.com>
> 
> DPAA2 (Data Path Acceleration Architecture) consists in
> mechanisms for processing Ethernet packets, queue management,
> accelerators, etc.
> 
> The Management Complex (mc) is a hardware entity that manages the DPAA2
> hardware resources. It provides an object-based abstraction for software
> drivers to use the DPAA2 hardware. The MC mediates operations such as
> create, discover, destroy of DPAA2 objects.
> The MC provides memory-mapped I/O command interfaces (MC portals) which
> DPAA2 software drivers use to operate on DPAA2 objects.
> 
> A DPRC is a container object that holds other types of DPAA2 objects.
> Each object in the DPRC is a Linux device and bound to a driver.
> The MC-bus driver is a platform driver (different from PCI or platform
> bus). The DPRC driver does runtime management of a bus instance. It
> performs the initial scan of the DPRC and handles changes in the DPRC
> configuration (adding/removing objects).
> 
> All objects inside a container share the same hardware isolation
> context, meaning that only an entire DPRC can be assigned to
> a virtual machine.
> When a container is assigned to a virtual machine, all the objects
> within that container are assigned to that virtual machine.
> The DPRC container assigned to the virtual machine is not allowed
> to change contents (add/remove objects) by the guest. The restriction
> is set by the host and enforced by the mc hardware.
> 
> The DPAA2 objects can be directly assigned to the guest. However
> the MC portals (the memory mapped command interface to the MC) need
> to be emulated because there are commands that configure the
> interrupts and the isolation IDs which are virtual in the guest.
> 
> Example:
> echo vfio-fsl-mc > /sys/bus/fsl-mc/devices/dprc.2/driver_override
> echo dprc.2 > /sys/bus/fsl-mc/drivers/vfio-fsl-mc/bind
> 
> The dprc.2 is bound to the VFIO driver and all the objects within
> dprc.2 are going to be bound to the VFIO driver.
> 
> This patch adds the infrastructure for VFIO support for fsl-mc
> devices. Subsequent patches will add support for binding and secure
> assigning these devices using VFIO.
> 
> More details about the DPAA2 objects can be found here:
> Documentation/networking/device_drivers/freescale/dpaa2/overview.rst
> 
> Signed-off-by: Bharat Bhushan <Bharat.Bhushan@nxp.com>
> Signed-off-by: Diana Craciun <diana.craciun@oss.nxp.com>
> ---
>  MAINTAINERS                               |   6 +
>  drivers/vfio/Kconfig                      |   1 +
>  drivers/vfio/Makefile                     |   1 +
>  drivers/vfio/fsl-mc/Kconfig               |   9 ++
>  drivers/vfio/fsl-mc/Makefile              |   4 +
>  drivers/vfio/fsl-mc/vfio_fsl_mc.c         | 160 ++++++++++++++++++++++
>  drivers/vfio/fsl-mc/vfio_fsl_mc_private.h |  14 ++
>  include/uapi/linux/vfio.h                 |   1 +
>  8 files changed, 196 insertions(+)
>  create mode 100644 drivers/vfio/fsl-mc/Kconfig
>  create mode 100644 drivers/vfio/fsl-mc/Makefile
>  create mode 100644 drivers/vfio/fsl-mc/vfio_fsl_mc.c
>  create mode 100644 drivers/vfio/fsl-mc/vfio_fsl_mc_private.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3b186ade3597..f3f9ea108588 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18229,6 +18229,12 @@ F:	drivers/vfio/
>  F:	include/linux/vfio.h
>  F:	include/uapi/linux/vfio.h
>  
> +VFIO FSL-MC DRIVER
> +M:	Diana Craciun <diana.craciun@oss.nxp.com>
> +L:	kvm@vger.kernel.org
> +S:	Maintained
> +F:	drivers/vfio/fsl-mc/
> +
>  VFIO MEDIATED DEVICE DRIVERS
>  M:	Kirti Wankhede <kwankhede@nvidia.com>
>  L:	kvm@vger.kernel.org
> diff --git a/drivers/vfio/Kconfig b/drivers/vfio/Kconfig
> index fd17db9b432f..5533df91b257 100644
> --- a/drivers/vfio/Kconfig
> +++ b/drivers/vfio/Kconfig
> @@ -47,4 +47,5 @@ menuconfig VFIO_NOIOMMU
>  source "drivers/vfio/pci/Kconfig"
>  source "drivers/vfio/platform/Kconfig"
>  source "drivers/vfio/mdev/Kconfig"
> +source "drivers/vfio/fsl-mc/Kconfig"
>  source "virt/lib/Kconfig"
> diff --git a/drivers/vfio/Makefile b/drivers/vfio/Makefile
> index de67c4725cce..fee73f3d9480 100644
> --- a/drivers/vfio/Makefile
> +++ b/drivers/vfio/Makefile
> @@ -9,3 +9,4 @@ obj-$(CONFIG_VFIO_SPAPR_EEH) += vfio_spapr_eeh.o
>  obj-$(CONFIG_VFIO_PCI) += pci/
>  obj-$(CONFIG_VFIO_PLATFORM) += platform/
>  obj-$(CONFIG_VFIO_MDEV) += mdev/
> +obj-$(CONFIG_VFIO_FSL_MC) += fsl-mc/
> diff --git a/drivers/vfio/fsl-mc/Kconfig b/drivers/vfio/fsl-mc/Kconfig
> new file mode 100644
> index 000000000000..b1a527d6b6f2
> --- /dev/null
> +++ b/drivers/vfio/fsl-mc/Kconfig
> @@ -0,0 +1,9 @@
> +config VFIO_FSL_MC
> +	tristate "VFIO support for QorIQ DPAA2 fsl-mc bus devices"
> +	depends on VFIO && FSL_MC_BUS && EVENTFD
> +	help
> +	  Driver to enable support for the VFIO QorIQ DPAA2 fsl-mc
> +	  (Management Complex) devices. This is required to passthrough
> +	  fsl-mc bus devices using the VFIO framework.
> +
> +	  If you don't know what to do here, say N.
> diff --git a/drivers/vfio/fsl-mc/Makefile b/drivers/vfio/fsl-mc/Makefile
> new file mode 100644
> index 000000000000..0c6e5d2ddaae
> --- /dev/null
> +++ b/drivers/vfio/fsl-mc/Makefile
> @@ -0,0 +1,4 @@
> +# SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
> +
> +vfio-fsl-mc-y := vfio_fsl_mc.o
> +obj-$(CONFIG_VFIO_FSL_MC) += vfio-fsl-mc.o
> diff --git a/drivers/vfio/fsl-mc/vfio_fsl_mc.c b/drivers/vfio/fsl-mc/vfio_fsl_mc.c
> new file mode 100644
> index 000000000000..8b53c2a25b32
> --- /dev/null
> +++ b/drivers/vfio/fsl-mc/vfio_fsl_mc.c
> @@ -0,0 +1,160 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
> +/*
> + * Copyright 2013-2016 Freescale Semiconductor Inc.
> + * Copyright 2016-2017,2019-2020 NXP
> + */
> +
> +#include <linux/device.h>
> +#include <linux/iommu.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/slab.h>
> +#include <linux/types.h>
> +#include <linux/vfio.h>
> +#include <linux/fsl/mc.h>
> +
> +#include "vfio_fsl_mc_private.h"
> +
> +static int vfio_fsl_mc_open(void *device_data)
> +{
> +	if (!try_module_get(THIS_MODULE))
> +		return -ENODEV;
> +
> +	return 0;
> +}
> +
> +static void vfio_fsl_mc_release(void *device_data)
> +{
> +	module_put(THIS_MODULE);
> +}
> +
> +static long vfio_fsl_mc_ioctl(void *device_data, unsigned int cmd,
> +			      unsigned long arg)
> +{
> +	switch (cmd) {
> +	case VFIO_DEVICE_GET_INFO:
> +	{
> +		return -ENOTTY;
> +	}
> +	case VFIO_DEVICE_GET_REGION_INFO:
> +	{
> +		return -ENOTTY;
> +	}
> +	case VFIO_DEVICE_GET_IRQ_INFO:
> +	{
> +		return -ENOTTY;
> +	}
> +	case VFIO_DEVICE_SET_IRQS:
> +	{
> +		return -ENOTTY;
> +	}
> +	case VFIO_DEVICE_RESET:
> +	{
> +		return -ENOTTY;
> +	}
> +	default:
> +		return -ENOTTY;
> +	}
> +}
> +
> +static ssize_t vfio_fsl_mc_read(void *device_data, char __user *buf,
> +				size_t count, loff_t *ppos)
> +{
> +	return -EINVAL;
> +}
> +
> +static ssize_t vfio_fsl_mc_write(void *device_data, const char __user *buf,
> +				 size_t count, loff_t *ppos)
> +{
> +	return -EINVAL;
> +}
> +
> +static int vfio_fsl_mc_mmap(void *device_data, struct vm_area_struct *vma)
> +{
> +	return -EINVAL;
> +}
> +
> +static const struct vfio_device_ops vfio_fsl_mc_ops = {
> +	.name		= "vfio-fsl-mc",
> +	.open		= vfio_fsl_mc_open,
> +	.release	= vfio_fsl_mc_release,
> +	.ioctl		= vfio_fsl_mc_ioctl,
> +	.read		= vfio_fsl_mc_read,
> +	.write		= vfio_fsl_mc_write,
> +	.mmap		= vfio_fsl_mc_mmap,
> +};
> +
> +static int vfio_fsl_mc_probe(struct fsl_mc_device *mc_dev)
> +{
> +	struct iommu_group *group;
> +	struct vfio_fsl_mc_device *vdev;
> +	struct device *dev = &mc_dev->dev;
> +	int ret;
> +
> +	group = vfio_iommu_group_get(dev);
> +	if (!group) {
> +		dev_err(dev, "%s: VFIO: No IOMMU group\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	vdev = devm_kzalloc(dev, sizeof(*vdev), GFP_KERNEL);
> +	if (!vdev) {
> +		vfio_iommu_group_put(group, dev);
> +		return -ENOMEM;
> +	}
> +
> +	vdev->mc_dev = mc_dev;
> +
> +	ret = vfio_add_group_dev(dev, &vfio_fsl_mc_ops, vdev);
> +	if (ret) {
> +		dev_err(dev, "%s: Failed to add to vfio group\n", __func__);
> +		vfio_iommu_group_put(group, dev);
> +		return ret;
> +	}
> +
> +	return ret;
nit: introduce out_group_put: as in other files
This will be usable also in subsequent patches
> +}
> +
> +static int vfio_fsl_mc_remove(struct fsl_mc_device *mc_dev)
> +{
> +	struct vfio_fsl_mc_device *vdev;
> +	struct device *dev = &mc_dev->dev;
> +
> +	vdev = vfio_del_group_dev(dev);
> +	if (!vdev)
> +		return -EINVAL;
> +
> +	vfio_iommu_group_put(mc_dev->dev.iommu_group, dev);
> +
> +	return 0;
> +}
> +
> +/*
> + * vfio-fsl_mc is a meta-driver, so use driver_override interface to
> + * bind a fsl_mc container with this driver and match_id_table is NULL.
> + */
> +static struct fsl_mc_driver vfio_fsl_mc_driver = {
> +	.probe		= vfio_fsl_mc_probe,
> +	.remove		= vfio_fsl_mc_remove,
> +	.match_id_table = NULL,
not needed?
> +	.driver	= {
> +		.name	= "vfio-fsl-mc",
> +		.owner	= THIS_MODULE,
> +	},
> +};
> +
> +static int __init vfio_fsl_mc_driver_init(void)
> +{
> +	return fsl_mc_driver_register(&vfio_fsl_mc_driver);
> +}
> +
> +static void __exit vfio_fsl_mc_driver_exit(void)
> +{
> +	fsl_mc_driver_unregister(&vfio_fsl_mc_driver);
> +}
> +
> +module_init(vfio_fsl_mc_driver_init);
> +module_exit(vfio_fsl_mc_driver_exit);
> +
> +MODULE_LICENSE("GPL v2");
Don't you need MODULE_LICENSE("Dual BSD/GPL"); ?
> +MODULE_DESCRIPTION("VFIO for FSL-MC devices - User Level meta-driver");
> diff --git a/drivers/vfio/fsl-mc/vfio_fsl_mc_private.h b/drivers/vfio/fsl-mc/vfio_fsl_mc_private.h
> new file mode 100644
> index 000000000000..e79cc116f6b8
> --- /dev/null
> +++ b/drivers/vfio/fsl-mc/vfio_fsl_mc_private.h
> @@ -0,0 +1,14 @@
> +/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
> +/*
> + * Copyright 2013-2016 Freescale Semiconductor Inc.
> + * Copyright 2016,2019-2020 NXP
> + */
> +
> +#ifndef VFIO_FSL_MC_PRIVATE_H
> +#define VFIO_FSL_MC_PRIVATE_H
> +
> +struct vfio_fsl_mc_device {
> +	struct fsl_mc_device		*mc_dev;
> +};
> +
> +#endif /* VFIO_FSL_MC_PRIVATE_H */
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index 920470502329..95deac891378 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -201,6 +201,7 @@ struct vfio_device_info {
>  #define VFIO_DEVICE_FLAGS_AMBA  (1 << 3)	/* vfio-amba device */
>  #define VFIO_DEVICE_FLAGS_CCW	(1 << 4)	/* vfio-ccw device */
>  #define VFIO_DEVICE_FLAGS_AP	(1 << 5)	/* vfio-ap device */
> +#define VFIO_DEVICE_FLAGS_FSL_MC (1 << 6)	/* vfio-fsl-mc device */
>  	__u32	num_regions;	/* Max region index + 1 */
>  	__u32	num_irqs;	/* Max IRQ index + 1 */
>  };
> 
Thanks

Eric

