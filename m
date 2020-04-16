Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F130C2BB85
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 09:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F232620784
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 09:12:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503253AbgDPJMD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 05:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502362AbgDPIb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 04:31:58 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F9D3C025482;
        Thu, 16 Apr 2020 01:31:38 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jOzvn-0000r7-Ad; Thu, 16 Apr 2020 10:31:31 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id D6F3D1C04D1;
        Thu, 16 Apr 2020 10:31:30 +0200 (CEST)
Date:   Thu, 16 Apr 2020 08:31:30 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] tools arch x86: Sync the msr-index.h copy with the
 kernel sources
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Borislav Petkov <bp@suse.de>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158702589041.28353.9795034299770830446.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     bab1a501e6587590dda4c6cd92250cfedcd1553f
Gitweb:        https://git.kernel.org/tip/bab1a501e6587590dda4c6cd92250cfedcd1553f
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Wed, 01 Apr 2020 12:12:19 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 14 Apr 2020 08:42:56 -03:00

tools arch x86: Sync the msr-index.h copy with the kernel sources

To pick up the changes in:

  6650cdd9a8cc ("x86/split_lock: Enable split lock detection by kernel")

  Warning: Kernel ABI header at 'tools/arch/x86/include/asm/msr-index.h' differs from latest version at 'arch/x86/include/asm/msr-index.h'
  diff -u tools/arch/x86/include/asm/msr-index.h arch/x86/include/asm/msr-index.h

Which causes these changes in tooling:

  $ tools/perf/trace/beauty/tracepoints/x86_msr.sh > before
  $ cp arch/x86/include/asm/msr-index.h tools/arch/x86/include/asm/msr-index.h
  $ tools/perf/trace/beauty/tracepoints/x86_msr.sh > after
  $ diff -u before after
  --- before	2020-04-01 12:11:14.789344795 -0300
  +++ after	2020-04-01 12:11:56.907798879 -0300
  @@ -10,6 +10,7 @@
   	[0x00000029] = "KNC_EVNTSEL1",
   	[0x0000002a] = "IA32_EBL_CR_POWERON",
   	[0x0000002c] = "EBC_FREQUENCY_ID",
  +	[0x00000033] = "TEST_CTRL",
   	[0x00000034] = "SMI_COUNT",
   	[0x0000003a] = "IA32_FEAT_CTL",
   	[0x0000003b] = "IA32_TSC_ADJUST",
  @@ -27,6 +28,7 @@
   	[0x000000c2] = "IA32_PERFCTR1",
   	[0x000000cd] = "FSB_FREQ",
   	[0x000000ce] = "PLATFORM_INFO",
  +	[0x000000cf] = "IA32_CORE_CAPS",
   	[0x000000e2] = "PKG_CST_CONFIG_CONTROL",
   	[0x000000e7] = "IA32_MPERF",
   	[0x000000e8] = "IA32_APERF",
  $

  $ make -C tools/perf O=/tmp/build/perf install-bin
  <SNIP>
    CC       /tmp/build/perf/trace/beauty/tracepoints/x86_msr.o
    LD       /tmp/build/perf/trace/beauty/tracepoints/perf-in.o
    LD       /tmp/build/perf/trace/beauty/perf-in.o
    LD       /tmp/build/perf/perf-in.o
    LINK     /tmp/build/perf/perf
  <SNIP>

Now one can do:

	perf trace -e msr:* --filter=msr==IA32_CORE_CAPS

or:

	perf trace -e msr:* --filter='msr==IA32_CORE_CAPS || msr==TEST_CTRL'

And see only those MSRs being accessed via:

  # perf trace -v -e msr:* --filter='msr==IA32_CORE_CAPS || msr==TEST_CTRL'
  New filter for msr:read_msr: (msr==0xcf || msr==0x33) && (common_pid != 8263 && common_pid != 23250)
  New filter for msr:write_msr: (msr==0xcf || msr==0x33) && (common_pid != 8263 && common_pid != 23250)
  New filter for msr:rdpmc: (msr==0xcf || msr==0x33) && (common_pid != 8263 && common_pid != 23250)

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/lkml/20200401153325.GC12534@kernel.org/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/x86/include/asm/msr-index.h |  9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/arch/x86/include/asm/msr-index.h b/tools/arch/x86/include/asm/msr-index.h
index d5e517d..12c9684 100644
--- a/tools/arch/x86/include/asm/msr-index.h
+++ b/tools/arch/x86/include/asm/msr-index.h
@@ -41,6 +41,10 @@
 
 /* Intel MSRs. Some also available on other CPUs */
 
+#define MSR_TEST_CTRL				0x00000033
+#define MSR_TEST_CTRL_SPLIT_LOCK_DETECT_BIT	29
+#define MSR_TEST_CTRL_SPLIT_LOCK_DETECT		BIT(MSR_TEST_CTRL_SPLIT_LOCK_DETECT_BIT)
+
 #define MSR_IA32_SPEC_CTRL		0x00000048 /* Speculation Control */
 #define SPEC_CTRL_IBRS			BIT(0)	   /* Indirect Branch Restricted Speculation */
 #define SPEC_CTRL_STIBP_SHIFT		1	   /* Single Thread Indirect Branch Predictor (STIBP) bit */
@@ -70,6 +74,11 @@
  */
 #define MSR_IA32_UMWAIT_CONTROL_TIME_MASK	(~0x03U)
 
+/* Abbreviated from Intel SDM name IA32_CORE_CAPABILITIES */
+#define MSR_IA32_CORE_CAPS			  0x000000cf
+#define MSR_IA32_CORE_CAPS_SPLIT_LOCK_DETECT_BIT  5
+#define MSR_IA32_CORE_CAPS_SPLIT_LOCK_DETECT	  BIT(MSR_IA32_CORE_CAPS_SPLIT_LOCK_DETECT_BIT)
+
 #define MSR_PKG_CST_CONFIG_CONTROL	0x000000e2
 #define NHM_C3_AUTO_DEMOTE		(1UL << 25)
 #define NHM_C1_AUTO_DEMOTE		(1UL << 26)
