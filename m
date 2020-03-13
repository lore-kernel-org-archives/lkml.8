Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24523C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 08:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC7CB206B1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 08:18:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="mI100v4i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbgCMIS0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 04:18:26 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:39366 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbgCMIRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 04:17:46 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 02D8Hifs071929;
        Fri, 13 Mar 2020 03:17:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1584087465;
        bh=cR2auaaZnVvBiqCa7pzD+K3uPGgTnEYNRzfeAZy+KTw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=mI100v4ipWTgkYhLpGjmRNpHdGYqOcaRWtQh/zfuh4LLXEmgE3JLjbw6egwgz0tdp
         av+hu2WY6ZcyizdKqMXlkqxZ8T9fRmVWdf0sqY8AISvzZgRah1CrwfLN6QV1y7F3an
         NRutpBsuqw9qmOjPzyRoA01pvl/IIa4wIPIrm3XQ=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 02D8Hing087897
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 13 Mar 2020 03:17:44 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 13
 Mar 2020 03:17:42 -0500
Received: from localhost.localdomain (10.64.41.19) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 13 Mar 2020 03:17:42 -0500
Received: from sokoban.bb.dnainternet.fi (ileax41-snat.itg.ti.com [10.172.224.153])
        by localhost.localdomain (8.15.2/8.15.2) with ESMTP id 02D8HQlc097835;
        Fri, 13 Mar 2020 03:17:40 -0500
From:   Tero Kristo <t-kristo@ti.com>
To:     <bjorn.andersson@linaro.org>, <ohad@wizery.com>,
        <linux-remoteproc@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <mathieu.poirier@linaro.org>,
        <s-anna@ti.com>, <afd@ti.com>, Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv8 06/15] remoteproc/omap: Initialize and assign reserved memory node
Date:   Fri, 13 Mar 2020 10:17:09 +0200
Message-ID: <20200313081718.30612-7-t-kristo@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200313081718.30612-1-t-kristo@ti.com>
References: <20200313081718.30612-1-t-kristo@ti.com>
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
Reviewed-by: Andrew F. Davis <afd@ti.com>
Acked-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/remoteproc/omap_remoteproc.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/omap_remoteproc.c b/drivers/remoteproc/omap_remoteproc.c
index 9a82d5c4a06b..b010e0607d5f 100644
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
@@ -486,14 +487,23 @@ static int omap_rproc_probe(struct platform_device *pdev)
 	if (ret)
 		goto free_rproc;
 
+	ret = of_reserved_mem_device_init(&pdev->dev);
+	if (ret) {
+		dev_warn(&pdev->dev, "device does not have specific CMA pool.\n");
+		dev_warn(&pdev->dev, "Typically this should be provided,\n");
+		dev_warn(&pdev->dev, "only omit if you know what you are doing.\n");
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
@@ -505,6 +515,7 @@ static int omap_rproc_remove(struct platform_device *pdev)
 
 	rproc_del(rproc);
 	rproc_free(rproc);
+	of_reserved_mem_device_release(&pdev->dev);
 
 	return 0;
 }
-- 
2.17.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
