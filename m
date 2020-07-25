Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60683C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 00:51:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CC3820674
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 00:51:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="VRV+Ct2a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbgGYAuw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 20:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbgGYAuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 20:50:51 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A43AC0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 17:50:51 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id l23so10409215qkk.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 17:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DK+xddklBD9RksRVcEYJ/WnD6RhMI19p3y2mblC/0iE=;
        b=VRV+Ct2aqcVwiNM2zzqo9FVLOrxLLoRfYV/Vlz7jdaHJJFy0PkKcpATM7RXzPjiUl9
         MxmmhCY5Yy6Ess7Qfk08THvDiRvHD0FWDBS0ShkjEM39XDa2+Ik6/u3i8e1v6d4i8jrR
         /sOJGDcvB+nI3/PGdvIYKlPqvDVvUhi/iNdHMU4xTT0NK/LDm+LfdMr8HO0B6xSu5o1s
         WIgVy9qdVSGWOO07vOyJnT5RN1g2WKhZ+cp4IAaGwgON60mL/J+qiV23pQJIweIT/2nn
         ye3Hvh/V23YrJhYj68/b2aDgE1ublKbfcmb4efsN0C3F6b/8dWQrygzNgI01hxlTBSy7
         ujJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DK+xddklBD9RksRVcEYJ/WnD6RhMI19p3y2mblC/0iE=;
        b=jgpZhBkr+LQDwiBabjJE1GeSzBXt4agFlVJSvubuL++Wt66Tp2wjn6vRz1L9UIucUx
         4yOhz7hI8tXvU8q7HP/nIffQgLCmm9S04KKhb+nYqSIhJaf/OQpmDbPgwXV3yARhtUmm
         KAllhRl8q0rbxms1o+ddKDp7z1HyFbZOG+feTmM8S0EEg5yiulU/b2gHGbRw4k2Ut8CZ
         q886+w2Ymu7cJ8+nTjMzUSk6zP73dAF84j2s41C1bd7FEPlBuk1wyDliHuGt8nbj0Txz
         ZKjEb0PRBnrGsqoUbbLX8+cBwQvc3EZd6xXSN6v82B11AXldNVClcGbJvicAR0fWExWD
         fbqg==
X-Gm-Message-State: AOAM530ngATVhx/xuZw4g6vWpAFKNCyPZkOeJJxtvOlcrTgazIQNip8t
        N6mclsWD+U6wcglmEhNJfINd/Q==
X-Google-Smtp-Source: ABdhPJzSixdFnKwoNquqKzR0a0xq3w5pZ3JNkNPGHhX9ge9lqWGqUmtREgV0crdG+ZLUi5MtiremAA==
X-Received: by 2002:a37:4d85:: with SMTP id a127mr13069961qkb.338.1595638250157;
        Fri, 24 Jul 2020 17:50:50 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id o184sm8975398qkd.41.2020.07.24.17.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 17:50:49 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     kernel-team@fb.com, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, mingo@redhat.com
Subject: [PATCH] ftrace: fix ftrace_trace_task return value
Date:   Fri, 24 Jul 2020 20:50:48 -0400
Message-Id: <20200725005048.1790-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I was attempting to use pid filtering with function_graph, but it wasn't
allowing anything to make it through.  Turns out ftrace_trace_task
returns false if ftrace_ignore_pid is not-empty, which isn't correct
anymore.  We're now setting it to FTRACE_PID_IGNORE if we need to ignore
that pid, otherwise it's set to the pid (which is weird considering the
name) or to FTRACE_PID_TRACE.  Fix the check to check for !=
FTRACE_PID_IGNORE.  With this we can now use function_graph with pid
filtering.

Fixes: 717e3f5ebc82 ("ftrace: Make function trace pid filtering a bit more exact")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel/trace/ftrace.c | 3 ---
 kernel/trace/trace.h  | 7 ++++++-
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 1903b80db6eb..7d879fae3777 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -139,9 +139,6 @@ static inline void ftrace_ops_init(struct ftrace_ops *ops)
 #endif
 }
 
-#define FTRACE_PID_IGNORE	-1
-#define FTRACE_PID_TRACE	-2
-
 static void ftrace_pid_func(unsigned long ip, unsigned long parent_ip,
 			    struct ftrace_ops *op, struct pt_regs *regs)
 {
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 13db4000af3f..1531ec565cb5 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1103,6 +1103,10 @@ print_graph_function_flags(struct trace_iterator *iter, u32 flags)
 extern struct list_head ftrace_pids;
 
 #ifdef CONFIG_FUNCTION_TRACER
+
+#define FTRACE_PID_IGNORE	-1
+#define FTRACE_PID_TRACE	-2
+
 struct ftrace_func_command {
 	struct list_head	list;
 	char			*name;
@@ -1114,7 +1118,8 @@ struct ftrace_func_command {
 extern bool ftrace_filter_param __initdata;
 static inline int ftrace_trace_task(struct trace_array *tr)
 {
-	return !this_cpu_read(tr->array_buffer.data->ftrace_ignore_pid);
+	return this_cpu_read(tr->array_buffer.data->ftrace_ignore_pid) !=
+		FTRACE_PID_IGNORE;
 }
 extern int ftrace_is_dead(void);
 int ftrace_create_function_files(struct trace_array *tr,
-- 
2.24.1

