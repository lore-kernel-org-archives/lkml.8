Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DC27C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 01:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67BBE20748
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 01:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593652931;
	bh=Sc6/7a4ZFbtbmwQKk3K67o57mnr8p/wUtpto7eiLetM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YwB3h2ngyEumOqQpaGXyFvtdr2QkqDIEmaE50j7e7n+kRIxlG6c9FdW37zkXGrtxF
	 931+ryh2Tf0PT1BsvxVlYongItl5FEMQehd1oYBru7auQpju2SQrI0Qfu7x5fmhvKM
	 mqKJubYSnFzzbbIR0OZIk0rThvgkLKDriVV4QHbg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbgGBBWJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 21:22:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:53048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728108AbgGBBWH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 21:22:07 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E822B2085B;
        Thu,  2 Jul 2020 01:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593652926;
        bh=Sc6/7a4ZFbtbmwQKk3K67o57mnr8p/wUtpto7eiLetM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QD8JIKCM/hOx3Mew1Js1i2YKrCyXNOpXYkqL/odaOJzF4a12DGhBZF2hb8Y9WTlUr
         OiLZvZk3LE73RfrIEmExxTwmU1BOwhmxHTL6DWNmeVppmDNN8EHNswS9m6srX8iFmw
         g71iOGQyTgAPtB7yLhlgFjd4ohRF0CMk8RuLuAJw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.7 03/53] perf/x86/rapl: Move RAPL support to common x86 code
Date:   Wed,  1 Jul 2020 21:21:12 -0400
Message-Id: <20200702012202.2700645-3-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200702012202.2700645-1-sashal@kernel.org>
References: <20200702012202.2700645-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephane Eranian <eranian@google.com>

[ Upstream commit fd3ae1e1587d64ef8cc8e361903d33625458073e ]

To prepare for support of both Intel and AMD RAPL.

As per the AMD PPR, Fam17h support Package RAPL counters to monitor power usage.
The RAPL counter operates as with Intel RAPL, and as such it is beneficial
to share the code.

No change in functionality.

Signed-off-by: Stephane Eranian <eranian@google.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20200527224659.206129-2-eranian@google.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/events/Kconfig            | 6 +++---
 arch/x86/events/Makefile           | 1 +
 arch/x86/events/intel/Makefile     | 2 --
 arch/x86/events/{intel => }/rapl.c | 9 ++++++---
 4 files changed, 10 insertions(+), 8 deletions(-)
 rename arch/x86/events/{intel => }/rapl.c (98%)

diff --git a/arch/x86/events/Kconfig b/arch/x86/events/Kconfig
index 9a7a1446cb3a0..4a809c6cbd2f5 100644
--- a/arch/x86/events/Kconfig
+++ b/arch/x86/events/Kconfig
@@ -10,11 +10,11 @@ config PERF_EVENTS_INTEL_UNCORE
 	available on NehalemEX and more modern processors.
 
 config PERF_EVENTS_INTEL_RAPL
-	tristate "Intel rapl performance events"
-	depends on PERF_EVENTS && CPU_SUP_INTEL && PCI
+	tristate "Intel/AMD rapl performance events"
+	depends on PERF_EVENTS && (CPU_SUP_INTEL || CPU_SUP_AMD) && PCI
 	default y
 	---help---
-	Include support for Intel rapl performance events for power
+	Include support for Intel and AMD rapl performance events for power
 	monitoring on modern processors.
 
 config PERF_EVENTS_INTEL_CSTATE
diff --git a/arch/x86/events/Makefile b/arch/x86/events/Makefile
index 9e07f554333fb..b418ef6878796 100644
--- a/arch/x86/events/Makefile
+++ b/arch/x86/events/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-y					+= core.o probe.o
+obj-$(PERF_EVENTS_INTEL_RAPL)		+= rapl.o
 obj-y					+= amd/
 obj-$(CONFIG_X86_LOCAL_APIC)            += msr.o
 obj-$(CONFIG_CPU_SUP_INTEL)		+= intel/
diff --git a/arch/x86/events/intel/Makefile b/arch/x86/events/intel/Makefile
index 3468b0c1dc7c9..e67a5886336c1 100644
--- a/arch/x86/events/intel/Makefile
+++ b/arch/x86/events/intel/Makefile
@@ -2,8 +2,6 @@
 obj-$(CONFIG_CPU_SUP_INTEL)		+= core.o bts.o
 obj-$(CONFIG_CPU_SUP_INTEL)		+= ds.o knc.o
 obj-$(CONFIG_CPU_SUP_INTEL)		+= lbr.o p4.o p6.o pt.o
-obj-$(CONFIG_PERF_EVENTS_INTEL_RAPL)	+= intel-rapl-perf.o
-intel-rapl-perf-objs			:= rapl.o
 obj-$(CONFIG_PERF_EVENTS_INTEL_UNCORE)	+= intel-uncore.o
 intel-uncore-objs			:= uncore.o uncore_nhmex.o uncore_snb.o uncore_snbep.o
 obj-$(CONFIG_PERF_EVENTS_INTEL_CSTATE)	+= intel-cstate.o
diff --git a/arch/x86/events/intel/rapl.c b/arch/x86/events/rapl.c
similarity index 98%
rename from arch/x86/events/intel/rapl.c
rename to arch/x86/events/rapl.c
index a5dbd25852cb7..ece043fb7b494 100644
--- a/arch/x86/events/intel/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -1,11 +1,14 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Support Intel RAPL energy consumption counters
+ * Support Intel/AMD RAPL energy consumption counters
  * Copyright (C) 2013 Google, Inc., Stephane Eranian
  *
  * Intel RAPL interface is specified in the IA-32 Manual Vol3b
  * section 14.7.1 (September 2013)
  *
+ * AMD RAPL interface for Fam17h is described in the public PPR:
+ * https://bugzilla.kernel.org/show_bug.cgi?id=206537
+ *
  * RAPL provides more controls than just reporting energy consumption
  * however here we only expose the 3 energy consumption free running
  * counters (pp0, pkg, dram).
@@ -58,8 +61,8 @@
 #include <linux/nospec.h>
 #include <asm/cpu_device_id.h>
 #include <asm/intel-family.h>
-#include "../perf_event.h"
-#include "../probe.h"
+#include "perf_event.h"
+#include "probe.h"
 
 MODULE_LICENSE("GPL");
 
-- 
2.25.1

