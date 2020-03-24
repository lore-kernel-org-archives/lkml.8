Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ECCCC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 20:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E96A205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 20:09:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hDjq3SVI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbgCXUJj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 16:09:39 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:31987 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725866AbgCXUJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 16:09:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585080578;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eqAkWy7IXNHN9M1BZ9stUZFEkaMutV+Lz4dKs1zB6M8=;
        b=hDjq3SVIEQXN39zniQiTWOpm6xtjlq8Tbdnjx00Eqerd5JoLuWFl4GY9TaYkw3VDlNq0sh
        oD2lehB8wHOTyy4V6mVQ/yZHIVQGofGVck6LnRu+5cAXHBwLmRaIba+DLi9+J3yFuu8EDU
        JXpxd0aUI/c8LsIVFc1ooFV39glS3vA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-482-__sf59ASPoC-UQUUxMQR7Q-1; Tue, 24 Mar 2020 16:09:36 -0400
X-MC-Unique: __sf59ASPoC-UQUUxMQR7Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 20091800EB6;
        Tue, 24 Mar 2020 20:09:35 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.27])
        by smtp.corp.redhat.com (Postfix) with SMTP id 3F62419C6A;
        Tue, 24 Mar 2020 20:09:33 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 24 Mar 2020 21:09:34 +0100 (CET)
Date:   Tue, 24 Mar 2020 21:09:32 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Manfred Spraul <manfred@colorfullife.com>,
        Markus Elfring <elfring@users.sourceforge.net>,
        Yoji <yoji.fujihar.min@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH V2] ipc/mqueue.c: change __do_notify() to bypass
 check_kill_permission()
Message-ID: <20200324200932.GB24230@redhat.com>
References: <20200322110901.GA25108@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200322110901.GA25108@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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

Test-case:

	#include <signal.h>
	#include <mqueue.h>
	#include <unistd.h>
	#include <sys/wait.h>
	#include <assert.h>

	static int notified;

	static void sigh(int sig)
	{
		notified = 1;
	}

	int main(void)
	{
		signal(SIGIO, sigh);

		int fd = mq_open("/mq", O_RDWR|O_CREAT, 0666, NULL);
		assert(fd >= 0);

		struct sigevent se = {
			.sigev_notify	= SIGEV_SIGNAL,
			.sigev_signo	= SIGIO,
		};
		assert(mq_notify(fd, &se) == 0);

		if (!fork()) {
			assert(setuid(1) == 0);
			mq_send(fd, "",1,0);
			return 0;
		}

		wait(NULL);
		mq_unlink("/mq");
		assert(notified);
		return 0;
	}

Reported-by: Yoji <yoji.fujihar.min@gmail.com>
Fixes: cc731525f26a ("signal: Remove kernel interal si_code magic")
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 ipc/mqueue.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index 49a05ba3000d..63b164932ffd 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -774,28 +774,40 @@ static void __do_notify(struct mqueue_inode_info *info)
 	 * synchronously. */
 	if (info->notify_owner &&
 	    info->attr.mq_curmsgs == 1) {
-		struct kernel_siginfo sig_i;
 		switch (info->notify.sigev_notify) {
 		case SIGEV_NONE:
 			break;
-		case SIGEV_SIGNAL:
-			/* sends signal */
+		case SIGEV_SIGNAL: {
+			struct kernel_siginfo sig_i;
+			struct task_struct *task;
+
+			/* do_mq_notify() accepts sigev_signo == 0, why?? */
+			if (!info->notify.sigev_signo)
+				break;
 
 			clear_siginfo(&sig_i);
 			sig_i.si_signo = info->notify.sigev_signo;
 			sig_i.si_errno = 0;
 			sig_i.si_code = SI_MESGQ;
 			sig_i.si_value = info->notify.sigev_value;
-			/* map current pid/uid into info->owner's namespaces */
 			rcu_read_lock();
+			/* map current pid/uid into info->owner's namespaces */
 			sig_i.si_pid = task_tgid_nr_ns(current,
 						ns_of_pid(info->notify_owner));
-			sig_i.si_uid = from_kuid_munged(info->notify_user_ns, current_uid());
+			sig_i.si_uid = from_kuid_munged(info->notify_user_ns,
+						current_uid());
+			/*
+			 * We can't use kill_pid_info(), this signal should
+			 * bypass check_kill_permission(). It is from kernel
+			 * but si_fromuser() can't know this.
+			 */
+			task = pid_task(info->notify_owner, PIDTYPE_PID);
+			if (task)
+				do_send_sig_info(info->notify.sigev_signo,
+						&sig_i, task, PIDTYPE_TGID);
 			rcu_read_unlock();
-
-			kill_pid_info(info->notify.sigev_signo,
-				      &sig_i, info->notify_owner);
 			break;
+		}
 		case SIGEV_THREAD:
 			set_cookie(info->notify_cookie, NOTIFY_WOKENUP);
 			netlink_sendskb(info->notify_sock, info->notify_cookie);
-- 
2.25.1.362.g51ebf55


