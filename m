Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE528C04EB5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 15:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B673214AF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 15:04:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FzBzif0c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbgBGPEi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 10:04:38 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37739 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727129AbgBGPEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 10:04:38 -0500
Received: by mail-pl1-f193.google.com with SMTP id c23so1109122plz.4
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 07:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NWcReeVPxFQUsyqNOiabJmMKrw4xIyAeqiGyEJARbUw=;
        b=FzBzif0c26bz63UUbza8ankdHil2hoE1+L2oOv4PvnYpcGJZBmj1XnWrOa/YsgbHky
         urQ2lx7mDS+gdjJBVEhUhk35XKRKREii4xy2pUgBm9QFkvbsxFdwHOsY84AaFbbNGTbM
         cvnilZjaaJusu0v3hataDjbF3cZehHbaOAgkguz87KDgJ0aYM6oFil3aToDUhC0Z0mZE
         zn4+vTs6gRwGKxJEFufufJG3wLpERyMZlz2LHFuKr3iy9/LRj+P9McRv4Qu5iqYJUuwX
         ZgmZhvdya27sBFDHkog0hUGz0cDKSStY5iO/T55dSVtCc/XKEX5OwVjzUKMkFK2/E742
         l4Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NWcReeVPxFQUsyqNOiabJmMKrw4xIyAeqiGyEJARbUw=;
        b=DjEBX48XQudw3sS+dtUai9F/pmUjeDU7NVvsJscr0E3WlwzWiLf7777nUJQefR7yMF
         QCIb1uOBF4H80nrbJspPVcm5NRblYttRGsBNQBsppd8nnyCEjeXupsQ50AK8VW/AksEu
         o18ImJGvlBBNyUiZi3JNTLw3sThBQ1/P2I8u8dCUOfT53ac0mAiI27nl11sDLXTc594u
         jjcFUCl5+K92EbR67gGbt4bdLm44Wys1lrshna2EOcEchVBr+Rud5LErGxibH7JXOFQY
         fiBH5bPiOm7Zfd4Mb2kqnubl3y4dPePb4SLiuDLjYT2s1R4U0w9slL2mPbiusdqRLMw3
         RGtw==
X-Gm-Message-State: APjAAAW9b+t5dfXrc6xmroTfeDkVNKRWBjNLWbPtZtUBwKVk7AgPhFsg
        s8FMB8JDaGjwMSE9+C7J+A==
X-Google-Smtp-Source: APXvYqwzX14uufAqEZBirHu92TvsJsk83E8+wKo4PvXEvtrFhwAdhikFaRShClMnmXjRIsRlSY/cbw==
X-Received: by 2002:a17:90a:200d:: with SMTP id n13mr4526087pjc.16.1581087877563;
        Fri, 07 Feb 2020 07:04:37 -0800 (PST)
Received: from madhuparna-HP-Notebook ([2402:3a80:545:29e1:fc5b:5bfd:1ab4:4848])
        by smtp.gmail.com with ESMTPSA id y16sm3386521pgf.41.2020.02.07.07.04.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Feb 2020 07:04:36 -0800 (PST)
From:   Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
X-Google-Original-From: Madhuparna Bhowmik <change_this_user_name@gmail.com>
Date:   Fri, 7 Feb 2020 20:34:29 +0530
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        "Eric W. Biederman" <ebiederm@gmail.com>, ebiederm@xmission.com,
        oleg@redhat.com, christian.brauner@ubuntu.com, guro@fb.com,
        tj@kernel.org, linux-kernel@vger.kernel.org, paulmck@kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org, frextrite@gmail.com
Subject: Re: [PATCH] signal.c: Fix sparse warnings
Message-ID: <20200207150429.GB10751@madhuparna-HP-Notebook>
References: <20200205172437.10113-1-madhuparnabhowmik10@gmail.com>
 <87wo90myhj.fsf@x220.int.ebiederm.org>
 <20200206110051.GA4531@madhuparna-HP-Notebook>
 <20200206202511.GC36876@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200206202511.GC36876@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 06, 2020 at 03:25:11PM -0500, Joel Fernandes wrote:
> On Thu, Feb 06, 2020 at 04:30:51PM +0530, Madhuparna Bhowmik wrote:
> > On Wed, Feb 05, 2020 at 04:59:52PM -0600, Eric W. Biederman wrote:
> > > madhuparnabhowmik10@gmail.com writes:
> > > 
> > > > From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> > > >
> > > > This patch fixes the following two sparse warnings caused due to
> > > > accessing RCU protected pointer tsk->parent without rcu primitives.
> > > >
> > > > kernel/signal.c:1948:65: warning: incorrect type in argument 1 (different address spaces)
> > > > kernel/signal.c:1948:65:    expected struct task_struct *tsk
> > > > kernel/signal.c:1948:65:    got struct task_struct [noderef] <asn:4> *parent
> > > > kernel/signal.c:1949:40: warning: incorrect type in argument 1 (different address spaces)
> > > > kernel/signal.c:1949:40:    expected void const volatile *p
> > > > kernel/signal.c:1949:40:    got struct cred const [noderef] <asn:4> *[noderef] <asn:4> *
> > > > kernel/signal.c:1949:40: warning: incorrect type in argument 1 (different address spaces)
> > > > kernel/signal.c:1949:40:    expected void const volatile *p
> > > > kernel/signal.c:1949:40:    got struct cred const [noderef] <asn:4> *[noderef] <asn:4> *
> > > >
> > > > Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> > > > ---
> > > >  kernel/signal.c | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/kernel/signal.c b/kernel/signal.c
> > > > index 9ad8dea93dbb..8227058ea8c4 100644
> > > > --- a/kernel/signal.c
> > > > +++ b/kernel/signal.c
> > > > @@ -1945,8 +1945,8 @@ bool do_notify_parent(struct task_struct *tsk, int sig)
> > > >  	 * correct to rely on this
> > > >  	 */
> > > >  	rcu_read_lock();
> > > > -	info.si_pid = task_pid_nr_ns(tsk, task_active_pid_ns(tsk->parent));
> > > > -	info.si_uid = from_kuid_munged(task_cred_xxx(tsk->parent, user_ns),
> > > > +	info.si_pid = task_pid_nr_ns(tsk, task_active_pid_ns(rcu_dereference(tsk->parent)));
> > > > +	info.si_uid = from_kuid_munged(task_cred_xxx(rcu_dereference(tsk->parent), user_ns),
> > > >  				       task_uid(tsk));
> > > >  	rcu_read_unlock();
> > > 
> > > 
> > > Still wrong because that access fundamentally depends upon the
> > > task_list_lock no the rcu_read_lock.  Things need to be consistent for
> > > longer than the rcu_read_lock is held.
> > >
> > Okay, then how about something like rcu_dereference_protected(tsk->parent, lockdep_is_held(&tasklist_lock))?
> > Let me know if this looks fine to you.
> 
> But then there are several other ->parent accesses in the function. What
> about something like the following? It removes the confusion Eric is
> referring to and fixes the sparse errors you mentioned. Thoughts?
>
Yes, I agree this should remove the confusion.

Thank you,
Madhuparna

> ---8<-----------------------
> 
> diff --git a/kernel/signal.c b/kernel/signal.c
> index bcd46f547db39..92f0b7bf70bf3 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -1909,6 +1909,7 @@ bool do_notify_parent(struct task_struct *tsk, int sig)
>  	struct sighand_struct *psig;
>  	bool autoreap = false;
>  	u64 utime, stime;
> +	struct task_struct *tsk_parent;
>  
>  	BUG_ON(sig == -1);
>  
> @@ -1918,6 +1919,9 @@ bool do_notify_parent(struct task_struct *tsk, int sig)
>  	BUG_ON(!tsk->ptrace &&
>  	       (tsk->group_leader != tsk || !thread_group_empty(tsk)));
>  
> +	tsk_parent = rcu_dereference_protected(tsk->parent,
> +					   lockdep_is_held(&tasklist_lock));
> +
>  	/* Wake up all pidfd waiters */
>  	do_notify_pidfd(tsk);
>  
> @@ -1926,7 +1930,7 @@ bool do_notify_parent(struct task_struct *tsk, int sig)
>  		 * This is only possible if parent == real_parent.
>  		 * Check if it has changed security domain.
>  		 */
> -		if (tsk->parent_exec_id != tsk->parent->self_exec_id)
> +		if (tsk->parent_exec_id != tsk_parent->self_exec_id)
>  			sig = SIGCHLD;
>  	}
>  
> @@ -1945,8 +1949,8 @@ bool do_notify_parent(struct task_struct *tsk, int sig)
>  	 * correct to rely on this
>  	 */
>  	rcu_read_lock();
> -	info.si_pid = task_pid_nr_ns(tsk, task_active_pid_ns(tsk->parent));
> -	info.si_uid = from_kuid_munged(task_cred_xxx(tsk->parent, user_ns),
> +	info.si_pid = task_pid_nr_ns(tsk, task_active_pid_ns(tsk_parent));
> +	info.si_uid = from_kuid_munged(task_cred_xxx(tsk_parent, user_ns),
>  				       task_uid(tsk));
>  	rcu_read_unlock();
>  
> @@ -1964,7 +1968,7 @@ bool do_notify_parent(struct task_struct *tsk, int sig)
>  		info.si_status = tsk->exit_code >> 8;
>  	}
>  
> -	psig = tsk->parent->sighand;
> +	psig = tsk_parent->sighand;
>  	spin_lock_irqsave(&psig->siglock, flags);
>  	if (!tsk->ptrace && sig == SIGCHLD &&
>  	    (psig->action[SIGCHLD-1].sa.sa_handler == SIG_IGN ||
> @@ -1989,8 +1993,8 @@ bool do_notify_parent(struct task_struct *tsk, int sig)
>  			sig = 0;
>  	}
>  	if (valid_signal(sig) && sig)
> -		__group_send_sig_info(sig, &info, tsk->parent);
> -	__wake_up_parent(tsk, tsk->parent);
> +		__group_send_sig_info(sig, &info, tsk_parent);
> +	__wake_up_parent(tsk, tsk_parent);
>  	spin_unlock_irqrestore(&psig->siglock, flags);
>  
>  	return autoreap;
> -- 
> 2.25.0.341.g760bfbb309-goog
> 
