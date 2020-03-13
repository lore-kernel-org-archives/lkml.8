Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B21D6C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 08:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A27B20754
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 08:17:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="nOJFgzAk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbgCMIRi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 04:17:38 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:42626 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgCMIRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 04:17:37 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 02D8Haqu121340;
        Fri, 13 Mar 2020 03:17:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1584087456;
        bh=SLdw2vgatE17/Hia3A70cAESnROgW6CNX2mOqTF12SM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=nOJFgzAkOcHQ/fEB/bz7udQ3WZmpHEFZsU8ZLSPf70SFYGayzmFYSGFAlkF86X/91
         QMPFQ9ksEk/52tHFftEfLeD4alQK3q1WYtdj3AXLRi0Kzopc2Th8po6diiEN2pICAr
         87JeStPPMEm68U1gCpQTGGUBWcBNAEHkTiP9zaTY=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02D8HaYx020647;
        Fri, 13 Mar 2020 03:17:36 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 13
 Mar 2020 03:17:36 -0500
Received: from localhost.localdomain (10.64.41.19) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 13 Mar 2020 03:17:35 -0500
Received: from sokoban.bb.dnainternet.fi (ileax41-snat.itg.ti.com [10.172.224.153])
        by localhost.localdomain (8.15.2/8.15.2) with ESMTP id 02D8HQlZ097835;
        Fri, 13 Mar 2020 03:17:34 -0500
From:   Tero Kristo <t-kristo@ti.com>
To:     <bjorn.andersson@linaro.org>, <ohad@wizery.com>,
        <linux-remoteproc@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <mathieu.poirier@linaro.org>,
        <s-anna@ti.com>, <afd@ti.com>, Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv8 03/15] remoteproc/omap: Add a sanity check for DSP boot address alignment
Date:   Fri, 13 Mar 2020 10:17:06 +0200
Message-ID: <20200313081718.30612-4-t-kristo@ti.com>
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

The DSP remote processors on OMAP SoCs require a boot register to
be programmed with a boot address, and this boot address needs to
be on a 1KB boundary. The current code is simply masking the boot
address appropriately without performing any sanity checks before
releasing the resets. An unaligned boot address results in an
undefined execution behavior and can result in various bus errors
like MMU Faults or L3 NoC errors. Such errors are hard to debug and
can be easily avoided by adding a sanity check for the alignment
before booting a DSP remote processor.

Signed-off-by: Suman Anna <s-anna@ti.com>
Signed-off-by: Tero Kristo <t-kristo@ti.com>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Reviewed-by: Andrew F. Davis <afd@ti.com>
Acked-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
v8:
  - Fixed return value of omap_rproc_write_dsp_boot_addr to properly
    return the status of the regmap write

 drivers/remoteproc/omap_remoteproc.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/remoteproc/omap_remoteproc.c b/drivers/remoteproc/omap_remoteproc.c
index d47d5ded651a..2020d4e3264d 100644
--- a/drivers/remoteproc/omap_remoteproc.c
+++ b/drivers/remoteproc/omap_remoteproc.c
@@ -121,14 +121,23 @@ static void omap_rproc_kick(struct rproc *rproc, int vqid)
  * @rproc: handle of a remote processor
  *
  * Set boot address for a supported DSP remote processor.
+ *
+ * Return: 0 on success, or -EINVAL if boot address is not aligned properly
  */
-static void omap_rproc_write_dsp_boot_addr(struct rproc *rproc)
+static int omap_rproc_write_dsp_boot_addr(struct rproc *rproc)
 {
+	struct device *dev = rproc->dev.parent;
 	struct omap_rproc *oproc = rproc->priv;
 	struct omap_rproc_boot_data *bdata = oproc->boot_data;
 	u32 offset = bdata->boot_reg;
 
-	regmap_write(bdata->syscon, offset, rproc->bootaddr);
+	if (rproc->bootaddr & (SZ_1K - 1)) {
+		dev_err(dev, "invalid boot address 0x%x, must be aligned on a 1KB boundary\n",
+			rproc->bootaddr);
+		return -EINVAL;
+	}
+
+	return regmap_write(bdata->syscon, offset, rproc->bootaddr);
 }
 
 /*
@@ -145,8 +154,11 @@ static int omap_rproc_start(struct rproc *rproc)
 	int ret;
 	struct mbox_client *client = &oproc->client;
 
-	if (oproc->boot_data)
-		omap_rproc_write_dsp_boot_addr(rproc);
+	if (oproc->boot_data) {
+		ret = omap_rproc_write_dsp_boot_addr(rproc);
+		if (ret)
+			return ret;
+	}
 
 	client->dev = dev;
 	client->tx_done = NULL;
-- 
2.17.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
