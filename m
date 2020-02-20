Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E1CC34031
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 05:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAD4D20801
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 05:28:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rlEkO17u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbgBTF14 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 00:27:56 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41158 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbgBTF1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 00:27:55 -0500
Received: by mail-pl1-f196.google.com with SMTP id t14so1074482plr.8
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 21:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Zv8Ik+PS8AssCatpWlWw7JuaIsf6nNBGZuIjVAxbnH8=;
        b=rlEkO17uvEGvk0dn8yYsc27klZVZJ/lkHWFe3Tku0KVIgUNR/WgssxdT5U2cdauGal
         BQ6N3c36LHNmKngNGkWNQCTyIqzU6khb8OlNQk6lt4dY50F85NTSPgGIwj99h4AbzaJa
         qHB7os3Xo3/0FqjRye3utyyccDi8vqbuh4NX/EXFEQBSs84EgQ/cjNWYc4+EcLGqlICl
         OAmszArsEqhORyIkzAh//uTx3P2ZyU2ihbyVGFPjxCqxE8VVs46TSY3d2bpfn8Ao4G0b
         UZyzjp7cBC1zfWHCfwzFLtfpdWQhfegmm9DYEJVfKXW2Zsk0o40iNWrcliCLpfRDA07U
         I2pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Zv8Ik+PS8AssCatpWlWw7JuaIsf6nNBGZuIjVAxbnH8=;
        b=n2yIj/7AFrlo0qPtJh15mdrq8HWwlpcU8wfoDSxLvy1oLgqqFkbApRbFeN0JlVOtPC
         CjDjvIaegCzFZMMn+cWEvGtGz1PNji6Yc8jZm2K4JGhYCQX3BQEa3s6u7vbP8msgz4i7
         A3d3uHqXr3YXIiiUkQvzx6fvBTBmo2Tv7QVCi2I46XgJGcOWgQSsFDS+KyvwghaSAHlH
         Cbkb7gcBDvOc3/GjQoORBuIE/m0XLGKcKIaSgZfkMEbz0iKaiyDraQTYLLzi4wc3sTPB
         W61PX7pUA5L3/isY7w/GLSwzJWJMGqWhMP7kNLlNppMIHWsKH5EuSBpYdmLO7e8Qd3PW
         qfzA==
X-Gm-Message-State: APjAAAWHSeE67pzHvNG810wI/DUiZOnN0cc/ZwpRppkEXnLgujETUUv8
        TfIrFR+5XdTeRru38DkYrLNZCQ==
X-Google-Smtp-Source: APXvYqyIYFh1Pf2/bbGkCOJqBrt4jcgJOwR12yEA3k2ni6brJ5MNlfQnVOIdVKzAm4ej6NAaQSnPiQ==
X-Received: by 2002:a17:902:8a85:: with SMTP id p5mr30524442plo.154.1582176474820;
        Wed, 19 Feb 2020 21:27:54 -0800 (PST)
Received: from localhost.localdomain (li1441-214.members.linode.com. [45.118.134.214])
        by smtp.gmail.com with ESMTPSA id l69sm1535663pgd.1.2020.02.19.21.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 21:27:54 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Robert Walker <robert.walker@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Coresight ML <coresight@lists.linaro.org>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v5 1/9] perf cs-etm: Defer to assign exception sample flag
Date:   Thu, 20 Feb 2020 13:26:53 +0800
Message-Id: <20200220052701.7754-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200220052701.7754-1-leo.yan@linaro.org>
References: <20200220052701.7754-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, neither the exception entry packet nor the exception return
packet isn't used to generate samples; so the exception packet is only
used as an affiliate packet, and the exception sample flag is assigned
to its previous range packet, this is finished in the function
cs_etm__set_sample_flags().

This patch moves the exception sample flag assignment from
cs_etm__set_sample_flags() to cs_etm__exception(), essentially it defers
to assign exception sample flag to the previous range packet, thus this
gives us a chance to keep the previous range packet's original sample
flag.

So this patch is only a preparation for later patches and doesn't
include any change for the functionality; based on it, we can add extra
processing between the exception packet and its previous range packet.

To reduce the indenting, this patch bails out directly at the entry of
cs_etm__exception() if detects the previous packet is not a range
packet.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/cs-etm.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index bba969d48076..48932a7a933f 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1479,6 +1479,13 @@ static int cs_etm__sample(struct cs_etm_queue *etmq,
 
 static int cs_etm__exception(struct cs_etm_traceid_queue *tidq)
 {
+	/*
+	 * Usually the exception packet follows a range packet, if it's not the
+	 * case, directly bail out.
+	 */
+	if (tidq->prev_packet->sample_type != CS_ETM_RANGE)
+		return 0;
+
 	/*
 	 * When the exception packet is inserted, whether the last instruction
 	 * in previous range packet is taken branch or not, we need to force
@@ -1490,8 +1497,16 @@ static int cs_etm__exception(struct cs_etm_traceid_queue *tidq)
 	 * swap PACKET with PREV_PACKET.  This keeps PREV_PACKET to be useful
 	 * for generating instruction and branch samples.
 	 */
-	if (tidq->prev_packet->sample_type == CS_ETM_RANGE)
-		tidq->prev_packet->last_instr_taken_branch = true;
+	tidq->prev_packet->last_instr_taken_branch = true;
+
+	/*
+	 * Since the exception packet is not used standalone for generating
+	 * samples and it's affiliation to the previous instruction range
+	 * packet; so set previous range packet flags to tell perf it is an
+	 * exception taken branch.
+	 */
+	if (tidq->packet->sample_type == CS_ETM_EXCEPTION)
+		tidq->prev_packet->flags = tidq->packet->flags;
 
 	return 0;
 }
@@ -1916,15 +1931,6 @@ static int cs_etm__set_sample_flags(struct cs_etm_queue *etmq,
 					PERF_IP_FLAG_CALL |
 					PERF_IP_FLAG_INTERRUPT;
 
-		/*
-		 * When the exception packet is inserted, since exception
-		 * packet is not used standalone for generating samples
-		 * and it's affiliation to the previous instruction range
-		 * packet; so set previous range packet flags to tell perf
-		 * it is an exception taken branch.
-		 */
-		if (prev_packet->sample_type == CS_ETM_RANGE)
-			prev_packet->flags = packet->flags;
 		break;
 	case CS_ETM_EXCEPTION_RET:
 		/*
-- 
2.17.1

