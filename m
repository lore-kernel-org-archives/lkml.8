Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10861C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 12:29:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8A0820810
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 12:29:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbgFAM25 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 08:28:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:36998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726232AbgFAM2I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 08:28:08 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 675F720823;
        Mon,  1 Jun 2020 12:28:08 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1jfjXz-00275G-Eg; Mon, 01 Jun 2020 08:28:07 -0400
Message-ID: <20200601122807.335170651@goodmis.org>
User-Agent: quilt/0.66
Date:   Mon, 01 Jun 2020 08:27:32 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Julia Lawall <Julia.Lawall@inria.fr>
Subject: [for-next][PATCH 03/12] tracing/probe: reverse arguments to list_add
References: <20200601122729.727113609@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Julia Lawall <Julia.Lawall@inria.fr>

Elsewhere in the file, the function trace_kprobe_has_same_kprobe uses
a trace_probe_event.probes object as the second argument of
list_for_each_entry, ie as a list head, while the list_for_each_entry
iterates over the list fields of the trace_probe structures, making
them the list elements.  So, exchange the arguments on the list_add
call to put the list head in the second argument.

Since both list_head structures were just initialized, this problem
did not cause any loss of information.

Link: https://lkml.kernel.org/r/1588879808-24488-1-git-send-email-Julia.Lawall@inria.fr

Fixes: 60d53e2c3b75 ("tracing/probe: Split trace_event related data from trace_probe")
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_probe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index ab8b6436d53f..b8a928e925c7 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -1006,7 +1006,7 @@ int trace_probe_init(struct trace_probe *tp, const char *event,
 	INIT_LIST_HEAD(&tp->event->class.fields);
 	INIT_LIST_HEAD(&tp->event->probes);
 	INIT_LIST_HEAD(&tp->list);
-	list_add(&tp->event->probes, &tp->list);
+	list_add(&tp->list, &tp->event->probes);
 
 	call = trace_probe_event_call(tp);
 	call->class = &tp->event->class;
-- 
2.26.2


