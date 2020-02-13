Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B654CC2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 09:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DF3A2173E
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 09:42:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vrNgUqWP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729757AbgBMJmo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 04:42:44 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:55258 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729440AbgBMJmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 04:42:42 -0500
Received: by mail-pj1-f65.google.com with SMTP id dw13so2140949pjb.4
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 01:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=G6IPm5U0/N32JfuJRrXFpT4+8WxS2iUn3t7D8Wj9RWY=;
        b=vrNgUqWPxNjcbcprI69cNxpFGDoNlqSdIUfnpnFCC1Z+cnY1e70ej8SOS8MyZU1iUu
         Foyb6kugSrVv9KNVBrdGT+IR49tDjT63OdH1PVsbdb8eaJZzpwdVvO2LUkxHjjMEWfYg
         ZfC0+UdGGiaKJwebfefg71mPJ2whj5CFNxWU0Zx7NEh6kAwNrVsvvhky53G9uGNGvHYl
         yh4g1tiGbTFJnbzGFg1DsE9xEfqMzWCN2BFgXkbH0Yla2SkezfnvY4mggLN4uEjtMlJU
         deL11fXjY/a4OVGq1zdDrramCjTp7bNYT6tV4N68F7XmWRRCkOSPxyqeGVApT3TYZGSE
         IdiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=G6IPm5U0/N32JfuJRrXFpT4+8WxS2iUn3t7D8Wj9RWY=;
        b=Pl+HGLkO/QG2Zrm0N6lU9RxAnpclggOuDzoIOS0IEgcBQaA5Doh4oHty4Ivbax4U+E
         Eq2Ym9JmhyQVsH+IAoH0mmQSNlQFpXz3UHfhSXy4L/nr+m8J4VYit4YX2mqkBC414qbf
         FM5wEkhS4xZLW8xxA464jY1g+eBXyCkVwhXkbmqJ3X2vHaB2nfNYLoIasLkRA4MX9uyU
         phD6ozTY4mpale/qMyoTTO7rcMrZc11vrguKKsfsLr8UkFIgaY734jco2qQYp777ZcWQ
         vjHrVQ1kuBIGrK4xycNe4SxtsSUhsMHqHNJkq+Y66CzPV0Pxr9SyLhatptLr76bQc6Nq
         L1qQ==
X-Gm-Message-State: APjAAAUFd65bVstAvFsrtIPILYBfgjp14ru1uPSIDT+YYjlun2Ga3C8p
        kyzaQ43FiSj0PTKA5QZO5HkAVg==
X-Google-Smtp-Source: APXvYqyXs+FQTEb/MYdpAWnSqLxOY3Lricf+P1+wCsYF6j9aOQspLE4mAeq2ZT3Mu7FTAD0FpT3RAg==
X-Received: by 2002:a17:902:2e:: with SMTP id 43mr12872821pla.326.1581586961690;
        Thu, 13 Feb 2020 01:42:41 -0800 (PST)
Received: from localhost.localdomain (li1441-214.members.linode.com. [45.118.134.214])
        by smtp.gmail.com with ESMTPSA id 3sm2310277pfi.13.2020.02.13.01.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 01:42:41 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Robert Walker <robert.walker@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Coresight ML <coresight@lists.linaro.org>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v4 1/5] perf cs-etm: Swap packets for instruction samples
Date:   Thu, 13 Feb 2020 17:42:00 +0800
Message-Id: <20200213094204.2568-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200213094204.2568-1-leo.yan@linaro.org>
References: <20200213094204.2568-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If use option '--itrace=iNNN' with Arm CoreSight trace data, perf tool
fails inject instruction samples; the root cause is the packets are
only swapped for branch samples and last branches but not for
instruction samples, so the new coming packets cannot be properly
handled for only synthesizing instruction samples.

To fix this issue, this patch refactors the code with a new function
cs_etm__packet_swap() which is used to swap packets and adds the
condition for instruction samples.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Mike Leach <mike.leach@linaro.org>
---
 tools/perf/util/cs-etm.c | 39 +++++++++++++++++++--------------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 5471045ebf5c..84f30c2de185 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -363,6 +363,23 @@ struct cs_etm_packet_queue
 	return NULL;
 }
 
+static void cs_etm__packet_swap(struct cs_etm_auxtrace *etm,
+				struct cs_etm_traceid_queue *tidq)
+{
+	struct cs_etm_packet *tmp;
+
+	if (etm->sample_branches || etm->synth_opts.last_branch ||
+	    etm->sample_instructions) {
+		/*
+		 * Swap PACKET with PREV_PACKET: PACKET becomes PREV_PACKET for
+		 * the next incoming packet.
+		 */
+		tmp = tidq->packet;
+		tidq->packet = tidq->prev_packet;
+		tidq->prev_packet = tmp;
+	}
+}
+
 static void cs_etm__packet_dump(const char *pkt_string)
 {
 	const char *color = PERF_COLOR_BLUE;
@@ -1340,7 +1357,6 @@ static int cs_etm__sample(struct cs_etm_queue *etmq,
 			  struct cs_etm_traceid_queue *tidq)
 {
 	struct cs_etm_auxtrace *etm = etmq->etm;
-	struct cs_etm_packet *tmp;
 	int ret;
 	u8 trace_chan_id = tidq->trace_chan_id;
 	u64 instrs_executed = tidq->packet->instr_count;
@@ -1404,15 +1420,7 @@ static int cs_etm__sample(struct cs_etm_queue *etmq,
 		}
 	}
 
-	if (etm->sample_branches || etm->synth_opts.last_branch) {
-		/*
-		 * Swap PACKET with PREV_PACKET: PACKET becomes PREV_PACKET for
-		 * the next incoming packet.
-		 */
-		tmp = tidq->packet;
-		tidq->packet = tidq->prev_packet;
-		tidq->prev_packet = tmp;
-	}
+	cs_etm__packet_swap(etm, tidq);
 
 	return 0;
 }
@@ -1441,7 +1449,6 @@ static int cs_etm__flush(struct cs_etm_queue *etmq,
 {
 	int err = 0;
 	struct cs_etm_auxtrace *etm = etmq->etm;
-	struct cs_etm_packet *tmp;
 
 	/* Handle start tracing packet */
 	if (tidq->prev_packet->sample_type == CS_ETM_EMPTY)
@@ -1476,15 +1483,7 @@ static int cs_etm__flush(struct cs_etm_queue *etmq,
 	}
 
 swap_packet:
-	if (etm->sample_branches || etm->synth_opts.last_branch) {
-		/*
-		 * Swap PACKET with PREV_PACKET: PACKET becomes PREV_PACKET for
-		 * the next incoming packet.
-		 */
-		tmp = tidq->packet;
-		tidq->packet = tidq->prev_packet;
-		tidq->prev_packet = tmp;
-	}
+	cs_etm__packet_swap(etm, tidq);
 
 	return err;
 }
-- 
2.17.1

