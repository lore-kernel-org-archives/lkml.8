Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8369C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 17:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEDE0207DA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 17:28:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729956AbgFOR2B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 13:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728585AbgFOR2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 13:28:01 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C08C061A0E;
        Mon, 15 Jun 2020 10:28:00 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jksto-000084-2S; Mon, 15 Jun 2020 19:27:56 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 82B661C00ED;
        Mon, 15 Jun 2020 19:27:55 +0200 (CEST)
Date:   Mon, 15 Jun 2020 17:27:55 -0000
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/msr: Lift AMD family 0x15 power-specific MSRs
Cc:     Borislav Petkov <bp@suse.de>, Guenter Roeck <linux@roeck-us.net>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159224207528.16989.13598767169279100668.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     d9124642495d0d91f2a09db933c0485f1abe6611
Gitweb:        https://git.kernel.org/tip/d9124642495d0d91f2a09db933c0485f1abe6611
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Mon, 08 Jun 2020 16:19:49 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 15 Jun 2020 18:01:26 +02:00

x86/msr: Lift AMD family 0x15 power-specific MSRs

... into the global msr-index.h header because they're used in multiple
compilation units. Sort the MSR list a bit. Update the msr-index.h copy
in tools.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/x86/events/amd/power.c            | 4 ----
 arch/x86/include/asm/msr-index.h       | 5 ++++-
 drivers/hwmon/fam15h_power.c           | 4 ----
 tools/arch/x86/include/asm/msr-index.h | 5 ++++-
 4 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/arch/x86/events/amd/power.c b/arch/x86/events/amd/power.c
index 43b09e9..16a2369 100644
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
index e8370e6..eb95372 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -418,15 +418,18 @@
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
index 267eac0..29f5fed 100644
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
index ef452b8..7dfd45b 100644
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
