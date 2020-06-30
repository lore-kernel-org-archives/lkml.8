Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 734C3C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 02:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4905E2071A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 02:49:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="tnjlF0sP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728716AbgF3Ctj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 22:49:39 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:45388 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbgF3Cth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 22:49:37 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 05U2nTtM048175;
        Mon, 29 Jun 2020 21:49:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1593485369;
        bh=XyAVH615sMRx3zwc7jKfCZgvfg3V97TNnw+Om9xj2gA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=tnjlF0sPN76vGcdO2OKAacn6xsOdlu8KaM808+4MsJITo+P70x8Oz7CQhM1gwSzTD
         0dMa7M9p2OaS7efPdw3L/hqGw8DgPa/qQcLGa+/DXHpR++5C+a40s7dmYO0hoN1jbz
         oUHLXQk8dUsOn3wn7uPPsoQSniI34nbFX/Wl2jFI=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 05U2nTVn064760
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 29 Jun 2020 21:49:29 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 29
 Jun 2020 21:49:29 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 29 Jun 2020 21:49:29 -0500
Received: from fllv0103.dal.design.ti.com (fllv0103.dal.design.ti.com [10.247.120.73])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 05U2nTte083925;
        Mon, 29 Jun 2020 21:49:29 -0500
Received: from localhost ([10.250.48.148])
        by fllv0103.dal.design.ti.com (8.14.7/8.14.7) with ESMTP id 05U2nTXA029160;
        Mon, 29 Jun 2020 21:49:29 -0500
From:   Suman Anna <s-anna@ti.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Lokesh Vutla <lokeshvutla@ti.com>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Suman Anna <s-anna@ti.com>
Subject: [PATCH v2 4/4] remoteproc: k3-r5: Add loading support for on-chip SRAM regions
Date:   Mon, 29 Jun 2020 21:49:22 -0500
Message-ID: <20200630024922.32491-5-s-anna@ti.com>
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

The K3 SoCs has various internal on-chip SRAM memories like the SRAM
within the MCU domain or the shared MSMC RAM within NavSS that can be
used for multiple purposes. One such purpose is to have the R5F cores
use a portion of such on-chip SRAM for fast-access data or to directly
execute code.

Add support to the K3 R5 remoteproc driver to parse and support
loading into such memories. The SRAM regions need to be mapped as
normal non-cacheable memory to avoid kernel crashes when the remoteproc
loader code uses the Arm64 memset library function (the "DC ZVA"
instruction throws a alignment fault on device type memory).

These SRAM regions are completely optional as not all firmware images
require these memories, and any such memory has to be reserved as such
in the DTS files.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
v2:
 - Adapted to use various devm_ functions resulting in a smaller patch
 - Failure path code is dropped as a result in k3_r5_core_of_exit() and
   k3_r5_core_of_get_sram_memories()
 - Dropped unneeded whitespaces in a debug trace
 - Revised the patch title to move away from remoteproc/k3-r5
 - Dropped Mathieu's Acked-by because of the changes
v1: https://patchwork.kernel.org/patch/11456373/

 drivers/remoteproc/ti_k3_r5_remoteproc.c | 79 ++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/drivers/remoteproc/ti_k3_r5_remoteproc.c b/drivers/remoteproc/ti_k3_r5_remoteproc.c
index aca0eaf42a38..ac8ae29f38aa 100644
--- a/drivers/remoteproc/ti_k3_r5_remoteproc.c
+++ b/drivers/remoteproc/ti_k3_r5_remoteproc.c
@@ -86,7 +86,9 @@ struct k3_r5_cluster {
  * @dev: cached device pointer
  * @rproc: rproc handle representing this core
  * @mem: internal memory regions data
+ * @sram: on-chip SRAM memory regions data
  * @num_mems: number of internal memory regions
+ * @num_sram: number of on-chip SRAM memory regions
  * @reset: reset control handle
  * @tsp: TI-SCI processor control handle
  * @ti_sci: TI-SCI handle
@@ -100,7 +102,9 @@ struct k3_r5_core {
 	struct device *dev;
 	struct rproc *rproc;
 	struct k3_r5_mem *mem;
+	struct k3_r5_mem *sram;
 	int num_mems;
+	int num_sram;
 	struct reset_control *reset;
 	struct ti_sci_proc *tsp;
 	const struct ti_sci_handle *ti_sci;
@@ -588,6 +592,18 @@ static void *k3_r5_rproc_da_to_va(struct rproc *rproc, u64 da, size_t len)
 		}
 	}
 
+	/* handle any SRAM regions using SoC-view addresses */
+	for (i = 0; i < core->num_sram; i++) {
+		dev_addr = core->sram[i].dev_addr;
+		size = core->sram[i].size;
+
+		if (da >= dev_addr && ((da + len) <= (dev_addr + size))) {
+			offset = da - dev_addr;
+			va = core->sram[i].cpu_addr + offset;
+			return (__force void *)va;
+		}
+	}
+
 	/* handle static DDR reserved memory regions */
 	for (i = 0; i < kproc->num_rmems; i++) {
 		dev_addr = kproc->rmem[i].dev_addr;
@@ -1030,6 +1046,63 @@ static int k3_r5_core_of_get_internal_memories(struct platform_device *pdev,
 	return 0;
 }
 
+static int k3_r5_core_of_get_sram_memories(struct platform_device *pdev,
+					   struct k3_r5_core *core)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct device *dev = &pdev->dev;
+	struct device_node *sram_np;
+	struct resource res;
+	int num_sram;
+	int i, ret;
+
+	num_sram = of_property_count_elems_of_size(np, "sram", sizeof(phandle));
+	if (num_sram <= 0) {
+		dev_dbg(dev, "device does not use reserved on-chip memories, num_sram = %d\n",
+			num_sram);
+		return 0;
+	}
+
+	core->sram = devm_kcalloc(dev, num_sram, sizeof(*core->sram), GFP_KERNEL);
+	if (!core->sram)
+		return -ENOMEM;
+
+	for (i = 0; i < num_sram; i++) {
+		sram_np = of_parse_phandle(np, "sram", i);
+		if (!sram_np)
+			return -EINVAL;
+
+		if (!of_device_is_available(sram_np)) {
+			of_node_put(sram_np);
+			return -EINVAL;
+		}
+
+		ret = of_address_to_resource(sram_np, 0, &res);
+		of_node_put(sram_np);
+		if (ret)
+			return -EINVAL;
+
+		core->sram[i].bus_addr = res.start;
+		core->sram[i].dev_addr = res.start;
+		core->sram[i].size = resource_size(&res);
+		core->sram[i].cpu_addr = devm_ioremap_wc(dev, res.start,
+							 resource_size(&res));
+		if (!core->sram[i].cpu_addr) {
+			dev_err(dev, "failed to parse and map sram%d memory at %pad\n",
+				i, &res.start);
+			return -ENOMEM;
+		}
+
+		dev_dbg(dev, "memory sram%d: bus addr %pa size 0x%zx va %pK da 0x%x\n",
+			i, &core->sram[i].bus_addr,
+			core->sram[i].size, core->sram[i].cpu_addr,
+			core->sram[i].dev_addr);
+	}
+	core->num_sram = num_sram;
+
+	return 0;
+}
+
 static
 struct ti_sci_proc *k3_r5_core_of_get_tsp(struct device *dev,
 					  const struct ti_sci_handle *sci)
@@ -1143,6 +1216,12 @@ static int k3_r5_core_of_init(struct platform_device *pdev)
 		goto err;
 	}
 
+	ret = k3_r5_core_of_get_sram_memories(pdev, core);
+	if (ret) {
+		dev_err(dev, "failed to get sram memories, ret = %d\n", ret);
+		goto err;
+	}
+
 	ret = ti_sci_proc_request(core->tsp);
 	if (ret < 0) {
 		dev_err(dev, "ti_sci_proc_request failed, ret = %d\n", ret);
-- 
2.26.0

