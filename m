Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0648FC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 18:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE27320737
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 18:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598464848;
	bh=WId3BTrlpx4dFQDQ6F8bBoE8Z80/dTcpERIP1b6Ga9k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=cJ2JAtwWqDUzwISA8QjBq8TKcr0Dm5TlscNb8z2WN5mBrDg2lw+etWMqtgH+fYIA6
	 9NTvy1sQE5u1rv+cdO/WRBWJvI6+Cscu53TElNZ2BhmWEJx3aQR/laoDC6inf6BYwW
	 0qogPQ6llFAaaaAkJkZYJ0QdfwG7Cnniuvz9CPDk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbgHZSAq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 14:00:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:39246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726187AbgHZSAh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 14:00:37 -0400
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF5D22080C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 18:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598464837;
        bh=WId3BTrlpx4dFQDQ6F8bBoE8Z80/dTcpERIP1b6Ga9k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WlCZi8EnojE9mq3JsTMdB/EpU2IwvMKwp4nkRpPehl/Wjl/ingt87cxtdjE8cPlt6
         +4uXgelDmcDTttV78THznZZSXI8M7WhMwgPrUNGbRk/h+zbH2gI1pHiFBOxxT1vwtJ
         Vojt3Y3rXd1laRtNb2Uv+FxqgBAn8TJh82ki5g10=
Received: by mail-wr1-f45.google.com with SMTP id a5so2742292wrm.6
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 11:00:36 -0700 (PDT)
X-Gm-Message-State: AOAM5300351o9y8w6hl7L34Aw49lVRE4lj41ittwmXT9GxG8jymyrWYP
        63UbWLCdC+I26hF1YL26bdQWwRlvTCylgzqwE+gtGg==
X-Google-Smtp-Source: ABdhPJx+8ruOOWOEt9g6LP17Jqc4u8yMfiB8jgl3qmPXylIwXxEaVMQkkFlxfJ5W/ZHpeKHB79EY3NJ71151MgqzJLM=
X-Received: by 2002:adf:f442:: with SMTP id f2mr6093709wrp.184.1598464835295;
 Wed, 26 Aug 2020 11:00:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200826115357.3049-1-graf@amazon.com> <87k0xlv5w5.fsf@nanos.tec.linutronix.de>
 <CALCETrX-8a61k03+XJop=k11-TkE+7JOiGTH=81sHXPmXsA+Tw@mail.gmail.com> <87eentuwn8.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87eentuwn8.fsf@nanos.tec.linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 26 Aug 2020 11:00:23 -0700
X-Gmail-Original-Message-ID: <CALCETrWG9UZUuygcTtYi51UFnaENW8Cv8xhuMXSZprP+_dQrFA@mail.gmail.com>
Message-ID: <CALCETrWG9UZUuygcTtYi51UFnaENW8Cv8xhuMXSZprP+_dQrFA@mail.gmail.com>
Subject: Re: [PATCH] x86/irq: Preserve vector in orig_ax for APIC code
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Alexander Graf <graf@amazon.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
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
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Jason Chen CJ <jason.cj.chen@intel.com>,
        Zhao Yakui <yakui.zhao@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Avi Kivity <avi@scylladb.com>,
        "Herrenschmidt, Benjamin" <benh@amazon.com>, robketr@amazon.de,
        Amos Kong <amos@scylladb.com>, Brian Gerst <brgerst@gmail.com>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 26, 2020 at 10:47 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Andy,
>
> On Wed, Aug 26 2020 at 09:13, Andy Lutomirski wrote:
> > On Wed, Aug 26, 2020 at 7:27 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> >> The below nasty hack cures it, but I hate it with a passion. I'll look
> >> deeper for a sane variant.
> >>
> > Fundamentally, the way we overload orig_ax is problematic.  I have a
> > half-written series to improve it, but my series is broken.  I think
> > it's fixable, though.
> >
> > First is this patch to use some __csh bits to indicate the entry type.
> > As far as I know, this patch is correct:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/commit/?h=x86/entry&id=dfff54208072a27909ae97ebce644c251a233ff2
>
> Yes, that looks about right.
>
> > Then I wrote this incorrect patch:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/commit/?h=x86/entry&id=3a5087acb8a2cc1e88b1a55fa36c2f8bef370572
> >
> > That one is wrong because the orig_ax wreckage seems to have leaked
> > into user ABI -- user programs think that orig_ax has certain
> > semantics on user-visible entries.
>
> Yes, orig_ax is pretty much user ABI for a very long time.
>
> > But I think that the problem in this thread could be fixed quite
> > nicely by the first patch, plus a new CS_ENTRY_IRQ and allocating
> > eight bits of __csh to store the vector.  Then we could read out the
> > vector.
>
> That works. Alternatively I can just store the vector in the irq
> descriptor itself. That's trivial enough and can be done completely in C
> independent of the stuff above.

The latter sounds quite sensible to me.  It does seem vaguely
ridiculous to be trying to fish the vector out of pt_regs in the APIC
code.

--Andy
