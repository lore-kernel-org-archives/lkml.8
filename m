Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15207C2BA19
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 02:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDAD120728
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 02:43:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbgDXCnB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 22:43:01 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:52316 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbgDXCnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 22:43:00 -0400
Received: from fsav108.sakura.ne.jp (fsav108.sakura.ne.jp [27.133.134.235])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 03O2gwPj002141;
        Fri, 24 Apr 2020 11:42:58 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav108.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav108.sakura.ne.jp);
 Fri, 24 Apr 2020 11:42:58 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav108.sakura.ne.jp)
Received: from ccsecurity.localdomain (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 03O2gr0T001874
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 24 Apr 2020 11:42:58 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Dmitry Safonov <dima@arista.com>,
        Michal Hocko <mhocko@suse.com>,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH] printk: Add loglevel for "do not print to consoles".
Date:   Fri, 24 Apr 2020 11:42:39 +0900
Message-Id: <20200424024239.63607-1-penguin-kernel@I-love.SAKURA.ne.jp>
X-Mailer: git-send-email 2.18.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since dump_tasks() is capable of generating thousands of printk() lines,
it can significantly delay solving OOM situation by killing a process
via the OOM killer. There is /proc/sys/vm/oom_dump_tasks which allows
suppressing dump_tasks(), but those who diagnose the reason of OOM need
dump_tasks() in order to understand memory usage as of invocation of the
OOM killer. Therefore, setting /proc/sys/vm/oom_dump_tasks to 0 cannot be
an option. Also, since userspace syslog daemon is likely configured not
to save low (e.g. KERN_DEBUG) loglevels, reducing loglevel used by
dump_tasks() cannot be an option. We want to maintain current loglevels
in order to allow saving kernel messages to log files while we also want
to avoid delays caused by printing to consoles due to maintaining current
loglevels.

While an attempt to make printk() asynchronous (i.e. defer printing to
consoles) and an attempt to make printk() to print to only selected
consoles (i.e. don't print unimportant messages to slow consoles) are
in progress, there are printk() callers where saving to log files is
useful for later analysis but printing to consoles for immediate
notification makes little sense. Two examples of such printk() callers
will be the OOM killer and memory allocation failure messages. Therefore,
this patch introduces a loglevel KERN_NO_CONSOLES which prevents all
consoles from printing such messages.

Since both KERN_NO_CONSOLES messages and !KERN_NO_CONSOLES messages are
stored into common printk buffer, KERN_NO_CONSOLES messages will be
retrievable from the vmcore file even if something bad (e.g. NULL pointer
dereference) followed. Therefore, as long as a system is configured for
later analysis, ability to suppress printing to consoles will be useful.
Since Dmitry Safonov is working on adding loglevel argument to
show_stack(), we will in near future be able to control whether
dump_stack() output is important enough to immediately print to consoles,
by adding loglevel argument to dump_stack().

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Dmitry Safonov <dima@arista.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Yafang Shao <laoar.shao@gmail.com>
---
 include/linux/kern_levels.h | 3 +++
 include/linux/printk.h      | 1 +
 kernel/printk/printk.c      | 7 ++++++-
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/linux/kern_levels.h b/include/linux/kern_levels.h
index bf2389c26ae3..cd69a9cb3c2a 100644
--- a/include/linux/kern_levels.h
+++ b/include/linux/kern_levels.h
@@ -23,6 +23,9 @@
  */
 #define KERN_CONT	KERN_SOH "c"
 
+/* Annotation for "don't print to consoles". */
+#define KERN_NO_CONSOLES KERN_SOH "S"
+
 /* integer equivalents of KERN_<LEVEL> */
 #define LOGLEVEL_SCHED		-2	/* Deferred messages from sched code
 					 * are set to this special level */
diff --git a/include/linux/printk.h b/include/linux/printk.h
index e061635e0409..da338b81c2e1 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -19,6 +19,7 @@ static inline int printk_get_level(const char *buffer)
 		switch (buffer[1]) {
 		case '0' ... '7':
 		case 'c':	/* KERN_CONT */
+		case 'S':       /* KERN_NO_CONSOLES */
 			return buffer[1];
 		}
 	}
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 9a9b6156270b..ed51641af087 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -361,6 +361,7 @@ static int console_msg_format = MSG_FORMAT_DEFAULT;
  */
 
 enum log_flags {
+	LOG_NO_CONSOLES = 1,    /* don't print to consoles */
 	LOG_NEWLINE	= 2,	/* text ended with a newline */
 	LOG_CONT	= 8,	/* text is a fragment of a continuation line */
 };
@@ -1959,6 +1960,9 @@ int vprintk_store(int facility, int level,
 				break;
 			case 'c':	/* KERN_CONT */
 				lflags |= LOG_CONT;
+				break;
+			case 'S':       /* KERN_NO_CONSOLES */
+				lflags |= LOG_NO_CONSOLES;
 			}
 
 			text_len -= 2;
@@ -2453,7 +2457,8 @@ void console_unlock(void)
 			break;
 
 		msg = log_from_idx(console_idx);
-		if (suppress_message_printing(msg->level)) {
+		if ((msg->flags & LOG_NO_CONSOLES) ||
+		    suppress_message_printing(msg->level)) {
 			/*
 			 * Skip record we have buffered and already printed
 			 * directly to the console when we received it, and
-- 
2.18.2

