Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 765A2C35247
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 16:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A6542084E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 16:45:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="amxR0ufk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbgBDQpF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 11:45:05 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:39722 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727330AbgBDQpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 11:45:05 -0500
Received: by mail-pj1-f67.google.com with SMTP id e9so1620566pjr.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 08:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LvcrkfGVaVyqYp3PxmtymjbwEQgZobmEwUEZg9FpGaA=;
        b=amxR0ufkthyJ0qvUGfISZjnp12D/UvujELNV7hj5l8NXTqN820SVKf/An6xueYxnsH
         WdsRKO/8Td+kLoM3zPJDXTvoRbt4DG7nobx+aEgd/navqMRUTcHZzXTJyrtr7tjICBWZ
         bS+5PzBtocw+xfxt65j0iA19ssjA0oXicVwyqvlyTqKgHocHNHMF0Kd+kd7wUk1/6NM5
         OBO8KU5gmYe4Ppnh3t+x/3uobPYNAlXP0cgafOUYmLtu6o/YytKdTeGjRbliY7DT+HUa
         oV0cwktplTjylwHI4Wuzu4vXKWW1wvaXzvqbjqZ+w3Cj4qw8gD6yG8A+4QeCxzBGIMbx
         WaUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LvcrkfGVaVyqYp3PxmtymjbwEQgZobmEwUEZg9FpGaA=;
        b=eZEc+DrPUrNLIdE9qulTF63onKSWFdgHHZZflkGjG2krSkKsRMVabiZSwwtMPbppJL
         rwuWavt3h0zC2C7mmB6/fXQeceS6u0R4ZV73nzxYKb1sWzgBZDIkKqaPQukoVXVONyxq
         dZjj0da7CYJVCopVqNbk9qW3SBEhkXbeOl0Ibxn+B2TUPufcdr1nggBobO13KT8yI/bI
         3jdrAVgpDsMN1TLwmDnrPfHPGFMoygBnC3nYhVkF4pw9YpxV5UKaudYdXD6/E7K+/QKU
         TZrtDa0cCcQJisT2Rla2ybw7XScW9F0sX93VzA3D4+oIFgxeHGBwfyDbb/ZlblkdkPh/
         PLLQ==
X-Gm-Message-State: APjAAAUlIkfiddyvBeNkhWTpWY8nNykxrrDWi4NY1KhU2M7f3cJV3mij
        +Kb5qMSffLVMOcIxCG68eDE=
X-Google-Smtp-Source: APXvYqyrNRvFVsIbsz+itodJc3xqzJ2HZEwsR8LxK0ZUndBzqXQuE0BdoLsPEulQaXBpVAWZVIxy/g==
X-Received: by 2002:a17:902:7406:: with SMTP id g6mr30734580pll.103.1580834704599;
        Tue, 04 Feb 2020 08:45:04 -0800 (PST)
Received: from localhost.localdomain ([146.196.37.61])
        by smtp.googlemail.com with ESMTPSA id ci5sm4266173pjb.5.2020.02.04.08.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 08:45:04 -0800 (PST)
From:   Amol Grover <frextrite@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Amol Grover <frextrite@gmail.com>
Subject: [PATCH v2] tracing: Annotate ftrace_graph_hash pointer with __rcu
Date:   Tue,  4 Feb 2020 22:13:01 +0530
Message-Id: <20200204164300.15297-1-frextrite@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix following instances of sparse error
kernel/trace/ftrace.c:5664:29: error: incompatible types in comparison
kernel/trace/ftrace.c:5785:21: error: incompatible types in comparison
kernel/trace/ftrace.c:5864:36: error: incompatible types in comparison
kernel/trace/ftrace.c:5866:25: error: incompatible types in comparison

Use rcu_dereference_sched to dereference the __rcu annotated pointer.

Signed-off-by: Amol Grover <frextrite@gmail.com>
---
v2:
- Use rcu_dereference_sched instead of rcu_dereference_protected

 kernel/trace/ftrace.c | 2 +-
 kernel/trace/trace.h  | 9 ++++++---
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 9bf1f2cd515e..959ded08dc13 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -5596,7 +5596,7 @@ static const struct file_operations ftrace_notrace_fops = {
 
 static DEFINE_MUTEX(graph_lock);
 
-struct ftrace_hash *ftrace_graph_hash = EMPTY_HASH;
+struct ftrace_hash __rcu *ftrace_graph_hash = EMPTY_HASH;
 struct ftrace_hash *ftrace_graph_notrace_hash = EMPTY_HASH;
 
 enum graph_filter_type {
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 63bf60f79398..7253e8251f50 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -950,22 +950,25 @@ extern void __trace_graph_return(struct trace_array *tr,
 				 unsigned long flags, int pc);
 
 #ifdef CONFIG_DYNAMIC_FTRACE
-extern struct ftrace_hash *ftrace_graph_hash;
+extern struct ftrace_hash __rcu *ftrace_graph_hash;
 extern struct ftrace_hash *ftrace_graph_notrace_hash;
 
 static inline int ftrace_graph_addr(struct ftrace_graph_ent *trace)
 {
 	unsigned long addr = trace->func;
 	int ret = 0;
+	struct ftrace_hash *hash;
 
 	preempt_disable_notrace();
 
-	if (ftrace_hash_empty(ftrace_graph_hash)) {
+	hash = rcu_dereference_sched(ftrace_graph_hash);
+
+	if (ftrace_hash_empty(hash)) {
 		ret = 1;
 		goto out;
 	}
 
-	if (ftrace_lookup_ip(ftrace_graph_hash, addr)) {
+	if (ftrace_lookup_ip(hash, addr)) {
 
 		/*
 		 * This needs to be cleared on the return functions
-- 
2.24.1

