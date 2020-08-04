Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47673C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 16:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3211C208A9
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 16:22:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729768AbgHDQV6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 12:21:58 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:43880 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729612AbgHDQU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 12:20:58 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from eli@mellanox.com)
        with SMTP; 4 Aug 2020 19:20:52 +0300
Received: from nps-server-21.mtl.labs.mlnx (nps-server-21.mtl.labs.mlnx [10.237.240.120])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 074GKqMD024001;
        Tue, 4 Aug 2020 19:20:52 +0300
Received: from nps-server-21.mtl.labs.mlnx (localhost [127.0.0.1])
        by nps-server-21.mtl.labs.mlnx (8.14.7/8.14.7) with ESMTP id 074GKqcp022638;
        Tue, 4 Aug 2020 19:20:52 +0300
Received: (from eli@localhost)
        by nps-server-21.mtl.labs.mlnx (8.14.7/8.14.7/Submit) id 074GKq3H022637;
        Tue, 4 Aug 2020 19:20:52 +0300
From:   Eli Cohen <eli@mellanox.com>
To:     mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     shahafs@mellanox.com, saeedm@mellanox.com, parav@mellanox.com,
        Cindy Lu <lulu@redhat.com>
Subject: [PATCH V4 linux-next 03/12] vhost-vdpa: support get/set backend features
Date:   Tue,  4 Aug 2020 19:20:39 +0300
Message-Id: <20200804162048.22587-4-eli@mellanox.com>
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

This patch makes userspace can get and set backend features to
vhost-vdpa.

Signed-off-by: Cindy Lu <lulu@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/vdpa.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 563ae6204052..2f0310d1b914 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -26,6 +26,10 @@
 
 #include "vhost.h"
 
+enum {
+	VHOST_VDPA_BACKEND_FEATURES = (1ULL << VHOST_BACKEND_F_IOTLB_MSG_V2)
+};
+
 /* Currently, only network backend w/o multiqueue is supported. */
 #define VHOST_VDPA_VQ_MAX	2
 
@@ -364,6 +368,8 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
 	struct vdpa_callback cb;
 	struct vhost_virtqueue *vq;
 	struct vhost_vring_state s;
+	u64 __user *featurep = argp;
+	u64 features;
 	u32 idx;
 	long r;
 
@@ -386,6 +392,18 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
 	case VHOST_GET_VRING_BASE:
 		vq->last_avail_idx = ops->get_vq_state(v->vdpa, idx);
 		break;
+	case VHOST_GET_BACKEND_FEATURES:
+		features = VHOST_VDPA_BACKEND_FEATURES;
+		if (copy_to_user(featurep, &features, sizeof(features)))
+			return -EFAULT;
+		return 0;
+	case VHOST_SET_BACKEND_FEATURES:
+		if (copy_from_user(&features, featurep, sizeof(features)))
+			return -EFAULT;
+		if (features & ~VHOST_VDPA_BACKEND_FEATURES)
+			return -EOPNOTSUPP;
+		vhost_set_backend_features(&v->vdev, features);
+		return 0;
 	}
 
 	r = vhost_vring_ioctl(&v->vdev, cmd, argp);
-- 
2.26.0

