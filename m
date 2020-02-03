Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EE25C35249
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 01:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03DB62067C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 01:52:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gJ5viVff"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbgBCBwk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Feb 2020 20:52:40 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:34481 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbgBCBwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Feb 2020 20:52:39 -0500
Received: by mail-pj1-f66.google.com with SMTP id f2so4334068pjq.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Feb 2020 17:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HmjIKHKHTkrFih6sNlRxYDtUepIYUbawMKXk0UIVIJQ=;
        b=gJ5viVffhA99MtSK0hwBqo6Kv5p1Bgb5bBhBhLVm0WHviPlbmV9rLNiS6wjbwRuzj2
         tBU8CbgKTv5nRDhJ6HclIscJa/aO/IBn0pFVIsxHMiT0aWYHZYiPy1vY2MBAkKriTJJ8
         DrtMoWwd3+6WkHHLTT5OLKIPVzoUBsROauIoTjXSuVPTULDxiRmzuud1n5UF89KPZzaH
         Xrt+bgLXg3/ECgCAy1lm9vJHXPPUiLICazxcdhVb3O8UfVsczRp/VVsbXzNwSv2out46
         CH6g+YGMwEHq5KmE1fvl43j98jz41JzlTt98qp9WU2zk5OVaxKRBFNLKPTo1jQUtz47n
         OMoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HmjIKHKHTkrFih6sNlRxYDtUepIYUbawMKXk0UIVIJQ=;
        b=gm8SDrsrrH+0ej1nKShYN28UBJAU4PgVfAnULlwQLDWLxP7ynURZwBQfiVV6oZy0sE
         0u0ZdsVG7HobIiSpvyw7B4MZ4dsppW1y7AiafDuBjAUE0FkYhj2jslxREB2PrdxAMMBi
         OtP4EupYzZrRODdcUXlRXmU2DBlqZKcu2ZpFLg7MoZl3DbIM51vydvYGOFLNnabL6e1K
         9TZHZPKnR10JXrVgSAEMh8Ikj+Y3is7JpfCz5/DUVTDV8CDiBpCA9g/5x3yw5wasBcrc
         udUmb71lZ3GSsWD3PWyo1HXoUroXdduoPXa2ZpiDPV/BdoTs5IQg8DREV7D0yFYaSzwE
         ALew==
X-Gm-Message-State: APjAAAWQRRJS3u++QXFbfr1aWmApg2ukrRz+9SzY6UtIOGLfA8YIDnaZ
        pivI0gz9vY/Xppsp/mNxxYyKKFhLW2yZ5Q==
X-Google-Smtp-Source: APXvYqyMggOnDjV7UUimqKsBhvpZ195iCh9ysL8a7MxGLbtFriw1s9mTdl7sllaRTeE6yN8Y5weCHQ==
X-Received: by 2002:a17:902:6184:: with SMTP id u4mr21704213plj.198.1580694757756;
        Sun, 02 Feb 2020 17:52:37 -0800 (PST)
Received: from localhost.localdomain (li1441-214.members.linode.com. [45.118.134.214])
        by smtp.gmail.com with ESMTPSA id y38sm17348308pgk.33.2020.02.02.17.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Feb 2020 17:52:37 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mike Leach <mike.leach@linaro.org>,
        Robert Walker <robert.walker@arm.com>,
        Coresight ML <coresight@lists.linaro.org>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v3 1/5] perf cs-etm: Swap packets for instruction samples
Date:   Mon,  3 Feb 2020 09:51:59 +0800
Message-Id: <20200203015203.27882-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200203015203.27882-1-leo.yan@linaro.org>
References: <20200203015203.27882-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If use option '--itrace=iNNN' with Arm CoreSight trace data, perf tool
fails inject instruction samples; the root cause is the packets are
only switched for branch samples and last branches but not for
instruction samples, so the new coming packets cannot be properly
handled for only synthesizing instruction samples.

To fix this issue, this patch switches packets for instruction samples.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/cs-etm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 5471045ebf5c..3dd5ba34a2c2 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1404,7 +1404,8 @@ static int cs_etm__sample(struct cs_etm_queue *etmq,
 		}
 	}
 
-	if (etm->sample_branches || etm->synth_opts.last_branch) {
+	if (etm->sample_branches || etm->synth_opts.last_branch ||
+	    etm->sample_instructions) {
 		/*
 		 * Swap PACKET with PREV_PACKET: PACKET becomes PREV_PACKET for
 		 * the next incoming packet.
@@ -1476,7 +1477,8 @@ static int cs_etm__flush(struct cs_etm_queue *etmq,
 	}
 
 swap_packet:
-	if (etm->sample_branches || etm->synth_opts.last_branch) {
+	if (etm->sample_branches || etm->synth_opts.last_branch ||
+	    etm->sample_instructions) {
 		/*
 		 * Swap PACKET with PREV_PACKET: PACKET becomes PREV_PACKET for
 		 * the next incoming packet.
-- 
2.17.1

