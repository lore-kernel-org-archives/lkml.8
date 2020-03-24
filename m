Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E40C54FD0
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 20:18:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC37C208CA
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 20:18:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="BCOA2Haf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728181AbgCXUSi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 16:18:38 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:52562 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727688AbgCXUSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 16:18:36 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 02OKIWFr089263;
        Tue, 24 Mar 2020 15:18:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1585081112;
        bh=KBK4nAkGYfaW/z7wnAp3kL3aRKdiM3zDk7Y34dWImPM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=BCOA2Haf/SkSB1hh68ZQJx+5tIZf56DEPfY9szr5oW/ZUVEF47U+00yzBXi18Del+
         U4AY8hSHMC8Udlvl6xwC3vUzAUEJHHh1APGT0MQKHcM7RnvPkxCbiXdgzKuQsH98Q2
         klTUgZgNUD6+1PG8AnYfpvr7JHRQNGaFqj/Yzz08=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 02OKIWI6015823
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 24 Mar 2020 15:18:32 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 24
 Mar 2020 15:18:31 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 24 Mar 2020 15:18:31 -0500
Received: from fllv0103.dal.design.ti.com (fllv0103.dal.design.ti.com [10.247.120.73])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02OKIVIW071981;
        Tue, 24 Mar 2020 15:18:31 -0500
Received: from localhost ([10.250.35.147])
        by fllv0103.dal.design.ti.com (8.14.7/8.14.7) with ESMTP id 02OKIVML084995;
        Tue, 24 Mar 2020 15:18:31 -0500
From:   Suman Anna <s-anna@ti.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Lokesh Vutla <lokeshvutla@ti.com>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Suman Anna <s-anna@ti.com>
Subject: [PATCH 6/7] remoteproc/k3-r5: Initialize TCM memories for ECC
Date:   Tue, 24 Mar 2020 15:18:18 -0500
Message-ID: <20200324201819.23095-7-s-anna@ti.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200324201819.23095-1-s-anna@ti.com>
References: <20200324201819.23095-1-s-anna@ti.com>
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
only manage the access and visibility from R5. The Core1 TCMs are not
used and accessible in LockStep mode, so they are only initialized
in Split-mode.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 drivers/remoteproc/ti_k3_r5_remoteproc.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/remoteproc/ti_k3_r5_remoteproc.c b/drivers/remoteproc/ti_k3_r5_remoteproc.c
index 655f8f14c37d..8c9b7ae5d8b7 100644
--- a/drivers/remoteproc/ti_k3_r5_remoteproc.c
+++ b/drivers/remoteproc/ti_k3_r5_remoteproc.c
@@ -366,6 +366,17 @@ static int k3_r5_rproc_prepare(struct rproc *rproc)
 		dev_err(dev, "unable to enable cores for TCM loading, ret = %d\n",
 			ret);
 
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
 	return ret;
 }
 
-- 
2.23.0

