Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F152C2BA16
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 08:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFFBD214D8
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 08:41:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbgDDIly (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 04:41:54 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41444 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbgDDIlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 04:41:52 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jKeN4-0000vw-4i; Sat, 04 Apr 2020 10:41:42 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id C32F31C0243;
        Sat,  4 Apr 2020 10:41:41 +0200 (CEST)
Date:   Sat, 04 Apr 2020 08:41:41 -0000
From:   "tip-bot2 for Adrian Hunter" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf events parser: Add missing Intel CPU events to parser
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <90c7ae07-c568-b6d3-f9c4-d0c1528a0610@intel.com>
References: <90c7ae07-c568-b6d3-f9c4-d0c1528a0610@intel.com>
MIME-Version: 1.0
Message-ID: <158598970145.28353.6935701404911756450.tip-bot2@tip-bot2>
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

Commit-ID:     47327f56674d69a423f7167f8d4ea537cc1762cc
Gitweb:        https://git.kernel.org/tip/47327f56674d69a423f7167f8d4ea537cc1762cc
Author:        Adrian Hunter <adrian.hunter@intel.com>
AuthorDate:    Thu, 26 Mar 2020 10:01:47 +02:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Fri, 03 Apr 2020 09:37:56 -03:00

perf events parser: Add missing Intel CPU events to parser

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

This happens because the parser splits names by '-' in order to deal
with cache events. For example 'L1-dcache' is a token in
parse-events.l which is matched to 'L1-dcache-load-miss' by the
following rule:

    PE_NAME_CACHE_TYPE '-' PE_NAME_CACHE_OP_RESULT '-' PE_NAME_CACHE_OP_RESULT opt_event_config

And so there is special handling for 2-part PMU names i.e.

    PE_PMU_EVENT_PRE '-' PE_PMU_EVENT_SUF sep_dc

but no handling for 3-part names, which are instead added as tokens e.g.

    topdown-[a-z-]+

While it would be possible to add a rule for 3-part names, that would
not work if the first parts were also a valid PMU name e.g.
'el-capacity-read' would be matched to 'el-capacity' before the parser
reached the 3rd part.

The parser would need significant change to rationalize all this, so
instead fix for now by adding missing Intel CPU events with 3-part names
to the event parser as tokens.

Missing events were found by using:

    grep -r EVENT_ATTR_STR arch/x86/events/intel/core.c

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Link: http://lore.kernel.org/lkml/90c7ae07-c568-b6d3-f9c4-d0c1528a0610@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/parse-events.l | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
index 7b1c8ee..baa48f2 100644
--- a/tools/perf/util/parse-events.l
+++ b/tools/perf/util/parse-events.l
@@ -342,11 +342,13 @@ bpf-output					{ return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_BPF_OUT
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
+tx-capacity-[a-z-]+			|
+el-capacity-[a-z-]+			{ return str(yyscanner, PE_KERNEL_PMU_EVENT); }
 
 L1-dcache|l1-d|l1d|L1-data		|
 L1-icache|l1-i|l1i|L1-instruction	|
