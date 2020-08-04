Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C2FC433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 20:58:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECD5522D03
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 20:58:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728331AbgHDU6W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 16:58:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:42170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728068AbgHDU6Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 16:58:16 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E087022B45;
        Tue,  4 Aug 2020 20:58:13 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1k340i-006HBu-Sw; Tue, 04 Aug 2020 16:58:12 -0400
Message-ID: <20200804205812.775534405@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 04 Aug 2020 16:57:49 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chengming Zhou <zhouchengming@bytedance.com>,
        Muchun Song <songmuchun@bytedance.com>
Subject: [for-linus][PATCH 06/17] ftrace: Do not let direct or IPMODIFY ftrace_ops be added to module
 and set trampolines
References: <20200804205743.419135730@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chengming Zhou <zhouchengming@bytedance.com>

When inserting a module, we find all ftrace_ops referencing it on the
ftrace_ops_list. But FTRACE_OPS_FL_DIRECT and FTRACE_OPS_FL_IPMODIFY
flags are special, and should not be set automatically. So warn and
skip ftrace_ops that have these two flags set and adding new code.
Also check if only one ftrace_ops references the module, in which case
we can use a trampoline as an optimization.

Link: https://lkml.kernel.org/r/20200728180554.65203-2-zhouchengming@bytedance.com

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index d052f856f1cf..f433cb44300a 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -6199,9 +6199,17 @@ static int referenced_filters(struct dyn_ftrace *rec)
 
 	for (ops = ftrace_ops_list; ops != &ftrace_list_end; ops = ops->next) {
 		if (ops_references_rec(ops, rec)) {
+			if (WARN_ON_ONCE(ops->flags & FTRACE_OPS_FL_DIRECT))
+				continue;
+			if (WARN_ON_ONCE(ops->flags & FTRACE_OPS_FL_IPMODIFY))
+				continue;
 			cnt++;
 			if (ops->flags & FTRACE_OPS_FL_SAVE_REGS)
 				rec->flags |= FTRACE_FL_REGS;
+			if (cnt == 1 && ops->trampoline)
+				rec->flags |= FTRACE_FL_TRAMP;
+			else
+				rec->flags &= ~FTRACE_FL_TRAMP;
 		}
 	}
 
-- 
2.26.2


