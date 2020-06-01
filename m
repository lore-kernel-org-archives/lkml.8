Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC3FBC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 16:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADF0D206C3
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 16:19:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BQ7r/3K5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbgFAQT6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 12:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgFAQT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 12:19:57 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B4CC05BD43
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 09:19:56 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id v19so112860wmj.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 09:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gSoSIieEDUdhx71lzmpxkrFipZd/wBiX5gbP/VSlMm8=;
        b=BQ7r/3K5XqD88yCTJ7O6KRhya+vbW6Y2bj0WH/p1fIIJVz4wwofL36dMCgGkhkJEue
         I0b/jXoO36TDmzdjdPtRq5hosXD9q3MSQm+DBaV3GZopV4fEYn3PYTccYDOoUX2y2kTw
         68oyouRtYKGc8ta06h7W/rGR8TM5cvaXjIoWrTc5yvBhGLs8eF/ckmkA6o6pLB2oTMt7
         259RMZZxgxuezq+xAx8VmJw4IQELlY8OLt05baRW6IUWjIW2aH0APIV1gnwbv5qLt2Jd
         itNjEABIvRF+rGP9pJg/d2YYlkHuC0p+El1AMnwT7Fvtg5XwHtjIEMkh2EUTQaSDYKQb
         EwtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gSoSIieEDUdhx71lzmpxkrFipZd/wBiX5gbP/VSlMm8=;
        b=QFoSJ3lz0zfTenZt5QSN+728XqEmOF0sqFr53mzJzZ306xrds0XdO8F7PEMla7KUHB
         MXQpt/dFLXJtkfB86K9O1Wnh6LMA5xkJqTJI5wy+iUhCSP/UEZDGtrU9ZGFCyv8tGjiU
         N2c0LEUWA4SpcHQkSxNqu9XvcVs8NOBqTH/uU/y1QQ4Ey1Wn9jvk08oHeMRCi0ceuspr
         kUj6Q91tdMR/g9hik0ZrYzbr2gadlRBma6YqYzoPYvmFiEATs/XpOImNrLZtvLn7PmzY
         42YI55+i0VgHidPjRCWqwA3wnqcgyvqmLqMs8IXxvD9TnzBCcLDLH+yzE4RLVExpX+db
         hTCw==
X-Gm-Message-State: AOAM530Ija5SL122RNxxsy0EZ4CsiXspNw9cSqksb7XQgXrp4OORm1Pe
        u/KD1YB8AnGjmTT9SU/dFOfNMA==
X-Google-Smtp-Source: ABdhPJxV+IFKofmH37ztXu3rTDfXtd0qV6gakRS/9Psclvq9FcsqiRT5srAaTvBvLEeJJuUaPQtoHA==
X-Received: by 2002:a1c:b656:: with SMTP id g83mr87819wmf.151.1591028394615;
        Mon, 01 Jun 2020 09:19:54 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id u12sm7202335wrq.90.2020.06.01.09.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 09:19:53 -0700 (PDT)
Date:   Mon, 1 Jun 2020 17:19:52 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        kgdb-bugreport@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kgdb: Avoid suspicious RCU usage warning
Message-ID: <20200601161952.3hx6sv5hzdnjnvtj@holly.lan>
References: <20200507153444.1.I70e0d4fd46d5ed2aaf0c98a355e8e1b7a5bb7e4e@changeid>
 <20200519104151.6evv3hizm5dbjjq2@holly.lan>
 <CAD=FV=XCFxgO-s--jw9CTgQUxtQfteoQ4XSL_bbjW4s82Wd3pg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=XCFxgO-s--jw9CTgQUxtQfteoQ4XSL_bbjW4s82Wd3pg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 05:02:27PM -0700, Doug Anderson wrote:
> Hi,
> 
> On Tue, May 19, 2020 at 3:41 AM Daniel Thompson
> <daniel.thompson@linaro.org> wrote:
> >
> > On Thu, May 07, 2020 at 03:53:58PM -0700, Douglas Anderson wrote:
> > > At times when I'm using kgdb I see a splat on my console about
> > > suspicious RCU usage.  I managed to come up with a case that could
> > > reproduce this that looked like this:
> > >
> > >   WARNING: suspicious RCU usage
> > >   5.7.0-rc4+ #609 Not tainted
> > >   -----------------------------
> > >   kernel/pid.c:395 find_task_by_pid_ns() needs rcu_read_lock() protection!
> > >
> > >   other info that might help us debug this:
> > >
> > >     rcu_scheduler_active = 2, debug_locks = 1
> > >   3 locks held by swapper/0/1:
> > >    #0: ffffff81b6b8e988 (&dev->mutex){....}-{3:3}, at: __device_attach+0x40/0x13c
> > >    #1: ffffffd01109e9e8 (dbg_master_lock){....}-{2:2}, at: kgdb_cpu_enter+0x20c/0x7ac
> > >    #2: ffffffd01109ea90 (dbg_slave_lock){....}-{2:2}, at: kgdb_cpu_enter+0x3ec/0x7ac
> > >
> > >   stack backtrace:
> > >   CPU: 7 PID: 1 Comm: swapper/0 Not tainted 5.7.0-rc4+ #609
> > >   Hardware name: Google Cheza (rev3+) (DT)
> > >   Call trace:
> > >    dump_backtrace+0x0/0x1b8
> > >    show_stack+0x1c/0x24
> > >    dump_stack+0xd4/0x134
> > >    lockdep_rcu_suspicious+0xf0/0x100
> > >    find_task_by_pid_ns+0x5c/0x80
> > >    getthread+0x8c/0xb0
> > >    gdb_serial_stub+0x9d4/0xd04
> > >    kgdb_cpu_enter+0x284/0x7ac
> > >    kgdb_handle_exception+0x174/0x20c
> > >    kgdb_brk_fn+0x24/0x30
> > >    call_break_hook+0x6c/0x7c
> > >    brk_handler+0x20/0x5c
> > >    do_debug_exception+0x1c8/0x22c
> > >    el1_sync_handler+0x3c/0xe4
> > >    el1_sync+0x7c/0x100
> > >    rpmh_rsc_probe+0x38/0x420
> > >    platform_drv_probe+0x94/0xb4
> > >    really_probe+0x134/0x300
> > >    driver_probe_device+0x68/0x100
> > >    __device_attach_driver+0x90/0xa8
> > >    bus_for_each_drv+0x84/0xcc
> > >    __device_attach+0xb4/0x13c
> > >    device_initial_probe+0x18/0x20
> > >    bus_probe_device+0x38/0x98
> > >    device_add+0x38c/0x420
> > >
> > > If I understand properly we should just be able to blanket kgdb under
> > > one big RCU read lock and the problem should go away.  We'll add it to
> > > the beast-of-a-function known as kgdb_cpu_enter().
> > >
> > > With this I no longer get any splats and things seem to work fine.
> > >
> > > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> >
> > In principle this looks OK but I'm curious why we don't cuddle these
> > calls up to the local interrupt locking (and also whether we want to
> > keep hold of the lock during stepping). If nothing else that would make
> > review easier.
> 
> It probably wouldn't hurt to keep hold of the lock during single
> stepping but I don't think there's any real reason we'd want to.
> Specifically the only real reason we're calling rcu_read_lock() is to
> avoid the warning.  Since we're a stop-the-world debugger it's not
> like something else could be messing with state at the same time.
> 
> I'm looking at the whole function though and I don't really understand
> all the comments about interrupts being restored by the 'trap return'
> code, do you?

Not as much as I'd like but, in principle at least, I think the trap
handler is written to make it an architecture decision to whether it
will be entered with interrupt disabled or not (which would in turn
depend on how the architecture manages exception stacks and what else
it uses the breakpoint machinery for).


> Specifically: as far as I can tell we _always_ restore
> interrupts when exiting the function.  There are only two return
> statements and both have "local_irq_restore(flags);" right before
> them.  We never modify the flags directly and the one other usage of
> "flags" is effectively the statement "local_irq_restore(flags);
> local_irq_save(flags);" which will, I guess, allow any interrupts that
> were already pending to take place.  Are you saying that you want me
> to match that and do a "rcu_read_unlock(); rcu_read_lock()" there?
> 
> If I understand things correctly (and there's maybe a better chance
> after I read Wei Li's recent patches) the disabling of IRQs for single
> stepping happens in a different way.  It looks like we update the
> "struct pt_regs" of the task we're stepping so that when we exit kgdb
> and start running the task again that the interrupts are off.  That
> seems reasonable to me and this function has nothing to do with it.
> 
> ...and further confusion on my part: does the whole saving / restoring
> of interrupts in kgdb_cpu_enter() make any sense anyway?  Is this
> function ever called from a context that's not an interrupt context?
> How do we get the pt_regs in that case?  Just for fun, I tried doing
> this:
> 
>     local_irq_save(flags);
> +   if (!arch_irqs_disabled_flags(flags))
> +           pr_warn("I was wrong\n");
> 
> ...and I never saw "I was wrong" on my system.  Maybe it matters for
> something not arm64?  ...or, maybe, this is from when kgdb worked in a
> completely different way?

I'm not yet in a position to test kgdb on all architectures. Mostly
this is because it can be hard to discover suitable qemu stanzas to
launch an emulator... and in one case because buildroot doesn't support
cross-gdb yet. Anyhow, right now, it is difficult to tour the niche
architectures to give a definitive answer.


> In general I made my patch by:
> * Calling rcu_read_lock() at the start of the function.
> * Calling rcu_read_unlock() right before all 2 of the "return" calls of
>   the function.
> 
> ...I was hoping that would actually make it easier to reason about
> even if the function is a beast.
> 
> 
> Hopefully the above makes sense.  I wouldn't rule out me just being
> utterly confused, but I _think_ I reasoned through it all.  ;-)  If it
> all makes sense, I'm inclined to:
> 
> 1. Leave my patch the way it is.

I'm still a little reluctant on this.

It's not that I think the current patch is buggy, more that I view the
interrupt locks as the place in the function that we start to "assert"
what our execution context is going to be. Seeing all the entry/exit
logic in one place makes reasoning easier and should make the eventual
refactoring of "the beast" a little easier too.


> 2. Perhaps remove the whole irq saving / restoring in kgdb_cpu_enter().

Are you feeling lucky?

I think there will come a time when bravery is called for but I'd rather
see this as part of a bigger rewrite instead of a single high risk
change.


Daniel.
