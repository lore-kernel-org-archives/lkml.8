Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DC2AC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 16:10:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6621120727
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 16:10:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UQaIJhvP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbgEPQKi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 12:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbgEPQKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 12:10:37 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA85C061A0C
        for <linux-kernel@vger.kernel.org>; Sat, 16 May 2020 09:10:37 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id b12so2201976plz.13
        for <linux-kernel@vger.kernel.org>; Sat, 16 May 2020 09:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XuUYo7fAaVl+pkn+HcNF5Gmy3Q32Dhaljcuilvq1vqc=;
        b=UQaIJhvP38huoji8qyDdm+QN6Pzawt8SQld35xCVbOG2AXuh0LxJNmP2HQwo1mOl5h
         Sx13wCzxgnwH2Iik2qOvaVvg8PDfUUziWC3T16yoS9nSoSJ1pEGJD73xJJfc2lcE33lR
         0J156v56G3s2w9xEktTWBNgMxcEn8k6TaMi9OZdhQQKr4RfH287rj5Gxgi+MSu9dDQld
         HzRpOzlNLpe1kB4RXWykkhz7ub3W/pQlTWDWLS9lSRm44NyjEnGs2/jDpTsdxdUcOZZH
         Z+D0b43ZSN5EsTegjtvlHCZRB+ydgUivbFjbySihii1I669d3dx3zao4k+sOPp0Z3fmZ
         ozEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XuUYo7fAaVl+pkn+HcNF5Gmy3Q32Dhaljcuilvq1vqc=;
        b=Gc9cJ1JzBauRP1gFNKcogqLGueX6/zrXKUu3oel2372z3O6/JO++t91QquPcq8t/Hb
         jBpMw1xv/cjM/r/GOSZcmrajHSIxna1gVoHsAvMos6ZeV/2cgMkvE8d6LeBKDnOtJQyc
         vCWgQYdxNDVcYtrWKN4LZdGE0r4TzrNk3DQUafUiz8kMOzUyBcGw86+wBXyuqI7Vt6YG
         eTk7c1rHJK3iRhCkUhjJMz3MCIl7E1nnTQjWI6pagIxiGtgKKIoez0Q4uKuk4WP49yCU
         7JiRf46zUId3XhnmbNLGXZlt1UUJChr9KRaLkodzCq6tvPNhHeuRB7TPUYx9c0fJcaoe
         RB0g==
X-Gm-Message-State: AOAM533FwU394bifPF1hT0VGxlOlJDoBBminT/QAWtaoJwyRLRbhzfd6
        7WIZEHQyt2mQz2hWOx37zFI=
X-Google-Smtp-Source: ABdhPJxtQN9S1Kx2J7tkycj95PdZ4wjpzmDbPAw+GGAnSPTUIMFSyzjndcB5W1GouVD+DoArC+AEJA==
X-Received: by 2002:a17:90a:ae0d:: with SMTP id t13mr9338022pjq.1.1589645436847;
        Sat, 16 May 2020 09:10:36 -0700 (PDT)
Received: from vultr.guest ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id y13sm4003132pfq.107.2020.05.16.09.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2020 09:10:35 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH] tracing: do not create option file latency-format
Date:   Sun, 17 May 2020 00:10:17 +0800
Message-Id: <20200516161017.155791-1-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The flag LATENCY_FMT actually is usually set by latency tracers internally.
So I think we should not export it to userspace. This patch removes the
option file 'latency-format' but keep the flag defined as usual.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 kernel/trace/trace.c | 4 ++++
 kernel/trace/trace.h | 4 +++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 29615f15a820..0d190e0021d5 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4733,6 +4733,8 @@ static int tracing_trace_options_show(struct seq_file *m, void *v)
 	trace_opts = tr->current_trace->flags->opts;
 
 	for (i = 0; trace_options[i]; i++) {
+		if (strlen(trace_options[i]) == 0)
+			continue;
 		if (tr->trace_flags & (1 << i))
 			seq_printf(m, "%s\n", trace_options[i]);
 		else
@@ -8359,6 +8361,8 @@ static void create_trace_options_dir(struct trace_array *tr)
 		return;
 
 	for (i = 0; trace_options[i]; i++) {
+		if (strlen(trace_options[i]) == 0)
+			continue;
 		if (top_level ||
 		    !((1 << i) & TOP_LEVEL_TRACE_FLAGS))
 			create_trace_option_core_file(tr, trace_options[i], i);
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 4eb1d004d5f2..6d9f0bba09c3 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1264,6 +1264,8 @@ extern void trace_parser_put(struct trace_parser *parser);
 extern int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
 	size_t cnt, loff_t *ppos);
 
+#define TRACE_OPTION_HIDE_NAME	""
+
 /*
  * Only create function graph options if function graph is configured.
  */
@@ -1321,7 +1323,7 @@ extern int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
 		C(SYM_USEROBJ,		"sym-userobj"),		\
 		C(PRINTK_MSGONLY,	"printk-msg-only"),	\
 		C(CONTEXT_INFO,		"context-info"),   /* Print pid/cpu/time */ \
-		C(LATENCY_FMT,		"latency-format"),	\
+		C(LATENCY_FMT,		TRACE_OPTION_HIDE_NAME),\
 		C(RECORD_CMD,		"record-cmd"),		\
 		C(RECORD_TGID,		"record-tgid"),		\
 		C(OVERWRITE,		"overwrite"),		\
-- 
2.25.1

