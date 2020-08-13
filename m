Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB2EC433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 07:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 605982078B
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 07:51:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbgHMHvU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 03:51:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:37162 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726100AbgHMHvT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 03:51:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C51DFAF82;
        Thu, 13 Aug 2020 07:51:39 +0000 (UTC)
Date:   Thu, 13 Aug 2020 09:51:17 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
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
Message-ID: <20200813075117.GJ12903@alley>
References: <20200717234818.8622-1-john.ogness@linutronix.de>
 <CAHk-=wivdy6-i=iqJ1ZG9YrRzaS0_LHHEPwb9KJg-S8i-Wm30w@mail.gmail.com>
 <87blkcanps.fsf@jogness.linutronix.de>
 <20200811160551.GC12903@alley>
 <20200812163908.GH12903@alley>
 <87v9hn2y1p.fsf@jogness.linutronix.de>
 <20200813051853.GA510@jagdpanzerIV.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200813051853.GA510@jagdpanzerIV.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2020-08-13 14:18:53, Sergey Senozhatsky wrote:
> On (20/08/13 02:30), John Ogness wrote:
> > 2. I haven't yet figured out how to preserve calling context when a
> > newline appears. For example:
> > 
> > pr_info("text");
> > pr_cont(" 1");
> > pr_cont(" 2\n");
> > pr_cont("3");
> > pr_cont(" 4\n");
> >
> > For "3" the calling context (info, timestamp) is lost because with "2"
> > the record is finalized. Perhaps the above is invalid usage of LOG_CONT?

If I get it correctly, the original code has the same problem.

The cont buffer is flushed when the cont piece ends with newline:

static bool cont_add(u32 caller_id, int facility, int level,
		     enum log_flags flags, const char *text, size_t len)
{
   [...]

	// The original flags come from the first line,
	// but later continuations can add a newline.
	if (flags & LOG_NEWLINE) {
		cont.flags |= LOG_NEWLINE;
		cont_flush();
	}

	return true;
}

cont_flush sets	cont.len = 0;

static void cont_flush(void)
{
	[...]
	cont.len = 0;
}


The messages is appended only when cont.len != 0 in log_output:

static size_t log_output(int facility, int level, enum log_flags lflags, const char *dict, size_t dictlen, char *text, size_t text_len)
{
	const u32 caller_id = printk_caller_id();

	/*
	 * If an earlier line was buffered, and we're a continuation
	 * write from the same context, try to add it to the buffer.
	 */
	if (cont.len) {
		if (cont.caller_id == caller_id && (lflags & LOG_CONT)) {
			if (cont_add(caller_id, facility, level, lflags, text, text_len))
				return text_len;
		}

      [...]
}


Also the original context is overridden when the cont buffer is empty:

static bool cont_add(u32 caller_id, int facility, int level,
		     enum log_flags flags, const char *text, size_t len)
{
	[...]

	if (!cont.len) {
		cont.facility = facility;
		cont.level = level;
		cont.caller_id = caller_id;
		cont.ts_nsec = local_clock();
		cont.flags = flags;
	}

	[...]
}

So I would ignore this problem for now.


> This is not an unseen pattern, I'm afraid. And the problem here can
> be more general:
> 
> 	pr_info("text");
> 	pr_cont("1");
> 	exception/IRQ/NMI
> 		pr_alert("text\n");
> 	pr_cont("2");
> 	pr_cont("\n");
> 

Good point.


> I guess the solution would be to store "last log_level" in task_struct
> and get current (new) timestamp for broken cont line?

I think about storing the context in per-CPU and per-context array.
It should be more memory efficient than task_struct and it should
solve even the above problem.


> We have this problem now. E.g. early boot messages from one of my boxes:
> 
> 6,173,41837,-;x86: Booting SMP configuration:
> 6,174,41838,-;.... node  #0, CPUs:      #1 #2 #3 #4
> 4,175,44993,-;MDS CPU bug present and SMT on, data leak possible. See https://www.kernel.org/doc/...
> 4,176,44993,c; #5 #6 #7
> 
> "CPUs: #1 #2 #3 #4 #5 #6 #7" is supposed to be one cont line with
> loglevel 6. But it gets interrupted and flushed so that "#5 #6 #7"
> appears with the different loglevel.

Nice example. It would be nice to fix this. But it should be done
separately.

Best Regards,
Petr
