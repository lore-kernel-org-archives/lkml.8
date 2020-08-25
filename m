Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95EF9C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 13:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78BA82074A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 13:10:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbgHYNKo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 09:10:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:43026 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726609AbgHYNKn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 09:10:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B3FD4B5DC;
        Tue, 25 Aug 2020 13:11:12 +0000 (UTC)
Date:   Tue, 25 Aug 2020 15:10:41 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     David Laight <David.Laight@aculab.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 1/5] printk: implement pr_cont_t
Message-ID: <20200825131041.GV4353@alley>
References: <20200819232632.13418-1-john.ogness@linutronix.de>
 <20200819232632.13418-2-john.ogness@linutronix.de>
 <20200820101625.GE4353@alley>
 <fb47baa77ff940e99224feac85a2f2d7@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb47baa77ff940e99224feac85a2f2d7@AcuMS.aculab.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2020-08-20 12:33:23, David Laight wrote:
> From: Petr Mladek
> > Sent: 20 August 2020 11:16
> ...
> > Now that I think about it. This is the biggest problem with any temporary buffer
> > for pr_cont() lines. I am more and more convinced that we should just
> > _keep the current behavior_. It is not ideal. But sometimes mixed
> > messages are always better than lost ones.
> 
> Maybe a marker to say 'more expected' might be useful.
> OTOH lack of a trailing '\n' probably signifies that a
> pr_cont() is likely to be next.

The problem is the "probably". Lack of trailing '\n' might also mean
that the author did not care. Note that newline is not strictly
required at the moment. The next message is concatenated only when
pr_cont() is used from the same process.

I would personally hate printk when I debugged some hard-to-reproduce
bug, finally succeeded, and some message was missing just because
of a missing newline.


> Unexpected pr_cont() could be output with a leading "... "
> to help indicate the message is a continuation.

Interesting idea. It might help to catch broken code. Well, I am still
not sure that people would appreciate this printk() behavior.


> > That said, some printk() API using local buffer would be still
> > valuable for pieces of code where people really want to avoid
> > mixed lines. But it should be optional and people should be
> > aware of the risks.
> 
> That could be very useful if it supported multi-line output.
> Thing like the stack backtrace code could use it avoid
> the mess that happens when multiple processes generate
> tracebacks at the same time.

Honestly, I am going to push against it. I agree that would be useful
but it is an evil path.

There has to be some limits. Backtraces are often printed in situation
where the buffer could not get allocated dynamically. There always
be a situation when a buffer will not be big enough.

If we add this feature, people will want to use it also for other
purposes that might need even bigger buffers and the size might
be even harder to predict.

And the temporary buffer is only part of the problem. The message also
has to be stored into the lockless ringbuffer, show on consoles, passed
to userspace, stored during panic by pstore.

The printk() design already is very complicated. And multiple lines
support would stretch it in yet another dimension.

And it is going to be less important. We are going to always store the
information about the printk caller. So that it will be much easier
to grep related lines.

Best Regards,
Petr
