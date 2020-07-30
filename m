Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2879C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 10:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 751C320809
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 10:08:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eO1Zpbim";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uQUKCyF9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728976AbgG3KIe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 06:08:34 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49462 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbgG3KI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 06:08:28 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596103706;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=icuGs7gjwEzJJOhYixOZSnol7c85JJb/wOCOTTI7rqU=;
        b=eO1ZpbimFr4/VZU8Xu1Jm7BTN6rAZkCeMIFOqmYVNGjkxlrG/diOZF3bAOO/ImZgtjQOzz
        8D8s1WFC04ITXjEhSjTXEz72UYGwPdPnixayykqXDGWkrEjx0cbnN8FQTRRXpZS0kl30mY
        aQEzLaEyxnNzXRpCp4wjEB8r3yppITClnLcI2OHderc1R+ig373JG4+Tv1mc5kdsCGZ7oT
        HGRJugykK9QNlO0fOVS1PV+bnPkQEWcUHGFbk4ic2ScPFesdmGCuQD4U/MExHZRnbBnSLR
        5kQp8gIbrDWmp4my1T+kihxDQw/Z8ZmwQuZ0mtAZO5RsShevUsWredvuUUnSVw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596103706;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=icuGs7gjwEzJJOhYixOZSnol7c85JJb/wOCOTTI7rqU=;
        b=uQUKCyF9Oe/6KX6UhyWkQD6yQX4GNL5ZsWnPYMWxA1+vs3CNTcslgY87M7qxDLIL9prarx
        OeE/FuDi/D8iHVCQ==
To:     peterz@infradead.org, Fenghua Yu <fenghua.yu@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Tony Luck <tony.luck@intel.com>, H Peter Anvin <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>, x86 <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC] x86/bus_lock: Enable bus lock detection
In-Reply-To: <20200729210935.GE2655@hirez.programming.kicks-ass.net>
Date:   Thu, 30 Jul 2020 12:08:26 +0200
Message-ID: <87r1stmi1x.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

peterz@infradead.org writes:
> On Wed, Jul 29, 2020 at 08:40:57PM +0000, Fenghua Yu wrote:
>> Can we disable Bus Lock Detection before handle it and re-enable it
>> after handle it? Will that resolve the recursion issue?
>
> Because WRMSR is cheap, right?
>
> You have to unconditionally {dis,en}able it on #DB entry/exit. Not only
> when it's a DR_BUS_LOCK, _always_. Then maybe. I'm too tired to think
> through the IST mess.
>
> IST's suck, they're horrible crap.
>
> Suppose we get a #DB, then we get an NMI right before it does WRMSR, so
> BUS_LOCK is still on, then the NMI does a dodgy LOCK op, we die.
>
> So that means, you get to disable it on every NMI-like exception too,
> but we happen to care about performance for those, you loose.
>
> Also, what happens if you have a hardware watchpoint on the instruction
> that causes DR_BUS_LOCK? Does that work as expected?

Q: Why on earth are Intel hardware folks cramming this into #DB?
A: Just because there was a bit left in DR6 to indicate it, right?

Q: Why can't hardware folks talk to us _before_ they make the x86 exception
   trainwreck even worse?
A: Just because they know that we'd tell them to go back to the drawing
   board.

Q: Is that going to be supported by the kernel?
A: No, go back to the drawing board and talk to us _before_ coming back
   with the next half thought out tinkerware cast in silicon.

I'm really tired of wasting time dealing with such misfeatures which create
more problems than they solve.

Thanks,

        Thomas


