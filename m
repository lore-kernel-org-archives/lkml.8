Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9506DC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 13:49:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BDF12076E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 13:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597931378;
	bh=kPzDIg3ULW4/+BsQ5fmrDHG5O+ojWJwe6pzGFhBe8zM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=l6Jr20KxqOKZ+92ch0eB6bL1yJS9IKfo9WZSletLCoCXVIkyf1h9hZu5HIcnSvsiL
	 7LAhJDop4L09j/0CxWAKsMaUWFABO9OqfEaIm/02xdFkzsnmVE6/Gzbh2O5NRM6eik
	 9CJgL7qDA4QadV6UjIKWdWDvN25CRfVtUf1wviB4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729102AbgHTNtg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 09:49:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:37172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727990AbgHTJ1d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:27:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D342522D03;
        Thu, 20 Aug 2020 09:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597915653;
        bh=kPzDIg3ULW4/+BsQ5fmrDHG5O+ojWJwe6pzGFhBe8zM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZEReOPI1u87GUlGNXh03o8mOAol6kXegZTE79Ny65kd4vjMy/1fNIoi1dHfzuYkGY
         vJ7EdzDIZLTpOL+BD8N5spUCX4/PAAJEWOBP6dHtFvfqLZY5P1MveWXB1IJShUlqd0
         kbGn3NYdNBD02PiNAqJZJyLM3DQFXMz1n+zbsZt4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>,
        Muchun Song <songmuchun@bytedance.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH 5.8 088/232] ftrace: Setup correct FTRACE_FL_REGS flags for module
Date:   Thu, 20 Aug 2020 11:18:59 +0200
Message-Id: <20200820091617.088880000@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091612.692383444@linuxfoundation.org>
References: <20200820091612.692383444@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chengming Zhou <zhouchengming@bytedance.com>

commit 8a224ffb3f52b0027f6b7279854c71a31c48fc97 upstream.

When module loaded and enabled, we will use __ftrace_replace_code
for module if any ftrace_ops referenced it found. But we will get
wrong ftrace_addr for module rec in ftrace_get_addr_new, because
rec->flags has not been setup correctly. It can cause the callback
function of a ftrace_ops has FTRACE_OPS_FL_SAVE_REGS to be called
with pt_regs set to NULL.
So setup correct FTRACE_FL_REGS flags for rec when we call
referenced_filters to find ftrace_ops references it.

Link: https://lkml.kernel.org/r/20200728180554.65203-1-zhouchengming@bytedance.com

Cc: stable@vger.kernel.org
Fixes: 8c4f3c3fa9681 ("ftrace: Check module functions being traced on reload")
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/trace/ftrace.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -6187,8 +6187,11 @@ static int referenced_filters(struct dyn
 	int cnt = 0;
 
 	for (ops = ftrace_ops_list; ops != &ftrace_list_end; ops = ops->next) {
-		if (ops_references_rec(ops, rec))
-		    cnt++;
+		if (ops_references_rec(ops, rec)) {
+			cnt++;
+			if (ops->flags & FTRACE_OPS_FL_SAVE_REGS)
+				rec->flags |= FTRACE_FL_REGS;
+		}
 	}
 
 	return cnt;
@@ -6367,8 +6370,8 @@ void ftrace_module_enable(struct module
 		if (ftrace_start_up)
 			cnt += referenced_filters(rec);
 
-		/* This clears FTRACE_FL_DISABLED */
-		rec->flags = cnt;
+		rec->flags &= ~FTRACE_FL_DISABLED;
+		rec->flags += cnt;
 
 		if (ftrace_start_up && cnt) {
 			int failed = __ftrace_replace_code(rec, 1);


