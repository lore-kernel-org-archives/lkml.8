Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4CDDC433F2
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 06:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C72B722B45
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 06:06:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbgG1GGG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 02:06:06 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:34834 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726299AbgG1GGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 02:06:06 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from eli@mellanox.com)
        with SMTP; 28 Jul 2020 09:06:02 +0300
Received: from nps-server-21.mtl.labs.mlnx (nps-server-21.mtl.labs.mlnx [10.237.240.120])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 06S662T9016728;
        Tue, 28 Jul 2020 09:06:02 +0300
Received: from nps-server-21.mtl.labs.mlnx (localhost [127.0.0.1])
        by nps-server-21.mtl.labs.mlnx (8.14.7/8.14.7) with ESMTP id 06S662Tp004224;
        Tue, 28 Jul 2020 09:06:02 +0300
Received: (from eli@localhost)
        by nps-server-21.mtl.labs.mlnx (8.14.7/8.14.7/Submit) id 06S662oI004223;
        Tue, 28 Jul 2020 09:06:02 +0300
From:   Eli Cohen <eli@mellanox.com>
To:     mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     shahafs@mellanox.com, saeedm@mellanox.com, parav@mellanox.com
Subject: [PATCH V3 vhost next 02/10] vdpa_sim: use the batching API
Date:   Tue, 28 Jul 2020 09:05:31 +0300
Message-Id: <20200728060539.4163-3-eli@mellanox.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200728060539.4163-1-eli@mellanox.com>
References: <20200728060539.4163-1-eli@mellanox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jason Wang <jasowang@redhat.com>

Change-Id: I3751f1aecce285e0f61530c69616852d49e5f547
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 20 --------------------
 drivers/vhost/vdpa.c             |  1 -
 2 files changed, 21 deletions(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index c7334cc65bb2..82d1068af3ef 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -548,24 +548,6 @@ static int vdpasim_set_map(struct vdpa_device *vdpa,
 	return ret;
 }
 
-static int vdpasim_dma_map(struct vdpa_device *vdpa, u64 iova, u64 size,
-			   u64 pa, u32 perm)
-{
-	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
-
-	return vhost_iotlb_add_range(vdpasim->iommu, iova,
-				     iova + size - 1, pa, perm);
-}
-
-static int vdpasim_dma_unmap(struct vdpa_device *vdpa, u64 iova, u64 size)
-{
-	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
-
-	vhost_iotlb_del_range(vdpasim->iommu, iova, iova + size - 1);
-
-	return 0;
-}
-
 static void vdpasim_free(struct vdpa_device *vdpa)
 {
 	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
@@ -598,8 +580,6 @@ static const struct vdpa_config_ops vdpasim_net_config_ops = {
 	.set_config             = vdpasim_set_config,
 	.get_generation         = vdpasim_get_generation,
 	.set_map                = vdpasim_set_map,
-	.dma_map                = vdpasim_dma_map,
-	.dma_unmap              = vdpasim_dma_unmap,
 	.free                   = vdpasim_free,
 };
 
diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 8827ae31f96d..65195b30133b 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -533,7 +533,6 @@ static int vhost_vdpa_map(struct vhost_vdpa *v,
 
 static void vhost_vdpa_unmap(struct vhost_vdpa *v, u64 iova, u64 size)
 {
-	struct vhost_dev *dev = &v->vdev;
 	struct vdpa_device *vdpa = v->vdpa;
 	const struct vdpa_config_ops *ops = vdpa->config;
 
-- 
2.26.0

