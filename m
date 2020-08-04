Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE8BDC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 16:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99EB3208A9
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 16:24:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729861AbgHDQYD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 12:24:03 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:43881 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729615AbgHDQU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 12:20:59 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from eli@mellanox.com)
        with SMTP; 4 Aug 2020 19:20:52 +0300
Received: from nps-server-21.mtl.labs.mlnx (nps-server-21.mtl.labs.mlnx [10.237.240.120])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 074GKqCp024004;
        Tue, 4 Aug 2020 19:20:52 +0300
Received: from nps-server-21.mtl.labs.mlnx (localhost [127.0.0.1])
        by nps-server-21.mtl.labs.mlnx (8.14.7/8.14.7) with ESMTP id 074GKqrp022641;
        Tue, 4 Aug 2020 19:20:52 +0300
Received: (from eli@localhost)
        by nps-server-21.mtl.labs.mlnx (8.14.7/8.14.7/Submit) id 074GKqZ0022640;
        Tue, 4 Aug 2020 19:20:52 +0300
From:   Eli Cohen <eli@mellanox.com>
To:     mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     shahafs@mellanox.com, saeedm@mellanox.com, parav@mellanox.com
Subject: [PATCH V4 linux-next 04/12] vhost-vdpa: support IOTLB batching hints
Date:   Tue,  4 Aug 2020 19:20:40 +0300
Message-Id: <20200804162048.22587-5-eli@mellanox.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200804162048.22587-1-eli@mellanox.com>
References: <20200804162048.22587-1-eli@mellanox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jason Wang <jasowang@redhat.com>

This patches extend the vhost IOTLB API to accept batch updating hints
form userspace. When userspace wants update the device IOTLB in a
batch, it may do:

1) Write vhost_iotlb_msg with VHOST_IOTLB_BATCH_BEGIN flag
2) Perform a batch of IOTLB updating via VHOST_IOTLB_UPDATE/INVALIDATE
3) Write vhost_iotlb_msg with VHOST_IOTLB_BATCH_END flag

Vhost-vdpa may decide to batch the IOMMU/IOTLB updating in step 3 when
vDPA device support set_map() ops. This is useful for the vDPA device
that want to know all the mappings to tweak their own DMA translation
logic.

For vDPA device that doesn't require set_map(), no behavior changes.

This capability is advertised via VHOST_BACKEND_F_IOTLB_BATCH capability.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/vdpa.c             | 36 ++++++++++++++++++++++++--------
 include/uapi/linux/vhost.h       |  2 ++
 include/uapi/linux/vhost_types.h | 11 ++++++++++
 3 files changed, 40 insertions(+), 9 deletions(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 2f0310d1b914..0a143615e69d 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -27,7 +27,9 @@
 #include "vhost.h"
 
 enum {
-	VHOST_VDPA_BACKEND_FEATURES = (1ULL << VHOST_BACKEND_F_IOTLB_MSG_V2)
+	VHOST_VDPA_BACKEND_FEATURES =
+	(1ULL << VHOST_BACKEND_F_IOTLB_MSG_V2) |
+	(1ULL << VHOST_BACKEND_F_IOTLB_BATCH),
 };
 
 /* Currently, only network backend w/o multiqueue is supported. */
@@ -48,6 +50,7 @@ struct vhost_vdpa {
 	int virtio_id;
 	int minor;
 	struct eventfd_ctx *config_ctx;
+	int in_batch;
 };
 
 static DEFINE_IDA(vhost_vdpa_ida);
@@ -140,6 +143,7 @@ static void vhost_vdpa_reset(struct vhost_vdpa *v)
 	struct vdpa_device *vdpa = v->vdpa;
 
 	vdpa_reset(vdpa);
+	v->in_batch = 0;
 }
 
 static long vhost_vdpa_get_device_id(struct vhost_vdpa *v, u8 __user *argp)
@@ -563,13 +567,15 @@ static int vhost_vdpa_map(struct vhost_vdpa *v,
 	if (r)
 		return r;
 
-	if (ops->dma_map)
+	if (ops->dma_map) {
 		r = ops->dma_map(vdpa, iova, size, pa, perm);
-	else if (ops->set_map)
-		r = ops->set_map(vdpa, dev->iotlb);
-	else
+	} else if (ops->set_map) {
+		if (!v->in_batch)
+			r = ops->set_map(vdpa, dev->iotlb);
+	} else {
 		r = iommu_map(v->domain, iova, pa, size,
 			      perm_to_iommu_flags(perm));
+	}
 
 	return r;
 }
@@ -582,12 +588,14 @@ static void vhost_vdpa_unmap(struct vhost_vdpa *v, u64 iova, u64 size)
 
 	vhost_vdpa_iotlb_unmap(v, iova, iova + size - 1);
 
-	if (ops->dma_map)
+	if (ops->dma_map) {
 		ops->dma_unmap(vdpa, iova, size);
-	else if (ops->set_map)
-		ops->set_map(vdpa, dev->iotlb);
-	else
+	} else if (ops->set_map) {
+		if (!v->in_batch)
+			ops->set_map(vdpa, dev->iotlb);
+	} else {
 		iommu_unmap(v->domain, iova, size);
+	}
 }
 
 static int vhost_vdpa_process_iotlb_update(struct vhost_vdpa *v,
@@ -680,6 +688,8 @@ static int vhost_vdpa_process_iotlb_msg(struct vhost_dev *dev,
 					struct vhost_iotlb_msg *msg)
 {
 	struct vhost_vdpa *v = container_of(dev, struct vhost_vdpa, vdev);
+	struct vdpa_device *vdpa = v->vdpa;
+	const struct vdpa_config_ops *ops = vdpa->config;
 	int r = 0;
 
 	r = vhost_dev_check_owner(dev);
@@ -693,6 +703,14 @@ static int vhost_vdpa_process_iotlb_msg(struct vhost_dev *dev,
 	case VHOST_IOTLB_INVALIDATE:
 		vhost_vdpa_unmap(v, msg->iova, msg->size);
 		break;
+	case VHOST_IOTLB_BATCH_BEGIN:
+		v->in_batch = true;
+		break;
+	case VHOST_IOTLB_BATCH_END:
+		if (v->in_batch && ops->set_map)
+			ops->set_map(vdpa, dev->iotlb);
+		v->in_batch = false;
+		break;
 	default:
 		r = -EINVAL;
 		break;
diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
index 5d9254e2a6b6..11a4948b6216 100644
--- a/include/uapi/linux/vhost.h
+++ b/include/uapi/linux/vhost.h
@@ -91,6 +91,8 @@
 
 /* Use message type V2 */
 #define VHOST_BACKEND_F_IOTLB_MSG_V2 0x1
+/* IOTLB can accept batching hints */
+#define VHOST_BACKEND_F_IOTLB_BATCH  0x2
 
 #define VHOST_SET_BACKEND_FEATURES _IOW(VHOST_VIRTIO, 0x25, __u64)
 #define VHOST_GET_BACKEND_FEATURES _IOR(VHOST_VIRTIO, 0x26, __u64)
diff --git a/include/uapi/linux/vhost_types.h b/include/uapi/linux/vhost_types.h
index 669457ce5c48..9a269a88a6ff 100644
--- a/include/uapi/linux/vhost_types.h
+++ b/include/uapi/linux/vhost_types.h
@@ -60,6 +60,17 @@ struct vhost_iotlb_msg {
 #define VHOST_IOTLB_UPDATE         2
 #define VHOST_IOTLB_INVALIDATE     3
 #define VHOST_IOTLB_ACCESS_FAIL    4
+/*
+ * VHOST_IOTLB_BATCH_BEGIN and VHOST_IOTLB_BATCH_END allow modifying
+ * multiple mappings in one go: beginning with
+ * VHOST_IOTLB_BATCH_BEGIN, followed by any number of
+ * VHOST_IOTLB_UPDATE messages, and ending with VHOST_IOTLB_BATCH_END.
+ * When one of these two values is used as the message type, the rest
+ * of the fields in the message are ignored. There's no guarantee that
+ * these changes take place automatically in the device.
+ */
+#define VHOST_IOTLB_BATCH_BEGIN    5
+#define VHOST_IOTLB_BATCH_END      6
 	__u8 type;
 };
 
-- 
2.26.0

