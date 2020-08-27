Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CDD3C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 16:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5479520791
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 16:58:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgH0Q6r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 12:58:47 -0400
Received: from smtprelay0149.hostedemail.com ([216.40.44.149]:37430 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726009AbgH0Q6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 12:58:44 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 68626100E7B46;
        Thu, 27 Aug 2020 16:58:42 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: air51_610ed3a2706e
X-Filterd-Recvd-Size: 5803
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Thu, 27 Aug 2020 16:58:40 +0000 (UTC)
Message-ID: <5d1dfb9b031130d4d20763ec621233a19d6a88a2.camel@perches.com>
Subject: Re: [PATCH] usb: atm: don't use snprintf() for sysfs attrs
From:   Joe Perches <joe@perches.com>
To:     Alex Dewar <alex.dewar90@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        cocci <cocci@systeme.lip6.fr>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        accessrunner-general@lists.sourceforge.net,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 27 Aug 2020 09:58:39 -0700
In-Reply-To: <20200827144846.yauuttjaqtxaldxg@lenovo-laptop>
References: <20200824222322.22962-1-alex.dewar90@gmail.com>
         <48f2dc90-7852-eaf1-55d7-2c85cf954688@rasmusvillemoes.dk>
         <20200827071537.GA168593@kroah.com>
         <20200827131819.7rcl2f5js3hkoqj2@lenovo-laptop>
         <def24e9e-018c-9712-0d07-d4cbc84f07d9@rasmusvillemoes.dk>
         <20200827144846.yauuttjaqtxaldxg@lenovo-laptop>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-08-27 at 15:48 +0100, Alex Dewar wrote:
> On Thu, Aug 27, 2020 at 03:41:06PM +0200, Rasmus Villemoes wrote:
> > On 27/08/2020 15.18, Alex Dewar wrote:
> > > On Thu, Aug 27, 2020 at 09:15:37AM +0200, Greg Kroah-Hartman wrote:
> > > > On Thu, Aug 27, 2020 at 08:42:06AM +0200, Rasmus Villemoes wrote:
> > > > > On 25/08/2020 00.23, Alex Dewar wrote:
> > > > > > kernel/cpu.c: don't use snprintf() for sysfs attrs
> > > > > > 
> > > > > > As per the documentation (Documentation/filesystems/sysfs.rst),
> > > > > > snprintf() should not be used for formatting values returned by sysfs.
> > > > > > 
> > > > > 
> > > > > Can we have a sysfs_sprintf() (could just be a macro that does sprintf)
> > > > > to make it clear to the next reader that we know we're in a sysfs show
> > > > > method? It would make auditing uses of sprintf() much easier.
> > > > 
> > > > Code churn to keep code checkers quiet for pointless reasons?  What
> > > > could go wrong with that...
> > 
> > I did not (mean to) suggest replacing existing sprintf() calls in sysfs
> > show methods. But when changes _are_ being made, such as when replacing
> > snprintf() calls for whatever reasons, can we please not make it harder
> > for people doing manual audits (those are "code checkers" as well, I
> > suppose, but they do tend to only make noise when finding something).
> > 
> > > > It should be pretty obvious to any reader that you are in a sysfs show
> > > > method, as almost all of them are trivially tiny and obvious.
> > 
> > git grep doesn't immediately show that, not even with a suitable -C
> > argument, as you can't really know the potential callers unless you open
> > the file and see that the function is only assigned as a .show method.
> > And even that can be a pain because it's all hidden behind five levels
> > of magic macros that build identifiers with ##.
> > 
> > > Perhaps I should have mentioned this in the commit message, but the problem
> > > is that snprintf() doesn't return the number of bytes written to the
> > > destination buffer,
> > 
> > I'm perfectly well aware of that, TYVM (you may want to 'git log
> > --author Villemoes lib/vsprintf.c').
> > 
> >  but the number of bytes that *would have been written if
> > > they fitted*, which may be more than the bounds specified [1]. So "return
> > > snprintf(...)" for sysfs attributes is an antipattern. If you need bounded
> > > string ops, scnprintf() is the way to go. Using snprintf() can give a
> > > false sense of security, because it isn't necessarily safe.
> > 
> > Huh? This all seems utterly irrelevant WRT a change that replaces
> > PAGE_SIZE by INT_MAX (because that's what sprintf() is going to pretend
> > you passed). You get the same return value.
> > 
> > But I'm not at all concerned about whether one passes the proper buffer
> > size or not in sysfs show methods; with my embedded hat on, I'm all for
> > saving a few bytes of .text here and there. The problem, as far as I'm
> > concerned, is merely that adding sprintf() callers makes it harder to
> > find the problematic sprintf() instances.
> > 
> 
> Apologies, I think I might have expressed myself poorly, being a kernel noob
> ;-). I know that this is a stylistic change rather than a functional
> one -- I meant that I was hoping that it would be helpful to get rid of bad
> uses of snprintf().
> 
> I really like your idea of helper methods though :-). If in show()
> methods we could have something like:
> 	return sysfs_itoa(buf, i);
> in place of:
> 	return sprintf(buf, "%d\n", i);
> 
> ... then we wouldn't be introducing any new calls to sprintf() as you
> say, but we'd still be removing a call to snprintf() (which also may be
> problematic). Plus we'd have type checking on the argument.
> 
> For returning strings, we could have a bounded and unbounded variant of
> the function. As it seems like only single values should be returned via
> sysfs, if we did things this way then it would only be these
> string-returning functions which could cause buffer overflow problems
> and kernel devs could focus their attention accordingly...
> 
> What do people think? I'm happy to have a crack, provided this is
> actually a sensible thing to do! I'm looking for a newbie-level project
> to get started with.

Not a bad idea.

Coccinelle should be able to transform the various .show
methods to something sysfs_ prefixed in a fairly automated
way.




