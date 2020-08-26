Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 075EFC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 09:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D11BF2071E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 09:41:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728334AbgHZJle (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 05:41:34 -0400
Received: from inva020.nxp.com ([92.121.34.13]:42104 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728002AbgHZJdy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 05:33:54 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id EC9E21A090E;
        Wed, 26 Aug 2020 11:33:52 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id DFDE91A08FF;
        Wed, 26 Aug 2020 11:33:52 +0200 (CEST)
Received: from fsr-ub1864-111.ea.freescale.net (fsr-ub1864-111.ea.freescale.net [10.171.82.141])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 8B01C202CA;
        Wed, 26 Aug 2020 11:33:52 +0200 (CEST)
From:   Diana Craciun <diana.craciun@oss.nxp.com>
To:     alex.williamson@redhat.com, kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, bharatb.linux@gmail.com,
        laurentiu.tudor@nxp.com, Diana Craciun <diana.craciun@oss.nxp.com>,
        Bharat Bhushan <Bharat.Bhushan@nxp.com>
Subject: [PATCH v4 03/10] vfio/fsl-mc: Implement VFIO_DEVICE_GET_INFO ioctl
Date:   Wed, 26 Aug 2020 12:33:08 +0300
Message-Id: <20200826093315.5279-4-diana.craciun@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200826093315.5279-1-diana.craciun@oss.nxp.com>
References: <20200826093315.5279-1-diana.craciun@oss.nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow userspace to get fsl-mc device info (number of regions
and irqs).

Signed-off-by: Bharat Bhushan <Bharat.Bhushan@nxp.com>
Signed-off-by: Diana Craciun <diana.craciun@oss.nxp.com>
---
 drivers/vfio/fsl-mc/vfio_fsl_mc.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/fsl-mc/vfio_fsl_mc.c b/drivers/vfio/fsl-mc/vfio_fsl_mc.c
index 85e007be3a5d..5a5460d01f00 100644
--- a/drivers/vfio/fsl-mc/vfio_fsl_mc.c
+++ b/drivers/vfio/fsl-mc/vfio_fsl_mc.c
@@ -33,10 +33,29 @@ static void vfio_fsl_mc_release(void *device_data)
 static long vfio_fsl_mc_ioctl(void *device_data, unsigned int cmd,
 			      unsigned long arg)
 {
+	unsigned long minsz;
+	struct vfio_fsl_mc_device *vdev = device_data;
+	struct fsl_mc_device *mc_dev = vdev->mc_dev;
+
 	switch (cmd) {
 	case VFIO_DEVICE_GET_INFO:
 	{
-		return -ENOTTY;
+		struct vfio_device_info info;
+
+		minsz = offsetofend(struct vfio_device_info, num_irqs);
+
+		if (copy_from_user(&info, (void __user *)arg, minsz))
+			return -EFAULT;
+
+		if (info.argsz < minsz)
+			return -EINVAL;
+
+		info.flags = VFIO_DEVICE_FLAGS_FSL_MC;
+		info.num_regions = mc_dev->obj_desc.region_count;
+		info.num_irqs = mc_dev->obj_desc.irq_count;
+
+		return copy_to_user((void __user *)arg, &info, minsz) ?
+			-EFAULT : 0;
 	}
 	case VFIO_DEVICE_GET_REGION_INFO:
 	{
-- 
2.17.1

