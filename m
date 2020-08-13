Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A463CC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 11:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88E7820656
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 11:30:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbgHMLai (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 07:30:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:39208 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726131AbgHMLah (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 07:30:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0B235B6A3;
        Thu, 13 Aug 2020 11:30:58 +0000 (UTC)
Date:   Thu, 13 Aug 2020 13:30:35 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kexec@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: POC: Alternative solution: Re: [PATCH 0/4] printk: reimplement
 LOG_CONT handling
Message-ID: <20200813113035.GN12903@alley>
References: <20200717234818.8622-1-john.ogness@linutronix.de>
 <CAHk-=wivdy6-i=iqJ1ZG9YrRzaS0_LHHEPwb9KJg-S8i-Wm30w@mail.gmail.com>
 <87blkcanps.fsf@jogness.linutronix.de>
 <20200811160551.GC12903@alley>
 <20200812163908.GH12903@alley>
 <87v9hn2y1p.fsf@jogness.linutronix.de>
 <20200813051853.GA510@jagdpanzerIV.localdomain>
 <875z9nvvl2.fsf@jogness.linutronix.de>
 <20200813084136.GK12903@alley>
 <87v9hmrg84.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v9hmrg84.fsf@jogness.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2020-08-13 12:35:47, John Ogness wrote:
> On 2020-08-13, Petr Mladek <pmladek@suse.com> wrote:
> > On Thu 2020-08-13 09:50:25, John Ogness wrote:
> >> On 2020-08-13, Sergey Senozhatsky <sergey.senozhatsky@gmail.com> wrote:
> >> > This is not an unseen pattern, I'm afraid. And the problem here can
> >> > be more general:
> >> >
> >> > 	pr_info("text");
> >> > 	pr_cont("1");
> >> > 	exception/IRQ/NMI
> >> > 		pr_alert("text\n");
> >> > 	pr_cont("2");
> >> > 	pr_cont("\n");
> >> >
> >> > I guess the solution would be to store "last log_level" in task_struct
> >> > and get current (new) timestamp for broken cont line?
> >> 
> >> (Warning: new ideas ahead)
> >> 
> >> The fundamental problem is that there is no real association between
> >> the cont parts. So any interruption results in a broken record. If we
> >> really want to do this correctly, we need real association.
> 
> I believe I failed to recognize the fundamental problem. The fundamental
> problem is that the pr_cont() semantics are very poor. I now strongly
> believe that we need to fix those semantics by having the pr_cont() user
> take responsibility for buffering the message. Patching the ~2000
> pr_cont() users will be far easier than continuing to twist ourselves
> around this madness.

Yes, this would make the API much more reliable. But it is not completely
easy. It has been discussed several times. The most serious attempt
is https://lore.kernel.org/lkml/1541165517-3557-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp/#t

lockdep.c is probably the most complicated pr_cont() user. The
conversion complicated the code a bit, see
https://lore.kernel.org/lkml/1541165517-3557-3-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp/

Linus also wanted to have an API to flush part of the message
before some action and finalize it later. It would be usable
for things like:

	pr_info("Doing something dangerous... ");
	printk_flush();
	do_dangerous_thing();
	pr_cont("ok\n");

Where pr_cont() would allow to flush part of the message to the
consoles and add the end of the line later when it did not crash.

It would need some support in the lockless ring buffer API anyway.
But it is only nice to have from my POV.


> The alloc function would need to work for any context, but that would
> not be an issue. If the cont message started to get too large, pr_cont()
> could do its own flushing in between, while still holding on to the
> context information. If for some reason the alloc function could not
> allocate a buffer, all the pr_cont() calls could fallback to logging the
> individual cont parts.

Also this was discussed several times. The most acceptable solution
was to use "small" buffer on the stack (128 bytes or so).


> I believe this would solve all cont-related problems while also allowing
> the new ringbuffer to remain as it already is in linux-next.

You are right. The buffering is really good step. It would make
the API sane and reliable. It has been proposed and discussed many
times. The main obstacle was that there was no volunteer to get this
done. If you are able to do so, it would be amazing.

I am just not sure what is more complicated. Getting lockless
operation correctly is always tricky. But going though 2000
callers individually is also a lot of work.

Best Regards,
Petr
