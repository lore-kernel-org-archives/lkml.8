Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F7AC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 16:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 766642177B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 16:22:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729776AbgHDQWX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 12:22:23 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:43897 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729620AbgHDQU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 12:20:59 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from eli@mellanox.com)
        with SMTP; 4 Aug 2020 19:20:53 +0300
Received: from nps-server-21.mtl.labs.mlnx (nps-server-21.mtl.labs.mlnx [10.237.240.120])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 074GKrLj024046;
        Tue, 4 Aug 2020 19:20:53 +0300
Received: from nps-server-21.mtl.labs.mlnx (localhost [127.0.0.1])
        by nps-server-21.mtl.labs.mlnx (8.14.7/8.14.7) with ESMTP id 074GKrAk022645;
        Tue, 4 Aug 2020 19:20:53 +0300
Received: (from eli@localhost)
        by nps-server-21.mtl.labs.mlnx (8.14.7/8.14.7/Submit) id 074GKrqM022644;
        Tue, 4 Aug 2020 19:20:53 +0300
From:   Eli Cohen <eli@mellanox.com>
To:     mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     shahafs@mellanox.com, saeedm@mellanox.com, parav@mellanox.com,
        Max Gurtovoy <maxg@mellanox.com>
Subject: [PATCH V4 linux-next 06/12] vdpa: remove hard coded virtq num
Date:   Tue,  4 Aug 2020 19:20:42 +0300
Message-Id: <20200804162048.22587-7-eli@mellanox.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200804162048.22587-1-eli@mellanox.com>
References: <20200804162048.22587-1-eli@mellanox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Max Gurtovoy <maxg@mellanox.com>

This will enable vdpa providers to add support for multi queue feature
and publish it to upper layers (vhost and virtio).

Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
Reviewed-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vdpa/ifcvf/ifcvf_main.c  | 3 ++-
 drivers/vdpa/vdpa.c              | 3 +++
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 4 ++--
 drivers/vhost/vdpa.c             | 9 +++------
 include/linux/vdpa.h             | 6 ++++--
 5 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
index a902b29b0d29..7c93225367db 100644
--- a/drivers/vdpa/ifcvf/ifcvf_main.c
+++ b/drivers/vdpa/ifcvf/ifcvf_main.c
@@ -431,7 +431,8 @@ static int ifcvf_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	}
 
 	adapter = vdpa_alloc_device(struct ifcvf_adapter, vdpa,
-				    dev, &ifc_vdpa_ops);
+				    dev, &ifc_vdpa_ops,
+				    IFCVF_MAX_QUEUE_PAIRS * 2);
 	if (adapter == NULL) {
 		IFCVF_ERR(pdev, "Failed to allocate vDPA structure");
 		return -ENOMEM;
diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index 7105265e4793..a69ffc991e13 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -61,6 +61,7 @@ static void vdpa_release_dev(struct device *d)
  * initialized but before registered.
  * @parent: the parent device
  * @config: the bus operations that is supported by this device
+ * @nvqs: number of virtqueues supported by this device
  * @size: size of the parent structure that contains private data
  *
  * Driver should use vdpa_alloc_device() wrapper macro instead of
@@ -71,6 +72,7 @@ static void vdpa_release_dev(struct device *d)
  */
 struct vdpa_device *__vdpa_alloc_device(struct device *parent,
 					const struct vdpa_config_ops *config,
+					int nvqs,
 					size_t size)
 {
 	struct vdpa_device *vdev;
@@ -97,6 +99,7 @@ struct vdpa_device *__vdpa_alloc_device(struct device *parent,
 	vdev->index = err;
 	vdev->config = config;
 	vdev->features_valid = false;
+	vdev->nvqs = nvqs;
 
 	err = dev_set_name(&vdev->dev, "vdpa%u", vdev->index);
 	if (err)
diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index 07ded545197d..676cb2f53202 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -65,7 +65,7 @@ static u64 vdpasim_features = (1ULL << VIRTIO_F_ANY_LAYOUT) |
 /* State of each vdpasim device */
 struct vdpasim {
 	struct vdpa_device vdpa;
-	struct vdpasim_virtqueue vqs[2];
+	struct vdpasim_virtqueue vqs[VDPASIM_VQ_NUM];
 	struct work_struct work;
 	/* spinlock to synchronize virtqueue state */
 	spinlock_t lock;
@@ -352,7 +352,7 @@ static struct vdpasim *vdpasim_create(void)
 	else
 		ops = &vdpasim_net_config_ops;
 
-	vdpasim = vdpa_alloc_device(struct vdpasim, vdpa, NULL, ops);
+	vdpasim = vdpa_alloc_device(struct vdpasim, vdpa, NULL, ops, VDPASIM_VQ_NUM);
 	if (!vdpasim)
 		goto err_alloc;
 
diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 0a143615e69d..0049e34f7ca6 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -32,9 +32,6 @@ enum {
 	(1ULL << VHOST_BACKEND_F_IOTLB_BATCH),
 };
 
-/* Currently, only network backend w/o multiqueue is supported. */
-#define VHOST_VDPA_VQ_MAX	2
-
 #define VHOST_VDPA_DEV_MAX (1U << MINORBITS)
 
 struct vhost_vdpa {
@@ -947,7 +944,7 @@ static int vhost_vdpa_probe(struct vdpa_device *vdpa)
 {
 	const struct vdpa_config_ops *ops = vdpa->config;
 	struct vhost_vdpa *v;
-	int minor, nvqs = VHOST_VDPA_VQ_MAX;
+	int minor;
 	int r;
 
 	/* Currently, we only accept the network devices. */
@@ -968,14 +965,14 @@ static int vhost_vdpa_probe(struct vdpa_device *vdpa)
 	atomic_set(&v->opened, 0);
 	v->minor = minor;
 	v->vdpa = vdpa;
-	v->nvqs = nvqs;
+	v->nvqs = vdpa->nvqs;
 	v->virtio_id = ops->get_device_id(vdpa);
 
 	device_initialize(&v->dev);
 	v->dev.release = vhost_vdpa_release_dev;
 	v->dev.parent = &vdpa->dev;
 	v->dev.devt = MKDEV(MAJOR(vhost_vdpa_major), minor);
-	v->vqs = kmalloc_array(nvqs, sizeof(struct vhost_virtqueue),
+	v->vqs = kmalloc_array(v->nvqs, sizeof(struct vhost_virtqueue),
 			       GFP_KERNEL);
 	if (!v->vqs) {
 		r = -ENOMEM;
diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index 9f50af7dc4a1..7b1e9df8fc11 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -41,6 +41,7 @@ struct vdpa_device {
 	const struct vdpa_config_ops *config;
 	unsigned int index;
 	bool features_valid;
+	int nvqs;
 };
 
 /**
@@ -216,11 +217,12 @@ struct vdpa_config_ops {
 
 struct vdpa_device *__vdpa_alloc_device(struct device *parent,
 					const struct vdpa_config_ops *config,
+					int nvqs,
 					size_t size);
 
-#define vdpa_alloc_device(dev_struct, member, parent, config)   \
+#define vdpa_alloc_device(dev_struct, member, parent, config, nvqs)   \
 			  container_of(__vdpa_alloc_device( \
-				       parent, config, \
+				       parent, config, nvqs, \
 				       sizeof(dev_struct) + \
 				       BUILD_BUG_ON_ZERO(offsetof( \
 				       dev_struct, member))), \
-- 
2.26.0

