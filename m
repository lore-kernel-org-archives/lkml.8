Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 187B1C4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 14:11:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF04821655
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 14:11:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbgCSOLu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 10:11:50 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:32865 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727982AbgCSOLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 10:11:14 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jEvt5-0002Jx-7U; Thu, 19 Mar 2020 15:11:07 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 56D501C22B1;
        Thu, 19 Mar 2020 15:10:54 +0100 (CET)
Date:   Thu, 19 Mar 2020 14:10:54 -0000
From:   "tip-bot2 for Steven Rostedt (VMware)" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] tools lib traceevent: Remove extra '\n' in
 print_event_time()
Cc:     "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200303231852.6ab6882f@oasis.local.home>
References: <20200303231852.6ab6882f@oasis.local.home>
MIME-Version: 1.0
Message-ID: <158462705403.28353.16455653786760721281.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     401d61cbd4d4c6b44b2a895ab4073c7f214c096b
Gitweb:        https://git.kernel.org/tip/401d61cbd4d4c6b44b2a895ab4073c7f214c096b
Author:        Steven Rostedt (VMware) <rostedt@goodmis.org>
AuthorDate:    Tue, 03 Mar 2020 23:18:52 -05:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Wed, 04 Mar 2020 10:34:10 -03:00

tools lib traceevent: Remove extra '\n' in print_event_time()

If the precision of print_event_time() is zero or greater than the
timestamp, it uses a different format. But that format had an extra new
line at the end, and caused the output to not look right:

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
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lore.kernel.org/lkml/20200303231852.6ab6882f@oasis.local.home
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/traceevent/event-parse.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/traceevent/event-parse.c b/tools/lib/traceevent/event-parse.c
index beaa8b8..e1bd2a9 100644
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
