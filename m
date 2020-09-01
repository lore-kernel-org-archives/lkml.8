Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53215C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 08:38:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C2CD206A5
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 08:38:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dahshTwL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbgIAIiz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 04:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbgIAIij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 04:38:39 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85DD8C061245
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 01:38:39 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id e11so454691wme.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 01:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZN61VRGKoruyxXY+VGk0MPmTIsgCGWDSKRpBE0L90zU=;
        b=dahshTwLKzZgnVn5TNOBxAiTNGBy7HZtdvbl1GM6B6T8e0+EIerEKq5ZBup2fnlLFa
         nTjzIly4WDjTZCbWuIpZX08Jf94mDj0Td8DMLaBrJuqg1cjaKM+XOWqug/raIK4XF6Y4
         Oxa33nHoORpf7+gbjJtuRYvhy8xKBubduqkTtK0Y1bEVN8VdI8auoShxWGIJia1MllAy
         zFjtN+dvvPLFWynWWxjxI/BfdUFf7I0dcE7hluqcMHKfkJJ+n13skQAr7ixttivZRfPR
         tY+hqc9bMUhQ5GhW8LmSjvLyRpF+ZSY6AkfEwSSfxQAhCHtCYXu851If49gKOHeJ3U2Q
         2eug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZN61VRGKoruyxXY+VGk0MPmTIsgCGWDSKRpBE0L90zU=;
        b=S/3vxYTUtok336FFjICfhf1MC8afczQevt80sBCYjZNECwFi1DU+2DZucAmzMi9sGF
         04ZGx7oVoDBticAUt6U/rMQRN6bOMpwoVGkvXZ2T8BaMHq9tFzaaDH4exptmcysZUq+4
         MjJX8Us2MEYkMzExOGNNo7zIZ4blaCN2yyCLC22CQyV9BTx6sFSnFXpJo44y3A/JEXge
         HooIleSMp+Ty+yP+eJK9YvWEdmKdJEGUmKvrnwBGsiwGl7tF6nxdXt5gJnPndsrLZzUv
         Y62kRSxsZ5QV0iK8UGcFdIAeCJi8QAVQl89HjERC8neJNNVKSJxvM4y8tfPn1XBLY3t2
         ubRQ==
X-Gm-Message-State: AOAM533d83WKt9xs0jX8UaxpH8bMKA0aXcoCI/Dlt1eOegoYv09QaDVE
        Aq4nzNFaf1sBt2VchnZ/FM34gg==
X-Google-Smtp-Source: ABdhPJywoUzOdZdxmRJtgachQGvxPD/SEpxWOTYA4oWuE/CM4i//JAvU+jMxcpGQOrP8+mu2trrv9g==
X-Received: by 2002:a05:600c:2146:: with SMTP id v6mr645279wml.159.1598949518177;
        Tue, 01 Sep 2020 01:38:38 -0700 (PDT)
Received: from hackbox2.linaro.org ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id d190sm911260wmd.23.2020.09.01.01.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 01:38:37 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Kemeng Shi <shikemeng@huawei.com>,
        James Clark <james.clark@arm.com>,
        Wei Li <liwei391@huawei.com>, Al Grant <Al.Grant@arm.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 05/14] perf auxtrace: Add option '-M' for memory events
Date:   Tue,  1 Sep 2020 09:38:06 +0100
Message-Id: <20200901083815.13755-6-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200901083815.13755-1-leo.yan@linaro.org>
References: <20200901083815.13755-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is to add option '-M', the AUX trace data can use this option
to synthesize memory event.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/Documentation/itrace.txt | 1 +
 tools/perf/util/auxtrace.c          | 4 ++++
 tools/perf/util/auxtrace.h          | 2 ++
 3 files changed, 7 insertions(+)

diff --git a/tools/perf/Documentation/itrace.txt b/tools/perf/Documentation/itrace.txt
index d3740c8f399b..079cdfabb352 100644
--- a/tools/perf/Documentation/itrace.txt
+++ b/tools/perf/Documentation/itrace.txt
@@ -11,6 +11,7 @@
 		d	create a debug log
 		f	synthesize first level cache events
 		m	synthesize last level cache events
+		M	synthesize memory events
 		t	synthesize TLB events
 		a	synthesize remote access events
 		g	synthesize a call chain (use with i or x)
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 42a85c86421d..62e7f6c5f8b5 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -1333,6 +1333,7 @@ void itrace_synth_opts__set_default(struct itrace_synth_opts *synth_opts,
 	synth_opts->flc = true;
 	synth_opts->llc = true;
 	synth_opts->tlb = true;
+	synth_opts->mem = true;
 	synth_opts->remote_access = true;
 
 	if (no_sample) {
@@ -1554,6 +1555,9 @@ int itrace_parse_synth_opts(const struct option *opt, const char *str,
 		case 'a':
 			synth_opts->remote_access = true;
 			break;
+		case 'M':
+			synth_opts->mem = true;
+			break;
 		case 'q':
 			synth_opts->quick += 1;
 			break;
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index 951d2d14cf24..7e5c9e1552bd 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -88,6 +88,7 @@ enum itrace_period_type {
  * @llc: whether to synthesize last level cache events
  * @tlb: whether to synthesize TLB events
  * @remote_access: whether to synthesize remote access events
+ * @mem: whether to synthesize memory events
  * @callchain_sz: maximum callchain size
  * @last_branch_sz: branch context size
  * @period: 'instructions' events period
@@ -126,6 +127,7 @@ struct itrace_synth_opts {
 	bool			llc;
 	bool			tlb;
 	bool			remote_access;
+	bool			mem;
 	unsigned int		callchain_sz;
 	unsigned int		last_branch_sz;
 	unsigned long long	period;
-- 
2.20.1

