Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85CD1C4332B
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 10:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E1B42072C
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 10:05:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbgCUKFj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 06:05:39 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:37929 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbgCUKFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 06:05:38 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jFb0X-0001JJ-3x; Sat, 21 Mar 2020 11:05:33 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 8E15CFFC8D; Sat, 21 Mar 2020 11:05:32 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Singh\, Balbir" <sblbir@amazon.com>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "keescook\@chromium.org" <keescook@chromium.org>,
        "Herrenschmidt\, Benjamin" <benh@amazon.com>,
        "x86\@kernel.org" <x86@kernel.org>
Subject: Re: [RFC PATCH] arch/x86: Optionally flush L1D on context switch
In-Reply-To: <034a2c0e2cc1bb0f4f7ff9a2c5cbdc269a483a71.camel@amazon.com>
References: <20200313220415.856-1-sblbir@amazon.com> <87imj19o13.fsf@nanos.tec.linutronix.de> <97b2bffc16257e70b8aa98ee86622dc4178154c4.camel@amazon.com> <8736a3456r.fsf@nanos.tec.linutronix.de> <034a2c0e2cc1bb0f4f7ff9a2c5cbdc269a483a71.camel@amazon.com>
Date:   Sat, 21 Mar 2020 11:05:32 +0100
Message-ID: <87d096rpjn.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Balbir,

"Singh, Balbir" <sblbir@amazon.com> writes:
> On Fri, 2020-03-20 at 12:49 +0100, Thomas Gleixner wrote:
>> I forgot the gory details by now, but having two entry points or a
>> conditional and share the rest (page allocation etc.) is definitely
>> better than two slightly different implementation which basically do the
>> same thing.
>
> OK, I can try and dedup them to the extent possible, but please do remember
> that 
>
> 1. KVM is usually loaded as a module
> 2. KVM is optional
>
> We can share code, by putting the common bits in the core kernel.

Obviously so.

>> > 1. SWAPGS fixes/work arounds (unless I misunderstood your suggestion)
>> 
>> How so? SWAPGS mitigation does not flush L1D. It merily serializes SWAPGS.
>
> Sorry, my bad, I was thinking MDS_CLEAR (via verw), which does flush out
> things, which I suspect should be sufficient from a return to user/signal
> handling, etc perspective.

MDS is affecting store buffers, fill buffers and load ports. Different story.

> Right now, reading through 
> https://software.intel.com/security-software-guidance/insights/deep-dive-snoop-assisted-l1-data-sampling
> , it does seem like we need this during a context switch, specifically since a
> dirty cache line can cause snooped reads for the attacker to leak data. Am I
> missing anything?

Yes. The way this goes is:

CPU0                   CPU1

victim1
 store secrit
                        victim2
attacker                  read secrit

Now if L1D is flushed on CPU0 before attacker reaches user space,
i.e. reaches the attack code, then there is nothing to see. From the
link:

  Similar to the L1TF VMM mitigations, snoop-assisted L1D sampling can be
  mitigated by flushing the L1D cache between when secrets are accessed
  and when possibly malicious software runs on the same core.

So the important point is to flush _before_ the attack code runs which
involves going back to user space or guest mode.

>> Even this is uninteresting:
>> 
>>     victim in -> attacker in (stays in kernel, e.g. waits for data) ->
>>     attacker out -> victim in
>> 
>
> Not from what I understand from the link above, the attack is a function of
> what can be snooped by another core/thread and that is a function of what
> modified secrets are in the cache line/store buffer.

Forget HT. That's not fixable by any flushing simply because there is no
scheduling involved.

CPU0  HT0          CPU0 HT1		CPU1

victim1            attacker
 store secrit
                        		victim2
                                          read secrit

> On return to user, we already use VERW (verw), but just return to user
> protection is not sufficient IMHO. Based on the link above, we need to clear
> the L1D cache before it can be snooped.

Again. Flush is required between store and attacker running attack
code. The attacker _cannot_ run attack code while it is in the kernel so
flushing L1D on context switch is just voodoo.

If you want to cure the HT case with core scheduling then the scenario
looks like this:

CPU0  HT0          CPU0 HT1		CPU1

victim1            IDLE
 store secrit
-> IDLE
                   attacker in 		victim2
                                          read secrit

And yes, there the context switch flush on HT0 prevents it. So this can
be part of a core scheduling based mitigation or handled via a per core
flush request.

But HT is attackable in so many ways ...

Thanks,

        tglx
