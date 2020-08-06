Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00ECCC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 02:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D097820823
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 02:41:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hzajBu1r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbgHFClo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 22:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbgHFClm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 22:41:42 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80DE5C061574
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 19:41:42 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id c10so4043550pjn.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 19:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Z9aoTydaBrsa4BYExn4DIx/YUkSnAWMKI+PsrmMc1kg=;
        b=hzajBu1rs2E+qvSVvJ6K6BjDroOe3GDUOn3WiHkuw+aBxuyip9JUZ5vpeDuRuXli3J
         h14C5Mtj47fepkc0s72md3P3Rih5cZAUlKNPviimW3BUFIXu+9Khj1cUn9Xs4WgmF+ab
         EFMx/Rbwp81sF6NQ96F+RKM004gUaVhuW9LGjPqUleyNmozTVtumxZiTXUipPdvXsoVr
         apZ4s+dVZAJyLkKti8Obf15EmKv7tFQOKGsB98kXGm5T5a6FOPb9CzocGbOPuCHI/gtl
         FXHhFLGVIyXrnvJlJydEH27dghrLi1lQ3TJk3U0fpIJFHuG2Ef6ByNxdGXAGIBB2yn5S
         HJVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Z9aoTydaBrsa4BYExn4DIx/YUkSnAWMKI+PsrmMc1kg=;
        b=LY04M9RA86G6i8mX0DnqsXFp3qqI6Prka1XXv6fa6XAZ6O535utIBPt1lOCpmU2ZOJ
         IuVitq2qUm4l3V1kEPSsvTMr0h5yS49bLg7cDeWOq6iBWPxfJVybU54irfCqcf5uHJwA
         KKI3QGib9H+N+FmURFN7U8MRUlHpvhSLEbT/pgGUpbgEsXwI1gp/LA8U0M5lSbFG8Zwc
         iy4a6OW/Ucb7agvrWAQK5TX2DfI4nBHWf4afh0xl/RJMDzdyLutzqGTlgIpVmNKgawS4
         PPgN3Lq+L83uisnTIkGswlaLyGbERqlwHn+KO2ZERVLHe4e1yH7f+fCJAk1fQPLhlcwo
         LCnw==
X-Gm-Message-State: AOAM533bnPvnnQHeyIeT6gF+HMEIoXU5BJ3G92go9oxWoGgc1HmZYaxL
        QWLVtoVvKCsdGM+SRKHuuN18mA==
X-Google-Smtp-Source: ABdhPJzz2Qy8HU2xZ7sFUqhC2UKaKmZjdo2X3lMitk0hlhPnbiVfZcYp/U4p/mdSH8Q2qqg1nKZUuw==
X-Received: by 2002:a17:902:ed4a:: with SMTP id y10mr5938244plb.106.1596681702037;
        Wed, 05 Aug 2020 19:41:42 -0700 (PDT)
Received: from localhost ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id na14sm4645939pjb.6.2020.08.05.19.41.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Aug 2020 19:41:41 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Ian Rogers <irogers@google.com>,
        Kemeng Shi <shikemeng@huawei.com>,
        James Clark <james.clark@arm.com>,
        Wei Li <liwei391@huawei.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Al Grant <Al.Grant@arm.com>, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 07/11] perf arm-spe: Enable attribution PERF_SAMPLE_DATA_SRC
Date:   Thu,  6 Aug 2020 10:40:37 +0800
Message-Id: <20200806024041.27475-8-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200806024041.27475-1-leo.yan@linaro.org>
References: <20200806024041.27475-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is to enable attribution PERF_SAMPLE_DATA_SRC for the perf
data, when decoding the tracing data, it will tells the tool it contains
memory data.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/arm-spe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 3882a5360ada..c2cf5058648f 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -803,7 +803,7 @@ arm_spe_synth_events(struct arm_spe *spe, struct perf_session *session)
 	attr.type = PERF_TYPE_HARDWARE;
 	attr.sample_type = evsel->core.attr.sample_type & PERF_SAMPLE_MASK;
 	attr.sample_type |= PERF_SAMPLE_IP | PERF_SAMPLE_TID |
-		PERF_SAMPLE_PERIOD;
+			    PERF_SAMPLE_PERIOD | PERF_SAMPLE_DATA_SRC;
 	if (spe->timeless_decoding)
 		attr.sample_type &= ~(u64)PERF_SAMPLE_TIME;
 	else
-- 
2.17.1

