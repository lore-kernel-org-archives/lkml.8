Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B159C47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 18:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2332F20736
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 18:10:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731010AbgEKSKm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 14:10:42 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:38421 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726891AbgEKSKm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 14:10:42 -0400
Received: from localhost.localdomain (ip5f5af07e.dynamic.kabel-deutschland.de [95.90.240.126])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 3091F2002EE0A;
        Mon, 11 May 2020 20:10:39 +0200 (CEST)
From:   Paul Menzel <pmenzel@molgen.mpg.de>
To:     linux-kernel@vger.kernel.org
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Subject: [PATCH] clocksource: Add `nopmtmr` to disable ACPI PM Timer at run-time
Date:   Mon, 11 May 2020 20:07:02 +0200
Message-Id: <20200511180702.27893-1-pmenzel@molgen.mpg.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initializing the ACPI Power Management Timer takes 33 ms on the ASUS
F2A85-M PRO.

     [    0.248373] calling  init_acpi_pm_clocksource+0x0/0x197 @ 1
     [    0.282913] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
     [    0.282916] initcall init_acpi_pm_clocksource+0x0/0x197 returned 0 after 33731 usecs

Currently, it’s only possible to disable that clocksource with the
Kconfig option `X86_PM_TIMER`, so add the option `nopmtmr` to disable
that clocksource at run-time.

     [    0.248381] calling  init_acpi_pm_clocksource+0x0/0x197 @ 1
     [    0.248383] initcall init_acpi_pm_clocksource+0x0/0x197 returned -19 after 0 usecs

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
---
Please consider this a request for comments.

1.  What would be the correct return value? Can ENODEV be used?
2.  Should the attribute `__read_mostly` be added?
---
 Documentation/admin-guide/kernel-parameters.txt |  2 ++
 drivers/clocksource/acpi_pm.c                   | 15 +++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 7bc83f3d9bdf..4ea7fa94b015 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3246,6 +3246,8 @@
 
 	nopcid		[X86-64] Disable the PCID cpu feature.
 
+	nopmtmr		[X86] Disable the ACPI Power Management Timer.
+
 	norandmaps	Don't use address space randomization.  Equivalent to
 			echo 0 > /proc/sys/kernel/randomize_va_space
 
diff --git a/drivers/clocksource/acpi_pm.c b/drivers/clocksource/acpi_pm.c
index eb596ff9e7bb..c1249f9c9acf 100644
--- a/drivers/clocksource/acpi_pm.c
+++ b/drivers/clocksource/acpi_pm.c
@@ -30,6 +30,7 @@
  * in arch/i386/kernel/acpi/boot.c
  */
 u32 pmtmr_ioport __read_mostly;
+static bool nopmtmr;
 
 static inline u32 read_pmtmr(void)
 {
@@ -177,6 +178,9 @@ static int __init init_acpi_pm_clocksource(void)
 	u64 value1, value2;
 	unsigned int i, j = 0;
 
+	if (nopmtmr)
+		return -ENODEV;
+
 	if (!pmtmr_ioport)
 		return -ENODEV;
 
@@ -239,3 +243,14 @@ static int __init parse_pmtmr(char *arg)
 	return 1;
 }
 __setup("pmtmr=", parse_pmtmr);
+
+/*
+ * Allow to disable PMTimer at run-time.
+ */
+static int __init parse_nopmtmr(char *arg)
+{
+	nopmtmr = true;
+
+	return 0;
+}
+__setup("nopmtmr", parse_nopmtmr);
-- 
2.26.2

