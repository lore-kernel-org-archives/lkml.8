Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F42EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 00:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26C5F2071A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 00:45:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="RfxEKl4S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbgE0Ap4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 20:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727022AbgE0Apz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 20:45:55 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F728C061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 17:45:54 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id q18so1259300ilm.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 17:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9L32LrOiBXF6bXFupNUcwgJzSfa5T/4eeicVRJznq9g=;
        b=RfxEKl4S5Nrey6QjkVoYE6kTG9L0EapEyutjKAA7lpx3sf0mr2kX1vlYTGGf4A1iYw
         /SWnSVp0aEmK5+VP7LRG/wvKc/1koLnTQK4vagFWY3+V7qAzImkofEXMQFE5X5WNrD0B
         OCf+tlKwfCdrOhX5bWmSI8be/Oi75UIGZ4p0k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9L32LrOiBXF6bXFupNUcwgJzSfa5T/4eeicVRJznq9g=;
        b=GbhySXnwx8S+myRVSQCNrn3fVqJH5j3VL3dchJDsmBpGO6Un2HeCyfj6Scwd+qXCqe
         FOzoVftUtbgFqui897mriMdOJlL/D5hfgs6NC1NhBq9Ug7anuPO1T+QS4Igxf2xabxct
         x2TVngh3RbMmNXXYsInXmqPRLc+KyzniYtTXns+pMDP2kE9mg0GWyKIa5iJM9UMvQ3Yb
         vsU8T6ekBsw5wNlpWgRHuRaz/2opUG6ci+/09ieOeNs2O7MygrDhndk++8Y/MDskmht2
         NB0T96q7dQIkW+Rxa033MGG4872tmAw/o+6mc//RPPD9zSvIpCw+xcfSCviOFKwMLfvr
         /2jA==
X-Gm-Message-State: AOAM530YwxwCYoVV9qpsUp1BOWy5GLOsbZbUD8A+9gRJ9aZX0U39UUfu
        BI53XGndJBJSdUaeDKmgZEKs3U8MpPSFr9DlGTDCuw==
X-Google-Smtp-Source: ABdhPJzGIA2LA2CFbvmxCeUvL+D2ipzLAj4zWcXU9JQ8u77hC93G5sTj3+nOgeshyNpJaxgJlVkKzmaBwVsfiYqqwm8=
X-Received: by 2002:a92:8b43:: with SMTP id i64mr3829836ild.171.1590540353847;
 Tue, 26 May 2020 17:45:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200513164714.22557-1-frederic@kernel.org> <20200513164714.22557-2-frederic@kernel.org>
 <20200520122949.GB16672@google.com> <20200522175739.GM2869@paulmck-ThinkPad-P72>
 <20200526152137.GB76276@google.com> <20200526162946.GK2869@paulmck-ThinkPad-P72>
 <20200526201840.GC76276@google.com> <20200526210947.GP2869@paulmck-ThinkPad-P72>
 <20200526212756.GF76276@google.com> <20200526222900.GQ2869@paulmck-ThinkPad-P72>
In-Reply-To: <20200526222900.GQ2869@paulmck-ThinkPad-P72>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Tue, 26 May 2020 20:45:42 -0400
Message-ID: <CAEXW_YSvdJYGL2fKwsMK3nL+AHVzip8g+GMEPjM69ARBq=+8TQ@mail.gmail.com>
Subject: Re: [PATCH 01/10] rcu: Directly lock rdp->nocb_lock on nocb code entrypoints
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Tue, May 26, 2020 at 6:29 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Tue, May 26, 2020 at 05:27:56PM -0400, Joel Fernandes wrote:
> > On Tue, May 26, 2020 at 02:09:47PM -0700, Paul E. McKenney wrote:
> > [...]
> > > > > > BTW, I'm really itching to give it a try to make the scheduler more deadlock
> > > > > > resilient (that is, if the scheduler wake up path detects a deadlock, then it
> > > > > > defers the wake up using timers, or irq_work on its own instead of passing
> > > > > > the burden of doing so to the callers). Thoughts?
> > > > >
> > > > > I have used similar approaches within RCU, but on the other hand the
> > > > > scheduler often has tighter latency constraints than RCU does.  So I
> > > > > think that is a better question for the scheduler maintainers than it
> > > > > is for me.  ;-)
> > > >
> > > > Ok, it definitely keeps coming up in my radar first with the
> > > > rcu_read_unlock_special() stuff, and now the nocb ;-). Perhaps it could also
> > > > be good for a conference discussion!
> > >
> > > Again, please understand that RCU has way looser latency constraints
> > > than the scheduler does.  Adding half a jiffy to wakeup latency might
> > > not go over well, especially in the real-time application area.
> >
> > Yeah, agreed that the "deadlock detection" code should be pretty light weight
> > if/when it is written.
>
> In addition, to even stand a chance, you would need to use hrtimers.
> The half-jiffy (at a minimum) delay from any other deferral mechanism
> that I know of would be the kiss of death, especially from the viewpoint
> of the real-time guys.

Just to make sure we are talking about the same kind of overhead - the
deferring is only needed if the rq lock is already held (detected by
trylocking). So there's no overhead in the common case other than the
trylock possibly being slightly more expensive than the regular
locking. Also, once the scheduler defers it, it uses the same kind of
mechanism that other deferral mechanisms use to overcome this deadlock
(timers, irq_work etc), so the overhead then would be no different
than what he have now - the RT users would already have the wake up
latency in current kernels without this idea implemented. Did I miss
something?

> > > But what did the scheduler maintainers say about this idea?
> >
> > Last I remember when it came up during the rcu_read_unlock_special() deadlock
> > discussions, there's no way to know for infra like RCU to know that it was
> > invoked from the scheduler.
> >
> > The idea I am bringing up now (about the scheduler itself detecting a
> > recursion) was never brought up (not yet) with the sched maintainers (at
> > least not by me).
>
> It might be good to bounce if off of them sooner rather than later.

Ok, I did that now over IRC. Thank you!

 - Joel
