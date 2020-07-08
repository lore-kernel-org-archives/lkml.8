Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54698C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 22:06:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 241672078A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 22:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594246013;
	bh=jVAW2G2+EwGS0eOOYnWqKfLq9W0ARKQ6+DuP1SLI3ys=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eDjXgFvqKQLWHLFC8+Idug40Qspd8Z8FUtR1BE08mNt+4m4NZ+benbSzkQLCZek+B
	 KoPrsbH221rq9IZM5mOM4U+nQ+k+dFID7eqPNiafGxwKSlSW3bfUc4JnGwWwNrKnqc
	 gt+Rw+MAXLV0+faiVcVT4Fxo9YTwSjj7Be/SQZ7o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbgGHWGv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 18:06:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:41148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbgGHWGv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 18:06:51 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B639B206DF;
        Wed,  8 Jul 2020 22:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594246010;
        bh=jVAW2G2+EwGS0eOOYnWqKfLq9W0ARKQ6+DuP1SLI3ys=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FXXNBtvxztsAaZYysaTM7W6FWjkWB31YhyYSb4kOddKZRmtadQG+UaSK3YwtCOdqU
         YddMJIEIxpguWgF1Rk6JtiBnsLkkJR6n5O8I5GK9eNwbwGrD0VWluZqh0ETcTub3Xp
         gOhIarpZDVawibWMUbBsjrtnJRHREDRhuYAAYNGc=
Date:   Wed, 8 Jul 2020 23:06:45 +0100
From:   Will Deacon <will@kernel.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     "liwei (GF)" <liwei391@huawei.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        David Miller <davem@davemloft.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, liwei1412@163.com
Subject: Re: [PATCH 0/4] arm64: kgdb/kdb: Fix single-step debugging issues
Message-ID: <20200708220645.GA27130@willie-the-truck>
References: <20200509214159.19680-1-liwei391@huawei.com>
 <CAD=FV=Xv6xgj_M9tYjHzmW4UZD2RdH2c5=dagNybSkdfBabYZw@mail.gmail.com>
 <a20ee677-495b-9336-a329-eabd50dd1cad@huawei.com>
 <CAD=FV=WYBAJB_nWxUAAVgV26e4CTzJeizZtxpwus6REi3j2meA@mail.gmail.com>
 <20200630072221.GA13332@willie-the-truck>
 <CAD=FV=UmKLqP3tqNco=cKvdf5hOTChAp5h_3C5Q5mYKQptDDJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=UmKLqP3tqNco=cKvdf5hOTChAp5h_3C5Q5mYKQptDDJw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Doug,

On Mon, Jul 06, 2020 at 02:37:05PM -0700, Doug Anderson wrote:
> On Tue, Jun 30, 2020 at 12:22 AM Will Deacon <will@kernel.org> wrote:
> > On Mon, Jun 29, 2020 at 02:20:11PM -0700, Doug Anderson wrote:
> > > On Sat, May 16, 2020 at 1:20 AM liwei (GF) <liwei391@huawei.com> wrote:
> > > > On 2020/5/14 8:34, Doug Anderson wrote:
> > > > > On Sat, May 9, 2020 at 6:49 AM Wei Li <liwei391@huawei.com> wrote:
> > > > >>
> > > > >> This patch set is to fix several issues of single-step debugging
> > > > >> in kgdb/kdb on arm64.
> > > > >>
> > > > >> It seems that these issues have been shelved a very long time,
> > > > >> but i still hope to solve them, as the single-step debugging
> > > > >> is an useful feature.
> > > > >>
> > > > >> Note:
> > > > >> Based on patch "arm64: cacheflush: Fix KGDB trap detection",
> > > > >> https://www.spinics.net/lists/arm-kernel/msg803741.html
> > > > >>
> > > > >> Wei Li (4):
> > > > >>   arm64: kgdb: Fix single-step exception handling oops
> > > > >>   arm64: Extract kprobes_save_local_irqflag() and
> > > > >>     kprobes_restore_local_irqflag()
> > > > >>   arm64: kgdb: Fix single-stepping into the irq handler wrongly
> > > > >>   arm64: kgdb: Set PSTATE.SS to 1 to reenable single-step
> > > > >>
> > > > >>  arch/arm64/include/asm/debug-monitors.h |  6 ++++++
> > > > >>  arch/arm64/kernel/debug-monitors.c      | 28 ++++++++++++++++++++++++-
> > > > >>  arch/arm64/kernel/kgdb.c                | 16 +++++++++++---
> > > > >>  arch/arm64/kernel/probes/kprobes.c      | 28 ++-----------------------
> > > > >>  4 files changed, 48 insertions(+), 30 deletions(-)
> > > > >
> > > > > Just an overall note that I'm very happy that you posted this patch
> > > > > series!  It's always been a thorn in my side that stepping and
> > > > > breakpoints were so broken on arm64 and I'm really excited that you're
> > > > > fixing them.  Now I'll have to get in the habit of using kgdb for more
> > > > > than just debugging crashes and maybe I can use it more for exploring
> > > > > how functions work more.  :-)
> > > > > > I'll also note that with your patch series I'm even seeing the "call"
> > > > > feature of gdb working now.  That has always been terribly broken for
> > > > > me.
> > > > >
> > > > Thanks for reviewing and testing this series.
> > > > Enjoy exploring the kernel with kgdb/kdb! :-)
> > >
> > > I'm curious to know if you plan another spin.  The feedback you
> > > received was fairly minor so it hopefully shouldn't be too hard.  I'd
> > > very much like to get your patches landed and I'd be happy to try to
> > > address the feedback and spin them myself if you're no longer
> > > available for it.
> >
> > I'd welcome some feedback on the proposal I sent out at the end of last
> > week:
> >
> > https://lore.kernel.org/r/20200626095551.GA9312@willie-the-truck
> >
> > which looks to solve some (all?) of these issues
> 
> Actually, I'm pretty sure that patch #1 of Wei Li's patch series would
> still be needed.  Would you object to landing it now just to get one
> patch outta the way?
> 
> https://lkml.kernel.org/r/20200509214159.19680-2-liwei391@huawei.com

I've grabbed patch 1, cheers.

> > slightly differently,
> > because it turns out we need to perform some low-level surgery for
> > preempt-rt *anyway*...
> >
> > I'm particularly keen to hear any thoughts concerning the reschedule on
> > return to EL1 after handling an interrupt that hit during a step.
> 
> Thanks for the pointer!  Unfortunately this is yet another area that
> I'm keenly interested in it working but pretty much clueless about how
> this whole area of the system works.  :-|

I'm also keen to fix it up but, although I roughly know how it works, I
always fail to find the time to spend on it. :-|

> My first question, though, is why would we want interrupts enabled
> while we're single stepping?  If you're trying to get the processor to
> just step one instruction forward you don't really want a bunch of
> IRQs going off in the middle of it, do you?  While in kgdb and
> debugging the kernel I would assume that a single step would run the
> very least amount of code that it could (other than debugger code).
> In general every time I exit kgdb (and re-start running the kernel
> normally) I sorta assume that there's a chance that something in the
> system will hit a timeout (maybe it's talking to external hardware
> that will give up or something).  If I'm stepping through code I just
> want that little bit of code I'm running to move forward and the rest
> of the kernel to stand still.  If I want the rest of the kernel to
> proceed I guess I'd set a breakpoint and then say "continue".

I understand where you're coming from, but I also think it's a reasonably
narrow viewpoint. If you disable IRQs during a step, you can change the
behaviour of the instruction being stepped. For example, an MRS of DAIF
will now see the I bit set instead of clear, and so something like
irqs_disabled() could go wrong while being stepped. But I think the main
realisation is that instructions being stepped can generate exceptions for
other reasons too, for example if you try to step a BUG() or a get_user().
Not only does that mean that we have to deal with exceptions during a step,
but it also means that disabling interrupts is a pretty bad idea because
the exception context may rely on them being enabled (for example, if it has
to sleep while handling a page fault).

> It seemed like with Wei Li's patch that we were closing holes and
> being more consistent about keeping interrupts disabled when stepping
> and I liked that.  Maybe if we made it so that taking interrupts
> didn't break everything then it would be _OK_ to let them fire, but if
> I had a choice I'd rather they didn't.

Although I appreciate somebody sending patches to improve this logic,
I really worry that it just moves the problem around and it won't be long
before somebody else sends another set of patches trying to deal with the
fallout. That ends up being a waste of everybody's time.

> ...of course, I'm looking at all this from the point of view of kgdb.
> I don't know nearly enough about how other parts of the kernel use
> single step to comment much on what would be best for them.

Sure, and I see you as Mr KGDB in this area anyway, but that's an important
user of this infrastructure (esp. single-step).

> Did what I said make sense at all, or was it gibberish?  ...or not
> gibberish but not what you were looking for?

I'm fairly set on unmasking IRQs during step for the reasons I mention
above. The question is really whether or not to forcibly prevent preemption
during such an irq.

Will
