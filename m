Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A2F4C33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 13:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5EF0207E0
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 13:54:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="dhhKfjxa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729033AbgAPNyM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 08:54:12 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:60072 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728992AbgAPNyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 08:54:10 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 00GDs9RA068573;
        Thu, 16 Jan 2020 07:54:09 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1579182849;
        bh=UMxFFuXkqsTtHBavkfkf0RrNVDcrQAbMK2gz+/LnwWQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=dhhKfjxa6N6NDyuiFzQUSHe7uFB5I6P4BuIuARQNVuoQ1BQA9k17O2K3mAauqRTIm
         qaUeKlJAJIqVVHAUAaaP1ztRECYhLC8y0pjIr0BBdFkLA+nnGy1e81fLb//ypQJ66f
         Mh0Gg5qn82KehHQcf/9DRDCtfmJKHqp3Idej6/fg=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00GDs8sD080626;
        Thu, 16 Jan 2020 07:54:08 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 16
 Jan 2020 07:54:08 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 16 Jan 2020 07:54:08 -0600
Received: from sokoban.bb.dnainternet.fi (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00GDrqdY048732;
        Thu, 16 Jan 2020 07:54:06 -0600
From:   Tero Kristo <t-kristo@ti.com>
To:     <bjorn.andersson@linaro.org>, <ohad@wizery.com>,
        <linux-remoteproc@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <mathieu.poirier@linaro.org>,
        <s-anna@ti.com>, <linux-omap@vger.kernel.org>,
        Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv5 06/14] remoteproc/omap: Initialize and assign reserved memory node
Date:   Thu, 16 Jan 2020 15:53:24 +0200
Message-ID: <20200116135332.7819-7-t-kristo@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200116135332.7819-1-t-kristo@ti.com>
References: <20200116135332.7819-1-t-kristo@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suman Anna <s-anna@ti.com>

The reserved memory nodes are not assigned to platform devices by
default in the driver core to avoid the lookup for every platform
device and incur a penalty as the real users are expected to be
only a few devices.

OMAP remoteproc devices fall into the above category and the OMAP
remoteproc driver _requires_ specific CMA pools to be assigned
for each device at the moment to align on the location of the
vrings and vring buffers in the RTOS-side firmware images. So,
use the of_reserved_mem_device_init/release() API appropriately
to assign the corresponding reserved memory region to the OMAP
remoteproc device. Note that only one region per device is
allowed by the framework.

Signed-off-by: Suman Anna <s-anna@ti.com>
Signed-off-by: Tero Kristo <t-kristo@ti.com>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
v5: no changes

 drivers/remoteproc/omap_remoteproc.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/omap_remoteproc.c b/drivers/remoteproc/omap_remoteproc.c
index 0846839b2c97..194303b860b2 100644
--- a/drivers/remoteproc/omap_remoteproc.c
+++ b/drivers/remoteproc/omap_remoteproc.c
@@ -17,6 +17,7 @@
 #include <linux/module.h>
 #include <linux/err.h>
 #include <linux/of_device.h>
+#include <linux/of_reserved_mem.h>
 #include <linux/platform_device.h>
 #include <linux/dma-mapping.h>
 #include <linux/remoteproc.h>
@@ -480,14 +481,22 @@ static int omap_rproc_probe(struct platform_device *pdev)
 	if (ret)
 		goto free_rproc;
 
+	ret = of_reserved_mem_device_init(&pdev->dev);
+	if (ret) {
+		dev_err(&pdev->dev, "device does not have specific CMA pool\n");
+		goto free_rproc;
+	}
+
 	platform_set_drvdata(pdev, rproc);
 
 	ret = rproc_add(rproc);
 	if (ret)
-		goto free_rproc;
+		goto release_mem;
 
 	return 0;
 
+release_mem:
+	of_reserved_mem_device_release(&pdev->dev);
 free_rproc:
 	rproc_free(rproc);
 	return ret;
@@ -499,6 +508,7 @@ static int omap_rproc_remove(struct platform_device *pdev)
 
 	rproc_del(rproc);
 	rproc_free(rproc);
+	of_reserved_mem_device_release(&pdev->dev);
 
 	return 0;
 }
-- 
2.17.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
