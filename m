Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D795C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:11:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76023249A4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:11:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729786AbgEHNLv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 09:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730333AbgEHNEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 09:04:53 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 312BBC05BD0A;
        Fri,  8 May 2020 06:04:53 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jX2gD-00074Z-6y; Fri, 08 May 2020 15:04:41 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id E040C1C03AB;
        Fri,  8 May 2020 15:04:40 +0200 (CEST)
Date:   Fri, 08 May 2020 13:04:40 -0000
From:   "tip-bot2 for Mike Leach" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf: cs-etm: Update to build with latest opencsd version.
Cc:     Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200501143615.1180-1-mike.leach@linaro.org>
References: <20200501143615.1180-1-mike.leach@linaro.org>
MIME-Version: 1.0
Message-ID: <158894308086.8414.11285755843467307275.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     29e2eb2a9e1fac8b320bf2b4c628c336afbdd84f
Gitweb:        https://git.kernel.org/tip/29e2eb2a9e1fac8b320bf2b4c628c336afbdd84f
Author:        Mike Leach <mike.leach@linaro.org>
AuthorDate:    Fri, 01 May 2020 15:36:15 +01:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 05 May 2020 16:35:32 -03:00

perf: cs-etm: Update to build with latest opencsd version.

OpenCSD version v0.14.0 adds in a new output element. This is represented
by a new value in the generic element type enum, which must be added to
the handling code in perf cs-etm-decoder to prevent build errors due to
build options on the perf project.

This element is not currently used by the perf decoder.

Perf build feature test updated to require a minimum of 0.14.0

Tested on Linux 5.7-rc3.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
Reviewed-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Suzuki Poulouse <suzuki.poulose@arm.com>
Cc: coresight@lists.linaro.org
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lore.kernel.org/lkml/20200501143615.1180-1-mike.leach@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/build/feature/test-libopencsd.c           | 4 ++--
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/build/feature/test-libopencsd.c b/tools/build/feature/test-libopencsd.c
index 2b0e02c..1547bc2 100644
--- a/tools/build/feature/test-libopencsd.c
+++ b/tools/build/feature/test-libopencsd.c
@@ -4,9 +4,9 @@
 /*
  * Check OpenCSD library version is sufficient to provide required features
  */
-#define OCSD_MIN_VER ((0 << 16) | (11 << 8) | (0))
+#define OCSD_MIN_VER ((0 << 16) | (14 << 8) | (0))
 #if !defined(OCSD_VER_NUM) || (OCSD_VER_NUM < OCSD_MIN_VER)
-#error "OpenCSD >= 0.11.0 is required"
+#error "OpenCSD >= 0.14.0 is required"
 #endif
 
 int main(void)
diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index cd92a99..cd007cc 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -564,6 +564,8 @@ static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
 		resp = cs_etm_decoder__set_tid(etmq, packet_queue,
 					       elem, trace_chan_id);
 		break;
+	/* Unused packet types */
+	case OCSD_GEN_TRC_ELEM_I_RANGE_NOPATH:
 	case OCSD_GEN_TRC_ELEM_ADDR_NACC:
 	case OCSD_GEN_TRC_ELEM_CYCLE_COUNT:
 	case OCSD_GEN_TRC_ELEM_ADDR_UNKNOWN:
