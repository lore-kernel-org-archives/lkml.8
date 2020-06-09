Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9181C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 01:08:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C80B2076C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 01:08:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729198AbgFIBIE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 21:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388206AbgFIBHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 21:07:49 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92DCBC03E969
        for <linux-kernel@vger.kernel.org>; Mon,  8 Jun 2020 18:07:48 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jiSjw-00087I-Pc; Tue, 09 Jun 2020 03:07:45 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 99B75101181; Tue,  9 Jun 2020 03:07:43 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [GIT pull - RFC] locking/kcsan for v5.8
In-Reply-To: <CAHk-=whyF0uSwVVvJ8hjVdP=s1m8hXPUzqtbWaNRqz+B52DU5g@mail.gmail.com>
References: <159110310259.14558.3096683243532489290.tglx@nanos.tec.linutronix.de> <CAHk-=whyF0uSwVVvJ8hjVdP=s1m8hXPUzqtbWaNRqz+B52DU5g@mail.gmail.com>
Date:   Tue, 09 Jun 2020 03:07:43 +0200
Message-ID: <87lfkx6o80.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Linus Torvalds <torvalds@linux-foundation.org> writes:
> On Tue, Jun 2, 2020 at 6:07 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>>
>> please consider to pull the latest locking/kcsan branch from:
>
> Gaah. So I left this until I had cleared out my queues, and now that I
> start looking at it, I find myself more annoyed by the messy history
> than by the kcsan code.

I'm surely not proud of it and neither is anyone else involved in that.

> For example, it generates conflicts with the sparc tree, because the
> sparc page table changes weren't done as a shared branch, but
> duplicated as commits (and the subsequent changes cause some
> conflicts).

Sorry, I was not aware of that.

> And the read-once/write-once changes that I was aware of and approve
> of, are similarly mixed in here randomly, rather than being as a
> branch of their own. I see that Will then made his own branch, but
> then we'd have the same issue as with the sparc changes.

We tried hard to keep all that separate, but at some point the resulting
conflicts became interesting.

 1) There was interest to keep the KCSAN history intact because Paul had
    stuff depending on it already

 2) Will's changes conflicted heavily and we had to make a decision what
    has to based on what

 3) Peter's an my efforts to get the whole entry maze sorted out
    introduced another massive change in the same area.

After discussing things back and forth we came to the conclusion that
KCSAN is ready to go and we base all that other stuff on top. In
hindsight maybe not the most brightest idea.

> The things I was _expecting_ to find annoying (various random changes
> to random code due to kcsan reports), I don't actually see.

They got shipped independently because they were legit bugs and the
fixes independent of KCSAN.

> Instead I see odd small completely unrelated things like the
> x86/purgatory changes that were merged in for odd reasons.
>
> How painful would it be to sort this out properly? I'll happily take
> the read-once changes as a separate branch, for example. There's
> nothing really controversial there., even if the gcc version bump
> might annoy some (I personally think we could bump it further up to
> 4.9, and require _Generic, for example - I suspect we have a number of
> places that could use _Generic instead of nasty sizeof games).
>
> I'd even make an exception and say "ok, just rebase the kcsan stuff on
> top" to clean up the messy history, because this is the kind of new
> feature that shouldn't affect a normal build, and I'd hate to have
> other changes that _can_ affect a normal build - like those atomic
> changes - mixed up in the middle of the kcsan stuff.
>
> So my first reaction from looking at this is that I'd rather get the
> infrastructure separately (like I already got the sparc32 page table
> changes), so that once I _do_ get the kcsan bits, they really would be
> "this introduces no semantic changes what-so-ever when not enabled".
>
> IOW, I'd be inclined to instead pull Will's branch, and then whatever
> x86 entry branches, and then kcsan last with _just_ kcsan stuff.
>
> Will that make everybody else cry tears of frustration?

TBH, yes. We played a reasonable amount of patch testris to avoid this
kind of interdependenies already and yes I have to admit that at some
point I gave up with the KCSAN/Will/Peterz conflicts.

I spent quite some time over the past weekend to rebase everything which
still depends on that (tip: x86/entry and ras/core ] onto a Will ->
Peterz scheme and make KCSAN a separate entity, but I'm still facing a
few subtle bugs which I have not decoded yet.

That said, I would appreciate if you bite the bullet and take the mess
as is, but I'm perfectly willing to bite the bullet and get all of this
restructured in the hope to get it done in time.

What really would cause massive frustration would be to sacrifice the
entry rework for this.

Anyway, I hope I gave you enough context and as I'm not going to touch
any of this before tomorrow morning, please take your time and let me
know.

Thanks,

        Thomas
