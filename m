Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8969CC2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 16:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6369720771
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 16:14:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="RToF/KLF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2636672AbgDPQOm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 12:14:42 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:46907 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2636317AbgDPQOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 12:14:21 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03GGCFET010375;
        Thu, 16 Apr 2020 18:14:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=HSxCJna+r5+8UesgNfnHzloc46YrqYjXP5KDUxOljAY=;
 b=RToF/KLFRTZwOODwY0YFkp6PU/uVLUwzjIT/u1mhdzeeOjmZe16DAIuogtvAxUR6MM+L
 D4zJ2fLpyHChxRI6Pie4fI4YExEGmnVWMjKwYWAIZaRab2sgZUktMVHxiLnsuZbhc0X+
 wCIh8D9W9KvCs1coz6G8J6HWFC2w17PoOraFTnv9sANOFWjGZRe0Fgh7Zb+PxAkEX19c
 G+905Q4DlkQ6QP0OV1HODDTbIKfbgfwnLHpQRR60c9YdnHj4lzHd7pSTylHn6+fMBwJ9
 9oo/Op+t+QVwxAOi//OMP81JgbrhfNA/ASaDN6/bzPohuoPPEqlLQMv7COPPAHOU3P5d Pg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 30dn94kmvm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Apr 2020 18:14:17 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9890C100034;
        Thu, 16 Apr 2020 18:14:16 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8C9202B2D2A;
        Thu, 16 Apr 2020 18:14:16 +0200 (CEST)
Received: from localhost (10.75.127.47) by SFHDAG3NODE1.st.com (10.75.127.7)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 16 Apr 2020 18:14:16
 +0200
From:   Arnaud Pouliquen <arnaud.pouliquen@st.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <arnaud.pouliquen@st.com>
Subject: [RFC 07/18] remoteproc: Add component bind/unbind for virtio platform
Date:   Thu, 16 Apr 2020 18:13:20 +0200
Message-ID: <20200416161331.7606-8-arnaud.pouliquen@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200416161331.7606-1-arnaud.pouliquen@st.com>
References: <20200416161331.7606-1-arnaud.pouliquen@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-16_06:2020-04-14,2020-04-16 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add component to declare bind and unbind functions. Theses functions
are used to ensure that the remoteproc virtio device is probed
and registered as a subdev of the rproc device before rproc
request the the prepare and start of the subdevice.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 drivers/remoteproc/remoteproc_virtio.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remoteproc/remoteproc_virtio.c
index 2a0f33ccd929..e1d7371d2d64 100644
--- a/drivers/remoteproc/remoteproc_virtio.c
+++ b/drivers/remoteproc/remoteproc_virtio.c
@@ -10,6 +10,7 @@
  * Brian Swetland <swetland@google.com>
  */
 
+#include <linux/component.h>
 #include <linux/dma-mapping.h>
 #include <linux/export.h>
 #include <linux/module.h>
@@ -426,7 +427,8 @@ static const struct rproc_subdev rproc_virtio_subdev = {
 	.stop		= rproc_vitio_stop
 };
 
-static int rproc_virtio_bind(struct device *dev)
+static int rproc_virtio_bind(struct device *dev, struct device *master,
+			     void *data)
 {
 	struct rproc_vdev *rvdev = dev_get_drvdata(dev);
 	struct rproc *rproc = rvdev->rproc;
@@ -483,7 +485,8 @@ static int rproc_virtio_bind(struct device *dev)
 	return ret;
 }
 
-static void rproc_virtio_unbind(struct device *dev)
+static void rproc_virtio_unbind(struct device *dev, struct device *master,
+				void *data)
 {
 	struct rproc_vdev *rvdev = dev_get_drvdata(dev);
 	struct rproc *rproc = rvdev->rproc;
@@ -504,6 +507,11 @@ static void rproc_virtio_unbind(struct device *dev)
 	dev_dbg(dev, "virtio dev %d unbound\n",  rvdev->index);
 }
 
+static const struct component_ops rproc_virtio_ops = {
+	.bind = rproc_virtio_bind,
+	.unbind = rproc_virtio_unbind,
+};
+
 static int rproc_virtio_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -548,14 +556,21 @@ static int rproc_virtio_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, rvdev);
 
+	ret = component_add(&pdev->dev, &rproc_virtio_ops);
+	if (ret)
+		return ret;
+
 	rproc_register_rvdev(rproc, rvdev);
 
-	return rproc_virtio_bind(dev);
+	return 0;
 }
 
 static int rproc_virtio_remove(struct platform_device *pdev)
 {
-	rproc_virtio_unbind(&pdev->dev);
+	struct rproc_vdev *rvdev = dev_get_drvdata(&pdev->dev);
+
+	component_del(&pdev->dev, &rproc_virtio_ops);
+	rproc_unregister_rvdev(rvdev);
 
 	return 0;
 }
-- 
2.17.1

