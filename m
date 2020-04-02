Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F222C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 07:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A7182064A
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 07:30:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729244AbgDBHaJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 03:30:09 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36253 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbgDBHaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 03:30:09 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jJuIX-0006Yi-N0; Thu, 02 Apr 2020 09:29:57 +0200
Date:   Thu, 2 Apr 2020 09:29:57 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     kernel test robot <lkp@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, LKP <lkp@lists.01.org>,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] workqueue: Don't double assign worker->sleeping
Message-ID: <20200402072957.fczmj5nbaosfq3hb@linutronix.de>
References: <20200327074308.GY11705@shao2-debian>
 <20200327175350.rw5gex6cwum3ohnu@linutronix.de>
 <CAJhGHyDmw5Fwq5mgb1h=7GBegQKP2HQnPTxcRps-0PvGbC2PWg@mail.gmail.com>
 <CAJhGHyBS9Z=x-X2Bxzbic2sfqj=STqr+K8Tgu1UfYMQDm6MtBg@mail.gmail.com>
 <20200401130346.e7cdsqgxppa6ohje@linutronix.de>
 <CAJhGHyBmcY75Rhc7UFyK7Ozho+aqOcX2EaxePhZFu9rt0w3-mA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJhGHyBmcY75Rhc7UFyK7Ozho+aqOcX2EaxePhZFu9rt0w3-mA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-04-02 08:07:35 [+0800], Lai Jiangshan wrote:
> > > would be *increased* twice
> > >
> > > I just saw the V2 patch, this issue is not listed, but need to be fixed too.
> >
> > | void wq_worker_running(struct task_struct *task)
> > | {
> > |         struct worker *worker = kthread_data(task);
> > |
> > |         if (!worker->sleeping)
> > |                 return;
> > |         if (!(worker->flags & WORKER_NOT_RUNNING))
> > |                 atomic_inc(&worker->pool->nr_running);
> > *0
> > |         worker->sleeping = 0;
> > *1
> > | }
> >
> > So an interrupt
> > - before *0, the preempting caller drop early in wq_worker_sleeping(), only one
> >   atomic_inc()
> 
> If it is preempted on *0, the preempting caller drop early in
> wq_worker_sleeping()
> so there is no atomic decreasing, only one atomic_inc() in the
> preempting caller.
> The preempted point here, wq_worker_running(), has already just done
> atomic_inc(),
> the total number of atomic_inc() is two, while the number of atomic decreasing
> is one.

But in order to look at the same worker->sleeping it has to be same
`task'. This can not happen because the `worker' assignment is
per-thread.

Sebastian
