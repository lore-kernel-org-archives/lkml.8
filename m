Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7412BC352A3
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 00:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B51920873
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 00:18:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbgBNASd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 19:18:33 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:53536 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727594AbgBNASd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 19:18:33 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j2Ogd-0005iL-L5; Fri, 14 Feb 2020 01:18:27 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 27E67101115; Fri, 14 Feb 2020 01:18:27 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andy Lutomirski <luto@kernel.org>,
        "Luck\, Tony" <tony.luck@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/5] x86/mce: Fix all mce notifiers to update the mce->handled bitmask
In-Reply-To: <CALCETrVrL1Ps9ubAcKQykxTofn4hbkESBYE9H22Ws5Pis_vG+g@mail.gmail.com>
References: <20200212204652.1489-1-tony.luck@intel.com> <20200212204652.1489-5-tony.luck@intel.com> <20200213170308.GM31799@zn.tnic> <20200213221913.GB21107@agluck-desk2.amr.corp.intel.com> <CALCETrVrL1Ps9ubAcKQykxTofn4hbkESBYE9H22Ws5Pis_vG+g@mail.gmail.com>
Date:   Fri, 14 Feb 2020 01:18:27 +0100
Message-ID: <87pneiggx8.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Lutomirski <luto@kernel.org> writes:

> On Thu, Feb 13, 2020 at 2:19 PM Luck, Tony <tony.luck@intel.com> wrote:
>>
>> On Thu, Feb 13, 2020 at 06:03:08PM +0100, Borislav Petkov wrote:
>> > On Wed, Feb 12, 2020 at 12:46:51PM -0800, Tony Luck wrote:
>> > > If the handler took any action to log or deal with the error, set
>> > > a bit int mce->handled so that the default handler on the end of
>> > > the machine check chain can see what has been done.
>> > >
>> > > [!!! What to do about NOTIFY_STOP ... any handler that returns this
>> > > value short-circuits calling subsequent entries on the chain. In
>> > > some cases this may be the right thing to do ... but it others we
>> > > really want to keep calling other functions on the chain]
>> >
>> > Yes, we can kill that NOTIFY_STOP thing in the mce code since it is
>> > nasty.
>>
>> Well, there are places where we want to keep NOTIFY_STOP.
>
> I very very strongly disagree.

Ack. The unholy mess of cpu hotplug notifiers and the at least 50 bugs
which were unearthed by converting them to a comprehensible and
symmetric state machine have documented the insanity of notifiers
nicely.

>> 1) Default case for CEC.  We want it to "hide" the corrected error.
>>    That was one of the main goals for CEC.  We've discussed cases
>>    where CEC shouldn't hide (when internal threshold exceeded and
>>    it tries to take a page offline ... probably something related to
>>    CMCI storms ... though we didn't really come to any conclusion)
>
> Then put this logic in do_machine_check() or in some sensible place
> that it calls via some ops structure or directly.  Don't hide it in
> some incomprehensible, possibly nondeterministic place in a notifier
> chain.
>
>> 2) Errata. Perhaps a vendor/platform specific function at the head
>>    of the notify chain that weeds out errors that should never have
>>    been reported.
>
> No, do this before the notifier chain please.

Right. The amount of possible handlers is really not huge.

So having a well defined flow of explicit calls including the handling
of magic workarounds in a central place makes tons of sense.

Thanks,

        tglx
