Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD7C3C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 15:20:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E9752065D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 15:20:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbgGJPTx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 11:19:53 -0400
Received: from mga09.intel.com ([134.134.136.24]:38307 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727910AbgGJPMK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 11:12:10 -0400
IronPort-SDR: l2N3vigUWRBl6eG4Enjt5cOsUFMCorp2Q7NlkYM+b3yLZ/OHz28+T45pXB3i3KgXnH9pcGhsOb
 Eaq9RanB144A==
X-IronPort-AV: E=McAfee;i="6000,8403,9678"; a="149686466"
X-IronPort-AV: E=Sophos;i="5.75,336,1589266800"; 
   d="scan'208";a="149686466"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2020 08:12:10 -0700
IronPort-SDR: SVs3RUzcXiYwAPFPqajKfW1FT8riFfuLVwr2IOzYEPUzsfK0ay7kHea8tubB3KTUE2fB6OuBhc
 kaMiO8ojd30w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,336,1589266800"; 
   d="scan'208";a="484675572"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.73])
  by fmsmga005.fm.intel.com with ESMTP; 10 Jul 2020 08:12:08 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 12/12] perf intel-pt: Add support for decoding PSB+ only
Date:   Fri, 10 Jul 2020 18:11:04 +0300
Message-Id: <20200710151104.15137-13-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200710151104.15137-1-adrian.hunter@intel.com>
References: <20200710151104.15137-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A single q option decodes ip from only FUP/TIP packets. Make it so that
repeating the q option (i.e. qq) decodes only PSB+, getting ip if there is
a FUP packet within PSB+ (i.e. between PSB and PSBEND).

Example:

 $ perf record -e intel_pt//u grep -rI pudding drivers
 [ perf record: Woken up 52 times to write data ]
 [ perf record: Captured and wrote 57.870 MB perf.data ]
 $ time perf script --itrace=bi | wc -l
 58948289

 real    1m23.863s
 user    1m23.251s
 sys     0m7.452s
 $ time perf script --itrace=biq | wc -l
 3385694

 real    0m4.453s
 user    0m4.455s
 sys     0m0.328s
 $ time perf script --itrace=biqq | wc -l
 1883

 real    0m0.047s
 user    0m0.043s
 sys     0m0.009s

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/Documentation/perf-intel-pt.txt     | 15 +++++++++++++++
 .../util/intel-pt-decoder/intel-pt-decoder.c   | 18 ++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/tools/perf/Documentation/perf-intel-pt.txt b/tools/perf/Documentation/perf-intel-pt.txt
index f9fe4a4040ba..d5a266d7f15b 100644
--- a/tools/perf/Documentation/perf-intel-pt.txt
+++ b/tools/perf/Documentation/perf-intel-pt.txt
@@ -999,6 +999,21 @@ What *will* be decoded with the (single) q option:
 Note the q option does not specify what events will be synthesized e.g. the p
 option must be used also to show power events.
 
+Repeating the q option (double-q i.e. qq) results in even faster decoding and even
+less detail.  The decoder decodes only extended PSB (PSB+) packets, getting the
+instruction pointer if there is a FUP packet within PSB+ (i.e. between PSB and
+PSBEND).  Note PSB packets occur regularly in the trace based on the psb_period
+config term (refer config terms section).  There will be a FUP packet if the
+PSB+ occurs while control flow is being traced.
+
+What will *not* be decoded with the qq option:
+
+	- everything except instruction pointer associated with PSB packets
+
+What *will* be decoded with the qq option:
+
+	- instruction pointer associated with PSB packets
+
 
 dump option
 ~~~~~~~~~~~
diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
index ccb204b1a050..697513f35154 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
@@ -113,6 +113,7 @@ struct intel_pt_decoder {
 	bool in_psb;
 	bool hop;
 	bool hop_psb_fup;
+	bool leap;
 	enum intel_pt_param_flags flags;
 	uint64_t pos;
 	uint64_t last_ip;
@@ -240,6 +241,7 @@ struct intel_pt_decoder *intel_pt_decoder_new(struct intel_pt_params *params)
 	decoder->return_compression = params->return_compression;
 	decoder->branch_enable      = params->branch_enable;
 	decoder->hop                = params->quick >= 1;
+	decoder->leap               = params->quick >= 2;
 
 	decoder->flags              = params->flags;
 
@@ -1903,9 +1905,18 @@ static int intel_pt_resample(struct intel_pt_decoder *decoder)
 #define HOP_RETURN	2
 #define HOP_AGAIN	3
 
+static int intel_pt_scan_for_psb(struct intel_pt_decoder *decoder);
+
 /* Hop mode: Ignore TNT, do not walk code, but get ip from FUPs and TIPs */
 static int intel_pt_hop_trace(struct intel_pt_decoder *decoder, bool *no_tip, int *err)
 {
+	/* Leap from PSB to PSB, getting ip from FUP within PSB+ */
+	if (decoder->leap && !decoder->in_psb && decoder->packet.type != INTEL_PT_PSB) {
+		*err = intel_pt_scan_for_psb(decoder);
+		if (*err)
+			return HOP_RETURN;
+	}
+
 	switch (decoder->packet.type) {
 	case INTEL_PT_TNT:
 		return HOP_IGNORE;
@@ -2681,6 +2692,7 @@ static int intel_pt_sync(struct intel_pt_decoder *decoder)
 	decoder->ip = 0;
 	intel_pt_clear_stack(&decoder->stack);
 
+leap:
 	err = intel_pt_scan_for_psb(decoder);
 	if (err)
 		return err;
@@ -2702,6 +2714,12 @@ static int intel_pt_sync(struct intel_pt_decoder *decoder)
 			decoder->pkt_state = INTEL_PT_STATE_RESAMPLE;
 		else
 			decoder->pkt_state = INTEL_PT_STATE_IN_SYNC;
+	} else if (decoder->leap) {
+		/*
+		 * In leap mode, only PSB+ is decoded, so keeping leaping to the
+		 * next PSB until there is an ip.
+		 */
+		goto leap;
 	} else {
 		return intel_pt_sync_ip(decoder);
 	}
-- 
2.17.1

