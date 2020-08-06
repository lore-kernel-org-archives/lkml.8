Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83E0EC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 16:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE29A23119
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 16:22:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726471AbgHFQWe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 12:22:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:43264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727053AbgHFQRX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 12:17:23 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 688E02311B;
        Thu,  6 Aug 2020 13:11:33 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1k3fgC-006KVA-7z; Thu, 06 Aug 2020 09:11:32 -0400
Message-ID: <20200806131132.126327427@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 06 Aug 2020 09:11:11 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>
Subject: [for-linus][PATCH 3/3] kprobes: Fix compiler warning for !CONFIG_KPROBES_ON_FTRACE
References: <20200806131108.374130743@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Muchun Song <songmuchun@bytedance.com>

Fix compiler warning(as show below) for !CONFIG_KPROBES_ON_FTRACE.

kernel/kprobes.c: In function 'kill_kprobe':
kernel/kprobes.c:1116:33: warning: statement with no effect
[-Wunused-value]
 1116 | #define disarm_kprobe_ftrace(p) (-ENODEV)
      |                                 ^
kernel/kprobes.c:2154:3: note: in expansion of macro
'disarm_kprobe_ftrace'
 2154 |   disarm_kprobe_ftrace(p);

Link: https://lore.kernel.org/r/20200805142136.0331f7ea@canb.auug.org.au
Link: https://lkml.kernel.org/r/20200805172046.19066-1-songmuchun@bytedance.com

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Fixes: 0cb2f1372baa ("kprobes: Fix NULL pointer dereference at kprobe_ftrace_handler")
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/kprobes.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 07bf03fcf574..66d14107968d 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1079,9 +1079,20 @@ static int disarm_kprobe_ftrace(struct kprobe *p)
 		ipmodify ? &kprobe_ipmodify_enabled : &kprobe_ftrace_enabled);
 }
 #else	/* !CONFIG_KPROBES_ON_FTRACE */
-#define prepare_kprobe(p)	arch_prepare_kprobe(p)
-#define arm_kprobe_ftrace(p)	(-ENODEV)
-#define disarm_kprobe_ftrace(p)	(-ENODEV)
+static inline int prepare_kprobe(struct kprobe *p)
+{
+	return arch_prepare_kprobe(p);
+}
+
+static inline int arm_kprobe_ftrace(struct kprobe *p)
+{
+	return -ENODEV;
+}
+
+static inline int disarm_kprobe_ftrace(struct kprobe *p)
+{
+	return -ENODEV;
+}
 #endif
 
 /* Arm a kprobe with text_mutex */
-- 
2.26.2


