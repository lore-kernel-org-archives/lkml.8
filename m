Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFC28C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 23:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C605420774
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 23:52:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgHNXw3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 19:52:29 -0400
Received: from smtprelay0038.hostedemail.com ([216.40.44.38]:59826 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726213AbgHNXw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 19:52:29 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id DB3FC18027C9B;
        Fri, 14 Aug 2020 23:52:27 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: bike41_3c12a7d27000
X-Filterd-Recvd-Size: 3702
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Fri, 14 Aug 2020 23:52:25 +0000 (UTC)
Message-ID: <b87a02b75c715d9a9f381fe3869612bb826a7351.camel@perches.com>
Subject: Re: POC: Alternative solution: Re: [PATCH 0/4] printk: reimplement
 LOG_CONT handling
From:   Joe Perches <joe@perches.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kexec@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Fri, 14 Aug 2020 16:52:24 -0700
In-Reply-To: <CAHk-=wjoRWDAGkeevWtxR73vMimYfzJt13yFqTqv=7BGb0cuAQ@mail.gmail.com>
References: <20200717234818.8622-1-john.ogness@linutronix.de>
         <CAHk-=wivdy6-i=iqJ1ZG9YrRzaS0_LHHEPwb9KJg-S8i-Wm30w@mail.gmail.com>
         <87blkcanps.fsf@jogness.linutronix.de> <20200811160551.GC12903@alley>
         <20200812163908.GH12903@alley> <87v9hn2y1p.fsf@jogness.linutronix.de>
         <20200813051853.GA510@jagdpanzerIV.localdomain>
         <875z9nvvl2.fsf@jogness.linutronix.de> <20200813084136.GK12903@alley>
         <20200813115435.GB483@jagdpanzerIV.localdomain>
         <CAHk-=wjoRWDAGkeevWtxR73vMimYfzJt13yFqTqv=7BGb0cuAQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-08-14 at 15:46 -0700, Linus Torvalds wrote:
> On Thu, Aug 13, 2020 at 4:54 AM Sergey Senozhatsky
> <sergey.senozhatsky@gmail.com> wrote:
> > I think what Linus said a long time ago was that the initial purpose of
> > pr_cont was
> > 
> >         pr_info("Initialize feature foo...");
> >         if (init_feature_foo() == 0)
> >                 pr_cont("ok\n");
> >         else
> >                 pr_cont("not ok\n");
> > 
> >         And if init_feature_foo() crashes the kernel then the first printk()
> >         form panic() will flush the cont buffer.
> 
> Right.
> 
> This is why I think any discussion that says "people should buffer
> their lines themselves and we should get rid if pr_cont()" is
> fundamentally broken.
> 
> Don't go down that hole. I won't take it. It's wrong.

I don't think it's wrong per se.

It's reasonable to avoid pr_cont when appropriate.

Trivial buffering, or adding and using YA vsprintf 
extension can avoid unnecessary message interleaving.

For instance, I just sent this patch to allow removal
of print_vma_addr and its use of pr_cont.

https://lore.kernel.org/lkml/09f11651f0e913e159b955ac447cd8cadf36cb0d.camel@perches.com/

This is similar to the dump_flags_names removal back
in commit edf14cdbf9a0 ("mm, printk: introduce new format
string for flags")

> The fact is, pr_cont() goes back to the original kernel. No, it wasn't
> pr_cont() back then, and no, there were no actual explicit markers for
> "this is a continuation" at all, it was all just "the last printk
> didn't have a newline, so we continue where we left off".
> 
> We've added pr_cont (and KERN_CONT) since then, and I realize that a
> lot of people hate the complexity it introduces, but it's a
> fundamental complexity that you have to live with.
> 
> If you can't live with pr_cont(), you shouldn't be working on
> printk(), and find some other area of the kernel that you _can_ live
> with.
> 
> It really is that simple.
> 

