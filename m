Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19235C47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 13:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6964206A5
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 13:37:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FmIiMP1U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729083AbgEENhJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 09:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728993AbgEENhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 09:37:08 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D73CC061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 06:37:07 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id h12so1169073pjz.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 06:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=6DxkBtXBsRjhDSSt5bpda9bBdLdSPYMqKL2JOYrqLyA=;
        b=FmIiMP1UrVnSztbbKw3HZJ10u19Ocye85lgZ/wBOpNCZsYUgKIQ5IWz+LRho31l73D
         jHOBgcVl9Nc87EibSBZOJFrq3n1E/QHgRkDvqVnRWG7OOOkvMb3MCPpVEHyphy4Iorzz
         6tSO4qSudgq2nOR1/RWngDiZ6tyHbq1uqf3T4qZK/W7uH+/mvfmFkX7ul4qro4vjefFa
         vzao3OIUv0QV5W3Ine1fo2PCRLO3nC2pUtx3SSxV4gsSf4OGq6ReWTBPoojl2sbEhNL5
         ovfiDalwxNI3iw1OQSkN2vaSk7tQpNx24HnWwqvVs8kMHG8RXdIB006F1ULBjam+gTZq
         gHhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6DxkBtXBsRjhDSSt5bpda9bBdLdSPYMqKL2JOYrqLyA=;
        b=Aj29pyydqa/oz27ZT+m5Pt6XZsTi4uEt/4LOUyxYiLuARDAt8XF+EFcbd8Bz6842on
         FEcJ/+qG2iPq9NKAnbnS2JQXKWxs07lRNia5RSf9Q64axrhOaL/5JG4u5EapbaOizU0K
         M9Nts3jYxg0Cjx7+Uec56yBvDXj2cVLP1OM8kR1LyR3I6OJ426DJbsxFMShjUREyc24P
         a0DcTTALNLOh2n62k9xyxWNCbNKHqE1rTYBf74yl0wB5ZEGuhQASKpfNk7i6y6j1sFY+
         BmmToyR6cveWPzWDOIjet/eJ0ZJNmQrgWSZz36ZdpQ8P9Rn+k11FnYjKj3Ed0/Mwtexm
         lF1w==
X-Gm-Message-State: AGi0PuZgnhzILp5xRUMQcVNKixA8mqlbWfFkVtWGqeHSHnXqFTwpLAb7
        wRqdJBs+Ff896iJLpZtTl19RyQ==
X-Google-Smtp-Source: APiQypKk5N1JogeWsMMibegsVTghCE8uN86ssgVDs3UVsbQlfg5lphbt3V+rSFAO2pEmg+JafdyVfg==
X-Received: by 2002:a17:902:fe06:: with SMTP id g6mr3272478plj.105.1588685826838;
        Tue, 05 May 2020 06:37:06 -0700 (PDT)
Received: from localhost ([2400:8904::f03c:91ff:fe8a:bbe4])
        by smtp.gmail.com with ESMTPSA id j5sm1561737pgi.5.2020.05.05.06.37.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 May 2020 06:37:06 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Tor Jeremiassen <tor@ti.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH] perf cs-etm: Move defined of traceid_list
Date:   Tue,  5 May 2020 21:36:42 +0800
Message-Id: <20200505133642.4756-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable 'traceid_list' is defined in the header file cs-etm.h,
if multiple C files include cs-etm.h the compiler might complaint for
multiple definition of 'traceid_list'.

To fix multiple definition error, move the definition of 'traceid_list'
into cs-etm.c.

Fixes: cd8bfd8c973e ("perf tools: Add processing of coresight metadata")
Reported-by: Thomas Backlund <tmb@mageia.org>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Mike Leach <mike.leach@linaro.org>
Tested-by: Mike Leach <mike.leach@linaro.org>
Tested-by: Thomas Backlund <tmb@mageia.org>
---
 tools/perf/util/cs-etm.c | 3 +++
 tools/perf/util/cs-etm.h | 3 ---
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 62d2f9b9ce1b..381d9708e9bd 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -94,6 +94,9 @@ struct cs_etm_queue {
 	struct cs_etm_traceid_queue **traceid_queues;
 };
 
+/* RB tree for quick conversion between traceID and metadata pointers */
+static struct intlist *traceid_list;
+
 static int cs_etm__update_queues(struct cs_etm_auxtrace *etm);
 static int cs_etm__process_queues(struct cs_etm_auxtrace *etm);
 static int cs_etm__process_timeless_queues(struct cs_etm_auxtrace *etm,
diff --git a/tools/perf/util/cs-etm.h b/tools/perf/util/cs-etm.h
index 650ecc2a6349..4ad925d6d799 100644
--- a/tools/perf/util/cs-etm.h
+++ b/tools/perf/util/cs-etm.h
@@ -114,9 +114,6 @@ enum cs_etm_isa {
 	CS_ETM_ISA_T32,
 };
 
-/* RB tree for quick conversion between traceID and metadata pointers */
-struct intlist *traceid_list;
-
 struct cs_etm_queue;
 
 struct cs_etm_packet {
-- 
2.17.1

