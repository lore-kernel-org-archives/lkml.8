Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD59EC3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 11:56:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9187A2068E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 11:56:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="md07E1Cu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728701AbgEDL45 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 07:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726756AbgEDL45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 07:56:57 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14BAEC061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 04:56:57 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id j21so350778pgb.7
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 04:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GCkhMjfnwBk0DNtUvJnARIqnihIjNoY60OBXaVN6s44=;
        b=md07E1CuUsuUSQQMN/4IJ4nZT8WijPeiNCpSFsuRpPwN4y3/HZvfMyKcJe1lSXq0SQ
         bmlt7w6z2PiQOMlZdWIj9HAXDPKK1h1aYT/joqcDRfwlLT6oDfFgeotmNBII2lRJ0GDb
         7npJtXt3OLyZS8T+eZTqWfF68z4yYTMGfmA2nsFKqK+MZ6uOPswX9AFCGtzfH68ikDT5
         kn3ML0MBh+BIxsKw67MLOVmlhAkj6qOLpQRBSrWla+TO4HGTngoq6T/ubGHt0HdBMVF9
         d6j8JmVw1QPOiAzkvbw8+jgOxEAulb4yC424vph/EQsJqRtgGu3tBrH4ABP3UQTthd85
         rqHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GCkhMjfnwBk0DNtUvJnARIqnihIjNoY60OBXaVN6s44=;
        b=P7zhnovhU0UIJJ54vNLFrmqaUxiLEMPPon+YrPwRfCVPemIyseUhQwE/lJro89H1ws
         lG8sMWzNgQ/ilvT7scTm1yMm7z8KqoASV2X++AuuZWVsg47UeF+mdGXdk60VD/jzW7Lc
         NZhYxlw7biHlT/YtKA+BGAQ15iOQhtTDe8Jjbj/IPuJPU9KAt+i4KGMO3OiLYDYLdo87
         S7vbyC71PG/Kqc3bZu042SlUQ4rxAp7fETOzerbIxW9cyYcgiq6nPL+XuewumX+9Qp07
         BMYDE8gUhM5Fncb1KpdJWt6AiTpx9Qk9whVWQKE21wsl2gckMHjQ3q0+rXCqH1Y48JkK
         Rfmg==
X-Gm-Message-State: AGi0PubtfgTiKjZ60nDmq2kvRj6fYbMg/VfXGbasTSqXBDOJo3LICOxF
        cBpHOMY5VC+GAYvhN0nn49prXw==
X-Google-Smtp-Source: APiQypLKu/ejHfK8I6XBtbu5HYNXbBwOtfDFEt4290Z9II+sB0mpmFr0y8OYJrwU8ylZ9X8J9/Bi9Q==
X-Received: by 2002:a63:9216:: with SMTP id o22mr15980158pgd.304.1588593416518;
        Mon, 04 May 2020 04:56:56 -0700 (PDT)
Received: from localhost ([2400:8904::f03c:91ff:fe8a:bbe4])
        by smtp.gmail.com with ESMTPSA id n23sm6777105pjq.18.2020.05.04.04.56.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 May 2020 04:56:56 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        James Clark <james.clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Al Grant <al.grant@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>
Cc:     Tan Xiaojun <tanxiaojun@huawei.com>, Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v7 2/3] perf auxtrace: Add four itrace options
Date:   Mon,  4 May 2020 19:56:24 +0800
Message-Id: <20200504115625.12589-3-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200504115625.12589-1-leo.yan@linaro.org>
References: <20200504115625.12589-1-leo.yan@linaro.org>
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
index 850113ab3e19..9d614071a267 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -1330,6 +1330,11 @@ void itrace_synth_opts__set_default(struct itrace_synth_opts *synth_opts,
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
@@ -1490,6 +1495,18 @@ int itrace_parse_synth_opts(const struct option *opt, const char *str,
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

