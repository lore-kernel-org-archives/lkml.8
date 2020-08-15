Return-Path: <SRS0=qJsj=BZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23381C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 21:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09D82206B6
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 21:55:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729372AbgHOVzz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 17:55:55 -0400
Received: from smtprelay0136.hostedemail.com ([216.40.44.136]:38898 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729064AbgHOVzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 17:55:50 -0400
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave04.hostedemail.com (Postfix) with ESMTP id EBF8C1801BE39
        for <linux-kernel@vger.kernel.org>; Sat, 15 Aug 2020 03:08:05 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id BAB625853;
        Sat, 15 Aug 2020 03:08:05 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: linen97_5911ea827002
X-Filterd-Recvd-Size: 2879
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Sat, 15 Aug 2020 03:08:03 +0000 (UTC)
Message-ID: <ccc21619fdee79985f619adeb49bd5713dc97d80.camel@perches.com>
Subject: Re: POC: Alternative solution: Re: [PATCH 0/4] printk: reimplement
 LOG_CONT handling
From:   Joe Perches <joe@perches.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kexec@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Fri, 14 Aug 2020 20:08:02 -0700
In-Reply-To: <CAHk-=wjNZ40akqgnb1y=dSYv1fX2Wk1SGF5hAzuV2azi5oQ+Tg@mail.gmail.com>
References: <20200717234818.8622-1-john.ogness@linutronix.de>
         <CAHk-=wivdy6-i=iqJ1ZG9YrRzaS0_LHHEPwb9KJg-S8i-Wm30w@mail.gmail.com>
         <87blkcanps.fsf@jogness.linutronix.de> <20200811160551.GC12903@alley>
         <20200812163908.GH12903@alley> <87v9hn2y1p.fsf@jogness.linutronix.de>
         <20200813051853.GA510@jagdpanzerIV.localdomain>
         <875z9nvvl2.fsf@jogness.linutronix.de> <20200813084136.GK12903@alley>
         <20200813115435.GB483@jagdpanzerIV.localdomain>
         <CAHk-=wjoRWDAGkeevWtxR73vMimYfzJt13yFqTqv=7BGb0cuAQ@mail.gmail.com>
         <b87a02b75c715d9a9f381fe3869612bb826a7351.camel@perches.com>
         <CAHk-=wjNZ40akqgnb1y=dSYv1fX2Wk1SGF5hAzuV2azi5oQ+Tg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-08-14 at 19:33 -0700, Linus Torvalds wrote:
> On Fri, Aug 14, 2020 at 4:52 PM Joe Perches <joe@perches.com> wrote:
> > On Fri, 2020-08-14 at 15:46 -0700, Linus Torvalds wrote:
> > > This is why I think any discussion that says "people should buffer
> > > their lines themselves and we should get rid if pr_cont()" is
> > > fundamentally broken.
> > > 
> > > Don't go down that hole. I won't take it. It's wrong.
> > 
> > I don't think it's wrong per se.
> 
> It's *absolutely* and 100% wrong.
> 
> Yes, any random *user* of pr_cont() can decide to buffer on it's own.

Which I believe is the point of the discussion,
not the complete removal of KERN_CONT.

> But when the discussion is about printk() - the implementation, not
> the users - then it's complete and utter BS to talk about trying to
> get rid of pr_cont().
> 
> See the difference?

Sure, but I fail to see where anyone said get rid of pr_cont
in this thread.  It seems all that was discussed was just
various schemes to improve coalescing output.


