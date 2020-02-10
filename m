Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 305D1C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:17:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06C2D2070A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581340637;
	bh=vxbJSE48AtOSQeHdAWv3a1D0R3dzmxtEgd7rqvKjSc0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jK9KfKG1QyEhR+dQR3uVM243hY0JfcY5amRhZBxgbPkq5AZ3lCYa/Az52Trr8y/zQ
	 9FF1F9GJ/J0Q34NpHZmjgnr8j2smb4RLx6IwXuCZZXk5GWXKXqw5Qxj2DsmAddahWE
	 6lzxzb2GOfe4+bMQzQE49+Rc70SF1f0xpItNN26I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731019AbgBJNRQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 08:17:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:32794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727881AbgBJMiE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:38:04 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2195E21739;
        Mon, 10 Feb 2020 12:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338284;
        bh=vxbJSE48AtOSQeHdAWv3a1D0R3dzmxtEgd7rqvKjSc0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HHWZO5yIqwRZx+mwPLD3dj526dcxK4/WoC37mUNIBZyMuxgjpBcUmaYf6SrcUOmxy
         VMNSGNa0+Lri5nIRCjcAuDrzShYCepl+tWFitzlfyyZD+bImg6PhU4v0em9J/hOz8Z
         ilZeHgdxlLsCNMnV4Z46GCI4bTM6APQVMvqhFV34=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Amol Grover <frextrite@gmail.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 137/309] tracing: Annotate ftrace_graph_hash pointer with __rcu
Date:   Mon, 10 Feb 2020 04:31:33 -0800
Message-Id: <20200210122419.524095400@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122406.106356946@linuxfoundation.org>
References: <20200210122406.106356946@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Amol Grover <frextrite@gmail.com>

[ Upstream commit 24a9729f831462b1d9d61dc85ecc91c59037243f ]

Fix following instances of sparse error
kernel/trace/ftrace.c:5664:29: error: incompatible types in comparison
kernel/trace/ftrace.c:5785:21: error: incompatible types in comparison
kernel/trace/ftrace.c:5864:36: error: incompatible types in comparison
kernel/trace/ftrace.c:5866:25: error: incompatible types in comparison

Use rcu_dereference_protected to access the __rcu annotated pointer.

Link: http://lkml.kernel.org/r/20200201072703.17330-1-frextrite@gmail.com

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Amol Grover <frextrite@gmail.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/ftrace.c | 2 +-
 kernel/trace/trace.h  | 9 ++++++---
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 0708a41cfe2de..b38c6af10da5b 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -5102,7 +5102,7 @@ static const struct file_operations ftrace_notrace_fops = {
 
 static DEFINE_MUTEX(graph_lock);
 
-struct ftrace_hash *ftrace_graph_hash = EMPTY_HASH;
+struct ftrace_hash __rcu *ftrace_graph_hash = EMPTY_HASH;
 struct ftrace_hash *ftrace_graph_notrace_hash = EMPTY_HASH;
 
 enum graph_filter_type {
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index d685c61085c0d..f8fb3786af72a 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -932,22 +932,25 @@ extern void __trace_graph_return(struct trace_array *tr,
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
+	hash = rcu_dereference_protected(ftrace_graph_hash, !preemptible());
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
2.20.1



