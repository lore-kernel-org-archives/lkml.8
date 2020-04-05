Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36023C2D0F4
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 14:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09052206B8
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 14:28:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DWuY8z+5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbgDEO2L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 10:28:11 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38043 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbgDEO2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 10:28:10 -0400
Received: by mail-pl1-f196.google.com with SMTP id w3so4851721plz.5
        for <linux-kernel@vger.kernel.org>; Sun, 05 Apr 2020 07:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=EcAOXWa4VyKr8Tee/fp6EQNRoRFueOk/KVm5h9x9DC8=;
        b=DWuY8z+5St7/yeB8jaSx2cilKYU1qhNhJhsBovc9J7MKWbDhRKnZhcSGS9/Ku5PxY3
         2SOXpegxxY3HHyP1wRwBEZPow7oJ9LdTDl3pSXyt06wkFAKgN90DxFt8NaszizegUDzM
         MY14t8F65iYAft3aoBB/Z+N6H7QI7YV2ZX+XrRDy7J4CwmZWpIZFVRAAa+A17QaojFll
         iXZgpViUy2JrZ/6E4HSjJGQPaLy7tzpxyVmers4GKsG/1VrWSergAdFn/ANYT6Bs+blQ
         k7LW/Z5N/QvPh1TyaetOfOfU4vc5do6Mh9DAemXfeFZxSJ56BZno2eOgktxJHzIzmUTs
         c3vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=EcAOXWa4VyKr8Tee/fp6EQNRoRFueOk/KVm5h9x9DC8=;
        b=lpqzATWdfhpSdpj446ZxfZvTpAEXRH2NeF/vY7Mx9XYzQ/et/MbsewTffgEy9VisND
         8ygp31f5SykOcXT7Sr09uFWeSEfWUk5BfUkQRtbxwocIsmIBtmJFVEkDiUlFEiFhHvT4
         NJYbuRPGX05bjgCiHlWQdhWJAVoxcQB+gTqkcXJSjGCK0YVnUMYk/AhffehJknstsC0L
         SaLaP+yfphThyXINGLj8kvopOXHTuoTu2sdEp9mfCZE9vsa9rHRd10W6zU8Clg+nP2e6
         8Am3z5bqyIxEb/P0fGZeTLEPslJ/WJdb2VPreYj0GPuQ6fP9pczjLrgUCOTQMJrIuHQy
         r0tA==
X-Gm-Message-State: AGi0PuZrv7pDDZuA+glZYxnJuzFUkMcVxXH/lUvFKCUY4LqOhOnaLq+z
        PoX9QQTvuU6uxPPRWF7A0Z4=
X-Google-Smtp-Source: APiQypIsY85KRWKDU7WhZFGqEu+u5vs20crTSuvU6gQOc6tdLQiTt/eyD/3eW+HtBYGPdCPBpBS6bw==
X-Received: by 2002:a17:90a:14c6:: with SMTP id k64mr10835888pja.39.1586096887788;
        Sun, 05 Apr 2020 07:28:07 -0700 (PDT)
Received: from localhost.localdomain ([163.125.28.26])
        by smtp.gmail.com with ESMTPSA id r7sm9750051pfg.38.2020.04.05.07.28.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 Apr 2020 07:28:07 -0700 (PDT)
From:   ahio.lee0@gmail.com
To:     trivial@kernel.org
Cc:     Ahio Lee <ahio.lee0@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] tracing: Remove blank line before right brace '}'
Date:   Sun,  5 Apr 2020 22:27:29 +0800
Message-Id: <20200405142729.16028-1-ahio.lee0@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ahio Lee <ahio.lee0@gmail.com>

No need to insert a weird blank line before right brace '}'.

Signed-off-by: Ahio Lee <ahio.lee0@gmail.com>
---
 kernel/trace/ring_buffer.c   | 1 -
 kernel/trace/trace.c         | 2 --
 kernel/trace/trace_irqsoff.c | 1 -
 3 files changed, 4 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 61f0e92ace99..9db44db5642a 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -3095,7 +3095,6 @@ void ring_buffer_discard_commit(struct trace_buffer *buffer,
 	trace_recursive_unlock(cpu_buffer);
 
 	preempt_enable_notrace();
-
 }
 EXPORT_SYMBOL_GPL(ring_buffer_discard_commit);
 
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 6b11e4e2150c..b780934547d3 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2973,7 +2973,6 @@ static void __ftrace_trace_stack(struct trace_buffer *buffer,
 	barrier();
 	__this_cpu_dec(ftrace_stack_reserve);
 	preempt_enable_notrace();
-
 }
 
 static inline void ftrace_trace_stack(struct trace_array *tr,
@@ -8195,7 +8194,6 @@ create_trace_option_file(struct trace_array *tr,
 
 	topt->entry = trace_create_file(opt->name, 0644, t_options, topt,
 				    &trace_options_fops);
-
 }
 
 static void
diff --git a/kernel/trace/trace_irqsoff.c b/kernel/trace/trace_irqsoff.c
index 10bbb0f381d5..042452ecd18e 100644
--- a/kernel/trace/trace_irqsoff.c
+++ b/kernel/trace/trace_irqsoff.c
@@ -228,7 +228,6 @@ static void irqsoff_trace_open(struct trace_iterator *iter)
 {
 	if (is_graph(iter->tr))
 		graph_trace_open(iter);
-
 }
 
 static void irqsoff_trace_close(struct trace_iterator *iter)
-- 
2.11.0

