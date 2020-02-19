Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 317DEC34031
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 02:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1617207FD
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 02:18:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qPHAUt/Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbgBSCSr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 21:18:47 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43054 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726882AbgBSCSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 21:18:47 -0500
Received: by mail-pl1-f195.google.com with SMTP id p11so8879448plq.10
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 18:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HCei443+woU3d+4WFpgaBHBCXtW7EVH0nzt1yj3zjH4=;
        b=qPHAUt/Qv05p/vp1UY+On7Y1+0zpI+56l4XvY0X6HovroNJTO/UN0Wo8hWOSt2aYBP
         81bp0JEwCCknAREh4lEU3rf6jhCs7q5JMRsfgSJr725g35H+eJwcqmLFtsSeWJTidN/H
         s3JYwmrFEQSXnkrHc0DpPDbNSdH3bF4o8HxakP5D+feZdIbm36Z+jU0DfBznHzyHi0Tn
         73Axzgj9lknUuk/j+oeNgMv1HtqUIMNBajxEsusKEKEsrSbyHNVAnjR4IvhhKtI6n6xM
         r9NegZd1gP4bDJ3cK0QDDRVUf9E71IUSXzdt9nRGImfvxVU+RX6nYIudHaakRpz1bT1K
         6nhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HCei443+woU3d+4WFpgaBHBCXtW7EVH0nzt1yj3zjH4=;
        b=KFOdO0Th/YfZuMxk1xIfq49uQ57iIxV3FWqH6/PNdvWe7gpv7TLVXMPtuilm2AZKAF
         YQxQPcB0WqgyBN4PWDMT1LCEInJlYpSfx9acNKVZW86bhyStKvyc374oG6e7j0AWfsvB
         SKJ/mmQzijt1XzLznUaXFQH7I8G8BgowznTEC/hHp2I7v7dcJn5ADiToyJasJwxmwoKV
         8OyljMXAaUNOmrlWPbluDov5apNNjxcvb1KyA/N0DzuSzMc9KLfY2bmGYG4cH3Klu2n9
         FTq/BTsIOofmN8nZmyV1YqTkHvmfYXAkQypCwPT152bd4G6TNyhPWX+TUg0D7SewwzS+
         M+ZQ==
X-Gm-Message-State: APjAAAXc+H6pASHcKKhghkmKz4u2an68LuVgqGifcvuUVRj97suxZYwF
        iItGxf79UoeIvJa3o2H0mTt7YA==
X-Google-Smtp-Source: APXvYqxmQ/J85EL9NXtjtE9q/6aOEoSr+QIuagctzT/TN68j9pNNr0W7dZ+vImvAs1AhkrENqn3SVg==
X-Received: by 2002:a17:902:9f83:: with SMTP id g3mr23820348plq.101.1582078725013;
        Tue, 18 Feb 2020 18:18:45 -0800 (PST)
Received: from localhost.localdomain (li1441-214.members.linode.com. [45.118.134.214])
        by smtp.gmail.com with ESMTPSA id q11sm322698pff.111.2020.02.18.18.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 18:18:44 -0800 (PST)
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
Subject: [PATCH v5 1/5] perf cs-etm: Swap packets for instruction samples
Date:   Wed, 19 Feb 2020 10:18:07 +0800
Message-Id: <20200219021811.20067-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200219021811.20067-1-leo.yan@linaro.org>
References: <20200219021811.20067-1-leo.yan@linaro.org>
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
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
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

