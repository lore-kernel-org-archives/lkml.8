Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93FA1C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 08:02:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7478820714
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 08:02:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbgCZICb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 04:02:31 -0400
Received: from mga05.intel.com ([192.55.52.43]:62561 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726138AbgCZICa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 04:02:30 -0400
IronPort-SDR: crbeDrVIpMVW+XBg0CbRYYo9MazbkTpSF99koz07St7QZjAsvHqElEEXY3dQkdWcbBE+EX3AY1
 hOX7J2CqHdVA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2020 01:02:30 -0700
IronPort-SDR: kII/cpXO6x6V6bmPddu+ycZJglZJPs/FoeQV/VPfuDSj8ZCFw6MMdeQ0nnUlo/HH2ULesYzYkV
 0bDeXr49LkMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,307,1580803200"; 
   d="scan'208";a="271083532"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.87]) ([10.237.72.87])
  by fmsmga004.fm.intel.com with ESMTP; 26 Mar 2020 01:02:29 -0700
Subject: [PATCH V2] perf tools: Add missing Intel CPU events to parser
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        linux-kernel@vger.kernel.org, Kan Liang <kan.liang@intel.com>
References: <20200324150443.28832-1-adrian.hunter@intel.com>
 <20200325103345.GA1856035@krava> <20200325131549.GB14102@kernel.org>
 <20200325135350.GA1888042@krava> <20200325142214.GD14102@kernel.org>
 <ea516b26-6249-e870-20bf-819ea1a2d2c2@intel.com>
 <20200325152211.GA1908530@krava>
 <fc3c4dee-981e-4c39-566a-4163ee0bcc02@intel.com>
 <20200325174449.GB1934048@krava>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <90c7ae07-c568-b6d3-f9c4-d0c1528a0610@intel.com>
Date:   Thu, 26 Mar 2020 10:01:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200325174449.GB1934048@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
---


Changes in V2:

	Add only 3-part names
	Clarify commit message


 tools/perf/util/parse-events.l | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
index 7b1c8ee537cf..baa48f28d57d 100644
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
-- 
2.17.1


