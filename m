Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F10C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 06:16:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EE8820656
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 06:16:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728671AbgG3GQF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 02:16:05 -0400
Received: from mga01.intel.com ([192.55.52.88]:2189 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726287AbgG3GQE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 02:16:04 -0400
IronPort-SDR: uzwtjNGUfP8n/Cuvlhqpgtd8xaD/1p1dqBCgOeRB0XAXZzG4cRhs82o6IxZawK3arIYYGm9iSP
 4Xh31C2zuzHg==
X-IronPort-AV: E=McAfee;i="6000,8403,9697"; a="169666541"
X-IronPort-AV: E=Sophos;i="5.75,413,1589266800"; 
   d="scan'208";a="169666541"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2020 23:16:04 -0700
IronPort-SDR: vncdIGSZjOvJ++EV9D9QT15AoGjFKFxYg4WgykdR9lilU76W41lQnJexaZJq520852MMb5TY9T
 hZ9S9f2XD+nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,413,1589266800"; 
   d="scan'208";a="313301258"
Received: from sgsxdev003.isng.intel.com (HELO localhost) ([10.226.88.14])
  by fmsmga004.fm.intel.com with ESMTP; 29 Jul 2020 23:16:01 -0700
From:   Dilip Kota <eswara.kota@linux.intel.com>
To:     x86@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        hpa@zytor.com, rahul.tanwar@linux.intel.com
Cc:     hdegoede@redhat.com, linux-kernel@vger.kernel.org,
        andy@infradead.org, cheol.yong.kim@intel.com,
        chuanhua.lei@linux.intel.com, qi-ming.wu@intel.com,
        Dilip Kota <eswara.kota@linux.intel.com>
Subject: [PATCH 1/1] x86/tsr: Fix tsc frequency enumeration failure on lightning mountain SoC
Date:   Thu, 30 Jul 2020 14:15:24 +0800
Message-Id: <4fcf09a0786550f5510ec3d9a8628baf7326dd39.1596084248.git.eswara.kota@linux.intel.com>
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
 arch/x86/kernel/tsc_msr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/tsc_msr.c b/arch/x86/kernel/tsc_msr.c
index 4fec6f3a1858b2..c255e10e914aa5 100644
--- a/arch/x86/kernel/tsc_msr.c
+++ b/arch/x86/kernel/tsc_msr.c
@@ -136,7 +136,8 @@ static const struct freq_desc freq_desc_ann = {
 /* 24 MHz crystal? : 24 * 13 / 4 = 78 MHz */
 static const struct freq_desc freq_desc_lgm = {
 	.use_msr_plat = true,
-	.freqs = { 78000, 78000, 78000, 78000, 78000, 78000, 78000, 78000 },
+	.freqs = { 78000, 78000, 78000, 78000, 78000, 78000, 78000, 78000, 78000,
+		   78000, 78000, 78000, 78000, 78000, 78000, 78000 },
 	.mask = 0x0f,
 };
 
-- 
2.11.0

