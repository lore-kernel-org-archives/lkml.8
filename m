Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1DE6C433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 17:37:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7B9F2078B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 17:37:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728560AbgGIRhh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 13:37:37 -0400
Received: from mga09.intel.com ([134.134.136.24]:35052 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728531AbgGIRha (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 13:37:30 -0400
IronPort-SDR: f8wgC0Eh3qPfBJAz56G7O2YRKVl3nrRwTn4edNQerCaFB0TWnNK+3Gub0u7qF7HQ1RFb/CAFKg
 0eN17RY6+hVA==
X-IronPort-AV: E=McAfee;i="6000,8403,9677"; a="149537130"
X-IronPort-AV: E=Sophos;i="5.75,332,1589266800"; 
   d="scan'208";a="149537130"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2020 10:37:30 -0700
IronPort-SDR: V0aYVo+4cve1aempC1eOPg4LH0aj2odu0qVxUKLv+FhgwUc/mxGb0jiJY6HJpBN5BRzTyCkd6x
 G6b2/dMjiEJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,332,1589266800"; 
   d="scan'208";a="324292563"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.73])
  by orsmga007.jf.intel.com with ESMTP; 09 Jul 2020 10:37:29 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 11/11] perf intel-pt: Add support for decoding PSB+ only
Date:   Thu,  9 Jul 2020 20:36:28 +0300
Message-Id: <20200709173628.5613-12-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200709173628.5613-1-adrian.hunter@intel.com>
References: <20200709173628.5613-1-adrian.hunter@intel.com>
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
 tools/perf/Documentation/perf-intel-pt.txt     |  3 +++
 .../util/intel-pt-decoder/intel-pt-decoder.c   | 18 ++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/tools/perf/Documentation/perf-intel-pt.txt b/tools/perf/Documentation/perf-intel-pt.txt
index 758295a7e3d6..849474629fe7 100644
--- a/tools/perf/Documentation/perf-intel-pt.txt
+++ b/tools/perf/Documentation/perf-intel-pt.txt
@@ -973,6 +973,9 @@ useful only if the control flow of interest is represented or indicated by FUP,
 TIP, TIP.PGE, or TIP.PGD packets.  However the q option could be used to find
 time ranges that could then be decoded fully using the --time option.
 
+Repeating the q option (i.e. qq) decodes only PSB+, getting ip if there is a
+FUP packet within PSB+ (i.e. between PSB and PSBEND).
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
2.25.1

