Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E62E2C3B186
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C04FA20838
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581338169;
	bh=edlHq5b5UuMqPC9yVMoxJBMe/EDH/q6DwYKRAChigTk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=r1lOzxv0FxjqFOLGOHdqCYGmkBXdN3n335OFhPnQjaT9AhQ74HgZzyjdGmviDWzzG
	 tN5RuoZqxVXwhEtZIy0gJV2C7JQU4TBzeXqldKPlZ3QAIfY7UxNCZ8wYZHbRe1FUJH
	 LIvGjszVebDo/HZ5k8sHHnNGmfsG1MVzHnzpn08A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728265AbgBJMgI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 07:36:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:53250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728059AbgBJMfk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:35:40 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 716BB21734;
        Mon, 10 Feb 2020 12:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338139;
        bh=edlHq5b5UuMqPC9yVMoxJBMe/EDH/q6DwYKRAChigTk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=klH7sAEQGgVvQK6XjTmzretxLX+itlFUIXhwSc96ClgcAX4jD7yqWiXkrjbak1fRA
         fId9+D4g6CTzoReGan4/5N3eb8WMd2m6VaALLvE4Vn0LH5ny9eTeFXJ/318sku6G/v
         QNS0X2CV2Vcq78HzV3huWy4a0T/a4/UnT7xxN3Pk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Amol Grover <frextrite@gmail.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 093/195] tracing: Annotate ftrace_graph_notrace_hash pointer with __rcu
Date:   Mon, 10 Feb 2020 04:32:31 -0800
Message-Id: <20200210122314.366076019@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122305.731206734@linuxfoundation.org>
References: <20200210122305.731206734@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Amol Grover <frextrite@gmail.com>

[ Upstream commit fd0e6852c407dd9aefc594f54ddcc21d84803d3b ]

Fix following instances of sparse error
kernel/trace/ftrace.c:5667:29: error: incompatible types in comparison
kernel/trace/ftrace.c:5813:21: error: incompatible types in comparison
kernel/trace/ftrace.c:5868:36: error: incompatible types in comparison
kernel/trace/ftrace.c:5870:25: error: incompatible types in comparison

Use rcu_dereference_protected to dereference the newly annotated pointer.

Link: http://lkml.kernel.org/r/20200205055701.30195-1-frextrite@gmail.com

Signed-off-by: Amol Grover <frextrite@gmail.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/ftrace.c | 2 +-
 kernel/trace/trace.h  | 8 ++++++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 00d987d9bd4a6..09c69ad8439ef 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -5073,7 +5073,7 @@ static const struct file_operations ftrace_notrace_fops = {
 static DEFINE_MUTEX(graph_lock);
 
 struct ftrace_hash __rcu *ftrace_graph_hash = EMPTY_HASH;
-struct ftrace_hash *ftrace_graph_notrace_hash = EMPTY_HASH;
+struct ftrace_hash __rcu *ftrace_graph_notrace_hash = EMPTY_HASH;
 
 enum graph_filter_type {
 	GRAPH_FILTER_NOTRACE	= 0,
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 70806f2f89bab..cf1a7d1f35109 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -873,7 +873,7 @@ extern void __trace_graph_return(struct trace_array *tr,
 
 #ifdef CONFIG_DYNAMIC_FTRACE
 extern struct ftrace_hash __rcu *ftrace_graph_hash;
-extern struct ftrace_hash *ftrace_graph_notrace_hash;
+extern struct ftrace_hash __rcu *ftrace_graph_notrace_hash;
 
 static inline int ftrace_graph_addr(struct ftrace_graph_ent *trace)
 {
@@ -926,10 +926,14 @@ static inline void ftrace_graph_addr_finish(struct ftrace_graph_ret *trace)
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
2.20.1



