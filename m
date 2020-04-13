Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A7EFC352B6
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 16:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D0B720739
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 16:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586796761;
	bh=41LZqW8d5XmQTbyN0N2s8HTXUkkGdeEX8LK2FJmvOYA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Llf64S/thoyG+M+sCiJ3JuLUvdOzx75Ii45hno0NUX5gWH5BYQDR4xr6KRBGai4/2
	 bfKb4snuKcfbxoqAVavcX5W0JoFxWRU5/WX6FA5008Gsll6JAByVUrdlT5c0Mx8VE0
	 NQThS6/z+1jbh8dYeeqlTbSpm+CG3uc9Un0yD+LI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731882AbgDMQwk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 12:52:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:43984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731861AbgDMQwb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 12:52:31 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F40820936;
        Mon, 13 Apr 2020 16:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586796750;
        bh=41LZqW8d5XmQTbyN0N2s8HTXUkkGdeEX8LK2FJmvOYA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aqDhael/cpL2+Li0ojNOUt6KrXK+PzepxDPKHGqHdTvqg+KL6AXbgdK8kghhOoihL
         OU4y5tzttQt9Mz5qzpY/uZLISWh/pCRPaA0ElhXv9i9mej37hwQIALn9iX7SmfVbXO
         IFm5ThRxXoHCU3a7IGY3dzmkF4k39WBcy7HdzM50=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 04/26] tools arch x86: Sync the msr-index.h copy with the kernel sources
Date:   Mon, 13 Apr 2020 13:51:41 -0300
Message-Id: <20200413165203.1816-5-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200413165203.1816-1-acme@kernel.org>
References: <20200413165203.1816-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
 tools/arch/x86/include/asm/msr-index.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/arch/x86/include/asm/msr-index.h b/tools/arch/x86/include/asm/msr-index.h
index d5e517d1c3dd..12c9684d59ba 100644
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
-- 
2.21.1

