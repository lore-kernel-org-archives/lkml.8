Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 413DEC3F2D3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 17:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0811D246AE
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 17:57:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b="XGM0SlB1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgB1R4z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 12:56:55 -0500
Received: from st43p00im-zteg10061901.me.com ([17.58.63.168]:41083 "EHLO
        st43p00im-zteg10061901.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726682AbgB1R4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 12:56:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1582912611; bh=ZKoA6Yjx1/Z+dP0GflEWyOEusd014cleJBs+zpX6blg=;
        h=From:To:Subject:Date:Message-Id;
        b=XGM0SlB1h9vh3oSJ4/ZZYIbFnP9aoV/q9vrGwXk2DF+Bb9CiMkeLQeS7h2UxckjwY
         25filGzCSr5Enn651g1lQvuUY7bSLgMfZvW3M8rfKJd1rD+raG4nOwB+mMONwvlmRs
         a2qBdLEKmt2oRotY3xen/+lRhZZ6E2F7j+ha3MoVTEmB74NMQ63BITxvPhNXhPtyPk
         g9FtfyiMf1NcZNcq2lRFfpE78cfBRqVGS8qXGaFSLoMavznBoWUVXhtwsw1Scs9yeD
         b+ZtBsrp0Q4rbxOY/BQ428Xw2bUzP0VAtyv6s2xzpa4uyWnFh3YelEJz3TXf77PDZd
         o4I0/HbiZf91g==
Received: from shwetrath.localdomain (unknown [66.199.8.131])
        by st43p00im-zteg10061901.me.com (Postfix) with ESMTPSA id 3DDC68603AE;
        Fri, 28 Feb 2020 17:56:51 +0000 (UTC)
From:   Vijay Thakkar <vijaythakkar@me.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Vijay Thakkar <vijaythakkar@me.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        =?UTF-8?q?Martin=20Li=C5=A1ka?= <mliska@suse.cz>,
        Jon Grimm <jon.grimm@amd.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH v3 3/3] perf vendor events amd: update Zen1 events to V2
Date:   Fri, 28 Feb 2020 12:56:39 -0500
Message-Id: <20200228175639.39171-4-vijaythakkar@me.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200228175639.39171-1-vijaythakkar@me.com>
References: <20200228175639.39171-1-vijaythakkar@me.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2020-02-28_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-2002280135
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch updates the PMCs for AMD Zen1 core based processors (Family
17h; Models 0 through 2F) to be in accordance with PMCs as
documented in the latest versions of the AMD Processor Programming
Reference [1], [2] and [3]. Note that some events, such as FPU pipe
assignment are missing in [1], and therefore [3] is included for full
coverage of events.

PMCs added:
fpu_pipe_assignment.dual{0|1|2|3}
fpu_pipe_assignment.total{0|1|2|3}
ls_mab_alloc.dc_prefetcher
ls_mab_alloc.stores
ls_mab_alloc.loads
bp_dyn_ind_pred
bp_de_redirect

PMC removed:
ex_ret_cond_misp

Cumulative counts, fpu_pipe_assignment.total and
fpu_pipe_assignment.dual, existed in v1, but did expose port-level
counters.

ex_ret_cond_misp has been removed as it has been removed from the latest
versions of the PPR, and when tested, always seems to sample zero as
tested on a Ryzen 3400G system.

[1]: Processor Programming Reference (PPR) for AMD Family 17h Models
01h,08h, Revision B2 Processors, 54945 Rev 3.03 - Jun 14, 2019.
[2]: Processor Programming Reference (PPR) for AMD Family 17h Model 18h,
Revision B1 Processors, 55570-B1 Rev 3.14 - Sep 26, 2019.
[3]: OSRR for AMD Family 17h processors, Models 00h-2Fh, 56255 Rev 3.03 - July, 2018
All of the PPRs can be found at:
https://bugzilla.kernel.org/show_bug.cgi?id=206537

Signed-off-by: Vijay Thakkar <vijaythakkar@me.com>

---
Changes in v2:
    - Correct the UMasks for fpu_pipe_assignment.dual* by left shifting
    all by 4 bits.
    - Correct UMask for ls_mab_alloc.loads
    - add bp_dyn_ind_pred (PMC0x08E)
    - add bp_de_redirect  (PMC0x091)
Changes in v3:
    - Correct the pipe numbers for fpu_pipe_assignment counters
    - Correct ls_mab_alloc.* public descriptions

 .../pmu-events/arch/x86/amdzen1/branch.json   | 11 ++++
 .../pmu-events/arch/x86/amdzen1/core.json     |  5 --
 .../arch/x86/amdzen1/floating-point.json      | 60 ++++++++++++++++++-
 .../pmu-events/arch/x86/amdzen1/memory.json   | 18 ++++++
 tools/perf/pmu-events/arch/x86/mapfile.csv    |  2 +-
 5 files changed, 88 insertions(+), 8 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/amdzen1/branch.json b/tools/perf/pmu-events/arch/x86/amdzen1/branch.json
index 93ddfd8053ca..a9943eeb8d6b 100644
--- a/tools/perf/pmu-events/arch/x86/amdzen1/branch.json
+++ b/tools/perf/pmu-events/arch/x86/amdzen1/branch.json
@@ -8,5 +8,16 @@
     "EventName": "bp_l2_btb_correct",
     "EventCode": "0x8b",
     "BriefDescription": "L2 BTB Correction."
+  },
+  {
+    "EventName": "bp_dyn_ind_pred",
+    "EventCode": "0x8e",
+    "BriefDescription": "Dynamic Indirect Predictions.",
+    "PublicDescription": "Indirect Branch Prediction for potential multi-target branch (speculative)."
+  },
+  {
+    "EventName": "bp_de_redirect",
+    "EventCode": "0x91",
+    "BriefDescription": "Decoder Overrides Existing Branch Prediction (speculative)."
   }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/amdzen1/core.json b/tools/perf/pmu-events/arch/x86/amdzen1/core.json
index 1079544eeed5..38994fb4b625 100644
--- a/tools/perf/pmu-events/arch/x86/amdzen1/core.json
+++ b/tools/perf/pmu-events/arch/x86/amdzen1/core.json
@@ -90,11 +90,6 @@
     "EventCode": "0xd1",
     "BriefDescription": "Retired Conditional Branch Instructions."
   },
-  {
-    "EventName": "ex_ret_cond_misp",
-    "EventCode": "0xd2",
-    "BriefDescription": "Retired Conditional Branch Instructions Mispredicted."
-  },
   {
     "EventName": "ex_div_busy",
     "EventCode": "0xd3",
diff --git a/tools/perf/pmu-events/arch/x86/amdzen1/floating-point.json b/tools/perf/pmu-events/arch/x86/amdzen1/floating-point.json
index ea4711983d1d..e026f8ebab8f 100644
--- a/tools/perf/pmu-events/arch/x86/amdzen1/floating-point.json
+++ b/tools/perf/pmu-events/arch/x86/amdzen1/floating-point.json
@@ -3,16 +3,72 @@
     "EventName": "fpu_pipe_assignment.dual",
     "EventCode": "0x00",
     "BriefDescription": "Total number multi-pipe uOps.",
-    "PublicDescription": "The number of operations (uOps) and dual-pipe uOps dispatched to each of the 4 FPU execution pipelines. This event reflects how busy the FPU pipelines are and may be used for workload characterization. This includes all operations performed by x87, MMX, and SSE instructions, including moves. Each increment represents a one- cycle dispatch event. This event is a speculative event. Since this event includes non-numeric operations it is not suitable for measuring MFLOPS. Total number multi-pipe uOps assigned to Pipe 3.",
+    "PublicDescription": "The number of operations (uOps) and dual-pipe uOps dispatched to each of the 4 FPU execution pipelines. This event reflects how busy the FPU pipelines are and may be used for workload characterization. This includes all operations performed by x87, MMX, and SSE instructions, including moves. Each increment represents a one- cycle dispatch event. This event is a speculative event. Since this event includes non-numeric operations it is not suitable for measuring MFLOPS. Total number multi-pipe uOps assigned to all pipes.",
     "UMask": "0xf0"
   },
+  {
+    "EventName": "fpu_pipe_assignment.dual3",
+    "EventCode": "0x00",
+    "BriefDescription": "Total number multi-pipe uOps to pipe 3.",
+    "PublicDescription": "The number of operations (uOps) and dual-pipe uOps dispatched to each of the 4 FPU execution pipelines. This event reflects how busy the FPU pipelines are and may be used for workload characterization. This includes all operations performed by x87, MMX, and SSE instructions, including moves. Each increment represents a one- cycle dispatch event. This event is a speculative event. Since this event includes non-numeric operations it is not suitable for measuring MFLOPS. Total number multi-pipe uOps assigned to pipe 3.",
+    "UMask": "0x80"
+  },
+  {
+    "EventName": "fpu_pipe_assignment.dual2",
+    "EventCode": "0x00",
+    "BriefDescription": "Total number multi-pipe uOps to pipe 2.",
+    "PublicDescription": "The number of operations (uOps) and dual-pipe uOps dispatched to each of the 4 FPU execution pipelines. This event reflects how busy the FPU pipelines are and may be used for workload characterization. This includes all operations performed by x87, MMX, and SSE instructions, including moves. Each increment represents a one- cycle dispatch event. This event is a speculative event. Since this event includes non-numeric operations it is not suitable for measuring MFLOPS. Total number multi-pipe uOps assigned to pipe 2.",
+    "UMask": "0x40"
+  },
+  {
+    "EventName": "fpu_pipe_assignment.dual1",
+    "EventCode": "0x00",
+    "BriefDescription": "Total number multi-pipe uOps to pipe 1.",
+    "PublicDescription": "The number of operations (uOps) and dual-pipe uOps dispatched to each of the 4 FPU execution pipelines. This event reflects how busy the FPU pipelines are and may be used for workload characterization. This includes all operations performed by x87, MMX, and SSE instructions, including moves. Each increment represents a one- cycle dispatch event. This event is a speculative event. Since this event includes non-numeric operations it is not suitable for measuring MFLOPS. Total number multi-pipe uOps assigned to pipe 1.",
+    "UMask": "0x20"
+  },
+  {
+    "EventName": "fpu_pipe_assignment.dual0",
+    "EventCode": "0x00",
+    "BriefDescription": "Total number multi-pipe uOps to pipe 0.",
+    "PublicDescription": "The number of operations (uOps) and dual-pipe uOps dispatched to each of the 4 FPU execution pipelines. This event reflects how busy the FPU pipelines are and may be used for workload characterization. This includes all operations performed by x87, MMX, and SSE instructions, including moves. Each increment represents a one- cycle dispatch event. This event is a speculative event. Since this event includes non-numeric operations it is not suitable for measuring MFLOPS. Total number multi-pipe uOps assigned to pipe 0.",
+    "UMask": "0x10"
+  },
   {
     "EventName": "fpu_pipe_assignment.total",
     "EventCode": "0x00",
     "BriefDescription": "Total number uOps.",
-    "PublicDescription": "The number of operations (uOps) and dual-pipe uOps dispatched to each of the 4 FPU execution pipelines. This event reflects how busy the FPU pipelines are and may be used for workload characterization. This includes all operations performed by x87, MMX, and SSE instructions, including moves. Each increment represents a one- cycle dispatch event. This event is a speculative event. Since this event includes non-numeric operations it is not suitable for measuring MFLOPS. Total number uOps assigned to Pipe 3.",
+    "PublicDescription": "The number of operations (uOps) and dual-pipe uOps dispatched to each of the 4 FPU execution pipelines. This event reflects how busy the FPU pipelines are and may be used for workload characterization. This includes all operations performed by x87, MMX, and SSE instructions, including moves. Each increment represents a one- cycle dispatch event. This event is a speculative event. Since this event includes non-numeric operations it is not suitable for measuring MFLOPS. Total number uOps assigned to all pipes.",
     "UMask": "0xf"
   },
+  {
+    "EventName": "fpu_pipe_assignment.total3",
+    "EventCode": "0x00",
+    "BriefDescription": "Total number of fp uOps on pipe 3.",
+    "PublicDescription": "The number of operations (uOps) dispatched to each of the 4 FPU execution pipelines. This event reflects how busy the FPU pipelines are and may be used for workload characterization. This includes all operations performed by x87, MMX, and SSE instructions, including moves. Each increment represents a one-cycle dispatch event. This event is a speculative event. Since this event includes non-numeric operations it is not suitable for measuring MFLOPS. Total number uOps assigned to pipe 3.",
+    "UMask": "0x8"
+  },
+  {
+    "EventName": "fpu_pipe_assignment.total2",
+    "EventCode": "0x00",
+    "BriefDescription": "Total number of fp uOps on pipe 2.",
+    "PublicDescription": "The number of operations (uOps) dispatched to each of the 4 FPU execution pipelines. This event reflects how busy the FPU pipelines are and may be used for workload characterization. This includes all operations performed by x87, MMX, and SSE instructions, including moves. Each increment represents a one- cycle dispatch event. This event is a speculative event. Since this event includes non-numeric operations it is not suitable for measuring MFLOPS. Total number uOps assigned to pipe 2.",
+    "UMask": "0x4"
+  },
+  {
+    "EventName": "fpu_pipe_assignment.total1",
+    "EventCode": "0x00",
+    "BriefDescription": "Total number of fp uOps on pipe 1.",
+    "PublicDescription": "The number of operations (uOps) dispatched to each of the 4 FPU execution pipelines. This event reflects how busy the FPU pipelines are and may be used for workload characterization. This includes all operations performed by x87, MMX, and SSE instructions, including moves. Each increment represents a one- cycle dispatch event. This event is a speculative event. Since this event includes non-numeric operations it is not suitable for measuring MFLOPS. Total number uOps assigned to pipe 1.",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "fpu_pipe_assignment.total0",
+    "EventCode": "0x00",
+    "BriefDescription": "Total number of fp uOps  on pipe 0.",
+    "PublicDescription": "The number of operations (uOps) dispatched to each of the 4 FPU execution pipelines. This event reflects how busy the FPU pipelines are and may be used for workload characterization. This includes all operations performed by x87, MMX, and SSE instructions, including moves. Each increment represents a one- cycle dispatch event. This event is a speculative event. Since this event includes non-numeric operations it is not suitable for measuring MFLOPS. Total number uOps assigned to pipe 0.",
+    "UMask": "0x1"
+  },
   {
     "EventName": "fp_sched_empty",
     "EventCode": "0x01",
diff --git a/tools/perf/pmu-events/arch/x86/amdzen1/memory.json b/tools/perf/pmu-events/arch/x86/amdzen1/memory.json
index fa2d60d4def0..9f9c087007d2 100644
--- a/tools/perf/pmu-events/arch/x86/amdzen1/memory.json
+++ b/tools/perf/pmu-events/arch/x86/amdzen1/memory.json
@@ -37,6 +37,24 @@
     "EventCode": "0x40",
     "BriefDescription": "The number of accesses to the data cache for load and store references. This may include certain microcode scratchpad accesses, although these are generally rare. Each increment represents an eight-byte access, although the instruction may only be accessing a portion of that. This event is a speculative event."
   },
+  {
+    "EventName": "ls_mab_alloc.dc_prefetcher",
+    "EventCode": "0x41",
+    "BriefDescription": "LS MAB allocates by type - DC prefetcher.",
+    "UMask": "0x8"
+  },
+  {
+    "EventName": "ls_mab_alloc.stores",
+    "EventCode": "0x41",
+    "BriefDescription": "LS MAB allocates by type - stores.",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "ls_mab_alloc.loads",
+    "EventCode": "0x41",
+    "BriefDescription": "LS MAB allocates by type - loads.",
+    "UMask": "0x01"
+  },
   {
     "EventName": "ls_l1_d_tlb_miss.all",
     "EventCode": "0x45",
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
index 244a36e37a3a..25b06cf98747 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -36,5 +36,5 @@ GenuineIntel-6-55-[56789ABCDEF],v1,cascadelakex,core
 GenuineIntel-6-7D,v1,icelake,core
 GenuineIntel-6-7E,v1,icelake,core
 GenuineIntel-6-86,v1,tremontx,core
-AuthenticAMD-23-([12][0-9A-F]|[0-9A-F]),v1,amdzen1,core
+AuthenticAMD-23-([12][0-9A-F]|[0-9A-F]),v2,amdzen1,core
 AuthenticAMD-23-[[:xdigit:]]+,v1,amdzen2,core
-- 
2.25.1

