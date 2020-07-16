Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58AFEC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 07:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33C262067D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 07:24:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728352AbgGPHXm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 03:23:42 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:60002 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728326AbgGPHXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 03:23:41 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from eli@mellanox.com)
        with SMTP; 16 Jul 2020 10:23:36 +0300
Received: from nps-server-21.mtl.labs.mlnx (nps-server-21.mtl.labs.mlnx [10.237.240.120])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 06G7Na3n006472;
        Thu, 16 Jul 2020 10:23:36 +0300
Received: from nps-server-21.mtl.labs.mlnx (localhost [127.0.0.1])
        by nps-server-21.mtl.labs.mlnx (8.14.7/8.14.7) with ESMTP id 06G7Na65005422;
        Thu, 16 Jul 2020 10:23:36 +0300
Received: (from eli@localhost)
        by nps-server-21.mtl.labs.mlnx (8.14.7/8.14.7/Submit) id 06G7Naxj005421;
        Thu, 16 Jul 2020 10:23:36 +0300
From:   Eli Cohen <eli@mellanox.com>
To:     mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     shahafs@mellanox.com, saeedm@mellanox.com,
        Eli Cohen <eli@mellanox.com>, Parav Pandit <parav@mellanox.com>
Subject: [PATCH vhost next 06/10] vdpa: Add means to communicate vq status on get_vq_state
Date:   Thu, 16 Jul 2020 10:23:23 +0300
Message-Id: <20200716072327.5359-7-eli@mellanox.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200716072327.5359-1-eli@mellanox.com>
References: <20200716072327.5359-1-eli@mellanox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, get_vq_state() is used only to pass the available index value
of a vq. Extend the struct to return status on the VQ to the caller.
For now, define VQ_STATE_NOT_READY. In the future it will be extended to
include other infomration.

Modify current vdpa driver to update this field.

Reviewed-by: Parav Pandit <parav@mellanox.com>
Signed-off-by: Eli Cohen <eli@mellanox.com>
---
 drivers/vdpa/ifcvf/ifcvf_main.c  | 1 +
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 1 +
 include/linux/vdpa.h             | 9 +++++++++
 3 files changed, 11 insertions(+)

diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
index 69032ee97824..77e3b3d91167 100644
--- a/drivers/vdpa/ifcvf/ifcvf_main.c
+++ b/drivers/vdpa/ifcvf/ifcvf_main.c
@@ -240,6 +240,7 @@ static void ifcvf_vdpa_get_vq_state(struct vdpa_device *vdpa_dev, u16 qid,
 {
 	struct ifcvf_hw *vf = vdpa_to_vf(vdpa_dev);
 
+	state->state = vf->vring[qid].ready ? 0 : BIT(VQ_STATE_NOT_READY);
 	state->avail_index = ifcvf_get_vq_state(vf, qid);
 }
 
diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index 599519039f8d..06d974b4bd7b 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -434,6 +434,7 @@ static void vdpasim_get_vq_state(struct vdpa_device *vdpa, u16 idx,
 	struct vdpasim_virtqueue *vq = &vdpasim->vqs[idx];
 	struct vringh *vrh = &vq->vring;
 
+	state->state = vq->ready ? 0 : BIT(VQ_STATE_NOT_READY);
 	state->avail_index = vrh->last_avail_idx;
 }
 
diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index 7b088bebffe8..bcefa30a3b2f 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -27,12 +27,21 @@ struct vdpa_notification_area {
 	resource_size_t size;
 };
 
+/**
+ * Bitmask describing the status of the vq
+ */
+enum {
+	VQ_STATE_NOT_READY = 0,
+};
+
 /**
  * vDPA vq_state definition
  * @avail_index: available index
+ * @state: returned status from get_vq_state
  */
 struct vdpa_vq_state {
 	u16	avail_index;
+	u32	state;
 };
 
 /**
-- 
2.27.0

