Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1141C35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 18:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A76B02467B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 18:01:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oVpH+7hb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbgBESBd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 13:01:33 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:38432 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbgBESBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 13:01:32 -0500
Received: by mail-vs1-f67.google.com with SMTP id r18so1939033vso.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 10:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tcERuPTreB1RdPPHaPDmwJiWCBqhIbQ/kkvuwoX6k74=;
        b=oVpH+7hbPNdJnNsLjdBlqZ71TWR1mX/Dt0ANmSlQg+wjEIEYcnIMa/ZCjtuvTu8Y+f
         lCVBpkS9eO35HQytqbp7j4bcqcVd9+uKbZwVawuzrzSvB4eVvCdhMu5aVmOy8WGjnK11
         myPmLTbHd+oIm9FFyuy3G1w83Z8aW2eC71Gdw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tcERuPTreB1RdPPHaPDmwJiWCBqhIbQ/kkvuwoX6k74=;
        b=gWeOzPpfqLQFZ0gtuwTP72Jra8nUY9fmPxn+U35UsiNfP29WEr8gXqgOCRwdxGl1K8
         f2Pbrb+joxABGAz2BcvPcqcg+Zq8epE2Vd55TcI84e8hQ0S4kkun+pJYzYXYFXIGLIJJ
         73pFoFlPi6QBzHqCuj2Pk/XO4+Z+Kq+40HGG/N7FUSp3RWxu8ao+D7iZPTto5jCYvc6D
         HJt+1t/5OjyVLaEiuC/UJ8VFw/mdh4VFlgsZKfbCxTXmoSYjQk8++hKfIxhRD8U2UeTU
         s78g1ZPgGQbYJdz89EpYAojtmp0m4rWp+TxDc77JlfYiGtzK/1xBGbh5hfNIkAQ2qQvj
         900Q==
X-Gm-Message-State: APjAAAWc/xyZqaBWFhpPAJuPtPEI/7+W6yxWPvhmRmCZOaEM53TmsBo0
        ufGayqLQzpZyyMGpk05WTExEYqd+urk=
X-Google-Smtp-Source: APXvYqy+6XmPtGHVcv6U0HIHhdwJj16HzcAy9aKzGna+8GM4igycPoRxk/3A5UihMw9VjOengC4aPQ==
X-Received: by 2002:a67:dc90:: with SMTP id g16mr22426058vsk.110.1580925690963;
        Wed, 05 Feb 2020 10:01:30 -0800 (PST)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com. [209.85.222.45])
        by smtp.gmail.com with ESMTPSA id s66sm176476vkg.11.2020.02.05.10.01.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Feb 2020 10:01:29 -0800 (PST)
Received: by mail-ua1-f45.google.com with SMTP id 59so1176926uap.12
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 10:01:29 -0800 (PST)
X-Received: by 2002:ab0:724c:: with SMTP id d12mr21945531uap.0.1580925689110;
 Wed, 05 Feb 2020 10:01:29 -0800 (PST)
MIME-Version: 1.0
References: <20200204141219.1.Ief3f3a7edbbd76165901b14813e90381c290786d@changeid>
 <20200205173042.chqij5i53mncfzar@holly.lan>
In-Reply-To: <20200205173042.chqij5i53mncfzar@holly.lan>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 5 Feb 2020 10:01:17 -0800
X-Gmail-Original-Message-ID: <CAD=FV=V6ovmi-zCUYyFdiyf0pG4g=i5N4hUC8JjvrWDRUzPnqQ@mail.gmail.com>
Message-ID: <CAD=FV=V6ovmi-zCUYyFdiyf0pG4g=i5N4hUC8JjvrWDRUzPnqQ@mail.gmail.com>
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

On Wed, Feb 5, 2020 at 9:30 AM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Tue, Feb 04, 2020 at 02:12:25PM -0800, Douglas Anderson wrote:
> > In commit bbfceba15f8d ("kdb: Get rid of confusing diag msg from "rd"
> > if current task has no regs") I tried to clean things up by using "if"
> > instead of "#ifdef".  Turns out we really need "#ifdef" since not all
> > architectures define some of the structures that the code is referring
> > to.
> >
> > Let's switch to #ifdef again, but at least avoid using it inside of
> > the function.
> >
> > Fixes: bbfceba15f8d ("kdb: Get rid of confusing diag msg from "rd" if current task has no regs")
> > Reported-by: Anatoly Pugachev <matorola@gmail.com>
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
>
> Thanks for being so quick with this (especially when if I had been less
> delinquent with linux-next it might have been spotted sooner).
>
>
> > ---
> > I don't have a sparc64 compiler but I'm pretty sure this should work.
> > Testing appreciated.
>
> I've just add sparc64 into my pre-release testing (although I have had to
> turn off a bunch of additional compiler warnings in order to do so).
>
>
> >  kernel/debug/kdb/kdb_main.c | 17 +++++++++++------
> >  1 file changed, 11 insertions(+), 6 deletions(-)
> >
> > diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
> > index b22292b649c4..c84e61747267 100644
> > --- a/kernel/debug/kdb/kdb_main.c
> > +++ b/kernel/debug/kdb/kdb_main.c
> > @@ -1833,6 +1833,16 @@ static int kdb_go(int argc, const char **argv)
> >  /*
> >   * kdb_rd - This function implements the 'rd' command.
> >   */
> > +
> > +/* Fallback to Linux showregs() if we don't have DBG_MAX_REG_NUM */
> > +#if DBG_MAX_REG_NUM <= 0
> > +static int kdb_rd(int argc, const char **argv)
> > +{
> > +     if (!kdb_check_regs())
> > +             kdb_dumpregs(kdb_current_regs);
> > +     return 0;
> > +}
> > +#else
>
> The original kdb_rd (and kdb_rm which still exists in this file) place
> the #if inside the function and users > 0 so the common case was
> covered at the top and the fallback at the bottom.
>
> Why change style when re-introducing this code?

My opinion is that #if / #ifdef leads to hard-to-follow code, so I
have always taken the policy that #if / #ifdef don't belong anywhere
inside a function if it can be avoided.  This seems to be the policy
in Linux in general, though not as much in the existing kgdb code.
IMO kgdb should be working to reduce #if / #ifdef inside functions.

In this case, the duplicated code is 1 line: the call to
kdb_check_regs().  It seemed better to duplicate.  Another option that
would avoid the #if / #ifdef in the function would be as follows.
Happy to change my patch like this if you prefer:

#if DBG_MAX_REG_NUM <= 0
static int _kdb_rd(void)
{
  kdb_dumpregs(kdb_current_regs);
  return 0;
}
#else
static int _kdb_rd(void)
{
 ...
}
#endif

static int kdb_rd(int argc, const char **argv)
{
  if (kdb_check_regs())
    return 0;
  return _kdb_rd();
}

...or if you just want to get something quickly so we have time to
debate the finer points, I wouldn't object to a simple Revert and I
can put it on my plate to resubmit the patch later.

-Doug
