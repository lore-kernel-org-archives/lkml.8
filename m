Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CE4EC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 16:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 800352075E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 16:01:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731699AbgFRQBe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 12:01:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:43464 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729481AbgFRQBd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 12:01:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6BA06AC9F;
        Thu, 18 Jun 2020 16:01:30 +0000 (UTC)
Date:   Thu, 18 Jun 2020 18:01:29 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     jim.cromie@gmail.com
Cc:     Jason Baron <jbaron@akamai.com>,
        LKML <linux-kernel@vger.kernel.org>, akpm@linuxfoundation.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Orson Zhai <orson.zhai@unisoc.com>,
        Linux Documentation List <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v3 19/21] dyndbg: extend ddebug_parse_flags to accept
 optional leading filter-flags
Message-ID: <20200618160129.GC3617@alley>
References: <20200617162536.611386-1-jim.cromie@gmail.com>
 <20200617162536.611386-22-jim.cromie@gmail.com>
 <20200618124400.GA7536@alley>
 <CAJfuBxyw7v=uQFMLHbsP_MAub7DFZOto6SnU71upXZDcK9L9QQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfuBxyw7v=uQFMLHbsP_MAub7DFZOto6SnU71upXZDcK9L9QQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2020-06-18 08:54:58, jim.cromie@gmail.com wrote:
> On Thu, Jun 18, 2020 at 6:44 AM Petr Mladek <pmladek@suse.com> wrote:
> >
> > On Wed 2020-06-17 10:25:34, Jim Cromie wrote:
> > > Change ddebug_parse_flags to accept optional filterflags before the
> > > required operator [-+=].  Read the flags into the filter_flags
> > > parameter added in the previous patch.  So this now supplies the
> > > filterflags to ddebug_exec_query.
> > >
> > > filterflags work like query terms, they constrain what callsites get
> > > matched before theyre modified.  So like a query, they can be empty.
> > >
> > > Filterflags let you read callsite's flagstate, including results of
> > > previous modifications, and require that certain flags are set, before
> > > modifying the callsite further.
> > >
> > > So you can build up sets of callsites by marking them with a
> > > particular flagstate, for example 'fmlt', then enable that set in a
> > > batch.
> > >
> > >   echo fmlt+p >control
> > >
> > > Naturally you can use almost any combo of flags you want for marking,
> > > and can mark several different sets with different patterns.  And then
> > > you can activate them in a bunch:
> > >
> > >   echo 'ft+p; mt+p; lt+p;' >control
> > >
> > > + * Parse `str' as a flags-spec, ie: [pfmlt_]*[-+=][pfmlt_]+
> >
> > This interface is simply _horrible_ and I do not see a point in this feature!!!
> >
> > I as a normal dynamic debug user am interested into:
> >
> >    + enabling/disabling messages from a given module/file/line/function
> >    + list of available modules/files/lines/functions
> >    + list of enabled modules/files/lines/functions
> >
> > I do not understand why I would ever want to do something like:
> >
> >    + enable messages that print module name and line number
> >    + disable message that does not print a module name
> 
> messages dont print them, the flags do, according to USER CHOICE.
> a developer who is deeply familiar with the code doesnt need to
> see most of it in the logs, average user might need them to comprehend things.

Any user, even average, has to deal also with non-debug messages that
do not include this extra information. Why pr_debug() message would
need it?

Message should be useful on its own. The location can be found by
grepping like for any other printk() messages.

Yes, the information might be handy. But all these configuration
choices also make the interface and code complicated. IMHO, it has
been over engineered. And this patch makes it even worse.


Anyway, you answered why the flags are there. But you did not explain
why anyone would need to use a filter based on them. Answer this,
please!!!


> > In fact, IMHO, all the 'flmt' flags were a wrong idea and nobody
> > really needed them. This information in not needed by other
> > printk() messages. Why pr_debug() would need them?
> > They just made the code and interface complicated.
> >
> 
> it looks like they landed fully formed in lib/dynamic_debug.c
> probably because that was a unification of several different print
> debug systems.

No, they were added by the commit 8ba6ebf583f12da32036fc0 ("Dynamic debug:
Add more flags").

There is no explanation why they were added. It probably just looked
like a good idea to the author and nobody complained at that time.

It has been included wihtout any comment, see
https://lore.kernel.org/lkml/201101231717.24175.bvanassche@acm.org/
https://lore.kernel.org/lkml/1300309888-5028-5-git-send-email-gregkh@suse.de/


> you are free to set them globally:
> echo +fmlt >control
> 
> or just the ones youre using
> echo up+fmlt >control

The question is not if I could do so. The question is how many users
do it or need to do so.

Features in this patchset affect the interface with userspace. It
means that they would need to be maintained "forewer". For this,
you need to prove that it is widely useful. Ideally, it should
be outcome of some discussion where people missed this.

I do not see any reasonable usecase for anything like:

   echo 'ft+p; mt+p; lt+p;' >control

Why people would do this, please?

Best Regards,
Petr
