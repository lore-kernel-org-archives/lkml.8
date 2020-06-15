Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0625FC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 18:41:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD1E9207D4
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 18:41:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731423AbgFOSk7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 14:40:59 -0400
Received: from mga06.intel.com ([134.134.136.31]:40522 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731415AbgFOSk6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 14:40:58 -0400
IronPort-SDR: 3Ysw0mhLJdLs8W+RBzti/i7RT+Am/FjCBQA0lpZPt7Jo+CqUw9uLBDF/gYGiINu4GufSOZXhlt
 qPCuux4ciwng==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2020 11:40:57 -0700
IronPort-SDR: S+6fT8Oicmw6ETedAOSMuRGjrbO84YI4y2V3zIkkPekNc8xHjILpUB+YkzTfG+768jBnMLkvPJ
 V5SxlQ4PFHvQ==
X-IronPort-AV: E=Sophos;i="5.73,515,1583222400"; 
   d="scan'208";a="308826233"
Received: from agluck-desk2.sc.intel.com ([10.3.52.68])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2020 11:40:56 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Youquan Song <youquan.song@intel.com>,
        Tony Luck <tony.luck@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86/mce: Add Skylake quirk for patrol scrub reported errors
Date:   Mon, 15 Jun 2020 11:40:56 -0700
Message-Id: <20200615184056.26531-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Youquan Song <youquan.song@intel.com>

Skylake has a mode where the system administrator can use a BIOS setup
option to request that the memory controller report uncorrected errors
found by the patrol scrubber as corrected.  This results in them being
signalled using CMCI, which is less disruptive than a machine check.

Add a quirk to detect that a "corrected" error is actually a downgraded
uncorrected error with model specific checks for the "MSCOD" signature in
MCi_STATUS and that the error was reported from a memory controller bank.

Adjust the severity to MCE_AO_SEVERITY so that Linux will try to take
the affected page offline.

[Tony: Wordsmith commit comment]

Signed-off-by: Youquan Song <youquan.song@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/mce/core.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index e9265e2f28c9..0dbd0a21a0bf 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -123,6 +123,8 @@ static struct irq_work mce_irq_work;
 
 static void (*quirk_no_way_out)(int bank, struct mce *m, struct pt_regs *regs);
 
+static void no_adjust_mce_log(struct mce *m) {};
+static void (*adjust_mce_log)(struct mce *m) = no_adjust_mce_log;
 /*
  * CPU/chipset specific EDAC code can register a notifier call here to print
  * MCE errors in a human-readable form.
@@ -772,6 +774,7 @@ bool machine_check_poll(enum mcp_flags flags, mce_banks_t *b)
 		if (mca_cfg.dont_log_ce && !mce_usable_address(&m))
 			goto clear_it;
 
+		adjust_mce_log(&m);
 		mce_log(&m);
 
 clear_it:
@@ -1640,6 +1643,30 @@ static void quirk_sandybridge_ifu(int bank, struct mce *m, struct pt_regs *regs)
 	m->cs = regs->cs;
 }
 
+/*
+ * Skylake family CPUs have a mode where the user can request that
+ * the memory controller report uncorrected errors found by the patrol
+ * scrubber as corrected (MCI_STATUS_UC == 0). This results in them being
+ * signalled using CMCI, which is less disruptive that a machine check.
+ * The following quirk detects such errors and adjusts the severity.
+ */
+
+#define MSCOD_UCE_SCRUB	(0x0010 << 16) /* UnCorrected Patrol Scrub Error */
+#define MSCOD_MASK	GENMASK_ULL(31, 16)
+
+/*
+ * Check the error code to see if this is an uncorrected patrol
+ * scrub error from one of the memory controller banks. If so,
+ * then adjust the severity level to MCE_AO_SEVERITY
+ */
+static void quirk_skx_adjust_mce_log(struct mce *m)
+{
+	if (((m->status & MCACOD_SCRUBMSK) == MCACOD_SCRUB) &&
+	    ((m->status & MSCOD_MASK) == MSCOD_UCE_SCRUB) &&
+	    m->bank >= 13 && m->bank <= 18)
+		m->severity = MCE_AO_SEVERITY;
+}
+
 /* Add per CPU specific workarounds here */
 static int __mcheck_cpu_apply_quirks(struct cpuinfo_x86 *c)
 {
@@ -1714,6 +1741,9 @@ static int __mcheck_cpu_apply_quirks(struct cpuinfo_x86 *c)
 
 		if (c->x86 == 6 && c->x86_model == 45)
 			quirk_no_way_out = quirk_sandybridge_ifu;
+
+		if (c->x86 == 6 && c->x86_model == INTEL_FAM6_SKYLAKE_X)
+			adjust_mce_log = quirk_skx_adjust_mce_log;
 	}
 
 	if (c->x86_vendor == X86_VENDOR_ZHAOXIN) {
-- 
2.21.1

