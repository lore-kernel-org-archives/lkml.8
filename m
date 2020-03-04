Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AFFBC3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 04:18:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 660C4214D8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 04:18:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgCDESy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 23:18:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:55200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725892AbgCDESy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 23:18:54 -0500
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A94C32146E;
        Wed,  4 Mar 2020 04:18:53 +0000 (UTC)
Date:   Tue, 3 Mar 2020 23:18:52 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>
Subject: [PATCH] tools lib traceevent: Remove extra '\n' in
 print_event_time()
Message-ID: <20200303231852.6ab6882f@oasis.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

If the precesion of print_event_time() is zero or greater than the
timestamp, it uses a different format. But that format had an extra new line
at the end, and caused the output to not look right:

cpus=2
           sleep-3946  [001]111264306005
: function:             inotify_inode_queue_event
           sleep-3946  [001]111264307158
: function:             __fsnotify_parent
           sleep-3946  [001]111264307637
: function:             inotify_dentry_parent_queue_event
           sleep-3946  [001]111264307989
: function:             fsnotify
           sleep-3946  [001]111264308401
: function:             audit_syscall_exit

Fixes: 38847db9740a ("libtraceevent, perf tools: Changes in tep_print_event_* APIs")
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 tools/lib/traceevent/event-parse.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/traceevent/event-parse.c b/tools/lib/traceevent/event-parse.c
index beaa8b8c08ff..e1bd2a93c6db 100644
--- a/tools/lib/traceevent/event-parse.c
+++ b/tools/lib/traceevent/event-parse.c
@@ -5541,7 +5541,7 @@ static void print_event_time(struct tep_handle *tep, struct trace_seq *s,
 	if (p10 > 1 && p10 < time)
 		trace_seq_printf(s, "%5llu.%0*llu", time / p10, prec, time % p10);
 	else
-		trace_seq_printf(s, "%12llu\n", time);
+		trace_seq_printf(s, "%12llu", time);
 }
 
 struct print_event_type {
-- 
2.20.1

