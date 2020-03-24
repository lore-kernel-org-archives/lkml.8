Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F139C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 15:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55A4720788
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 15:05:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbgCXPF1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 11:05:27 -0400
Received: from mga12.intel.com ([192.55.52.136]:12689 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727385AbgCXPF1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 11:05:27 -0400
IronPort-SDR: Kkla0TiTvkB/k/s/h03etu3L7Lej9vj0brRjuSJ3VPyy0O1xMwigxU4PvPw4zK/LGKOCbMpyKm
 gnptkoyYkIjw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2020 08:05:26 -0700
IronPort-SDR: YI/iSHDbntR4SkhZ3Kmf+3rHCw4xOcJMp4VU+wYFmWaEgp7ZnsDDtfSQ7YaiFQZKiaFsX2ORZf
 zG+YBRtooeTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,300,1580803200"; 
   d="scan'208";a="393310990"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.87])
  by orsmga004.jf.intel.com with ESMTP; 24 Mar 2020 08:05:24 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] perf tools: Add missing Intel CPU events to parser
Date:   Tue, 24 Mar 2020 17:04:43 +0200
Message-Id: <20200324150443.28832-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

perf list expects CPU events to be parseable by name, e.g.

    # perf list | grep el-capacity-read
      el-capacity-read OR cpu/el-capacity-read/          [Kernel PMU event]

But the event parser does not recognize them that way, e.g.

    # perf test -v "Parse event"
    <SNIP>
    running test 54 'cycles//u'
    running test 55 'cycles:k'
    running test 0 'cpu/config=10,config1,config2=3,period=1000/u'
    running test 1 'cpu/config=1,name=krava/u,cpu/config=2/u'
    running test 2 'cpu/config=1,call-graph=fp,time,period=100000/,cpu/config=2,call-graph=no,time=0,period=2000/'
    running test 3 'cpu/name='COMPLEX_CYCLES_NAME:orig=cycles,desc=chip-clock-ticks',period=0x1,event=0x2/ukp'
    -> cpu/event=0,umask=0x11/
    -> cpu/event=0,umask=0x13/
    -> cpu/event=0x54,umask=0x1/
    failed to parse event 'el-capacity-read:u,cpu/event=el-capacity-read/u', err 1, str 'parser error'
    event syntax error: 'el-capacity-read:u,cpu/event=el-capacity-read/u'
                           \___ parser error test child finished with 1
    ---- end ----
    Parse event definition strings: FAILED!

Fix by adding missing Intel CPU events to the event parser.
Missing events were found by using:

    grep -r EVENT_ATTR_STR arch/x86/events/intel/core.c

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/parse-events.l | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
index 7b1c8ee537cf..a4012613cdcf 100644
--- a/tools/perf/util/parse-events.l
+++ b/tools/perf/util/parse-events.l
@@ -342,11 +342,25 @@ bpf-output					{ return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_BPF_OUT
 	 * Because the prefix cycles is mixed up with cpu-cycles.
 	 * loads and stores are mixed up with cache event
 	 */
-cycles-ct					{ return str(yyscanner, PE_KERNEL_PMU_EVENT); }
-cycles-t					{ return str(yyscanner, PE_KERNEL_PMU_EVENT); }
-mem-loads					{ return str(yyscanner, PE_KERNEL_PMU_EVENT); }
-mem-stores					{ return str(yyscanner, PE_KERNEL_PMU_EVENT); }
-topdown-[a-z-]+					{ return str(yyscanner, PE_KERNEL_PMU_EVENT); }
+cycles-ct				|
+cycles-t				|
+mem-loads				|
+mem-stores				|
+topdown-[a-z-]+				|
+tx-start				|
+tx-commit				|
+tx-abort				|
+tx-capacity				|
+tx-conflict				|
+el-start				|
+el-commit				|
+el-abort				|
+el-capacity				|
+el-conflict				|
+tx-capacity-read			|
+tx-capacity-write			|
+el-capacity-read			|
+el-capacity-write			{ return str(yyscanner, PE_KERNEL_PMU_EVENT); }
 
 L1-dcache|l1-d|l1d|L1-data		|
 L1-icache|l1-i|l1i|L1-instruction	|
-- 
2.17.1

