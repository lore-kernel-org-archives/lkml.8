Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 260D8C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 12:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09364206CD
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 12:27:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbgHaM07 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 08:26:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:35808 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726468AbgHaM0e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 08:26:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 67098B7DB;
        Mon, 31 Aug 2020 12:26:33 +0000 (UTC)
From:   Miroslav Benes <mbenes@suse.cz>
To:     rostedt@goodmis.org, mingo@redhat.com
Cc:     peterz@infradead.org, adrian.hunter@intel.com,
        masami.hiramatsu.pt@hitachi.com, linux-kernel@vger.kernel.org,
        Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH] ftrace: Free the trampoline when ftrace_startup() fails
Date:   Mon, 31 Aug 2020 14:26:31 +0200
Message-Id: <20200831122631.28057-1-mbenes@suse.cz>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit fc0ea795f53c ("ftrace: Add symbols for ftrace trampolines")
missed to remove ops from new ftrace_ops_trampoline_list in
ftrace_startup() if ftrace_hash_ipmodify_enable() fails there. It may
lead to BUG if such ops come from a module which may be removed.

Moreover, the trampoline itself is not freed in this case.

Fix it by calling ftrace_trampoline_free() during the rollback.

Fixes: fc0ea795f53c ("ftrace: Add symbols for ftrace trampolines")
Signed-off-by: Miroslav Benes <mbenes@suse.cz>
---

It would be fair to add

Fixes: f8b8be8a310a ("ftrace, kprobes: Support IPMODIFY flag to find IP modify conflict")

too. The situation was a bit more complicated back then though since
RCU-tasks support was missing.

 kernel/trace/ftrace.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 275441254bb5..656d7cb5a78c 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -2862,6 +2862,8 @@ int ftrace_startup(struct ftrace_ops *ops, int command)
 		__unregister_ftrace_function(ops);
 		ftrace_start_up--;
 		ops->flags &= ~FTRACE_OPS_FL_ENABLED;
+		if (ops->flags & FTRACE_OPS_FL_DYNAMIC)
+			ftrace_trampoline_free(ops);
 		return ret;
 	}
 
-- 
2.28.0

