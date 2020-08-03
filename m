Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C1B8C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 07:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC981206D4
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 07:57:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725945AbgHCH5U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 03:57:20 -0400
Received: from mga11.intel.com ([192.55.52.93]:57296 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725855AbgHCH5T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 03:57:19 -0400
IronPort-SDR: uv1LacBmTNYdKe4aHvKxVA5aRFRAFwGnspnqR+P7qDwDltt/O/LVJhu+YZGqlAc557pUF3zhcg
 CqRRMWfmmXdw==
X-IronPort-AV: E=McAfee;i="6000,8403,9701"; a="149860482"
X-IronPort-AV: E=Sophos;i="5.75,429,1589266800"; 
   d="scan'208";a="149860482"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2020 00:57:19 -0700
IronPort-SDR: UofXxyXTJjPFG6h3gnRb6Y63QeecTBqZy7k53xZisVLBiJMHcEq02Ky6icbFcRx0vbSSmPz3bA
 GA1cWQzrvp5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,429,1589266800"; 
   d="scan'208";a="314579642"
Received: from sgsxdev003.isng.intel.com (HELO localhost) ([10.226.88.14])
  by fmsmga004.fm.intel.com with ESMTP; 03 Aug 2020 00:57:16 -0700
From:   Dilip Kota <eswara.kota@linux.intel.com>
To:     x86@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        hpa@zytor.com, rahul.tanwar@linux.intel.com
Cc:     tony.luck@intel.com, hdegoede@redhat.com,
        linux-kernel@vger.kernel.org, andy@infradead.org,
        cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com, Dilip Kota <eswara.kota@linux.intel.com>
Subject: [PATCH v3 1/1] x86/tsr: Fix tsc frequency enumeration failure on Lightning Mountain SoC
Date:   Mon,  3 Aug 2020 15:56:36 +0800
Message-Id: <211c643ae217604b46cbec43a2c0423946dc7d2d.1596440057.git.eswara.kota@linux.intel.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Frequency descriptor of Lightning Mountain SoC doesn't have all the
frequency entries so resulting in the below failure causing kernel hang.

[    0.000000] Error MSR_FSB_FREQ index 15 is unknown
[    0.000000] tsc: Fast TSC calibration failed

So, add all the frequency entries in the Lightning Mountain SoC frequency
descriptor.

Fixes: 0cc5359d8fd45 ("x86/cpu: Update init data for new Airmont CPU model")
Fixes: 812c2d7506fd ("x86/tsc_msr: Use named struct initializers")
Signed-off-by: Dilip Kota <eswara.kota@linux.intel.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
Changes on v3:
  Fix the nit pick pointed by Andy
  Add Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Changes on v2:
  Add description in the comments explaining about frequency entries.
 arch/x86/kernel/tsc_msr.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/tsc_msr.c b/arch/x86/kernel/tsc_msr.c
index 4fec6f3a1858b2..a654a9b4b77c07 100644
--- a/arch/x86/kernel/tsc_msr.c
+++ b/arch/x86/kernel/tsc_msr.c
@@ -133,10 +133,15 @@ static const struct freq_desc freq_desc_ann = {
 	.mask = 0x0f,
 };
 
-/* 24 MHz crystal? : 24 * 13 / 4 = 78 MHz */
+/*
+ * 24 MHz crystal? : 24 * 13 / 4 = 78 MHz
+ * Frequency step for Lightning Mountain SoC is fixed to 78 MHz,
+ * so all the frequency entries are 78000.
+ */
 static const struct freq_desc freq_desc_lgm = {
 	.use_msr_plat = true,
-	.freqs = { 78000, 78000, 78000, 78000, 78000, 78000, 78000, 78000 },
+	.freqs = { 78000, 78000, 78000, 78000, 78000, 78000, 78000, 78000,
+		   78000, 78000, 78000, 78000, 78000, 78000, 78000, 78000 },
 	.mask = 0x0f,
 };
 
-- 
2.11.0

