Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF519C2BA16
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 08:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FF4820752
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 08:42:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgDDImi convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 04:42:38 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41771 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbgDDIm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 04:42:27 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jKeNR-0001Gq-WD; Sat, 04 Apr 2020 10:42:06 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 38C561C047B;
        Sat,  4 Apr 2020 10:42:00 +0200 (CEST)
Date:   Sat, 04 Apr 2020 08:41:59 -0000
From:   "tip-bot2 for Vijay Thakkar" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf vendor events amd: Restrict model detection
 for zen1 based processors
Cc:     Vijay Thakkar <vijaythakkar@me.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Jon Grimm <jon.grimm@amd.com>,
        mliska@suse.cz, Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200318190002.307290-2-vijaythakkar@me.com>
References: <20200318190002.307290-2-vijaythakkar@me.com>
MIME-Version: 1.0
Message-ID: <158598971978.28353.11358389773881558584.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     c5f18e9e94bad244115dc5e47f27bd061ecc5552
Gitweb:        https://git.kernel.org/tip/c5f18e9e94bad244115dc5e47f27bd061ecc5552
Author:        Vijay Thakkar <vijaythakkar@me.com>
AuthorDate:    Wed, 18 Mar 2020 15:00:00 -04:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 24 Mar 2020 10:35:53 -03:00

perf vendor events amd: Restrict model detection for zen1 based processors

This patch changes the previous blanket detection of AMD Family 17h
processors to be more specific to Zen1 core based products only by
replacing model detection regex pattern [[:xdigit:]]+ with
([12][0-9A-F]|[0-9A-F]), restricting to models 0 though 2f only.

This change is required to allow for the addition of separate PMU events
for Zen2 core based models in the following patches as those belong to
family 17h but have different PMCs. Current PMU events directory has
also been renamed to "amdzen1" from "amdfam17h" to reflect this
specificity.

Note that although this change does not break PMU counters for existing
zen1 based systems, it does disable the current set of counters for zen2
based systems. Counters for zen2 have been added in the following
patches in this patchset.

Signed-off-by: Vijay Thakkar <vijaythakkar@me.com>
Acked-by: Kim Phillips <kim.phillips@amd.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Jon Grimm <jon.grimm@amd.com>
Cc: Martin Liška <mliska@suse.cz>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20200318190002.307290-2-vijaythakkar@me.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/pmu-events/arch/x86/amdfam17h/branch.json         |  12 +-
 tools/perf/pmu-events/arch/x86/amdfam17h/cache.json          | 329 +-------
 tools/perf/pmu-events/arch/x86/amdfam17h/core.json           | 134 +---
 tools/perf/pmu-events/arch/x86/amdfam17h/floating-point.json | 168 +----
 tools/perf/pmu-events/arch/x86/amdfam17h/memory.json         | 162 +---
 tools/perf/pmu-events/arch/x86/amdfam17h/other.json          |  65 +-
 tools/perf/pmu-events/arch/x86/amdzen1/branch.json           |  12 +-
 tools/perf/pmu-events/arch/x86/amdzen1/cache.json            | 329 +++++++-
 tools/perf/pmu-events/arch/x86/amdzen1/core.json             | 134 +++-
 tools/perf/pmu-events/arch/x86/amdzen1/floating-point.json   | 168 ++++-
 tools/perf/pmu-events/arch/x86/amdzen1/memory.json           | 162 +++-
 tools/perf/pmu-events/arch/x86/amdzen1/other.json            |  65 +-
 tools/perf/pmu-events/arch/x86/mapfile.csv                   |   2 +-
 13 files changed, 871 insertions(+), 871 deletions(-)
 delete mode 100644 tools/perf/pmu-events/arch/x86/amdfam17h/branch.json
 delete mode 100644 tools/perf/pmu-events/arch/x86/amdfam17h/cache.json
 delete mode 100644 tools/perf/pmu-events/arch/x86/amdfam17h/core.json
 delete mode 100644 tools/perf/pmu-events/arch/x86/amdfam17h/floating-point.json
 delete mode 100644 tools/perf/pmu-events/arch/x86/amdfam17h/memory.json
 delete mode 100644 tools/perf/pmu-events/arch/x86/amdfam17h/other.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen1/branch.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen1/cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen1/core.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen1/floating-point.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen1/memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen1/other.json

diff --git a/tools/perf/pmu-events/arch/x86/amdfam17h/branch.json b/tools/perf/pmu-events/arch/x86/amdfam17h/branch.json
deleted file mode 100644
index 93ddfd8..0000000
--- a/tools/perf/pmu-events/arch/x86/amdfam17h/branch.json
+++ /dev/null
@@ -1,12 +0,0 @@
-[
-  {
-    "EventName": "bp_l1_btb_correct",
-    "EventCode": "0x8a",
-    "BriefDescription": "L1 BTB Correction."
-  },
-  {
-    "EventName": "bp_l2_btb_correct",
-    "EventCode": "0x8b",
-    "BriefDescription": "L2 BTB Correction."
-  }
-]
diff --git a/tools/perf/pmu-events/arch/x86/amdfam17h/cache.json b/tools/perf/pmu-events/arch/x86/amdfam17h/cache.json
deleted file mode 100644
index 6221a84..0000000
--- a/tools/perf/pmu-events/arch/x86/amdfam17h/cache.json
+++ /dev/null
@@ -1,329 +0,0 @@
-[
-  {
-    "EventName": "ic_fw32",
-    "EventCode": "0x80",
-    "BriefDescription": "The number of 32B fetch windows transferred from IC pipe to DE instruction decoder (includes non-cacheable and cacheable fill responses)."
-  },
-  {
-    "EventName": "ic_fw32_miss",
-    "EventCode": "0x81",
-    "BriefDescription": "The number of 32B fetch windows tried to read the L1 IC and missed in the full tag."
-  },
-  {
-    "EventName": "ic_cache_fill_l2",
-    "EventCode": "0x82",
-    "BriefDescription": "The number of 64 byte instruction cache line was fulfilled from the L2 cache."
-  },
-  {
-    "EventName": "ic_cache_fill_sys",
-    "EventCode": "0x83",
-    "BriefDescription": "The number of 64 byte instruction cache line fulfilled from system memory or another cache."
-  },
-  {
-    "EventName": "bp_l1_tlb_miss_l2_hit",
-    "EventCode": "0x84",
-    "BriefDescription": "The number of instruction fetches that miss in the L1 ITLB but hit in the L2 ITLB."
-  },
-  {
-    "EventName": "bp_l1_tlb_miss_l2_miss",
-    "EventCode": "0x85",
-    "BriefDescription": "The number of instruction fetches that miss in both the L1 and L2 TLBs."
-  },
-  {
-    "EventName": "bp_snp_re_sync",
-    "EventCode": "0x86",
-    "BriefDescription": "The number of pipeline restarts caused by invalidating probes that hit on the instruction stream currently being executed. This would happen if the active instruction stream was being modified by another processor in an MP system - typically a highly unlikely event."
-  },
-  {
-    "EventName": "ic_fetch_stall.ic_stall_any",
-    "EventCode": "0x87",
-    "BriefDescription": "IC pipe was stalled during this clock cycle for any reason (nothing valid in pipe ICM1).",
-    "PublicDescription": "Instruction Pipe Stall. IC pipe was stalled during this clock cycle for any reason (nothing valid in pipe ICM1).",
-    "UMask": "0x4"
-  },
-  {
-    "EventName": "ic_fetch_stall.ic_stall_dq_empty",
-    "EventCode": "0x87",
-    "BriefDescription": "IC pipe was stalled during this clock cycle (including IC to OC fetches) due to DQ empty.",
-    "PublicDescription": "Instruction Pipe Stall. IC pipe was stalled during this clock cycle (including IC to OC fetches) due to DQ empty.",
-    "UMask": "0x2"
-  },
-  {
-    "EventName": "ic_fetch_stall.ic_stall_back_pressure",
-    "EventCode": "0x87",
-    "BriefDescription": "IC pipe was stalled during this clock cycle (including IC to OC fetches) due to back-pressure.",
-    "PublicDescription": "Instruction Pipe Stall. IC pipe was stalled during this clock cycle (including IC to OC fetches) due to back-pressure.",
-    "UMask": "0x1"
-  },
-  {
-    "EventName": "ic_cache_inval.l2_invalidating_probe",
-    "EventCode": "0x8c",
-    "BriefDescription": "IC line invalidated due to L2 invalidating probe (external or LS).",
-    "PublicDescription": "The number of instruction cache lines invalidated. A non-SMC event is CMC (cross modifying code), either from the other thread of the core or another core. IC line invalidated due to L2 invalidating probe (external or LS).",
-    "UMask": "0x2"
-  },
-  {
-    "EventName": "ic_cache_inval.fill_invalidated",
-    "EventCode": "0x8c",
-    "BriefDescription": "IC line invalidated due to overwriting fill response.",
-    "PublicDescription": "The number of instruction cache lines invalidated. A non-SMC event is CMC (cross modifying code), either from the other thread of the core or another core. IC line invalidated due to overwriting fill response.",
-    "UMask": "0x1"
-  },
-  {
-    "EventName": "bp_tlb_rel",
-    "EventCode": "0x99",
-    "BriefDescription": "The number of ITLB reload requests."
-  },
-  {
-    "EventName": "l2_request_g1.rd_blk_l",
-    "EventCode": "0x60",
-    "BriefDescription": "Requests to L2 Group1.",
-    "PublicDescription": "Requests to L2 Group1.",
-    "UMask": "0x80"
-  },
-  {
-    "EventName": "l2_request_g1.rd_blk_x",
-    "EventCode": "0x60",
-    "BriefDescription": "Requests to L2 Group1.",
-    "PublicDescription": "Requests to L2 Group1.",
-    "UMask": "0x40"
-  },
-  {
-    "EventName": "l2_request_g1.ls_rd_blk_c_s",
-    "EventCode": "0x60",
-    "BriefDescription": "Requests to L2 Group1.",
-    "PublicDescription": "Requests to L2 Group1.",
-    "UMask": "0x20"
-  },
-  {
-    "EventName": "l2_request_g1.cacheable_ic_read",
-    "EventCode": "0x60",
-    "BriefDescription": "Requests to L2 Group1.",
-    "PublicDescription": "Requests to L2 Group1.",
-    "UMask": "0x10"
-  },
-  {
-    "EventName": "l2_request_g1.change_to_x",
-    "EventCode": "0x60",
-    "BriefDescription": "Requests to L2 Group1.",
-    "PublicDescription": "Requests to L2 Group1.",
-    "UMask": "0x8"
-  },
-  {
-    "EventName": "l2_request_g1.prefetch_l2",
-    "EventCode": "0x60",
-    "BriefDescription": "Requests to L2 Group1.",
-    "PublicDescription": "Requests to L2 Group1.",
-    "UMask": "0x4"
-  },
-  {
-    "EventName": "l2_request_g1.l2_hw_pf",
-    "EventCode": "0x60",
-    "BriefDescription": "Requests to L2 Group1.",
-    "PublicDescription": "Requests to L2 Group1.",
-    "UMask": "0x2"
-  },
-  {
-    "EventName": "l2_request_g1.other_requests",
-    "EventCode": "0x60",
-    "BriefDescription": "Events covered by l2_request_g2.",
-    "PublicDescription": "Requests to L2 Group1. Events covered by l2_request_g2.",
-    "UMask": "0x1"
-  },
-  {
-    "EventName": "l2_request_g2.group1",
-    "EventCode": "0x61",
-    "BriefDescription": "All Group 1 commands not in unit0.",
-    "PublicDescription": "Multi-events in that LS and IF requests can be received simultaneous. All Group 1 commands not in unit0.",
-    "UMask": "0x80"
-  },
-  {
-    "EventName": "l2_request_g2.ls_rd_sized",
-    "EventCode": "0x61",
-    "BriefDescription": "RdSized, RdSized32, RdSized64.",
-    "PublicDescription": "Multi-events in that LS and IF requests can be received simultaneous. RdSized, RdSized32, RdSized64.",
-    "UMask": "0x40"
-  },
-  {
-    "EventName": "l2_request_g2.ls_rd_sized_nc",
-    "EventCode": "0x61",
-    "BriefDescription": "RdSizedNC, RdSized32NC, RdSized64NC.",
-    "PublicDescription": "Multi-events in that LS and IF requests can be received simultaneous. RdSizedNC, RdSized32NC, RdSized64NC.",
-    "UMask": "0x20"
-  },
-  {
-    "EventName": "l2_request_g2.ic_rd_sized",
-    "EventCode": "0x61",
-    "BriefDescription": "Multi-events in that LS and IF requests can be received simultaneous.",
-    "PublicDescription": "Multi-events in that LS and IF requests can be received simultaneous.",
-    "UMask": "0x10"
-  },
-  {
-    "EventName": "l2_request_g2.ic_rd_sized_nc",
-    "EventCode": "0x61",
-    "BriefDescription": "Multi-events in that LS and IF requests can be received simultaneous.",
-    "PublicDescription": "Multi-events in that LS and IF requests can be received simultaneous.",
-    "UMask": "0x8"
-  },
-  {
-    "EventName": "l2_request_g2.smc_inval",
-    "EventCode": "0x61",
-    "BriefDescription": "Multi-events in that LS and IF requests can be received simultaneous.",
-    "PublicDescription": "Multi-events in that LS and IF requests can be received simultaneous.",
-    "UMask": "0x4"
-  },
-  {
-    "EventName": "l2_request_g2.bus_locks_originator",
-    "EventCode": "0x61",
-    "BriefDescription": "Multi-events in that LS and IF requests can be received simultaneous.",
-    "PublicDescription": "Multi-events in that LS and IF requests can be received simultaneous.",
-    "UMask": "0x2"
-  },
-  {
-    "EventName": "l2_request_g2.bus_locks_responses",
-    "EventCode": "0x61",
-    "BriefDescription": "Multi-events in that LS and IF requests can be received simultaneous.",
-    "PublicDescription": "Multi-events in that LS and IF requests can be received simultaneous.",
-    "UMask": "0x1"
-  },
-  {
-    "EventName": "l2_latency.l2_cycles_waiting_on_fills",
-    "EventCode": "0x62",
-    "BriefDescription": "Total cycles spent waiting for L2 fills to complete from L3 or memory, divided by four. Event counts are for both threads. To calculate average latency, the number of fills from both threads must be used.",
-    "PublicDescription": "Total cycles spent waiting for L2 fills to complete from L3 or memory, divided by four. Event counts are for both threads. To calculate average latency, the number of fills from both threads must be used.",
-    "UMask": "0x1"
-  },
-  {
-    "EventName": "l2_wcb_req.wcb_write",
-    "EventCode": "0x63",
-    "PublicDescription": "LS (Load/Store unit) to L2 WCB (Write Combining Buffer) write requests.",
-    "BriefDescription": "LS to L2 WCB write requests.",
-    "UMask": "0x40"
-  },
-  {
-    "EventName": "l2_wcb_req.wcb_close",
-    "EventCode": "0x63",
-    "BriefDescription": "LS to L2 WCB close requests.",
-    "PublicDescription": "LS (Load/Store unit) to L2 WCB (Write Combining Buffer) close requests.",
-    "UMask": "0x20"
-  },
-  {
-    "EventName": "l2_wcb_req.zero_byte_store",
-    "EventCode": "0x63",
-    "BriefDescription": "LS to L2 WCB zero byte store requests.",
-    "PublicDescription": "LS (Load/Store unit) to L2 WCB (Write Combining Buffer) zero byte store requests.",
-    "UMask": "0x4"
-  },
-  {
-    "EventName": "l2_wcb_req.cl_zero",
-    "EventCode": "0x63",
-    "PublicDescription": "LS to L2 WCB cache line zeroing requests.",
-    "BriefDescription": "LS (Load/Store unit) to L2 WCB (Write Combining Buffer) cache line zeroing requests.",
-    "UMask": "0x1"
-  },
-  {
-    "EventName": "l2_cache_req_stat.ls_rd_blk_cs",
-    "EventCode": "0x64",
-    "BriefDescription": "LS ReadBlock C/S Hit.",
-    "PublicDescription": "This event does not count accesses to the L2 cache by the L2 prefetcher, but it does count accesses by the L1 prefetcher. LS ReadBlock C/S Hit.",
-    "UMask": "0x80"
-  },
-  {
-    "EventName": "l2_cache_req_stat.ls_rd_blk_l_hit_x",
-    "EventCode": "0x64",
-    "BriefDescription": "LS Read Block L Hit X.",
-    "PublicDescription": "This event does not count accesses to the L2 cache by the L2 prefetcher, but it does count accesses by the L1 prefetcher. LS Read Block L Hit X.",
-    "UMask": "0x40"
-  },
-  {
-    "EventName": "l2_cache_req_stat.ls_rd_blk_l_hit_s",
-    "EventCode": "0x64",
-    "BriefDescription": "LsRdBlkL Hit Shared.",
-    "PublicDescription": "This event does not count accesses to the L2 cache by the L2 prefetcher, but it does count accesses by the L1 prefetcher. LsRdBlkL Hit Shared.",
-    "UMask": "0x20"
-  },
-  {
-    "EventName": "l2_cache_req_stat.ls_rd_blk_x",
-    "EventCode": "0x64",
-    "BriefDescription": "LsRdBlkX/ChgToX Hit X.  Count RdBlkX finding Shared as a Miss.",
-    "PublicDescription": "This event does not count accesses to the L2 cache by the L2 prefetcher, but it does count accesses by the L1 prefetcher. LsRdBlkX/ChgToX Hit X.  Count RdBlkX finding Shared as a Miss.",
-    "UMask": "0x10"
-  },
-  {
-    "EventName": "l2_cache_req_stat.ls_rd_blk_c",
-    "EventCode": "0x64",
-    "BriefDescription": "LS Read Block C S L X Change to X Miss.",
-    "PublicDescription": "This event does not count accesses to the L2 cache by the L2 prefetcher, but it does count accesses by the L1 prefetcher. LS Read Block C S L X Change to X Miss.",
-    "UMask": "0x8"
-  },
-  {
-    "EventName": "l2_cache_req_stat.ic_fill_hit_x",
-    "EventCode": "0x64",
-    "BriefDescription": "IC Fill Hit Exclusive Stale.",
-    "PublicDescription": "This event does not count accesses to the L2 cache by the L2 prefetcher, but it does count accesses by the L1 prefetcher. IC Fill Hit Exclusive Stale.",
-    "UMask": "0x4"
-  },
-  {
-    "EventName": "l2_cache_req_stat.ic_fill_hit_s",
-    "EventCode": "0x64",
-    "BriefDescription": "IC Fill Hit Shared.",
-    "PublicDescription": "This event does not count accesses to the L2 cache by the L2 prefetcher, but it does count accesses by the L1 prefetcher. IC Fill Hit Shared.",
-    "UMask": "0x2"
-  },
-  {
-    "EventName": "l2_cache_req_stat.ic_fill_miss",
-    "EventCode": "0x64",
-    "BriefDescription": "IC Fill Miss.",
-    "PublicDescription": "This event does not count accesses to the L2 cache by the L2 prefetcher, but it does count accesses by the L1 prefetcher. IC Fill Miss.",
-    "UMask": "0x1"
-  },
-  {
-    "EventName": "l2_fill_pending.l2_fill_busy",
-    "EventCode": "0x6d",
-    "BriefDescription": "Total cycles spent with one or more fill requests in flight from L2.",
-    "PublicDescription": "Total cycles spent with one or more fill requests in flight from L2.",
-    "UMask": "0x1"
-  },
-  {
-    "EventName": "l3_request_g1.caching_l3_cache_accesses",
-    "EventCode": "0x01",
-    "BriefDescription": "Caching: L3 cache accesses",
-    "UMask": "0x80",
-    "Unit": "L3PMC"
-  },
-  {
-    "EventName": "l3_lookup_state.all_l3_req_typs",
-    "EventCode": "0x04",
-    "BriefDescription": "All L3 Request Types",
-    "UMask": "0xff",
-    "Unit": "L3PMC"
-  },
-  {
-    "EventName": "l3_comb_clstr_state.other_l3_miss_typs",
-    "EventCode": "0x06",
-    "BriefDescription": "Other L3 Miss Request Types",
-    "UMask": "0xfe",
-    "Unit": "L3PMC"
-  },
-  {
-    "EventName": "l3_comb_clstr_state.request_miss",
-    "EventCode": "0x06",
-    "BriefDescription": "L3 cache misses",
-    "UMask": "0x01",
-    "Unit": "L3PMC"
-  },
-  {
-    "EventName": "xi_sys_fill_latency",
-    "EventCode": "0x90",
-    "BriefDescription": "L3 Cache Miss Latency. Total cycles for all transactions divided by 16. Ignores SliceMask and ThreadMask.",
-    "UMask": "0x00",
-    "Unit": "L3PMC"
-  },
-  {
-    "EventName": "xi_ccx_sdp_req1.all_l3_miss_req_typs",
-    "EventCode": "0x9a",
-    "BriefDescription": "All L3 Miss Request Types. Ignores SliceMask and ThreadMask.",
-    "UMask": "0x3f",
-    "Unit": "L3PMC"
-  }
-]
diff --git a/tools/perf/pmu-events/arch/x86/amdfam17h/core.json b/tools/perf/pmu-events/arch/x86/amdfam17h/core.json
deleted file mode 100644
index 1079544..0000000
--- a/tools/perf/pmu-events/arch/x86/amdfam17h/core.json
+++ /dev/null
@@ -1,134 +0,0 @@
-[
-  {
-    "EventName": "ex_ret_instr",
-    "EventCode": "0xc0",
-    "BriefDescription": "Retired Instructions."
-  },
-  {
-    "EventName": "ex_ret_cops",
-    "EventCode": "0xc1",
-    "BriefDescription": "Retired Uops.",
-    "PublicDescription": "The number of uOps retired. This includes all processor activity (instructions, exceptions, interrupts, microcode assists, etc.). The number of events logged per cycle can vary from 0 to 4."
-  },
-  {
-    "EventName": "ex_ret_brn",
-    "EventCode": "0xc2",
-    "BriefDescription": "Retired Branch Instructions.",
-    "PublicDescription": "The number of branch instructions retired. This includes all types of architectural control flow changes, including exceptions and interrupts."
-  },
-  {
-    "EventName": "ex_ret_brn_misp",
-    "EventCode": "0xc3",
-    "BriefDescription": "Retired Branch Instructions Mispredicted.",
-    "PublicDescription": "The number of branch instructions retired, of any type, that were not correctly predicted. This includes those for which prediction is not attempted (far control transfers, exceptions and interrupts)."
-  },
-  {
-    "EventName": "ex_ret_brn_tkn",
-    "EventCode": "0xc4",
-    "BriefDescription": "Retired Taken Branch Instructions.",
-    "PublicDescription": "The number of taken branches that were retired. This includes all types of architectural control flow changes, including exceptions and interrupts."
-  },
-  {
-    "EventName": "ex_ret_brn_tkn_misp",
-    "EventCode": "0xc5",
-    "BriefDescription": "Retired Taken Branch Instructions Mispredicted.",
-    "PublicDescription": "The number of retired taken branch instructions that were mispredicted."
-  },
-  {
-    "EventName": "ex_ret_brn_far",
-    "EventCode": "0xc6",
-    "BriefDescription": "Retired Far Control Transfers.",
-    "PublicDescription": "The number of far control transfers retired including far call/jump/return, IRET, SYSCALL and SYSRET, plus exceptions and interrupts. Far control transfers are not subject to branch prediction."
-  },
-  {
-    "EventName": "ex_ret_brn_resync",
-    "EventCode": "0xc7",
-    "BriefDescription": "Retired Branch Resyncs.",
-    "PublicDescription": "The number of resync branches. These reflect pipeline restarts due to certain microcode assists and events such as writes to the active instruction stream, among other things. Each occurrence reflects a restart penalty similar to a branch mispredict. This is relatively rare."
-  },
-  {
-    "EventName": "ex_ret_near_ret",
-    "EventCode": "0xc8",
-    "BriefDescription": "Retired Near Returns.",
-    "PublicDescription": "The number of near return instructions (RET or RET Iw) retired."
-  },
-  {
-    "EventName": "ex_ret_near_ret_mispred",
-    "EventCode": "0xc9",
-    "BriefDescription": "Retired Near Returns Mispredicted.",
-    "PublicDescription": "The number of near returns retired that were not correctly predicted by the return address predictor. Each such mispredict incurs the same penalty as a mispredicted conditional branch instruction."
-  },
-  {
-    "EventName": "ex_ret_brn_ind_misp",
-    "EventCode": "0xca",
-    "BriefDescription": "Retired Indirect Branch Instructions Mispredicted.",
-    "PublicDescription": "Retired Indirect Branch Instructions Mispredicted."
-  },
-  {
-    "EventName": "ex_ret_mmx_fp_instr.sse_instr",
-    "EventCode": "0xcb",
-    "BriefDescription": "SSE instructions (SSE, SSE2, SSE3, SSSE3, SSE4A, SSE41, SSE42, AVX).",
-    "PublicDescription": "The number of MMX, SSE or x87 instructions retired. The UnitMask allows the selection of the individual classes of instructions as given in the table. Each increment represents one complete instruction. Since this event includes non-numeric instructions it is not suitable for measuring MFLOPS. SSE instructions (SSE, SSE2, SSE3, SSSE3, SSE4A, SSE41, SSE42, AVX).",
-    "UMask": "0x4"
-  },
-  {
-    "EventName": "ex_ret_mmx_fp_instr.mmx_instr",
-    "EventCode": "0xcb",
-    "BriefDescription": "MMX instructions.",
-    "PublicDescription": "The number of MMX, SSE or x87 instructions retired. The UnitMask allows the selection of the individual classes of instructions as given in the table. Each increment represents one complete instruction. Since this event includes non-numeric instructions it is not suitable for measuring MFLOPS. MMX instructions.",
-    "UMask": "0x2"
-  },
-  {
-    "EventName": "ex_ret_mmx_fp_instr.x87_instr",
-    "EventCode": "0xcb",
-    "BriefDescription": "x87 instructions.",
-    "PublicDescription": "The number of MMX, SSE or x87 instructions retired. The UnitMask allows the selection of the individual classes of instructions as given in the table. Each increment represents one complete instruction. Since this event includes non-numeric instructions it is not suitable for measuring MFLOPS. x87 instructions.",
-    "UMask": "0x1"
-  },
-  {
-    "EventName": "ex_ret_cond",
-    "EventCode": "0xd1",
-    "BriefDescription": "Retired Conditional Branch Instructions."
-  },
-  {
-    "EventName": "ex_ret_cond_misp",
-    "EventCode": "0xd2",
-    "BriefDescription": "Retired Conditional Branch Instructions Mispredicted."
-  },
-  {
-    "EventName": "ex_div_busy",
-    "EventCode": "0xd3",
-    "BriefDescription": "Div Cycles Busy count."
-  },
-  {
-    "EventName": "ex_div_count",
-    "EventCode": "0xd4",
-    "BriefDescription": "Div Op Count."
-  },
-  {
-    "EventName": "ex_tagged_ibs_ops.ibs_count_rollover",
-    "EventCode": "0x1cf",
-    "BriefDescription": "Number of times an op could not be tagged by IBS because of a previous tagged op that has not retired.",
-    "PublicDescription": "Tagged IBS Ops. Number of times an op could not be tagged by IBS because of a previous tagged op that has not retired.",
-    "UMask": "0x4"
-  },
-  {
-    "EventName": "ex_tagged_ibs_ops.ibs_tagged_ops_ret",
-    "EventCode": "0x1cf",
-    "BriefDescription": "Number of Ops tagged by IBS that retired.",
-    "PublicDescription": "Tagged IBS Ops. Number of Ops tagged by IBS that retired.",
-    "UMask": "0x2"
-  },
-  {
-    "EventName": "ex_tagged_ibs_ops.ibs_tagged_ops",
-    "EventCode": "0x1cf",
-    "BriefDescription": "Number of Ops tagged by IBS.",
-    "PublicDescription": "Tagged IBS Ops. Number of Ops tagged by IBS.",
-    "UMask": "0x1"
-  },
-  {
-    "EventName": "ex_ret_fus_brnch_inst",
-    "EventCode": "0x1d0",
-    "BriefDescription": "The number of fused retired branch instructions retired per cycle. The number of events logged per cycle can vary from 0 to 3."
-  }
-]
diff --git a/tools/perf/pmu-events/arch/x86/amdfam17h/floating-point.json b/tools/perf/pmu-events/arch/x86/amdfam17h/floating-point.json
deleted file mode 100644
index ea47119..0000000
--- a/tools/perf/pmu-events/arch/x86/amdfam17h/floating-point.json
+++ /dev/null
@@ -1,168 +0,0 @@
-[
-  {
-    "EventName": "fpu_pipe_assignment.dual",
-    "EventCode": "0x00",
-    "BriefDescription": "Total number multi-pipe uOps.",
-    "PublicDescription": "The number of operations (uOps) and dual-pipe uOps dispatched to each of the 4 FPU execution pipelines. This event reflects how busy the FPU pipelines are and may be used for workload characterization. This includes all operations performed by x87, MMX, and SSE instructions, including moves. Each increment represents a one- cycle dispatch event. This event is a speculative event. Since this event includes non-numeric operations it is not suitable for measuring MFLOPS. Total number multi-pipe uOps assigned to Pipe 3.",
-    "UMask": "0xf0"
-  },
-  {
-    "EventName": "fpu_pipe_assignment.total",
-    "EventCode": "0x00",
-    "BriefDescription": "Total number uOps.",
-    "PublicDescription": "The number of operations (uOps) and dual-pipe uOps dispatched to each of the 4 FPU execution pipelines. This event reflects how busy the FPU pipelines are and may be used for workload characterization. This includes all operations performed by x87, MMX, and SSE instructions, including moves. Each increment represents a one- cycle dispatch event. This event is a speculative event. Since this event includes non-numeric operations it is not suitable for measuring MFLOPS. Total number uOps assigned to Pipe 3.",
-    "UMask": "0xf"
-  },
-  {
-    "EventName": "fp_sched_empty",
-    "EventCode": "0x01",
-    "BriefDescription": "This is a speculative event. The number of cycles in which the FPU scheduler is empty. Note that some Ops like FP loads bypass the scheduler."
-  },
-  {
-    "EventName": "fp_retx87_fp_ops.all",
-    "EventCode": "0x02",
-    "BriefDescription": "All Ops.",
-    "PublicDescription": "The number of x87 floating-point Ops that have retired. The number of events logged per cycle can vary from 0 to 8.",
-    "UMask": "0x7"
-  },
-  {
-    "EventName": "fp_retx87_fp_ops.div_sqr_r_ops",
-    "EventCode": "0x02",
-    "BriefDescription": "Divide and square root Ops.",
-    "PublicDescription": "The number of x87 floating-point Ops that have retired. The number of events logged per cycle can vary from 0 to 8. Divide and square root Ops.",
-    "UMask": "0x4"
-  },
-  {
-    "EventName": "fp_retx87_fp_ops.mul_ops",
-    "EventCode": "0x02",
-    "BriefDescription": "Multiply Ops.",
-    "PublicDescription": "The number of x87 floating-point Ops that have retired. The number of events logged per cycle can vary from 0 to 8. Multiply Ops.",
-    "UMask": "0x2"
-  },
-  {
-    "EventName": "fp_retx87_fp_ops.add_sub_ops",
-    "EventCode": "0x02",
-    "BriefDescription": "Add/subtract Ops.",
-    "PublicDescription": "The number of x87 floating-point Ops that have retired. The number of events logged per cycle can vary from 0 to 8. Add/subtract Ops.",
-    "UMask": "0x1"
-  },
-  {
-    "EventName": "fp_ret_sse_avx_ops.all",
-    "EventCode": "0x03",
-    "BriefDescription": "All FLOPS.",
-    "PublicDescription": "This is a retire-based event. The number of retired SSE/AVX FLOPS. The number of events logged per cycle can vary from 0 to 64. This event can count above 15.",
-    "UMask": "0xff"
-  },
-  {
-    "EventName": "fp_ret_sse_avx_ops.dp_mult_add_flops",
-    "EventCode": "0x03",
-    "BriefDescription": "Double precision multiply-add FLOPS. Multiply-add counts as 2 FLOPS.",
-    "PublicDescription": "This is a retire-based event. The number of retired SSE/AVX FLOPS. The number of events logged per cycle can vary from 0 to 64. This event can count above 15. Double precision multiply-add FLOPS. Multiply-add counts as 2 FLOPS.",
-    "UMask": "0x80"
-  },
-  {
-    "EventName": "fp_ret_sse_avx_ops.dp_div_flops",
-    "EventCode": "0x03",
-    "BriefDescription": "Double precision divide/square root FLOPS.",
-    "PublicDescription": "This is a retire-based event. The number of retired SSE/AVX FLOPS. The number of events logged per cycle can vary from 0 to 64. This event can count above 15. Double precision divide/square root FLOPS.",
-    "UMask": "0x40"
-  },
-  {
-    "EventName": "fp_ret_sse_avx_ops.dp_mult_flops",
-    "EventCode": "0x03",
-    "BriefDescription": "Double precision multiply FLOPS.",
-    "PublicDescription": "This is a retire-based event. The number of retired SSE/AVX FLOPS. The number of events logged per cycle can vary from 0 to 64. This event can count above 15. Double precision multiply FLOPS.",
-    "UMask": "0x20"
-  },
-  {
-    "EventName": "fp_ret_sse_avx_ops.dp_add_sub_flops",
-    "EventCode": "0x03",
-    "BriefDescription": "Double precision add/subtract FLOPS.",
-    "PublicDescription": "This is a retire-based event. The number of retired SSE/AVX FLOPS. The number of events logged per cycle can vary from 0 to 64. This event can count above 15. Double precision add/subtract FLOPS.",
-    "UMask": "0x10"
-  },
-  {
-    "EventName": "fp_ret_sse_avx_ops.sp_mult_add_flops",
-    "EventCode": "0x03",
-    "BriefDescription": "Single precision multiply-add FLOPS. Multiply-add counts as 2 FLOPS.",
-    "PublicDescription": "This is a retire-based event. The number of retired SSE/AVX FLOPS. The number of events logged per cycle can vary from 0 to 64. This event can count above 15. Single precision multiply-add FLOPS. Multiply-add counts as 2 FLOPS.",
-    "UMask": "0x8"
-  },
-  {
-    "EventName": "fp_ret_sse_avx_ops.sp_div_flops",
-    "EventCode": "0x03",
-    "BriefDescription": "Single-precision divide/square root FLOPS.",
-    "PublicDescription": "This is a retire-based event. The number of retired SSE/AVX FLOPS. The number of events logged per cycle can vary from 0 to 64. This event can count above 15. Single-precision divide/square root FLOPS.",
-    "UMask": "0x4"
-  },
-  {
-    "EventName": "fp_ret_sse_avx_ops.sp_mult_flops",
-    "EventCode": "0x03",
-    "BriefDescription": "Single-precision multiply FLOPS.",
-    "PublicDescription": "This is a retire-based event. The number of retired SSE/AVX FLOPS. The number of events logged per cycle can vary from 0 to 64. This event can count above 15. Single-precision multiply FLOPS.",
-    "UMask": "0x2"
-  },
-  {
-    "EventName": "fp_ret_sse_avx_ops.sp_add_sub_flops",
-    "EventCode": "0x03",
-    "BriefDescription": "Single-precision add/subtract FLOPS.",
-    "PublicDescription": "This is a retire-based event. The number of retired SSE/AVX FLOPS. The number of events logged per cycle can vary from 0 to 64. This event can count above 15. Single-precision add/subtract FLOPS.",
-    "UMask": "0x1"
-  },
-  {
-    "EventName": "fp_num_mov_elim_scal_op.optimized",
-    "EventCode": "0x04",
-    "BriefDescription": "Number of Scalar Ops optimized.",
-    "PublicDescription": "This is a dispatch based speculative event, and is useful for measuring the effectiveness of the Move elimination and Scalar code optimization schemes. Number of Scalar Ops optimized.",
-    "UMask": "0x8"
-  },
-  {
-    "EventName": "fp_num_mov_elim_scal_op.opt_potential",
-    "EventCode": "0x04",
-    "BriefDescription": "Number of Ops that are candidates for optimization (have Z-bit either set or pass).",
-    "PublicDescription": "This is a dispatch based speculative event, and is useful for measuring the effectiveness of the Move elimination and Scalar code optimization schemes. Number of Ops that are candidates for optimization (have Z-bit either set or pass).",
-    "UMask": "0x4"
-  },
-  {
-    "EventName": "fp_num_mov_elim_scal_op.sse_mov_ops_elim",
-    "EventCode": "0x04",
-    "BriefDescription": "Number of SSE Move Ops eliminated.",
-    "PublicDescription": "This is a dispatch based speculative event, and is useful for measuring the effectiveness of the Move elimination and Scalar code optimization schemes. Number of SSE Move Ops eliminated.",
-    "UMask": "0x2"
-  },
-  {
-    "EventName": "fp_num_mov_elim_scal_op.sse_mov_ops",
-    "EventCode": "0x04",
-    "BriefDescription": "Number of SSE Move Ops.",
-    "PublicDescription": "This is a dispatch based speculative event, and is useful for measuring the effectiveness of the Move elimination and Scalar code optimization schemes. Number of SSE Move Ops.",
-    "UMask": "0x1"
-  },
-  {
-    "EventName": "fp_retired_ser_ops.x87_ctrl_ret",
-    "EventCode": "0x05",
-    "BriefDescription": "x87 control word mispredict traps due to mispredictions in RC or PC, or changes in mask bits.",
-    "PublicDescription": "The number of serializing Ops retired. x87 control word mispredict traps due to mispredictions in RC or PC, or changes in mask bits.",
-    "UMask": "0x8"
-  },
-  {
-    "EventName": "fp_retired_ser_ops.x87_bot_ret",
-    "EventCode": "0x05",
-    "BriefDescription": "x87 bottom-executing uOps retired.",
-    "PublicDescription": "The number of serializing Ops retired. x87 bottom-executing uOps retired.",
-    "UMask": "0x4"
-  },
-  {
-    "EventName": "fp_retired_ser_ops.sse_ctrl_ret",
-    "EventCode": "0x05",
-    "BriefDescription": "SSE control word mispredict traps due to mispredictions in RC, FTZ or DAZ, or changes in mask bits.",
-    "PublicDescription": "The number of serializing Ops retired. SSE control word mispredict traps due to mispredictions in RC, FTZ or DAZ, or changes in mask bits.",
-    "UMask": "0x2"
-  },
-  {
-    "EventName": "fp_retired_ser_ops.sse_bot_ret",
-    "EventCode": "0x05",
-    "BriefDescription": "SSE bottom-executing uOps retired.",
-    "PublicDescription": "The number of serializing Ops retired. SSE bottom-executing uOps retired.",
-    "UMask": "0x1"
-  }
-]
diff --git a/tools/perf/pmu-events/arch/x86/amdfam17h/memory.json b/tools/perf/pmu-events/arch/x86/amdfam17h/memory.json
deleted file mode 100644
index fa2d60d..0000000
--- a/tools/perf/pmu-events/arch/x86/amdfam17h/memory.json
+++ /dev/null
@@ -1,162 +0,0 @@
-[
-  {
-    "EventName": "ls_locks.bus_lock",
-    "EventCode": "0x25",
-    "BriefDescription": "Bus lock when a locked operations crosses a cache boundary or is done on an uncacheable memory type.",
-    "PublicDescription": "Bus lock when a locked operations crosses a cache boundary or is done on an uncacheable memory type.",
-    "UMask": "0x1"
-  },
-  {
-    "EventName": "ls_dispatch.ld_st_dispatch",
-    "EventCode": "0x29",
-    "BriefDescription": "Load-op-Stores.",
-    "PublicDescription": "Counts the number of operations dispatched to the LS unit. Unit Masks ADDed. Load-op-Stores.",
-    "UMask": "0x4"
-  },
-  {
-    "EventName": "ls_dispatch.store_dispatch",
-    "EventCode": "0x29",
-    "BriefDescription": "Counts the number of operations dispatched to the LS unit. Unit Masks ADDed.",
-    "PublicDescription": "Counts the number of operations dispatched to the LS unit. Unit Masks ADDed.",
-    "UMask": "0x2"
-  },
-  {
-    "EventName": "ls_dispatch.ld_dispatch",
-    "EventCode": "0x29",
-    "BriefDescription": "Counts the number of operations dispatched to the LS unit. Unit Masks ADDed.",
-    "PublicDescription": "Counts the number of operations dispatched to the LS unit. Unit Masks ADDed.",
-    "UMask": "0x1"
-  },
-  {
-    "EventName": "ls_stlf",
-    "EventCode": "0x35",
-    "BriefDescription": "Number of STLF hits."
-  },
-  {
-    "EventName": "ls_dc_accesses",
-    "EventCode": "0x40",
-    "BriefDescription": "The number of accesses to the data cache for load and store references. This may include certain microcode scratchpad accesses, although these are generally rare. Each increment represents an eight-byte access, although the instruction may only be accessing a portion of that. This event is a speculative event."
-  },
-  {
-    "EventName": "ls_l1_d_tlb_miss.all",
-    "EventCode": "0x45",
-    "BriefDescription": "L1 DTLB Miss or Reload off all sizes.",
-    "PublicDescription": "L1 DTLB Miss or Reload off all sizes.",
-    "UMask": "0xff"
-  },
-  {
-    "EventName": "ls_l1_d_tlb_miss.tlb_reload_1g_l2_miss",
-    "EventCode": "0x45",
-    "BriefDescription": "L1 DTLB Miss of a page of 1G size.",
-    "PublicDescription": "L1 DTLB Miss of a page of 1G size.",
-    "UMask": "0x80"
-  },
-  {
-    "EventName": "ls_l1_d_tlb_miss.tlb_reload_2m_l2_miss",
-    "EventCode": "0x45",
-    "BriefDescription": "L1 DTLB Miss of a page of 2M size.",
-    "PublicDescription": "L1 DTLB Miss of a page of 2M size.",
-    "UMask": "0x40"
-  },
-  {
-    "EventName": "ls_l1_d_tlb_miss.tlb_reload_32k_l2_miss",
-    "EventCode": "0x45",
-    "BriefDescription": "L1 DTLB Miss of a page of 32K size.",
-    "PublicDescription": "L1 DTLB Miss of a page of 32K size.",
-    "UMask": "0x20"
-  },
-  {
-    "EventName": "ls_l1_d_tlb_miss.tlb_reload_4k_l2_miss",
-    "EventCode": "0x45",
-    "BriefDescription": "L1 DTLB Miss of a page of 4K size.",
-    "PublicDescription": "L1 DTLB Miss of a page of 4K size.",
-    "UMask": "0x10"
-  },
-  {
-    "EventName": "ls_l1_d_tlb_miss.tlb_reload_1g_l2_hit",
-    "EventCode": "0x45",
-    "BriefDescription": "L1 DTLB Reload of a page of 1G size.",
-    "PublicDescription": "L1 DTLB Reload of a page of 1G size.",
-    "UMask": "0x8"
-  },
-  {
-    "EventName": "ls_l1_d_tlb_miss.tlb_reload_2m_l2_hit",
-    "EventCode": "0x45",
-    "BriefDescription": "L1 DTLB Reload of a page of 2M size.",
-    "PublicDescription": "L1 DTLB Reload of a page of 2M size.",
-    "UMask": "0x4"
-  },
-  {
-    "EventName": "ls_l1_d_tlb_miss.tlb_reload_32k_l2_hit",
-    "EventCode": "0x45",
-    "BriefDescription": "L1 DTLB Reload of a page of 32K size.",
-    "PublicDescription": "L1 DTLB Reload of a page of 32K size.",
-    "UMask": "0x2"
-  },
-  {
-    "EventName": "ls_l1_d_tlb_miss.tlb_reload_4k_l2_hit",
-    "EventCode": "0x45",
-    "BriefDescription": "L1 DTLB Reload of a page of 4K size.",
-    "PublicDescription": "L1 DTLB Reload of a page of 4K size.",
-    "UMask": "0x1"
-  },
-  {
-    "EventName": "ls_tablewalker.perf_mon_tablewalk_alloc_iside",
-    "EventCode": "0x46",
-    "BriefDescription": "Tablewalker allocation.",
-    "PublicDescription": "Tablewalker allocation.",
-    "UMask": "0xc"
-  },
-  {
-    "EventName": "ls_tablewalker.perf_mon_tablewalk_alloc_dside",
-    "EventCode": "0x46",
-    "BriefDescription": "Tablewalker allocation.",
-    "PublicDescription": "Tablewalker allocation.",
-    "UMask": "0x3"
-  },
-  {
-    "EventName": "ls_misal_accesses",
-    "EventCode": "0x47",
-    "BriefDescription": "Misaligned loads."
-  },
-  {
-    "EventName": "ls_pref_instr_disp.prefetch_nta",
-    "EventCode": "0x4b",
-    "BriefDescription": "Software Prefetch Instructions (PREFETCHNTA instruction) Dispatched.",
-    "PublicDescription": "Software Prefetch Instructions (PREFETCHNTA instruction) Dispatched.",
-    "UMask": "0x4"
-  },
-  {
-    "EventName": "ls_pref_instr_disp.store_prefetch_w",
-    "EventCode": "0x4b",
-    "BriefDescription": "Software Prefetch Instructions (3DNow PREFETCHW instruction) Dispatched.",
-    "PublicDescription": "Software Prefetch Instructions (3DNow PREFETCHW instruction) Dispatched.",
-    "UMask": "0x2"
-  },
-  {
-    "EventName": "ls_pref_instr_disp.load_prefetch_w",
-    "EventCode": "0x4b",
-    "BriefDescription": "Prefetch, Prefetch_T0_T1_T2.",
-    "PublicDescription": "Software Prefetch Instructions Dispatched. Prefetch, Prefetch_T0_T1_T2.",
-    "UMask": "0x1"
-  },
-  {
-    "EventName": "ls_inef_sw_pref.mab_mch_cnt",
-    "EventCode": "0x52",
-    "BriefDescription": "The number of software prefetches that did not fetch data outside of the processor core.",
-    "PublicDescription": "The number of software prefetches that did not fetch data outside of the processor core.",
-    "UMask": "0x2"
-  },
-  {
-    "EventName": "ls_inef_sw_pref.data_pipe_sw_pf_dc_hit",
-    "EventCode": "0x52",
-    "BriefDescription": "The number of software prefetches that did not fetch data outside of the processor core.",
-    "PublicDescription": "The number of software prefetches that did not fetch data outside of the processor core.",
-    "UMask": "0x1"
-  },
-  {
-    "EventName": "ls_not_halted_cyc",
-    "EventCode": "0x76",
-    "BriefDescription": "Cycles not in Halt."
-  }
-]
diff --git a/tools/perf/pmu-events/arch/x86/amdfam17h/other.json b/tools/perf/pmu-events/arch/x86/amdfam17h/other.json
deleted file mode 100644
index b26a00d..0000000
--- a/tools/perf/pmu-events/arch/x86/amdfam17h/other.json
+++ /dev/null
@@ -1,65 +0,0 @@
-[
-  {
-    "EventName": "ic_oc_mode_switch.oc_ic_mode_switch",
-    "EventCode": "0x28a",
-    "BriefDescription": "OC to IC mode switch.",
-    "PublicDescription": "OC Mode Switch. OC to IC mode switch.",
-    "UMask": "0x2"
-  },
-  {
-    "EventName": "ic_oc_mode_switch.ic_oc_mode_switch",
-    "EventCode": "0x28a",
-    "BriefDescription": "IC to OC mode switch.",
-    "PublicDescription": "OC Mode Switch. IC to OC mode switch.",
-    "UMask": "0x1"
-  },
-  {
-    "EventName": "de_dis_dispatch_token_stalls0.retire_token_stall",
-    "EventCode": "0xaf",
-    "BriefDescription": "RETIRE Tokens unavailable.",
-    "PublicDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall. RETIRE Tokens unavailable.",
-    "UMask": "0x40"
-  },
-  {
-    "EventName": "de_dis_dispatch_token_stalls0.agsq_token_stall",
-    "EventCode": "0xaf",
-    "BriefDescription": "AGSQ Tokens unavailable.",
-    "PublicDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall. AGSQ Tokens unavailable.",
-    "UMask": "0x20"
-  },
-  {
-    "EventName": "de_dis_dispatch_token_stalls0.alu_token_stall",
-    "EventCode": "0xaf",
-    "BriefDescription": "ALU tokens total unavailable.",
-    "PublicDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall. ALU tokens total unavailable.",
-    "UMask": "0x10"
-  },
-  {
-    "EventName": "de_dis_dispatch_token_stalls0.alsq3_0_token_stall",
-    "EventCode": "0xaf",
-    "BriefDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall.",
-    "PublicDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall.",
-    "UMask": "0x8"
-  },
-  {
-    "EventName": "de_dis_dispatch_token_stalls0.alsq3_token_stall",
-    "EventCode": "0xaf",
-    "BriefDescription": "ALSQ 3 Tokens unavailable.",
-    "PublicDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall. ALSQ 3 Tokens unavailable.",
-    "UMask": "0x4"
-  },
-  {
-    "EventName": "de_dis_dispatch_token_stalls0.alsq2_token_stall",
-    "EventCode": "0xaf",
-    "BriefDescription": "ALSQ 2 Tokens unavailable.",
-    "PublicDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall. ALSQ 2 Tokens unavailable.",
-    "UMask": "0x2"
-  },
-  {
-    "EventName": "de_dis_dispatch_token_stalls0.alsq1_token_stall",
-    "EventCode": "0xaf",
-    "BriefDescription": "ALSQ 1 Tokens unavailable.",
-    "PublicDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall. ALSQ 1 Tokens unavailable.",
-    "UMask": "0x1"
-  }
-]
diff --git a/tools/perf/pmu-events/arch/x86/amdzen1/branch.json b/tools/perf/pmu-events/arch/x86/amdzen1/branch.json
new file mode 100644
index 0000000..93ddfd8
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/amdzen1/branch.json
@@ -0,0 +1,12 @@
+[
+  {
+    "EventName": "bp_l1_btb_correct",
+    "EventCode": "0x8a",
+    "BriefDescription": "L1 BTB Correction."
+  },
+  {
+    "EventName": "bp_l2_btb_correct",
+    "EventCode": "0x8b",
+    "BriefDescription": "L2 BTB Correction."
+  }
+]
diff --git a/tools/perf/pmu-events/arch/x86/amdzen1/cache.json b/tools/perf/pmu-events/arch/x86/amdzen1/cache.json
new file mode 100644
index 0000000..6221a84
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/amdzen1/cache.json
@@ -0,0 +1,329 @@
+[
+  {
+    "EventName": "ic_fw32",
+    "EventCode": "0x80",
+    "BriefDescription": "The number of 32B fetch windows transferred from IC pipe to DE instruction decoder (includes non-cacheable and cacheable fill responses)."
+  },
+  {
+    "EventName": "ic_fw32_miss",
+    "EventCode": "0x81",
+    "BriefDescription": "The number of 32B fetch windows tried to read the L1 IC and missed in the full tag."
+  },
+  {
+    "EventName": "ic_cache_fill_l2",
+    "EventCode": "0x82",
+    "BriefDescription": "The number of 64 byte instruction cache line was fulfilled from the L2 cache."
+  },
+  {
+    "EventName": "ic_cache_fill_sys",
+    "EventCode": "0x83",
+    "BriefDescription": "The number of 64 byte instruction cache line fulfilled from system memory or another cache."
+  },
+  {
+    "EventName": "bp_l1_tlb_miss_l2_hit",
+    "EventCode": "0x84",
+    "BriefDescription": "The number of instruction fetches that miss in the L1 ITLB but hit in the L2 ITLB."
+  },
+  {
+    "EventName": "bp_l1_tlb_miss_l2_miss",
+    "EventCode": "0x85",
+    "BriefDescription": "The number of instruction fetches that miss in both the L1 and L2 TLBs."
+  },
+  {
+    "EventName": "bp_snp_re_sync",
+    "EventCode": "0x86",
+    "BriefDescription": "The number of pipeline restarts caused by invalidating probes that hit on the instruction stream currently being executed. This would happen if the active instruction stream was being modified by another processor in an MP system - typically a highly unlikely event."
+  },
+  {
+    "EventName": "ic_fetch_stall.ic_stall_any",
+    "EventCode": "0x87",
+    "BriefDescription": "IC pipe was stalled during this clock cycle for any reason (nothing valid in pipe ICM1).",
+    "PublicDescription": "Instruction Pipe Stall. IC pipe was stalled during this clock cycle for any reason (nothing valid in pipe ICM1).",
+    "UMask": "0x4"
+  },
+  {
+    "EventName": "ic_fetch_stall.ic_stall_dq_empty",
+    "EventCode": "0x87",
+    "BriefDescription": "IC pipe was stalled during this clock cycle (including IC to OC fetches) due to DQ empty.",
+    "PublicDescription": "Instruction Pipe Stall. IC pipe was stalled during this clock cycle (including IC to OC fetches) due to DQ empty.",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "ic_fetch_stall.ic_stall_back_pressure",
+    "EventCode": "0x87",
+    "BriefDescription": "IC pipe was stalled during this clock cycle (including IC to OC fetches) due to back-pressure.",
+    "PublicDescription": "Instruction Pipe Stall. IC pipe was stalled during this clock cycle (including IC to OC fetches) due to back-pressure.",
+    "UMask": "0x1"
+  },
+  {
+    "EventName": "ic_cache_inval.l2_invalidating_probe",
+    "EventCode": "0x8c",
+    "BriefDescription": "IC line invalidated due to L2 invalidating probe (external or LS).",
+    "PublicDescription": "The number of instruction cache lines invalidated. A non-SMC event is CMC (cross modifying code), either from the other thread of the core or another core. IC line invalidated due to L2 invalidating probe (external or LS).",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "ic_cache_inval.fill_invalidated",
+    "EventCode": "0x8c",
+    "BriefDescription": "IC line invalidated due to overwriting fill response.",
+    "PublicDescription": "The number of instruction cache lines invalidated. A non-SMC event is CMC (cross modifying code), either from the other thread of the core or another core. IC line invalidated due to overwriting fill response.",
+    "UMask": "0x1"
+  },
+  {
+    "EventName": "bp_tlb_rel",
+    "EventCode": "0x99",
+    "BriefDescription": "The number of ITLB reload requests."
+  },
+  {
+    "EventName": "l2_request_g1.rd_blk_l",
+    "EventCode": "0x60",
+    "BriefDescription": "Requests to L2 Group1.",
+    "PublicDescription": "Requests to L2 Group1.",
+    "UMask": "0x80"
+  },
+  {
+    "EventName": "l2_request_g1.rd_blk_x",
+    "EventCode": "0x60",
+    "BriefDescription": "Requests to L2 Group1.",
+    "PublicDescription": "Requests to L2 Group1.",
+    "UMask": "0x40"
+  },
+  {
+    "EventName": "l2_request_g1.ls_rd_blk_c_s",
+    "EventCode": "0x60",
+    "BriefDescription": "Requests to L2 Group1.",
+    "PublicDescription": "Requests to L2 Group1.",
+    "UMask": "0x20"
+  },
+  {
+    "EventName": "l2_request_g1.cacheable_ic_read",
+    "EventCode": "0x60",
+    "BriefDescription": "Requests to L2 Group1.",
+    "PublicDescription": "Requests to L2 Group1.",
+    "UMask": "0x10"
+  },
+  {
+    "EventName": "l2_request_g1.change_to_x",
+    "EventCode": "0x60",
+    "BriefDescription": "Requests to L2 Group1.",
+    "PublicDescription": "Requests to L2 Group1.",
+    "UMask": "0x8"
+  },
+  {
+    "EventName": "l2_request_g1.prefetch_l2",
+    "EventCode": "0x60",
+    "BriefDescription": "Requests to L2 Group1.",
+    "PublicDescription": "Requests to L2 Group1.",
+    "UMask": "0x4"
+  },
+  {
+    "EventName": "l2_request_g1.l2_hw_pf",
+    "EventCode": "0x60",
+    "BriefDescription": "Requests to L2 Group1.",
+    "PublicDescription": "Requests to L2 Group1.",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "l2_request_g1.other_requests",
+    "EventCode": "0x60",
+    "BriefDescription": "Events covered by l2_request_g2.",
+    "PublicDescription": "Requests to L2 Group1. Events covered by l2_request_g2.",
+    "UMask": "0x1"
+  },
+  {
+    "EventName": "l2_request_g2.group1",
+    "EventCode": "0x61",
+    "BriefDescription": "All Group 1 commands not in unit0.",
+    "PublicDescription": "Multi-events in that LS and IF requests can be received simultaneous. All Group 1 commands not in unit0.",
+    "UMask": "0x80"
+  },
+  {
+    "EventName": "l2_request_g2.ls_rd_sized",
+    "EventCode": "0x61",
+    "BriefDescription": "RdSized, RdSized32, RdSized64.",
+    "PublicDescription": "Multi-events in that LS and IF requests can be received simultaneous. RdSized, RdSized32, RdSized64.",
+    "UMask": "0x40"
+  },
+  {
+    "EventName": "l2_request_g2.ls_rd_sized_nc",
+    "EventCode": "0x61",
+    "BriefDescription": "RdSizedNC, RdSized32NC, RdSized64NC.",
+    "PublicDescription": "Multi-events in that LS and IF requests can be received simultaneous. RdSizedNC, RdSized32NC, RdSized64NC.",
+    "UMask": "0x20"
+  },
+  {
+    "EventName": "l2_request_g2.ic_rd_sized",
+    "EventCode": "0x61",
+    "BriefDescription": "Multi-events in that LS and IF requests can be received simultaneous.",
+    "PublicDescription": "Multi-events in that LS and IF requests can be received simultaneous.",
+    "UMask": "0x10"
+  },
+  {
+    "EventName": "l2_request_g2.ic_rd_sized_nc",
+    "EventCode": "0x61",
+    "BriefDescription": "Multi-events in that LS and IF requests can be received simultaneous.",
+    "PublicDescription": "Multi-events in that LS and IF requests can be received simultaneous.",
+    "UMask": "0x8"
+  },
+  {
+    "EventName": "l2_request_g2.smc_inval",
+    "EventCode": "0x61",
+    "BriefDescription": "Multi-events in that LS and IF requests can be received simultaneous.",
+    "PublicDescription": "Multi-events in that LS and IF requests can be received simultaneous.",
+    "UMask": "0x4"
+  },
+  {
+    "EventName": "l2_request_g2.bus_locks_originator",
+    "EventCode": "0x61",
+    "BriefDescription": "Multi-events in that LS and IF requests can be received simultaneous.",
+    "PublicDescription": "Multi-events in that LS and IF requests can be received simultaneous.",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "l2_request_g2.bus_locks_responses",
+    "EventCode": "0x61",
+    "BriefDescription": "Multi-events in that LS and IF requests can be received simultaneous.",
+    "PublicDescription": "Multi-events in that LS and IF requests can be received simultaneous.",
+    "UMask": "0x1"
+  },
+  {
+    "EventName": "l2_latency.l2_cycles_waiting_on_fills",
+    "EventCode": "0x62",
+    "BriefDescription": "Total cycles spent waiting for L2 fills to complete from L3 or memory, divided by four. Event counts are for both threads. To calculate average latency, the number of fills from both threads must be used.",
+    "PublicDescription": "Total cycles spent waiting for L2 fills to complete from L3 or memory, divided by four. Event counts are for both threads. To calculate average latency, the number of fills from both threads must be used.",
+    "UMask": "0x1"
+  },
+  {
+    "EventName": "l2_wcb_req.wcb_write",
+    "EventCode": "0x63",
+    "PublicDescription": "LS (Load/Store unit) to L2 WCB (Write Combining Buffer) write requests.",
+    "BriefDescription": "LS to L2 WCB write requests.",
+    "UMask": "0x40"
+  },
+  {
+    "EventName": "l2_wcb_req.wcb_close",
+    "EventCode": "0x63",
+    "BriefDescription": "LS to L2 WCB close requests.",
+    "PublicDescription": "LS (Load/Store unit) to L2 WCB (Write Combining Buffer) close requests.",
+    "UMask": "0x20"
+  },
+  {
+    "EventName": "l2_wcb_req.zero_byte_store",
+    "EventCode": "0x63",
+    "BriefDescription": "LS to L2 WCB zero byte store requests.",
+    "PublicDescription": "LS (Load/Store unit) to L2 WCB (Write Combining Buffer) zero byte store requests.",
+    "UMask": "0x4"
+  },
+  {
+    "EventName": "l2_wcb_req.cl_zero",
+    "EventCode": "0x63",
+    "PublicDescription": "LS to L2 WCB cache line zeroing requests.",
+    "BriefDescription": "LS (Load/Store unit) to L2 WCB (Write Combining Buffer) cache line zeroing requests.",
+    "UMask": "0x1"
+  },
+  {
+    "EventName": "l2_cache_req_stat.ls_rd_blk_cs",
+    "EventCode": "0x64",
+    "BriefDescription": "LS ReadBlock C/S Hit.",
+    "PublicDescription": "This event does not count accesses to the L2 cache by the L2 prefetcher, but it does count accesses by the L1 prefetcher. LS ReadBlock C/S Hit.",
+    "UMask": "0x80"
+  },
+  {
+    "EventName": "l2_cache_req_stat.ls_rd_blk_l_hit_x",
+    "EventCode": "0x64",
+    "BriefDescription": "LS Read Block L Hit X.",
+    "PublicDescription": "This event does not count accesses to the L2 cache by the L2 prefetcher, but it does count accesses by the L1 prefetcher. LS Read Block L Hit X.",
+    "UMask": "0x40"
+  },
+  {
+    "EventName": "l2_cache_req_stat.ls_rd_blk_l_hit_s",
+    "EventCode": "0x64",
+    "BriefDescription": "LsRdBlkL Hit Shared.",
+    "PublicDescription": "This event does not count accesses to the L2 cache by the L2 prefetcher, but it does count accesses by the L1 prefetcher. LsRdBlkL Hit Shared.",
+    "UMask": "0x20"
+  },
+  {
+    "EventName": "l2_cache_req_stat.ls_rd_blk_x",
+    "EventCode": "0x64",
+    "BriefDescription": "LsRdBlkX/ChgToX Hit X.  Count RdBlkX finding Shared as a Miss.",
+    "PublicDescription": "This event does not count accesses to the L2 cache by the L2 prefetcher, but it does count accesses by the L1 prefetcher. LsRdBlkX/ChgToX Hit X.  Count RdBlkX finding Shared as a Miss.",
+    "UMask": "0x10"
+  },
+  {
+    "EventName": "l2_cache_req_stat.ls_rd_blk_c",
+    "EventCode": "0x64",
+    "BriefDescription": "LS Read Block C S L X Change to X Miss.",
+    "PublicDescription": "This event does not count accesses to the L2 cache by the L2 prefetcher, but it does count accesses by the L1 prefetcher. LS Read Block C S L X Change to X Miss.",
+    "UMask": "0x8"
+  },
+  {
+    "EventName": "l2_cache_req_stat.ic_fill_hit_x",
+    "EventCode": "0x64",
+    "BriefDescription": "IC Fill Hit Exclusive Stale.",
+    "PublicDescription": "This event does not count accesses to the L2 cache by the L2 prefetcher, but it does count accesses by the L1 prefetcher. IC Fill Hit Exclusive Stale.",
+    "UMask": "0x4"
+  },
+  {
+    "EventName": "l2_cache_req_stat.ic_fill_hit_s",
+    "EventCode": "0x64",
+    "BriefDescription": "IC Fill Hit Shared.",
+    "PublicDescription": "This event does not count accesses to the L2 cache by the L2 prefetcher, but it does count accesses by the L1 prefetcher. IC Fill Hit Shared.",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "l2_cache_req_stat.ic_fill_miss",
+    "EventCode": "0x64",
+    "BriefDescription": "IC Fill Miss.",
+    "PublicDescription": "This event does not count accesses to the L2 cache by the L2 prefetcher, but it does count accesses by the L1 prefetcher. IC Fill Miss.",
+    "UMask": "0x1"
+  },
+  {
+    "EventName": "l2_fill_pending.l2_fill_busy",
+    "EventCode": "0x6d",
+    "BriefDescription": "Total cycles spent with one or more fill requests in flight from L2.",
+    "PublicDescription": "Total cycles spent with one or more fill requests in flight from L2.",
+    "UMask": "0x1"
+  },
+  {
+    "EventName": "l3_request_g1.caching_l3_cache_accesses",
+    "EventCode": "0x01",
+    "BriefDescription": "Caching: L3 cache accesses",
+    "UMask": "0x80",
+    "Unit": "L3PMC"
+  },
+  {
+    "EventName": "l3_lookup_state.all_l3_req_typs",
+    "EventCode": "0x04",
+    "BriefDescription": "All L3 Request Types",
+    "UMask": "0xff",
+    "Unit": "L3PMC"
+  },
+  {
+    "EventName": "l3_comb_clstr_state.other_l3_miss_typs",
+    "EventCode": "0x06",
+    "BriefDescription": "Other L3 Miss Request Types",
+    "UMask": "0xfe",
+    "Unit": "L3PMC"
+  },
+  {
+    "EventName": "l3_comb_clstr_state.request_miss",
+    "EventCode": "0x06",
+    "BriefDescription": "L3 cache misses",
+    "UMask": "0x01",
+    "Unit": "L3PMC"
+  },
+  {
+    "EventName": "xi_sys_fill_latency",
+    "EventCode": "0x90",
+    "BriefDescription": "L3 Cache Miss Latency. Total cycles for all transactions divided by 16. Ignores SliceMask and ThreadMask.",
+    "UMask": "0x00",
+    "Unit": "L3PMC"
+  },
+  {
+    "EventName": "xi_ccx_sdp_req1.all_l3_miss_req_typs",
+    "EventCode": "0x9a",
+    "BriefDescription": "All L3 Miss Request Types. Ignores SliceMask and ThreadMask.",
+    "UMask": "0x3f",
+    "Unit": "L3PMC"
+  }
+]
diff --git a/tools/perf/pmu-events/arch/x86/amdzen1/core.json b/tools/perf/pmu-events/arch/x86/amdzen1/core.json
new file mode 100644
index 0000000..1079544
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/amdzen1/core.json
@@ -0,0 +1,134 @@
+[
+  {
+    "EventName": "ex_ret_instr",
+    "EventCode": "0xc0",
+    "BriefDescription": "Retired Instructions."
+  },
+  {
+    "EventName": "ex_ret_cops",
+    "EventCode": "0xc1",
+    "BriefDescription": "Retired Uops.",
+    "PublicDescription": "The number of uOps retired. This includes all processor activity (instructions, exceptions, interrupts, microcode assists, etc.). The number of events logged per cycle can vary from 0 to 4."
+  },
+  {
+    "EventName": "ex_ret_brn",
+    "EventCode": "0xc2",
+    "BriefDescription": "Retired Branch Instructions.",
+    "PublicDescription": "The number of branch instructions retired. This includes all types of architectural control flow changes, including exceptions and interrupts."
+  },
+  {
+    "EventName": "ex_ret_brn_misp",
+    "EventCode": "0xc3",
+    "BriefDescription": "Retired Branch Instructions Mispredicted.",
+    "PublicDescription": "The number of branch instructions retired, of any type, that were not correctly predicted. This includes those for which prediction is not attempted (far control transfers, exceptions and interrupts)."
+  },
+  {
+    "EventName": "ex_ret_brn_tkn",
+    "EventCode": "0xc4",
+    "BriefDescription": "Retired Taken Branch Instructions.",
+    "PublicDescription": "The number of taken branches that were retired. This includes all types of architectural control flow changes, including exceptions and interrupts."
+  },
+  {
+    "EventName": "ex_ret_brn_tkn_misp",
+    "EventCode": "0xc5",
+    "BriefDescription": "Retired Taken Branch Instructions Mispredicted.",
+    "PublicDescription": "The number of retired taken branch instructions that were mispredicted."
+  },
+  {
+    "EventName": "ex_ret_brn_far",
+    "EventCode": "0xc6",
+    "BriefDescription": "Retired Far Control Transfers.",
+    "PublicDescription": "The number of far control transfers retired including far call/jump/return, IRET, SYSCALL and SYSRET, plus exceptions and interrupts. Far control transfers are not subject to branch prediction."
+  },
+  {
+    "EventName": "ex_ret_brn_resync",
+    "EventCode": "0xc7",
+    "BriefDescription": "Retired Branch Resyncs.",
+    "PublicDescription": "The number of resync branches. These reflect pipeline restarts due to certain microcode assists and events such as writes to the active instruction stream, among other things. Each occurrence reflects a restart penalty similar to a branch mispredict. This is relatively rare."
+  },
+  {
+    "EventName": "ex_ret_near_ret",
+    "EventCode": "0xc8",
+    "BriefDescription": "Retired Near Returns.",
+    "PublicDescription": "The number of near return instructions (RET or RET Iw) retired."
+  },
+  {
+    "EventName": "ex_ret_near_ret_mispred",
+    "EventCode": "0xc9",
+    "BriefDescription": "Retired Near Returns Mispredicted.",
+    "PublicDescription": "The number of near returns retired that were not correctly predicted by the return address predictor. Each such mispredict incurs the same penalty as a mispredicted conditional branch instruction."
+  },
+  {
+    "EventName": "ex_ret_brn_ind_misp",
+    "EventCode": "0xca",
+    "BriefDescription": "Retired Indirect Branch Instructions Mispredicted.",
+    "PublicDescription": "Retired Indirect Branch Instructions Mispredicted."
+  },
+  {
+    "EventName": "ex_ret_mmx_fp_instr.sse_instr",
+    "EventCode": "0xcb",
+    "BriefDescription": "SSE instructions (SSE, SSE2, SSE3, SSSE3, SSE4A, SSE41, SSE42, AVX).",
+    "PublicDescription": "The number of MMX, SSE or x87 instructions retired. The UnitMask allows the selection of the individual classes of instructions as given in the table. Each increment represents one complete instruction. Since this event includes non-numeric instructions it is not suitable for measuring MFLOPS. SSE instructions (SSE, SSE2, SSE3, SSSE3, SSE4A, SSE41, SSE42, AVX).",
+    "UMask": "0x4"
+  },
+  {
+    "EventName": "ex_ret_mmx_fp_instr.mmx_instr",
+    "EventCode": "0xcb",
+    "BriefDescription": "MMX instructions.",
+    "PublicDescription": "The number of MMX, SSE or x87 instructions retired. The UnitMask allows the selection of the individual classes of instructions as given in the table. Each increment represents one complete instruction. Since this event includes non-numeric instructions it is not suitable for measuring MFLOPS. MMX instructions.",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "ex_ret_mmx_fp_instr.x87_instr",
+    "EventCode": "0xcb",
+    "BriefDescription": "x87 instructions.",
+    "PublicDescription": "The number of MMX, SSE or x87 instructions retired. The UnitMask allows the selection of the individual classes of instructions as given in the table. Each increment represents one complete instruction. Since this event includes non-numeric instructions it is not suitable for measuring MFLOPS. x87 instructions.",
+    "UMask": "0x1"
+  },
+  {
+    "EventName": "ex_ret_cond",
+    "EventCode": "0xd1",
+    "BriefDescription": "Retired Conditional Branch Instructions."
+  },
+  {
+    "EventName": "ex_ret_cond_misp",
+    "EventCode": "0xd2",
+    "BriefDescription": "Retired Conditional Branch Instructions Mispredicted."
+  },
+  {
+    "EventName": "ex_div_busy",
+    "EventCode": "0xd3",
+    "BriefDescription": "Div Cycles Busy count."
+  },
+  {
+    "EventName": "ex_div_count",
+    "EventCode": "0xd4",
+    "BriefDescription": "Div Op Count."
+  },
+  {
+    "EventName": "ex_tagged_ibs_ops.ibs_count_rollover",
+    "EventCode": "0x1cf",
+    "BriefDescription": "Number of times an op could not be tagged by IBS because of a previous tagged op that has not retired.",
+    "PublicDescription": "Tagged IBS Ops. Number of times an op could not be tagged by IBS because of a previous tagged op that has not retired.",
+    "UMask": "0x4"
+  },
+  {
+    "EventName": "ex_tagged_ibs_ops.ibs_tagged_ops_ret",
+    "EventCode": "0x1cf",
+    "BriefDescription": "Number of Ops tagged by IBS that retired.",
+    "PublicDescription": "Tagged IBS Ops. Number of Ops tagged by IBS that retired.",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "ex_tagged_ibs_ops.ibs_tagged_ops",
+    "EventCode": "0x1cf",
+    "BriefDescription": "Number of Ops tagged by IBS.",
+    "PublicDescription": "Tagged IBS Ops. Number of Ops tagged by IBS.",
+    "UMask": "0x1"
+  },
+  {
+    "EventName": "ex_ret_fus_brnch_inst",
+    "EventCode": "0x1d0",
+    "BriefDescription": "The number of fused retired branch instructions retired per cycle. The number of events logged per cycle can vary from 0 to 3."
+  }
+]
diff --git a/tools/perf/pmu-events/arch/x86/amdzen1/floating-point.json b/tools/perf/pmu-events/arch/x86/amdzen1/floating-point.json
new file mode 100644
index 0000000..ea47119
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/amdzen1/floating-point.json
@@ -0,0 +1,168 @@
+[
+  {
+    "EventName": "fpu_pipe_assignment.dual",
+    "EventCode": "0x00",
+    "BriefDescription": "Total number multi-pipe uOps.",
+    "PublicDescription": "The number of operations (uOps) and dual-pipe uOps dispatched to each of the 4 FPU execution pipelines. This event reflects how busy the FPU pipelines are and may be used for workload characterization. This includes all operations performed by x87, MMX, and SSE instructions, including moves. Each increment represents a one- cycle dispatch event. This event is a speculative event. Since this event includes non-numeric operations it is not suitable for measuring MFLOPS. Total number multi-pipe uOps assigned to Pipe 3.",
+    "UMask": "0xf0"
+  },
+  {
+    "EventName": "fpu_pipe_assignment.total",
+    "EventCode": "0x00",
+    "BriefDescription": "Total number uOps.",
+    "PublicDescription": "The number of operations (uOps) and dual-pipe uOps dispatched to each of the 4 FPU execution pipelines. This event reflects how busy the FPU pipelines are and may be used for workload characterization. This includes all operations performed by x87, MMX, and SSE instructions, including moves. Each increment represents a one- cycle dispatch event. This event is a speculative event. Since this event includes non-numeric operations it is not suitable for measuring MFLOPS. Total number uOps assigned to Pipe 3.",
+    "UMask": "0xf"
+  },
+  {
+    "EventName": "fp_sched_empty",
+    "EventCode": "0x01",
+    "BriefDescription": "This is a speculative event. The number of cycles in which the FPU scheduler is empty. Note that some Ops like FP loads bypass the scheduler."
+  },
+  {
+    "EventName": "fp_retx87_fp_ops.all",
+    "EventCode": "0x02",
+    "BriefDescription": "All Ops.",
+    "PublicDescription": "The number of x87 floating-point Ops that have retired. The number of events logged per cycle can vary from 0 to 8.",
+    "UMask": "0x7"
+  },
+  {
+    "EventName": "fp_retx87_fp_ops.div_sqr_r_ops",
+    "EventCode": "0x02",
+    "BriefDescription": "Divide and square root Ops.",
+    "PublicDescription": "The number of x87 floating-point Ops that have retired. The number of events logged per cycle can vary from 0 to 8. Divide and square root Ops.",
+    "UMask": "0x4"
+  },
+  {
+    "EventName": "fp_retx87_fp_ops.mul_ops",
+    "EventCode": "0x02",
+    "BriefDescription": "Multiply Ops.",
+    "PublicDescription": "The number of x87 floating-point Ops that have retired. The number of events logged per cycle can vary from 0 to 8. Multiply Ops.",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "fp_retx87_fp_ops.add_sub_ops",
+    "EventCode": "0x02",
+    "BriefDescription": "Add/subtract Ops.",
+    "PublicDescription": "The number of x87 floating-point Ops that have retired. The number of events logged per cycle can vary from 0 to 8. Add/subtract Ops.",
+    "UMask": "0x1"
+  },
+  {
+    "EventName": "fp_ret_sse_avx_ops.all",
+    "EventCode": "0x03",
+    "BriefDescription": "All FLOPS.",
+    "PublicDescription": "This is a retire-based event. The number of retired SSE/AVX FLOPS. The number of events logged per cycle can vary from 0 to 64. This event can count above 15.",
+    "UMask": "0xff"
+  },
+  {
+    "EventName": "fp_ret_sse_avx_ops.dp_mult_add_flops",
+    "EventCode": "0x03",
+    "BriefDescription": "Double precision multiply-add FLOPS. Multiply-add counts as 2 FLOPS.",
+    "PublicDescription": "This is a retire-based event. The number of retired SSE/AVX FLOPS. The number of events logged per cycle can vary from 0 to 64. This event can count above 15. Double precision multiply-add FLOPS. Multiply-add counts as 2 FLOPS.",
+    "UMask": "0x80"
+  },
+  {
+    "EventName": "fp_ret_sse_avx_ops.dp_div_flops",
+    "EventCode": "0x03",
+    "BriefDescription": "Double precision divide/square root FLOPS.",
+    "PublicDescription": "This is a retire-based event. The number of retired SSE/AVX FLOPS. The number of events logged per cycle can vary from 0 to 64. This event can count above 15. Double precision divide/square root FLOPS.",
+    "UMask": "0x40"
+  },
+  {
+    "EventName": "fp_ret_sse_avx_ops.dp_mult_flops",
+    "EventCode": "0x03",
+    "BriefDescription": "Double precision multiply FLOPS.",
+    "PublicDescription": "This is a retire-based event. The number of retired SSE/AVX FLOPS. The number of events logged per cycle can vary from 0 to 64. This event can count above 15. Double precision multiply FLOPS.",
+    "UMask": "0x20"
+  },
+  {
+    "EventName": "fp_ret_sse_avx_ops.dp_add_sub_flops",
+    "EventCode": "0x03",
+    "BriefDescription": "Double precision add/subtract FLOPS.",
+    "PublicDescription": "This is a retire-based event. The number of retired SSE/AVX FLOPS. The number of events logged per cycle can vary from 0 to 64. This event can count above 15. Double precision add/subtract FLOPS.",
+    "UMask": "0x10"
+  },
+  {
+    "EventName": "fp_ret_sse_avx_ops.sp_mult_add_flops",
+    "EventCode": "0x03",
+    "BriefDescription": "Single precision multiply-add FLOPS. Multiply-add counts as 2 FLOPS.",
+    "PublicDescription": "This is a retire-based event. The number of retired SSE/AVX FLOPS. The number of events logged per cycle can vary from 0 to 64. This event can count above 15. Single precision multiply-add FLOPS. Multiply-add counts as 2 FLOPS.",
+    "UMask": "0x8"
+  },
+  {
+    "EventName": "fp_ret_sse_avx_ops.sp_div_flops",
+    "EventCode": "0x03",
+    "BriefDescription": "Single-precision divide/square root FLOPS.",
+    "PublicDescription": "This is a retire-based event. The number of retired SSE/AVX FLOPS. The number of events logged per cycle can vary from 0 to 64. This event can count above 15. Single-precision divide/square root FLOPS.",
+    "UMask": "0x4"
+  },
+  {
+    "EventName": "fp_ret_sse_avx_ops.sp_mult_flops",
+    "EventCode": "0x03",
+    "BriefDescription": "Single-precision multiply FLOPS.",
+    "PublicDescription": "This is a retire-based event. The number of retired SSE/AVX FLOPS. The number of events logged per cycle can vary from 0 to 64. This event can count above 15. Single-precision multiply FLOPS.",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "fp_ret_sse_avx_ops.sp_add_sub_flops",
+    "EventCode": "0x03",
+    "BriefDescription": "Single-precision add/subtract FLOPS.",
+    "PublicDescription": "This is a retire-based event. The number of retired SSE/AVX FLOPS. The number of events logged per cycle can vary from 0 to 64. This event can count above 15. Single-precision add/subtract FLOPS.",
+    "UMask": "0x1"
+  },
+  {
+    "EventName": "fp_num_mov_elim_scal_op.optimized",
+    "EventCode": "0x04",
+    "BriefDescription": "Number of Scalar Ops optimized.",
+    "PublicDescription": "This is a dispatch based speculative event, and is useful for measuring the effectiveness of the Move elimination and Scalar code optimization schemes. Number of Scalar Ops optimized.",
+    "UMask": "0x8"
+  },
+  {
+    "EventName": "fp_num_mov_elim_scal_op.opt_potential",
+    "EventCode": "0x04",
+    "BriefDescription": "Number of Ops that are candidates for optimization (have Z-bit either set or pass).",
+    "PublicDescription": "This is a dispatch based speculative event, and is useful for measuring the effectiveness of the Move elimination and Scalar code optimization schemes. Number of Ops that are candidates for optimization (have Z-bit either set or pass).",
+    "UMask": "0x4"
+  },
+  {
+    "EventName": "fp_num_mov_elim_scal_op.sse_mov_ops_elim",
+    "EventCode": "0x04",
+    "BriefDescription": "Number of SSE Move Ops eliminated.",
+    "PublicDescription": "This is a dispatch based speculative event, and is useful for measuring the effectiveness of the Move elimination and Scalar code optimization schemes. Number of SSE Move Ops eliminated.",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "fp_num_mov_elim_scal_op.sse_mov_ops",
+    "EventCode": "0x04",
+    "BriefDescription": "Number of SSE Move Ops.",
+    "PublicDescription": "This is a dispatch based speculative event, and is useful for measuring the effectiveness of the Move elimination and Scalar code optimization schemes. Number of SSE Move Ops.",
+    "UMask": "0x1"
+  },
+  {
+    "EventName": "fp_retired_ser_ops.x87_ctrl_ret",
+    "EventCode": "0x05",
+    "BriefDescription": "x87 control word mispredict traps due to mispredictions in RC or PC, or changes in mask bits.",
+    "PublicDescription": "The number of serializing Ops retired. x87 control word mispredict traps due to mispredictions in RC or PC, or changes in mask bits.",
+    "UMask": "0x8"
+  },
+  {
+    "EventName": "fp_retired_ser_ops.x87_bot_ret",
+    "EventCode": "0x05",
+    "BriefDescription": "x87 bottom-executing uOps retired.",
+    "PublicDescription": "The number of serializing Ops retired. x87 bottom-executing uOps retired.",
+    "UMask": "0x4"
+  },
+  {
+    "EventName": "fp_retired_ser_ops.sse_ctrl_ret",
+    "EventCode": "0x05",
+    "BriefDescription": "SSE control word mispredict traps due to mispredictions in RC, FTZ or DAZ, or changes in mask bits.",
+    "PublicDescription": "The number of serializing Ops retired. SSE control word mispredict traps due to mispredictions in RC, FTZ or DAZ, or changes in mask bits.",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "fp_retired_ser_ops.sse_bot_ret",
+    "EventCode": "0x05",
+    "BriefDescription": "SSE bottom-executing uOps retired.",
+    "PublicDescription": "The number of serializing Ops retired. SSE bottom-executing uOps retired.",
+    "UMask": "0x1"
+  }
+]
diff --git a/tools/perf/pmu-events/arch/x86/amdzen1/memory.json b/tools/perf/pmu-events/arch/x86/amdzen1/memory.json
new file mode 100644
index 0000000..fa2d60d
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/amdzen1/memory.json
@@ -0,0 +1,162 @@
+[
+  {
+    "EventName": "ls_locks.bus_lock",
+    "EventCode": "0x25",
+    "BriefDescription": "Bus lock when a locked operations crosses a cache boundary or is done on an uncacheable memory type.",
+    "PublicDescription": "Bus lock when a locked operations crosses a cache boundary or is done on an uncacheable memory type.",
+    "UMask": "0x1"
+  },
+  {
+    "EventName": "ls_dispatch.ld_st_dispatch",
+    "EventCode": "0x29",
+    "BriefDescription": "Load-op-Stores.",
+    "PublicDescription": "Counts the number of operations dispatched to the LS unit. Unit Masks ADDed. Load-op-Stores.",
+    "UMask": "0x4"
+  },
+  {
+    "EventName": "ls_dispatch.store_dispatch",
+    "EventCode": "0x29",
+    "BriefDescription": "Counts the number of operations dispatched to the LS unit. Unit Masks ADDed.",
+    "PublicDescription": "Counts the number of operations dispatched to the LS unit. Unit Masks ADDed.",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "ls_dispatch.ld_dispatch",
+    "EventCode": "0x29",
+    "BriefDescription": "Counts the number of operations dispatched to the LS unit. Unit Masks ADDed.",
+    "PublicDescription": "Counts the number of operations dispatched to the LS unit. Unit Masks ADDed.",
+    "UMask": "0x1"
+  },
+  {
+    "EventName": "ls_stlf",
+    "EventCode": "0x35",
+    "BriefDescription": "Number of STLF hits."
+  },
+  {
+    "EventName": "ls_dc_accesses",
+    "EventCode": "0x40",
+    "BriefDescription": "The number of accesses to the data cache for load and store references. This may include certain microcode scratchpad accesses, although these are generally rare. Each increment represents an eight-byte access, although the instruction may only be accessing a portion of that. This event is a speculative event."
+  },
+  {
+    "EventName": "ls_l1_d_tlb_miss.all",
+    "EventCode": "0x45",
+    "BriefDescription": "L1 DTLB Miss or Reload off all sizes.",
+    "PublicDescription": "L1 DTLB Miss or Reload off all sizes.",
+    "UMask": "0xff"
+  },
+  {
+    "EventName": "ls_l1_d_tlb_miss.tlb_reload_1g_l2_miss",
+    "EventCode": "0x45",
+    "BriefDescription": "L1 DTLB Miss of a page of 1G size.",
+    "PublicDescription": "L1 DTLB Miss of a page of 1G size.",
+    "UMask": "0x80"
+  },
+  {
+    "EventName": "ls_l1_d_tlb_miss.tlb_reload_2m_l2_miss",
+    "EventCode": "0x45",
+    "BriefDescription": "L1 DTLB Miss of a page of 2M size.",
+    "PublicDescription": "L1 DTLB Miss of a page of 2M size.",
+    "UMask": "0x40"
+  },
+  {
+    "EventName": "ls_l1_d_tlb_miss.tlb_reload_32k_l2_miss",
+    "EventCode": "0x45",
+    "BriefDescription": "L1 DTLB Miss of a page of 32K size.",
+    "PublicDescription": "L1 DTLB Miss of a page of 32K size.",
+    "UMask": "0x20"
+  },
+  {
+    "EventName": "ls_l1_d_tlb_miss.tlb_reload_4k_l2_miss",
+    "EventCode": "0x45",
+    "BriefDescription": "L1 DTLB Miss of a page of 4K size.",
+    "PublicDescription": "L1 DTLB Miss of a page of 4K size.",
+    "UMask": "0x10"
+  },
+  {
+    "EventName": "ls_l1_d_tlb_miss.tlb_reload_1g_l2_hit",
+    "EventCode": "0x45",
+    "BriefDescription": "L1 DTLB Reload of a page of 1G size.",
+    "PublicDescription": "L1 DTLB Reload of a page of 1G size.",
+    "UMask": "0x8"
+  },
+  {
+    "EventName": "ls_l1_d_tlb_miss.tlb_reload_2m_l2_hit",
+    "EventCode": "0x45",
+    "BriefDescription": "L1 DTLB Reload of a page of 2M size.",
+    "PublicDescription": "L1 DTLB Reload of a page of 2M size.",
+    "UMask": "0x4"
+  },
+  {
+    "EventName": "ls_l1_d_tlb_miss.tlb_reload_32k_l2_hit",
+    "EventCode": "0x45",
+    "BriefDescription": "L1 DTLB Reload of a page of 32K size.",
+    "PublicDescription": "L1 DTLB Reload of a page of 32K size.",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "ls_l1_d_tlb_miss.tlb_reload_4k_l2_hit",
+    "EventCode": "0x45",
+    "BriefDescription": "L1 DTLB Reload of a page of 4K size.",
+    "PublicDescription": "L1 DTLB Reload of a page of 4K size.",
+    "UMask": "0x1"
+  },
+  {
+    "EventName": "ls_tablewalker.perf_mon_tablewalk_alloc_iside",
+    "EventCode": "0x46",
+    "BriefDescription": "Tablewalker allocation.",
+    "PublicDescription": "Tablewalker allocation.",
+    "UMask": "0xc"
+  },
+  {
+    "EventName": "ls_tablewalker.perf_mon_tablewalk_alloc_dside",
+    "EventCode": "0x46",
+    "BriefDescription": "Tablewalker allocation.",
+    "PublicDescription": "Tablewalker allocation.",
+    "UMask": "0x3"
+  },
+  {
+    "EventName": "ls_misal_accesses",
+    "EventCode": "0x47",
+    "BriefDescription": "Misaligned loads."
+  },
+  {
+    "EventName": "ls_pref_instr_disp.prefetch_nta",
+    "EventCode": "0x4b",
+    "BriefDescription": "Software Prefetch Instructions (PREFETCHNTA instruction) Dispatched.",
+    "PublicDescription": "Software Prefetch Instructions (PREFETCHNTA instruction) Dispatched.",
+    "UMask": "0x4"
+  },
+  {
+    "EventName": "ls_pref_instr_disp.store_prefetch_w",
+    "EventCode": "0x4b",
+    "BriefDescription": "Software Prefetch Instructions (3DNow PREFETCHW instruction) Dispatched.",
+    "PublicDescription": "Software Prefetch Instructions (3DNow PREFETCHW instruction) Dispatched.",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "ls_pref_instr_disp.load_prefetch_w",
+    "EventCode": "0x4b",
+    "BriefDescription": "Prefetch, Prefetch_T0_T1_T2.",
+    "PublicDescription": "Software Prefetch Instructions Dispatched. Prefetch, Prefetch_T0_T1_T2.",
+    "UMask": "0x1"
+  },
+  {
+    "EventName": "ls_inef_sw_pref.mab_mch_cnt",
+    "EventCode": "0x52",
+    "BriefDescription": "The number of software prefetches that did not fetch data outside of the processor core.",
+    "PublicDescription": "The number of software prefetches that did not fetch data outside of the processor core.",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "ls_inef_sw_pref.data_pipe_sw_pf_dc_hit",
+    "EventCode": "0x52",
+    "BriefDescription": "The number of software prefetches that did not fetch data outside of the processor core.",
+    "PublicDescription": "The number of software prefetches that did not fetch data outside of the processor core.",
+    "UMask": "0x1"
+  },
+  {
+    "EventName": "ls_not_halted_cyc",
+    "EventCode": "0x76",
+    "BriefDescription": "Cycles not in Halt."
+  }
+]
diff --git a/tools/perf/pmu-events/arch/x86/amdzen1/other.json b/tools/perf/pmu-events/arch/x86/amdzen1/other.json
new file mode 100644
index 0000000..b26a00d
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/amdzen1/other.json
@@ -0,0 +1,65 @@
+[
+  {
+    "EventName": "ic_oc_mode_switch.oc_ic_mode_switch",
+    "EventCode": "0x28a",
+    "BriefDescription": "OC to IC mode switch.",
+    "PublicDescription": "OC Mode Switch. OC to IC mode switch.",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "ic_oc_mode_switch.ic_oc_mode_switch",
+    "EventCode": "0x28a",
+    "BriefDescription": "IC to OC mode switch.",
+    "PublicDescription": "OC Mode Switch. IC to OC mode switch.",
+    "UMask": "0x1"
+  },
+  {
+    "EventName": "de_dis_dispatch_token_stalls0.retire_token_stall",
+    "EventCode": "0xaf",
+    "BriefDescription": "RETIRE Tokens unavailable.",
+    "PublicDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall. RETIRE Tokens unavailable.",
+    "UMask": "0x40"
+  },
+  {
+    "EventName": "de_dis_dispatch_token_stalls0.agsq_token_stall",
+    "EventCode": "0xaf",
+    "BriefDescription": "AGSQ Tokens unavailable.",
+    "PublicDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall. AGSQ Tokens unavailable.",
+    "UMask": "0x20"
+  },
+  {
+    "EventName": "de_dis_dispatch_token_stalls0.alu_token_stall",
+    "EventCode": "0xaf",
+    "BriefDescription": "ALU tokens total unavailable.",
+    "PublicDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall. ALU tokens total unavailable.",
+    "UMask": "0x10"
+  },
+  {
+    "EventName": "de_dis_dispatch_token_stalls0.alsq3_0_token_stall",
+    "EventCode": "0xaf",
+    "BriefDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall.",
+    "PublicDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall.",
+    "UMask": "0x8"
+  },
+  {
+    "EventName": "de_dis_dispatch_token_stalls0.alsq3_token_stall",
+    "EventCode": "0xaf",
+    "BriefDescription": "ALSQ 3 Tokens unavailable.",
+    "PublicDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall. ALSQ 3 Tokens unavailable.",
+    "UMask": "0x4"
+  },
+  {
+    "EventName": "de_dis_dispatch_token_stalls0.alsq2_token_stall",
+    "EventCode": "0xaf",
+    "BriefDescription": "ALSQ 2 Tokens unavailable.",
+    "PublicDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall. ALSQ 2 Tokens unavailable.",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "de_dis_dispatch_token_stalls0.alsq1_token_stall",
+    "EventCode": "0xaf",
+    "BriefDescription": "ALSQ 1 Tokens unavailable.",
+    "PublicDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall. ALSQ 1 Tokens unavailable.",
+    "UMask": "0x1"
+  }
+]
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
index 745ced0..82a9db0 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -36,4 +36,4 @@ GenuineIntel-6-55-[56789ABCDEF],v1,cascadelakex,core
 GenuineIntel-6-7D,v1,icelake,core
 GenuineIntel-6-7E,v1,icelake,core
 GenuineIntel-6-86,v1,tremontx,core
-AuthenticAMD-23-[[:xdigit:]]+,v1,amdfam17h,core
+AuthenticAMD-23-([12][0-9A-F]|[0-9A-F]),v1,amdzen1,core
