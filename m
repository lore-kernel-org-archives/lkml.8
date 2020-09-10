Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A24EC43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 18:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFCD220855
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 18:45:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eI3qrHhG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbgIJSpc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 14:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbgIJSPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 14:15:50 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A37BC061757
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 11:15:36 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id i22so10121857eja.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 11:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wdKwuIYahGAcwH7SDiKXLOr/d5VqpaT7+721VY4D3qo=;
        b=eI3qrHhGbPdo+Pf89ABvTc0AIa9X5nX6d3t12c55DCcDBPpQkeeZd/h2hgMf4F+UG7
         ygxsCrC2Sym6U6bxRilUTjVoO1mhhjSKyy/q4ZYEI1jYC+imyK4xpqkwqpKHCpAl6+7i
         KXTzQDR4nZlMv0TALH7hdRG3UgPBYGXeKI2wVlWnBO6v96Zm+Xa8w98k831TDYoGvn1t
         8NCFcE/+3fdYN7IVpM98UEvrAnpQYBXvafbRz7YZ1ooVIt/iNWuxK/GVPru5wcErbGEm
         FJOo+QQBxpWeZk4dZ9DwroIIdr6DIdVMnOEfT0PRShfqSfd8mUTWFdW7DfbI+u5fMPrJ
         ebuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wdKwuIYahGAcwH7SDiKXLOr/d5VqpaT7+721VY4D3qo=;
        b=b15SNhkSC/KLYTmVPH6k23bg6oy22/+r1Of2ox9LVJAuZw8BklrA7nxdP4jnG+S1AF
         krTMiv9YXUo+3IWxF/Rsm2K5BdkJ25/JIYEsIGcz1xGxuFpHVnBPwfVwtG2NyDRIHb/n
         10hc3XCSHU43jgSbQQym1d2cPhTYeK4UUoqlxfkZWDrfhqT96awHYHTzP0PB+VpgDFOA
         qbdPVPp6y1QR3vwSpQCJNku1AOKXuQXZ1Dhbw029bcggRNPPVWo0aGydI83GN6iy7Jfg
         VRnylUdaoPbST3nujl8+Db7KRftuUYTRTifzqPimVtZip1M8a72/ueIyVNjrnDLInHzP
         uhXw==
X-Gm-Message-State: AOAM531E2I8Ztvbc3TdrrJ3C8Z+VCb50rQSKJus3TU3PAEPH8EAYSkpp
        jcm6ZedwRMm2CI67wGSFupurewJtPUc=
X-Google-Smtp-Source: ABdhPJyydxp/DDhW6hAekE8TjqB3N4SpbDLJE0MUMED1iHSMc60n8VrO9yFeXVsH/nJhioYiL4+cTA==
X-Received: by 2002:a17:906:4755:: with SMTP id j21mr10454706ejs.228.1599761734012;
        Thu, 10 Sep 2020 11:15:34 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([213.57.90.10])
        by smtp.gmail.com with ESMTPSA id y6sm8636117edj.50.2020.09.10.11.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 11:15:33 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, SW_Drivers@habana.ai
Cc:     gregkh@linuxfoundation.org, Moti Haimovski <mhaimovski@habana.ai>
Subject: [PATCH 03/11] habanalabs: refactor MMU as device-oriented
Date:   Thu, 10 Sep 2020 21:15:16 +0300
Message-Id: <20200910181524.21460-3-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200910181524.21460-1-oded.gabbay@gmail.com>
References: <20200910181524.21460-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Moti Haimovski <mhaimovski@habana.ai>

As preparation to MMU v2, rework MMU to be device oriented
instantiated according to the device in hand.

Signed-off-by: Moti Haimovski <mhaimovski@habana.ai>
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/common/Makefile     |   2 +-
 drivers/misc/habanalabs/common/device.c     |   6 +
 drivers/misc/habanalabs/common/habanalabs.h |  49 +++-
 drivers/misc/habanalabs/common/mmu.c        | 309 ++++++++++++++++++++
 drivers/misc/habanalabs/common/mmu_v1.c     | 260 +++-------------
 5 files changed, 404 insertions(+), 222 deletions(-)
 create mode 100644 drivers/misc/habanalabs/common/mmu.c

diff --git a/drivers/misc/habanalabs/common/Makefile b/drivers/misc/habanalabs/common/Makefile
index e8ed12810517..eccd8c7dc62d 100644
--- a/drivers/misc/habanalabs/common/Makefile
+++ b/drivers/misc/habanalabs/common/Makefile
@@ -3,5 +3,5 @@ HL_COMMON_FILES := common/habanalabs_drv.o common/device.o common/context.o \
 		common/asid.o common/habanalabs_ioctl.o \
 		common/command_buffer.o common/hw_queue.o common/irq.o \
 		common/sysfs.o common/hwmon.o common/memory.o \
-		common/command_submission.o common/mmu_v1.o \
+		common/command_submission.o common/mmu.o common/mmu_v1.o \
 		common/firmware_if.o common/pci.o
diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index aa7fa9e94651..196e35d71118 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -321,6 +321,10 @@ static int device_early_init(struct hl_device *hdev)
 		goto free_chip_info;
 	}
 
+	rc = hl_mmu_if_set_funcs(hdev);
+	if (rc)
+		goto free_idle_busy_ts_arr;
+
 	hl_cb_mgr_init(&hdev->kernel_cb_mgr);
 
 	mutex_init(&hdev->send_cpu_message_lock);
@@ -334,6 +338,8 @@ static int device_early_init(struct hl_device *hdev)
 
 	return 0;
 
+free_idle_busy_ts_arr:
+	kfree(hdev->idle_busy_ts_arr);
 free_chip_info:
 	kfree(hdev->hl_chip_info);
 free_eq_wq:
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index ec765320159a..15e746a5fe35 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -1423,6 +1423,44 @@ struct hl_device_idle_busy_ts {
 	ktime_t				busy_to_idle_ts;
 };
 
+
+/**
+ * struct hl_mmu_priv - used for holding per-device mmu internal information.
+ * @mmu_pgt_pool: pool of page tables used by MMU for allocating hops.
+ * @mmu_shadow_hop0: shadow array of hop0 tables.
+ */
+struct hl_mmu_priv {
+	struct gen_pool *mmu_pgt_pool;
+	void *mmu_shadow_hop0;
+};
+
+/**
+ * struct hl_mmu_funcs - Device related MMU functions.
+ * @init: initialize the MMU module.
+ * @fini: release the MMU module.
+ * @ctx_init: Initialize a context for using the MMU module.
+ * @ctx_fini: disable a ctx from using the mmu module.
+ * @map: maps a virtual address to physical address for a context.
+ * @unmap: unmap a virtual address of a context.
+ * @flush: flush all writes from all cores to reach device MMU.
+ * @swap_out: marks all mapping of the given context as swapped out.
+ * @swap_in: marks all mapping of the given context as swapped in.
+ */
+struct hl_mmu_funcs {
+	int (*init)(struct hl_device *hdev);
+	void (*fini)(struct hl_device *hdev);
+	int (*ctx_init)(struct hl_ctx *ctx);
+	void (*ctx_fini)(struct hl_ctx *ctx);
+	int (*map)(struct hl_ctx *ctx,
+			u64 virt_addr, u64 phys_addr, u32 page_size,
+			bool is_dram_addr);
+	int (*unmap)(struct hl_ctx *ctx,
+			u64 virt_addr, bool is_dram_addr);
+	void (*flush)(struct hl_ctx *ctx);
+	void (*swap_out)(struct hl_ctx *ctx);
+	void (*swap_in)(struct hl_ctx *ctx);
+};
+
 /**
  * struct hl_device - habanalabs device structure.
  * @pdev: pointer to PCI device, can be NULL in case of simulator device.
@@ -1459,10 +1497,8 @@ struct hl_device_idle_busy_ts {
  * @asic_prop: ASIC specific immutable properties.
  * @asic_funcs: ASIC specific functions.
  * @asic_specific: ASIC specific information to use only from ASIC files.
- * @mmu_pgt_pool: pool of available MMU hops.
  * @vm: virtual memory manager for MMU.
  * @mmu_cache_lock: protects MMU cache invalidation as it can serve one context.
- * @mmu_shadow_hop0: shadow mapping of the MMU hop 0 zone.
  * @hwmon_dev: H/W monitor device.
  * @pm_mng_profile: current power management profile.
  * @hl_chip_info: ASIC's sensors information.
@@ -1480,6 +1516,8 @@ struct hl_device_idle_busy_ts {
  * @idle_busy_ts_arr: array to hold time stamps of transitions from idle to busy
  *                    and vice-versa
  * @aggregated_cs_counters: aggregated cs counters among all contexts
+ * @mmu_priv: device-specific MMU data.
+ * @mmu_func: device-related MMU functions.
  * @dram_used_mem: current DRAM memory consumption.
  * @timeout_jiffies: device CS timeout value.
  * @max_power: the max power of the device, as configured by the sysadmin. This
@@ -1564,10 +1602,8 @@ struct hl_device {
 	struct asic_fixed_properties	asic_prop;
 	const struct hl_asic_funcs	*asic_funcs;
 	void				*asic_specific;
-	struct gen_pool			*mmu_pgt_pool;
 	struct hl_vm			vm;
 	struct mutex			mmu_cache_lock;
-	void				*mmu_shadow_hop0;
 	struct device			*hwmon_dev;
 	enum hl_pm_mng_profile		pm_mng_profile;
 	struct hwmon_chip_info		*hl_chip_info;
@@ -1591,6 +1627,9 @@ struct hl_device {
 
 	struct hl_cs_counters		aggregated_cs_counters;
 
+	struct hl_mmu_priv		mmu_priv;
+	struct hl_mmu_funcs		mmu_func;
+
 	atomic64_t			dram_used_mem;
 	u64				timeout_jiffies;
 	u64				max_power;
@@ -1842,6 +1881,8 @@ int hl_mmu_unmap(struct hl_ctx *ctx, u64 virt_addr, u32 page_size,
 		bool flush_pte);
 void hl_mmu_swap_out(struct hl_ctx *ctx);
 void hl_mmu_swap_in(struct hl_ctx *ctx);
+int hl_mmu_if_set_funcs(struct hl_device *hdev);
+void hl_mmu_v1_set_funcs(struct hl_device *hdev);
 
 int hl_fw_load_fw_to_device(struct hl_device *hdev, const char *fw_name,
 				void __iomem *dst);
diff --git a/drivers/misc/habanalabs/common/mmu.c b/drivers/misc/habanalabs/common/mmu.c
new file mode 100644
index 000000000000..b5058798aeb9
--- /dev/null
+++ b/drivers/misc/habanalabs/common/mmu.c
@@ -0,0 +1,309 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright 2016-2020 HabanaLabs, Ltd.
+ * All Rights Reserved.
+ */
+
+#include <linux/slab.h>
+
+#include "habanalabs.h"
+
+static bool is_dram_va(struct hl_device *hdev, u64 virt_addr)
+{
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
+
+	return hl_mem_area_inside_range(virt_addr, prop->dmmu.page_size,
+					prop->dmmu.start_addr,
+					prop->dmmu.end_addr);
+}
+
+/**
+ * hl_mmu_init() - initialize the MMU module.
+ * @hdev: habanalabs device structure.
+ *
+ * This function does the following:
+ * - Create a pool of pages for pgt_infos.
+ * - Create a shadow table for pgt
+ *
+ * Return: 0 for success, non-zero for failure.
+ */
+int hl_mmu_init(struct hl_device *hdev)
+{
+	if (hdev->mmu_enable)
+		return hdev->mmu_func.init(hdev);
+
+	return 0;
+}
+
+/**
+ * hl_mmu_fini() - release the MMU module.
+ * @hdev: habanalabs device structure.
+ *
+ * This function does the following:
+ * - Disable MMU in H/W.
+ * - Free the pgt_infos pool.
+ *
+ * All contexts should be freed before calling this function.
+ */
+void hl_mmu_fini(struct hl_device *hdev)
+{
+	if (hdev->mmu_enable)
+		hdev->mmu_func.fini(hdev);
+}
+
+/**
+ * hl_mmu_ctx_init() - initialize a context for using the MMU module.
+ * @ctx: pointer to the context structure to initialize.
+ *
+ * Initialize a mutex to protect the concurrent mapping flow, a hash to hold all
+ * page tables hops related to this context.
+ * Return: 0 on success, non-zero otherwise.
+ */
+int hl_mmu_ctx_init(struct hl_ctx *ctx)
+{
+	struct hl_device *hdev = ctx->hdev;
+
+	if (hdev->mmu_enable)
+		return hdev->mmu_func.ctx_init(ctx);
+
+	return 0;
+}
+
+/*
+ * hl_mmu_ctx_fini - disable a ctx from using the mmu module
+ *
+ * @ctx: pointer to the context structure
+ *
+ * This function does the following:
+ * - Free any pgts which were not freed yet
+ * - Free the mutex
+ * - Free DRAM default page mapping hops
+ */
+void hl_mmu_ctx_fini(struct hl_ctx *ctx)
+{
+	struct hl_device *hdev = ctx->hdev;
+
+	if (hdev->mmu_enable)
+		hdev->mmu_func.ctx_fini(ctx);
+}
+
+/*
+ * hl_mmu_unmap - unmaps a virtual addr
+ *
+ * @ctx: pointer to the context structure
+ * @virt_addr: virt addr to map from
+ * @page_size: size of the page to unmap
+ * @flush_pte: whether to do a PCI flush
+ *
+ * This function does the following:
+ * - Check that the virt addr is mapped
+ * - Unmap the virt addr and frees pgts if possible
+ * - Returns 0 on success, -EINVAL if the given addr is not mapped
+ *
+ * Because this function changes the page tables in the device and because it
+ * changes the MMU hash, it must be protected by a lock.
+ * However, because it maps only a single page, the lock should be implemented
+ * in a higher level in order to protect the entire mapping of the memory area
+ *
+ * For optimization reasons PCI flush may be requested once after unmapping of
+ * large area.
+ */
+int hl_mmu_unmap(struct hl_ctx *ctx, u64 virt_addr, u32 page_size,
+		bool flush_pte)
+{
+	struct hl_device *hdev = ctx->hdev;
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
+	struct hl_mmu_properties *mmu_prop;
+	u64 real_virt_addr;
+	u32 real_page_size, npages;
+	int i, rc = 0;
+	bool is_dram_addr;
+
+	if (!hdev->mmu_enable)
+		return 0;
+
+	is_dram_addr = is_dram_va(hdev, virt_addr);
+
+	if (is_dram_addr)
+		mmu_prop = &prop->dmmu;
+	else if ((page_size % prop->pmmu_huge.page_size) == 0)
+		mmu_prop = &prop->pmmu_huge;
+	else
+		mmu_prop = &prop->pmmu;
+
+	/*
+	 * The H/W handles mapping of specific page sizes. Hence if the page
+	 * size is bigger, we break it to sub-pages and unmap them separately.
+	 */
+	if ((page_size % mmu_prop->page_size) == 0) {
+		real_page_size = mmu_prop->page_size;
+	} else {
+		dev_err(hdev->dev,
+			"page size of %u is not %uKB aligned, can't unmap\n",
+			page_size, mmu_prop->page_size >> 10);
+
+		return -EFAULT;
+	}
+
+	npages = page_size / real_page_size;
+	real_virt_addr = virt_addr;
+
+	for (i = 0 ; i < npages ; i++) {
+		rc = hdev->mmu_func.unmap(ctx, real_virt_addr, is_dram_addr);
+		if (rc)
+			break;
+
+		real_virt_addr += real_page_size;
+	}
+
+	if (flush_pte)
+		hdev->mmu_func.flush(ctx);
+
+	return rc;
+}
+
+/*
+ * hl_mmu_map - maps a virtual addr to physical addr
+ *
+ * @ctx: pointer to the context structure
+ * @virt_addr: virt addr to map from
+ * @phys_addr: phys addr to map to
+ * @page_size: physical page size
+ * @flush_pte: whether to do a PCI flush
+ *
+ * This function does the following:
+ * - Check that the virt addr is not mapped
+ * - Allocate pgts as necessary in order to map the virt addr to the phys
+ * - Returns 0 on success, -EINVAL if addr is already mapped, or -ENOMEM.
+ *
+ * Because this function changes the page tables in the device and because it
+ * changes the MMU hash, it must be protected by a lock.
+ * However, because it maps only a single page, the lock should be implemented
+ * in a higher level in order to protect the entire mapping of the memory area
+ *
+ * For optimization reasons PCI flush may be requested once after mapping of
+ * large area.
+ */
+int hl_mmu_map(struct hl_ctx *ctx, u64 virt_addr, u64 phys_addr, u32 page_size,
+		bool flush_pte)
+{
+	struct hl_device *hdev = ctx->hdev;
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
+	struct hl_mmu_properties *mmu_prop;
+	u64 real_virt_addr, real_phys_addr;
+	u32 real_page_size, npages;
+	int i, rc, mapped_cnt = 0;
+	bool is_dram_addr;
+
+	if (!hdev->mmu_enable)
+		return 0;
+
+	is_dram_addr = is_dram_va(hdev, virt_addr);
+
+	if (is_dram_addr)
+		mmu_prop = &prop->dmmu;
+	else if ((page_size % prop->pmmu_huge.page_size) == 0)
+		mmu_prop = &prop->pmmu_huge;
+	else
+		mmu_prop = &prop->pmmu;
+
+	/*
+	 * The H/W handles mapping of specific page sizes. Hence if the page
+	 * size is bigger, we break it to sub-pages and map them separately.
+	 */
+	if ((page_size % mmu_prop->page_size) == 0) {
+		real_page_size = mmu_prop->page_size;
+	} else {
+		dev_err(hdev->dev,
+			"page size of %u is not %uKB aligned, can't unmap\n",
+			page_size, mmu_prop->page_size >> 10);
+
+		return -EFAULT;
+	}
+
+	WARN_ONCE((phys_addr & (real_page_size - 1)),
+		"Mapping 0x%llx with page size of 0x%x is erroneous! Address must be divisible by page size",
+		phys_addr, real_page_size);
+
+	npages = page_size / real_page_size;
+	real_virt_addr = virt_addr;
+	real_phys_addr = phys_addr;
+
+	for (i = 0 ; i < npages ; i++) {
+		rc = hdev->mmu_func.map(ctx, real_virt_addr, real_phys_addr,
+				real_page_size, is_dram_addr);
+		if (rc)
+			goto err;
+
+		real_virt_addr += real_page_size;
+		real_phys_addr += real_page_size;
+		mapped_cnt++;
+	}
+
+	if (flush_pte)
+		hdev->mmu_func.flush(ctx);
+
+	return 0;
+
+err:
+	real_virt_addr = virt_addr;
+	for (i = 0 ; i < mapped_cnt ; i++) {
+		if (hdev->mmu_func.unmap(ctx, real_virt_addr, is_dram_addr))
+			dev_warn_ratelimited(hdev->dev,
+				"failed to unmap va: 0x%llx\n", real_virt_addr);
+
+		real_virt_addr += real_page_size;
+	}
+
+	hdev->mmu_func.flush(ctx);
+
+	return rc;
+}
+
+/*
+ * hl_mmu_swap_out - marks all mapping of the given ctx as swapped out
+ *
+ * @ctx: pointer to the context structure
+ *
+ */
+void hl_mmu_swap_out(struct hl_ctx *ctx)
+{
+	struct hl_device *hdev = ctx->hdev;
+
+	if (hdev->mmu_enable)
+		hdev->mmu_func.swap_out(ctx);
+}
+
+/*
+ * hl_mmu_swap_in - marks all mapping of the given ctx as swapped in
+ *
+ * @ctx: pointer to the context structure
+ *
+ */
+void hl_mmu_swap_in(struct hl_ctx *ctx)
+{
+	struct hl_device *hdev = ctx->hdev;
+
+	if (hdev->mmu_enable)
+		hdev->mmu_func.swap_in(ctx);
+}
+
+int hl_mmu_if_set_funcs(struct hl_device *hdev)
+{
+	if (!hdev->mmu_enable)
+		return 0;
+
+	switch (hdev->asic_type) {
+	case ASIC_GOYA:
+	case ASIC_GAUDI:
+		hl_mmu_v1_set_funcs(hdev);
+		break;
+	default:
+		dev_err(hdev->dev, "Unrecognized ASIC type %d\n",
+			hdev->asic_type);
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
diff --git a/drivers/misc/habanalabs/common/mmu_v1.c b/drivers/misc/habanalabs/common/mmu_v1.c
index 3fc0f497fab3..8d1eb5265419 100644
--- a/drivers/misc/habanalabs/common/mmu_v1.c
+++ b/drivers/misc/habanalabs/common/mmu_v1.c
@@ -29,7 +29,7 @@ static void _free_hop(struct hl_ctx *ctx, struct pgt_info *pgt_info)
 {
 	struct hl_device *hdev = ctx->hdev;
 
-	gen_pool_free(hdev->mmu_pgt_pool, pgt_info->phys_addr,
+	gen_pool_free(hdev->mmu_priv.mmu_pgt_pool, pgt_info->phys_addr,
 			hdev->asic_prop.mmu_hop_table_size);
 	hash_del(&pgt_info->node);
 	kfree((u64 *) (uintptr_t) pgt_info->shadow_addr);
@@ -54,7 +54,7 @@ static u64 alloc_hop(struct hl_ctx *ctx)
 	if (!pgt_info)
 		return ULLONG_MAX;
 
-	phys_addr = (u64) gen_pool_alloc(hdev->mmu_pgt_pool,
+	phys_addr = (u64) gen_pool_alloc(hdev->mmu_priv.mmu_pgt_pool,
 					prop->mmu_hop_table_size);
 	if (!phys_addr) {
 		dev_err(hdev->dev, "failed to allocate page\n");
@@ -75,7 +75,8 @@ static u64 alloc_hop(struct hl_ctx *ctx)
 	return shadow_addr;
 
 shadow_err:
-	gen_pool_free(hdev->mmu_pgt_pool, phys_addr, prop->mmu_hop_table_size);
+	gen_pool_free(hdev->mmu_priv.mmu_pgt_pool, phys_addr,
+			prop->mmu_hop_table_size);
 pool_add_err:
 	kfree(pgt_info);
 
@@ -90,11 +91,11 @@ static inline u64 get_phys_hop0_addr(struct hl_ctx *ctx)
 
 static inline u64 get_hop0_addr(struct hl_ctx *ctx)
 {
-	return (u64) (uintptr_t) ctx->hdev->mmu_shadow_hop0 +
+	return (u64) (uintptr_t) ctx->hdev->mmu_priv.mmu_shadow_hop0 +
 			(ctx->asid * ctx->hdev->asic_prop.mmu_hop_table_size);
 }
 
-static inline void flush(struct hl_ctx *ctx)
+static void flush(struct hl_ctx *ctx)
 {
 	/* flush all writes from all cores to reach PCI */
 	mb();
@@ -254,15 +255,6 @@ static inline u64 get_phys_addr(struct hl_ctx *ctx, u64 shadow_addr)
 	return phys_hop_addr + pte_offset;
 }
 
-static bool is_dram_va(struct hl_device *hdev, u64 virt_addr)
-{
-	struct asic_fixed_properties *prop = &hdev->asic_prop;
-
-	return hl_mem_area_inside_range(virt_addr, prop->dmmu.page_size,
-					prop->dmmu.start_addr,
-					prop->dmmu.end_addr);
-}
-
 static int dram_default_mapping_init(struct hl_ctx *ctx)
 {
 	struct hl_device *hdev = ctx->hdev;
@@ -413,7 +405,7 @@ static void dram_default_mapping_fini(struct hl_ctx *ctx)
 }
 
 /**
- * hl_mmu_init() - initialize the MMU module.
+ * hl_mmu_v1_init() - initialize the MMU module.
  * @hdev: habanalabs device structure.
  *
  * This function does the following:
@@ -422,23 +414,20 @@ static void dram_default_mapping_fini(struct hl_ctx *ctx)
  *
  * Return: 0 for success, non-zero for failure.
  */
-int hl_mmu_init(struct hl_device *hdev)
+static int hl_mmu_v1_init(struct hl_device *hdev)
 {
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
 	int rc;
 
-	if (!hdev->mmu_enable)
-		return 0;
-
-	hdev->mmu_pgt_pool =
+	hdev->mmu_priv.mmu_pgt_pool =
 			gen_pool_create(__ffs(prop->mmu_hop_table_size), -1);
 
-	if (!hdev->mmu_pgt_pool) {
+	if (!hdev->mmu_priv.mmu_pgt_pool) {
 		dev_err(hdev->dev, "Failed to create page gen pool\n");
 		return -ENOMEM;
 	}
 
-	rc = gen_pool_add(hdev->mmu_pgt_pool, prop->mmu_pgt_addr +
+	rc = gen_pool_add(hdev->mmu_priv.mmu_pgt_pool, prop->mmu_pgt_addr +
 			prop->mmu_hop0_tables_total_size,
 			prop->mmu_pgt_size - prop->mmu_hop0_tables_total_size,
 			-1);
@@ -447,10 +436,10 @@ int hl_mmu_init(struct hl_device *hdev)
 		goto err_pool_add;
 	}
 
-	hdev->mmu_shadow_hop0 = kvmalloc_array(prop->max_asid,
-					prop->mmu_hop_table_size,
-					GFP_KERNEL | __GFP_ZERO);
-	if (ZERO_OR_NULL_PTR(hdev->mmu_shadow_hop0)) {
+	hdev->mmu_priv.mmu_shadow_hop0 = kvmalloc_array(prop->max_asid,
+						prop->mmu_hop_table_size,
+						GFP_KERNEL | __GFP_ZERO);
+	if (ZERO_OR_NULL_PTR(hdev->mmu_priv.mmu_shadow_hop0)) {
 		rc = -ENOMEM;
 		goto err_pool_add;
 	}
@@ -460,7 +449,7 @@ int hl_mmu_init(struct hl_device *hdev)
 	return 0;
 
 err_pool_add:
-	gen_pool_destroy(hdev->mmu_pgt_pool);
+	gen_pool_destroy(hdev->mmu_priv.mmu_pgt_pool);
 
 	return rc;
 }
@@ -475,15 +464,12 @@ int hl_mmu_init(struct hl_device *hdev)
  *
  * All contexts should be freed before calling this function.
  */
-void hl_mmu_fini(struct hl_device *hdev)
+static void hl_mmu_v1_fini(struct hl_device *hdev)
 {
-	if (!hdev->mmu_enable)
-		return;
-
 	/* MMU H/W fini was already done in device hw_fini() */
 
-	kvfree(hdev->mmu_shadow_hop0);
-	gen_pool_destroy(hdev->mmu_pgt_pool);
+	kvfree(hdev->mmu_priv.mmu_shadow_hop0);
+	gen_pool_destroy(hdev->mmu_priv.mmu_pgt_pool);
 }
 
 /**
@@ -494,13 +480,8 @@ void hl_mmu_fini(struct hl_device *hdev)
  * page tables hops related to this context.
  * Return: 0 on success, non-zero otherwise.
  */
-int hl_mmu_ctx_init(struct hl_ctx *ctx)
+static int hl_mmu_v1_ctx_init(struct hl_ctx *ctx)
 {
-	struct hl_device *hdev = ctx->hdev;
-
-	if (!hdev->mmu_enable)
-		return 0;
-
 	mutex_init(&ctx->mmu_lock);
 	hash_init(ctx->mmu_shadow_hash);
 
@@ -517,16 +498,13 @@ int hl_mmu_ctx_init(struct hl_ctx *ctx)
  * - Free the mutex
  * - Free DRAM default page mapping hops
  */
-void hl_mmu_ctx_fini(struct hl_ctx *ctx)
+static void hl_mmu_v1_ctx_fini(struct hl_ctx *ctx)
 {
 	struct hl_device *hdev = ctx->hdev;
 	struct pgt_info *pgt_info;
 	struct hlist_node *tmp;
 	int i;
 
-	if (!hdev->mmu_enable)
-		return;
-
 	dram_default_mapping_fini(ctx);
 
 	if (!hash_empty(ctx->mmu_shadow_hash))
@@ -543,7 +521,8 @@ void hl_mmu_ctx_fini(struct hl_ctx *ctx)
 	mutex_destroy(&ctx->mmu_lock);
 }
 
-static int _hl_mmu_unmap(struct hl_ctx *ctx, u64 virt_addr, bool is_dram_addr)
+static int _hl_mmu_v1_unmap(struct hl_ctx *ctx,
+				u64 virt_addr, bool is_dram_addr)
 {
 	struct hl_device *hdev = ctx->hdev;
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
@@ -676,82 +655,7 @@ static int _hl_mmu_unmap(struct hl_ctx *ctx, u64 virt_addr, bool is_dram_addr)
 	return -EINVAL;
 }
 
-/*
- * hl_mmu_unmap - unmaps a virtual addr
- *
- * @ctx: pointer to the context structure
- * @virt_addr: virt addr to map from
- * @page_size: size of the page to unmap
- * @flush_pte: whether to do a PCI flush
- *
- * This function does the following:
- * - Check that the virt addr is mapped
- * - Unmap the virt addr and frees pgts if possible
- * - Returns 0 on success, -EINVAL if the given addr is not mapped
- *
- * Because this function changes the page tables in the device and because it
- * changes the MMU hash, it must be protected by a lock.
- * However, because it maps only a single page, the lock should be implemented
- * in a higher level in order to protect the entire mapping of the memory area
- *
- * For optimization reasons PCI flush may be requested once after unmapping of
- * large area.
- */
-int hl_mmu_unmap(struct hl_ctx *ctx, u64 virt_addr, u32 page_size,
-		bool flush_pte)
-{
-	struct hl_device *hdev = ctx->hdev;
-	struct asic_fixed_properties *prop = &hdev->asic_prop;
-	struct hl_mmu_properties *mmu_prop;
-	u64 real_virt_addr;
-	u32 real_page_size, npages;
-	int i, rc = 0;
-	bool is_dram_addr;
-
-	if (!hdev->mmu_enable)
-		return 0;
-
-	is_dram_addr = is_dram_va(hdev, virt_addr);
-
-	if (is_dram_addr)
-		mmu_prop = &prop->dmmu;
-	else if ((page_size % prop->pmmu_huge.page_size) == 0)
-		mmu_prop = &prop->pmmu_huge;
-	else
-		mmu_prop = &prop->pmmu;
-
-	/*
-	 * The H/W handles mapping of specific page sizes. Hence if the page
-	 * size is bigger, we break it to sub-pages and unmap them separately.
-	 */
-	if ((page_size % mmu_prop->page_size) == 0) {
-		real_page_size = mmu_prop->page_size;
-	} else {
-		dev_err(hdev->dev,
-			"page size of %u is not %uKB aligned, can't unmap\n",
-			page_size, mmu_prop->page_size >> 10);
-
-		return -EFAULT;
-	}
-
-	npages = page_size / real_page_size;
-	real_virt_addr = virt_addr;
-
-	for (i = 0 ; i < npages ; i++) {
-		rc = _hl_mmu_unmap(ctx, real_virt_addr, is_dram_addr);
-		if (rc)
-			break;
-
-		real_virt_addr += real_page_size;
-	}
-
-	if (flush_pte)
-		flush(ctx);
-
-	return rc;
-}
-
-static int _hl_mmu_map(struct hl_ctx *ctx, u64 virt_addr, u64 phys_addr,
+static int _hl_mmu_v1_map(struct hl_ctx *ctx, u64 virt_addr, u64 phys_addr,
 			u32 page_size, bool is_dram_addr)
 {
 	struct hl_device *hdev = ctx->hdev;
@@ -917,121 +821,43 @@ static int _hl_mmu_map(struct hl_ctx *ctx, u64 virt_addr, u64 phys_addr,
 }
 
 /*
- * hl_mmu_map - maps a virtual addr to physical addr
+ * hl_mmu_v1_swap_out - marks all mapping of the given ctx as swapped out
  *
  * @ctx: pointer to the context structure
- * @virt_addr: virt addr to map from
- * @phys_addr: phys addr to map to
- * @page_size: physical page size
- * @flush_pte: whether to do a PCI flush
- *
- * This function does the following:
- * - Check that the virt addr is not mapped
- * - Allocate pgts as necessary in order to map the virt addr to the phys
- * - Returns 0 on success, -EINVAL if addr is already mapped, or -ENOMEM.
- *
- * Because this function changes the page tables in the device and because it
- * changes the MMU hash, it must be protected by a lock.
- * However, because it maps only a single page, the lock should be implemented
- * in a higher level in order to protect the entire mapping of the memory area
  *
- * For optimization reasons PCI flush may be requested once after mapping of
- * large area.
  */
-int hl_mmu_map(struct hl_ctx *ctx, u64 virt_addr, u64 phys_addr, u32 page_size,
-		bool flush_pte)
+static void hl_mmu_v1_swap_out(struct hl_ctx *ctx)
 {
-	struct hl_device *hdev = ctx->hdev;
-	struct asic_fixed_properties *prop = &hdev->asic_prop;
-	struct hl_mmu_properties *mmu_prop;
-	u64 real_virt_addr, real_phys_addr;
-	u32 real_page_size, npages;
-	int i, rc, mapped_cnt = 0;
-	bool is_dram_addr;
-
-	if (!hdev->mmu_enable)
-		return 0;
-
-	is_dram_addr = is_dram_va(hdev, virt_addr);
-
-	if (is_dram_addr)
-		mmu_prop = &prop->dmmu;
-	else if ((page_size % prop->pmmu_huge.page_size) == 0)
-		mmu_prop = &prop->pmmu_huge;
-	else
-		mmu_prop = &prop->pmmu;
-
-	/*
-	 * The H/W handles mapping of specific page sizes. Hence if the page
-	 * size is bigger, we break it to sub-pages and map them separately.
-	 */
-	if ((page_size % mmu_prop->page_size) == 0) {
-		real_page_size = mmu_prop->page_size;
-	} else {
-		dev_err(hdev->dev,
-			"page size of %u is not %uKB aligned, can't unmap\n",
-			page_size, mmu_prop->page_size >> 10);
 
-		return -EFAULT;
-	}
-
-	WARN_ONCE((phys_addr & (real_page_size - 1)),
-		"Mapping 0x%llx with page size of 0x%x is erroneous! Address must be divisible by page size",
-		phys_addr, real_page_size);
-
-	npages = page_size / real_page_size;
-	real_virt_addr = virt_addr;
-	real_phys_addr = phys_addr;
-
-	for (i = 0 ; i < npages ; i++) {
-		rc = _hl_mmu_map(ctx, real_virt_addr, real_phys_addr,
-				real_page_size, is_dram_addr);
-		if (rc)
-			goto err;
-
-		real_virt_addr += real_page_size;
-		real_phys_addr += real_page_size;
-		mapped_cnt++;
-	}
-
-	if (flush_pte)
-		flush(ctx);
-
-	return 0;
-
-err:
-	real_virt_addr = virt_addr;
-	for (i = 0 ; i < mapped_cnt ; i++) {
-		if (_hl_mmu_unmap(ctx, real_virt_addr, is_dram_addr))
-			dev_warn_ratelimited(hdev->dev,
-				"failed to unmap va: 0x%llx\n", real_virt_addr);
-
-		real_virt_addr += real_page_size;
-	}
-
-	flush(ctx);
-
-	return rc;
 }
 
 /*
- * hl_mmu_swap_out - marks all mapping of the given ctx as swapped out
+ * hl_mmu_v1_swap_in - marks all mapping of the given ctx as swapped in
  *
  * @ctx: pointer to the context structure
  *
  */
-void hl_mmu_swap_out(struct hl_ctx *ctx)
+static void hl_mmu_v1_swap_in(struct hl_ctx *ctx)
 {
 
 }
 
 /*
- * hl_mmu_swap_in - marks all mapping of the given ctx as swapped in
- *
- * @ctx: pointer to the context structure
+ * hl_mmu_v1_prepare - prepare mmu  for working with mmu v1
  *
+ * @hdev: pointer to the device structure
  */
-void hl_mmu_swap_in(struct hl_ctx *ctx)
-{
-
+void hl_mmu_v1_set_funcs(struct hl_device *hdev)
+{
+	struct hl_mmu_funcs *mmu = &hdev->mmu_func;
+
+	mmu->init = hl_mmu_v1_init;
+	mmu->fini = hl_mmu_v1_fini;
+	mmu->ctx_init = hl_mmu_v1_ctx_init;
+	mmu->ctx_fini = hl_mmu_v1_ctx_fini;
+	mmu->map = _hl_mmu_v1_map;
+	mmu->unmap = _hl_mmu_v1_unmap;
+	mmu->flush = flush;
+	mmu->swap_out = hl_mmu_v1_swap_out;
+	mmu->swap_in = hl_mmu_v1_swap_in;
 }
-- 
2.17.1

