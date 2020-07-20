Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C32F9C433F2
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 07:53:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA72920674
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 07:53:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728223AbgGTHxz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 03:53:55 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:41287 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726689AbgGTHxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 03:53:52 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from eli@mellanox.com)
        with SMTP; 20 Jul 2020 10:53:45 +0300
Received: from nps-server-21.mtl.labs.mlnx (nps-server-21.mtl.labs.mlnx [10.237.240.120])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 06K7rjgN008217;
        Mon, 20 Jul 2020 10:53:45 +0300
Received: from nps-server-21.mtl.labs.mlnx (localhost [127.0.0.1])
        by nps-server-21.mtl.labs.mlnx (8.14.7/8.14.7) with ESMTP id 06K7ERZ9032181;
        Mon, 20 Jul 2020 10:14:27 +0300
Received: (from eli@localhost)
        by nps-server-21.mtl.labs.mlnx (8.14.7/8.14.7/Submit) id 06K7ERGf032176;
        Mon, 20 Jul 2020 10:14:27 +0300
From:   Eli Cohen <eli@mellanox.com>
To:     mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     shahafs@mellanox.com, saeedm@mellanox.com, parav@mellanox.com
Subject: [PATCH V2 vhost next 01/10] vhost-vdpa: support batch updating
Date:   Mon, 20 Jul 2020 10:14:07 +0300
Message-Id: <20200720071416.32112-2-eli@mellanox.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200720071416.32112-1-eli@mellanox.com>
References: <20200720071416.32112-1-eli@mellanox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jason Wang <jasowang@redhat.com>

Change-Id: Ifd7139cfbd122dc22493f4bb93fa884f8edbddb6
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/vdpa.c             | 23 +++++++++++++++++------
 include/uapi/linux/vhost_types.h |  2 ++
 2 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index a54b60d6623f..8827ae31f96d 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -73,6 +73,7 @@ struct vhost_vdpa {
 	int virtio_id;
 	int minor;
 	struct eventfd_ctx *config_ctx;
+	bool in_batch;
 };
 
 static DEFINE_IDA(vhost_vdpa_ida);
@@ -521,9 +522,9 @@ static int vhost_vdpa_map(struct vhost_vdpa *v,
 
 	if (ops->dma_map)
 		r = ops->dma_map(vdpa, iova, size, pa, perm);
-	else if (ops->set_map)
-		r = ops->set_map(vdpa, dev->iotlb);
-	else
+	else if (ops->set_map) {
+
+	} else
 		r = iommu_map(v->domain, iova, pa, size,
 			      perm_to_iommu_flags(perm));
 
@@ -540,9 +541,8 @@ static void vhost_vdpa_unmap(struct vhost_vdpa *v, u64 iova, u64 size)
 
 	if (ops->dma_map)
 		ops->dma_unmap(vdpa, iova, size);
-	else if (ops->set_map)
-		ops->set_map(vdpa, dev->iotlb);
-	else
+	else if (ops->set_map) {
+	} else
 		iommu_unmap(v->domain, iova, size);
 }
 
@@ -636,6 +636,8 @@ static int vhost_vdpa_process_iotlb_msg(struct vhost_dev *dev,
 					struct vhost_iotlb_msg *msg)
 {
 	struct vhost_vdpa *v = container_of(dev, struct vhost_vdpa, vdev);
+	struct vdpa_device *vdpa = v->vdpa;
+	const struct vdpa_config_ops *ops = vdpa->config;
 	int r = 0;
 
 	r = vhost_dev_check_owner(dev);
@@ -649,6 +651,15 @@ static int vhost_vdpa_process_iotlb_msg(struct vhost_dev *dev,
 	case VHOST_IOTLB_INVALIDATE:
 		vhost_vdpa_unmap(v, msg->iova, msg->size);
 		break;
+	case VHOST_IOTLB_BATCH_BEGIN:
+		v->in_batch = true;
+		break;
+	case VHOST_IOTLB_BATCH_END:
+		if (v->in_batch && ops->set_map) {
+			ops->set_map(vdpa, dev->iotlb);
+		}
+		v->in_batch = false;
+		break;
 	default:
 		r = -EINVAL;
 		break;
diff --git a/include/uapi/linux/vhost_types.h b/include/uapi/linux/vhost_types.h
index 669457ce5c48..7f52245f8d5d 100644
--- a/include/uapi/linux/vhost_types.h
+++ b/include/uapi/linux/vhost_types.h
@@ -60,6 +60,8 @@ struct vhost_iotlb_msg {
 #define VHOST_IOTLB_UPDATE         2
 #define VHOST_IOTLB_INVALIDATE     3
 #define VHOST_IOTLB_ACCESS_FAIL    4
+#define VHOST_IOTLB_BATCH_BEGIN    5
+#define VHOST_IOTLB_BATCH_END      6
 	__u8 type;
 };
 
-- 
2.26.0

