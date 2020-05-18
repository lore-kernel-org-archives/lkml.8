Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FCC7C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 23:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11BDD207F9
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 23:00:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbgERXAA convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 19:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbgERXAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 19:00:00 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A3D3C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 16:00:00 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jaojc-0005Dt-Ik; Tue, 19 May 2020 00:59:48 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 0DB1C1006A1; Tue, 19 May 2020 00:59:48 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, bp@alien8.de, luto@kernel.org,
        hpa@zytor.com, dave.hansen@intel.com, tony.luck@intel.com,
        ak@linux.intel.com, ravi.v.shankar@intel.com,
        chang.seok.bae@intel.com,
        Andrew Cooper <andrew.cooper3@citrix.com>, x86@kernel.org
Subject: Re: [PATCH v12 10/18] x86/fsgsbase/64: Enable FSGSBASE instructions in helper functions
In-Reply-To: <20200518202435.GD33628@sasha-vm>
References: <20200511045311.4785-11-sashal@kernel.org> <87v9ktw1ev.fsf@nanos.tec.linutronix.de> <20200518202435.GD33628@sasha-vm>
Date:   Tue, 19 May 2020 00:59:48 +0200
Message-ID: <87y2povogr.fsf@nanos.tec.linutronix.de>
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

Sasha,

Sasha Levin <sashal@kernel.org> writes:
> Thank you for taking the time to review this.

welcome and sorry for the explosion.

> On Mon, May 18, 2020 at 08:20:08PM +0200, Thomas Gleixner wrote:
>>Sasha Levin <sashal@kernel.org> writes:
>>This conditional irqsave gunk is clearly NOT what was in the tip tree
>>before it got reverted:
>>
>>  a86b4625138d ("x86/fsgsbase/64: Enable FSGSBASE instructions in helper functions")
>
> It wasn't in the reverted series, it came in Intel's v9 series, with
> these comments in the cover letter:
>
> 	Updates from v8 [10]:
> 	[...]
> 	* Simplified GS base helper functions (Tony L.)

Ok. I never looked at that series because that requested confirmation
that nothing will regress due to the ptrace changes was not there. After
a bit of handwaving this dried out. So I completely missed that back
then. And I did not look at any later variant which had 0day complaints.

> And I did, Thomas. While I'm not intimately familiar with the code I
> made sure that all the patches that came on top of the merged series
> before it got reverted made it into this new series. However, more work
> has happened here after the revert and I would expect that the code in
> this new series will be different than the code you reverted last
> year.

It's obvious that it would be different from what was merged simply
because the affected code has changed but not in substantial points like
losing a kprobes protection by "simplifying" something which was
carefully done in the first place.

It's not your fault at all, you just happened to be the messanger. The
people responsible for that mess owe you at least a beer.

>> - In paranoid_exit()
>>
>>-	TRACE_IRQS_IRETQ_DEBUG
>>+	TRACE_IRQS_OFF_DEBUG
>
> (assuming we're looking at the same thing here, ) Changed in v8 of the
> series.

Sigh.

> I'm a bit confused about the surprise here that v12 is different than
> the reverted patches. There were multiple rounds of review which
> resulted in the code being more than just a revert of the revert along
> with a small fix.
>
>> > This looks unpleasant to review.  I wonder if it would be better to unrevert
>> > the reversion, merge up to Linus' tree or -tip, and then base the changes on
>> > top of that.
>>
>> I don't think that's a good idea. The old code is broken in several ways
>> and not bisectable. So we really better start from scratch.
>
> And this is what we have here, a series that has more than trivial
> differences from the revert, and is more of a pain to review. Look at
> what you did with your 25 minutes: you've reverted the revert and went
> on to apply fixes on top of it, exactly the thing you've asked
> not to do a few months prior.

I did that to analyse whether that new series has everything what was
fixed back then and did not introduce new bugs. Mission accomplished.

> No need to worry about me sending a new series, as I can't - I just
> don't know what you want to see at this point: on one hand you're saying
> "we really better start from scratch" and on the other hand "this
> conditional irqsave gunk is clearly NOT what was in the tip tree before
> it got reverted", you're making suggestions to change comments only to
> later complain that "a gazillion of comment changes make reading the
> diff harder". 

Gah. That comment change thing was just an annoyance and I complained
about it because I was already grumpy as hell.

So what I meant is that the blind revert of the revert, i.e. just
reapplying the previous stuff, is horrible. Simply because the reverted
patches were already not bisectable. And then applying random changes on
top does not make it any better.

So yes, I would have done exactly where I started:

   1) Extract the original patches from git

   2) Apply them and fixup the rejects

and on top of that:

   3) Make them bisectable by folding back the fixes to the right place
      and reordering them which creates a result which is equivalent to
      'start from scratch' but without losing context and introducing
      new bugs. Simply because it's trivial to diff against the state
      before the revert.

   4) Do the 'improvements' on top, discuss them and fold them back.

For what you tried to do I would have omitted #4 completely and then
did:

   5) Rebase the latest Intel variant

   6) Diff the results ideally step by step

   7) Analyze the deltas carefully and if unsure about the result
      ask.
      
   That way you really would have noticed that this helper patch is
   substantially different and you would have noticed that the kprobes
   protection is gone. Also that would have clearly shown you the IRQ
   flag wreckage.

So to go forward can you please just do #1 - #3 first?

Vs. the s/GSBASE/GS base/g comment changes: I don't mind them per se,
but they are incomplete because they just change it in the new code
while there are still the original comments using GSBASE. So either we
change it wholesale or not at all. If so, then this wants to be a
separate patch right at the beginning of the new series which changes
the existing comments before introducing a different variant.

That "simplified" handling is going nowhere. That conditional irq
disable and the redundant conditionals and the out of line invocation in
switch_to() are just not going to happen.

So when comparing it to the latest Intel trainwreck ignore that part
completely,

I've uploaded my quick shot with a few cleanups on top (folded back) for
reference:

  https://tglx.de/~tglx/patches-fsgs.tar

Uncompiled and untested. I'm not claiming it's bug free either. If you
find one, please keep it. Hope that helps.

Thanks,

        tglx
