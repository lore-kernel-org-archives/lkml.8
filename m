Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95430C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 17:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BDF320661
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 17:42:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="qdhtuQt7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729926AbgBKRmt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 12:42:49 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:10640 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729747AbgBKRmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 12:42:47 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01BHgSbG007670;
        Tue, 11 Feb 2020 18:42:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=wAkz+ySSsKKVKfrYFI4i7+3VEwwlHhF9+EHwMswyto8=;
 b=qdhtuQt7jg48KoqatAag9tRnFzNGUzGW+HX1gAFQII3t3PHNDzrhUN3O2QU7JSElA118
 N1UfacxHw4sgXd9JvNXAVe5HO8ZNNUm7hrrfpsY3TD2PohIbiil4hSf5AOWfsX9+eryB
 TMawgcVW+5/rtktmsRxpvAhGSgOl6DeIKh3TCRtCcjcUAWSh/Safkzt6jO1HVxTX4D9v
 SxiqhUEPF0l3J+pkUoontNg/R7du9qK/vrvCzlFsEKmbGlXPwPKO2YQdM+EOqETaa3Z7
 W80/OVcIqruwMwmTUCwvSIVyKE2xoUbSxblTmD+xR94RCXMnART5kSIXqJWf8xfyeQjZ EA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2y1ufh7pju-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Feb 2020 18:42:39 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D59D810002A;
        Tue, 11 Feb 2020 18:42:34 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C55222C8E8C;
        Tue, 11 Feb 2020 18:42:34 +0100 (CET)
Received: from localhost (10.75.127.46) by SFHDAG3NODE1.st.com (10.75.127.7)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 11 Feb 2020 18:42:33
 +0100
From:   Arnaud Pouliquen <arnaud.pouliquen@st.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     Ohad Ben-Cohen <ohad@wizery.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Loic PALLARDY <loic.pallardy@st.com>,
        <arnaud.pouliquen@st.com>, Suman Anna <s-anna@ti.com>,
        Fabien DESSENNE <fabien.dessenne@st.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH v5 2/3] remoteproc: stm32: add support for co-processor booted before kernel
Date:   Tue, 11 Feb 2020 18:42:04 +0100
Message-ID: <20200211174205.22247-3-arnaud.pouliquen@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200211174205.22247-1-arnaud.pouliquen@st.com>
References: <20200211174205.22247-1-arnaud.pouliquen@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG8NODE2.st.com (10.75.127.23) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-11_05:2020-02-10,2020-02-11 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabien Dessenne <fabien.dessenne@st.com>

Add support of a remote firmware, preloaded by the boot loader.
Two backup registers are used to retrieve the state of the remote
firmware and to get the optional resource table address.

Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 drivers/remoteproc/stm32_rproc.c | 205 ++++++++++++++++++++++++++++---
 1 file changed, 191 insertions(+), 14 deletions(-)

diff --git a/drivers/remoteproc/stm32_rproc.c b/drivers/remoteproc/stm32_rproc.c
index a18f88044111..3d1e0774318c 100644
--- a/drivers/remoteproc/stm32_rproc.c
+++ b/drivers/remoteproc/stm32_rproc.c
@@ -38,6 +38,15 @@
 #define STM32_MBX_VQ1_ID	1
 #define STM32_MBX_SHUTDOWN	"shutdown"
 
+#define RSC_TBL_SIZE		(1024)
+
+#define COPRO_STATE_OFF		0
+#define COPRO_STATE_INIT	1
+#define COPRO_STATE_CRUN	2
+#define COPRO_STATE_CSTOP	3
+#define COPRO_STATE_STANDBY	4
+#define COPRO_STATE_CRASH	5
+
 struct stm32_syscon {
 	struct regmap *map;
 	u32 reg;
@@ -70,12 +79,14 @@ struct stm32_rproc {
 	struct reset_control *rst;
 	struct stm32_syscon hold_boot;
 	struct stm32_syscon pdds;
+	struct stm32_syscon copro_state;
 	int wdg_irq;
 	u32 nb_rmems;
 	struct stm32_rproc_mem *rmems;
 	struct stm32_mbox mb[MBOX_NB_MBX];
 	struct workqueue_struct *workqueue;
 	bool secured_soc;
+	void __iomem *rsc_va;
 };
 
 static int stm32_rproc_pa_to_da(struct rproc *rproc, phys_addr_t pa, u64 *da)
@@ -98,6 +109,28 @@ static int stm32_rproc_pa_to_da(struct rproc *rproc, phys_addr_t pa, u64 *da)
 	return -EINVAL;
 }
 
+static int stm32_rproc_da_to_pa(struct rproc *rproc, u64 da, phys_addr_t *pa)
+{
+	unsigned int i;
+	struct stm32_rproc *ddata = rproc->priv;
+	struct stm32_rproc_mem *p_mem;
+
+	for (i = 0; i < ddata->nb_rmems; i++) {
+		p_mem = &ddata->rmems[i];
+
+		if (da < p_mem->dev_addr ||
+		    da >= p_mem->dev_addr + p_mem->size)
+			continue;
+		*pa = da - p_mem->dev_addr + p_mem->bus_addr;
+		dev_dbg(rproc->dev.parent, "da %llx to pa %#x\n", da, *pa);
+		return 0;
+	}
+
+	dev_err(rproc->dev.parent, "can't translate da %llx\n", da);
+
+	return -EINVAL;
+}
+
 static int stm32_rproc_mem_alloc(struct rproc *rproc,
 				 struct rproc_mem_entry *mem)
 {
@@ -127,6 +160,15 @@ static int stm32_rproc_mem_release(struct rproc *rproc,
 	return 0;
 }
 
+static int stm32_rproc_elf_load_segments(struct rproc *rproc,
+					 const struct firmware *fw)
+{
+	if (!rproc->skip_fw_load)
+		return rproc_elf_load_segments(rproc, fw);
+
+	return 0;
+}
+
 static int stm32_rproc_of_memory_translations(struct rproc *rproc)
 {
 	struct device *parent, *dev = rproc->dev.parent;
@@ -197,9 +239,34 @@ static int stm32_rproc_mbox_idx(struct rproc *rproc, const unsigned char *name)
 static int stm32_rproc_elf_load_rsc_table(struct rproc *rproc,
 					  const struct firmware *fw)
 {
-	if (rproc_elf_load_rsc_table(rproc, fw))
-		dev_warn(&rproc->dev, "no resource table found for this firmware\n");
+	struct resource_table *table = NULL;
+	struct stm32_rproc *ddata = rproc->priv;
+
+	if (!rproc->skip_fw_load) {
+		if (rproc_elf_load_rsc_table(rproc, fw))
+			goto no_rsc_table;
+
+		return 0;
+	}
+
+	if (ddata->rsc_va) {
+		table = (struct resource_table *)ddata->rsc_va;
+		/* Assuming that the resource table fits in 1kB is fair */
+		rproc->cached_table = kmemdup(table, RSC_TBL_SIZE, GFP_KERNEL);
+		if (!rproc->cached_table)
+			return -ENOMEM;
+
+		rproc->table_ptr = rproc->cached_table;
+		rproc->table_sz = RSC_TBL_SIZE;
+		return 0;
+	}
 
+	rproc->cached_table = NULL;
+	rproc->table_ptr = NULL;
+	rproc->table_sz = 0;
+
+no_rsc_table:
+	dev_warn(&rproc->dev, "no resource table found for this firmware\n");
 	return 0;
 }
 
@@ -259,6 +326,36 @@ static int stm32_rproc_parse_fw(struct rproc *rproc, const struct firmware *fw)
 	return stm32_rproc_elf_load_rsc_table(rproc, fw);
 }
 
+static struct resource_table *
+stm32_rproc_elf_find_loaded_rsc_table(struct rproc *rproc,
+				      const struct firmware *fw)
+{
+	struct stm32_rproc *ddata = rproc->priv;
+
+	if (!rproc->skip_fw_load)
+		return rproc_elf_find_loaded_rsc_table(rproc, fw);
+
+	return (struct resource_table *)ddata->rsc_va;
+}
+
+static int stm32_rproc_elf_sanity_check(struct rproc *rproc,
+					const struct firmware *fw)
+{
+	if (!rproc->skip_fw_load)
+		return rproc_elf_sanity_check(rproc, fw);
+
+	return 0;
+}
+
+static u32 stm32_rproc_elf_get_boot_addr(struct rproc *rproc,
+					 const struct firmware *fw)
+{
+	if (!rproc->skip_fw_load)
+		return rproc_elf_get_boot_addr(rproc, fw);
+
+	return 0;
+}
+
 static irqreturn_t stm32_rproc_wdg(int irq, void *data)
 {
 	struct rproc *rproc = data;
@@ -420,7 +517,7 @@ static int stm32_rproc_start(struct rproc *rproc)
 	stm32_rproc_add_coredump_trace(rproc);
 
 	/* clear remote proc Deep Sleep */
-	if (ddata->pdds.map) {
+	if (ddata->pdds.map && !rproc->skip_fw_load) {
 		err = regmap_update_bits(ddata->pdds.map, ddata->pdds.reg,
 					 ddata->pdds.mask, 0);
 		if (err) {
@@ -429,9 +526,15 @@ static int stm32_rproc_start(struct rproc *rproc)
 		}
 	}
 
-	err = stm32_rproc_set_hold_boot(rproc, false);
-	if (err)
-		return err;
+	/*
+	 * If M4 previously started by bootloader, just guarantee holdboot
+	 * is set to catch any crash.
+	 */
+	if (!rproc->skip_fw_load) {
+		err = stm32_rproc_set_hold_boot(rproc, false);
+		if (err)
+			return err;
+	}
 
 	return stm32_rproc_set_hold_boot(rproc, true);
 }
@@ -473,6 +576,21 @@ static int stm32_rproc_stop(struct rproc *rproc)
 		}
 	}
 
+	/* update copro state to OFF */
+	if (ddata->copro_state.map) {
+		err = regmap_update_bits(ddata->copro_state.map,
+					 ddata->copro_state.reg,
+					 ddata->copro_state.mask,
+					 COPRO_STATE_OFF);
+		if (err) {
+			dev_err(&rproc->dev, "failed to set copro state\n");
+			return err;
+		}
+	}
+
+	/* Reset skip_fw_load state as we stop the co-processor */
+	rproc->skip_fw_load = false;
+
 	return 0;
 }
 
@@ -502,11 +620,11 @@ static struct rproc_ops st_rproc_ops = {
 	.start		= stm32_rproc_start,
 	.stop		= stm32_rproc_stop,
 	.kick		= stm32_rproc_kick,
-	.load		= rproc_elf_load_segments,
+	.load		= stm32_rproc_elf_load_segments,
 	.parse_fw	= stm32_rproc_parse_fw,
-	.find_loaded_rsc_table = rproc_elf_find_loaded_rsc_table,
-	.sanity_check	= rproc_elf_sanity_check,
-	.get_boot_addr	= rproc_elf_get_boot_addr,
+	.find_loaded_rsc_table = stm32_rproc_elf_find_loaded_rsc_table,
+	.sanity_check	= stm32_rproc_elf_sanity_check,
+	.get_boot_addr	= stm32_rproc_elf_get_boot_addr,
 };
 
 static const struct of_device_id stm32_rproc_match[] = {
@@ -543,8 +661,10 @@ static int stm32_rproc_parse_dt(struct platform_device *pdev)
 	struct device_node *np = dev->of_node;
 	struct rproc *rproc = platform_get_drvdata(pdev);
 	struct stm32_rproc *ddata = rproc->priv;
-	struct stm32_syscon tz;
-	unsigned int tzen;
+	struct stm32_syscon tz, rsctbl;
+	phys_addr_t rsc_pa;
+	u32 rsc_da;
+	unsigned int tzen, state;
 	int err, irq;
 
 	irq = platform_get_irq(pdev, 0);
@@ -602,11 +722,62 @@ static int stm32_rproc_parse_dt(struct platform_device *pdev)
 
 	err = stm32_rproc_get_syscon(np, "st,syscfg-pdds", &ddata->pdds);
 	if (err)
-		dev_warn(dev, "failed to get pdds\n");
+		dev_warn(dev, "pdds not supported\n");
 
 	rproc->auto_boot = of_property_read_bool(np, "st,auto-boot");
 
-	return stm32_rproc_of_memory_translations(rproc);
+	err = stm32_rproc_of_memory_translations(rproc);
+	if (err)
+		return err;
+
+	/* check if the coprocessor has been started from the bootloader */
+	err = stm32_rproc_get_syscon(np, "st,syscfg-copro-state",
+				     &ddata->copro_state);
+	if (err) {
+		/* no copro_state syscon (optional) */
+		dev_warn(dev, "copro_state not supported\n");
+		goto bail;
+	}
+
+	err = regmap_read(ddata->copro_state.map, ddata->copro_state.reg,
+			  &state);
+	if (err) {
+		dev_err(&rproc->dev, "failed to read copro state\n");
+		return err;
+	}
+
+	if (state == COPRO_STATE_CRUN) {
+		rproc->skip_fw_load = true;
+
+		if (stm32_rproc_get_syscon(np, "st,syscfg-rsc-tbl", &rsctbl)) {
+			/* no rsc table syscon (optional) */
+			dev_warn(dev, "rsc tbl syscon not supported\n");
+			goto bail;
+		}
+
+		err = regmap_read(rsctbl.map, rsctbl.reg, &rsc_da);
+		if (err) {
+			dev_err(&rproc->dev, "failed to read rsc tbl addr\n");
+			return err;
+		}
+		if (!rsc_da)
+			/* no rsc table */
+			goto bail;
+
+		err = stm32_rproc_da_to_pa(rproc, rsc_da, &rsc_pa);
+		if (err)
+			return err;
+
+		ddata->rsc_va = devm_ioremap_wc(dev, rsc_pa, RSC_TBL_SIZE);
+		if (IS_ERR_OR_NULL(ddata->rsc_va)) {
+			dev_err(dev, "Unable to map memory region: %pa+%zx\n",
+				&rsc_pa, RSC_TBL_SIZE);
+			ddata->rsc_va = NULL;
+			return -ENOMEM;
+		}
+	}
+bail:
+	return 0;
 }
 
 static int stm32_rproc_probe(struct platform_device *pdev)
@@ -640,6 +811,12 @@ static int stm32_rproc_probe(struct platform_device *pdev)
 	if (ret)
 		goto free_wkq;
 
+	if (!rproc->skip_fw_load) {
+		ret = stm32_rproc_stop(rproc);
+		if (ret)
+			goto free_rproc;
+	}
+
 	ret = stm32_rproc_request_mbox(rproc);
 	if (ret)
 		goto free_rproc;
-- 
2.17.1

