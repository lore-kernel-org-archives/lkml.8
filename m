Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0843C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEF3020CC7
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588778691;
	bh=6aL5rrHW/YWhwWzOMpVAdz3C4Xy3266/7gDhyYMd0qU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=F09Wwx4tzg2IpE6/lp4WJSA98njcoGod7WxDvSi7SU0muxGQiKXGXM/C9+0cY9i3v
	 l4MqrHk5dbMy4VazHYSgbpAoDTGp04RU27mc5i8qnbC6dMk+t9+/fK8p51NmpWqNzi
	 9Q/pZfprNNozWt8/AnMtDVd5IXdiEwKZeBkh2+BI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729932AbgEFPYu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 11:24:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:43308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729921AbgEFPYr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 11:24:47 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0477921841;
        Wed,  6 May 2020 15:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588778686;
        bh=6aL5rrHW/YWhwWzOMpVAdz3C4Xy3266/7gDhyYMd0qU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0RueMxAgP0eJCHhAdyv3ZwLhx46k3OzElrTPln+vjXmGYIVzrO8IRN+P+5Qln38GW
         Y9yiLdV0oS56SH3xCLqpLhDIemaZneqth4FBDrfKZpsc+wyIl/cO6IOh/sCbKZhz3a
         V+fdWitlnIdXoM4RsiCmkrhAGQaCxrw8PJ8evdWU=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        clang-built-linux@googlegroups.com,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 33/91] perf parse-events: Fix memory leaks found on parse_events
Date:   Wed,  6 May 2020 12:21:36 -0300
Message-Id: <20200506152234.21977-34-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200506152234.21977-1-acme@kernel.org>
References: <20200506152234.21977-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ian Rogers <irogers@google.com>

Fix a memory leak found by applying LLVM's libfuzzer on parse_events().

Signed-off-by: Ian Rogers <irogers@google.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: clang-built-linux@googlegroups.com
Link: http://lore.kernel.org/lkml/20200319023101.82458-1-irogers@google.com
[ split from a larger patch, use zfree() ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/parse-events.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 5795f3a8f71c..6dc9e57ab95b 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1482,6 +1482,7 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
 
 		list_for_each_entry_safe(pos, tmp, &config_terms, list) {
 			list_del_init(&pos->list);
+			zfree(&pos->val.str);
 			free(pos);
 		}
 		return -EINVAL;
-- 
2.21.1

