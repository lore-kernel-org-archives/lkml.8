Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98928C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C7722064B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:48:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="TAm9rNPt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732104AbgIHRsb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 13:48:31 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:53460 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732068AbgIHRql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 13:46:41 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 088HkSt7016356;
        Tue, 8 Sep 2020 12:46:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1599587188;
        bh=FK1CokiSYiGRZpmJHyo0T17KAISKb7OLKtCZBceTxYc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=TAm9rNPtsPEGQibx14WMdoYDmsMFs71HRsMHjI8PhiO27aViThRLeNCPTlng8mWhE
         /mUldY5929UEoFbUHeR7R2vnDjklzkjxMB8ja8FUrCXNiJTrl5Ls77QCefwq7zxwYA
         U9JvYM6OlVtydz2qrJFinsUULimEo901a1x3Ebu4=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 088HkSRv099386
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 8 Sep 2020 12:46:28 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 8 Sep
 2020 12:46:27 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 8 Sep 2020 12:46:27 -0500
Received: from lelv0597.itg.ti.com (lelv0597.itg.ti.com [10.181.64.32])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 088HkRSu116091;
        Tue, 8 Sep 2020 12:46:27 -0500
Received: from localhost ([10.250.34.59])
        by lelv0597.itg.ti.com (8.14.7/8.14.7) with ESMTP id 088HkRY0040375;
        Tue, 8 Sep 2020 12:46:27 -0500
From:   Suman Anna <s-anna@ti.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     Lokesh Vutla <lokeshvutla@ti.com>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Suman Anna <s-anna@ti.com>
Subject: [PATCH v4 3/4] remoteproc: k3-r5: Initialize TCM memories for ECC
Date:   Tue, 8 Sep 2020 12:45:55 -0500
Message-ID: <20200908174556.21277-4-s-anna@ti.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908174556.21277-1-s-anna@ti.com>
References: <20200908174556.21277-1-s-anna@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The R5F processors on K3 SoCs all have two TCMs (ATCM and BTCM) that
support 32-bit ECC. The TCMs are typically loaded with some boot-up
code to initialize the R5 MPUs to further execute code out of DDR.
The ECC for the TCMs is enabled by default on K3 SoCs due to internal
default tie-off values, but the TCM memories are not initialized on
device power up. Any read access without the corresponding TCM memory
location initialized will generate an ECC error, and any such access
from a A72 or A53 core will trigger a SError.

So, zero initialize both the TCM memories before loading any firmware
onto a R5F in remoteproc mode. Any R5F booted from U-Boot/SPL would
require a similar initialization in the bootloader. Note that both
the TCMs are initialized unconditionally as the TCM enable config bits
only manage the access and visibility from R5.

Signed-off-by: Suman Anna <s-anna@ti.com>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
v4: No changes
v3: https://patchwork.kernel.org/patch/11679335/
 - No code changes, picked up tags
v2: https://patchwork.kernel.org/patch/11632989/
v1: https://patchwork.kernel.org/patch/11456371/

 drivers/remoteproc/ti_k3_r5_remoteproc.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/ti_k3_r5_remoteproc.c b/drivers/remoteproc/ti_k3_r5_remoteproc.c
index 15e52ea67bbe..a6b395ab47b6 100644
--- a/drivers/remoteproc/ti_k3_r5_remoteproc.c
+++ b/drivers/remoteproc/ti_k3_r5_remoteproc.c
@@ -362,11 +362,24 @@ static int k3_r5_rproc_prepare(struct rproc *rproc)
 
 	ret = (cluster->mode == CLUSTER_MODE_LOCKSTEP) ?
 		k3_r5_lockstep_release(cluster) : k3_r5_split_release(core);
-	if (ret)
+	if (ret) {
 		dev_err(dev, "unable to enable cores for TCM loading, ret = %d\n",
 			ret);
+		return ret;
+	}
 
-	return ret;
+	/*
+	 * Zero out both TCMs unconditionally (access from v8 Arm core is not
+	 * affected by ATCM & BTCM enable configuration values) so that ECC
+	 * can be effective on all TCM addresses.
+	 */
+	dev_dbg(dev, "zeroing out ATCM memory\n");
+	memset(core->mem[0].cpu_addr, 0x00, core->mem[0].size);
+
+	dev_dbg(dev, "zeroing out BTCM memory\n");
+	memset(core->mem[1].cpu_addr, 0x00, core->mem[1].size);
+
+	return 0;
 }
 
 /*
-- 
2.28.0

