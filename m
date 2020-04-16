Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47DAFC352BE
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 16:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 246E120771
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 16:14:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="YeZbZYRX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442862AbgDPQOg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 12:14:36 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:16640 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732881AbgDPQOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 12:14:20 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03GGDE7R005334;
        Thu, 16 Apr 2020 18:14:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=9k0FNhJOPSvwIJNPLmFrVLya7+VY5EmTPJ6xttH4GPs=;
 b=YeZbZYRXQTmO9XDUeIuCvzaFn91Kd+T3rf0iGQCGfFDVULmOCcLptryRRfiJlVgdPSXM
 fDsdBUzG7fiXpSJMOmEblM3ueKRpIBjk2d+3BRGT6JCm5T2+SUs5I/UCVhHm8CknbGfS
 AA5KzT4tO5v2EvNHo4BQOiE84cxw9u2TG+GoVBr47Rd1179k4W6nE2D6B1RrlNtmfmxy
 dvCmbgV8kBUrshGketf22kzp+azQNDICeN/bWTFoUpmTvQ6Z6Znpv4SH0cCOrFrk9P0A
 7ZdYbLnBUZYwAgQDV9FWDbu9v5RMNUDdiUOZt/zHHVOnfT7769NxbzgrnWngfN1nwN2v 4w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 30dn6t3nbv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Apr 2020 18:14:15 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3AE3710002A;
        Thu, 16 Apr 2020 18:14:15 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2EB4B2B2D2A;
        Thu, 16 Apr 2020 18:14:15 +0200 (CEST)
Received: from localhost (10.75.127.47) by SFHDAG3NODE1.st.com (10.75.127.7)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 16 Apr 2020 18:14:14
 +0200
From:   Arnaud Pouliquen <arnaud.pouliquen@st.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <arnaud.pouliquen@st.com>
Subject: [RFC 06/18] remoteproc: Add component in core for child devices synchronization
Date:   Thu, 16 Apr 2020 18:13:19 +0200
Message-ID: <20200416161331.7606-7-arnaud.pouliquen@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200416161331.7606-1-arnaud.pouliquen@st.com>
References: <20200416161331.7606-1-arnaud.pouliquen@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG6NODE2.st.com (10.75.127.17) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-16_06:2020-04-14,2020-04-16 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As virtio is now a platform device. We need to ensure that the virtio
device is initialized before subdev ops are called.
Add a rproc master component to synchronize child devices bind/unbind
before the resource allocation and the firmware start.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 drivers/remoteproc/remoteproc_core.c | 96 +++++++++++++++++++++++++++-
 include/linux/remoteproc.h           |  4 ++
 2 files changed, 98 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 5dcef62d8d1d..cb40aae12b98 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -16,6 +16,7 @@
 
 #define pr_fmt(fmt)    "%s: " fmt, __func__
 
+#include <linux/component.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/device.h>
@@ -42,6 +43,8 @@
 
 #define HIGH_BITS_MASK 0xFFFFFFFF00000000ULL
 
+#define BIND_TIMEOUT_MS 1000
+
 static DEFINE_MUTEX(rproc_list_mutex);
 static LIST_HEAD(rproc_list);
 
@@ -410,6 +413,45 @@ void rproc_free_vring(struct rproc_vring *rvring)
 	rsc->vring[idx].notifyid = -1;
 }
 
+static int rproc_compare_of(struct device *dev, void *data)
+{
+	if (dev->of_node)
+		return dev->of_node == data;
+	else
+		return dev == data;
+}
+
+static void rproc_release_of(struct device *dev, void *data)
+{
+	if (dev->of_node)
+		of_node_put(data);
+}
+
+static void rproc_unbind(struct device *dev)
+{
+	struct rproc *rproc = container_of(dev, struct rproc, dev);
+
+	/* undbind all child components */
+	component_unbind_all(dev, NULL);
+	complete(&rproc->completed);
+}
+
+static int rproc_bind(struct device *dev)
+{
+	struct rproc *rproc = container_of(dev, struct rproc, dev);
+
+	/* bind all child components */
+	rproc->bind_status = component_bind_all(dev, NULL);
+	complete(&rproc->completed);
+
+	return rproc->bind_status;
+}
+
+static const struct component_master_ops rproc_cmp_ops = {
+	.bind = rproc_bind,
+	.unbind = rproc_unbind,
+};
+
 /**
  * rproc_handle_vdev() - handle a vdev fw resource
  * @rproc: the remote processor
@@ -475,6 +517,10 @@ static int rproc_handle_vdev(struct rproc *rproc, struct fw_rsc_vdev *rsc,
 			"failed to create rproc-virtio device\n");
 		return ret;
 	}
+	/* register a component associated to the virtio platform */
+	component_match_add_release(&pdev->dev, &rproc->match,
+				    rproc_release_of, rproc_compare_of,
+				    &pdev->dev);
 	rproc->nb_vdev++;
 
 	return  0;
@@ -1318,20 +1364,51 @@ static int rproc_fw_boot(struct rproc *rproc, const struct firmware *fw)
 		goto clean_up_resources;
 	}
 
+	/*
+	 * bind all the children associated to the resources before starting
+	 * the remote processor. This synchro point ensures that everything is
+	 * ready to run.
+	 */
+	init_completion(&rproc->completed);
+	if (rproc->match) {
+		ret = component_master_add_with_match(dev, &rproc_cmp_ops,
+						      rproc->match);
+		if (ret) {
+			dev_err(dev, "failed to bind rproc\n");
+			goto clean_up_resources;
+		}
+	}
+	/* Wait for all children to be bound */
+	if (!wait_for_completion_timeout(&rproc->completed,
+					 msecs_to_jiffies(BIND_TIMEOUT_MS))) {
+		dev_err(dev, "failed to bind child device(s)\n");
+		ret = -ETIMEDOUT;
+		goto clean_up_resources;
+	}
+
+	ret = rproc->bind_status;
+	if (ret) {
+		dev_err(dev, "failed to bind\n");
+		goto clean_up_resources;
+	}
+
 	/* Allocate carveout resources associated to rproc */
 	ret = rproc_alloc_registered_carveouts(rproc);
 	if (ret) {
 		dev_err(dev, "Failed to allocate associated carveouts: %d\n",
 			ret);
-		goto clean_up_resources;
+		goto unbind_comp;
 	}
 
 	ret = rproc_start(rproc, fw);
 	if (ret)
-		goto clean_up_resources;
+		goto unbind_comp;
 
 	return 0;
 
+unbind_comp:
+	component_master_del(dev, &rproc_cmp_ops);
+	rproc->match = NULL;
 clean_up_resources:
 	rproc_resource_cleanup(rproc);
 	kfree(rproc->cached_table);
@@ -1733,6 +1810,21 @@ void rproc_shutdown(struct rproc *rproc)
 		goto out;
 	}
 
+	/*
+	 * Unbind all the children before cleaning resources. This synchro
+	 * point ensures that everything has been released before resources are
+	 * freed.
+	 */
+	init_completion(&rproc->completed);
+
+	component_master_del(dev, &rproc_cmp_ops);
+	rproc->match = NULL;
+
+	if (!wait_for_completion_timeout(&rproc->completed,
+					 msecs_to_jiffies(BIND_TIMEOUT_MS))) {
+		dev_err(dev, "failed to unbind child device(s)\n");
+	}
+
 	/* clean up all acquired resources */
 	rproc_resource_cleanup(rproc);
 
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index eb5bd568f11e..d7235f7356e2 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -514,6 +514,10 @@ struct rproc {
 	bool auto_boot;
 	struct list_head dump_segments;
 	int nb_vdev;
+	struct component_match *match;
+	struct completion completed;
+	int bind_status;
+
 };
 
 /**
-- 
2.17.1

