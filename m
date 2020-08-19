Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 629FAC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 12:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3623C206FA
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 12:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ipZ2QBKk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LG6BWzaO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbgHSMdy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 08:33:54 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38984 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727846AbgHSMdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 08:33:15 -0400
Date:   Wed, 19 Aug 2020 12:33:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597840389;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xnbYGpJ74gcTFWcOUDCAetN/HzUoEVlhxXAKT9TO5MY=;
        b=ipZ2QBKkaHyDiLsjL1AvTBJVQirWYRQp2QUzU5eM8QWQhz0CVQ6LyOG+w4M63E0uBF3/LA
        IKARb5rBU4VCM8pHR7PR+KJWcEU7/lJboPQcHFRTRoXy32W8Ufm7/hSic6N/4LcUSItY87
        vFd3ddqtFzqDPNZT4oxya1U6f04IVZWxiV0KuSmR6fXanac16urgUj472t0ELfkgHC1Ju7
        b2aYa3G5qqOSqMZGpirVpo63wQ1fBDgSINtItgVeIAMKsAS7jZFzYvNaiv73oVZarDCgDq
        oKsqV3JDUKuW12Jd9gNTMSzEImOEOJhxRL4Gi5rOAc7iHL6UEmdVNe42qW/4Ig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597840389;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xnbYGpJ74gcTFWcOUDCAetN/HzUoEVlhxXAKT9TO5MY=;
        b=LG6BWzaOqSaNt5R3OKLuL6IEnqJsn3dDg5V9KBPVaxWAfsaE5rKcM2wiuM3iagWTeZ6yvl
        2looV26g8NFgabBA==
From:   "tip-bot2 for James Morse" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Add struct rdt_cache::arch_has_{sparse,
 empty}_bitmaps
Cc:     James Morse <james.morse@arm.com>, Borislav Petkov <bp@suse.de>,
        Babu Moger <babu.moger@amd.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200708163929.2783-10-james.morse@arm.com>
References: <20200708163929.2783-10-james.morse@arm.com>
MIME-Version: 1.0
Message-ID: <159784038840.3192.17148158844840208920.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     316e7f901f5aedb415c72d1eedd7de0846238dd0
Gitweb:        https://git.kernel.org/tip/316e7f901f5aedb415c72d1eedd7de0846238dd0
Author:        James Morse <james.morse@arm.com>
AuthorDate:    Wed, 08 Jul 2020 16:39:28 
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 19 Aug 2020 10:41:40 +02:00

x86/resctrl: Add struct rdt_cache::arch_has_{sparse, empty}_bitmaps

Intel CPUs expect the cache bitmap provided by user-space to have on a
single span of 1s, whereas AMD can support bitmaps like 0xf00f. Arm's
MPAM support also allows sparse bitmaps.

Similarly, Intel CPUs check at least one bit set, whereas AMD CPUs are
quite happy with an empty bitmap. Arm's MPAM allows an empty bitmap.

To move resctrl out to /fs/, platform differences like this need to be
explained.

Add two resource properties arch_has_{empty,sparse}_bitmaps. Test these
around the relevant parts of cbm_validate().

Merging the validate calls causes AMD to gain the min_cbm_bits test
needed for Haswell, but as it always sets this value to 1, it will never
match.

 [ bp: Massage commit message. ]

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lkml.kernel.org/r/20200708163929.2783-10-james.morse@arm.com
---
 arch/x86/kernel/cpu/resctrl/core.c        | 14 ++++----
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 39 +++++-----------------
 arch/x86/kernel/cpu/resctrl/internal.h    |  8 ++---
 3 files changed, 22 insertions(+), 39 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 10a52d1..cbbd751 100644
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
index b0e24cb..c877642 100644
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
@@ -117,30 +122,6 @@ bool cbm_validate_intel(char *buf, u32 *data, struct rdt_resource *r)
 }
 
 /*
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
-/*
  * Read one cache bit mask (hex). Check that it is valid for the current
  * resource type.
  */
@@ -165,7 +146,7 @@ int parse_cbm(struct rdt_parse_data *data, struct rdt_resource *r,
 		return -EINVAL;
 	}
 
-	if (!r->cbm_validate(data->buf, &cbm_val, r))
+	if (!cbm_validate(data->buf, &cbm_val, r))
 		return -EINVAL;
 
 	if ((rdtgrp->mode == RDT_MODE_EXCLUSIVE ||
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 21f4399..0b48294 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -358,6 +358,8 @@ struct msr_param {
  *			in a cache bit mask
  * @shareable_bits:	Bitmask of shareable resource with other
  *			executing entities
+ * @arch_has_sparse_bitmaps:	True if a bitmap like f00f is valid.
+ * @arch_has_empty_bitmaps:	True if the '0' bitmap is valid.
  */
 struct rdt_cache {
 	unsigned int	cbm_len;
@@ -365,6 +367,8 @@ struct rdt_cache {
 	unsigned int	cbm_idx_mult;
 	unsigned int	cbm_idx_offset;
 	unsigned int	shareable_bits;
+	bool		arch_has_sparse_bitmaps;
+	bool		arch_has_empty_bitmaps;
 };
 
 /**
@@ -434,7 +438,6 @@ struct rdt_parse_data {
  * @cache:		Cache allocation related data
  * @format_str:		Per resource format string to show domain value
  * @parse_ctrlval:	Per resource function pointer to parse control values
- * @cbm_validate	Cache bitmask validate function
  * @evt_list:		List of monitoring events
  * @num_rmid:		Number of RMIDs available
  * @mon_scale:		cqm counter * mon_scale = occupancy in bytes
@@ -461,7 +464,6 @@ struct rdt_resource {
 	int (*parse_ctrlval)(struct rdt_parse_data *data,
 			     struct rdt_resource *r,
 			     struct rdt_domain *d);
-	bool (*cbm_validate)(char *buf, u32 *data, struct rdt_resource *r);
 	struct list_head	evt_list;
 	int			num_rmid;
 	unsigned int		mon_scale;
@@ -604,8 +606,6 @@ void cqm_setup_limbo_handler(struct rdt_domain *dom, unsigned long delay_ms);
 void cqm_handle_limbo(struct work_struct *work);
 bool has_busy_rmid(struct rdt_resource *r, struct rdt_domain *d);
 void __check_limbo(struct rdt_domain *d, bool force_free);
-bool cbm_validate_intel(char *buf, u32 *data, struct rdt_resource *r);
-bool cbm_validate_amd(char *buf, u32 *data, struct rdt_resource *r);
 void rdt_domain_reconfigure_cdp(struct rdt_resource *r);
 
 #endif /* _ASM_X86_RESCTRL_INTERNAL_H */
