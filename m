Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F48BC47258
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 22:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38CFD206FA
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 22:36:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729495AbgEEWgy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 18:36:54 -0400
Received: from mga09.intel.com ([134.134.136.24]:41852 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729447AbgEEWgt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 18:36:49 -0400
IronPort-SDR: bteAh34PnL9qc00zRqBok2KDIVIgGCA5bn+3UR4SRDKCcGyGJk2OrZOUWnRDrpKMmh0h5ZDCuu
 3VEGF7b5lzxw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2020 15:36:48 -0700
IronPort-SDR: 712HFudz9AZH15e6tZm2gewlKugR/9Yp98LKlkHFKE3XDortyf7EjsDUqrFh8hqFDwFzb5g88L
 6d5WctPODkuw==
X-IronPort-AV: E=Sophos;i="5.73,357,1583222400"; 
   d="scan'208";a="284410861"
Received: from rchatre-s.jf.intel.com ([10.54.70.76])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2020 15:36:48 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     tglx@linutronix.de, fenghua.yu@intel.com, bp@alien8.de,
        tony.luck@intel.com
Cc:     kuo-lang.tseng@intel.com, mingo@redhat.com, babu.moger@amd.com,
        hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH V2 7/7] x86/resctrl: Support wider MBM counters
Date:   Tue,  5 May 2020 15:36:18 -0700
Message-Id: <69d52abd5b14794d3a0f05ba7c755ed1f4c0d5ed.1588715690.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1588715690.git.reinette.chatre@intel.com>
References: <cover.1588715690.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The original Memory Bandwidth Monitoring (MBM) architectural
definition defines counters of up to 62 bits in the
IA32_QM_CTR MSR while the first-generation MBM implementation
uses statically defined 24 bit counters.

The MBM CPUID enumeration properties have been expanded to include
the MBM counter width, encoded as an offset from 24 bits.

While eight bits are available for the counter width offset
IA32_QM_CTR MSR only supports 62 bit counters. A sanity check,
with warning printed when encountered, is added to ensure counters
cannot exceed the 62 bit limit.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/kernel/cpu/resctrl/internal.h | 8 +++++++-
 arch/x86/kernel/cpu/resctrl/monitor.c  | 8 +++++++-
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 58b002c31655..f20a47d120b1 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -31,7 +31,7 @@
 
 #define CQM_LIMBOCHECK_INTERVAL	1000
 
-#define MBM_CNTR_WIDTH			24
+#define MBM_CNTR_WIDTH_BASE		24
 #define MBM_OVERFLOW_INTERVAL		1000
 #define MAX_MBA_BW			100u
 #define MBA_IS_LINEAR			0x4
@@ -40,6 +40,12 @@
 
 #define RMID_VAL_ERROR			BIT_ULL(63)
 #define RMID_VAL_UNAVAIL		BIT_ULL(62)
+/*
+ * With the above fields in use 62 bits remain in MSR_IA32_QM_CTR for
+ * data to be returned. The counter width is discovered from the hardware
+ * as an offset from MBM_CNTR_WIDTH_BASE.
+ */
+#define MBM_CNTR_WIDTH_OFFSET_MAX (62 - MBM_CNTR_WIDTH_BASE)
 
 
 struct rdt_fs_context {
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index df964c03f6c6..837d7d012b7b 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -618,12 +618,18 @@ static void l3_mon_evt_init(struct rdt_resource *r)
 
 int rdt_get_mon_l3_config(struct rdt_resource *r)
 {
+	unsigned int mbm_offset = boot_cpu_data.x86_cache_mbm_width_offset;
 	unsigned int cl_size = boot_cpu_data.x86_cache_size;
 	int ret;
 
 	r->mon_scale = boot_cpu_data.x86_cache_occ_scale;
 	r->num_rmid = boot_cpu_data.x86_cache_max_rmid + 1;
-	r->mbm_width = MBM_CNTR_WIDTH;
+	r->mbm_width = MBM_CNTR_WIDTH_BASE;
+
+	if (mbm_offset > 0 && mbm_offset <= MBM_CNTR_WIDTH_OFFSET_MAX)
+		r->mbm_width += mbm_offset;
+	else if (mbm_offset > MBM_CNTR_WIDTH_OFFSET_MAX)
+		pr_warn("Ignoring impossible MBM counter offset\n");
 
 	/*
 	 * A reasonable upper limit on the max threshold is the number
-- 
2.21.0

