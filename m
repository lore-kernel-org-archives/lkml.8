Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC43DC4BA24
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 20:25:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B73CB2072D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 20:25:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbgBZUZk convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 15:25:40 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:59565 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727260AbgBZUZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 15:25:40 -0500
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j73FF-0005pG-O5; Wed, 26 Feb 2020 21:25:25 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 36C5A104099; Wed, 26 Feb 2020 21:25:25 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andy Lutomirski <luto@amacapital.net>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <JGross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch 13/16] x86/entry: Move irqflags and context tracking to C for simple idtentries
In-Reply-To: <A4E714B9-ECBA-4984-986C-02B4EAF5018C@amacapital.net>
References: <20200226162811.GA18400@hirez.programming.kicks-ass.net> <A4E714B9-ECBA-4984-986C-02B4EAF5018C@amacapital.net>
Date:   Wed, 26 Feb 2020 21:25:25 +0100
Message-ID: <87blplp03u.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Lutomirski <luto@amacapital.net> writes:
>> On Feb 26, 2020, at 8:28 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>> 
>> ﻿On Wed, Feb 26, 2020 at 07:11:39AM -0800, Andy Lutomirski wrote:
>> 
>>> In some sense, this is a weakness of the magic macro approach.  Some
>>> of the entries just want to have code that runs before all the entry
>>> fixups.  This is an example of it.  So are the cr2 reads.  It can all
>>> be made to work, but it's a bit gross.
>> 
>> Right. In my current pile (new patche since last posting) I also have
>> one that makes #DB save-clear/restore DR7.
>> 
>> I got it early enough that only a watchpoint on the task stack can still
>> screw us over, since I also included your patch that excludes
>> cpu_entry_area.
>
> Hmm. It would be nice to prevent watchpoints on the task stack, but that would need some trickery.  It could be done.
>
>> 
>> Pushing it earlier still would require calling into C from the entry
>> stack, which I know is on your todo list, but we're not quite there yet.
>
> Indeed.
>
> This is my main objection to the DEFINE_IDTENTRY stuff. It’s *great*
> for the easy cases, but it’s not so great for the nasty cases. Maybe
> we should open code PF, MC, DB, etc.  (And kill the kvm special case
> for PF.  I have a working patch for that and I can send it.)

I'm fine with that. I like the obvious easy ones as it spares to
duplicate all the same crap all over the place.

Making the nasty ones have:

#define DEFINE_IDTENTRY_$NASTY(exc_name)	\
__visible void notrace exc_name(args....)

would solve this and you can stick whatever you want into it and have
the NOPROBE added manually. Hmm?

Thanks,

        tglx


