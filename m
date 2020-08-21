Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4269C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 09:28:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F1942087D
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 09:28:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H/1Ar6xp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728476AbgHUJ2n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 05:28:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25356 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728450AbgHUJ2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 05:28:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598002117;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=8Zsy9C/W5fdE4C1wFlfllX162Xx/h03AqwPyKw4nkG8=;
        b=H/1Ar6xpJLU/Md4BGF1nEl2OdoTVJcSbmN4vZo6I7ij5KwiYoOlrT+FeZ5uLye/mfnA1X1
        V2c3KV60GWe9yn5YzeuXMECerl01Oo1xdM97A+isiQ/MQxf2J5fufCe4KEFR/0JwbZkXyC
        AHepRP8gz/5LspycZsPIYCVDaUH112Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-491-s7LwOrfBOcuKVDmWVXLBHw-1; Fri, 21 Aug 2020 05:28:35 -0400
X-MC-Unique: s7LwOrfBOcuKVDmWVXLBHw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D2EC318A2242;
        Fri, 21 Aug 2020 09:28:33 +0000 (UTC)
Received: from hp-dl380pg8-01.lab.eng.pek2.redhat.com (hp-dl380pg8-01.lab.eng.pek2.redhat.com [10.73.8.10])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 271B67191C;
        Fri, 21 Aug 2020 09:28:28 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     rob.miller@broadcom.com, lingshan.zhu@intel.com,
        eperezma@redhat.com, lulu@redhat.com, shahafs@mellanox.com,
        hanand@xilinx.com, mhabets@solarflare.com, gdawar@xilinx.com,
        saugatm@xilinx.com, vmireyno@marvell.com,
        zhangweining@ruijie.com.cn, eli@mellanox.com,
        Jason Wang <jasowang@redhat.com>
Subject: [PATCH V2 2/3] vhost: vdpa: report iova range
Date:   Fri, 21 Aug 2020 05:28:12 -0400
Message-Id: <20200821092813.8952-3-jasowang@redhat.com>
In-Reply-To: <20200821092813.8952-1-jasowang@redhat.com>
References: <20200821092813.8952-1-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces a new ioctl for vhost-vdpa device that can
report the iova range by the device.

For device that implements get_iova_range() method, we fetch it from
the vDPA device. If device doesn't implement get_iova_range() but
depends on platform IOMMU, we will query via DOMAIN_ATTR_GEOMETRY,
otherwise [0, ULLONG_MAX] is assumed.

For safety, this patch also rules out the map request which is not in
the valid range.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/vdpa.c             | 41 ++++++++++++++++++++++++++++++++
 include/uapi/linux/vhost.h       |  4 ++++
 include/uapi/linux/vhost_types.h |  9 +++++++
 3 files changed, 54 insertions(+)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 3fab94f88894..1adb4adb0345 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -48,6 +48,7 @@ struct vhost_vdpa {
 	int minor;
 	struct eventfd_ctx *config_ctx;
 	int in_batch;
+	struct vdpa_iova_range range;
 };
 
 static DEFINE_IDA(vhost_vdpa_ida);
@@ -344,6 +345,16 @@ static long vhost_vdpa_set_config_call(struct vhost_vdpa *v, u32 __user *argp)
 	return 0;
 }
 
+static long vhost_vdpa_get_iova_range(struct vhost_vdpa *v, u32 __user *argp)
+{
+	struct vhost_vdpa_iova_range range = {
+		.first = v->range.first,
+		.last = v->range.last,
+	};
+
+	return copy_to_user(argp, &range, sizeof(range));
+}
+
 static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
 				   void __user *argp)
 {
@@ -476,6 +487,9 @@ static long vhost_vdpa_unlocked_ioctl(struct file *filep,
 	case VHOST_VDPA_SET_CONFIG_CALL:
 		r = vhost_vdpa_set_config_call(v, argp);
 		break;
+	case VHOST_VDPA_GET_IOVA_RANGE:
+		r = vhost_vdpa_get_iova_range(v, argp);
+		break;
 	default:
 		r = vhost_dev_ioctl(&v->vdev, cmd, argp);
 		if (r == -ENOIOCTLCMD)
@@ -597,6 +611,10 @@ static int vhost_vdpa_process_iotlb_update(struct vhost_vdpa *v,
 	u64 iova = msg->iova;
 	int ret = 0;
 
+	if (msg->iova < v->range.first ||
+	    msg->iova + msg->size - 1 > v->range.last)
+		return -EINVAL;
+
 	if (vhost_iotlb_itree_first(iotlb, msg->iova,
 				    msg->iova + msg->size - 1))
 		return -EEXIST;
@@ -762,6 +780,27 @@ static void vhost_vdpa_free_domain(struct vhost_vdpa *v)
 	v->domain = NULL;
 }
 
+static void vhost_vdpa_set_iova_range(struct vhost_vdpa *v)
+{
+	struct vdpa_iova_range *range = &v->range;
+	struct iommu_domain_geometry geo;
+	struct vdpa_device *vdpa = v->vdpa;
+	const struct vdpa_config_ops *ops = vdpa->config;
+
+	if (ops->get_iova_range) {
+		*range = ops->get_iova_range(vdpa);
+	} else if (v->domain &&
+		   !iommu_domain_get_attr(v->domain,
+		   DOMAIN_ATTR_GEOMETRY, &geo) &&
+		   geo.force_aperture) {
+		range->first = geo.aperture_start;
+		range->last = geo.aperture_end;
+	} else {
+		range->first = 0;
+		range->last = ULLONG_MAX;
+	}
+}
+
 static int vhost_vdpa_open(struct inode *inode, struct file *filep)
 {
 	struct vhost_vdpa *v;
@@ -802,6 +841,8 @@ static int vhost_vdpa_open(struct inode *inode, struct file *filep)
 	if (r)
 		goto err_init_iotlb;
 
+	vhost_vdpa_set_iova_range(v);
+
 	filep->private_data = v;
 
 	return 0;
diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
index 75232185324a..c998860d7bbc 100644
--- a/include/uapi/linux/vhost.h
+++ b/include/uapi/linux/vhost.h
@@ -146,4 +146,8 @@
 
 /* Set event fd for config interrupt*/
 #define VHOST_VDPA_SET_CONFIG_CALL	_IOW(VHOST_VIRTIO, 0x77, int)
+
+/* Get the valid iova range */
+#define VHOST_VDPA_GET_IOVA_RANGE	_IOR(VHOST_VIRTIO, 0x78, \
+					     struct vhost_vdpa_iova_range)
 #endif
diff --git a/include/uapi/linux/vhost_types.h b/include/uapi/linux/vhost_types.h
index 9a269a88a6ff..f7f6a3a28977 100644
--- a/include/uapi/linux/vhost_types.h
+++ b/include/uapi/linux/vhost_types.h
@@ -138,6 +138,15 @@ struct vhost_vdpa_config {
 	__u8 buf[0];
 };
 
+/* vhost vdpa IOVA range
+ * @first: First address that can be mapped by vhost-vDPA
+ * @last: Last address that can be mapped by vhost-vDPA
+ */
+struct vhost_vdpa_iova_range {
+	__u64 first;
+	__u64 last;
+};
+
 /* Feature bits */
 /* Log all write descriptors. Can be changed while device is active. */
 #define VHOST_F_LOG_ALL 26
-- 
2.18.1

