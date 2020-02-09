Return-Path: <SRS0=6uoK=35=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24048C2BA83
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 20:54:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF98820733
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 20:54:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727892AbgBIUxf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Feb 2020 15:53:35 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42713 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727409AbgBIUxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Feb 2020 15:53:35 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j0ta8-0007Rh-Fp; Sun, 09 Feb 2020 21:53:32 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id B6CBF100F5A; Sun,  9 Feb 2020 21:53:31 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [GIT pull] perf fixes for 5.6-rc1
In-Reply-To: <CAHk-=wiEg6+j1UuRSAZmXozJEw0p33gM9uPT2oAOFwsOUaa=uw@mail.gmail.com>
References: <158125695731.26104.949647922067525745.tglx@nanos.tec.linutronix.de> <158125695732.26104.3631526665331853849.tglx@nanos.tec.linutronix.de> <CAHk-=wiEg6+j1UuRSAZmXozJEw0p33gM9uPT2oAOFwsOUaa=uw@mail.gmail.com>
Date:   Sun, 09 Feb 2020 21:53:31 +0100
Message-ID: <877e0v5vp0.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Sun, Feb 9, 2020 at 6:06 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>>
>>    - Prevent am intgeer underflow in the perf mlock acounting
>>
>>    - Add a missing prototyp for arch_perf_update_userpage()
>>
>>    - Fix the perf parser so it does not delete parse event terms, which
>>      caused a regression for using perf with the ARM CoreSight as the sink
>>      confuguration was missing due to the deletion.
>
> You've started drinking too early in the day.  But hey, I guess it was
> evening _somewhere_ in the world.

I swear, I wasn't even near alcohol before writing this.

> Pick out the five speeling errors in that pull request message.

But I have to admit shamefully that I really should have searched my
misplaced reading glasses instead of trying to squint through my driving
glasses.

Want me to redo it?

Thanks,

        tglx
