Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C0AC433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 17:37:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B02A2078B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 17:37:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbgGIRhQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 13:37:16 -0400
Received: from mga09.intel.com ([134.134.136.24]:35018 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726758AbgGIRhN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 13:37:13 -0400
IronPort-SDR: vA6BgWem8Rf5J/1LOYl+5ZsaF5FqlpFocjZM2owV8xhAbGCrFuUeJYUo/ES02/AKhXyzrrvp4M
 4GkAOy2BQgbQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9677"; a="149537098"
X-IronPort-AV: E=Sophos;i="5.75,332,1589266800"; 
   d="scan'208";a="149537098"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2020 10:37:12 -0700
IronPort-SDR: Pr6ccG+MTpvcImtoBJ2lOccHxffcxodl/M4Q8ZpjUWi2i85pUD6f0FLQwOiZ9yZIiYPrhXpiz2
 gx2zSZl8sEnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,332,1589266800"; 
   d="scan'208";a="324292500"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.73])
  by orsmga007.jf.intel.com with ESMTP; 09 Jul 2020 10:37:11 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 01/11] perf intel-pt: Fix FUP packet state
Date:   Thu,  9 Jul 2020 20:36:18 +0300
Message-Id: <20200709173628.5613-2-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200709173628.5613-1-adrian.hunter@intel.com>
References: <20200709173628.5613-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While walking code towards a FUP ip, the packet state is
INTEL_PT_STATE_FUP or INTEL_PT_STATE_FUP_NO_TIP. That was mishandled
resulting in the state becoming INTEL_PT_STATE_IN_SYNC prematurely.
The result was an occasional lost EXSTOP event.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: stable@vger.kernel.org
---
 .../util/intel-pt-decoder/intel-pt-decoder.c  | 21 +++++++------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
index f8ccfd6be0ee..75c4bd74d521 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
@@ -1164,6 +1164,7 @@ static int intel_pt_walk_fup(struct intel_pt_decoder *decoder)
 			return 0;
 		if (err == -EAGAIN ||
 		    intel_pt_fup_with_nlip(decoder, &intel_pt_insn, ip, err)) {
+			decoder->pkt_state = INTEL_PT_STATE_IN_SYNC;
 			if (intel_pt_fup_event(decoder))
 				return 0;
 			return -EAGAIN;
@@ -1942,17 +1943,13 @@ static int intel_pt_walk_trace(struct intel_pt_decoder *decoder)
 			}
 			if (decoder->set_fup_mwait)
 				no_tip = true;
+			if (no_tip)
+				decoder->pkt_state = INTEL_PT_STATE_FUP_NO_TIP;
+			else
+				decoder->pkt_state = INTEL_PT_STATE_FUP;
 			err = intel_pt_walk_fup(decoder);
-			if (err != -EAGAIN) {
-				if (err)
-					return err;
-				if (no_tip)
-					decoder->pkt_state =
-						INTEL_PT_STATE_FUP_NO_TIP;
-				else
-					decoder->pkt_state = INTEL_PT_STATE_FUP;
-				return 0;
-			}
+			if (err != -EAGAIN)
+				return err;
 			if (no_tip) {
 				no_tip = false;
 				break;
@@ -2599,15 +2596,11 @@ const struct intel_pt_state *intel_pt_decode(struct intel_pt_decoder *decoder)
 			err = intel_pt_walk_tip(decoder);
 			break;
 		case INTEL_PT_STATE_FUP:
-			decoder->pkt_state = INTEL_PT_STATE_IN_SYNC;
 			err = intel_pt_walk_fup(decoder);
 			if (err == -EAGAIN)
 				err = intel_pt_walk_fup_tip(decoder);
-			else if (!err)
-				decoder->pkt_state = INTEL_PT_STATE_FUP;
 			break;
 		case INTEL_PT_STATE_FUP_NO_TIP:
-			decoder->pkt_state = INTEL_PT_STATE_IN_SYNC;
 			err = intel_pt_walk_fup(decoder);
 			if (err == -EAGAIN)
 				err = intel_pt_walk_trace(decoder);
-- 
2.25.1

