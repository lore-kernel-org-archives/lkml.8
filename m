Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE66FC10DCE
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 00:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0C6420637
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 00:45:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbgCGApj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 19:45:39 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:54755 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbgCGApj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 19:45:39 -0500
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jANav-000056-47; Sat, 07 Mar 2020 01:45:33 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 1C2B2104088; Sat,  7 Mar 2020 01:45:32 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Qian Cai <cai@lca.pw>
Cc:     fweisbec@gmail.com, mingo@kernel.org, elver@google.com,
        linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] tick/sched: fix data races at tick_do_timer_cpu
In-Reply-To: <1583506974.7365.160.camel@lca.pw>
References: <87tv34laqq.fsf@nanos.tec.linutronix.de> <1C65422C-FFA4-4651-893B-300FAF9C49DE@lca.pw> <1583506974.7365.160.camel@lca.pw>
Date:   Sat, 07 Mar 2020 01:45:32 +0100
Message-ID: <878skdat77.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qian Cai <cai@lca.pw> writes:
> On Wed, 2020-03-04 at 06:20 -0500, Qian Cai wrote:
>> Looks at tick_sched_do_timer(), for example,
>> 
>> if (unlikely(tick_do_timer_cpu == TICK_DO_TIMER_NONE)) {
>> #ifdef CONFIG_NO_HZ_FULL
>> 		WARN_ON(tick_nohz_full_running);
>> #endif
>> 		tick_do_timer_cpu = cpu;
>> 	}
>> #endif
>> 
>> /* Check, if the jiffies need an update */
>> if (tick_do_timer_cpu == cpu)
>> 	tick_do_update_jiffies64(now);
>> 
>> Could we rule out all compilers and archs will not optimize it if !CONFIG_NO_HZ_FULL to,
>> 
>> if (unlikely(tick_do_timer_cpu == TICK_DO_TIMER_NONE) || tick_do_timer_cpu == cpu)
>>          tick_do_update_jiffies64(now);
>> 
>> So it could save a branch or/and realized that tick_do_timer_cpu is
>> not used later in this cpu, so it could discard the store?

Sorry, I can't make any sense of this.

If a compiler optimizes this in the way you are describing then it is
seriously broken. If that happens then lots of code will just fall apart
in colourful ways.

>> I am not all that familiar with all other 14 places if it is possible
>> to happen concurrently as well, so I took a pragmatic approach that
>> for now only deal with the places that KCSAN confirmed, and then look
>> forward for an incremental approach if there are more places needs
>> treatments later once confirmed.

Stop this please. I just wasted days to understand why code was
sprinkled with random rcu*enter/exit() invocations until I figured out
that the reason was exactly what you are proposing:

     Curing the symptoms

That's the worst engineering principle ever, really.

Just shutting up the tool without doing a proper analysis is a
guaranteed recipe for disaster because it is going to paper over real or
latent bugs. Read the git log history carefully to find prime examples
for this.

So no, neither shutting up just the places KCSAN complained about and
ignoring the rest nor your new proposal
 
> If you don't think that will be happening and dislike using READ/WRITE_ONCE()
> for documentation purpose, we could annotate those using the data_race() macro.
> Is that more acceptable?

is leading anywhere. It's both based on cargo cult programming and lacks
proper root cause analysis.

I'm surely not ignoring the output of KCSAN, but please understand that
any attempt to silence its output purely based on mechanical duct tape
is not going anywhere.

I wasted actually months in the past to decode a subtle wreckage which
was caused by the back then 'silence uninitilized variable warnings'
frenzy. One of these blindly applied annotations papered over a real
bug and made it horribly hard to find.

As I'm busy with other urgent nightmares right now, this has to wait
until I get some spare cycles or you come up with some proper analysis.

Thanks,

        tglx
