Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 913D4C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 12:29:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7994320716
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 12:29:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbgFVM3b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 08:29:31 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:36667 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728101AbgFVM3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 08:29:30 -0400
Received: from ip5f5af08c.dynamic.kabel-deutschland.de ([95.90.240.140] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jnLZl-000475-Q4; Mon, 22 Jun 2020 12:29:25 +0000
Date:   Mon, 22 Jun 2020 14:29:25 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Dominique Martinet <asmadeus@codewreck.org>,
        Alexander Kapshuk <alexander.kapshuk@gmail.com>,
        linux-kernel@vger.kernel.org, ebiederm@xmission.com,
        akpm@linux-foundation.org, liuzhiqiang26@huawei.com,
        joel@joelfernandes.org, paulmck@linux.vnet.ibm.com,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] kernel/signal.c: Export symbol __lock_task_sighand
Message-ID: <20200622122925.khcilncycuzb4xki@wittgenstein>
References: <20200621133704.77896-1-alexander.kapshuk@gmail.com>
 <20200622062527.GA6516@redhat.com>
 <20200622083905.c3nurmkbo5yhd6lj@wittgenstein>
 <20200622102401.GA12377@nautica>
 <20200622113610.okzntx7jmnk6n7au@wittgenstein>
 <20200622120259.GD6516@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200622120259.GD6516@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 02:03:00PM +0200, Oleg Nesterov wrote:
> On 06/22, Christian Brauner wrote:
> >
> > On Mon, Jun 22, 2020 at 12:24:01PM +0200, Dominique Martinet wrote:
> > > Christian Brauner wrote on Mon, Jun 22, 2020:
> > > > On Mon, Jun 22, 2020 at 08:25:28AM +0200, Oleg Nesterov wrote:
> > > >> current->sighand is stable and can't go away. Unless "current" is exiting and
> > > >> has already passed exit_notify(). So I don't think net/9p needs this helper.
> > > >
> > > > From what I can gather from the thread (cf. [1]) that is linked in the
> > > > commit message the main motivation for all of this is sparse not being
> > > > happy and not some bug. (Maybe I'm not seeing something though.)
> > > >
> > > > The patch itself linked here doesn't seem to buy anything. I agree with
> > > > Oleg. Afaict, lock_task_sighand() would only be needed here if the task
> > > > wouldn't be current. So maybe it should just be dropped from the series.
> > >
> > > Sure. I honestly have no idea on what guarantees we have from the task
> > > being current here as opposed to any other task -- I guess that another
> > > thread calling exit for exemple would have to wait?
> >
> > When a thread in a non-trivial thread-group (sorry for the math
> > reference :)) execs it'll unshare its struct sighand.
> 
> Well, not really...
> 
> The execing threads will kill other other threads, then it will check

I know but I didn't want to go into that much detail but you're right of
course! :)

> if ->sighand should be unshared. The latter is very unlikely, I don't
> think CLONE_SIGHAND without CLONE_THREAD is actually used today.

It is a supported case however unlikely. I just tried to answer
Dominique's specific question pointing out that even in that unlikely
case sighand_struct is stable.

Just as an fyi, CLONE_SIGHAND with CLONE_VM but without CLONE_THREAD is
actually used quite a bit, e.g. in newlib, in stress-ng, and in criu.
Actually for some use-cases with userfaultfd if you want to handle
pagefaults in the child, you'd want CLONE_VM which enforces
CLONE_SIGHAND so that would be another use-case afaict.

And honestly, quite often this combo is used in helper processes that
share as much context as possible without CLONE_THREAD to do as little
work as possible in terms of allocations and so on in the kernel.
(Another interesting use-case could arise with CLONE_SIGHAND +
 CLONE_CLEAR_SIGHAND as it allows you to reset both the parent's and
 child's signal handler in one shot.)

> 
> But this doesn't really matter. I mean, even if you race with another
> thread doing exec/exit/whatever, current->sighand is stable. Unless, again,
> current has already exited (called exit_notify()).
> 
> > The new struct
> > sighand will be assigned using rcu_assign_pointer() so afaik (Paul or
> > Oleg can yell at me if I'm talking nonsense) any prior callers will see
> > the prior sighand value.
> 
> Yes, but see above.
> 
> If tsk is not current, then (in general) it is not safe to use tsk->sighand
> directly. It can can be changed by exec (as you explained), or you can hit
> tsk->sighand == NULL if you race with exit.
> 
> Oleg.
> 
