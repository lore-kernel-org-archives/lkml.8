Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C18AC34031
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 05:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3367B20801
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 05:29:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bRhVmrGG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbgBTF3J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 00:29:09 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39517 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbgBTF3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 00:29:08 -0500
Received: by mail-pl1-f196.google.com with SMTP id g6so1080514plp.6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 21:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3qk48O5iP5UI83BGLtFK/DPXjcS2SRQP8TVMgp2fJpo=;
        b=bRhVmrGGpBmtuhmW7mF9VhV7BpnN10S3RU3sTcIlAIM6YOGdKjZ3Muy0pfFZe2HjrE
         +ivyFn3B0QqL0Ol5NTaEMo8clTBpXV+uTp8jhp82ceKiaBLhs86pcSsLjIXMlQiYMOQn
         U7/pghcJB7bzkbFeytV2N+2VSre7MAF5HzQr4a9xJo8EdiiZV9e4SCRrsqsLuzX3baYS
         Sjr0EPpXA0sO0qCXUn903Cva3jEeYbKONPZfRXl24FlLLEG2TWe1L+i/JUlqlfkDfgcr
         AI/yVONdmuXUT8egRIDZyGN4l3PIV0VubOxrHCzNjswERFv82GKMpG494kJbaaCd4IbE
         2WdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3qk48O5iP5UI83BGLtFK/DPXjcS2SRQP8TVMgp2fJpo=;
        b=P+Jhhp+TrvLRC27Q6VPpijkYGhS/777v/ugIHjcSzhqD42zvI+ls5RXKYQJQzwFYX6
         yGR4q4T5pyr1vOLF61eCzvERfXLpBxAxJc2aPxlF7+ZHMcwSgFH6FdaA/Hmz8KUXOXHb
         2HbixwIkjThLTjOdpGSr9wQCOg74Vc4dnlfiC+JsVLx40dSdfEJc2hPmrIZ53nVUTMa4
         jj37NlI3CsZizbc9O/lNE3fpiYzOUeGp1saWbuoxlTHqMDBQDckU2I08ew2+QHcdg2Ap
         C95FZXiNZtioaTFaEF43UhxquUUkoKUalPMUfgwxbuvtohLUUbjrK0VcIMMNr1r4zMK7
         7LdQ==
X-Gm-Message-State: APjAAAWeP6T/2ieoSBU2y+PSWcGEu9kCU1f/YHnGHS/YwyBK0gBRqD0k
        6xkF5/pHmla4O+UdMivDa46XVA==
X-Google-Smtp-Source: APXvYqwRsniVe9jr9X/SxVEMR87rh2T9LKg7rl7y/G3tSgvH3gz7yNnWze0GXZlxv9TewDyIjcISZw==
X-Received: by 2002:a17:902:b617:: with SMTP id b23mr30197151pls.285.1582176547616;
        Wed, 19 Feb 2020 21:29:07 -0800 (PST)
Received: from localhost.localdomain (li1441-214.members.linode.com. [45.118.134.214])
        by smtp.gmail.com with ESMTPSA id l69sm1535663pgd.1.2020.02.19.21.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 21:29:07 -0800 (PST)
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
Subject: [PATCH v5 8/9] perf thread: Add helper to get top return address
Date:   Thu, 20 Feb 2020 13:27:00 +0800
Message-Id: <20200220052701.7754-9-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200220052701.7754-1-leo.yan@linaro.org>
References: <20200220052701.7754-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the instruction emulation or single step in kernel, when return to
the user space, the return address is not possible to be the same with
the ret_addr in thread stack.

This patch adds a helper to read out the top return address from thread
stack, this can be used for specific calibration in up case.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/thread-stack.c | 10 ++++++++++
 tools/perf/util/thread-stack.h |  1 +
 2 files changed, 11 insertions(+)

diff --git a/tools/perf/util/thread-stack.c b/tools/perf/util/thread-stack.c
index 0885967d5bc3..60cd6fdca8de 100644
--- a/tools/perf/util/thread-stack.c
+++ b/tools/perf/util/thread-stack.c
@@ -497,6 +497,16 @@ void thread_stack__sample(struct thread *thread, int cpu,
 	chain->nr = i;
 }
 
+u64 thread_stack__get_top_ret_addr(struct thread *thread, int cpu)
+{
+	struct thread_stack *ts = thread__stack(thread, cpu);
+
+	if (!ts || !ts->cnt)
+		return UINT64_MAX;
+
+	return ts->stack[ts->cnt--].ret_addr;
+}
+
 struct call_return_processor *
 call_return_processor__new(int (*process)(struct call_return *cr, u64 *parent_db_id, void *data),
 			   void *data)
diff --git a/tools/perf/util/thread-stack.h b/tools/perf/util/thread-stack.h
index e1ec5a58f1b2..b9d07a3be6c2 100644
--- a/tools/perf/util/thread-stack.h
+++ b/tools/perf/util/thread-stack.h
@@ -88,6 +88,7 @@ void thread_stack__sample(struct thread *thread, int cpu, struct ip_callchain *c
 int thread_stack__flush(struct thread *thread);
 void thread_stack__free(struct thread *thread);
 size_t thread_stack__depth(struct thread *thread, int cpu);
+u64 thread_stack__get_top_ret_addr(struct thread *thread, int cpu);
 
 struct call_return_processor *
 call_return_processor__new(int (*process)(struct call_return *cr, u64 *parent_db_id, void *data),
-- 
2.17.1

