Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14DA0C4CECE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 08:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE6042072C
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 08:17:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="nRFo8Y1N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgCMIRs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 04:17:48 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:57372 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726533AbgCMIRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 04:17:42 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 02D8HfMt117711;
        Fri, 13 Mar 2020 03:17:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1584087461;
        bh=2VnBgxbP2qm2a2VEa4g46ntomxLnyRUJqsLVK6FDmPs=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=nRFo8Y1N1lBPBtBg66N52ClWiEocetVCQy+UP9c6ZSbYdoqwAiZelJal7XrR7PORs
         hdlYRFliMZ5PdXmlICNUFN2ou5g5rzWFPhHKXu2phig8Fok1QBcHhaSVDmeKouvefx
         F0iDao6Ecd7SJJUXJlKOmJUVI6Q+xMdE6o+K4+lI=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02D8Hfks020818;
        Fri, 13 Mar 2020 03:17:41 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 13
 Mar 2020 03:17:40 -0500
Received: from localhost.localdomain (10.64.41.19) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 13 Mar 2020 03:17:40 -0500
Received: from sokoban.bb.dnainternet.fi (ileax41-snat.itg.ti.com [10.172.224.153])
        by localhost.localdomain (8.15.2/8.15.2) with ESMTP id 02D8HQlb097835;
        Fri, 13 Mar 2020 03:17:38 -0500
From:   Tero Kristo <t-kristo@ti.com>
To:     <bjorn.andersson@linaro.org>, <ohad@wizery.com>,
        <linux-remoteproc@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <mathieu.poirier@linaro.org>,
        <s-anna@ti.com>, <afd@ti.com>, Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv8 05/15] remoteproc/omap: Add the rproc ops .da_to_va() implementation
Date:   Fri, 13 Mar 2020 10:17:08 +0200
Message-ID: <20200313081718.30612-6-t-kristo@ti.com>
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

An implementation for the rproc ops .da_to_va() has been added
that provides the address translation between device addresses
to kernel virtual addresses for internal RAMs present on that
particular remote processor device. The implementation provides
the translations based on the addresses parsed and stored during
the probe.

This ops gets invoked by the exported rproc_da_to_va() function
and allows the remoteproc core's ELF loader to be able to load
program data directly into the internal memories.

Signed-off-by: Suman Anna <s-anna@ti.com>
Signed-off-by: Tero Kristo <t-kristo@ti.com>
Reviewed-by: Andrew F. Davis <afd@ti.com>
Acked-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/remoteproc/omap_remoteproc.c | 40 ++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/remoteproc/omap_remoteproc.c b/drivers/remoteproc/omap_remoteproc.c
index 251db31c74a9..9a82d5c4a06b 100644
--- a/drivers/remoteproc/omap_remoteproc.c
+++ b/drivers/remoteproc/omap_remoteproc.c
@@ -245,10 +245,50 @@ static int omap_rproc_stop(struct rproc *rproc)
 	return 0;
 }
 
+/**
+ * omap_rproc_da_to_va() - internal memory translation helper
+ * @rproc: remote processor to apply the address translation for
+ * @da: device address to translate
+ * @len: length of the memory buffer
+ *
+ * Custom function implementing the rproc .da_to_va ops to provide address
+ * translation (device address to kernel virtual address) for internal RAMs
+ * present in a DSP or IPU device). The translated addresses can be used
+ * either by the remoteproc core for loading, or by any rpmsg bus drivers.
+ *
+ * Return: translated virtual address in kernel memory space on success,
+ *         or NULL on failure.
+ */
+static void *omap_rproc_da_to_va(struct rproc *rproc, u64 da, int len)
+{
+	struct omap_rproc *oproc = rproc->priv;
+	int i;
+	u32 offset;
+
+	if (len <= 0)
+		return NULL;
+
+	if (!oproc->num_mems)
+		return NULL;
+
+	for (i = 0; i < oproc->num_mems; i++) {
+		if (da >= oproc->mem[i].dev_addr && da + len <=
+		    oproc->mem[i].dev_addr + oproc->mem[i].size) {
+			offset = da - oproc->mem[i].dev_addr;
+			/* __force to make sparse happy with type conversion */
+			return (__force void *)(oproc->mem[i].cpu_addr +
+						offset);
+		}
+	}
+
+	return NULL;
+}
+
 static const struct rproc_ops omap_rproc_ops = {
 	.start		= omap_rproc_start,
 	.stop		= omap_rproc_stop,
 	.kick		= omap_rproc_kick,
+	.da_to_va	= omap_rproc_da_to_va,
 };
 
 static const struct omap_rproc_mem_data ipu_mems[] = {
-- 
2.17.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
