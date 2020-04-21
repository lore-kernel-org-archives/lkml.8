Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B60AC54FCC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 15:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E3AA2068F
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 15:08:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728908AbgDUPIy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 11:08:54 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:34858 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbgDUPIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 11:08:54 -0400
Received: from ip5f5af183.dynamic.kabel-deutschland.de ([95.90.241.131] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jQuVt-0003oO-F2; Tue, 21 Apr 2020 15:08:41 +0000
Date:   Tue, 21 Apr 2020 17:08:40 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linux Containers <containers@lists.linux-foundation.org>,
        Christof Meerwald <cmeerw@cmeerw.org>,
        linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH] signal: Avoid corrupting si_pid and si_uid in
 do_notify_parent
Message-ID: <20200421150840.gevtsrhdec5wwg6y@wittgenstein>
References: <20200419201336.GI22017@edge.cmeerw.net>
 <87sggyytnh.fsf@x220.int.ebiederm.org>
 <20200421083031.5wapruzncjkagvhf@wittgenstein>
 <871rog6g56.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <871rog6g56.fsf@x220.int.ebiederm.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 09:57:09AM -0500, Eric W. Biederman wrote:
> Christian Brauner <christian.brauner@ubuntu.com> writes:
> 
> > On Mon, Apr 20, 2020 at 12:05:38PM -0500, Eric W. Biederman wrote:
> >> diff --git a/kernel/signal.c b/kernel/signal.c
> >> index 9899c5f91ee1..a88a89422227 100644
> >> --- a/kernel/signal.c
> >> +++ b/kernel/signal.c
> >> @@ -1993,8 +1993,12 @@ bool do_notify_parent(struct task_struct *tsk, int sig)
> >>  		if (psig->action[SIGCHLD-1].sa.sa_handler == SIG_IGN)
> >>  			sig = 0;
> >>  	}
> >> +	/*
> >> +	 * Bypass send_signal as the si_pid and si_uid values have
> >> +	 * been generated in the parent's namespaces.
> >> +	 */
> >
> > At first I misread that comment as saying that we're skipping sending a
> > signal not that it relates to a specific function (and I won't admit that
> > I wrote a whole long paragraph on why I'm confused we're skipping
> > sending signals on invalid si_pid and si_uid...).
> 
> I have updated the comment to read:
> +       /*
> +        * Send with __send_signal as si_pid and si_uid are in the
> +        * parent's namespaces.
> +        */
> 
> That should be enough of a hint for someone to read the code and figure
> out what is going on.

Perfect, thanks!
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>

Christian
