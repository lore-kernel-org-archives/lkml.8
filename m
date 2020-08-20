Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81184C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 14:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58ED720724
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 14:06:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1BJsfCDP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kdkE/t2j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727931AbgHTOGY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 10:06:24 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47584 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727108AbgHTOGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 10:06:05 -0400
Date:   Thu, 20 Aug 2020 16:05:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597932354;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OrJ1aIyBogMdujoWj79axXogbff5cVmSIo2RpB1aEK0=;
        b=1BJsfCDP3QRtFXAXVfKxuf2aJ37ALnsmqqHr1Fh4qPiKQZQlK6tTqHEWJRoLzQ9HDdYDjE
        JWRlxbOc60ng5A4KtJnMF3rCNKKxooExKKLn+wa+moZGL7BaL8+ODlV5rmAsUSP43BEbqc
        OvaflQxKsanwbCs6fl0BDHLQMs5/1GsFYPhHJKi1nI6ILauw0EZdDFwx5vki+6MtNYycx4
        U1lRRfv5NjD0s5MtZnExsx300a7J4s1l0snU6BIL7naqoUoNoKL0SlLAoCWw25UFxzw5Mb
        lIoGyirdg2IiIgCn+Jk0ATj47Szq37bs7jOAKrhwrHM5MFCd4EpMYjKEyP5mgA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597932354;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OrJ1aIyBogMdujoWj79axXogbff5cVmSIo2RpB1aEK0=;
        b=kdkE/t2j/RlmnRbFNpfDzmbKgUaz210/3SmiwkGKR7iiiACw4BYmZZo1mJALMg3XSwnMTU
        7TmMjhI8QpKre3Dg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will@kernel.org>, tglx@linutronix.de,
        kent.overstreet@gmail.com
Subject: Re: [PATCH] lockdep: Do no validate wait context for novalidate class
Message-ID: <20200820140552.5xtk23a3lxvcfpvu@linutronix.de>
References: <20200629201529.1017485-1-bigeasy@linutronix.de>
 <20200820114036.GQ2674@hirez.programming.kicks-ass.net>
 <20200820114348.giwwlbihjwpl4kxz@linutronix.de>
 <20200820123859.GS2674@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200820123859.GS2674@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-08-20 14:38:59 [+0200], peterz@infradead.org wrote:
> On Thu, Aug 20, 2020 at 01:43:48PM +0200, Sebastian Andrzej Siewior wrote:
> > On 2020-08-20 13:40:36 [+0200], peterz@infradead.org wrote:
> > > Anyway, all 3 users should have the same wait context, so where is the
> > > actual problem?
> >=20
> > I have one in RT which is a per-CPU spinlock within local_bh_disable()
> > to act as a per-CPU BLK like mainline.
>=20
> Then can we get to see that code and an explanation for what the problem
> is and why it is still correct?

An actual backtrace looks like this:
| WARNING: possible circular locking dependency detected
=E2=80=A6
| Possible unsafe locking scenario:
|
|       CPU0                    CPU1
|       ----                    ----
|  lock(k-sk_lock-AF_NETLINK);
|                               lock((l).lock#2);
|                               lock(k-sk_lock-AF_NETLINK);
|  lock((l).lock#2);
|
|  *** DEADLOCK ***

The "k-sk_lock-AF_NETLINK" is global but "(l).lock#2" is per CPU. The
circular dependency can not occur because CPU0 and CPU1 can acquire the
lock simultaneously.
The softirq code is at
   https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/tr=
ee/patches/softirq-Add-preemptible-softirq.patch?h=3Dlinux-5.6.y-rt-patches=
&id=3D4ce1fda10dae882d494c6430cc438ff645a35603#n146

I'm not sure why sk_lock on CPU0 is before (l).lock. It doesn't change
even if the lock is acquired after trace_softirqs_off(). If the sk_lock
would be acquired with enabled BH then lockdep would complain.

The lovely in_atomic() check is due to irq_enter(), preempt_disable() +
local_bh_disable() and others.

> Because as is, this patch isn't needed.
I can hold on to this and maybe it is not needed the final version of
softirq ends up to be different :)

Thanks.

Sebastian
