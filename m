Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DFEDC4724C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 17:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F79620787
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 17:04:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbgD3REk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 13:04:40 -0400
Received: from foss.arm.com ([217.140.110.172]:59242 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727881AbgD3REi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 13:04:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CB326101E;
        Thu, 30 Apr 2020 10:04:37 -0700 (PDT)
Received: from melchizedek.cambridge.arm.com (melchizedek.cambridge.arm.com [10.1.196.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7C5AD3F73D;
        Thu, 30 Apr 2020 10:04:36 -0700 (PDT)
From:   James Morse <james.morse@arm.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        James Morse <james.morse@arm.com>
Subject: [PATCH v2 09/10] x86/resctrl: Add arch_has_sparse_bitmaps to explain AMD/Intel CAT difference
Date:   Thu, 30 Apr 2020 18:03:59 +0100
Message-Id: <20200430170400.21501-10-james.morse@arm.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20200430170400.21501-1-james.morse@arm.com>
References: <20200430170400.21501-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intel expects the cache bitmap provided by user-space to have on a
single span of 1s, whereas AMD can support bitmaps like 0xf00f.
Arm's MPAM support also allows sparse bitmaps.

To move resctrl out to /fs/ we need to explain platform differences
like this. Add a resource property arch_has_sparse_bitmaps. Test this
around the 'non-consecutive' test in cbm_validate().

Merging the validate calls causes AMD top gain the min_cbm_bits test
needed for Haswell, but as it always sets this value to 1, it will
never match.

CC: Babu Moger <Babu.Moger@amd.com>
Signed-off-by: James Morse <james.morse@arm.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/kernel/cpu/resctrl/core.c        |  4 +--
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 36 +++++------------------
 arch/x86/kernel/cpu/resctrl/internal.h    |  6 ++--
 3 files changed, 12 insertions(+), 34 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 7a6a6303fc05..00c88f42742c 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -923,7 +923,7 @@ static __init void rdt_init_res_defs_intel(void)
 		    r->rid == RDT_RESOURCE_L2 ||
 		    r->rid == RDT_RESOURCE_L2DATA ||
 		    r->rid == RDT_RESOURCE_L2CODE)
-			r->cbm_validate = cbm_validate_intel;
+			r->cache.arch_has_sparse_bitmaps = false;
 		else if (r->rid == RDT_RESOURCE_MBA) {
 			r->msr_base = MSR_IA32_MBA_THRTL_BASE;
 			r->msr_update = mba_wrmsr_intel;
@@ -942,7 +942,7 @@ static __init void rdt_init_res_defs_amd(void)
 		    r->rid == RDT_RESOURCE_L2 ||
 		    r->rid == RDT_RESOURCE_L2DATA ||
 		    r->rid == RDT_RESOURCE_L2CODE)
-			r->cbm_validate = cbm_validate_amd;
+			r->cache.arch_has_sparse_bitmaps = true;
 		else if (r->rid == RDT_RESOURCE_MBA) {
 			r->msr_base = MSR_IA32_MBA_BW_BASE;
 			r->msr_update = mba_wrmsr_amd;
diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index c983efddb537..cca2dfbadf3b 100644
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
@@ -101,7 +103,9 @@ bool cbm_validate_intel(char *buf, u32 *data, struct rdt_resource *r)
 	first_bit = find_first_bit(&val, cbm_len);
 	zero_bit = find_next_zero_bit(&val, cbm_len, first_bit);
 
-	if (find_next_bit(&val, cbm_len, zero_bit) < cbm_len) {
+	/* Are non-contiguous bitmaps allowed? */
+	if (!r->cache.arch_has_sparse_bitmaps &&
+	    (find_next_bit(&val, cbm_len, zero_bit) < cbm_len)) {
 		rdt_last_cmd_printf("The mask %lx has non-consecutive 1-bits\n", val);
 		return false;
 	}
@@ -116,30 +120,6 @@ bool cbm_validate_intel(char *buf, u32 *data, struct rdt_resource *r)
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
@@ -165,7 +145,7 @@ int parse_cbm(struct rdt_parse_data *data, struct rdt_resource *r,
 		return -EINVAL;
 	}
 
-	if (!r->cbm_validate(data->buf, &cbm_val, r))
+	if (!cbm_validate(data->buf, &cbm_val, r))
 		return -EINVAL;
 
 	if ((rdtgrp->mode == RDT_MODE_EXCLUSIVE ||
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index c8d84aec62d3..290e7f96d0db 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -350,6 +350,7 @@ struct msr_param {
  *			in a cache bit mask
  * @shareable_bits:	Bitmask of shareable resource with other
  *			executing entities
+ * @arch_has_sparse_bitmaps:	True if a bitmap like f00f is valid.
  */
 struct rdt_cache {
 	unsigned int	cbm_len;
@@ -357,6 +358,7 @@ struct rdt_cache {
 	unsigned int	cbm_idx_mult;
 	unsigned int	cbm_idx_offset;
 	unsigned int	shareable_bits;
+	bool		arch_has_sparse_bitmaps;
 };
 
 /**
@@ -426,7 +428,6 @@ struct rdt_parse_data {
  * @cache:		Cache allocation related data
  * @format_str:		Per resource format string to show domain value
  * @parse_ctrlval:	Per resource function pointer to parse control values
- * @cbm_validate	Cache bitmask validate function
  * @evt_list:		List of monitoring events
  * @num_rmid:		Number of RMIDs available
  * @mon_scale:		cqm counter * mon_scale = occupancy in bytes
@@ -453,7 +454,6 @@ struct rdt_resource {
 	int (*parse_ctrlval)(struct rdt_parse_data *data,
 			     struct rdt_resource *r,
 			     struct rdt_domain *d);
-	bool (*cbm_validate)(char *buf, u32 *data, struct rdt_resource *r);
 	struct list_head	evt_list;
 	int			num_rmid;
 	unsigned int		mon_scale;
@@ -594,8 +594,6 @@ void cqm_setup_limbo_handler(struct rdt_domain *dom, unsigned long delay_ms);
 void cqm_handle_limbo(struct work_struct *work);
 bool has_busy_rmid(struct rdt_resource *r, struct rdt_domain *d);
 void __check_limbo(struct rdt_domain *d, bool force_free);
-bool cbm_validate_intel(char *buf, u32 *data, struct rdt_resource *r);
-bool cbm_validate_amd(char *buf, u32 *data, struct rdt_resource *r);
 void rdt_domain_reconfigure_cdp(struct rdt_resource *r);
 
 #endif /* _ASM_X86_RESCTRL_INTERNAL_H */
-- 
2.26.1

