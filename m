Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58EAFC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 16:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44B302070A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 16:22:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729806AbgHDQWw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 12:22:52 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:43896 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729632AbgHDQVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 12:21:00 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from eli@mellanox.com)
        with SMTP; 4 Aug 2020 19:20:53 +0300
Received: from nps-server-21.mtl.labs.mlnx (nps-server-21.mtl.labs.mlnx [10.237.240.120])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 074GKq9h024042;
        Tue, 4 Aug 2020 19:20:52 +0300
Received: from nps-server-21.mtl.labs.mlnx (localhost [127.0.0.1])
        by nps-server-21.mtl.labs.mlnx (8.14.7/8.14.7) with ESMTP id 074GKq7r022643;
        Tue, 4 Aug 2020 19:20:52 +0300
Received: (from eli@localhost)
        by nps-server-21.mtl.labs.mlnx (8.14.7/8.14.7/Submit) id 074GKqgm022642;
        Tue, 4 Aug 2020 19:20:52 +0300
From:   Eli Cohen <eli@mellanox.com>
To:     mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     shahafs@mellanox.com, saeedm@mellanox.com, parav@mellanox.com
Subject: [PATCH V4 linux-next 05/12] vdpasim: support batch updating
Date:   Tue,  4 Aug 2020 19:20:41 +0300
Message-Id: <20200804162048.22587-6-eli@mellanox.com>
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

The vDPA simulator support both set_map() and dma_map()/dma_unmap()
operations. But vhost-vdpa can only use one of them. So this patch
introduce a module parameter (batch_mapping) that let vpda_sim to
support only one of those dma operations. The batched mapping via
set_map() is enabled by default.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 40 +++++++++++++++++++++++++++++---
 1 file changed, 37 insertions(+), 3 deletions(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index 13febedd73ee..07ded545197d 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -34,6 +34,10 @@
 #define DRV_DESC     "vDPA Device Simulator"
 #define DRV_LICENSE  "GPL v2"
 
+static int batch_mapping = 1;
+module_param(batch_mapping, int, 0444);
+MODULE_PARM_DESC(batch_mapping, "Batched mapping 1 -Enable; 0 - Disable");
+
 struct vdpasim_virtqueue {
 	struct vringh vring;
 	struct vringh_kiov iov;
@@ -334,15 +338,21 @@ static const struct dma_map_ops vdpasim_dma_ops = {
 };
 
 static const struct vdpa_config_ops vdpasim_net_config_ops;
+static const struct vdpa_config_ops vdpasim_net_batch_config_ops;
 
 static struct vdpasim *vdpasim_create(void)
 {
+	const struct vdpa_config_ops *ops;
 	struct vdpasim *vdpasim;
 	struct device *dev;
 	int ret = -ENOMEM;
 
-	vdpasim = vdpa_alloc_device(struct vdpasim, vdpa, NULL,
-				    &vdpasim_net_config_ops);
+	if (batch_mapping)
+		ops = &vdpasim_net_batch_config_ops;
+	else
+		ops = &vdpasim_net_config_ops;
+
+	vdpasim = vdpa_alloc_device(struct vdpasim, vdpa, NULL, ops);
 	if (!vdpasim)
 		goto err_alloc;
 
@@ -641,12 +651,36 @@ static const struct vdpa_config_ops vdpasim_net_config_ops = {
 	.get_config             = vdpasim_get_config,
 	.set_config             = vdpasim_set_config,
 	.get_generation         = vdpasim_get_generation,
-	.set_map                = vdpasim_set_map,
 	.dma_map                = vdpasim_dma_map,
 	.dma_unmap              = vdpasim_dma_unmap,
 	.free                   = vdpasim_free,
 };
 
+static const struct vdpa_config_ops vdpasim_net_batch_config_ops = {
+	.set_vq_address         = vdpasim_set_vq_address,
+	.set_vq_num             = vdpasim_set_vq_num,
+	.kick_vq                = vdpasim_kick_vq,
+	.set_vq_cb              = vdpasim_set_vq_cb,
+	.set_vq_ready           = vdpasim_set_vq_ready,
+	.get_vq_ready           = vdpasim_get_vq_ready,
+	.set_vq_state           = vdpasim_set_vq_state,
+	.get_vq_state           = vdpasim_get_vq_state,
+	.get_vq_align           = vdpasim_get_vq_align,
+	.get_features           = vdpasim_get_features,
+	.set_features           = vdpasim_set_features,
+	.set_config_cb          = vdpasim_set_config_cb,
+	.get_vq_num_max         = vdpasim_get_vq_num_max,
+	.get_device_id          = vdpasim_get_device_id,
+	.get_vendor_id          = vdpasim_get_vendor_id,
+	.get_status             = vdpasim_get_status,
+	.set_status             = vdpasim_set_status,
+	.get_config             = vdpasim_get_config,
+	.set_config             = vdpasim_set_config,
+	.get_generation         = vdpasim_get_generation,
+	.set_map                = vdpasim_set_map,
+	.free                   = vdpasim_free,
+};
+
 static int __init vdpasim_dev_init(void)
 {
 	vdpasim_dev = vdpasim_create();
-- 
2.26.0

