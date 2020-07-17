Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB56C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 12:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B404D206BE
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 12:27:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X6fk95Iq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726221AbgGQM1A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 08:27:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26950 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726056AbgGQM07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 08:26:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594988818;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KP6z2JAFlKJzeK81Po09Cqg+RcRw4LyY6eOEY43EWjw=;
        b=X6fk95IqSOpa3dI8GKA17UoM2nPPubrZ/QhpI9utntJMKGQhSHtwtZatHt637p+ehR2dsT
        xcdKBlgUOrgDayE+U9h5Kn+8IHXZHaGMqMWj7F4FtX9t2gdUDvf/Ju+LcT1XTk7BMiyNGp
        A9XJDuA2NhqMNE19FNpVn//S0o9mEdI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-33-c78cKYkwPoeOQHF-2z6eZA-1; Fri, 17 Jul 2020 08:26:56 -0400
X-MC-Unique: c78cKYkwPoeOQHF-2z6eZA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 438B4100AA2A;
        Fri, 17 Jul 2020 12:26:55 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.194.199])
        by smtp.corp.redhat.com (Postfix) with SMTP id 1CE5C79502;
        Fri, 17 Jul 2020 12:26:52 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri, 17 Jul 2020 14:26:54 +0200 (CEST)
Date:   Fri, 17 Jul 2020 14:26:51 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     christian@brauner.io, "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 5.8-rc*: kernel BUG at kernel/signal.c:1917
Message-ID: <20200717122651.GA6067@redhat.com>
References: <6b253b55-586d-0bc4-9f58-c45c631abc60@kernel.org>
 <5a8c4c38-7aeb-981a-8d3b-a7a5c8ca5564@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a8c4c38-7aeb-981a-8d3b-a7a5c8ca5564@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/17, Jiri Slaby wrote:
>
> On 17. 07. 20, 12:45, Jiri Slaby wrote:
> > Hi,
> >
> > the strace testsuite triggers this on 5.8-rc4 and -rc5 both on x86_64
> > and i586:
>
> make check needs -jsomething, running is sequentially (-j1) doesn't
> trigger it. After the error, I cannot run anything. Like ps to find out
> what test caused the crash...

Strange... I'll try to reproduce but I can't do this till Monday.

Meanwhile, could you try the patch below? It needs CONFIG_DEBUG_ATOMIC_SLEEP.

Oleg.

diff --git a/kernel/signal.c b/kernel/signal.c
index ee22ec78fd6d..84782843eb1c 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1914,7 +1914,9 @@ bool do_notify_parent(struct task_struct *tsk, int sig)
 	BUG_ON(sig == -1);
 
  	/* do_notify_parent_cldstop should have been called instead.  */
- 	BUG_ON(task_is_stopped_or_traced(tsk));
+ 	WARN(task_is_stopped_or_traced(tsk),
+ 		"exist with state=%ld set at %pS",
+ 		tsk->state, (void*)tsk->task_state_change);
 
 	BUG_ON(!tsk->ptrace &&
 	       (tsk->group_leader != tsk || !thread_group_empty(tsk)));
@@ -2214,6 +2216,7 @@ static void ptrace_stop(int exit_code, int why, int clear_code, kernel_siginfo_t
 		preempt_enable_no_resched();
 		freezable_schedule();
 		cgroup_leave_frozen(true);
+		WARN_ON(current->state);
 	} else {
 		/*
 		 * By the time we got the lock, our tracer went away.
@@ -2393,6 +2396,7 @@ static bool do_signal_stop(int signr)
 		/* Now we don't run again until woken by SIGCONT or SIGKILL */
 		cgroup_enter_frozen();
 		freezable_schedule();
+		WARN_ON(current->state);
 		return true;
 	} else {
 		/*

