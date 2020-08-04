Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 924AFC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 16:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DF452070A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 16:22:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729789AbgHDQWc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 12:22:32 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:43912 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729658AbgHDQVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 12:21:02 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from eli@mellanox.com)
        with SMTP; 4 Aug 2020 19:20:53 +0300
Received: from nps-server-21.mtl.labs.mlnx (nps-server-21.mtl.labs.mlnx [10.237.240.120])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 074GKrMK024049;
        Tue, 4 Aug 2020 19:20:53 +0300
Received: from nps-server-21.mtl.labs.mlnx (localhost [127.0.0.1])
        by nps-server-21.mtl.labs.mlnx (8.14.7/8.14.7) with ESMTP id 074GKrhH022647;
        Tue, 4 Aug 2020 19:20:53 +0300
Received: (from eli@localhost)
        by nps-server-21.mtl.labs.mlnx (8.14.7/8.14.7/Submit) id 074GKrt4022646;
        Tue, 4 Aug 2020 19:20:53 +0300
From:   Eli Cohen <eli@mellanox.com>
To:     mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     shahafs@mellanox.com, saeedm@mellanox.com, parav@mellanox.com,
        Eli Cohen <eli@mellanox.com>
Subject: [PATCH V4 linux-next 07/12] net/vdpa: Use struct for set/get vq state
Date:   Tue,  4 Aug 2020 19:20:43 +0300
Message-Id: <20200804162048.22587-8-eli@mellanox.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200804162048.22587-1-eli@mellanox.com>
References: <20200804162048.22587-1-eli@mellanox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For now VQ state involves 16 bit available index value encoded in u64
variable. In the future it will be extended to contain more fields. Use
struct to contain the state, now containing only a single u16 for the
available index. In the future we can add fields to this struct.

Reviewed-by: Parav Pandit <parav@mellanox.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Eli Cohen <eli@mellanox.com>
---
 drivers/vdpa/ifcvf/ifcvf_base.c  |  4 ++--
 drivers/vdpa/ifcvf/ifcvf_base.h  |  4 ++--
 drivers/vdpa/ifcvf/ifcvf_main.c  |  9 +++++----
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 10 ++++++----
 drivers/vhost/vdpa.c             |  7 +++++--
 include/linux/vdpa.h             | 18 ++++++++++++++----
 6 files changed, 34 insertions(+), 18 deletions(-)

diff --git a/drivers/vdpa/ifcvf/ifcvf_base.c b/drivers/vdpa/ifcvf/ifcvf_base.c
index 94bf0328b68d..f2a128e56de5 100644
--- a/drivers/vdpa/ifcvf/ifcvf_base.c
+++ b/drivers/vdpa/ifcvf/ifcvf_base.c
@@ -272,7 +272,7 @@ static int ifcvf_config_features(struct ifcvf_hw *hw)
 	return 0;
 }
 
-u64 ifcvf_get_vq_state(struct ifcvf_hw *hw, u16 qid)
+u16 ifcvf_get_vq_state(struct ifcvf_hw *hw, u16 qid)
 {
 	struct ifcvf_lm_cfg __iomem *ifcvf_lm;
 	void __iomem *avail_idx_addr;
@@ -287,7 +287,7 @@ u64 ifcvf_get_vq_state(struct ifcvf_hw *hw, u16 qid)
 	return last_avail_idx;
 }
 
-int ifcvf_set_vq_state(struct ifcvf_hw *hw, u16 qid, u64 num)
+int ifcvf_set_vq_state(struct ifcvf_hw *hw, u16 qid, u16 num)
 {
 	struct ifcvf_lm_cfg __iomem *ifcvf_lm;
 	void __iomem *avail_idx_addr;
diff --git a/drivers/vdpa/ifcvf/ifcvf_base.h b/drivers/vdpa/ifcvf/ifcvf_base.h
index 24af422b5a3e..08f267a2aafe 100644
--- a/drivers/vdpa/ifcvf/ifcvf_base.h
+++ b/drivers/vdpa/ifcvf/ifcvf_base.h
@@ -116,7 +116,7 @@ void ifcvf_set_status(struct ifcvf_hw *hw, u8 status);
 void io_write64_twopart(u64 val, u32 *lo, u32 *hi);
 void ifcvf_reset(struct ifcvf_hw *hw);
 u64 ifcvf_get_features(struct ifcvf_hw *hw);
-u64 ifcvf_get_vq_state(struct ifcvf_hw *hw, u16 qid);
-int ifcvf_set_vq_state(struct ifcvf_hw *hw, u16 qid, u64 num);
+u16 ifcvf_get_vq_state(struct ifcvf_hw *hw, u16 qid);
+int ifcvf_set_vq_state(struct ifcvf_hw *hw, u16 qid, u16 num);
 struct ifcvf_adapter *vf_to_adapter(struct ifcvf_hw *hw);
 #endif /* _IFCVF_H_ */
diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
index 7c93225367db..dc311e972b9e 100644
--- a/drivers/vdpa/ifcvf/ifcvf_main.c
+++ b/drivers/vdpa/ifcvf/ifcvf_main.c
@@ -237,19 +237,20 @@ static u16 ifcvf_vdpa_get_vq_num_max(struct vdpa_device *vdpa_dev)
 	return IFCVF_QUEUE_MAX;
 }
 
-static u64 ifcvf_vdpa_get_vq_state(struct vdpa_device *vdpa_dev, u16 qid)
+static void ifcvf_vdpa_get_vq_state(struct vdpa_device *vdpa_dev, u16 qid,
+				    struct vdpa_vq_state *state)
 {
 	struct ifcvf_hw *vf = vdpa_to_vf(vdpa_dev);
 
-	return ifcvf_get_vq_state(vf, qid);
+	state->avail_index = ifcvf_get_vq_state(vf, qid);
 }
 
 static int ifcvf_vdpa_set_vq_state(struct vdpa_device *vdpa_dev, u16 qid,
-				   u64 num)
+				   const struct vdpa_vq_state *state)
 {
 	struct ifcvf_hw *vf = vdpa_to_vf(vdpa_dev);
 
-	return ifcvf_set_vq_state(vf, qid, num);
+	return ifcvf_set_vq_state(vf, qid, state->avail_index);
 }
 
 static void ifcvf_vdpa_set_vq_cb(struct vdpa_device *vdpa_dev, u16 qid,
diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index 676cb2f53202..f1c351d5959b 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -450,26 +450,28 @@ static bool vdpasim_get_vq_ready(struct vdpa_device *vdpa, u16 idx)
 	return vq->ready;
 }
 
-static int vdpasim_set_vq_state(struct vdpa_device *vdpa, u16 idx, u64 state)
+static int vdpasim_set_vq_state(struct vdpa_device *vdpa, u16 idx,
+				const struct vdpa_vq_state *state)
 {
 	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
 	struct vdpasim_virtqueue *vq = &vdpasim->vqs[idx];
 	struct vringh *vrh = &vq->vring;
 
 	spin_lock(&vdpasim->lock);
-	vrh->last_avail_idx = state;
+	vrh->last_avail_idx = state->avail_index;
 	spin_unlock(&vdpasim->lock);
 
 	return 0;
 }
 
-static u64 vdpasim_get_vq_state(struct vdpa_device *vdpa, u16 idx)
+static void vdpasim_get_vq_state(struct vdpa_device *vdpa, u16 idx,
+				 struct vdpa_vq_state *state)
 {
 	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
 	struct vdpasim_virtqueue *vq = &vdpasim->vqs[idx];
 	struct vringh *vrh = &vq->vring;
 
-	return vrh->last_avail_idx;
+	state->avail_index = vrh->last_avail_idx;
 }
 
 static u32 vdpasim_get_vq_align(struct vdpa_device *vdpa)
diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 0049e34f7ca6..c2e1e2d55084 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -366,6 +366,7 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
 {
 	struct vdpa_device *vdpa = v->vdpa;
 	const struct vdpa_config_ops *ops = vdpa->config;
+	struct vdpa_vq_state vq_state;
 	struct vdpa_callback cb;
 	struct vhost_virtqueue *vq;
 	struct vhost_vring_state s;
@@ -391,7 +392,8 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
 		ops->set_vq_ready(vdpa, idx, s.num);
 		return 0;
 	case VHOST_GET_VRING_BASE:
-		vq->last_avail_idx = ops->get_vq_state(v->vdpa, idx);
+		ops->get_vq_state(v->vdpa, idx, &vq_state);
+		vq->last_avail_idx = vq_state.avail_index;
 		break;
 	case VHOST_GET_BACKEND_FEATURES:
 		features = VHOST_VDPA_BACKEND_FEATURES;
@@ -421,7 +423,8 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
 		break;
 
 	case VHOST_SET_VRING_BASE:
-		if (ops->set_vq_state(vdpa, idx, vq->last_avail_idx))
+		vq_state.avail_index = vq->last_avail_idx;
+		if (ops->set_vq_state(vdpa, idx, &vq_state))
 			r = -EINVAL;
 		break;
 
diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index 7b1e9df8fc11..8f412620071d 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -27,6 +27,14 @@ struct vdpa_notification_area {
 	resource_size_t size;
 };
 
+/**
+ * vDPA vq_state definition
+ * @avail_index: available index
+ */
+struct vdpa_vq_state {
+	u16	avail_index;
+};
+
 /**
  * vDPA device - representation of a vDPA device
  * @dev: underlying device
@@ -80,12 +88,12 @@ struct vdpa_device {
  * @set_vq_state:		Set the state for a virtqueue
  *				@vdev: vdpa device
  *				@idx: virtqueue index
- *				@state: virtqueue state (last_avail_idx)
+ *				@state: pointer to set virtqueue state (last_avail_idx)
  *				Returns integer: success (0) or error (< 0)
  * @get_vq_state:		Get the state for a virtqueue
  *				@vdev: vdpa device
  *				@idx: virtqueue index
- *				Returns virtqueue state (last_avail_idx)
+ *				@state: pointer to returned state (last_avail_idx)
  * @get_vq_notification: 	Get the notification area for a virtqueue
  *				@vdev: vdpa device
  *				@idx: virtqueue index
@@ -182,8 +190,10 @@ struct vdpa_config_ops {
 			  struct vdpa_callback *cb);
 	void (*set_vq_ready)(struct vdpa_device *vdev, u16 idx, bool ready);
 	bool (*get_vq_ready)(struct vdpa_device *vdev, u16 idx);
-	int (*set_vq_state)(struct vdpa_device *vdev, u16 idx, u64 state);
-	u64 (*get_vq_state)(struct vdpa_device *vdev, u16 idx);
+	int (*set_vq_state)(struct vdpa_device *vdev, u16 idx,
+			    const struct vdpa_vq_state *state);
+	void (*get_vq_state)(struct vdpa_device *vdev, u16 idx,
+			     struct vdpa_vq_state *state);
 	struct vdpa_notification_area
 	(*get_vq_notification)(struct vdpa_device *vdev, u16 idx);
 	int (*get_vq_irq)(struct vdpa_device *vdv, u16 idx);
-- 
2.26.0

