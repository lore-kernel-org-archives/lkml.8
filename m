Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D583DC35249
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 05:57:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 998202082E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 05:57:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O8qKu8Z/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbgBEF5c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 00:57:32 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:37112 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbgBEF5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 00:57:31 -0500
Received: by mail-pj1-f66.google.com with SMTP id m13so502425pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 21:57:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Osd6lHNiwt4HuEIAx7RCd4aai13f+0kkBfeOhTavDQg=;
        b=O8qKu8Z/sRwu52iIKxNhqY6g2mcLWqIgG91NDx4IdpOu08VotLQ426lk72n4tdkaQm
         Cf+1AUtw7WoMfyhXzI2Ak4cfUXD+fJgGGDm50IS+9g7KqWnlKNz/lffL0+SXgtJ02k4I
         yBtYeQE+aoC2a849fgvCGU0R4Tg+WhewEG8LfwJ3jN+KLM0QDyNVc6PDlR4BDiHFhYHq
         +19Lypn7J0SMvWsyuJle58aNP0ZuGZ1y6QhD70pIk0vGfTRSk1QZ7MCN5QpOyl5gY74X
         r7/3rpsf3Wz8pMgTtjnbtBudrs4Z1/MVS2C1qFYK0V5kIjrjgT2CoLNHhf8UBw3iM8Ag
         o00g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Osd6lHNiwt4HuEIAx7RCd4aai13f+0kkBfeOhTavDQg=;
        b=gNgh9108fc4RH5OGk/ANB/ND+tE0ru1HUEo58uIsdQl6U6OPauaPCQIwxHbFtYsROx
         xMLcAryaEZXhcFNa+0TEqljHShdb+g93AbrxU22U+B7GSODnRPa5tMHaDiaLrk9kLtgy
         Pko88yDMkrHtHikDrNeSMqHsxt9AsoW44HhwDWT98baMOHFxZ5SPPIVA/phRh5LZXSR6
         mN6xIAVVtn8yFJK8py9QVsCiEpPLddJa/HGQeiA0RLuxwFqf0hoxuLJzpiWz7/xZSVtY
         T4MsK07cB/woZq700NDhcDBuYKdfQqGz0ePklTlA9OjqZh7KNkWQbpHaGES4W2xqJ3ag
         ErcA==
X-Gm-Message-State: APjAAAUCjEWZA68RRmI8IFxJR9zice7/jFdI646s0b50bgwZPAN8Xn3r
        8pKPXpJpfEup3ECcxBJ6rfM=
X-Google-Smtp-Source: APXvYqwiEqw+zhsMO4I0HAA1xC9pca42gaAf9Cxcb2MrA0/GJOZ6z1gRLca+ldF3glgqLn29G//SZQ==
X-Received: by 2002:a17:902:d688:: with SMTP id v8mr34300061ply.238.1580882250911;
        Tue, 04 Feb 2020 21:57:30 -0800 (PST)
Received: from localhost.localdomain ([103.211.17.109])
        by smtp.googlemail.com with ESMTPSA id o29sm27152613pfp.124.2020.02.04.21.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 21:57:30 -0800 (PST)
From:   Amol Grover <frextrite@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Amol Grover <frextrite@gmail.com>
Subject: [PATCH] tracing: Annotate ftrace_graph_notrace_hash pointer with __rcu
Date:   Wed,  5 Feb 2020 11:27:02 +0530
Message-Id: <20200205055701.30195-1-frextrite@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix following instances of sparse error
kernel/trace/ftrace.c:5667:29: error: incompatible types in comparison
kernel/trace/ftrace.c:5813:21: error: incompatible types in comparison
kernel/trace/ftrace.c:5868:36: error: incompatible types in comparison
kernel/trace/ftrace.c:5870:25: error: incompatible types in comparison

Use rcu_dereference_protected to dereference the newly annotated pointer.

Signed-off-by: Amol Grover <frextrite@gmail.com>
---
 kernel/trace/ftrace.c | 2 +-
 kernel/trace/trace.h  | 8 ++++++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 9bf1f2cd515e..3a310c0c3ae3 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -5597,7 +5597,7 @@ static const struct file_operations ftrace_notrace_fops = {
 static DEFINE_MUTEX(graph_lock);
 
 struct ftrace_hash *ftrace_graph_hash = EMPTY_HASH;
-struct ftrace_hash *ftrace_graph_notrace_hash = EMPTY_HASH;
+struct ftrace_hash __rcu *ftrace_graph_notrace_hash = EMPTY_HASH;
 
 enum graph_filter_type {
 	GRAPH_FILTER_NOTRACE	= 0,
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 63bf60f79398..8c78bd6d53ca 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -951,7 +951,7 @@ extern void __trace_graph_return(struct trace_array *tr,
 
 #ifdef CONFIG_DYNAMIC_FTRACE
 extern struct ftrace_hash *ftrace_graph_hash;
-extern struct ftrace_hash *ftrace_graph_notrace_hash;
+extern struct ftrace_hash __rcu *ftrace_graph_notrace_hash;
 
 static inline int ftrace_graph_addr(struct ftrace_graph_ent *trace)
 {
@@ -1001,10 +1001,14 @@ static inline void ftrace_graph_addr_finish(struct ftrace_graph_ret *trace)
 static inline int ftrace_graph_notrace_addr(unsigned long addr)
 {
 	int ret = 0;
+	struct ftrace_hash *notrace_hash;
 
 	preempt_disable_notrace();
 
-	if (ftrace_lookup_ip(ftrace_graph_notrace_hash, addr))
+	notrace_hash = rcu_dereference_protected(ftrace_graph_notrace_hash,
+						 !preemptible());
+
+	if (ftrace_lookup_ip(notrace_hash, addr))
 		ret = 1;
 
 	preempt_enable_notrace();
-- 
2.24.1

