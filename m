Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC32BCA90AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 16:10:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8297A20736
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 16:10:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hf+olsJC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbgELQKz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 12:10:55 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:36190 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725816AbgELQKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 12:10:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589299853;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hvH2X62DzXXWtFflMt0DqXIMg/2hBMuAh5imNtmYoRA=;
        b=Hf+olsJCoERVXl0DpSsCgj0z+r2nUcFLvl3GuFZNDUoMGkyc1tBFrdhd7meW4VyasWFyHF
        hl+jfw+L8ha6BM8l2jijzTlCFhqJtuwerMlq+V2cHloFKHE+bAZD0XIWAddK35DPBjQdBK
        k080hLX8u2uEbx6ylAyYh7onSxDjHvk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-Ohi1rfTUMXi_oTtWzQsDtA-1; Tue, 12 May 2020 12:10:49 -0400
X-MC-Unique: Ohi1rfTUMXi_oTtWzQsDtA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 54198107ACCA;
        Tue, 12 May 2020 16:10:48 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.195.92])
        by smtp.corp.redhat.com (Postfix) with SMTP id 6FF6560C05;
        Tue, 12 May 2020 16:10:46 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 12 May 2020 18:10:47 +0200 (CEST)
Date:   Tue, 12 May 2020 18:10:45 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     akpm@linux-foundation.org, peterz@infradead.org,
        paulmck@kernel.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH 2/2] kernel/sys: do not grab tasklist_lock for
 sys_setpriority(PRIO_PROCESS)
Message-ID: <20200512161044.GB28621@redhat.com>
References: <20200512000353.23653-1-dave@stgolabs.net>
 <20200512000353.23653-3-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200512000353.23653-3-dave@stgolabs.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/11, Davidlohr Bueso wrote:
>
> This option does not iterate the tasklist and we already have
> an rcu aware stable pointer. Also, the nice value is not serialized
> by this lock. Reduce the scope of this lock to just PRIO_PGRP
> and PRIO_USER - which need to to set the priorities atomically
> to the list of tasks, at least vs fork().

looks correct, but probably the PRIO_USER case can avoid tasklist too?
It can't help to avoid the race with setuid().

(PRIO_PGRP needs tasklist_lock (see my previous email) but afaics it
 can race with fork anyway, it can miss the new child which was not
 added to the list yet, I hope we do not care).

So I'd suggest a single patch instead of 1-2, but I still don't understand
your PF_EXITING check in 1/2.

Oleg.

--- x/kernel/sys.c
+++ x/kernel/sys.c
@@ -214,7 +214,6 @@ SYSCALL_DEFINE3(setpriority, int, which, int, who, int, niceval)
 		niceval = MAX_NICE;
 
 	rcu_read_lock();
-	read_lock(&tasklist_lock);
 	switch (which) {
 	case PRIO_PROCESS:
 		if (who)
@@ -229,9 +228,11 @@ SYSCALL_DEFINE3(setpriority, int, which, int, who, int, niceval)
 			pgrp = find_vpid(who);
 		else
 			pgrp = task_pgrp(current);
+		read_lock(&tasklist_lock);
 		do_each_pid_thread(pgrp, PIDTYPE_PGID, p) {
 			error = set_one_prio(p, niceval, error);
 		} while_each_pid_thread(pgrp, PIDTYPE_PGID, p);
+		read_unlock(&tasklist_lock);
 		break;
 	case PRIO_USER:
 		uid = make_kuid(cred->user_ns, who);
@@ -243,16 +244,15 @@ SYSCALL_DEFINE3(setpriority, int, which, int, who, int, niceval)
 			if (!user)
 				goto out_unlock;	/* No processes for this user */
 		}
-		do_each_thread(g, p) {
+		for_each_process_thread(g, p) {
 			if (uid_eq(task_uid(p), uid) && task_pid_vnr(p))
 				error = set_one_prio(p, niceval, error);
-		} while_each_thread(g, p);
+		}
 		if (!uid_eq(uid, cred->uid))
 			free_uid(user);		/* For find_user() */
 		break;
 	}
 out_unlock:
-	read_unlock(&tasklist_lock);
 	rcu_read_unlock();
 out:
 	return error;
@@ -277,7 +277,6 @@ SYSCALL_DEFINE2(getpriority, int, which, int, who)
 		return -EINVAL;
 
 	rcu_read_lock();
-	read_lock(&tasklist_lock);
 	switch (which) {
 	case PRIO_PROCESS:
 		if (who)
@@ -295,11 +294,13 @@ SYSCALL_DEFINE2(getpriority, int, which, int, who)
 			pgrp = find_vpid(who);
 		else
 			pgrp = task_pgrp(current);
+		read_lock(&tasklist_lock);
 		do_each_pid_thread(pgrp, PIDTYPE_PGID, p) {
 			niceval = nice_to_rlimit(task_nice(p));
 			if (niceval > retval)
 				retval = niceval;
 		} while_each_pid_thread(pgrp, PIDTYPE_PGID, p);
+		read_unlock(&tasklist_lock);
 		break;
 	case PRIO_USER:
 		uid = make_kuid(cred->user_ns, who);
@@ -311,19 +312,18 @@ SYSCALL_DEFINE2(getpriority, int, which, int, who)
 			if (!user)
 				goto out_unlock;	/* No processes for this user */
 		}
-		do_each_thread(g, p) {
+		for_each_process_thread(g, p) {
 			if (uid_eq(task_uid(p), uid) && task_pid_vnr(p)) {
 				niceval = nice_to_rlimit(task_nice(p));
 				if (niceval > retval)
 					retval = niceval;
 			}
-		} while_each_thread(g, p);
+		}
 		if (!uid_eq(uid, cred->uid))
 			free_uid(user);		/* for find_user() */
 		break;
 	}
 out_unlock:
-	read_unlock(&tasklist_lock);
 	rcu_read_unlock();
 
 	return retval;

