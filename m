Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECF0CC18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 16:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCD8921927
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 16:50:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbgCJQuY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 12:50:24 -0400
Received: from smtprelay0075.hostedemail.com ([216.40.44.75]:58653 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726307AbgCJQuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 12:50:24 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 53E711802DEEB;
        Tue, 10 Mar 2020 16:50:23 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: list44_3299c48c4159
X-Filterd-Recvd-Size: 2580
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Tue, 10 Mar 2020 16:50:21 +0000 (UTC)
Message-ID: <0fdd3a89033ce3d6e7ab6b12eddefc343ac43729.camel@perches.com>
Subject: Re: [PATCH] kbuild: Disable -Wpointer-to-enum-cast
From:   Joe Perches <joe@perches.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        David Laight <David.Laight@aculab.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        stable <stable@vger.kernel.org>
Date:   Tue, 10 Mar 2020 09:48:40 -0700
In-Reply-To: <CAK7LNARMsO0AeO8-kH4czMuW0Y_=dN+ZhtXNdRE7CWGvU2PNvA@mail.gmail.com>
References: <20200308073400.23398-1-natechancellor@gmail.com>
         <CAK7LNARcTHpd8fzrAhFVB_AR7NoBgenX64de0eS2uN8g0by9PQ@mail.gmail.com>
         <20200310012545.GA16822@ubuntu-m2-xlarge-x86>
         <c2a687d065c1463d8eea9947687b3b05@AcuMS.aculab.com>
         <CAK7LNARMsO0AeO8-kH4czMuW0Y_=dN+ZhtXNdRE7CWGvU2PNvA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-03-11 at 00:30 +0900, Masahiro Yamada wrote:
> On Tue, Mar 10, 2020 at 8:31 PM David Laight <David.Laight@aculab.com> wrote:
> > From: Nathan Chancellor
> > > Sent: 10 March 2020 01:26
> > ...
> > > Sure, I can send v2 to do that but I think that sending 97 patches just
> > > casting the small values (usually less than twenty) to unsigned long
> > > then to the enum is rather frivolous. I audited at least ten to fifteen
> > > of these call sites when creating the clang patch and they are all
> > > basically false positives.
> > 
> > Such casts just make the code hard to read.
> > If misused casts can hide horrid bugs.
> > IMHO sprinkling the code with casts just to remove
> > compiler warnings will bite back one day.
> > 
> 
> I agree that too much casts make the code hard to read,
> but irrespective of this patch, there is no difference
> in the fact that we need a cast to convert
> (const void *) to a non-pointer value.
> 
> The difference is whether we use
> (uintptr_t) or (enum foo).

or hide it altogether in a macro like cast_to

#define cast_to(type, val)	\
	etc...

where cast_to could do the appropriate
intermediate cast if type is an enum
and sizeof(tupeof val) is larger than int


