Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC5BC2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 11:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F6DD206CC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 11:07:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O7G9Vc2A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbgBFLH2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 06:07:28 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35122 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727478AbgBFLH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 06:07:27 -0500
Received: by mail-pf1-f193.google.com with SMTP id y73so2970259pfg.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 03:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=B8bvNpykVDgQC9hk3603Rl2GIFzoG6wwUdwHDUabs1k=;
        b=O7G9Vc2AuE7mWt1YBeW9+Ncjcl07/rGGQN4eDuXaG/UUfLFuxP67P/JA+D+N76FpW3
         xmMRSR/LhBebqdf6QRe8A0SeF3nIYkxiQqEekdjDPArG7ziwyIeiA5IoibNZrhxP4U2l
         9lr/87MlY0pDwN7xQ9BYGahOhhJLdYRua93qFY8i1S8Ys1MIW5v6fIuw6fE01GtRztld
         XnSAQyEzMPlVl05jaW/a9RiELZgQw/N3jXa0G+JEIWQrXUvAT6ZdH7+5jmHPdYcaq/z8
         +LleDSauaxtYE9cmn0D7JE3m8fpEEzUCcNOrJ6fmhQCyF0NTUNPLP954mm8i7rRobQOZ
         kAqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=B8bvNpykVDgQC9hk3603Rl2GIFzoG6wwUdwHDUabs1k=;
        b=O/ZlJD35HQC/05NatRCS9ZECtkn0l8LYRBZYF6AQEL77zuWyGXbC1czAVjSxHdyNc0
         MVNPv13SE6zpcW/+nKGMPewXq7PDSIgLQ1GeQvZeugoekYy09DfvSiJ1jSl7a+U64Q30
         An/IdSQadlXaFKmiJgi2dGAQFOy5zgThEzQNgAOgVKvvIK+UtXWfNY9liiNpFFDLqCMT
         AyVxBnNRWPt7TBMAYweFKm7kwZYZTesGRtJNLlgTsmydjooThOrAAy8tvSztrUdFcgbu
         IwiSPbnE3+p5Qg37y1sMJywq72MJ7+Tgxi+WycH40psrZDCdL/YyI1KuR3p9ITNjvg8c
         1FbA==
X-Gm-Message-State: APjAAAU9CdF4uY9iBlB+5H7pH9dFDgr3aJ5U+g5gFeJ8/bi4bD93JQvh
        PRsoAn7eJP2Dixqu1HfkXLG1IwU=
X-Google-Smtp-Source: APXvYqz0wz9KCKiUmNhqSDan+ujm7+gwNzv7SyueZhaDtSnhgiRcO6R1GnrXKZ+e1JtT1HIrlYl7rQ==
X-Received: by 2002:a17:902:9b93:: with SMTP id y19mr3063945plp.89.1580986859115;
        Thu, 06 Feb 2020 03:00:59 -0800 (PST)
Received: from madhuparna-HP-Notebook ([218.248.46.83])
        by smtp.gmail.com with ESMTPSA id y75sm3068441pfb.116.2020.02.06.03.00.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Feb 2020 03:00:58 -0800 (PST)
From:   Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
X-Google-Original-From: Madhuparna Bhowmik <change_this_user_name@gmail.com>
Date:   Thu, 6 Feb 2020 16:30:51 +0530
To:     "Eric W. Biederman" <ebiederm@gmail.com>
Cc:     madhuparnabhowmik10@gmail.com, ebiederm@xmission.com,
        oleg@redhat.com, christian.brauner@ubuntu.com, guro@fb.com,
        tj@kernel.org, linux-kernel@vger.kernel.org, paulmck@kernel.org,
        joel@joelfernandes.org,
        linux-kernel-mentees@lists.linuxfoundation.org, frextrite@gmail.com
Subject: Re: [PATCH] signal.c: Fix sparse warnings
Message-ID: <20200206110051.GA4531@madhuparna-HP-Notebook>
References: <20200205172437.10113-1-madhuparnabhowmik10@gmail.com>
 <87wo90myhj.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wo90myhj.fsf@x220.int.ebiederm.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 05, 2020 at 04:59:52PM -0600, Eric W. Biederman wrote:
> madhuparnabhowmik10@gmail.com writes:
> 
> > From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> >
> > This patch fixes the following two sparse warnings caused due to
> > accessing RCU protected pointer tsk->parent without rcu primitives.
> >
> > kernel/signal.c:1948:65: warning: incorrect type in argument 1 (different address spaces)
> > kernel/signal.c:1948:65:    expected struct task_struct *tsk
> > kernel/signal.c:1948:65:    got struct task_struct [noderef] <asn:4> *parent
> > kernel/signal.c:1949:40: warning: incorrect type in argument 1 (different address spaces)
> > kernel/signal.c:1949:40:    expected void const volatile *p
> > kernel/signal.c:1949:40:    got struct cred const [noderef] <asn:4> *[noderef] <asn:4> *
> > kernel/signal.c:1949:40: warning: incorrect type in argument 1 (different address spaces)
> > kernel/signal.c:1949:40:    expected void const volatile *p
> > kernel/signal.c:1949:40:    got struct cred const [noderef] <asn:4> *[noderef] <asn:4> *
> >
> > Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> > ---
> >  kernel/signal.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/signal.c b/kernel/signal.c
> > index 9ad8dea93dbb..8227058ea8c4 100644
> > --- a/kernel/signal.c
> > +++ b/kernel/signal.c
> > @@ -1945,8 +1945,8 @@ bool do_notify_parent(struct task_struct *tsk, int sig)
> >  	 * correct to rely on this
> >  	 */
> >  	rcu_read_lock();
> > -	info.si_pid = task_pid_nr_ns(tsk, task_active_pid_ns(tsk->parent));
> > -	info.si_uid = from_kuid_munged(task_cred_xxx(tsk->parent, user_ns),
> > +	info.si_pid = task_pid_nr_ns(tsk, task_active_pid_ns(rcu_dereference(tsk->parent)));
> > +	info.si_uid = from_kuid_munged(task_cred_xxx(rcu_dereference(tsk->parent), user_ns),
> >  				       task_uid(tsk));
> >  	rcu_read_unlock();
> 
> 
> Still wrong because that access fundamentally depends upon the
> task_list_lock no the rcu_read_lock.  Things need to be consistent for
> longer than the rcu_read_lock is held.
>
Okay, then how about something like rcu_dereference_protected(tsk->parent, lockdep_is_held(&tasklist_lock))?
Let me know if this looks fine to you.

Thank you,
Madhuparna

> This patch makes sparse happy and confuses programmers who are trying to
> read the code.
> 
> 
> Eric
