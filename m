Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6075C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 13:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 845752068D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 13:41:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389143AbgEZNla (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 09:41:30 -0400
Received: from foss.arm.com ([217.140.110.172]:51064 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388963AbgEZNl3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 09:41:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 27E1E55D;
        Tue, 26 May 2020 06:41:28 -0700 (PDT)
Received: from melchizedek.cambridge.arm.com (melchizedek.cambridge.arm.com [10.1.196.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A5F673F6C4;
        Tue, 26 May 2020 06:41:26 -0700 (PDT)
From:   James Morse <james.morse@arm.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        James Morse <james.morse@arm.com>
Subject: [PATCH v4 09/10] x86/resctrl: Add arch_has_{sparse,empty}_bitmaps to explain CAT differences
Date:   Tue, 26 May 2020 14:40:58 +0100
Message-Id: <20200526134059.1690-10-james.morse@arm.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20200526134059.1690-1-james.morse@arm.com>
References: <20200526134059.1690-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intel CPUs expect the cache bitmap provided by user-space to have on
a single span of 1s, whereas AMD can support bitmaps like 0xf00f.
Arm's MPAM support also allows sparse bitmaps.

Similarly, Intel CPUs check at least one bit set, whereas AMD CPUs
are quite happy with an empty bitmap. Arm's MPAM allows an empty
bitmap.

To move resctrl out to /fs/ we need to explain platform differences
like this. Add two resource properties arch_has_{empty,sparse}_bitmaps.
Test these around the relevant parts of cbm_validate().

Merging the validate calls causes AMD to gain the min_cbm_bits test
needed for Haswell, but as it always sets this value to 1, it will
never match.

CC: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: James Morse <james.morse@arm.com>
Reviewed-by: Babu Moger <babu.moger@amd.com>
---
 arch/x86/kernel/cpu/resctrl/core.c        | 14 ++++----
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 39 ++++++-----------------
 arch/x86/kernel/cpu/resctrl/internal.h    |  8 ++---
 3 files changed, 22 insertions(+), 39 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 223e5b90bcfd..587f9791d2a6 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -922,9 +922,10 @@ static __init void rdt_init_res_defs_intel(void)
 		    r->rid == RDT_RESOURCE_L3CODE ||
 		    r->rid == RDT_RESOURCE_L2 ||
 		    r->rid == RDT_RESOURCE_L2DATA ||
-		    r->rid == RDT_RESOURCE_L2CODE)
-			r->cbm_validate = cbm_validate_intel;
-		else if (r->rid == RDT_RESOURCE_MBA) {
+		    r->rid == RDT_RESOURCE_L2CODE) {
+			r->cache.arch_has_sparse_bitmaps = false;
+			r->cache.arch_has_empty_bitmaps = false;
+		} else if (r->rid == RDT_RESOURCE_MBA) {
 			r->msr_base = MSR_IA32_MBA_THRTL_BASE;
 			r->msr_update = mba_wrmsr_intel;
 		}
@@ -941,9 +942,10 @@ static __init void rdt_init_res_defs_amd(void)
 		    r->rid == RDT_RESOURCE_L3CODE ||
 		    r->rid == RDT_RESOURCE_L2 ||
 		    r->rid == RDT_RESOURCE_L2DATA ||
-		    r->rid == RDT_RESOURCE_L2CODE)
-			r->cbm_validate = cbm_validate_amd;
-		else if (r->rid == RDT_RESOURCE_MBA) {
+		    r->rid == RDT_RESOURCE_L2CODE) {
+			r->cache.arch_has_sparse_bitmaps = true;
+			r->cache.arch_has_empty_bitmaps = true;
+		} else if (r->rid == RDT_RESOURCE_MBA) {
 			r->msr_base = MSR_IA32_MBA_BW_BASE;
 			r->msr_update = mba_wrmsr_amd;
 		}
diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index b0e24cb6f85c..c877642e8a14 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -76,12 +76,14 @@ int parse_bw(struct rdt_parse_data *data, struct rdt_resource *r,
 }
 
 /*
- * Check whether a cache bit mask is valid. The SDM says:
+ * Check whether a cache bit mask is valid.
+ * For Intel the SDM says:
  *	Please note that all (and only) contiguous '1' combinations
  *	are allowed (e.g. FFFFH, 0FF0H, 003CH, etc.).
  * Additionally Haswell requires at least two bits set.
+ * AMD allows non-contiguous bitmasks.
  */
-bool cbm_validate_intel(char *buf, u32 *data, struct rdt_resource *r)
+static bool cbm_validate(char *buf, u32 *data, struct rdt_resource *r)
 {
 	unsigned long first_bit, zero_bit, val;
 	unsigned int cbm_len = r->cache.cbm_len;
@@ -93,7 +95,8 @@ bool cbm_validate_intel(char *buf, u32 *data, struct rdt_resource *r)
 		return false;
 	}
 
-	if (val == 0 || val > r->default_ctrl) {
+	if ((!r->cache.arch_has_empty_bitmaps && val == 0) ||
+	    val > r->default_ctrl) {
 		rdt_last_cmd_puts("Mask out of range\n");
 		return false;
 	}
@@ -101,7 +104,9 @@ bool cbm_validate_intel(char *buf, u32 *data, struct rdt_resource *r)
 	first_bit = find_first_bit(&val, cbm_len);
 	zero_bit = find_next_zero_bit(&val, cbm_len, first_bit);
 
-	if (find_next_bit(&val, cbm_len, zero_bit) < cbm_len) {
+	/* Are non-contiguous bitmaps allowed? */
+	if (!r->cache.arch_has_sparse_bitmaps &&
+	    (find_next_bit(&val, cbm_len, zero_bit) < cbm_len)) {
 		rdt_last_cmd_printf("The mask %lx has non-consecutive 1-bits\n", val);
 		return false;
 	}
@@ -116,30 +121,6 @@ bool cbm_validate_intel(char *buf, u32 *data, struct rdt_resource *r)
 	return true;
 }
 
-/*
- * Check whether a cache bit mask is valid. AMD allows non-contiguous
- * bitmasks
- */
-bool cbm_validate_amd(char *buf, u32 *data, struct rdt_resource *r)
-{
-	unsigned long val;
-	int ret;
-
-	ret = kstrtoul(buf, 16, &val);
-	if (ret) {
-		rdt_last_cmd_printf("Non-hex character in the mask %s\n", buf);
-		return false;
-	}
-
-	if (val > r->default_ctrl) {
-		rdt_last_cmd_puts("Mask out of range\n");
-		return false;
-	}
-
-	*data = val;
-	return true;
-}
-
 /*
  * Read one cache bit mask (hex). Check that it is valid for the current
  * resource type.
@@ -165,7 +146,7 @@ int parse_cbm(struct rdt_parse_data *data, struct rdt_resource *r,
 		return -EINVAL;
 	}
 
-	if (!r->cbm_validate(data->buf, &cbm_val, r))
+	if (!cbm_validate(data->buf, &cbm_val, r))
 		return -EINVAL;
 
 	if ((rdtgrp->mode == RDT_MODE_EXCLUSIVE ||
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 242cbdb8f2df..169fb5a1d5d7 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -357,6 +357,8 @@ struct msr_param {
  *			in a cache bit mask
  * @shareable_bits:	Bitmask of shareable resource with other
  *			executing entities
+ * @arch_has_sparse_bitmaps:	True if a bitmap like f00f is valid.
+ * @arch_has_empty_bitmaps:	True if the '0' bitmap is valid.
  */
 struct rdt_cache {
 	unsigned int	cbm_len;
@@ -364,6 +366,8 @@ struct rdt_cache {
 	unsigned int	cbm_idx_mult;
 	unsigned int	cbm_idx_offset;
 	unsigned int	shareable_bits;
+	bool		arch_has_sparse_bitmaps;
+	bool		arch_has_empty_bitmaps;
 };
 
 /**
@@ -433,7 +437,6 @@ struct rdt_parse_data {
  * @cache:		Cache allocation related data
  * @format_str:		Per resource format string to show domain value
  * @parse_ctrlval:	Per resource function pointer to parse control values
- * @cbm_validate	Cache bitmask validate function
  * @evt_list:		List of monitoring events
  * @num_rmid:		Number of RMIDs available
  * @mon_scale:		cqm counter * mon_scale = occupancy in bytes
@@ -460,7 +463,6 @@ struct rdt_resource {
 	int (*parse_ctrlval)(struct rdt_parse_data *data,
 			     struct rdt_resource *r,
 			     struct rdt_domain *d);
-	bool (*cbm_validate)(char *buf, u32 *data, struct rdt_resource *r);
 	struct list_head	evt_list;
 	int			num_rmid;
 	unsigned int		mon_scale;
@@ -603,8 +605,6 @@ void cqm_setup_limbo_handler(struct rdt_domain *dom, unsigned long delay_ms);
 void cqm_handle_limbo(struct work_struct *work);
 bool has_busy_rmid(struct rdt_resource *r, struct rdt_domain *d);
 void __check_limbo(struct rdt_domain *d, bool force_free);
-bool cbm_validate_intel(char *buf, u32 *data, struct rdt_resource *r);
-bool cbm_validate_amd(char *buf, u32 *data, struct rdt_resource *r);
 void rdt_domain_reconfigure_cdp(struct rdt_resource *r);
 
 #endif /* _ASM_X86_RESCTRL_INTERNAL_H */
-- 
2.19.1

