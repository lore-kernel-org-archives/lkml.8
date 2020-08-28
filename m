Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3598C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 20:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B57F20872
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 20:21:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbgH1UVy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 16:21:54 -0400
Received: from mga06.intel.com ([134.134.136.31]:20557 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726033AbgH1UVw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 16:21:52 -0400
IronPort-SDR: dcJWC4OC/h6or2j7jOyZJgyQV28of0IqVBA5YjOxxFKCayBuuy1D5lg3qYrQm1l4CkdTOBFlf0
 CdqFBdhm2mfw==
X-IronPort-AV: E=McAfee;i="6000,8403,9727"; a="218296666"
X-IronPort-AV: E=Sophos;i="5.76,365,1592895600"; 
   d="scan'208";a="218296666"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2020 13:21:52 -0700
IronPort-SDR: kdb6aqXSAlyd2ELvUl+q+/AVHnlwLgMtbNHRH/UPuIcxPTDvhEeYa927E8s5xmqV6Kg6eGxg88
 RVE5FAR7zr0Q==
X-IronPort-AV: E=Sophos;i="5.76,365,1592895600"; 
   d="scan'208";a="444950476"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.68])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2020 13:21:51 -0700
Date:   Fri, 28 Aug 2020 13:21:50 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Song, Youquan" <youquan.song@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] x86/mce: Add Skylake quirk for patrol scrub reported
 errors
Message-ID: <20200828202150.GA11854@agluck-desk2.amr.corp.intel.com>
References: <20200615184056.26531-1-tony.luck@intel.com>
 <20200616192952.GO13515@zn.tnic>
 <3908561D78D1C84285E8C5FCA982C28F7F670974@ORSMSX115.amr.corp.intel.com>
 <20200617074158.GB10118@zn.tnic>
 <20200617184901.GA387@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617184901.GA387@agluck-desk2.amr.corp.intel.com>
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
This updated patch slipped through some cracks. Sorry for the delay.

V2:
Boris:	Don't optimize with pointer to quirk function. Just do
 	the vendor/family/model check in the adjust_mce_log()
	function
Tony:	Add check for stepping >= 4
---
 arch/x86/kernel/cpu/mce/core.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index e9265e2f28c9..2d5fe23adf29 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -673,6 +673,35 @@ static void mce_read_aux(struct mce *m, int i)
 	}
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
+static void adjust_mce_log(struct mce *m)
+{
+	struct cpuinfo_x86 *c = &boot_cpu_data;
+
+	if (c->x86_vendor == X86_VENDOR_INTEL && c->x86 == 6 &&
+	    c->x86_model == INTEL_FAM6_SKYLAKE_X && c->x86_stepping >= 4) {
+		/*
+		 * Check the error code to see if this is an uncorrected patrol
+		 * scrub error from one of the memory controller banks. If so,
+		 * then adjust the severity level to MCE_AO_SEVERITY
+		 */
+		if (((m->status & MCACOD_SCRUBMSK) == MCACOD_SCRUB) &&
+		    ((m->status & MSCOD_MASK) == MSCOD_UCE_SCRUB) &&
+		    m->bank >= 13 && m->bank <= 18)
+			m->severity = MCE_AO_SEVERITY;
+	}
+}
+
 DEFINE_PER_CPU(unsigned, mce_poll_count);
 
 /*
@@ -772,6 +801,7 @@ bool machine_check_poll(enum mcp_flags flags, mce_banks_t *b)
 		if (mca_cfg.dont_log_ce && !mce_usable_address(&m))
 			goto clear_it;
 
+		adjust_mce_log(&m);
 		mce_log(&m);
 
 clear_it:
-- 
2.21.1

