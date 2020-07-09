Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A930C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 17:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E10E2078B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 17:37:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728445AbgGIRhR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 13:37:17 -0400
Received: from mga09.intel.com ([134.134.136.24]:35024 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728306AbgGIRhO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 13:37:14 -0400
IronPort-SDR: QFJt/rp+MOShVNfqfQmvsZ7+dEdRwGnV/QRJ/o8nKxU+XYmEzInMdDenJ1BQKREo/ACtsVJ01F
 fIFT5EnfCXIQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9677"; a="149537103"
X-IronPort-AV: E=Sophos;i="5.75,332,1589266800"; 
   d="scan'208";a="149537103"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2020 10:37:14 -0700
IronPort-SDR: 3R1c+nKbaCem1ySBfUTk6scLZ01GfHkNzzblc/AOx5C3skAUkO+t23WfAl5uePo5EHW3B9m3qv
 B0lbVahmuWzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,332,1589266800"; 
   d="scan'208";a="324292508"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.73])
  by orsmga007.jf.intel.com with ESMTP; 09 Jul 2020 10:37:12 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 02/11] perf intel-pt: Fix duplicate branch after CBR
Date:   Thu,  9 Jul 2020 20:36:19 +0300
Message-Id: <20200709173628.5613-3-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200709173628.5613-1-adrian.hunter@intel.com>
References: <20200709173628.5613-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CBR events can result in a duplicate branch event, because the state type
defaults to a branch. Fix by clearing the state type.

Example: trace 'sleep' and hope for a frequency change

 Before:

   $ perf record -e intel_pt//u sleep 0.1
   [ perf record: Woken up 1 times to write data ]
   [ perf record: Captured and wrote 0.034 MB perf.data ]
   $ perf script --itrace=bpe > before.txt

 After:

   $ perf script --itrace=bpe > after.txt
   $ diff -u before.txt after.txt
   --- before.txt  2020-07-07 14:42:18.191508098 +0300
   +++ after.txt   2020-07-07 14:42:36.587891753 +0300
   @@ -29673,7 +29673,6 @@
               sleep 93431 [007] 15411.619905:          1  branches:u:                 0 [unknown] ([unknown]) =>     7f0818abb2e0 clock_nanosleep@@GLIBC_2.17+0x0 (/usr/lib/x86_64-linux-gnu/libc-2.31.so)
               sleep 93431 [007] 15411.619905:          1  branches:u:      7f0818abb30c clock_nanosleep@@GLIBC_2.17+0x2c (/usr/lib/x86_64-linux-gnu/libc-2.31.so) =>                0 [unknown] ([unknown])
               sleep 93431 [007] 15411.720069:         cbr:  cbr: 15 freq: 1507 MHz ( 56%)         7f0818abb30c clock_nanosleep@@GLIBC_2.17+0x2c (/usr/lib/x86_64-linux-gnu/libc-2.31.so)
   -           sleep 93431 [007] 15411.720069:          1  branches:u:      7f0818abb30c clock_nanosleep@@GLIBC_2.17+0x2c (/usr/lib/x86_64-linux-gnu/libc-2.31.so) =>                0 [unknown] ([unknown])
               sleep 93431 [007] 15411.720076:          1  branches:u:                 0 [unknown] ([unknown]) =>     7f0818abb30e clock_nanosleep@@GLIBC_2.17+0x2e (/usr/lib/x86_64-linux-gnu/libc-2.31.so)
               sleep 93431 [007] 15411.720077:          1  branches:u:      7f0818abb323 clock_nanosleep@@GLIBC_2.17+0x43 (/usr/lib/x86_64-linux-gnu/libc-2.31.so) =>     7f0818ac0eb7 __nanosleep+0x17 (/usr/lib/x86_64-linux-gnu/libc-2.31.so)
               sleep 93431 [007] 15411.720077:          1  branches:u:      7f0818ac0ebf __nanosleep+0x1f (/usr/lib/x86_64-linux-gnu/libc-2.31.so) =>     55cb7e4c2827 rpl_nanosleep+0x97 (/usr/bin/sleep)

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Fixes: 91de8684f1cff ("perf intel-pt: Cater for CBR change in PSB+")
Fixes: abe5a1d3e4bee ("perf intel-pt: Decoder to output CBR changes immediately")
Cc: stable@vger.kernel.org
---
 tools/perf/util/intel-pt-decoder/intel-pt-decoder.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
index 75c4bd74d521..7ffcbd6fcd1a 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
@@ -1977,8 +1977,10 @@ static int intel_pt_walk_trace(struct intel_pt_decoder *decoder)
 			 * possibility of another CBR change that gets caught up
 			 * in the PSB+.
 			 */
-			if (decoder->cbr != decoder->cbr_seen)
+			if (decoder->cbr != decoder->cbr_seen) {
+				decoder->state.type = 0;
 				return 0;
+			}
 			break;
 
 		case INTEL_PT_PIP:
@@ -2019,8 +2021,10 @@ static int intel_pt_walk_trace(struct intel_pt_decoder *decoder)
 
 		case INTEL_PT_CBR:
 			intel_pt_calc_cbr(decoder);
-			if (decoder->cbr != decoder->cbr_seen)
+			if (decoder->cbr != decoder->cbr_seen) {
+				decoder->state.type = 0;
 				return 0;
+			}
 			break;
 
 		case INTEL_PT_MODE_EXEC:
-- 
2.25.1

