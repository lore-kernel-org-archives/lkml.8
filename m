Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF88C4BA2D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACE052469C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:14:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729151AbgB0NOb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 08:14:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:44912 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729094AbgB0NOb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:14:31 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 765DCB18F;
        Thu, 27 Feb 2020 13:14:29 +0000 (UTC)
Date:   Thu, 27 Feb 2020 14:14:28 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [PATCH v1] lib/vsprintf: update comment about
 simple_strto<foo>() functions
Message-ID: <20200227131428.5nhvslwdmocv6fkb@pathway.suse.cz>
References: <20200221085723.42469-1-andriy.shevchenko@linux.intel.com>
 <20200221145141.pchim24oht7nxfir@pengutronix.de>
 <CAHp75VfR+X6Mw8ywKNW5mTomzmuHSM8ecQUhxtM=LUkWaSe9CA@mail.gmail.com>
 <20200221163334.w7pocmbbw4ymimlc@pengutronix.de>
 <d6c3b369-9777-9986-f41f-3f3a4f85d64c@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d6c3b369-9777-9986-f41f-3f3a4f85d64c@rasmusvillemoes.dk>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 2020-02-22 01:28:25, Rasmus Villemoes wrote:
> On 21/02/2020 17.33, Uwe Kleine-König wrote:
> > On Fri, Feb 21, 2020 at 05:27:49PM +0200, Andy Shevchenko wrote:
> >> On Fri, Feb 21, 2020 at 4:54 PM Uwe Kleine-König
> >> <u.kleine-koenig@pengutronix.de> wrote:
> >>> On Fri, Feb 21, 2020 at 10:57:23AM +0200, Andy Shevchenko wrote:
> >>>> The commit 885e68e8b7b1 ("kernel.h: update comment about simple_strto<foo>()
> >>>> functions") updated a comment regard to simple_strto<foo>() functions, but
> >>>> missed similar change in the vsprintf.c module.
> >>>>
> >>>> Update comments in vsprintf.c as well for simple_strto<foo>() functions.
> >>
> >> ...
> >>
> >>>> - * This function is obsolete. Please use kstrtoull instead.
> >>>> + * This function has caveats. Please use kstrtoull instead.
> >>
> >>> I wonder if we instead want to create a set of functions that is
> >>> versatile enough to cover kstrtoull and simple_strtoull. i.e. fix the
> >>> rounding problems (that are the caveats, right?) and as calling
> >>> convention use an errorvalued int return + an output-parameter of the
> >>> corresponding type.
> >>
> >> It wouldn't be possible to apply same rules to both. They both are
> >> part of existing ABI.
> > 
> > The idea is to creat a sane set of functions, then convert all users to
> > the sane one and only then strip the strange functions away. (Userspace)
> > ABI isn't affected, is it?
> 
> There are lots of in-tree users of all these interfaces, converting them
> all is never going to happen. And yes, there are also kstrtox_user
> variants which are definitely part of ABI (more or less the whole reason
> kstrox accepts a single trailing newline but is otherwise rather strict
> is so it can parse stuff that is echo'd to a sysfs/procfs/... file).

Thanks a lot for the detailed answer. It seems that there is no easy
solution to the problem.

Is still anyone against the original patch updating the comments in
vsprintf.c. Otherwise, I would queue it for 5.7.

Best Regards,
Petr
