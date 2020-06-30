Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6321DC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 02:49:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42BC52071A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 02:49:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="MN/rUJ4n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728640AbgF3Cte (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 22:49:34 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:41682 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbgF3Cte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 22:49:34 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 05U2nSVm123658;
        Mon, 29 Jun 2020 21:49:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1593485368;
        bh=HJHaiv3gDNDUUjiAHDJS0Y4WAlxsJkqEQohXF0BMQa4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=MN/rUJ4nrxk69iC/g8+M189zmXfrDeFCDn5YahKKWbu1TBrix1qpEGHlJ9hlmpERY
         nbx2SmKvMkUvMTIjLjmt5klUYcfw9auzLLaXXbXo3u3WA62ByKI1PK/1ZljLEK4/fH
         yNLl1RndssQuujOTwnbkyk1Af0n4nqgiZE91nD+w=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 05U2nSQT048638
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 29 Jun 2020 21:49:28 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 29
 Jun 2020 21:49:28 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 29 Jun 2020 21:49:28 -0500
Received: from fllv0103.dal.design.ti.com (fllv0103.dal.design.ti.com [10.247.120.73])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 05U2nSja043379;
        Mon, 29 Jun 2020 21:49:28 -0500
Received: from localhost ([10.250.48.148])
        by fllv0103.dal.design.ti.com (8.14.7/8.14.7) with ESMTP id 05U2nSFF029156;
        Mon, 29 Jun 2020 21:49:28 -0500
From:   Suman Anna <s-anna@ti.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Lokesh Vutla <lokeshvutla@ti.com>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Suman Anna <s-anna@ti.com>
Subject: [PATCH v2 3/4] remoteproc: k3-r5: Initialize TCM memories for ECC
Date:   Mon, 29 Jun 2020 21:49:21 -0500
Message-ID: <20200630024922.32491-4-s-anna@ti.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200630024922.32491-1-s-anna@ti.com>
References: <20200630024922.32491-1-s-anna@ti.com>
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
---
v2:
 - Fixed the logic of initializing TCMs even when the resets deassertion
   failed
 - Dropped the confusing last sentence from the 2nd paragraph of the
   patch description
 - Revised the patch title to move away from remoteproc/k3-r5
 - Dropped Mathieu's Acked-by because of the changes
v1: https://patchwork.kernel.org/patch/11456371/

 drivers/remoteproc/ti_k3_r5_remoteproc.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/ti_k3_r5_remoteproc.c b/drivers/remoteproc/ti_k3_r5_remoteproc.c
index c4f99e59dc2f..aca0eaf42a38 100644
--- a/drivers/remoteproc/ti_k3_r5_remoteproc.c
+++ b/drivers/remoteproc/ti_k3_r5_remoteproc.c
@@ -363,11 +363,24 @@ static int k3_r5_rproc_prepare(struct rproc *rproc)
 
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
2.26.0

