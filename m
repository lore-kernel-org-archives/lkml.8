Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D4B1C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 22:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2ADC2073B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 22:47:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JwousZ2y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbgE0WrP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 18:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbgE0WrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 18:47:12 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 292AFC05BD1E
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 15:47:11 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id q16so1025885qki.13
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 15:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=nbEWkIzxzN6eZ6xPKnCRGctia5KBHft159BSCmyKONo=;
        b=JwousZ2yLFbWfR3g1IJR6wZbl7lKbd/jQsaDFlLivWKbbZLizq7IOrRCLpFB2Ka6P0
         78DMWCbw8u4Man4C3yVrW6eHNq178lw2MNHqEQnZtdDrHoPmCJnKsRSKAwX4MqcJowCJ
         dG5dpU71hT+u4IvHLdnzty2ddvr5R7v0jXjA7ZKonb5sH+jSIL1lVY5N2gZfJyZuSqgw
         qX36OFj8SC3fTnk49T/QhXml9c/UiNSxDi2KzFP2a4yV/EHFPUFzFfqclWdeRwgQTWdM
         krJA4jLj5hsTyw5akztpyovZ3RiJwQ/OVZiuo2+3zc+Rl8DuF7/hvfltQG06jOEtuVvP
         jb+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=nbEWkIzxzN6eZ6xPKnCRGctia5KBHft159BSCmyKONo=;
        b=NRKCiwUe2RNqhFBuQmUbbCZ25kBjtL4lbC50F7zafAkQDJrmNT7eHBoZBhfVCVL66e
         l+OOg/koMeWkZpwkKa2w08pToxuVkelZEWFg0m38DmzVSwZGw2UBZwUaOOz4KuPoXdmk
         MJGsfxxSf2hvbhRW1MYglxWuY9XdTSdRS+8RO4gkSOQsbkj3gmfoKO9v8/L5Bm/IQyrM
         8QtbiyVO/6kuuAqJ1Jstdyq5+exeQTnFki7dVfNOigm9NemjTZ665PVBMZztFgeiCRJ0
         JzYrDFF33JotSuIphrb7KLJBCb+1iZ+40qbCSUifXQnrdnGS5Poh7MFMn3PfzeKj6ZUq
         biew==
X-Gm-Message-State: AOAM531+nCsPq6rYhxS81fVXvKVNKBz95f1s7+OiRm0TrQotvmORBeyn
        PYTajHWkqjO9sj8JRU2rSlSSjLUyf3UXrnHxZFw+fkyCo3P3WkYRDddiIVEQogh7h9vWBbQGyzm
        H3OnfDmG7uPihIYat9Jmua6wLJcQg5uwWZLWDjVy2YwPCJ22+Ez/EWs6a9i6xKwH/diBmeSBC
X-Google-Smtp-Source: ABdhPJykuBdgApQm/wDt+i0xZO9/PzLst/7oADnfK8r2MRQoUbYR8AwJTXPhEdIi+X+70PRi9qbSsfvFySDx
X-Received: by 2002:ad4:5668:: with SMTP id bm8mr282519qvb.248.1590619630187;
 Wed, 27 May 2020 15:47:10 -0700 (PDT)
Date:   Wed, 27 May 2020 15:46:55 -0700
In-Reply-To: <20200527224659.206129-1-eranian@google.com>
Message-Id: <20200527224659.206129-2-eranian@google.com>
Mime-Version: 1.0
References: <20200527224659.206129-1-eranian@google.com>
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652-goog
Subject: [PATCH v2 1/5] perf/x86/rapl: move RAPL support to common x86 code
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

Signed-off-by: Stephane Eranian <eranian@google.com>
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
index 6f1d1fde8b2de..12c42eba77ec3 100644
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
2.27.0.rc0.183.gde8f92d652-goog

