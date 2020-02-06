Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A320DC33CAC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 16:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69F6D217BA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 16:16:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EIzYnnnQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbgBFQQP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 11:16:15 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:37421 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727600AbgBFQQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 11:16:14 -0500
Received: by mail-vs1-f65.google.com with SMTP id x18so4129862vsq.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 08:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=khdAdINHrbF0yvYt+hGIc2ksicOYuTBGDLSCy6ujc8Q=;
        b=EIzYnnnQa8E7suKKVeTQY2aMwT8WhXZwnuzb0SDixpYBjgkX1W7WuCrwO+41Hpmqpp
         OCd8RlKKrN4JpSsgPxwBO7Hy81KVa/X678GlNgbQuzTTnNtQL+2yD02IDtKvFt0lR1aJ
         Y5ORYF+7c15kuUTy+ooKE1uipKe0LMrLgaDds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=khdAdINHrbF0yvYt+hGIc2ksicOYuTBGDLSCy6ujc8Q=;
        b=E49Nz5Rt3o9P1qEo3yZayzaKHdx0ljvwTUUDJ79DjNRZpzkceUk2yDusb3gif8ltPF
         laIovYXpISroEvgsXOv/xp7tG/oySxlGfD6cbE8cjHrmXMpk66B+6gYiK6t3rM7JqI9E
         Uxk58GG5cVi10O4J1SVHYnTTGo4o8QbU35frkmDwKrC3S1q0xG3qOiriJb7HPja9uCGN
         2lY+rdfH1t4ymQeMdD/5oEowD7KwmukxW4r18j1BiDuXMbQJ5C91uOufOLN3CSsEAbr0
         XXa6+PPKdczBvQkdmm3a0TZg5YNU8SJes1DPgr5JhmyDhCf5WHehEJhFXOvJsIluzFfS
         5H8Q==
X-Gm-Message-State: APjAAAXb8m7IHvKXAmYjZEZCxXWXdIsyaEbbd9tJzf5S4Il8QsNha3nm
        LM0KqYqAl94oc/HLywZArojoainZjHQ=
X-Google-Smtp-Source: APXvYqwydOcPuW3nLoDG1jX0FeMqyIrp5N2BC5qUtTPBJ370aWzTZv98DlHrJUFu7CLJZghRit8w0A==
X-Received: by 2002:a67:8c8a:: with SMTP id o132mr2207100vsd.111.1581005772093;
        Thu, 06 Feb 2020 08:16:12 -0800 (PST)
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com. [209.85.221.178])
        by smtp.gmail.com with ESMTPSA id 41sm1134936uaf.8.2020.02.06.08.16.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2020 08:16:11 -0800 (PST)
Received: by mail-vk1-f178.google.com with SMTP id u6so1754980vkn.13
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 08:16:10 -0800 (PST)
X-Received: by 2002:ac5:c807:: with SMTP id y7mr2201558vkl.92.1581005770288;
 Thu, 06 Feb 2020 08:16:10 -0800 (PST)
MIME-Version: 1.0
References: <20200204141219.1.Ief3f3a7edbbd76165901b14813e90381c290786d@changeid>
 <20200205173042.chqij5i53mncfzar@holly.lan> <CAD=FV=V6ovmi-zCUYyFdiyf0pG4g=i5N4hUC8JjvrWDRUzPnqQ@mail.gmail.com>
 <20200206115826.oeltu56pp6w5jwvs@holly.lan>
In-Reply-To: <20200206115826.oeltu56pp6w5jwvs@holly.lan>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 6 Feb 2020 08:15:52 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XpUwWyxoEOdOGf=hDQSmQgU7VV0gOPHdvN1L4AqGok1A@mail.gmail.com>
Message-ID: <CAD=FV=XpUwWyxoEOdOGf=hDQSmQgU7VV0gOPHdvN1L4AqGok1A@mail.gmail.com>
Subject: Re: [PATCH] kdb: Fix compiling on architectures w/out DBG_MAX_REG_NUM defined
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Anatoly Pugachev <matorola@gmail.com>,
        Sparc kernel list <sparclinux@vger.kernel.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Chuhong Yuan <hslester96@gmail.com>,
        kgdb-bugreport@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Feb 6, 2020 at 3:58 AM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Wed, Feb 05, 2020 at 10:01:17AM -0800, Doug Anderson wrote:
> > Hi,
> >
> > On Wed, Feb 5, 2020 at 9:30 AM Daniel Thompson
> > <daniel.thompson@linaro.org> wrote:
> > >
> > > On Tue, Feb 04, 2020 at 02:12:25PM -0800, Douglas Anderson wrote:
> > > > In commit bbfceba15f8d ("kdb: Get rid of confusing diag msg from "rd"
> > > > if current task has no regs") I tried to clean things up by using "if"
> > > > instead of "#ifdef".  Turns out we really need "#ifdef" since not all
> > > > architectures define some of the structures that the code is referring
> > > > to.
> > > >
> > > > Let's switch to #ifdef again, but at least avoid using it inside of
> > > > the function.
> > > >
> > > > Fixes: bbfceba15f8d ("kdb: Get rid of confusing diag msg from "rd" if current task has no regs")
> > > > Reported-by: Anatoly Pugachev <matorola@gmail.com>
> > > > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > >
> > > Thanks for being so quick with this (especially when if I had been less
> > > delinquent with linux-next it might have been spotted sooner).
> > >
> > >
> > > > ---
> > > > I don't have a sparc64 compiler but I'm pretty sure this should work.
> > > > Testing appreciated.
> > >
> > > I've just add sparc64 into my pre-release testing (although I have had to
> > > turn off a bunch of additional compiler warnings in order to do so).
> > >
> > >
> > > >  kernel/debug/kdb/kdb_main.c | 17 +++++++++++------
> > > >  1 file changed, 11 insertions(+), 6 deletions(-)
> > > >
> > > > diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
> > > > index b22292b649c4..c84e61747267 100644
> > > > --- a/kernel/debug/kdb/kdb_main.c
> > > > +++ b/kernel/debug/kdb/kdb_main.c
> > > > @@ -1833,6 +1833,16 @@ static int kdb_go(int argc, const char **argv)
> > > >  /*
> > > >   * kdb_rd - This function implements the 'rd' command.
> > > >   */
> > > > +
> > > > +/* Fallback to Linux showregs() if we don't have DBG_MAX_REG_NUM */
> > > > +#if DBG_MAX_REG_NUM <= 0
> > > > +static int kdb_rd(int argc, const char **argv)
> > > > +{
> > > > +     if (!kdb_check_regs())
> > > > +             kdb_dumpregs(kdb_current_regs);
> > > > +     return 0;
> > > > +}
> > > > +#else
> > >
> > > The original kdb_rd (and kdb_rm which still exists in this file) place
> > > the #if inside the function and users > 0 so the common case was
> > > covered at the top and the fallback at the bottom.
> > >
> > > Why change style when re-introducing this code?
> >
> > My opinion is that #if / #ifdef leads to hard-to-follow code, so I
> > have always taken the policy that #if / #ifdef don't belong anywhere
> > inside a function if it can be avoided.  This seems to be the policy
> > in Linux in general, though not as much in the existing kgdb code.
> > IMO kgdb should be working to reduce #if / #ifdef inside functions.
>
> I definitely agree that reducing #if and its shortcuts is a good thing.
>
> However I would characterize the dominant pattern as using #if[def]
> to replace disabled functionality with an inline nop version. Other
> cases are, I think, less clear cut.
>
>
> > In this case, the duplicated code is 1 line: the call to
> > kdb_check_regs().  It seemed better to duplicate.  Another option that
> > would avoid the #if / #ifdef in the function would be as follows.
> > Happy to change my patch like this if you prefer:
>
> I wasn't really the duplicated code that bothered me.
>
> More that this test of DBG_MAX_REG_NUM is following a different pattern
> to all other instances in the code case (for a start all others use a
> DBG_MAX_REG_NUM > 0 test and put the fallback code at the bottom).

Ah, got it.  I'll give a shot at a new version then.


> > ...or if you just want to get something quickly so we have time to
> > debate the finer points, I wouldn't object to a simple Revert and I
> > can put it on my plate to resubmit the patch later.
>
> There's a degree of bikeshedding in the above (and as we both know this
> are larger bits of tidying up that kdb, in particular, could benefit
> from) but nevertheless I think a revert is better at this point.
>
> I hope you don't mind but I shall interpret the above paragraph as an
> Acked-by: since I'd like the record to show your diligence in jumping
> on this!

Sounds perfect.  Thanks for the revert and adding exra tests for the
future to keep me from shooting myself in the foot.

-Doug
