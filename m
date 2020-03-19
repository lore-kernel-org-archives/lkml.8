Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A11C4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 08:20:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5396220714
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 08:20:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbgCSIUv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 04:20:51 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59617 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgCSIUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 04:20:50 -0400
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1jEqPm-0002Oo-Vy; Thu, 19 Mar 2020 09:20:31 +0100
From:   John Ogness <john.ogness@linutronix.de>
To:     Eugeniu Rosca <erosca@de.adit-jv.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        <linux-kernel@vger.kernel.org>, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andrew Gabbasov <andrew_gabbasov@mentor.com>,
        Dirk Behme <dirk.behme@de.bosch.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
Subject: Re: [RFC PATCH 3/3] watchdog: Turn console verbosity on when reporting softlockup
References: <20200315170903.17393-1-erosca@de.adit-jv.com>
        <20200315170903.17393-4-erosca@de.adit-jv.com>
        <20200317021818.GD219881@google.com>
        <20200318180525.GA5790@lxhi-065.adit-jv.com>
Date:   Thu, 19 Mar 2020 09:20:27 +0100
In-Reply-To: <20200318180525.GA5790@lxhi-065.adit-jv.com> (Eugeniu Rosca's
        message of "Wed, 18 Mar 2020 19:05:25 +0100")
Message-ID: <87r1xog3hw.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-03-18, Eugeniu Rosca <erosca@de.adit-jv.com> wrote:
> On Tue, Mar 17, 2020 at 11:18:18AM +0900, Sergey Senozhatsky wrote:
>> On (20/03/15 18:09), Eugeniu Rosca wrote:
>>> @@ -428,6 +428,8 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
>>>  			}
>>>  		}
>>>  
>>> +		console_verbose_start();
>>> +
>>>  		pr_emerg("BUG: soft lockup - CPU#%d stuck for %us! [%s:%d]\n",
>>>  			smp_processor_id(), duration,
>>>  			current->comm, task_pid_nr(current));
>>> @@ -453,6 +455,8 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
>>>  		if (softlockup_panic)
>>>  			panic("softlockup: hung tasks");
>>>  		__this_cpu_write(soft_watchdog_warn, true);
>>> +
>>> +		console_verbose_end();
>>>  	} else
>>>  		__this_cpu_write(soft_watchdog_warn, false);
>> 
>> I'm afraid, as of now, this approach is not going to work the way it's
>> supposed to work in 100% of cases. Because the only thing that printk()
>> call sort of guarantees is that the message will be stored somewhere.
>> Either in the main kernel log buffer, on in one of auxiliary per-CPU
>> log buffers. It does not guarantee, generally speaking, that the message
>> will be printed on the console immediately.
>
> I take this passage as an acknowledgement of the problem being _real_,
> in spite of the fix being not perfect.
>
> One aspect I would like to emphasize is that (please, NAK this
> statement if it's not accurate) the problem reported in this patch is
> not specific to the existing printk mechanism, but also applies to the
> upcoming kthread-based printk. If that's true, then IMHO this is a
> compelling argument to join forces and try to find a working, safe and
> future-proof solution.

Let me clarify that the upcoming rework is _not_ simply to make a
kthread-based printk. There upcoming rework addresses several issues
(kthreads being only a piece):

1. allow printk-callers to get their messages immediately and locklessly
   into the log buffer from any context

2. during normal operation, printk-callers are completely decoupled from
   console printing

3. in the case of an emergency, every printk-caller will directly and
   synchronously perform console printing of its messages on consoles
   that support atomic writing

For the rework we decided that triggering an oops is what irreversibly
transitions the system from "normal operation" to "emergency".

One could interpret the current "console_verbose()" to be some sort of
equivalent to irreversibly transitioning the system to "emergency". But
that is not how it was decided to be interpreted. For the rework,
printk-callers do not have any influence on forcing immediate console
printing (unless they trigger an oops). console_verbose() is still
relevant in the rework. console_verbose() is affecting _what_ is printed
to consoles and _not when_.

Once the printk rework is complete, the mechanisms for atomic and
synchronous console printing will be in place. It would be possible that
these mechanisms could also be used in non-oops scenarios. But that
would need to be discussed in depth and clearly defined with caution for
abuse.

John Ogness
