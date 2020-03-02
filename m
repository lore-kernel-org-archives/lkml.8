Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3FC3C3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 02:17:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA90724697
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 02:17:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgCBCRh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Mar 2020 21:17:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:57098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726690AbgCBCRh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 21:17:37 -0500
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31A2824697;
        Mon,  2 Mar 2020 02:17:36 +0000 (UTC)
Date:   Sun, 1 Mar 2020 21:17:33 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Cezary Rojewski <cezary.rojewski@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Question about enabling trave_events on module load
Message-ID: <20200301211733.26949f4a@oasis.local.home>
In-Reply-To: <8107a684-3ade-2457-28e4-c7e29ab1b1f5@intel.com>
References: <8107a684-3ade-2457-28e4-c7e29ab1b1f5@intel.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Feb 2020 20:16:54 +0100
Cezary Rojewski <cezary.rojewski@intel.com> wrote:

> Hello Steven,
> 
> I bet that is not the first time said question is asked - that's for 
> sure - but I failed to find a method for solving the issue, that is: not 
> missing a single trace from the moment given module is loaded. Maybe I'm 
> missing something or documentation wasn't clear enough and that's why 
> I'm here.
> 
> If I am, please point to towards the right direction. Then you can slap 
> me for not reading the documentation carefully.
> 
> "trace_event=" cmdline option seems to target built-in tracepoints 
> _only_ so ain't much of a help to me. After digging the past for some 
> time, I've found a very promising thread:
> 	tracing: Enable tracepoints via module parameters
> 	https://lore.kernel.org/patchwork/patch/240185/

I find this email extremely amusing. Just the day before (Thursday), I
was trying to clean out my INBOX (it had emails back from 2008!) and I
came across this very thread, and said to myself. "Hmm, I wonder if I
should push this again?". What a coincidence that the next day, someone
would email me about that thread after 9 years!

> 
> Sadly, I wasn't able to find _that_ solution (or anything similar for 
> that matter) implemented into the kernel.

That's because it was dropped and forgotten about :-(  I left it in my
INBOX to remind myself to bring it back, but that didn't work out as
well as I expected, as my INBOX turned into more of a graveyard than a
TODO list.

> 
> So far, the only option I came with was separating traces into a 
> built-in piece that declares all events upfront so "trace_event=" option 
> has something to hook into. Said piece is of course made of a standard 
> trace header file filled with macro usage and a .c file with handful of 
> EXPORT_TRACEPOINT_SYMBOL(s).
> 
> While that solution could suffice, localization is the problem here - if 
> a tree my module is built in is configured via -m, the built-in piece 

I'm unfamiliar with "-m", what does that do?

> won't expose symbols at all and 'make' will leave me with bunch of 
> "ERROR: <symbol> undefined" for every module my traces were used in. To 
> fix the problem, I've relocated my trace .c file to /kernel/trace/. 
> Finally it compiles and works as intended..

Well, obviously (as you state below), that's not an answer.

> 
> Not really satisfying, though. While there are some examples of 
> subsystems keeping their trace .c in /kernel/trace (e.g.: 
> power-traces.c), I don't believe that place is open for _every single 
> driver_ to dump their trace sources into.
> 
> If indeed traces cannot be enabled on module load, then this is a gap.
> While not everyone looked satisfied in the 9year old thread, I believe 
> having the gap closed is important - and userspace can always be 
> improved upon as time passes.
> 
> 
> Thank you in advance for your input and time.

I think your email confirmed to me that I need to push this thread
again.

Thanks for reaching out!

-- Steve
