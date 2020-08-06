Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F8D6C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 03:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0F2222D6D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 03:08:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WrkJpCyS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbgHFDIf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 23:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727783AbgHFDI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 23:08:28 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA6B5C061574
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 20:08:28 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id g33so8518431pgb.4
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 20:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Z9aoTydaBrsa4BYExn4DIx/YUkSnAWMKI+PsrmMc1kg=;
        b=WrkJpCyS//k5f3jLpJq0gYmWMxcAz9Jo8ahuFYEOai5Ic6kfXLmFMv7a7xU4nI7mJf
         P8NFXQ4A1g65VpJtKThhoBOB5Qx+CTnzX2sJO7/XlLMvuqZQdocOn7yPo9ifAPXGUm0y
         w3m0rct4atRlkW/EQfzz+yEi9dtw3kByAy/+0l0ef12l8tyHNAmJnsdNghh3VrllI3F/
         1+wlVlwv32jhrspT3BPPeRmc9wfoH0wN3SNPrLSgmaE3JV9RlyMyloliuzkWke89FXrs
         nYJxAXsutGPT6qeoKlfJSPeOR74S2s24MddVc+9zsX1lQObC0T5SsiIcx1wrAdmLaJbA
         3jGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Z9aoTydaBrsa4BYExn4DIx/YUkSnAWMKI+PsrmMc1kg=;
        b=acjohmHqPgj9jTe8S97Hh1EtbuyyrmeZ8SCivTX5r6Tdvpe0ZHRoQH8GyHwG5S5adw
         moPzH8tmo34s5XHQ/0Ze73/vMR9g+OM2eqDrpgv+TQH8dlJsetI3csVg7aR06w368yhz
         leqvsDjP/k+N8NgPxrGTYbaTAgzGgI7Wbkb1pYTK/oFbtz1wSl92XnBveYvr3toeaF0w
         JRSy0ZG3/vHUd2RpMsEQSZ1h8rMcpuIE/5Dx5Ib6xVsBNcPb/WNa4s2/pJPcArdMJqSW
         5TE+CgCRQ6QopNpZE3JFR8X/uCpKh3NDTJevkP9FAXBFc6Vf9OuLU46aE/+0XiK4jt34
         WdRQ==
X-Gm-Message-State: AOAM5328fHH0QTHNgdSERkNKksFUYtS+UJUh44igm+IWFnkwUm93vso7
        Un9KbSYJY2pCNqRXs/VXc2P1qw==
X-Google-Smtp-Source: ABdhPJxvroh3jGExosCdQNtms3tA8lWe1hNJRAg7BKavEOjPYB3KFqjr6Ga7fIIAt8Wm1xuyBUMlSw==
X-Received: by 2002:a63:fd03:: with SMTP id d3mr5534389pgh.76.1596683308330;
        Wed, 05 Aug 2020 20:08:28 -0700 (PDT)
Received: from localhost ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id i7sm4945160pgh.58.2020.08.05.20.08.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Aug 2020 20:08:27 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Ian Rogers <irogers@google.com>,
        Kemeng Shi <shikemeng@huawei.com>,
        James Clark <james.clark@arm.com>,
        Wei Li <liwei391@huawei.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Al Grant <Al.Grant@arm.com>, linux-kernel@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH RESEND v1 07/11] perf arm-spe: Enable attribution PERF_SAMPLE_DATA_SRC
Date:   Thu,  6 Aug 2020 11:07:23 +0800
Message-Id: <20200806030727.30267-8-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200806030727.30267-1-leo.yan@linaro.org>
References: <20200806030727.30267-1-leo.yan@linaro.org>
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

