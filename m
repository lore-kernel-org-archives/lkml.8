Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C2CFC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 10:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F364120838
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 10:01:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729191AbgG3KBp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 06:01:45 -0400
Received: from mga09.intel.com ([134.134.136.24]:23981 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726847AbgG3KBp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 06:01:45 -0400
IronPort-SDR: YzqaBCgw1jHuAFTwgi/qkrFvRW30fswu+FkkV6deAQpg+GyBmdjpKX+/4/pz2c6HPboNZ3b3rB
 4zdut0YHVqcg==
X-IronPort-AV: E=McAfee;i="6000,8403,9697"; a="152793530"
X-IronPort-AV: E=Sophos;i="5.75,414,1589266800"; 
   d="scan'208";a="152793530"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2020 03:01:44 -0700
IronPort-SDR: FxOU6+iY7ETDuMxgw4aZbQTi9R5349YtyQI6Lj+IQzLyKJCjINKdfS/nhOcJImk9LkCqR/ZCZT
 jxfSG/2OyU6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,414,1589266800"; 
   d="scan'208";a="313360870"
Received: from sgsxdev003.isng.intel.com (HELO localhost) ([10.226.88.14])
  by fmsmga004.fm.intel.com with ESMTP; 30 Jul 2020 03:01:41 -0700
From:   Dilip Kota <eswara.kota@linux.intel.com>
To:     x86@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        hpa@zytor.com, rahul.tanwar@linux.intel.com
Cc:     hdegoede@redhat.com, linux-kernel@vger.kernel.org,
        andy@infradead.org, cheol.yong.kim@intel.com,
        chuanhua.lei@linux.intel.com, qi-ming.wu@intel.com,
        Dilip Kota <eswara.kota@linux.intel.com>
Subject: [PATCH v2 1/1] x86/tsr: Fix tsc frequency enumeration failure on Lightning Mountain SoC
Date:   Thu, 30 Jul 2020 18:01:07 +0800
Message-Id: <8b64c9f9e54351d841daea663f0579de3c103f15.1596103176.git.eswara.kota@linux.intel.com>
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
---
Changes on v2:
  Add description in the comments explaining about frequency entries.

 arch/x86/kernel/tsc_msr.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/tsc_msr.c b/arch/x86/kernel/tsc_msr.c
index 4fec6f3a1858b2..83b54c65aad2f3 100644
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
+	.freqs = { 78000, 78000, 78000, 78000, 78000, 78000, 78000, 78000, 78000,
+		   78000, 78000, 78000, 78000, 78000, 78000, 78000 },
 	.mask = 0x0f,
 };
 
-- 
2.11.0

