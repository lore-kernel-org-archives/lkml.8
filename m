Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B6E5C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 21:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B46920671
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 21:58:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fNLd3V7H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbgEOV6E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 17:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726261AbgEOV6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 17:58:03 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82EE4C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 14:58:03 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id c20so4013615qtw.11
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 14:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=jsgrd+yL+qVjZ1fQ9LAGCWz1zaJCfpOMPOOJKKSyH+M=;
        b=fNLd3V7HwbN6zH9B56Vihufpy59WO4cmpH3k4PHtA3rlI/j2OdHgyjB9jCqE/5d/p6
         lpHOdtUaeiY7D2lWcEdVGhXML4i5FtydwMcZUIVW4YiRnW2By/qfPHItvnCIxzsN3A/4
         ny0Sx2nVAi6l+uQ1oGdR5dCt5gR6TRq/I7TaR9m3OX2+/980bfZRVhI0ni1HL9ZsJsd/
         +QeU7c5torWv6YtVJ0J0fd0MtvOTnK1UfoKmEo3e0S6rSYdM9ddEfwzjyCxO8QF4MpOG
         cIbbHKjPKBcx96/B6u3oPaNxmc5l1qoftv9rPOGJMQyG1W1eQ2pnCiAbuymk8xjaS8ky
         AF2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=jsgrd+yL+qVjZ1fQ9LAGCWz1zaJCfpOMPOOJKKSyH+M=;
        b=GKNBuTRFxJF9/6U+9hZWqhXjkxVdyR70cZCNnMwI5CBYF4PTh5AezUeqrNkeuHCuwA
         colustKcRBqcUTBQvTIHirm6TCHu4Lu4SCyABQZCkvy3mPZcFHs8fgCh9ydVkajKyoA+
         frmvagaV3OAJ7kPuqXqsaA3BJoDw/VnJBHOX4UWemsV7xFkX1erCPYbPRKq8DWYG8Bos
         M5k6TNllKI7hinJU5q/2oSiEvmG/NzcgDZ3gZMGmy/eNMXGk3jMIR9vK8XPmP/W1uWOt
         G4Uogl5Peju7rttkX8IK86YnHm1o/wIBOJ+nOiw0OOcCCjOA3OoLh1mOFewP9V/PCrfo
         4Xug==
X-Gm-Message-State: AOAM532YgGfyaiPmxH4Q428RrEEGTNPVpCHe1fPw2uin4Mzv0cYrrlvn
        Db/2WgCa39PfFd8NLoSyM9IQyu9Rj8DBLmuUIVgcXk6lQafy/4/n9JuZTI57iuX4svn2lHGFNZR
        CV7ufN0c+ol3qNA9uyb9M9Gn6IiutPB/whWaxllgCR3cTpFj07ZkQX9RHzJfmyScI3QA5+hw0
X-Google-Smtp-Source: ABdhPJx+Z/MItTtCJCfFpi9pMsPchH13M20FpqlsTAUzy13GDlZZlAsT+biYytaGjPd0e3+iTi1bHxBq1fSu
X-Received: by 2002:a05:6214:445:: with SMTP id cc5mr5670792qvb.161.1589579882620;
 Fri, 15 May 2020 14:58:02 -0700 (PDT)
Date:   Fri, 15 May 2020 14:57:31 -0700
In-Reply-To: <20200515215733.20647-1-eranian@google.com>
Message-Id: <20200515215733.20647-2-eranian@google.com>
Mime-Version: 1.0
References: <20200515215733.20647-1-eranian@google.com>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be-goog
Subject: [PATCH 1/3] perf/x86/rapl: move RAPL support to common x86 code
From:   Stephane Eranian <eranian@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@elte.hu, irogers@google.com,
        kim.phillips@amd.com, jolsa@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To prepare for support of both Intel and AMD RAPL.
Move rapl.c to arch/x86/events. Rename config option.
Fixup header paths.

Signed-off-by: Stephane Eranian <eranian@google.com>
---
 arch/x86/events/Kconfig            | 8 ++++----
 arch/x86/events/Makefile           | 1 +
 arch/x86/events/intel/Makefile     | 2 --
 arch/x86/events/{intel => }/rapl.c | 9 ++++++---
 4 files changed, 11 insertions(+), 9 deletions(-)
 rename arch/x86/events/{intel => }/rapl.c (98%)

diff --git a/arch/x86/events/Kconfig b/arch/x86/events/Kconfig
index 9a7a1446cb3a0..e542c32b0a55f 100644
--- a/arch/x86/events/Kconfig
+++ b/arch/x86/events/Kconfig
@@ -9,12 +9,12 @@ config PERF_EVENTS_INTEL_UNCORE
 	Include support for Intel uncore performance events. These are
 	available on NehalemEX and more modern processors.
 
-config PERF_EVENTS_INTEL_RAPL
-	tristate "Intel rapl performance events"
-	depends on PERF_EVENTS && CPU_SUP_INTEL && PCI
+config PERF_EVENTS_X86_RAPL
+	tristate "RAPL performance events"
+	depends on PERF_EVENTS && (CPU_SUP_INTEL || CPU_SUP_AMD) && PCI
 	default y
 	---help---
-	Include support for Intel rapl performance events for power
+	Include support for Intel and AMD rapl performance events for power
 	monitoring on modern processors.
 
 config PERF_EVENTS_INTEL_CSTATE
diff --git a/arch/x86/events/Makefile b/arch/x86/events/Makefile
index 6f1d1fde8b2de..d5087a5745108 100644
--- a/arch/x86/events/Makefile
+++ b/arch/x86/events/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-y					+= core.o probe.o
+obj-$(CONFIG_PERF_EVENTS_X86_RAPL)	+= rapl.o
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
2.26.2.761.g0e0b3e54be-goog

