Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A0AC433E7
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 15:20:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A971206A1
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 15:20:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbgGJPTj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 11:19:39 -0400
Received: from mga09.intel.com ([134.134.136.24]:38306 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727886AbgGJPMK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 11:12:10 -0400
IronPort-SDR: +XjpWhnI5qEfItBAJEZicv4OvKMYM0P2ruEgPEAKt0C/JGTiIZD5rwNmfRefYGEnHm2Q3twlQm
 Lef/6mBjAtFw==
X-IronPort-AV: E=McAfee;i="6000,8403,9678"; a="149686443"
X-IronPort-AV: E=Sophos;i="5.75,336,1589266800"; 
   d="scan'208";a="149686443"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2020 08:12:08 -0700
IronPort-SDR: /5BmnwL+SFpM9Ijdth3B95De6plWp5ZkImMC3j1wmeWmmFaazjbkZ3O53Zm2Pibupqln7639VP
 3GPpBgulvFiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,336,1589266800"; 
   d="scan'208";a="484675561"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.73])
  by fmsmga005.fm.intel.com with ESMTP; 10 Jul 2020 08:12:06 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 11/12] perf intel-pt: Add support for decoding FUP/TIP only
Date:   Fri, 10 Jul 2020 18:11:03 +0300
Message-Id: <20200710151104.15137-12-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200710151104.15137-1-adrian.hunter@intel.com>
References: <20200710151104.15137-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new itrace 'q' option to add support for a mode of decoding that
ignores TNT, does not walk object code, but gets the ip from FUP and TIP
packets.

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

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/Documentation/perf-intel-pt.txt    |  31 ++++
 .../util/intel-pt-decoder/intel-pt-decoder.c  | 167 +++++++++++++++++-
 .../util/intel-pt-decoder/intel-pt-decoder.h  |   1 +
 tools/perf/util/intel-pt.c                    |   6 +-
 4 files changed, 200 insertions(+), 5 deletions(-)

diff --git a/tools/perf/Documentation/perf-intel-pt.txt b/tools/perf/Documentation/perf-intel-pt.txt
index 4666e4a83615..f9fe4a4040ba 100644
--- a/tools/perf/Documentation/perf-intel-pt.txt
+++ b/tools/perf/Documentation/perf-intel-pt.txt
@@ -825,6 +825,7 @@ The letters are:
 	l	synthesize last branch entries (use with i or x)
 	L	synthesize last branch entries on existing event records
 	s	skip initial number of events
+	q	quicker (less detailed) decoding
 
 "Instructions" events look like they were recorded by "perf record -e
 instructions".
@@ -969,6 +970,36 @@ at the beginning. This is useful to ignore initialization code.
 
 skips the first million instructions.
 
+The q option changes the way the trace is decoded.  The decoding is much faster
+but much less detailed.  Specifically, with the q option, the decoder does not
+decode TNT packets, and does not walk object code, but gets the ip from FUP and
+TIP packets.  The q option can be used with the b and i options but the period
+is not used.  The q option decodes more quickly, but is useful only if the
+control flow of interest is represented or indicated by FUP, TIP, TIP.PGE, or
+TIP.PGD packets (refer below).  However the q option could be used to find time
+ranges that could then be decoded fully using the --time option.
+
+What will *not* be decoded with the (single) q option:
+
+	- direct calls and jmps
+	- conditional branches
+	- non-branch instructions
+
+What *will* be decoded with the (single) q option:
+
+	- asynchronous branches such as interrupts
+	- indirect branches
+	- function return target address *if* the noretcomp config term (refer
+	config terms section) was used
+	- start of (control-flow) tracing
+	- end of (control-flow) tracing, if it is not out of context
+	- power events, ptwrite, transaction start and abort
+	- instruction pointer associated with PSB packets
+
+Note the q option does not specify what events will be synthesized e.g. the p
+option must be used also to show power events.
+
+
 dump option
 ~~~~~~~~~~~
 
diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
index 7ffcbd6fcd1a..ccb204b1a050 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
@@ -55,6 +55,7 @@ enum intel_pt_pkt_state {
 	INTEL_PT_STATE_TIP_PGD,
 	INTEL_PT_STATE_FUP,
 	INTEL_PT_STATE_FUP_NO_TIP,
+	INTEL_PT_STATE_RESAMPLE,
 };
 
 static inline bool intel_pt_sample_time(enum intel_pt_pkt_state pkt_state)
@@ -65,6 +66,7 @@ static inline bool intel_pt_sample_time(enum intel_pt_pkt_state pkt_state)
 	case INTEL_PT_STATE_ERR_RESYNC:
 	case INTEL_PT_STATE_IN_SYNC:
 	case INTEL_PT_STATE_TNT_CONT:
+	case INTEL_PT_STATE_RESAMPLE:
 		return true;
 	case INTEL_PT_STATE_TNT:
 	case INTEL_PT_STATE_TIP:
@@ -109,6 +111,8 @@ struct intel_pt_decoder {
 	bool fixup_last_mtc;
 	bool have_last_ip;
 	bool in_psb;
+	bool hop;
+	bool hop_psb_fup;
 	enum intel_pt_param_flags flags;
 	uint64_t pos;
 	uint64_t last_ip;
@@ -235,6 +239,7 @@ struct intel_pt_decoder *intel_pt_decoder_new(struct intel_pt_params *params)
 	decoder->data               = params->data;
 	decoder->return_compression = params->return_compression;
 	decoder->branch_enable      = params->branch_enable;
+	decoder->hop                = params->quick >= 1;
 
 	decoder->flags              = params->flags;
 
@@ -275,6 +280,9 @@ struct intel_pt_decoder *intel_pt_decoder_new(struct intel_pt_params *params)
 	intel_pt_log("timestamp: tsc_ctc_mult %u\n", decoder->tsc_ctc_mult);
 	intel_pt_log("timestamp: tsc_slip %#x\n", decoder->tsc_slip);
 
+	if (decoder->hop)
+		intel_pt_log("Hop mode: decoding FUP and TIPs, but not TNT\n");
+
 	return decoder;
 }
 
@@ -1730,8 +1738,14 @@ static int intel_pt_walk_psbend(struct intel_pt_decoder *decoder)
 
 		case INTEL_PT_FUP:
 			decoder->pge = true;
-			if (decoder->packet.count)
+			if (decoder->packet.count) {
 				intel_pt_set_last_ip(decoder);
+				if (decoder->hop) {
+					/* Act on FUP at PSBEND */
+					decoder->ip = decoder->last_ip;
+					decoder->hop_psb_fup = true;
+				}
+			}
 			break;
 
 		case INTEL_PT_MODE_TSX:
@@ -1875,6 +1889,118 @@ static int intel_pt_walk_fup_tip(struct intel_pt_decoder *decoder)
 	}
 }
 
+static int intel_pt_resample(struct intel_pt_decoder *decoder)
+{
+	decoder->pkt_state = INTEL_PT_STATE_IN_SYNC;
+	decoder->state.type = INTEL_PT_INSTRUCTION;
+	decoder->state.from_ip = decoder->ip;
+	decoder->state.to_ip = 0;
+	return 0;
+}
+
+#define HOP_PROCESS	0
+#define HOP_IGNORE	1
+#define HOP_RETURN	2
+#define HOP_AGAIN	3
+
+/* Hop mode: Ignore TNT, do not walk code, but get ip from FUPs and TIPs */
+static int intel_pt_hop_trace(struct intel_pt_decoder *decoder, bool *no_tip, int *err)
+{
+	switch (decoder->packet.type) {
+	case INTEL_PT_TNT:
+		return HOP_IGNORE;
+
+	case INTEL_PT_TIP_PGD:
+		if (!decoder->packet.count)
+			return HOP_IGNORE;
+		intel_pt_set_ip(decoder);
+		decoder->state.type |= INTEL_PT_TRACE_END;
+		decoder->state.from_ip = 0;
+		decoder->state.to_ip = decoder->ip;
+		return HOP_RETURN;
+
+	case INTEL_PT_TIP:
+		if (!decoder->packet.count)
+			return HOP_IGNORE;
+		intel_pt_set_ip(decoder);
+		decoder->state.type = INTEL_PT_INSTRUCTION;
+		decoder->state.from_ip = decoder->ip;
+		decoder->state.to_ip = 0;
+		return HOP_RETURN;
+
+	case INTEL_PT_FUP:
+		if (!decoder->packet.count)
+			return HOP_IGNORE;
+		intel_pt_set_ip(decoder);
+		if (intel_pt_fup_event(decoder))
+			return HOP_RETURN;
+		if (!decoder->branch_enable)
+			*no_tip = true;
+		if (*no_tip) {
+			decoder->state.type = INTEL_PT_INSTRUCTION;
+			decoder->state.from_ip = decoder->ip;
+			decoder->state.to_ip = 0;
+			return HOP_RETURN;
+		}
+		*err = intel_pt_walk_fup_tip(decoder);
+		if (!*err)
+			decoder->pkt_state = INTEL_PT_STATE_RESAMPLE;
+		return HOP_RETURN;
+
+	case INTEL_PT_PSB:
+		decoder->last_ip = 0;
+		decoder->have_last_ip = true;
+		decoder->hop_psb_fup = false;
+		*err = intel_pt_walk_psbend(decoder);
+		if (*err == -EAGAIN)
+			return HOP_AGAIN;
+		if (*err)
+			return HOP_RETURN;
+		if (decoder->hop_psb_fup) {
+			decoder->hop_psb_fup = false;
+			decoder->state.type = INTEL_PT_INSTRUCTION;
+			decoder->state.from_ip = decoder->ip;
+			decoder->state.to_ip = 0;
+			return HOP_RETURN;
+		}
+		if (decoder->cbr != decoder->cbr_seen) {
+			decoder->state.type = 0;
+			return HOP_RETURN;
+		}
+		return HOP_IGNORE;
+
+	case INTEL_PT_BAD:
+	case INTEL_PT_PAD:
+	case INTEL_PT_TIP_PGE:
+	case INTEL_PT_TSC:
+	case INTEL_PT_TMA:
+	case INTEL_PT_MODE_EXEC:
+	case INTEL_PT_MODE_TSX:
+	case INTEL_PT_MTC:
+	case INTEL_PT_CYC:
+	case INTEL_PT_VMCS:
+	case INTEL_PT_PSBEND:
+	case INTEL_PT_CBR:
+	case INTEL_PT_TRACESTOP:
+	case INTEL_PT_PIP:
+	case INTEL_PT_OVF:
+	case INTEL_PT_MNT:
+	case INTEL_PT_PTWRITE:
+	case INTEL_PT_PTWRITE_IP:
+	case INTEL_PT_EXSTOP:
+	case INTEL_PT_EXSTOP_IP:
+	case INTEL_PT_MWAIT:
+	case INTEL_PT_PWRE:
+	case INTEL_PT_PWRX:
+	case INTEL_PT_BBP:
+	case INTEL_PT_BIP:
+	case INTEL_PT_BEP:
+	case INTEL_PT_BEP_IP:
+	default:
+		return HOP_PROCESS;
+	}
+}
+
 static int intel_pt_walk_trace(struct intel_pt_decoder *decoder)
 {
 	bool no_tip = false;
@@ -1885,6 +2011,19 @@ static int intel_pt_walk_trace(struct intel_pt_decoder *decoder)
 		if (err)
 			return err;
 next:
+		if (decoder->hop) {
+			switch (intel_pt_hop_trace(decoder, &no_tip, &err)) {
+			case HOP_IGNORE:
+				continue;
+			case HOP_RETURN:
+				return err;
+			case HOP_AGAIN:
+				goto next;
+			default:
+				break;
+			}
+		}
+
 		switch (decoder->packet.type) {
 		case INTEL_PT_TNT:
 			if (!decoder->packet.count)
@@ -1914,6 +2053,12 @@ static int intel_pt_walk_trace(struct intel_pt_decoder *decoder)
 			decoder->state.from_ip = 0;
 			decoder->state.to_ip = decoder->ip;
 			decoder->state.type |= INTEL_PT_TRACE_BEGIN;
+			/*
+			 * In hop mode, resample to get the to_ip as an
+			 * "instruction" sample.
+			 */
+			if (decoder->hop)
+				decoder->pkt_state = INTEL_PT_STATE_RESAMPLE;
 			return 0;
 		}
 
@@ -2033,7 +2178,7 @@ static int intel_pt_walk_trace(struct intel_pt_decoder *decoder)
 
 		case INTEL_PT_MODE_TSX:
 			/* MODE_TSX need not be followed by FUP */
-			if (!decoder->pge) {
+			if (!decoder->pge || decoder->in_psb) {
 				intel_pt_update_in_tx(decoder);
 				break;
 			}
@@ -2424,7 +2569,11 @@ static int intel_pt_sync_ip(struct intel_pt_decoder *decoder)
 	if (err)
 		return err;
 
-	decoder->pkt_state = INTEL_PT_STATE_IN_SYNC;
+	/* In hop mode, resample to get the to_ip as an "instruction" sample */
+	if (decoder->hop)
+		decoder->pkt_state = INTEL_PT_STATE_RESAMPLE;
+	else
+		decoder->pkt_state = INTEL_PT_STATE_IN_SYNC;
 	decoder->overflow = false;
 
 	decoder->state.from_ip = 0;
@@ -2545,7 +2694,14 @@ static int intel_pt_sync(struct intel_pt_decoder *decoder)
 
 	if (decoder->ip) {
 		decoder->state.type = 0; /* Do not have a sample */
-		decoder->pkt_state = INTEL_PT_STATE_IN_SYNC;
+		/*
+		 * In hop mode, resample to get the PSB FUP ip as an
+		 * "instruction" sample.
+		 */
+		if (decoder->hop)
+			decoder->pkt_state = INTEL_PT_STATE_RESAMPLE;
+		else
+			decoder->pkt_state = INTEL_PT_STATE_IN_SYNC;
 	} else {
 		return intel_pt_sync_ip(decoder);
 	}
@@ -2609,6 +2765,9 @@ const struct intel_pt_state *intel_pt_decode(struct intel_pt_decoder *decoder)
 			if (err == -EAGAIN)
 				err = intel_pt_walk_trace(decoder);
 			break;
+		case INTEL_PT_STATE_RESAMPLE:
+			err = intel_pt_resample(decoder);
+			break;
 		default:
 			err = intel_pt_bug(decoder);
 			break;
diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h
index e289e463d635..8645fc265481 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h
@@ -250,6 +250,7 @@ struct intel_pt_params {
 	uint32_t tsc_ctc_ratio_n;
 	uint32_t tsc_ctc_ratio_d;
 	enum intel_pt_param_flags flags;
+	unsigned int quick;
 };
 
 struct intel_pt_decoder;
diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index bddeb18648df..7cb3cf769d4d 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -1030,6 +1030,7 @@ static struct intel_pt_queue *intel_pt_alloc_queue(struct intel_pt *pt,
 	params.mtc_period = intel_pt_mtc_period(pt);
 	params.tsc_ctc_ratio_n = pt->tsc_ctc_ratio_n;
 	params.tsc_ctc_ratio_d = pt->tsc_ctc_ratio_d;
+	params.quick = pt->synth_opts.quick;
 
 	if (pt->filts.cnt > 0)
 		params.pgd_ip = intel_pt_pgd_ip;
@@ -1423,7 +1424,10 @@ static int intel_pt_synth_instruction_sample(struct intel_pt_queue *ptq)
 
 	sample.id = ptq->pt->instructions_id;
 	sample.stream_id = ptq->pt->instructions_id;
-	sample.period = ptq->state->tot_insn_cnt - ptq->last_insn_cnt;
+	if (pt->synth_opts.quick)
+		sample.period = 1;
+	else
+		sample.period = ptq->state->tot_insn_cnt - ptq->last_insn_cnt;
 
 	sample.cyc_cnt = ptq->ipc_cyc_cnt - ptq->last_in_cyc_cnt;
 	if (sample.cyc_cnt) {
-- 
2.17.1

