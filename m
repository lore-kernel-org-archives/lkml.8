Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 325F2C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:20:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 013DD20842
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581340810;
	bh=Tklai9L5ED9xc8AiYLoOZICvNWuSUY6Xwu8KGjNzcIA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wZJsxJGSExr5kDFkT+0y69pSjEJDXed3e9Ce2f++mPRqp99OTIr9aAdHALyxQAZj9
	 hN1uiHIJI9w+3EHbyMv+D2R/rgkcImWEu4y4KoWAkdvfSaERsqssZID8hM//X3fknc
	 EAcVcE2cgfCJrOFt+Ri7cNR7gUyDa1ShYuvNaFB4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730992AbgBJNUF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 08:20:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:59710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728874AbgBJMhn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:37:43 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 571452467D;
        Mon, 10 Feb 2020 12:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338263;
        bh=Tklai9L5ED9xc8AiYLoOZICvNWuSUY6Xwu8KGjNzcIA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BRQwyvEDPy/gkpSpxN3iOoEP/a5aqDvECAMSHaVQ2l2NyyhdbOm3VbXXKYvVS5PbF
         jVUsxi6PADWFv14fR+SjoQ/pog/f7VVLONclAa5HFe0+D7+RxpuJxP6GJXSvszuWAe
         iMmRzOIWPQKizh1ofCg3txLhmNJET0+mAD5jlDLY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 139/309] ftrace: Add comment to why rcu_dereference_sched() is open coded
Date:   Mon, 10 Feb 2020 04:31:35 -0800
Message-Id: <20200210122419.705169559@linuxfoundation.org>
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

From: Steven Rostedt (VMware) <rostedt@goodmis.org>

[ Upstream commit 16052dd5bdfa16dbe18d8c1d4cde2ddab9d23177 ]

Because the function graph tracer can execute in sections where RCU is not
"watching", the rcu_dereference_sched() for the has needs to be open coded.
This is fine because the RCU "flavor" of the ftrace hash is protected by
its own RCU handling (it does its own little synchronization on every CPU
and does not rely on RCU sched).

Acked-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index c4fd5731d6b37..08647723cfab9 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -943,6 +943,11 @@ static inline int ftrace_graph_addr(struct ftrace_graph_ent *trace)
 
 	preempt_disable_notrace();
 
+	/*
+	 * Have to open code "rcu_dereference_sched()" because the
+	 * function graph tracer can be called when RCU is not
+	 * "watching".
+	 */
 	hash = rcu_dereference_protected(ftrace_graph_hash, !preemptible());
 
 	if (ftrace_hash_empty(hash)) {
@@ -990,6 +995,11 @@ static inline int ftrace_graph_notrace_addr(unsigned long addr)
 
 	preempt_disable_notrace();
 
+	/*
+	 * Have to open code "rcu_dereference_sched()" because the
+	 * function graph tracer can be called when RCU is not
+	 * "watching".
+	 */
 	notrace_hash = rcu_dereference_protected(ftrace_graph_notrace_hash,
 						 !preemptible());
 
-- 
2.20.1



