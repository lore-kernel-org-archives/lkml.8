Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA63BC54EEB
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 20:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99FE3208CA
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 20:18:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="S3lGOy1o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728209AbgCXUSl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 16:18:41 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:43620 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727513AbgCXUSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 16:18:39 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 02OKIXkY039621;
        Tue, 24 Mar 2020 15:18:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1585081113;
        bh=rgcK0izV60vaMgOYTwIlec7ZHpQ6A2jrrTou43/lA6E=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=S3lGOy1olcbdIpBpppcydK7E44YzT0jssboimdq/4q7x9+PsNW230ogzxkIWVK99L
         5m8FWf8BrfuXL69jyax0CYue7xPaul7uXtg2oTUFzPtDWGW5MkEzJCAymmyZjHsmEc
         7a4KcaLuhNrRXrao9VNlsBtUsinzfYCpoazMiPOE=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 02OKIXI3065754
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 24 Mar 2020 15:18:33 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 24
 Mar 2020 15:18:33 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 24 Mar 2020 15:18:32 -0500
Received: from fllv0103.dal.design.ti.com (fllv0103.dal.design.ti.com [10.247.120.73])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02OKIWb4113597;
        Tue, 24 Mar 2020 15:18:32 -0500
Received: from localhost ([10.250.35.147])
        by fllv0103.dal.design.ti.com (8.14.7/8.14.7) with ESMTP id 02OKIWI1085001;
        Tue, 24 Mar 2020 15:18:32 -0500
From:   Suman Anna <s-anna@ti.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Lokesh Vutla <lokeshvutla@ti.com>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Suman Anna <s-anna@ti.com>
Subject: [PATCH 7/7] remoteproc/k3-r5: Add loading support for on-chip SRAM regions
Date:   Tue, 24 Mar 2020 15:18:19 -0500
Message-ID: <20200324201819.23095-8-s-anna@ti.com>
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
 drivers/remoteproc/ti_k3_r5_remoteproc.c | 106 ++++++++++++++++++++++-
 1 file changed, 105 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/ti_k3_r5_remoteproc.c b/drivers/remoteproc/ti_k3_r5_remoteproc.c
index 8c9b7ae5d8b7..0ae0b66ec9eb 100644
--- a/drivers/remoteproc/ti_k3_r5_remoteproc.c
+++ b/drivers/remoteproc/ti_k3_r5_remoteproc.c
@@ -85,7 +85,9 @@ struct k3_r5_cluster {
  * @dev: cached device pointer
  * @rproc: rproc handle representing this core
  * @mem: internal memory regions data
+ * @sram: on-chip SRAM memory regions data
  * @num_mems: number of internal memory regions
+ * @num_sram: number of on-chip SRAM memory regions
  * @reset: reset control handle
  * @tsp: TI-SCI processor control handle
  * @ti_sci: TI-SCI handle
@@ -99,7 +101,9 @@ struct k3_r5_core {
 	struct device *dev;
 	struct rproc *rproc;
 	struct k3_r5_mem *mem;
+	struct k3_r5_mem *sram;
 	int num_mems;
+	int num_sram;
 	struct reset_control *reset;
 	struct ti_sci_proc *tsp;
 	const struct ti_sci_handle *ti_sci;
@@ -585,6 +589,18 @@ static void *k3_r5_rproc_da_to_va(struct rproc *rproc, u64 da, size_t len)
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
@@ -1017,6 +1033,77 @@ static int k3_r5_core_of_get_internal_memories(struct platform_device *pdev,
 	return ret;
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
+	core->sram = kcalloc(num_sram, sizeof(*core->sram), GFP_KERNEL);
+	if (!core->sram)
+		return -ENOMEM;
+
+	for (i = 0; i < num_sram; i++) {
+		sram_np = of_parse_phandle(np, "sram", i);
+		if (!sram_np) {
+			ret = -EINVAL;
+			goto fail;
+		}
+
+		if (!of_device_is_available(sram_np)) {
+			of_node_put(sram_np);
+			ret = -EINVAL;
+			goto fail;
+		}
+
+		ret = of_address_to_resource(sram_np, 0, &res);
+		of_node_put(sram_np);
+		if (ret) {
+			ret = -EINVAL;
+			goto fail;
+		}
+		core->sram[i].bus_addr = res.start;
+		core->sram[i].dev_addr = res.start;
+		core->sram[i].size = resource_size(&res);
+		core->sram[i].cpu_addr = ioremap_wc(res.start,
+						    resource_size(&res));
+		if (!core->sram[i].cpu_addr) {
+			dev_err(dev, "failed to parse and map sram%d memory at %pad\n",
+				i, &res.start);
+			ret = -ENOMEM;
+			goto fail;
+		}
+
+		dev_dbg(dev, "memory    sram%d: bus addr %pa size 0x%zx va %pK da 0x%x\n",
+			i, &core->sram[i].bus_addr,
+			core->sram[i].size, core->sram[i].cpu_addr,
+			core->sram[i].dev_addr);
+	}
+	core->num_sram = num_sram;
+
+	return 0;
+
+fail:
+	for (i--; i >= 0; i--) {
+		if (core->sram[i].cpu_addr)
+			iounmap(core->sram[i].cpu_addr);
+	}
+	kfree(core->sram);
+
+	return ret;
+}
+
 static
 struct ti_sci_proc *k3_r5_core_of_get_tsp(struct device *dev,
 					  const struct ti_sci_handle *sci)
@@ -1048,7 +1135,7 @@ static int k3_r5_core_of_init(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
 	struct k3_r5_core *core;
-	int ret, ret1;
+	int ret, ret1, i;
 
 	core = devm_kzalloc(dev, sizeof(*core), GFP_KERNEL);
 	if (!core)
@@ -1125,10 +1212,23 @@ static int k3_r5_core_of_init(struct platform_device *pdev)
 		goto err_intmem;
 	}
 
+	ret = k3_r5_core_of_get_sram_memories(pdev, core);
+	if (ret) {
+		dev_err(dev, "failed to get sram memories, ret = %d\n", ret);
+		goto err_sram;
+	}
+
 	platform_set_drvdata(pdev, core);
 
 	return 0;
 
+err_sram:
+	for (i = 0; i < core->num_mems; i++) {
+		devm_iounmap(dev, core->mem[i].cpu_addr);
+		devm_release_mem_region(dev, core->mem[i].bus_addr,
+					core->mem[i].size);
+	}
+	devm_kfree(dev, core->mem);
 err_intmem:
 	ret1 = ti_sci_proc_release(core->tsp);
 	if (ret1)
@@ -1156,6 +1256,10 @@ static int k3_r5_core_of_exit(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	int i, ret;
 
+	for (i = 0; i < core->num_sram; i++)
+		iounmap(core->sram[i].cpu_addr);
+	kfree(core->sram);
+
 	for (i = 0; i < core->num_mems; i++) {
 		devm_release_mem_region(dev, core->mem[i].bus_addr,
 					core->mem[i].size);
-- 
2.23.0

