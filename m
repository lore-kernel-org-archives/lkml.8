Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04071C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 11:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D14762245C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 11:47:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="He5apUmU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732844AbgGaLr5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 07:47:57 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:34160 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732807AbgGaLrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 07:47:53 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06VBaYT5031440;
        Fri, 31 Jul 2020 13:47:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=u6EYUC0xcRE70s9suBWPO0FSC0+bERZDODPG0q9BHrI=;
 b=He5apUmU+Xbcje+QBUCFXyf9F00NdJA/f/2l3jPhj+P9mZVmhYbl0om32MWcgp5e/lxq
 fFPDxCGh6+1ceh+0cuvQNVEsoOR++L5latWahTk5CjzFJ7tbNs6xGKG/cCic3Os295b8
 OMqwM7VBBJXAhsOoUtsFtCrQyaXujULGyNaLAtdugbaLwMlrZrkw+vC5NCXg9309+FD3
 I4/xctQmyXrLBY4npscI860XCJq9YAjpoQ0OtQiMEZvvHQxQdLVLYVu9K8WN0HbmJaSC
 K3u2WoNIbHaxgHi9dzsW+/V5+8S8EYNmLyPcVP4VQoEKmCSoVQ+kbwbg00XSdOGPwwwh Ng== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 32gbmgp66u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 31 Jul 2020 13:47:50 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B70A610002A;
        Fri, 31 Jul 2020 13:47:49 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id ABD9E2A7A83;
        Fri, 31 Jul 2020 13:47:49 +0200 (CEST)
Received: from localhost (10.75.127.45) by SFHDAG3NODE1.st.com (10.75.127.7)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 31 Jul 2020 13:47:49
 +0200
From:   Arnaud Pouliquen <arnaud.pouliquen@st.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <arnaud.pouliquen@st.com>
Subject: [PATCH 8/9] rpmsg: virtio: use rpmsg_ns driver to manage ns announcement
Date:   Fri, 31 Jul 2020 13:47:31 +0200
Message-ID: <20200731114732.12815-9-arnaud.pouliquen@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200731114732.12815-1-arnaud.pouliquen@st.com>
References: <20200731114732.12815-1-arnaud.pouliquen@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG7NODE3.st.com (10.75.127.21) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-31_04:2020-07-31,2020-07-31 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new rpmsg_ns API to send the name service announcements if
the VIRTIO_RPMSG_F_NS is set, else just not implement the ops.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 drivers/rpmsg/virtio_rpmsg_bus.c | 94 +++++---------------------------
 1 file changed, 13 insertions(+), 81 deletions(-)

diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
index f771fdae150e..3c771a6392be 100644
--- a/drivers/rpmsg/virtio_rpmsg_bus.c
+++ b/drivers/rpmsg/virtio_rpmsg_bus.c
@@ -91,35 +91,6 @@ struct rpmsg_hdr {
 	u8 data[];
 } __packed;
 
-/**
- * struct rpmsg_ns_msg - dynamic name service announcement message
- * @name: name of remote service that is published
- * @addr: address of remote service that is published
- * @flags: indicates whether service is created or destroyed
- *
- * This message is sent across to publish a new service, or announce
- * about its removal. When we receive these messages, an appropriate
- * rpmsg channel (i.e device) is created/destroyed. In turn, the ->probe()
- * or ->remove() handler of the appropriate rpmsg driver will be invoked
- * (if/as-soon-as one is registered).
- */
-struct rpmsg_ns_msg {
-	char name[RPMSG_NAME_SIZE];
-	__virtio32 addr;
-	__virtio32 flags;
-} __packed;
-
-/**
- * enum rpmsg_ns_flags - dynamic name service announcement flags
- *
- * @RPMSG_NS_CREATE: a new remote service was just created
- * @RPMSG_NS_DESTROY: a known remote service was just destroyed
- */
-enum rpmsg_ns_flags {
-	RPMSG_NS_CREATE		= 0,
-	RPMSG_NS_DESTROY	= 1,
-};
-
 /**
  * @vrp: the remote processor this channel belongs to
  */
@@ -324,60 +295,18 @@ static void virtio_rpmsg_destroy_ept(struct rpmsg_endpoint *ept)
 	__rpmsg_destroy_ept(vch->vrp, ept);
 }
 
-static int virtio_rpmsg_announce_create(struct rpmsg_device *rpdev)
-{
-	struct virtio_rpmsg_channel *vch = to_virtio_rpmsg_channel(rpdev);
-	struct virtproc_info *vrp = vch->vrp;
-	struct device *dev = &rpdev->dev;
-	int err = 0;
-
-	/* need to tell remote processor's name service about this channel ? */
-	if (rpdev->announce && rpdev->ept &&
-	    virtio_has_feature(vrp->vdev, VIRTIO_RPMSG_F_NS)) {
-		struct rpmsg_ns_msg nsm;
-
-		strncpy(nsm.name, rpdev->id.name, RPMSG_NAME_SIZE);
-		nsm.addr = cpu_to_virtio32(vrp->vdev, rpdev->ept->addr);
-		nsm.flags = cpu_to_virtio32(vrp->vdev, RPMSG_NS_CREATE);
-
-		err = rpmsg_sendto(rpdev->ept, &nsm, sizeof(nsm), RPMSG_NS_ADDR);
-		if (err)
-			dev_err(dev, "failed to announce service %d\n", err);
-	}
-
-	return err;
-}
-
-static int virtio_rpmsg_announce_destroy(struct rpmsg_device *rpdev)
-{
-	struct virtio_rpmsg_channel *vch = to_virtio_rpmsg_channel(rpdev);
-	struct virtproc_info *vrp = vch->vrp;
-	struct device *dev = &rpdev->dev;
-	int err = 0;
-
-	/* tell remote processor's name service we're removing this channel */
-	if (rpdev->announce && rpdev->ept &&
-	    virtio_has_feature(vrp->vdev, VIRTIO_RPMSG_F_NS)) {
-		struct rpmsg_ns_msg nsm;
-
-		strncpy(nsm.name, rpdev->id.name, RPMSG_NAME_SIZE);
-		nsm.addr = cpu_to_virtio32(vrp->vdev, rpdev->ept->addr);
-		nsm.flags = cpu_to_virtio32(vrp->vdev, RPMSG_NS_DESTROY);
-
-		err = rpmsg_sendto(rpdev->ept, &nsm, sizeof(nsm), RPMSG_NS_ADDR);
-		if (err)
-			dev_err(dev, "failed to announce service %d\n", err);
-	}
-
-	return err;
-}
-
 static const struct rpmsg_device_ops virtio_rpmsg_ops = {
 	.create_channel = virtio_rpmsg_create_channel,
 	.release_channel = virtio_rpmsg_release_channel,
 	.create_ept = virtio_rpmsg_create_ept,
-	.announce_create = virtio_rpmsg_announce_create,
-	.announce_destroy = virtio_rpmsg_announce_destroy,
+};
+
+static const struct rpmsg_device_ops virtio_rpmsg_w_nsa_ops = {
+	.create_channel = virtio_rpmsg_create_channel,
+	.release_channel = virtio_rpmsg_release_channel,
+	.create_ept = virtio_rpmsg_create_ept,
+	.announce_create = rpmsg_ns_announce_create,
+	.announce_destroy = rpmsg_ns_announce_destroy,
 };
 
 static void virtio_rpmsg_release_device(struct device *dev)
@@ -423,7 +352,10 @@ __rpmsg_create_channel(struct virtproc_info *vrp,
 	rpdev = &vch->rpdev;
 	rpdev->src = chinfo->src;
 	rpdev->dst = chinfo->dst;
-	rpdev->ops = &virtio_rpmsg_ops;
+	if (virtio_has_feature(vrp->vdev, VIRTIO_RPMSG_F_NS))
+		rpdev->ops = &virtio_rpmsg_w_nsa_ops;
+	else
+		rpdev->ops = &virtio_rpmsg_ops;
 
 	/*
 	 * rpmsg server channels has predefined local address (for now),
@@ -933,7 +865,7 @@ static int rpmsg_probe(struct virtio_device *vdev)
 
 		/* Assign public information to the rpmsg_device */
 		rpdev_ns = &vch->rpdev;
-		rpdev_ns->ops = &virtio_rpmsg_ops;
+		rpdev_ns->ops = &virtio_rpmsg_w_nsa_ops;
 
 		rpdev_ns->dev.parent = &vrp->vdev->dev;
 		rpdev_ns->dev.release = virtio_rpmsg_release_device;
-- 
2.17.1

