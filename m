Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B23C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 19:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F4B52071E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 19:02:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391794AbgAXTCr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 14:02:47 -0500
Received: from mga02.intel.com ([134.134.136.20]:12053 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387918AbgAXTCr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 14:02:47 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jan 2020 11:02:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,358,1574150400"; 
   d="scan'208";a="228392465"
Received: from unknown (HELO gayuk-dev-mach.sc.intel.com) ([10.3.79.172])
  by orsmga003.jf.intel.com with ESMTP; 24 Jan 2020 11:02:18 -0800
From:   Gayatri Kammela <gayatri.kammela@intel.com>
To:     platform-driver-x86@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, vishwanath.somayaji@intel.com,
        dvhart@infradead.org, mika.westerberg@intel.com,
        peterz@infradead.org, charles.d.prestopine@intel.com,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Box <david.e.box@intel.com>
Subject: [PATCH v1] platform/x86: Add Atom based Jasper Lake (JSL) platform support to intel_pmc_core driver
Date:   Fri, 24 Jan 2020 10:59:28 -0800
Message-Id: <325960f10edc2418d8c92b5176743472dfbcd486.1579892112.git.gayatri.kammela@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Jasper Lake to the list of the platforms that intel_pmc_core
driver supports for pmc_core device.

Just like Ice Lake, Tiger Lake and Elkhart Lake, Jasper Lake can also
reuse all the Cannon Lake PCH IPs. Also, it uses the same PCH IPs of
Tiger Lake, no additional effort is needed to enable but to simply reuse
them.

Cc: Srinivas Pandruvada <srinivas.pandruvada@intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: David Box <david.e.box@intel.com>
Signed-off-by: Gayatri Kammela <gayatri.kammela@intel.com>
---
 drivers/platform/x86/intel_pmc_core.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
index d583cd5adb31..73ee27c4b027 100644
--- a/drivers/platform/x86/intel_pmc_core.c
+++ b/drivers/platform/x86/intel_pmc_core.c
@@ -193,7 +193,7 @@ static const struct pmc_bit_map cnp_pfear_map[] = {
 	{"Fuse",                BIT(6)},
 	/*
 	 * Reserved for Cannon Lake but valid for Ice Lake, Comet Lake,
-	 * Tiger Lake and Elkhart Lake.
+	 * Tiger Lake, Elkhart Lake and Jasper Lake.
 	 */
 	{"SBR8",		BIT(7)},
 
@@ -240,7 +240,7 @@ static const struct pmc_bit_map cnp_pfear_map[] = {
 	{"HDA_PGD6",            BIT(4)},
 	/*
 	 * Reserved for Cannon Lake but valid for Ice Lake, Comet Lake,
-	 * Tiger Lake and ELkhart Lake.
+	 * Tiger Lake, ELkhart Lake and Jasper Lake.
 	 */
 	{"PSF6",		BIT(5)},
 	{"PSF7",		BIT(6)},
@@ -273,7 +273,7 @@ static const struct pmc_bit_map *ext_icl_pfear_map[] = {
 };
 
 static const struct pmc_bit_map tgl_pfear_map[] = {
-	/* Tiger Lake and Elkhart Lake generation onwards only */
+	/* Tiger Lake, Elkhart Lake and Jasper Lake generation onwards only */
 	{"PSF9",		BIT(0)},
 	{"RES_66",		BIT(1)},
 	{"RES_67",		BIT(2)},
@@ -1138,6 +1138,7 @@ static const struct x86_cpu_id intel_pmc_core_ids[] = {
 	INTEL_CPU_FAM6(TIGERLAKE_L, tgl_reg_map),
 	INTEL_CPU_FAM6(TIGERLAKE, tgl_reg_map),
 	INTEL_CPU_FAM6(ATOM_TREMONT, tgl_reg_map),
+	INTEL_CPU_FAM6(ATOM_TREMONT_L, tgl_reg_map),
 	{}
 };
 
-- 
2.17.1

