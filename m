Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEBB0C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 16:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A81A422243
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 16:14:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="jSuvQtP8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2636747AbgDPQOu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 12:14:50 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:60762 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2506882AbgDPQOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 12:14:21 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03GGDEcA005340;
        Thu, 16 Apr 2020 18:14:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=YZpO0MFVW9vkv1rWFiaUKKC8KtUwKhF7TJEzzRaiSig=;
 b=jSuvQtP8C4bkThZade7Gr7g5EmOAKrdv17XxcdCMhpYEbbxKNruIHyIMEYWjNrTKCifq
 JQYwIz5mGlK6lA5fzi5Q7AY/xWnZZx1Rv0ZVmKmrA8cRANawKOO3s56xYHRCw5sgi9Ns
 IINiHjentlBBy8uvcF+MQo9h6F8u4JqzvsBqU7HcCjI1J8v5kcpuOpJOYJmUMsf1L3E9
 ZUHx9KNahYz+4hM21hxs8uv47XCcLYMteaSW/BCOl3FKwqsSEVfh+pLdMbgXa4V0B6V0
 ranTFllTyjMla+G5hFQcQdgJG5RExP+OJ21ZM9mu28cQKZJSmO4ocaKTkob1Cj8wM6Vy rQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 30dn6t3nbq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Apr 2020 18:14:14 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C63D410002A;
        Thu, 16 Apr 2020 18:14:13 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B8AD62B2D2A;
        Thu, 16 Apr 2020 18:14:13 +0200 (CEST)
Received: from localhost (10.75.127.47) by SFHDAG3NODE1.st.com (10.75.127.7)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 16 Apr 2020 18:14:12
 +0200
From:   Arnaud Pouliquen <arnaud.pouliquen@st.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <arnaud.pouliquen@st.com>
Subject: [RFC 05/18] remoteproc: Create platform device for vdev
Date:   Thu, 16 Apr 2020 18:13:18 +0200
Message-ID: <20200416161331.7606-6-arnaud.pouliquen@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200416161331.7606-1-arnaud.pouliquen@st.com>
References: <20200416161331.7606-1-arnaud.pouliquen@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-16_06:2020-04-14,2020-04-16 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Manage the vdev as a platform device. The platform device is created
when a vdev resource is detected in the resource table.
The rvdev is now managed in rproc_virtio platform.
The rdev->refcount is now useless.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 drivers/remoteproc/remoteproc_core.c     |  57 +++---
 drivers/remoteproc/remoteproc_internal.h |  10 +-
 drivers/remoteproc/remoteproc_virtio.c   | 213 ++++++++++++++---------
 include/linux/remoteproc.h               |   9 +-
 4 files changed, 175 insertions(+), 114 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 32056449bb72..5dcef62d8d1d 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -31,6 +31,7 @@
 #include <linux/idr.h>
 #include <linux/elf.h>
 #include <linux/crc32.h>
+#include <linux/of_platform.h>
 #include <linux/of_reserved_mem.h>
 #include <linux/virtio_ids.h>
 #include <linux/virtio_ring.h>
@@ -440,7 +441,9 @@ static int rproc_handle_vdev(struct rproc *rproc, struct fw_rsc_vdev *rsc,
 			     int offset, int avail)
 {
 	struct device *dev = &rproc->dev;
-	struct rproc_vdev *rvdev;
+	struct rproc_vdev_data vdev_data;
+	struct platform_device *pdev;
+	int ret;
 
 	/* make sure resource isn't truncated */
 	if (struct_size(rsc, vring, rsc->num_of_vrings) + rsc->config_len >
@@ -455,37 +458,43 @@ static int rproc_handle_vdev(struct rproc *rproc, struct fw_rsc_vdev *rsc,
 		return -EINVAL;
 	}
 
-	dev_dbg(dev, "vdev rsc: id %d, dfeatures 0x%x, cfg len %d, %d vrings\n",
-		rsc->id, rsc->dfeatures, rsc->config_len, rsc->num_of_vrings);
+	vdev_data.rsc_offset = offset;
+	vdev_data.rsc = rsc;
+	vdev_data.id  = rsc->id;
+	vdev_data.index  = rproc->nb_vdev;
 
-	/* we currently support only two vrings per rvdev */
-	if (rsc->num_of_vrings > ARRAY_SIZE(rvdev->vring)) {
-		dev_err(dev, "too many vrings: %d\n", rsc->num_of_vrings);
-		return -EINVAL;
+	dev_dbg(dev, "%s: rsc_offset = %d rsc = %p id = %d\n",
+		__func__, vdev_data.rsc_offset, vdev_data.rsc, vdev_data.id);
+
+	pdev = platform_device_register_data(dev, "rproc-virtio",
+					     rproc->nb_vdev, &vdev_data,
+					     sizeof(vdev_data));
+	ret = PTR_ERR_OR_ZERO(pdev);
+	if (ret) {
+		dev_err(rproc->dev.parent,
+			"failed to create rproc-virtio device\n");
+		return ret;
 	}
+	rproc->nb_vdev++;
 
-	rvdev = kzalloc(sizeof(*rvdev), GFP_KERNEL);
-	if (!rvdev)
-		return -ENOMEM;
+	return  0;
+}
 
-	kref_init(&rvdev->refcount);
+static void rproc_vdev_release(struct rproc_vdev *rvdev)
+{
+	struct device *dev = &rvdev->pdev->dev;
 
-	rvdev->rsc = rsc;
-	rvdev->rsc_offset = offset;
-	rvdev->id = rsc->id;
-	rvdev->rproc = rproc;
-	rvdev->index = rproc->nb_vdev++;
+	if (!dev->of_node)
+		platform_device_unregister(rvdev->pdev);
+}
 
+void rproc_register_rvdev(struct rproc *rproc, struct rproc_vdev *rvdev)
+{
 	list_add_tail(&rvdev->node, &rproc->rvdevs);
-
-	return rproc_virtio_device_add(rvdev);
 }
 
-void rproc_vdev_release(struct kref *ref)
+void rproc_unregister_rvdev(struct rproc_vdev *rvdev)
 {
-	struct rproc_vdev *rvdev = container_of(ref, struct rproc_vdev, refcount);
-
-	rproc_virtio_device_remove(rvdev);
 	list_del(&rvdev->node);
 }
 
@@ -1192,9 +1201,9 @@ static void rproc_resource_cleanup(struct rproc *rproc)
 		kfree(entry);
 	}
 
-	/* clean up remote vdev entries */
+	/* clean up virtio platform devices */
 	list_for_each_entry_safe(rvdev, rvtmp, &rproc->rvdevs, node)
-		kref_put(&rvdev->refcount, rproc_vdev_release);
+		rproc_vdev_release(rvdev);
 
 	rproc_coredump_cleanup(rproc);
 }
diff --git a/drivers/remoteproc/remoteproc_internal.h b/drivers/remoteproc/remoteproc_internal.h
index fad95f1a50c1..f5eaffac2fcd 100644
--- a/drivers/remoteproc/remoteproc_internal.h
+++ b/drivers/remoteproc/remoteproc_internal.h
@@ -24,10 +24,18 @@ struct rproc_debug_trace {
 	struct rproc_mem_entry trace_mem;
 };
 
+struct rproc_vdev_data {
+	u32 rsc_offset;
+	struct fw_rsc_vdev *rsc;
+	unsigned int id;
+	unsigned int index;
+};
+
 /* from remoteproc_core.c */
 void rproc_release(struct kref *kref);
 irqreturn_t rproc_vq_interrupt(struct rproc *rproc, int vq_id);
-void rproc_vdev_release(struct kref *ref);
+void rproc_register_rvdev(struct rproc *rproc, struct rproc_vdev *rvdev);
+void rproc_unregister_rvdev(struct rproc_vdev *rvdev);
 
 /* from remoteproc_virtio.c */
 int rproc_virtio_device_add(struct rproc_vdev *rvdev);
diff --git a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remoteproc/remoteproc_virtio.c
index 0f7efac7d4f3..2a0f33ccd929 100644
--- a/drivers/remoteproc/remoteproc_virtio.c
+++ b/drivers/remoteproc/remoteproc_virtio.c
@@ -2,6 +2,7 @@
 /*
  * Remote processor messaging transport (OMAP platform-specific bits)
  *
+ * Copyright (C) 2020 ST STMicroelectronics.
  * Copyright (C) 2011 Texas Instruments, Inc.
  * Copyright (C) 2011 Google, Inc.
  *
@@ -11,14 +12,15 @@
 
 #include <linux/dma-mapping.h>
 #include <linux/export.h>
+#include <linux/module.h>
 #include <linux/of_reserved_mem.h>
+#include <linux/platform_device.h>
 #include <linux/remoteproc.h>
 #include <linux/virtio.h>
 #include <linux/virtio_config.h>
 #include <linux/virtio_ids.h>
 #include <linux/virtio_ring.h>
 #include <linux/err.h>
-#include <linux/kref.h>
 #include <linux/slab.h>
 
 #include "remoteproc_internal.h"
@@ -296,41 +298,23 @@ static const struct virtio_config_ops rproc_virtio_config_ops = {
 	.set		= rproc_virtio_set,
 };
 
-/**
- * rproc_rvdev_release() - release the existence of a rvdev
- *
- * @dev: the subdevice's dev
- */
-static void rproc_virtio_rvdev_release(struct device *dev)
-{
-	struct rproc_vdev *rvdev = container_of(dev, struct rproc_vdev, dev);
-
-	of_reserved_mem_device_release(dev);
-
-	kfree(rvdev);
-}
-
-/*
- * This function is called whenever vdev is released, and is responsible
- * to decrement the remote processor's refcount which was taken when vdev was
- * added.
- *
- * Never call this function directly; it will be called by the driver
- * core when needed.
- */
 static void rproc_virtio_dev_release(struct device *dev)
 {
 	struct virtio_device *vdev = dev_to_virtio(dev);
-	struct rproc_vdev *rvdev = vdev_to_rvdev(vdev);
 	struct rproc *rproc = vdev_to_rproc(vdev);
 
-	kfree(vdev);
-
-	kref_put(&rvdev->refcount, rproc_vdev_release);
-
 	put_device(&rproc->dev);
 }
 
+static void rproc_virtio_dev_init(struct rproc_vdev *rvdev)
+{
+	memset(&rvdev->vdev, 0, sizeof(rvdev->vdev));
+	rvdev->vdev.dev.parent = &rvdev->pdev->dev;
+	rvdev->vdev.dev.release = rproc_virtio_dev_release;
+	rvdev->vdev.config = &rproc_virtio_config_ops;
+	rvdev->vdev.id.device = rvdev->id;
+}
+
 /**
  * rproc_vdev_start() - register an rproc-induced virtio device
  * @subdev: the rproc virtio subdevice
@@ -345,8 +329,8 @@ static int rproc_vitio_start(struct rproc_subdev *subdev)
 	struct rproc_vdev *rvdev = container_of(subdev, struct rproc_vdev,
 						subdev);
 	struct rproc *rproc = rvdev->rproc;
-	struct device *dev = &rvdev->dev;
-	struct virtio_device *vdev;
+	struct device *dev = &rvdev->pdev->dev;
+	struct virtio_device *vdev = &rvdev->vdev;
 	struct rproc_mem_entry *mem;
 	int ret;
 
@@ -387,29 +371,15 @@ static int rproc_vitio_start(struct rproc_subdev *subdev)
 	}
 
 	/* Allocate virtio device */
-	vdev = kzalloc(sizeof(*vdev), GFP_KERNEL);
-	if (!vdev) {
-		ret = -ENOMEM;
-		goto out;
-	}
-	vdev->id.device	= rvdev->id,
-	vdev->config = &rproc_virtio_config_ops,
-	vdev->dev.parent = dev;
-	vdev->dev.release = rproc_virtio_dev_release;
+	rproc_virtio_dev_init(rvdev);
 
 	/*
 	 * We're indirectly making a non-temporary copy of the rproc pointer
 	 * here, because drivers probed with this vdev will indirectly
 	 * access the wrapping rproc.
-	 *
-	 * Therefore we must increment the rproc refcount here, and decrement
-	 * it _only_ when the vdev is released.
 	 */
 	get_device(&rproc->dev);
 
-	/* Reference the vdev and vring allocations */
-	kref_get(&rvdev->refcount);
-
 	ret = register_virtio_device(vdev);
 	if (ret) {
 		put_device(&vdev->dev);
@@ -427,17 +397,9 @@ static int rproc_vitio_start(struct rproc_subdev *subdev)
 static int rproc_remove_virtio_dev(struct device *dev, void *data)
 {
 	struct virtio_device *vdev = dev_to_virtio(dev);
-	struct rproc_vdev *rvdev = vdev_to_rvdev(vdev);
-	struct rproc_vring *rvring;
-	int id;
 
 	unregister_virtio_device(vdev);
 
-	for (id = 0; id < ARRAY_SIZE(rvdev->vring); id++) {
-		rvring = &rvdev->vring[id];
-		rproc_free_vring(rvring);
-	}
-
 	return 0;
 }
 /**
@@ -451,12 +413,12 @@ static void rproc_vitio_stop(struct rproc_subdev *subdev, bool crashed)
 {
 	struct rproc_vdev *rvdev = container_of(subdev, struct rproc_vdev,
 						subdev);
+	struct device *dev = &rvdev->pdev->dev;
 	int ret;
 
-	ret = device_for_each_child(&rvdev->dev, NULL, rproc_remove_virtio_dev);
+	ret = device_for_each_child(dev, NULL, rproc_remove_virtio_dev);
 	if (ret)
-		dev_warn(&rvdev->dev, "can't remove vdev child device: %d\n",
-			 ret);
+		dev_warn(dev, "can't remove vdev child device: %d\n", ret);
 }
 
 static const struct rproc_subdev rproc_virtio_subdev = {
@@ -464,42 +426,35 @@ static const struct rproc_subdev rproc_virtio_subdev = {
 	.stop		= rproc_vitio_stop
 };
 
-int rproc_virtio_device_add(struct rproc_vdev *rvdev)
+static int rproc_virtio_bind(struct device *dev)
 {
+	struct rproc_vdev *rvdev = dev_get_drvdata(dev);
 	struct rproc *rproc = rvdev->rproc;
 	struct fw_rsc_vdev *rsc = rvdev->rsc;
-	char name[16];
 	int ret, i;
 
-	/* Initialise vdev subdevice */
-	snprintf(name, sizeof(name), "vdev%dbuffer", rvdev->index);
-	rvdev->dev.parent = &rproc->dev;
-	rvdev->dev.dma_pfn_offset = rproc->dev.parent->dma_pfn_offset;
-	rvdev->dev.release = rproc_virtio_rvdev_release;
-	dev_set_name(&rvdev->dev, "%s#%s", dev_name(rvdev->dev.parent), name);
-	dev_set_drvdata(&rvdev->dev, rvdev);
+	/* test if a resource has been associated to the vdev */
+	if (!rvdev->rsc)
+		return 0;
 
-	ret = device_register(&rvdev->dev);
-	if (ret) {
-		put_device(&rvdev->dev);
-		return ret;
-	}
-	/* Make device dma capable by inheriting from parent's capabilities */
-	set_dma_ops(&rvdev->dev, get_dma_ops(rproc->dev.parent));
+	dev_dbg(dev, "vdev rsc: id %d, dfeatures 0x%x, cfg len %d, %d vrings\n",
+		rsc->id, rsc->dfeatures, rsc->config_len, rsc->num_of_vrings);
 
-	ret = dma_coerce_mask_and_coherent(&rvdev->dev,
-					   dma_get_mask(rproc->dev.parent));
-	if (ret) {
-		dev_warn(&rvdev->dev,
-			 "Failed to set DMA mask %llx. Trying to continue... %x\n",
-			 dma_get_mask(rproc->dev.parent), ret);
+	/* we currently support only two vrings per rvdev */
+	if (rsc->num_of_vrings > ARRAY_SIZE(rvdev->vring)) {
+		dev_err(dev, "too many vrings: %d\n", rsc->num_of_vrings);
+		return -EINVAL;
 	}
 
+	/* If no resource table or no vdev nothing to do */
+	if (!rsc || !rsc->num_of_vrings)
+		return 0;
+
 	/* parse the vrings */
 	for (i = 0; i < rsc->num_of_vrings; i++) {
 		ret = rproc_parse_vring(rvdev, rsc, i);
 		if (ret)
-			goto free_rvdev;
+			return ret;
 	}
 
 	/* allocate the vring resources */
@@ -510,9 +465,12 @@ int rproc_virtio_device_add(struct rproc_vdev *rvdev)
 	}
 
 	rvdev->subdev = rproc_virtio_subdev;
+	rvdev->id = rsc->id;
 
 	rproc_add_subdev(rproc, &rvdev->subdev);
 
+	dev_dbg(dev, "virtio dev %d bound\n",  rvdev->index);
+
 	return 0;
 
 free_vg:
@@ -522,16 +480,103 @@ int rproc_virtio_device_add(struct rproc_vdev *rvdev)
 		rproc_free_vring(rvring);
 	}
 
-free_rvdev:
-	device_unregister(&rvdev->dev);
-
 	return ret;
 }
 
-void rproc_virtio_device_remove(struct rproc_vdev *rvdev)
+static void rproc_virtio_unbind(struct device *dev)
 {
+	struct rproc_vdev *rvdev = dev_get_drvdata(dev);
 	struct rproc *rproc = rvdev->rproc;
+	struct rproc_vring *rvring;
+	int id;
+
+	/*test if a resource has been associated to the vdev */
+	if (!rvdev->rsc)
+		return;
+
+	for (id = 0; id < ARRAY_SIZE(rvdev->vring); id++) {
+		rvring = &rvdev->vring[id];
+		rproc_free_vring(rvring);
+	}
 
 	rproc_remove_subdev(rproc, &rvdev->subdev);
-	device_unregister(&rvdev->dev);
+
+	dev_dbg(dev, "virtio dev %d unbound\n",  rvdev->index);
 }
+
+static int rproc_virtio_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	struct rproc_vdev *rvdev;
+	struct rproc *rproc;
+	int ret;
+
+	rvdev = devm_kzalloc(&pdev->dev, sizeof(*rvdev), GFP_KERNEL);
+	if (!rvdev)
+		return -ENOMEM;
+
+	if (dev->of_node) {
+		/*
+		 * The platform device is declared in the device tree
+		 * retrieve rproc struct through the remoteproc platform
+		 */
+		rproc = rproc_get_by_node(dev->parent->of_node);
+
+		/* the reg is used to specify the vdev index */
+		if (of_property_read_u32(np, "reg", &rvdev->index))
+			return -EINVAL;
+	} else {
+		struct rproc_vdev_data *vdev_data = pdev->dev.platform_data;
+
+		if (!vdev_data)
+			return -EINVAL;
+
+		rproc = container_of(dev->parent, struct rproc, dev);
+
+		rvdev->rsc_offset = vdev_data->rsc_offset;
+		rvdev->rsc = vdev_data->rsc;
+		rvdev->id = vdev_data->id;
+		rvdev->index = vdev_data->index;
+
+		ret = dma_coerce_mask_and_coherent(dev, DMA_BIT_MASK(32));
+		if (ret)
+			return ret;
+	}
+	rvdev->pdev = pdev;
+	rvdev->rproc = rproc;
+
+	platform_set_drvdata(pdev, rvdev);
+
+	rproc_register_rvdev(rproc, rvdev);
+
+	return rproc_virtio_bind(dev);
+}
+
+static int rproc_virtio_remove(struct platform_device *pdev)
+{
+	rproc_virtio_unbind(&pdev->dev);
+
+	return 0;
+}
+
+/* Platform driver */
+static const struct of_device_id rproc_virtio_match[] = {
+	{ .compatible = "rproc-virtio", },
+	{},
+};
+
+static struct platform_driver rproc_virtio_driver = {
+	.probe		= rproc_virtio_probe,
+	.remove		= rproc_virtio_remove,
+	.driver		= {
+		.name	= "rproc-virtio",
+		.of_match_table	= rproc_virtio_match,
+	},
+};
+
+module_platform_driver(rproc_virtio_driver);
+
+MODULE_AUTHOR("Arnaud Pouliquen <arnaud.pouliquen@st.com>");
+MODULE_DESCRIPTION("Platform bus driver for rproc based virtio devices");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index ab9762563ae0..eb5bd568f11e 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -560,8 +560,8 @@ struct rproc_vring {
 
 /**
  * struct rproc_vdev - remoteproc state for a supported virtio device
- * @refcount: reference counter for the vdev and vring allocations
  * @subdev: handle for registering the vdev as a rproc subdevice
+ * @pdev: remoteproc virtio platform device
  * @id: virtio device id (as in virtio_ids.h)
  * @node: list node
  * @rproc: the rproc handle
@@ -572,10 +572,9 @@ struct rproc_vring {
  * @index: vdev position versus other vdev declared in resource table
  */
 struct rproc_vdev {
-	struct kref refcount;
-
 	struct rproc_subdev subdev;
-	struct device dev;
+	struct platform_device *pdev;
+	struct virtio_device vdev;
 
 	unsigned int id;
 	struct list_head node;
@@ -628,7 +627,7 @@ int rproc_coredump_add_custom_segment(struct rproc *rproc,
 
 static inline struct rproc_vdev *vdev_to_rvdev(struct virtio_device *vdev)
 {
-	return container_of(vdev->dev.parent, struct rproc_vdev, dev);
+	return container_of(vdev, struct rproc_vdev, vdev);
 }
 
 static inline struct rproc *vdev_to_rproc(struct virtio_device *vdev)
-- 
2.17.1

