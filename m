Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7820FC3B186
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 14:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58E7A2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 14:46:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728457AbgBJOpk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 09:45:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:58740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728264AbgBJOph (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 09:45:37 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A31A924650;
        Mon, 10 Feb 2020 14:45:36 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1j1AJb-001Vye-Ix; Mon, 10 Feb 2020 09:45:35 -0500
Message-Id: <20200210144535.457004128@goodmis.org>
User-Agent: quilt/0.65
Date:   Mon, 10 Feb 2020 09:44:58 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [for-linus][PATCH 3/4] tracing/kprobe: Fix uninitialized variable bug
References: <20200210144455.531096382@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>

There is a potential execution path in which variable *ret* is returned
without being properly initialized, previously.

Fix this by initializing variable *ret* to 0.

Link: http://lkml.kernel.org/r/20200205223404.GA3379@embeddedor

Addresses-Coverity-ID: 1491142 ("Uninitialized scalar variable")
Fixes: 2a588dd1d5d6 ("tracing: Add kprobe event command generation functions")
Reviewed-by: Tom Zanussi <zanussi@kernel.org>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_kprobe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 51efc790aea8..21bafd48f2ac 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -1012,7 +1012,7 @@ int __kprobe_event_add_fields(struct dynevent_cmd *cmd, ...)
 {
 	struct dynevent_arg arg;
 	va_list args;
-	int ret;
+	int ret = 0;
 
 	if (cmd->type != DYNEVENT_TYPE_KPROBE)
 		return -EINVAL;
-- 
2.24.1


