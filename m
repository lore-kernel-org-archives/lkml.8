Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F13AC433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 16:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EB262070A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 16:25:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729993AbgHDQZx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 12:25:53 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:43867 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729610AbgHDQU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 12:20:58 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from eli@mellanox.com)
        with SMTP; 4 Aug 2020 19:20:52 +0300
Received: from nps-server-21.mtl.labs.mlnx (nps-server-21.mtl.labs.mlnx [10.237.240.120])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 074GKqTE023997;
        Tue, 4 Aug 2020 19:20:52 +0300
Received: from nps-server-21.mtl.labs.mlnx (localhost [127.0.0.1])
        by nps-server-21.mtl.labs.mlnx (8.14.7/8.14.7) with ESMTP id 074GKq0N022636;
        Tue, 4 Aug 2020 19:20:52 +0300
Received: (from eli@localhost)
        by nps-server-21.mtl.labs.mlnx (8.14.7/8.14.7/Submit) id 074GKqKD022635;
        Tue, 4 Aug 2020 19:20:52 +0300
From:   Eli Cohen <eli@mellanox.com>
To:     mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     shahafs@mellanox.com, saeedm@mellanox.com, parav@mellanox.com
Subject: [PATCH V4 linux-next 02/12] vhost: generialize backend features setting/getting
Date:   Tue,  4 Aug 2020 19:20:38 +0300
Message-Id: <20200804162048.22587-3-eli@mellanox.com>
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

Move the backend features setting/getting from net.c to vhost.c to be
reused by vhost-vdpa.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/net.c   | 18 ++----------------
 drivers/vhost/vhost.c | 15 +++++++++++++++
 drivers/vhost/vhost.h |  2 ++
 3 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 8e0921d3805d..bfbbe5c876f9 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -1615,21 +1615,6 @@ static long vhost_net_reset_owner(struct vhost_net *n)
 	return err;
 }
 
-static int vhost_net_set_backend_features(struct vhost_net *n, u64 features)
-{
-	int i;
-
-	mutex_lock(&n->dev.mutex);
-	for (i = 0; i < VHOST_NET_VQ_MAX; ++i) {
-		mutex_lock(&n->vqs[i].vq.mutex);
-		n->vqs[i].vq.acked_backend_features = features;
-		mutex_unlock(&n->vqs[i].vq.mutex);
-	}
-	mutex_unlock(&n->dev.mutex);
-
-	return 0;
-}
-
 static int vhost_net_set_features(struct vhost_net *n, u64 features)
 {
 	size_t vhost_hlen, sock_hlen, hdr_len;
@@ -1730,7 +1715,8 @@ static long vhost_net_ioctl(struct file *f, unsigned int ioctl,
 			return -EFAULT;
 		if (features & ~VHOST_NET_BACKEND_FEATURES)
 			return -EOPNOTSUPP;
-		return vhost_net_set_backend_features(n, features);
+		vhost_set_backend_features(&n->dev, features);
+		return 0;
 	case VHOST_RESET_OWNER:
 		return vhost_net_reset_owner(n);
 	case VHOST_SET_OWNER:
diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 8f622064b3e8..5e5cc3dd983e 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -2591,6 +2591,21 @@ struct vhost_msg_node *vhost_dequeue_msg(struct vhost_dev *dev,
 }
 EXPORT_SYMBOL_GPL(vhost_dequeue_msg);
 
+void vhost_set_backend_features(struct vhost_dev *dev, u64 features)
+{
+	struct vhost_virtqueue *vq;
+	int i;
+
+	mutex_lock(&dev->mutex);
+	for (i = 0; i < dev->nvqs; ++i) {
+		vq = dev->vqs[i];
+		mutex_lock(&vq->mutex);
+		vq->acked_backend_features = features;
+		mutex_unlock(&vq->mutex);
+	}
+	mutex_unlock(&dev->mutex);
+}
+EXPORT_SYMBOL_GPL(vhost_set_backend_features);
 
 static int __init vhost_init(void)
 {
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index 38eb1aa3b68d..9032d3c2a9f4 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -214,6 +214,8 @@ void vhost_enqueue_msg(struct vhost_dev *dev,
 		       struct vhost_msg_node *node);
 struct vhost_msg_node *vhost_dequeue_msg(struct vhost_dev *dev,
 					 struct list_head *head);
+void vhost_set_backend_features(struct vhost_dev *dev, u64 features);
+
 __poll_t vhost_chr_poll(struct file *file, struct vhost_dev *dev,
 			    poll_table *wait);
 ssize_t vhost_chr_read_iter(struct vhost_dev *dev, struct iov_iter *to,
-- 
2.26.0

