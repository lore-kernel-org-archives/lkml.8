Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C108C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EEE1208A9
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:59:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388844AbgFWV7q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 17:59:46 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:51274 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387558AbgFWV7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 17:59:45 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jnqxE-0004Hk-I8; Tue, 23 Jun 2020 15:59:44 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jnqxD-0003OQ-N3; Tue, 23 Jun 2020 15:59:44 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     <linux-kernel@vger.kernel.org>
Cc:     <linux-fsdevel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>
References: <87pn9u6h8c.fsf@x220.int.ebiederm.org>
        <87r1u5laac.fsf@x220.int.ebiederm.org>
Date:   Tue, 23 Jun 2020 16:55:20 -0500
In-Reply-To: <87r1u5laac.fsf@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Tue, 23 Jun 2020 16:52:43 -0500")
Message-ID: <874kr1la5z.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jnqxD-0003OQ-N3;;;mid=<874kr1la5z.fsf_-_@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+2UXPbTw30wEkfFjbQUHoFz2avs7xxoas=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH v2 4/6] signal: In signal_group_exit remove the group_exit_task test
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


There are two places where signal_group_exit are set.  In the
fs/exec.c:de_thread() and in fs/coredump.c:zap_threads().

The coredump usage of group_exit_task was explicitly added[1]
so that signal_group_exit() would return true during a
coredump.

When examining the coredump usage it turns out that SIGNAL_GROUP_COREDUMP
is set in all of the same places as group_exit_task.  So signal_group_exit
can test SIGNAL_GROUP_COREDUMP and achieve the same results with
respect to coredumps as testing group_exit_task.

Similarly the exec code sets and clears SIGNAL_GROUP_DETHREAD in all
of the places where group_exit_task is set and cleared.

So test SIGNAL_GROUP_COREDUMP | SIGNAL_GROUP_DETHREAD instead of
group_exit_task.

Cc: Oleg Nesterov <oleg@redhat.com>
[1] 6cd8f0acae34 ("coredump: ensure that SIGKILL always kills the dumping thread")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 include/linux/sched/signal.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 5ff8697b21cd..43822e2b63e6 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -268,8 +268,9 @@ static inline void signal_set_stop_flags(struct signal_struct *sig,
 /* If true, all threads except ->group_exit_task have pending SIGKILL */
 static inline int signal_group_exit(const struct signal_struct *sig)
 {
-	return	(sig->flags & SIGNAL_GROUP_EXIT) ||
-		(sig->group_exit_task != NULL);
+	return	(sig->flags & (SIGNAL_GROUP_EXIT |
+			       SIGNAL_GROUP_COREDUMP |
+			       SIGNAL_GROUP_DETHREAD));
 }
 
 extern void flush_signals(struct task_struct *);
-- 
2.20.1

