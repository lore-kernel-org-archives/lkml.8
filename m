Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50736C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 16:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B6DE2070A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 16:24:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729892AbgHDQYN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 12:24:13 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:43913 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729664AbgHDQU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 12:20:59 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from eli@mellanox.com)
        with SMTP; 4 Aug 2020 19:20:53 +0300
Received: from nps-server-21.mtl.labs.mlnx (nps-server-21.mtl.labs.mlnx [10.237.240.120])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 074GKrPM024053;
        Tue, 4 Aug 2020 19:20:53 +0300
Received: from nps-server-21.mtl.labs.mlnx (localhost [127.0.0.1])
        by nps-server-21.mtl.labs.mlnx (8.14.7/8.14.7) with ESMTP id 074GKrrM022649;
        Tue, 4 Aug 2020 19:20:53 +0300
Received: (from eli@localhost)
        by nps-server-21.mtl.labs.mlnx (8.14.7/8.14.7/Submit) id 074GKr0f022648;
        Tue, 4 Aug 2020 19:20:53 +0300
From:   Eli Cohen <eli@mellanox.com>
To:     mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     shahafs@mellanox.com, saeedm@mellanox.com, parav@mellanox.com,
        Eli Cohen <eli@mellanox.com>
Subject: [PATCH V4 linux-next 08/12] vdpa: Modify get_vq_state() to return error code
Date:   Tue,  4 Aug 2020 19:20:44 +0300
Message-Id: <20200804162048.22587-9-eli@mellanox.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200804162048.22587-1-eli@mellanox.com>
References: <20200804162048.22587-1-eli@mellanox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modify get_vq_state() so it returns an error code. In case of hardware
acceleration, the available index may be retrieved from the device, an
operation that can possibly fail.

Reviewed-by: Parav Pandit <parav@mellanox.com>
Signed-off-by: Eli Cohen <eli@mellanox.com>
---
 drivers/vdpa/ifcvf/ifcvf_main.c  | 5 +++--
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 5 +++--
 drivers/vhost/vdpa.c             | 5 ++++-
 include/linux/vdpa.h             | 4 ++--
 4 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
index dc311e972b9e..076d7ac5e723 100644
--- a/drivers/vdpa/ifcvf/ifcvf_main.c
+++ b/drivers/vdpa/ifcvf/ifcvf_main.c
@@ -237,12 +237,13 @@ static u16 ifcvf_vdpa_get_vq_num_max(struct vdpa_device *vdpa_dev)
 	return IFCVF_QUEUE_MAX;
 }
 
-static void ifcvf_vdpa_get_vq_state(struct vdpa_device *vdpa_dev, u16 qid,
-				    struct vdpa_vq_state *state)
+static int ifcvf_vdpa_get_vq_state(struct vdpa_device *vdpa_dev, u16 qid,
+				   struct vdpa_vq_state *state)
 {
 	struct ifcvf_hw *vf = vdpa_to_vf(vdpa_dev);
 
 	state->avail_index = ifcvf_get_vq_state(vf, qid);
+	return 0;
 }
 
 static int ifcvf_vdpa_set_vq_state(struct vdpa_device *vdpa_dev, u16 qid,
diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index f1c351d5959b..c68741363643 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -464,14 +464,15 @@ static int vdpasim_set_vq_state(struct vdpa_device *vdpa, u16 idx,
 	return 0;
 }
 
-static void vdpasim_get_vq_state(struct vdpa_device *vdpa, u16 idx,
-				 struct vdpa_vq_state *state)
+static int vdpasim_get_vq_state(struct vdpa_device *vdpa, u16 idx,
+				struct vdpa_vq_state *state)
 {
 	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
 	struct vdpasim_virtqueue *vq = &vdpasim->vqs[idx];
 	struct vringh *vrh = &vq->vring;
 
 	state->avail_index = vrh->last_avail_idx;
+	return 0;
 }
 
 static u32 vdpasim_get_vq_align(struct vdpa_device *vdpa)
diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index c2e1e2d55084..a0b7c91948e1 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -392,7 +392,10 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
 		ops->set_vq_ready(vdpa, idx, s.num);
 		return 0;
 	case VHOST_GET_VRING_BASE:
-		ops->get_vq_state(v->vdpa, idx, &vq_state);
+		r = ops->get_vq_state(v->vdpa, idx, &vq_state);
+		if (r)
+			return r;
+
 		vq->last_avail_idx = vq_state.avail_index;
 		break;
 	case VHOST_GET_BACKEND_FEATURES:
diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index 8f412620071d..fd6e560d70f9 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -192,8 +192,8 @@ struct vdpa_config_ops {
 	bool (*get_vq_ready)(struct vdpa_device *vdev, u16 idx);
 	int (*set_vq_state)(struct vdpa_device *vdev, u16 idx,
 			    const struct vdpa_vq_state *state);
-	void (*get_vq_state)(struct vdpa_device *vdev, u16 idx,
-			     struct vdpa_vq_state *state);
+	int (*get_vq_state)(struct vdpa_device *vdev, u16 idx,
+			    struct vdpa_vq_state *state);
 	struct vdpa_notification_area
 	(*get_vq_notification)(struct vdpa_device *vdev, u16 idx);
 	int (*get_vq_irq)(struct vdpa_device *vdv, u16 idx);
-- 
2.26.0

