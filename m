Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C5CCC433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 16:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBFCF2076A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 16:49:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="ZqCLTomY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387452AbgFHQtA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 12:49:00 -0400
Received: from mail.skyhub.de ([5.9.137.197]:60552 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730600AbgFHQs6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 12:48:58 -0400
Received: from zn.tnic (p200300ec2f26d700bd0154d6acadb88d.dip0.t-ipconnect.de [IPv6:2003:ec:2f26:d700:bd01:54d6:acad:b88d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1E5621EC0350;
        Mon,  8 Jun 2020 18:48:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1591634936;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=rOKfoU0ZC5rCSSB2Qb9KKfq8usShNnx2QQldAkXS4EM=;
        b=ZqCLTomYIeFVP6pAHyLYVb8funu9IPaoBC2N2NcUdP192rj9HzH9QQDm/YK5N3ssFTrzjS
        fSKpGcqgIA1nkuFSdYvZv5pWEuaTv9bn4yz39iBRgrBLlwc33caYd3zWHGXrBTvgHWlHlH
        Uqm92VAq/HnLwDS4rrG/HXb5gMrFXQk=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     Huang Rui <ray.huang@amd.com>, linux-hwmon@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86/msr: Lift AMD family 0x15 power-specific MSRs
Date:   Mon,  8 Jun 2020 18:48:47 +0200
Message-Id: <20200608164847.14232-1-bp@alien8.de>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

... into the global msr-index.h header because they're used in multiple
compilation units. Sort the MSR list a bit. Update the msr-index.h copy
in tools.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/events/amd/power.c            | 4 ----
 arch/x86/include/asm/msr-index.h       | 5 ++++-
 drivers/hwmon/fam15h_power.c           | 4 ----
 tools/arch/x86/include/asm/msr-index.h | 5 ++++-
 4 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/arch/x86/events/amd/power.c b/arch/x86/events/amd/power.c
index 43b09e9c93a2..16a2369c586e 100644
--- a/arch/x86/events/amd/power.c
+++ b/arch/x86/events/amd/power.c
@@ -13,10 +13,6 @@
 #include <asm/cpu_device_id.h>
 #include "../perf_event.h"
 
-#define MSR_F15H_CU_PWR_ACCUMULATOR     0xc001007a
-#define MSR_F15H_CU_MAX_PWR_ACCUMULATOR 0xc001007b
-#define MSR_F15H_PTSC			0xc0010280
-
 /* Event code: LSB 8 bits, passed in attr->config any other bit is reserved. */
 #define AMD_POWER_EVENT_MASK		0xFFULL
 
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index ef452b817f44..7dfd45bb6cdb 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -414,15 +414,18 @@
 #define MSR_AMD64_PATCH_LEVEL		0x0000008b
 #define MSR_AMD64_TSC_RATIO		0xc0000104
 #define MSR_AMD64_NB_CFG		0xc001001f
-#define MSR_AMD64_CPUID_FN_1		0xc0011004
 #define MSR_AMD64_PATCH_LOADER		0xc0010020
 #define MSR_AMD_PERF_CTL		0xc0010062
 #define MSR_AMD_PERF_STATUS		0xc0010063
 #define MSR_AMD_PSTATE_DEF_BASE		0xc0010064
+#define MSR_F15H_CU_PWR_ACCUMULATOR     0xc001007a
+#define MSR_F15H_CU_MAX_PWR_ACCUMULATOR 0xc001007b
 #define MSR_AMD64_OSVW_ID_LENGTH	0xc0010140
 #define MSR_AMD64_OSVW_STATUS		0xc0010141
+#define MSR_F15H_PTSC			0xc0010280
 #define MSR_AMD_PPIN_CTL		0xc00102f0
 #define MSR_AMD_PPIN			0xc00102f1
+#define MSR_AMD64_CPUID_FN_1		0xc0011004
 #define MSR_AMD64_LS_CFG		0xc0011020
 #define MSR_AMD64_DC_CFG		0xc0011022
 #define MSR_AMD64_BU_CFG2		0xc001102a
diff --git a/drivers/hwmon/fam15h_power.c b/drivers/hwmon/fam15h_power.c
index 267eac00a3fb..29f5fed28c2a 100644
--- a/drivers/hwmon/fam15h_power.c
+++ b/drivers/hwmon/fam15h_power.c
@@ -41,10 +41,6 @@ MODULE_LICENSE("GPL");
 /* set maximum interval as 1 second */
 #define MAX_INTERVAL			1000
 
-#define MSR_F15H_CU_PWR_ACCUMULATOR	0xc001007a
-#define MSR_F15H_CU_MAX_PWR_ACCUMULATOR	0xc001007b
-#define MSR_F15H_PTSC			0xc0010280
-
 #define PCI_DEVICE_ID_AMD_15H_M70H_NB_F4 0x15b4
 
 struct fam15h_power_data {
diff --git a/tools/arch/x86/include/asm/msr-index.h b/tools/arch/x86/include/asm/msr-index.h
index ef452b817f44..7dfd45bb6cdb 100644
--- a/tools/arch/x86/include/asm/msr-index.h
+++ b/tools/arch/x86/include/asm/msr-index.h
@@ -414,15 +414,18 @@
 #define MSR_AMD64_PATCH_LEVEL		0x0000008b
 #define MSR_AMD64_TSC_RATIO		0xc0000104
 #define MSR_AMD64_NB_CFG		0xc001001f
-#define MSR_AMD64_CPUID_FN_1		0xc0011004
 #define MSR_AMD64_PATCH_LOADER		0xc0010020
 #define MSR_AMD_PERF_CTL		0xc0010062
 #define MSR_AMD_PERF_STATUS		0xc0010063
 #define MSR_AMD_PSTATE_DEF_BASE		0xc0010064
+#define MSR_F15H_CU_PWR_ACCUMULATOR     0xc001007a
+#define MSR_F15H_CU_MAX_PWR_ACCUMULATOR 0xc001007b
 #define MSR_AMD64_OSVW_ID_LENGTH	0xc0010140
 #define MSR_AMD64_OSVW_STATUS		0xc0010141
+#define MSR_F15H_PTSC			0xc0010280
 #define MSR_AMD_PPIN_CTL		0xc00102f0
 #define MSR_AMD_PPIN			0xc00102f1
+#define MSR_AMD64_CPUID_FN_1		0xc0011004
 #define MSR_AMD64_LS_CFG		0xc0011020
 #define MSR_AMD64_DC_CFG		0xc0011022
 #define MSR_AMD64_BU_CFG2		0xc001102a
-- 
2.21.0

