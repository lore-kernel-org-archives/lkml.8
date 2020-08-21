Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFC87C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 15:08:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0132207C3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 15:08:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728059AbgHUPIv convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 11:08:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:44768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725873AbgHUPIv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 11:08:51 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 62FEC20656;
        Fri, 21 Aug 2020 15:08:50 +0000 (UTC)
Date:   Fri, 21 Aug 2020 11:08:48 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Joerg Vehlow <lkml@jv-coder.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Huang Ying <ying.huang@intel.com>,
        linux-kernel@vger.kernel.org,
        Joerg Vehlow <joerg.vehlow@aox-tech.de>
Subject: Re: [BUG RT] dump-capture kernel not executed for panic in
 interrupt context
Message-ID: <20200821110848.6c3183d1@oasis.local.home>
In-Reply-To: <c6b095af-fc92-420f-303f-d2efd9f28873@jv-coder.de>
References: <2c243f59-6d10-7abb-bab4-e7b1796cd54f@jv-coder.de>
        <20200528084614.0c949e8d@gandalf.local.home>
        <cbbf7926-148e-7acb-dc03-3f055d73364b@jv-coder.de>
        <20200727163655.8c94c8e245637b62311f5053@linux-foundation.org>
        <c6b095af-fc92-420f-303f-d2efd9f28873@jv-coder.de>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Aug 2020 12:25:33 +0200
Joerg Vehlow <lkml@jv-coder.de> wrote:

> Hi Andrew and Others (please read at least the part with @RT developers),
> 
> > Yup, mutex_trylock() from interrupt is improper.  Well dang, that's a
> > bit silly.  Presumably the 2006 spin_lock_mutex() wasn't taken with
> > irqs-off.
> >
> > Ho hum, did you look at switching the kexec code back to the xchg
> > approach?
> >  
> I looked into reverting to the xchg approach, but that seems to be
> not a good solution anymore, because the mutex is used in many places,
> a lot with waiting locks and I guess that would require spinning now,
> if we do this with bare xchg.
> 
> Instead I thought about using a spinlock, because they are supposed
> to be used in interrupt context as well, if I understand the documentation
> correctly ([1]).
> @RT developers
> Unfortunately the rt patches seem to interpret it a bit different and
> spin_trylock uses __rt_mutex_trylock again, with the same consequences as
> with the current code.
> 
> I tried raw_spinlocks, but it looks like they result in a deadlock at
> least in the rt kernel. Thiy may be because of memory allocations in the
> critical sections, that are not allowed if I understand it correctly.
> 
> I have no clue how to fix it at this point.
> 
> Jörg
> 
> [1] https://kernel.readthedocs.io/en/sphinx-samples/kernel-locking.html

There's only two places that wait on the mutex, and all other places
try to get it, and if it fails, it simply exits.

What I would do is introduce a kexec_busy counter, and have something
like this:

For the two locations that actually wait on the mutex:

loop:
	mutex_lock(&kexec_mutex);
	ret = atomic_inc_return(&kexec_busy);
	if (ret > 1) {
		/* Atomic context is busy on this counter, spin */
		atomic_dec(&kexec_busy);
		mutex_unlock(&kexec_mutex);
		goto loop;
	}
	[..]
	atomic_dec(&kexec_busy);
	mutex_unlock(&kexec_mutex);

And then all the other places that do the trylock:

	cant_sleep();
	ret = atomic_inc_return(&kexec_busy);
	if (ret > 1) {
		atomic_dec(&kexec_busy);
		return;
	}
	[..]
	atomic_dec(&kexec_busy);


-- Steve
