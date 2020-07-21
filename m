Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF6E8C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 03:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E2322073A
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 03:53:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728416AbgGUDx5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 23:53:57 -0400
Received: from smtprelay0033.hostedemail.com ([216.40.44.33]:46894 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726483AbgGUDx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 23:53:57 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id BB25F18014A0A;
        Tue, 21 Jul 2020 03:53:55 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: clock38_5a1340526f2a
X-Filterd-Recvd-Size: 2274
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Tue, 21 Jul 2020 03:53:53 +0000 (UTC)
Message-ID: <b44b9b7c0f0d5ace01e56d2bac0251573ea7df17.camel@perches.com>
Subject: Re: [PATCH 2/4] printk: store instead of processing cont parts
From:   Joe Perches <joe@perches.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kexec@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Mon, 20 Jul 2020 20:53:52 -0700
In-Reply-To: <CAHk-=whqiemoYRE41+qMuwQ_Qw3pn7gy2-Mso=ZDrwxQCVkncg@mail.gmail.com>
References: <20200717234818.8622-1-john.ogness@linutronix.de>
         <20200717234818.8622-3-john.ogness@linutronix.de>
         <20200719143527.GA566@jagdpanzerIV.localdomain>
         <CAHk-=wg70es2rSYsHbBcWrBPsoHmbZ8vmeqTS_Kypv6zHAwQjA@mail.gmail.com>
         <20200720015057.GA463@jagdpanzerIV.localdomain>
         <CAHk-=whqiemoYRE41+qMuwQ_Qw3pn7gy2-Mso=ZDrwxQCVkncg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-07-20 at 11:30 -0700, Linus Torvalds wrote:
> On Sun, Jul 19, 2020 at 6:51 PM Sergey Senozhatsky
> <sergey.senozhatsky@gmail.com> wrote:
> > Do I get it right, what you are saying is - when we process a PR_CONT
> > message the cont buffer should already contain previous non-LOG_NEWLINE
> > and non-PR_CONT message, otherwise it's a bug?
> 
> No.
> 
> I'm saying that the code that does PR_CONT should have done *some*
> printing before, otherwise it's at the very least questionable.
> 
> IOW, you can't just randomly start printing with PR_CONT, without
> having established _some_ context for it.

I believe there are at least a few cases that
_only_ use pr_cont to emit
complete lines.

For example: SEQ_printf in kernel/sched/debug.c


