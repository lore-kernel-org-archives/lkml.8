Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC764C34047
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 20:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A36F024655
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 20:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582057089;
	bh=qqnLyB3gVVKRKrBhyaJyFqmzkXjVgBOGwvgmzPzW+Gg=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=yefk28rIq33vvBibnzqIo2rpXpyHpBZbZx53wa5gzG8xEbK+cAwi6IBxLHne6ady5
	 9Rty8jV7auVG0gV8e1CgWRp2ZDFkIZEyQu89eu2KF7IYJH0vjTx9mLGbnh+4NNnOUo
	 i4Gw/RFtoyYPO/Pq3F4KJk278AbJ6yvu0/HCbHu0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbgBRUSI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 15:18:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:53236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726384AbgBRUSH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 15:18:07 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 165832176D;
        Tue, 18 Feb 2020 20:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582057087;
        bh=qqnLyB3gVVKRKrBhyaJyFqmzkXjVgBOGwvgmzPzW+Gg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=qEM+fw9aHW+bZBCC3UebArPkarrxb3jBlJ9OjiUtvnWPkwSLEVSWkwrk1rk2S/t/G
         HjGxcW4B93H5pkpev+KVTm9fGqrA92KMqBahARDW6NCRwC/N/SAzbHynpv9O29BzuD
         yePbCbgHNEOCP7bb6uGQbp17zFSRrAw8PW6/+OQo=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id E60563520856; Tue, 18 Feb 2020 12:18:06 -0800 (PST)
Date:   Tue, 18 Feb 2020 12:18:06 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org, gregkh@linuxfoundation.org,
        gustavo@embeddedor.com, tglx@linutronix.de, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com
Subject: Re: [PATCH v2 3/9] rcu,tracing: Create trace_rcu_{enter,exit}()
Message-ID: <20200218201806.GI2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200213163800.5c51a5f1@gandalf.local.home>
 <20200213215004.GM2935@paulmck-ThinkPad-P72>
 <20200213170451.690c4e5c@gandalf.local.home>
 <20200213223918.GN2935@paulmck-ThinkPad-P72>
 <20200214151906.b1354a7ed6b01fc3bf2de862@kernel.org>
 <20200215145934.GD2935@paulmck-ThinkPad-P72>
 <20200217175519.12a694a969c1a8fb2e49905e@kernel.org>
 <20200217163112.GM2935@paulmck-ThinkPad-P72>
 <20200218133335.c87d7b2399ee6532bf28b74a@kernel.org>
 <20200218124609.1a33f868@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200218124609.1a33f868@gandalf.local.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2020 at 12:46:09PM -0500, Steven Rostedt wrote:
> On Tue, 18 Feb 2020 13:33:35 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > On Mon, 17 Feb 2020 08:31:12 -0800
> > "Paul E. McKenney" <paulmck@kernel.org> wrote:
> > >   
> > > > BTW, if you consider the x86 specific code is in the generic file,
> > > > we can move NOKPROBE_SYMBOL() in arch/x86/kernel/traps.c.
> > > > (Sorry, I've hit this idea right now)  
> > > 
> > > Might this affect other architectures with NMIs and probe-like things?
> > > If so, it might make sense to leave it where it is.  
> > 
> > Yes, git grep shows that arm64 is using rcu_nmi_enter() in
> > debug_exception_enter().
> > OK, let's keep it, but maybe it is good to update the comment for
> > arm64 too. What about following?
> > 
> > +/*
> > + * All functions in do_int3() on x86, do_debug_exception() on arm64 must be
> > + * marked NOKPROBE before kprobes handler is called.
> > + * ist_enter() on x86 and debug_exception_enter() on arm64 which is called
> > + * before kprobes handle happens to call rcu_nmi_enter() which means
> > + * that rcu_nmi_enter() must be marked NOKRPOBE.
> > + */
> > 
> 
> Ah, why don't we just say...
> 
> /*
>  * All functions called in the breakpoint trap handler (e.g. do_int3()
>  * on x86), must not allow kprobes until the kprobe breakpoint handler
>  * is called, otherwise it can cause an infinite recursion.
>  * On some archs, rcu_nmi_enter() is called in the breakpoint handler
>  * before the kprobe breakpoint handler is called, thus it must be
>  * marked as NOKPROBE.
>  */
> 
> And that way we don't make this an arch specific comment.

That looks good to me.  Masami, does this work for you?

							Thanx, Paul
