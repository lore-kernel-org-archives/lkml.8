Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9760DC433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 11:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CC812087C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 11:47:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="pm1N9DTs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732832AbgGaLrz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 07:47:55 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:59802 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732798AbgGaLrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 07:47:51 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06VBc3YF015220;
        Fri, 31 Jul 2020 13:47:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=R5KOro9PEHr3KtnwJblpsnsouoeA3x4Np6V+4sid338=;
 b=pm1N9DTsecrZSPU3q6pNqMXkRfFmZfzRaEkintqff9YQinbT2uBrVLVfgngXacM0d4Ta
 2yfcl7TOukryQTN/0yeRhse3Z2pro+DIVhF+OdspkqOniLuJuDuqyJ52yTr3QNz9nzwI
 FT5i1kpL9svfWtqpho8Wy/rYmelzp4hp8aposBivxkaZqM8May4oEq0R0gFcjpqPLuDB
 yzlbvhyWdFhi5UgdN/4rz5x8rZveeCTG9QHe286lIGNiQ18K+9OIY3KDzyVEkHyCuvG5
 C9cyl94c7pFSmHEv3K8hiaHpGvH7k3GMQ5hplzhyRnKsdck3SrELmUs0MVCLMsyHRixN sw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 32gagvna7v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 31 Jul 2020 13:47:47 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6A45610002A;
        Fri, 31 Jul 2020 13:47:47 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5F764221061;
        Fri, 31 Jul 2020 13:47:47 +0200 (CEST)
Received: from localhost (10.75.127.45) by SFHDAG3NODE1.st.com (10.75.127.7)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 31 Jul 2020 13:47:46
 +0200
From:   Arnaud Pouliquen <arnaud.pouliquen@st.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <arnaud.pouliquen@st.com>
Subject: [PATCH 6/9] rpmsg: virtio: use rpmsg ns device for the ns announcement
Date:   Fri, 31 Jul 2020 13:47:29 +0200
Message-ID: <20200731114732.12815-7-arnaud.pouliquen@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200731114732.12815-1-arnaud.pouliquen@st.com>
References: <20200731114732.12815-1-arnaud.pouliquen@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG3NODE1.st.com (10.75.127.7) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-31_04:2020-07-31,2020-07-31 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As generic NS driver is available, rely on it for NS management instead of
managing it in RPMsg virtio bus.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 drivers/rpmsg/Kconfig            |  1 +
 drivers/rpmsg/virtio_rpmsg_bus.c | 86 ++++++++------------------------
 2 files changed, 21 insertions(+), 66 deletions(-)

diff --git a/drivers/rpmsg/Kconfig b/drivers/rpmsg/Kconfig
index 140faa975ea1..0143c9864c45 100644
--- a/drivers/rpmsg/Kconfig
+++ b/drivers/rpmsg/Kconfig
@@ -71,5 +71,6 @@ config RPMSG_VIRTIO
 	depends on HAS_DMA
 	select RPMSG
 	select VIRTIO
+	select RPMSG_NS
 
 endmenu
diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
index b2927661868c..f771fdae150e 100644
--- a/drivers/rpmsg/virtio_rpmsg_bus.c
+++ b/drivers/rpmsg/virtio_rpmsg_bus.c
@@ -48,7 +48,6 @@
  * @endpoints_lock: lock of the endpoints set
  * @sendq:	wait queue of sending contexts waiting for a tx buffers
  * @sleepers:	number of senders that are waiting for a tx buffer
- * @ns_ept:	the bus's name service endpoint
  *
  * This structure stores the rpmsg state of a given virtio remote processor
  * device (there might be several virtio proc devices for each physical
@@ -67,7 +66,6 @@ struct virtproc_info {
 	struct mutex endpoints_lock;
 	wait_queue_head_t sendq;
 	atomic_t sleepers;
-	struct rpmsg_endpoint *ns_ept;
 };
 
 /* The feature bitmap for virtio rpmsg */
@@ -841,68 +839,14 @@ static void rpmsg_xmit_done(struct virtqueue *svq)
 	wake_up_interruptible(&vrp->sendq);
 }
 
-/* invoked when a name service announcement arrives */
-static int rpmsg_ns_cb(struct rpmsg_device *rpdev, void *data, int len,
-		       void *priv, u32 src)
-{
-	struct rpmsg_ns_msg *msg = data;
-	struct rpmsg_device *newch;
-	struct rpmsg_channel_info chinfo;
-	struct virtproc_info *vrp = priv;
-	struct device *dev = &vrp->vdev->dev;
-	int ret;
-
-#if defined(CONFIG_DYNAMIC_DEBUG)
-	dynamic_hex_dump("NS announcement: ", DUMP_PREFIX_NONE, 16, 1,
-			 data, len, true);
-#endif
-
-	if (len != sizeof(*msg)) {
-		dev_err(dev, "malformed ns msg (%d)\n", len);
-		return -EINVAL;
-	}
-
-	/*
-	 * the name service ept does _not_ belong to a real rpmsg channel,
-	 * and is handled by the rpmsg bus itself.
-	 * for sanity reasons, make sure a valid rpdev has _not_ sneaked
-	 * in somehow.
-	 */
-	if (rpdev) {
-		dev_err(dev, "anomaly: ns ept has an rpdev handle\n");
-		return -EINVAL;
-	}
-
-	/* don't trust the remote processor for null terminating the name */
-	msg->name[RPMSG_NAME_SIZE - 1] = '\0';
-
-	strncpy(chinfo.name, msg->name, sizeof(chinfo.name));
-	chinfo.src = RPMSG_ADDR_ANY;
-	chinfo.dst = virtio32_to_cpu(vrp->vdev, msg->addr);
-
-	dev_info(dev, "%sing channel %s addr 0x%x\n",
-		 virtio32_to_cpu(vrp->vdev, msg->flags) & RPMSG_NS_DESTROY ?
-		 "destroy" : "creat", msg->name, chinfo.dst);
-
-	if (virtio32_to_cpu(vrp->vdev, msg->flags) & RPMSG_NS_DESTROY) {
-		ret = rpmsg_unregister_device(&vrp->vdev->dev, &chinfo);
-		if (ret)
-			dev_err(dev, "rpmsg_destroy_channel failed: %d\n", ret);
-	} else {
-		newch = __rpmsg_create_channel(vrp, &chinfo);
-		if (!newch)
-			dev_err(dev, "rpmsg_create_channel failed\n");
-	}
-
-	return 0;
-}
-
 static int rpmsg_probe(struct virtio_device *vdev)
 {
 	vq_callback_t *vq_cbs[] = { rpmsg_recv_done, rpmsg_xmit_done };
 	static const char * const names[] = { "input", "output" };
 	struct virtqueue *vqs[2];
 	struct virtproc_info *vrp;
+	struct virtio_rpmsg_channel *vch;
+	struct rpmsg_device *rpdev_ns;
 	void *bufs_va;
 	int err = 0, i;
 	size_t total_buf_space;
@@ -978,14 +922,27 @@ static int rpmsg_probe(struct virtio_device *vdev)
 
 	/* if supported by the remote processor, enable the name service */
 	if (virtio_has_feature(vdev, VIRTIO_RPMSG_F_NS)) {
-		/* a dedicated endpoint handles the name service msgs */
-		vrp->ns_ept = __rpmsg_create_ept(vrp, NULL, rpmsg_ns_cb,
-						vrp, RPMSG_NS_ADDR);
-		if (!vrp->ns_ept) {
-			dev_err(&vdev->dev, "failed to create the ns ept\n");
+		vch = kzalloc(sizeof(*vch), GFP_KERNEL);
+		if (!vch) {
 			err = -ENOMEM;
 			goto free_coherent;
 		}
+
+		/* Link the channel to our vrp */
+		vch->vrp = vrp;
+
+		/* Assign public information to the rpmsg_device */
+		rpdev_ns = &vch->rpdev;
+		rpdev_ns->ops = &virtio_rpmsg_ops;
+
+		rpdev_ns->dev.parent = &vrp->vdev->dev;
+		rpdev_ns->dev.release = virtio_rpmsg_release_device;
+
+		err = rpmsg_ns_register_device(rpdev_ns);
+		if (err) {
+			kfree(vch);
+			goto free_coherent;
+		}
 	}
 
 	/*
@@ -1038,9 +995,6 @@ static void rpmsg_remove(struct virtio_device *vdev)
 	if (ret)
 		dev_warn(&vdev->dev, "can't remove rpmsg device: %d\n", ret);
 
-	if (vrp->ns_ept)
-		__rpmsg_destroy_ept(vrp, vrp->ns_ept);
-
 	idr_destroy(&vrp->endpoints);
 
 	vdev->config->del_vqs(vrp->vdev);
-- 
2.17.1

