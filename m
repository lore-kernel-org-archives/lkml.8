Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB07EC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 20:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DE5A206C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 20:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589919900;
	bh=kTkWLjuMmuCoA4+qPlnZ725Sz7A7HK3SsaeFNh7OfYw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=h4lNHQWbei0i6yaNh4IwjX2o50olkDzDad1XBi/kNFXf34rj9LPfRng2AEuaXRiT1
	 5QXtn1AS7oT2Ul7NjxFOih7+1kGcca+PLrsyePV3hREm/x7fczfykxnFTChc1BykUB
	 ZRVH5lTIpx3z2HhAqYj7++lz4rUMJT51UoRXbv+A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbgESUY7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 16:24:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:38262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726283AbgESUY7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 16:24:59 -0400
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E77B20829
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 20:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589919898;
        bh=kTkWLjuMmuCoA4+qPlnZ725Sz7A7HK3SsaeFNh7OfYw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bbVLRSI4e13oo38U0HlOerWhsy1lYq+cYBR7SkOe6bdl1cAJZ/GjkDEejvTkaxlAJ
         AgTs2Zwga+ZUJBeaIyTz4ZO+IoyzXl/FaKm5XMj06OVyMBaOuLNBi1UoJqnKtvSnMQ
         I2xdMuiz6KIps85xfzpXM+x66UFCaM3XMZ3T2yH0=
Received: by mail-wr1-f48.google.com with SMTP id k13so853152wrx.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 13:24:57 -0700 (PDT)
X-Gm-Message-State: AOAM531gaX5jI3Wd+CDDOJu5i1EBKzegMcD28fulGkVkAdlNLpnixoQg
        OAYTO1Qyf+FmXkU80J/Er7w+QWYJZTX4q/sWBmmXXA==
X-Google-Smtp-Source: ABdhPJzrAv5O1IkT9VWE6i37uyVDoQrBGbOQGXVSgM+ibFDEEWTi/A9SHF1R5Xeovyvl3AMGx0pJMl/vQGtOViOnH0U=
X-Received: by 2002:adf:a298:: with SMTP id s24mr655323wra.184.1589919896535;
 Tue, 19 May 2020 13:24:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200515234547.710474468@linutronix.de> <20200515235125.628629605@linutronix.de>
 <CALCETrWnkuwvTuJKr8Vuecgr_q+1ReBDrTv4XOqGaw7-ZpEeQQ@mail.gmail.com>
 <87ftbv7nsd.fsf@nanos.tec.linutronix.de> <87a7237k3x.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87a7237k3x.fsf@nanos.tec.linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 19 May 2020 13:24:45 -0700
X-Gmail-Original-Message-ID: <CALCETrXbQkE1zTW5Ly+ZQgDFLQQa3crPxzK6to0YR+BP5B9q+g@mail.gmail.com>
Message-ID: <CALCETrXbQkE1zTW5Ly+ZQgDFLQQa3crPxzK6to0YR+BP5B9q+g@mail.gmail.com>
Subject: Re: [patch V6 12/37] x86/entry: Provide idtentry_entry/exit_cond_rcu()
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Jason Chen CJ <jason.cj.chen@intel.com>,
        Zhao Yakui <yakui.zhao@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 19, 2020 at 1:20 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Thomas Gleixner <tglx@linutronix.de> writes:
> > Andy Lutomirski <luto@kernel.org> writes:
> >> On Fri, May 15, 2020 at 5:10 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> >>> The pagefault handler cannot use the regular idtentry_enter() because that
> >>> invokes rcu_irq_enter() if the pagefault was caused in the kernel. Not a
> >>> problem per se, but kernel side page faults can schedule which is not
> >>> possible without invoking rcu_irq_exit().
> >>>
> >>> Adding rcu_irq_exit() and a matching rcu_irq_enter() into the actual
> >>> pagefault handling code would be possible, but not pretty either.
> >>>
> >>> Provide idtentry_entry/exit_cond_rcu() which calls rcu_irq_enter() only
> >>> when RCU is not watching. The conditional RCU enabling is a correctness
> >>> issue: A kernel page fault which hits a RCU idle reason can neither
> >>> schedule nor is it likely to survive. But avoiding RCU warnings or RCU side
> >>> effects is at least increasing the chance for useful debug output.
> >>>
> >>> The function is also useful for implementing lightweight reschedule IPI and
> >>> KVM posted interrupt IPI entry handling later.
> >>
> >> Why is this conditional?  That is, couldn't we do this for all
> >> idtentry_enter() calls instead of just for page faults?  Evil things
> >> like NMI shouldn't go through this path at all.
> >
> > I thought about that, but then ended up with the conclusion that RCU
> > might be unhappy, but my conclusion might be fundamentally wrong.
>
> It's about this:
>
> rcu_nmi_enter()
> {
>         if (!rcu_is_watching()) {
>             make it watch;
>         } else if (!in_nmi()) {
>             do_magic_nohz_dyntick_muck();
>         }
>
> So if we do all irq/system vector entries conditional then the
> do_magic() gets never executed. After that I got lost...

I'm also baffled by that magic, but I'm also not suggesting doing this
to *all* entries -- just the not-super-magic ones that use
idtentry_enter().

Paul, what is this code actually trying to do?
