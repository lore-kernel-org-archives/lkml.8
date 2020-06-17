Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 232A9C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 12:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01F6F2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 12:12:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbgFQMMA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 08:12:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:41110 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725967AbgFQMMA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 08:12:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 45557AAC7;
        Wed, 17 Jun 2020 12:12:03 +0000 (UTC)
Date:   Wed, 17 Jun 2020 14:11:58 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     jim.cromie@gmail.com
Cc:     Jason Baron <jbaron@akamai.com>,
        LKML <linux-kernel@vger.kernel.org>, akpm@linuxfoundation.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v2 19/24] dyndbg: accept query terms like module:foo and
 file=bar
Message-ID: <20200617121156.GV31238@alley>
References: <20200613155738.2249399-1-jim.cromie@gmail.com>
 <20200613155738.2249399-20-jim.cromie@gmail.com>
 <20200616115727.GN31238@alley>
 <CAJfuBxwmMNzt6ffQkYX7vU1qRa12=mCbO9T4SMzF7RXV5UwkYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfuBxwmMNzt6ffQkYX7vU1qRa12=mCbO9T4SMzF7RXV5UwkYQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2020-06-16 14:08:57, jim.cromie@gmail.com wrote:
> On Tue, Jun 16, 2020 at 5:57 AM Petr Mladek <pmladek@suse.com> wrote:
> >
> > On Sat 2020-06-13 09:57:33, Jim Cromie wrote:
> > > Current code expects "keyword" "arg" as 2 space separated words.
> > > Change to also accept "keyword:arg" and "keyword=arg" forms as well,
> > > and drop !(nwords%2) requirement.
> > >
> > > Then in rest of function, use new keyword,arg variables instead of
> > > word[i],word[i+1]
> >
> > I like the idea. But please allow only one form. IMHO, parameter=value
> > is a common way to pass values to commandline parameters.
> >
> 
> I dont see a basis to prefer one over the other.
> we already now accept  " file   foo.c:func "
> that might argue for file=foo:func
> but file:foo:func is what youd expect reading left-to-right
> 
> > Note that "keyword" and "arg" is strange naming, especially "arg".
> >
> 
> I think keyword is clear in context. query_term is suitable, but no better.
> 
> arg is pretty generic, without overloaded meaning like value ( like
> lvalue ? rvalue ?)
> almost as old as 'i', but generally a string (not an int)
> Is there an alternative you favor ?

You made to do some research and I was wrong. For example, getopt()
operates with options and their arguments. So, 'keyword' and 'arg' names
look good after all.

Well, I still think that only one syntax should be supported. And it
is better to distinguish keywords and arguments, so I prefer keyword=arg.

I see "filename:func" or "filename:line" as a compound parameter. People are
familiar with this syntax, for example, from gdb.

But using '=' is very common for first level delimiter: getopt,
qemu.

Well, I do not have strong opinion on this.

Best Regards,
Petr
