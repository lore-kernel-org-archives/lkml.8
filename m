Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A9CC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8ADD02078E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:59:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388710AbgFWV7J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 17:59:09 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:42034 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387455AbgFWV7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 17:59:09 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jnqwd-0002ux-QC; Tue, 23 Jun 2020 15:59:07 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jnqwc-0000mu-Qc; Tue, 23 Jun 2020 15:59:07 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     <linux-kernel@vger.kernel.org>
Cc:     <linux-fsdevel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>
References: <87pn9u6h8c.fsf@x220.int.ebiederm.org>
        <87r1u5laac.fsf@x220.int.ebiederm.org>
Date:   Tue, 23 Jun 2020 16:54:43 -0500
In-Reply-To: <87r1u5laac.fsf@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Tue, 23 Jun 2020 16:52:43 -0500")
Message-ID: <87a70tla70.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jnqwc-0000mu-Qc;;;mid=<87a70tla70.fsf_-_@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+kkhDUBissrPENOFQGDqoexIjbrQanp20=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH v2 3/6] signal: Implement SIGNAL_GROUP_DETHREAD
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


To allow signal_group_exit to be simplfied so that it can only test
signal->flags.  Add a new flag SIGNAL_GROUP_DETHREAD, that is set and
cleared where de_thread sets and clears group_exit_task today.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/exec.c                    | 3 +++
 include/linux/sched/signal.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/fs/exec.c b/fs/exec.c
index 33b5d9229c01..9c4c1ab8f715 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1145,6 +1145,7 @@ static int de_thread(struct task_struct *tsk)
 		return -EAGAIN;
 	}
 
+	sig->flags |= SIGNAL_GROUP_DETHREAD;
 	sig->group_exit_task = tsk;
 	sig->notify_count = zap_other_threads(tsk);
 	if (!thread_group_leader(tsk))
@@ -1244,6 +1245,7 @@ static int de_thread(struct task_struct *tsk)
 	}
 
 	spin_lock_irq(lock);
+	sig->flags &= ~SIGNAL_GROUP_DETHREAD;
 	sig->group_exit_task = NULL;
 	sig->notify_count = 0;
 	spin_unlock_irq(lock);
@@ -1259,6 +1261,7 @@ static int de_thread(struct task_struct *tsk)
 	/* protects against exit_notify() and __exit_signal() */
 	read_lock_irq(&tasklist_lock);
 	spin_lock(lock);
+	sig->flags &= ~SIGNAL_GROUP_DETHREAD;
 	sig->group_exit_task = NULL;
 	sig->notify_count = 0;
 	spin_unlock(lock);
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index b4f36a11be5e..5ff8697b21cd 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -253,6 +253,7 @@ struct signal_struct {
 /* Signal group actions. */
 #define SIGNAL_GROUP_EXIT	0x00000100 /* group exit in progress */
 #define SIGNAL_GROUP_COREDUMP	0x00000200 /* coredump in progress */
+#define SIGNAL_GROUP_DETHREAD	0x00000400 /* exec de_thread in progress */
 
 /* Flags applicable to the entire signal group. */
 #define SIGNAL_UNKILLABLE	0x00001000 /* for init: ignore fatal signals */
-- 
2.20.1

