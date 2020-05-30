Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29260C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 12:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3D7A2073B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 12:25:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lPVjazEL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728989AbgE3MZg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 08:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728957AbgE3MZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 08:25:18 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E1B2C08C5C9
        for <linux-kernel@vger.kernel.org>; Sat, 30 May 2020 05:25:10 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id d10so1248667pgn.4
        for <linux-kernel@vger.kernel.org>; Sat, 30 May 2020 05:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2YAFqNJjM105ApHhyQ1ANOO4+Lj2OnO6M0CgdOM00k4=;
        b=lPVjazEL/C1Cd2lvIvspSqQM++WeYGU1wkOposcZvqLiQDPoquXcXnp5n2nsRTPxpG
         sRvt83txZA86zsCCygRLpPayPNhq8iE11fP6gZPNdpf8ecnR8XYcLHca8Nsc7W2TqTrD
         JPTYK2EwnW6g47QxBZ5MKcIT/035l5ZyGnU3l0E6Y9ROQLJ6AuhT6gcQ0/6994PVOh0r
         +3en0bhqUNn0IruXrXO9BptRHrvszxX4RO85fKxPARZbzoFeDcpub7YARSd8aObJncpD
         RBU0ljvX35RmiRVovz0u1PsFAHt4WJf4gYyNHbFOv9cKxQ43LCesosFUQdAnWdJuh9ND
         IWhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2YAFqNJjM105ApHhyQ1ANOO4+Lj2OnO6M0CgdOM00k4=;
        b=Bg1M6ov2/TgPoxT62Nj7/fh7bjeCZS7eBHFNxqHeDT3azZH1zZKpDOF9HuNefsvN8e
         MU4SNpGpPnEjVAwyfQsEjGv/KPUVmVwP0+MurCbqIItj51DeZKu+CdkLwuapABhgR7N1
         3RoLLrlV53oSCMhDwxFDs8PWYt+O4E29TK3h09GOTJ5yxHo8WjT8q5TG4D8uSBL+3yeU
         XihB03EHSi+8wKNI+boxjBdq+V5B6P+T8874uSQhMKluvUVyFATgfoFtsiKJ8eIYc5V+
         Ov2TB896K1lOBgPllVaEB9gHZZyWqHsMig/ELiQxvVMvQ9CbitoPFEEK+aaAMKgxDcSR
         Z2oQ==
X-Gm-Message-State: AOAM531SCVCAT7EOtKtu4JMb2jsMaGlvzV24PLmuD4Q0CIo0juZZErwB
        0Qr4rM049WOcvMdcA0hIAKbGoQ==
X-Google-Smtp-Source: ABdhPJzLsOODlGIDSzfmFqLDTQ+HvzalQIwF5Ia4d1Vs22DqNV6mIqALU+edPyhhEBFnReEJp3MaGw==
X-Received: by 2002:a62:a504:: with SMTP id v4mr12479227pfm.117.1590841509772;
        Sat, 30 May 2020 05:25:09 -0700 (PDT)
Received: from localhost ([2400:8904::f03c:91ff:fe8a:bbe4])
        by smtp.gmail.com with ESMTPSA id w73sm10134096pfd.113.2020.05.30.05.25.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 30 May 2020 05:25:09 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Al Grant <al.grant@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>
Cc:     Tan Xiaojun <tanxiaojun@huawei.com>, Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v8 2/3] perf auxtrace: Add four itrace options
Date:   Sat, 30 May 2020 20:24:41 +0800
Message-Id: <20200530122442.490-3-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200530122442.490-1-leo.yan@linaro.org>
References: <20200530122442.490-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tan Xiaojun <tanxiaojun@huawei.com>

This patch is to add four options to synthesize events which are
described as below:

 'f': synthesize first level cache events
 'm': synthesize last level cache events
 't': synthesize TLB events
 'a': synthesize remote access events

This four options will be used by ARM SPE as their first consumer.

Signed-off-by: Tan Xiaojun <tanxiaojun@huawei.com>
Signed-off-by: James Clark <james.clark@arm.com>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
Tested-by: James Clark <james.clark@arm.com>
---
 tools/perf/Documentation/itrace.txt |  6 +++++-
 tools/perf/util/auxtrace.c          | 17 +++++++++++++++++
 tools/perf/util/auxtrace.h          | 15 ++++++++++++++-
 3 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/itrace.txt b/tools/perf/Documentation/itrace.txt
index 271484754fee..e817179c5027 100644
--- a/tools/perf/Documentation/itrace.txt
+++ b/tools/perf/Documentation/itrace.txt
@@ -1,5 +1,5 @@
 		i	synthesize instructions events
-		b	synthesize branches events
+		b	synthesize branches events (branch misses for Arm SPE)
 		c	synthesize branches events (calls only)
 		r	synthesize branches events (returns only)
 		x	synthesize transactions events
@@ -9,6 +9,10 @@
 			of aux-output (refer to perf record)
 		e	synthesize error events
 		d	create a debug log
+		f	synthesize first level cache events
+		m	synthesize last level cache events
+		t	synthesize TLB events
+		a	synthesize remote access events
 		g	synthesize a call chain (use with i or x)
 		G	synthesize a call chain on existing event records
 		l	synthesize last branch entries (use with i or x)
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 8cf7d405ee67..fe76a056a179 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -1331,6 +1331,11 @@ void itrace_synth_opts__set_default(struct itrace_synth_opts *synth_opts,
 	synth_opts->pwr_events = true;
 	synth_opts->other_events = true;
 	synth_opts->errors = true;
+	synth_opts->flc = true;
+	synth_opts->llc = true;
+	synth_opts->tlb = true;
+	synth_opts->remote_access = true;
+
 	if (no_sample) {
 		synth_opts->period_type = PERF_ITRACE_PERIOD_INSTRUCTIONS;
 		synth_opts->period = 1;
@@ -1491,6 +1496,18 @@ int itrace_parse_synth_opts(const struct option *opt, const char *str,
 				goto out_err;
 			p = endptr;
 			break;
+		case 'f':
+			synth_opts->flc = true;
+			break;
+		case 'm':
+			synth_opts->llc = true;
+			break;
+		case 't':
+			synth_opts->tlb = true;
+			break;
+		case 'a':
+			synth_opts->remote_access = true;
+			break;
 		case ' ':
 		case ',':
 			break;
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index 0220a2e86c16..142ccf7d34df 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -63,6 +63,7 @@ enum itrace_period_type {
  *          because 'perf inject' will write it out
  * @instructions: whether to synthesize 'instructions' events
  * @branches: whether to synthesize 'branches' events
+ *            (branch misses only for Arm SPE)
  * @transactions: whether to synthesize events for transactions
  * @ptwrites: whether to synthesize events for ptwrites
  * @pwr_events: whether to synthesize power events
@@ -78,6 +79,10 @@ enum itrace_period_type {
  * @thread_stack: feed branches to the thread_stack
  * @last_branch: add branch context to 'instruction' events
  * @add_last_branch: add branch context to existing event records
+ * @flc: whether to synthesize first level cache events
+ * @llc: whether to synthesize last level cache events
+ * @tlb: whether to synthesize TLB events
+ * @remote_access: whether to synthesize remote access events
  * @callchain_sz: maximum callchain size
  * @last_branch_sz: branch context size
  * @period: 'instructions' events period
@@ -107,6 +112,10 @@ struct itrace_synth_opts {
 	bool			thread_stack;
 	bool			last_branch;
 	bool			add_last_branch;
+	bool			flc;
+	bool			llc;
+	bool			tlb;
+	bool			remote_access;
 	unsigned int		callchain_sz;
 	unsigned int		last_branch_sz;
 	unsigned long long	period;
@@ -596,7 +605,7 @@ bool auxtrace__evsel_is_auxtrace(struct perf_session *session,
 
 #define ITRACE_HELP \
 "				i:	    		synthesize instructions events\n"		\
-"				b:	    		synthesize branches events\n"		\
+"				b:	    		synthesize branches events (branch misses for Arm SPE)\n" \
 "				c:	    		synthesize branches events (calls only)\n"	\
 "				r:	    		synthesize branches events (returns only)\n" \
 "				x:	    		synthesize transactions events\n"		\
@@ -604,6 +613,10 @@ bool auxtrace__evsel_is_auxtrace(struct perf_session *session,
 "				p:	    		synthesize power events\n"			\
 "				e:	    		synthesize error events\n"			\
 "				d:	    		create a debug log\n"			\
+"				f:	    		synthesize first level cache events\n" \
+"				m:	    		synthesize last level cache events\n" \
+"				t:	    		synthesize TLB events\n" \
+"				a:	    		synthesize remote access events\n" \
 "				g[len]:     		synthesize a call chain (use with i or x)\n" \
 "				l[len]:     		synthesize last branch entries (use with i or x)\n" \
 "				sNUMBER:    		skip initial number of events\n"		\
-- 
2.17.1

