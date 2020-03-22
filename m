Return-Path: <SRS0=o5Nk=5H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B4FFC54EEB
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 11:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A28F2072E
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 11:09:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AzYsiaYz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbgCVLJN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 07:09:13 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:50565 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726866AbgCVLJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 07:09:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584875351;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=UuVeC4/NGVly7qh8t4z6DXcT1v9hFLFYvhikXTFie/A=;
        b=AzYsiaYzyMwyzXJiAz6ssrFyvtFgM0Pu68Xng9hX1gpZ1GtdbrXfSCNLafzqhYTMGGOcG5
        W3lRppfEQ30TyQW67cnSnuromVLIdvFj3m4SXXV+COQycbdoUnhxIOzE7lr7x2gFBWckLP
        KFxdb55Zx7t4ysixHLlJOGReN9MGJgo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-311-zV-lPawhNWa3_kqsuXuZ7Q-1; Sun, 22 Mar 2020 07:09:06 -0400
X-MC-Unique: zV-lPawhNWa3_kqsuXuZ7Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8F208107ACC4;
        Sun, 22 Mar 2020 11:09:04 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.62])
        by smtp.corp.redhat.com (Postfix) with SMTP id 670B05C1B2;
        Sun, 22 Mar 2020 11:09:02 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Sun, 22 Mar 2020 12:09:04 +0100 (CET)
Date:   Sun, 22 Mar 2020 12:09:01 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Manfred Spraul <manfred@colorfullife.com>,
        Markus Elfring <elfring@users.sourceforge.net>,
        Yoji <yoji.fujihar.min@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] ipc/mqueue.c: change __do_notify() to bypass
 check_kill_permission()
Message-ID: <20200322110901.GA25108@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit cc731525f26a ("signal: Remove kernel interal si_code magic")
changed the value of SI_FROMUSER(SI_MESGQ), this means that mq_notify()
no longer works if the sender doesn't have rights to send a signal.

Change __do_notify() to use do_send_sig_info() instead of kill_pid_info()
to avoid check_kill_permission().

This needs the additional notify.sigev_signo != 0 check, shouldn't we
change do_mq_notify() to deny sigev_signo == 0 ?

Reported-by: Yoji <yoji.fujihar.min@gmail.com>
Fixes: cc731525f26a ("signal: Remove kernel interal si_code magic")
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 ipc/mqueue.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index 49a05ba3000d..3145fae162c1 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -775,12 +775,15 @@ static void __do_notify(struct mqueue_inode_info *info)
 	if (info->notify_owner &&
 	    info->attr.mq_curmsgs == 1) {
 		struct kernel_siginfo sig_i;
+		struct task_struct *task;
 		switch (info->notify.sigev_notify) {
 		case SIGEV_NONE:
 			break;
 		case SIGEV_SIGNAL:
+			/* do_mq_notify() accepts sigev_signo == 0, why?? */
+			if (!info->notify.sigev_signo)
+				break;
 			/* sends signal */
-
 			clear_siginfo(&sig_i);
 			sig_i.si_signo = info->notify.sigev_signo;
 			sig_i.si_errno = 0;
@@ -790,11 +793,13 @@ static void __do_notify(struct mqueue_inode_info *info)
 			rcu_read_lock();
 			sig_i.si_pid = task_tgid_nr_ns(current,
 						ns_of_pid(info->notify_owner));
-			sig_i.si_uid = from_kuid_munged(info->notify_user_ns, current_uid());
+			sig_i.si_uid = from_kuid_munged(info->notify_user_ns,
+						current_uid());
+			task = pid_task(info->notify_owner, PIDTYPE_PID);
+			if (task)
+				do_send_sig_info(info->notify.sigev_signo,
+						&sig_i, task, PIDTYPE_TGID);
 			rcu_read_unlock();
-
-			kill_pid_info(info->notify.sigev_signo,
-				      &sig_i, info->notify_owner);
 			break;
 		case SIGEV_THREAD:
 			set_cookie(info->notify_cookie, NOTIFY_WOKENUP);
-- 
2.25.1.362.g51ebf55


