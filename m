Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAF79C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 09:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D69F2087D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 09:34:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728169AbgHZJeE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 05:34:04 -0400
Received: from inva020.nxp.com ([92.121.34.13]:42132 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728015AbgHZJdz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 05:33:55 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 53C4A1A091E;
        Wed, 26 Aug 2020 11:33:53 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 462321A08FF;
        Wed, 26 Aug 2020 11:33:53 +0200 (CEST)
Received: from fsr-ub1864-111.ea.freescale.net (fsr-ub1864-111.ea.freescale.net [10.171.82.141])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id EE821202CA;
        Wed, 26 Aug 2020 11:33:52 +0200 (CEST)
From:   Diana Craciun <diana.craciun@oss.nxp.com>
To:     alex.williamson@redhat.com, kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, bharatb.linux@gmail.com,
        laurentiu.tudor@nxp.com, Diana Craciun <diana.craciun@oss.nxp.com>,
        Bharat Bhushan <Bharat.Bhushan@nxp.com>
Subject: [PATCH v4 04/10] vfio/fsl-mc: Implement VFIO_DEVICE_GET_REGION_INFO ioctl call
Date:   Wed, 26 Aug 2020 12:33:09 +0300
Message-Id: <20200826093315.5279-5-diana.craciun@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200826093315.5279-1-diana.craciun@oss.nxp.com>
References: <20200826093315.5279-1-diana.craciun@oss.nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Expose to userspace information about the memory regions.

Signed-off-by: Bharat Bhushan <Bharat.Bhushan@nxp.com>
Signed-off-by: Diana Craciun <diana.craciun@oss.nxp.com>
---
 drivers/vfio/fsl-mc/vfio_fsl_mc.c         | 79 ++++++++++++++++++++++-
 drivers/vfio/fsl-mc/vfio_fsl_mc_private.h | 19 ++++++
 2 files changed, 97 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/fsl-mc/vfio_fsl_mc.c b/drivers/vfio/fsl-mc/vfio_fsl_mc.c
index 5a5460d01f00..093b8d68496c 100644
--- a/drivers/vfio/fsl-mc/vfio_fsl_mc.c
+++ b/drivers/vfio/fsl-mc/vfio_fsl_mc.c
@@ -17,16 +17,72 @@
 
 static struct fsl_mc_driver vfio_fsl_mc_driver;
 
+static int vfio_fsl_mc_regions_init(struct vfio_fsl_mc_device *vdev)
+{
+	struct fsl_mc_device *mc_dev = vdev->mc_dev;
+	int count = mc_dev->obj_desc.region_count;
+	int i;
+
+	vdev->regions = kcalloc(count, sizeof(struct vfio_fsl_mc_region),
+				GFP_KERNEL);
+	if (!vdev->regions)
+		return -ENOMEM;
+
+	for (i = 0; i < count; i++) {
+		struct resource *res = &mc_dev->regions[i];
+
+		vdev->regions[i].addr = res->start;
+		vdev->regions[i].size = resource_size(res);
+		vdev->regions[i].flags = 0;
+	}
+
+	vdev->num_regions = mc_dev->obj_desc.region_count;
+	return 0;
+}
+
+static void vfio_fsl_mc_regions_cleanup(struct vfio_fsl_mc_device *vdev)
+{
+	vdev->num_regions = 0;
+	kfree(vdev->regions);
+}
+
 static int vfio_fsl_mc_open(void *device_data)
 {
+	struct vfio_fsl_mc_device *vdev = device_data;
+	int ret;
+
 	if (!try_module_get(THIS_MODULE))
 		return -ENODEV;
 
+	mutex_lock(&vdev->driver_lock);
+	if (!vdev->refcnt) {
+		ret = vfio_fsl_mc_regions_init(vdev);
+		if (ret)
+			goto err_reg_init;
+	}
+	vdev->refcnt++;
+
+	mutex_unlock(&vdev->driver_lock);
+
 	return 0;
+
+err_reg_init:
+	mutex_unlock(&vdev->driver_lock);
+	module_put(THIS_MODULE);
+	return ret;
 }
 
 static void vfio_fsl_mc_release(void *device_data)
 {
+	struct vfio_fsl_mc_device *vdev = device_data;
+
+	mutex_lock(&vdev->driver_lock);
+
+	if (!(--vdev->refcnt))
+		vfio_fsl_mc_regions_cleanup(vdev);
+
+	mutex_unlock(&vdev->driver_lock);
+
 	module_put(THIS_MODULE);
 }
 
@@ -59,7 +115,25 @@ static long vfio_fsl_mc_ioctl(void *device_data, unsigned int cmd,
 	}
 	case VFIO_DEVICE_GET_REGION_INFO:
 	{
-		return -ENOTTY;
+		struct vfio_region_info info;
+
+		minsz = offsetofend(struct vfio_region_info, offset);
+
+		if (copy_from_user(&info, (void __user *)arg, minsz))
+			return -EFAULT;
+
+		if (info.argsz < minsz)
+			return -EINVAL;
+
+		if (info.index >= vdev->num_regions)
+			return -EINVAL;
+
+		/* map offset to the physical address  */
+		info.offset = VFIO_FSL_MC_INDEX_TO_OFFSET(info.index);
+		info.size = vdev->regions[info.index].size;
+		info.flags = vdev->regions[info.index].flags;
+
+		return copy_to_user((void __user *)arg, &info, minsz);
 	}
 	case VFIO_DEVICE_GET_IRQ_INFO:
 	{
@@ -204,6 +278,7 @@ static int vfio_fsl_mc_probe(struct fsl_mc_device *mc_dev)
 		vfio_iommu_group_put(group, dev);
 		return ret;
 	}
+	mutex_init(&vdev->driver_lock);
 
 	return ret;
 }
@@ -227,6 +302,8 @@ static int vfio_fsl_mc_remove(struct fsl_mc_device *mc_dev)
 
 	mc_dev->mc_io = NULL;
 
+	mutex_destroy(&vdev->driver_lock);
+
 	vfio_iommu_group_put(mc_dev->dev.iommu_group, dev);
 
 	return 0;
diff --git a/drivers/vfio/fsl-mc/vfio_fsl_mc_private.h b/drivers/vfio/fsl-mc/vfio_fsl_mc_private.h
index 37d61eaa58c8..818dfd3df4db 100644
--- a/drivers/vfio/fsl-mc/vfio_fsl_mc_private.h
+++ b/drivers/vfio/fsl-mc/vfio_fsl_mc_private.h
@@ -7,9 +7,28 @@
 #ifndef VFIO_FSL_MC_PRIVATE_H
 #define VFIO_FSL_MC_PRIVATE_H
 
+#define VFIO_FSL_MC_OFFSET_SHIFT    40
+#define VFIO_FSL_MC_OFFSET_MASK (((u64)(1) << VFIO_FSL_MC_OFFSET_SHIFT) - 1)
+
+#define VFIO_FSL_MC_OFFSET_TO_INDEX(off) ((off) >> VFIO_FSL_MC_OFFSET_SHIFT)
+
+#define VFIO_FSL_MC_INDEX_TO_OFFSET(index)	\
+	((u64)(index) << VFIO_FSL_MC_OFFSET_SHIFT)
+
+struct vfio_fsl_mc_region {
+	u32			flags;
+	u32			type;
+	u64			addr;
+	resource_size_t		size;
+};
+
 struct vfio_fsl_mc_device {
 	struct fsl_mc_device		*mc_dev;
 	struct notifier_block        nb;
+	int				refcnt;
+	u32				num_regions;
+	struct vfio_fsl_mc_region	*regions;
+	struct mutex driver_lock;
 };
 
 #endif /* VFIO_FSL_MC_PRIVATE_H */
-- 
2.17.1

