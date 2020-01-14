Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D2AC33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 08:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28D72207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 08:43:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lGEURDl4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728799AbgANInq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 03:43:46 -0500
Received: from merlin.infradead.org ([205.233.59.134]:40930 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbgANInp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 03:43:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=U3RF+wuU6+PT2BD7xbGzYkq6o+SbUI6E7+a+DjOKcEM=; b=lGEURDl402SmQX3dHrrkytLB2
        qOPkT0b/UXb0MCSpM7PTMQfdOMJvDMfPYozEXcQAS6y2FZZXnOvgMjP+n3x7GPsP7RUyvstZUH1O1
        lvbibsF4PfUM9wZutgYPdWYLZvpH9W5914PWT3bFKXgPwQRCcOaoA2SqO3E7c43vq29jlquyr3fbj
        KF/YnOiPXX8zsEkI9QyzzfE8aEihcGhZOzjMsu25fGQpW/zbBDD901nE0NNlRUEWTBZ9BKGYYSujD
        RdqqOlzC2L7kkclR0+4DeAXLeM0hl06rwgBN11YQ+ABzW/Mk9wR4TSPb2JiM9ZM02+2IucS1ZEBdq
        l9+SB1q2w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1irHnT-0005FB-LE; Tue, 14 Jan 2020 08:43:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 81179304BDF;
        Tue, 14 Jan 2020 09:41:58 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 232F8201D41A2; Tue, 14 Jan 2020 09:43:34 +0100 (CET)
Date:   Tue, 14 Jan 2020 09:43:34 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+aaa6fa4949cc5d9b7b25@syzkaller.appspotmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: BUG: MAX_LOCKDEP_CHAINS too low!
Message-ID: <20200114084334.GI2827@hirez.programming.kicks-ass.net>
References: <0000000000007523a60576e80a47@google.com>
 <CACT4Y+b3AmVQMjPNsPHOXRZS4tNYb6Z9h5-c=1ZwZk0VR-5J5Q@mail.gmail.com>
 <20180928070042.GF3439@hirez.programming.kicks-ass.net>
 <CACT4Y+YFmSmXjs5EMNRPvsR-mLYeAYKypBppYq_M_boTi8a9uQ@mail.gmail.com>
 <CACT4Y+ZBYYUiJejNbPcZWS+aHehvkgKkTKm0gvuviXGGcirJ5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+ZBYYUiJejNbPcZWS+aHehvkgKkTKm0gvuviXGGcirJ5g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2020 at 11:59:25AM +0100, Dmitry Vyukov wrote:

> Or are there some ID leaks in lockdep? syzbot has a bunch of very
> simple reproducers for these bugs, so not really a maximally diverse
> load. And I think I saw these bugs massively when testing just a
> single subsystem too, e.g. netfilter.

Can you share me one of the simple ones? A .c files I can run on my
regular test box that should make it go *splat* ?

Often in the past hitting these limits was the result of some
particularly poor annotation.

For instance, locks in per-cpu data used to trigger this, since
static locks don't need explicit {mutex,spin_lock}_init() calls and
instead use their (static) address. This worked fine for global state,
but per-cpu is an exception, there it causes a nr_cpus explosion in
lockdep state because you get nr_cpus different addresses.

Now, we fixed that particular issue:

  383776fa7527 ("locking/lockdep: Handle statically initialized PER_CPU locks properly")

but maybe there's something else going on.

Just blindly bumping the number without analysis of what exactly is
happening is never a good idea.
