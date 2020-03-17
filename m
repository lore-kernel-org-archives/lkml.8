Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52692C5ACD7
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 21:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EF952073E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 21:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584480849;
	bh=evBdlCEE86lti4WZPTJ6+vB7aYt3/vRIW7pFjOpsR+Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gPIkFcV+Q+lTiEjm1b2bBB+KLbPq5UYWQX/ldXo6Zau5Sgs1TxkOqo7lQagOZK6ZV
	 09f6w+ECh8492HFr8lVYvCL6Myp2ojQNqihsknm3MwT2VJ8/l4qAi9NtJpr/08Leth
	 t4ECX8thWvm53JQIT7ZTkqyWrYG1v20wvj+5JYHY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbgCQVeH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 17:34:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:53004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726980AbgCQVeG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 17:34:06 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C35A2076A;
        Tue, 17 Mar 2020 21:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584480845;
        bh=evBdlCEE86lti4WZPTJ6+vB7aYt3/vRIW7pFjOpsR+Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0RSgQrQmFJySw1P7FIjG0kyv82P98w/RqMhTBp0BJcL2mOpopEw3Zc3l927+yAmiU
         IjKgEKetaj0F+GtqiFi7/QWwl2735Lfycj2nmlCRi52iv10/rawGzjf0Tvagp+Bif0
         KgsP3WtboElPA06LCOZOAVdvIRUOf53ZJASXqR4w=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>
Subject: [PATCH 15/23] perf intel-pt: Rename intel-pt.txt and put it in man page format
Date:   Tue, 17 Mar 2020 18:32:51 -0300
Message-Id: <20200317213259.15494-16-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200317213259.15494-1-acme@kernel.org>
References: <20200317213259.15494-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Make the Intel PT documentation into a man page.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lore.kernel.org/lkml/20200311122034.3697-2-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../{intel-pt.txt => perf-intel-pt.txt}       | 57 +++++++++++--------
 1 file changed, 33 insertions(+), 24 deletions(-)
 rename tools/perf/Documentation/{intel-pt.txt => perf-intel-pt.txt} (98%)

diff --git a/tools/perf/Documentation/intel-pt.txt b/tools/perf/Documentation/perf-intel-pt.txt
similarity index 98%
rename from tools/perf/Documentation/intel-pt.txt
rename to tools/perf/Documentation/perf-intel-pt.txt
index 2cf2d9e9d0da..7d743a98a9c1 100644
--- a/tools/perf/Documentation/intel-pt.txt
+++ b/tools/perf/Documentation/perf-intel-pt.txt
@@ -1,8 +1,17 @@
-Intel Processor Trace
-=====================
+perf-intel-pt(1)
+================
 
-Overview
-========
+NAME
+----
+perf-intel-pt - Support for Intel Processor Trace within perf tools
+
+SYNOPSIS
+--------
+[verse]
+'perf record' -e intel_pt//
+
+DESCRIPTION
+-----------
 
 Intel Processor Trace (Intel PT) is an extension of Intel Architecture that
 collects information about software execution such as control flow, execution
@@ -43,7 +52,7 @@ vary depending on the use-case and architecture.
 
 
 Quickstart
-==========
+----------
 
 It is important to start small.  That is because it is easy to capture vastly
 more data than can possibly be processed.
@@ -156,10 +165,10 @@ for more details.
 
 
 perf record
-===========
+-----------
 
 new event
----------
+~~~~~~~~~
 
 The Intel PT kernel driver creates a new PMU for Intel PT.  PMU events are
 selected by providing the PMU name followed by the "config" separated by slashes.
@@ -245,7 +254,7 @@ perf_event_attr is displayed if the -vv option is used e.g.
 
 
 config terms
-------------
+~~~~~~~~~~~~
 
 The June 2015 version of Intel 64 and IA-32 Architectures Software Developer
 Manuals, Chapter 36 Intel Processor Trace, defined new Intel PT features.
@@ -435,7 +444,7 @@ pwr_evt		Enable power events.  The power events provide information about
 
 
 AUX area sampling option
-------------------------
+~~~~~~~~~~~~~~~~~~~~~~~~
 
 To select Intel PT "sampling" the AUX area sampling option can be used:
 
@@ -485,7 +494,7 @@ but the tool validates that the sample size is not greater than 60KiB.
 
 
 new snapshot option
--------------------
+~~~~~~~~~~~~~~~~~~~
 
 The difference between full trace and snapshot from the kernel's perspective is
 that in full trace we don't overwrite trace data that the user hasn't collected
@@ -514,7 +523,7 @@ The snapshot size is displayed if the option -vv is used e.g.
 
 
 new auxtrace mmap size option
----------------------------
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 Intel PT buffer size is specified by an addition to the -m option e.g.
 
@@ -547,7 +556,7 @@ The mmap size and auxtrace mmap size are displayed if the -vv option is used e.g
 
 
 Intel PT modes of operation
----------------------------
+~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 Intel PT can be used in 2 modes:
 	full-trace mode
@@ -577,7 +586,7 @@ The 2 modes cannot be used together.
 
 
 Buffer handling
----------------
+~~~~~~~~~~~~~~~
 
 There may be buffer limitations (i.e. single ToPa entry) which means that actual
 buffer sizes are limited to powers of 2 up to 4MiB (MAX_ORDER).  In order to
@@ -601,7 +610,7 @@ data.
 
 
 Intel PT and build ids
-----------------------
+~~~~~~~~~~~~~~~~~~~~~~
 
 By default "perf record" post-processes the event stream to find all build ids
 for executables for all addresses sampled.  Deliberately, Intel PT is not
@@ -619,7 +628,7 @@ If the perf.data file contains Intel PT data, that is the same as:
 
 
 Snapshot mode and event disabling
----------------------------------
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 In order to make a snapshot, the intel_pt event is disabled using an IOCTL,
 namely PERF_EVENT_IOC_DISABLE.  However doing that can also disable the
@@ -642,7 +651,7 @@ To run the test:
 
 
 perf record modes (nothing new here)
-------------------------------------
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 perf record essentially operates in one of three modes:
 	per thread
@@ -668,7 +677,7 @@ mode by using the --per-thread option.
 
 
 Privileged vs non-privileged users
-----------------------------------
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 Unless /proc/sys/kernel/perf_event_paranoid is set to -1, unprivileged users
 have memory limits imposed upon them.  That affects what buffer sizes they can
@@ -697,7 +706,7 @@ be possible to decode Intel PT in per-cpu mode.
 
 
 sched_switch tracepoint
------------------------
+~~~~~~~~~~~~~~~~~~~~~~~
 
 The sched_switch tracepoint is used to provide side-band data for Intel PT
 decoding in kernels where the PERF_RECORD_SWITCH metadata event isn't
@@ -783,14 +792,14 @@ cannot be matched against the Intel PT trace.
 
 
 perf script
-===========
+-----------
 
 By default, perf script will decode trace data found in the perf.data file.
 This can be further controlled by new option --itrace.
 
 
 New --itrace option
--------------------
+~~~~~~~~~~~~~~~~~~~
 
 Having no option is the same as
 
@@ -913,7 +922,7 @@ at the beginning. This is useful to ignore initialization code.
 skips the first million instructions.
 
 dump option
------------
+~~~~~~~~~~~
 
 perf script has an option (-D) to "dump" the events i.e. display the binary
 data.
@@ -931,7 +940,7 @@ To disable the display of Intel PT packets, combine the -D option with
 
 
 perf report
-===========
+-----------
 
 By default, perf report will decode trace data found in the perf.data file.
 This can be further controlled by new option --itrace exactly the same as
@@ -939,7 +948,7 @@ perf script, with the exception that the default is --itrace=igxe.
 
 
 perf inject
-===========
+-----------
 
 perf inject also accepts the --itrace option in which case tracing data is
 removed and replaced with the synthesized events. e.g.
@@ -977,7 +986,7 @@ that may change in the future if greater use is made of the data.
 
 
 PEBS via Intel PT
-=================
+-----------------
 
 Some hardware has the feature to redirect PEBS records to the Intel PT trace.
 Recording is selected by using the aux-output config term e.g.
-- 
2.21.1

