Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D316C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 07:53:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73B2A20773
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 07:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593330836;
	bh=+0oHKHcUdFFoiAahMo+M4XWqCenZKlkd5vQhp8CMqwU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=CQmprqxgxR9qpginrpUX4+vUg9+C6KVbau51gpg6nVz4vXT6lC9THdY2FdUK7Rwbi
	 Rz4jkiitENqpNI3QRLOFOaC5WzeC2P9xFi+S8XZypeVES2zdbY+nbBzUfp81rXL6h4
	 49MvK8qtXjW93vdGdFSdVZGn6hkaJV8SW7Q0gGyk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbgF1Hxy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 03:53:54 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:26245 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbgF1Hxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 03:53:54 -0400
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 05S7raNp000778;
        Sun, 28 Jun 2020 16:53:37 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 05S7raNp000778
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1593330817;
        bh=slO6LDT7JSvd0tqSAbq3FSmhFBjuPQq4fwTfTKHHWas=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XE+86vc9qWZnPy+N6rT4hn5jX+Rl5+ftJ5vRCWLoj03SmM4BjMGfGiLwRIraAuehC
         AmGEqn5p3xMc0oDpxTWCH7QAhkMQ5wYe+gWNr+8A/ZjhStdRTatOy+lmgv7lBBsElM
         N+HR1lPNzvljtkfWAQdLW5RONw8X6ZLib7hK6Xo6Kmn4Pnlps7rINSAL5u4KzhkJjh
         cVvZfOo1VxZioNtGWxmFytyv4VHAjRabtDlo+9Rd24oy9iwGzVZLpjAprp7O8QHiC1
         +zU9PDLTEGpvBJ8w78s6kPyqdZmND75h5UyVurNY5UEKIEPuv1Wceb7gfAXJNFIRcn
         Zrr8p173AfnxQ==
X-Nifty-SrcIP: [209.85.217.51]
Received: by mail-vs1-f51.google.com with SMTP id s20so272266vsq.5;
        Sun, 28 Jun 2020 00:53:37 -0700 (PDT)
X-Gm-Message-State: AOAM53239D6Jlmpn+kT0qaepQA3b2v7RsJVuZ86j9FZ0ogQE5JMZPtct
        0g2KDnPXq2gsjYCT/9kFAQ8Tko07ZZ+K3j0h7Mw=
X-Google-Smtp-Source: ABdhPJyWcjLnLmborMoOD/A569fwnY+U6Ybig5wZ0puzbFbIbFWE7oPW4lxLwdHPoXry4KyEK4bbph1oPyfEYKiBSqQ=
X-Received: by 2002:a67:694d:: with SMTP id e74mr8023465vsc.155.1593330815873;
 Sun, 28 Jun 2020 00:53:35 -0700 (PDT)
MIME-Version: 1.0
References: <11c1e65b393b4c3ca6118515c77bbf19524dab11.1593074472.git.hns@goldelico.com>
 <CAK7LNATCLscXNDZ1RUmbnM5BeV-tvKjz9kQB8eo0SNp10WbjFQ@mail.gmail.com> <2D851B90-5F85-4136-AF70-E764FDF4D7DD@goldelico.com>
In-Reply-To: <2D851B90-5F85-4136-AF70-E764FDF4D7DD@goldelico.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 28 Jun 2020 16:52:59 +0900
X-Gmail-Original-Message-ID: <CAK7LNARfgaVgmqzsa+n2rvPx5K1dsmcqMLSeLe_tMP0O017=Yw@mail.gmail.com>
Message-ID: <CAK7LNARfgaVgmqzsa+n2rvPx5K1dsmcqMLSeLe_tMP0O017=Yw@mail.gmail.com>
Subject: Re: [PATCH] modpost: remove use of non-standard strsep() in HOSTCC code
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 28, 2020 at 3:17 PM H. Nikolaus Schaller <hns@goldelico.com> wrote:
>
> Hi,
>
> > Am 28.06.2020 um 07:51 schrieb Masahiro Yamada <masahiroy@kernel.org>:
> >
> > On Thu, Jun 25, 2020 at 5:47 PM H. Nikolaus Schaller <hns@goldelico.com> wrote:
> >>
> >> strsep() is neither standard C nor POSIX and used outside
> >> the kernel code here. Using it here requires that the
> >> build host supports it out of the box which is e.g.
> >> not true for a Darwin build host and using a cross-compiler.
> >> This leads to:
> >>
> >> scripts/mod/modpost.c:145:2: warning: implicit declaration of function 'strsep' [-Wimplicit-function-declaration]
> >>  return strsep(stringp, "\n");
> >>  ^
> >>
> >> and a segfault when running MODPOST.
> >>
> >> See also: https://stackoverflow.com/a/7219504
> >>
> >> So let's add some lines of code separating the string at the
> >> next newline character instead of using strsep(). It does not
> >> hurt kernel size or speed since this code is run on the build host.
> >>
> >> Fixes: ac5100f5432967 ("modpost: add read_text_file() and get_line() helpers")
> >> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> >> ---
> >> scripts/mod/modpost.c | 7 ++++++-
> >> 1 file changed, 6 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> >> index 6aea65c65745..8fe63989c6e1 100644
> >> --- a/scripts/mod/modpost.c
> >> +++ b/scripts/mod/modpost.c
> >> @@ -138,11 +138,16 @@ char *read_text_file(const char *filename)
> >>
> >> char *get_line(char **stringp)
> >> {
> >> +       char *p;
> >>        /* do not return the unwanted extra line at EOF */
> >>        if (*stringp && **stringp == '\0')
> >
> > This check does not make sense anymore.
> >
> > Previously, get_line(NULL) returns NULL.
> >
> > With your patch, get_line(NULL) crashes
> > due to NULL-pointer dereference.
>
> Well, that is original code.


Sorry for confusion.

I meant this:

  char *s = NULL;
  get_line(&s);


In the current code, get_line(&s) returns NULL.
As 'man strsep' says this:
  "If *stringp is NULL, the strsep() function returns NULL
   and does nothing else."

With your patch, **stringp will cause
NULL-pointer dereference.






>
> I have only replaced the strsep() function.
> But yes, it looks to be better in addition to
> my patch.
>
> >
> >
> >
> >>                return NULL;
> >>
> >> -       return strsep(stringp, "\n");
> >> +       p = *stringp;
> >> +       while (**stringp != '\n')
> >> +               (*stringp)++;
> >
> >
> > Is this a safe conversion?
> >
> > If the input file does not contain '\n' at all,
> > this while-loop continues running,
> > and results in the segmentation fault
> > due to buffer over-run.
>
> Ah, yes, you are right.
>
> We should use
>
> +       while (**stringp && **stringp != '\n')
>
> >
> >
> >
> >> +       *(*stringp)++ = '\0';
> >> +       return p;
> >> }
> >
> >
> >
> > How about this?
> >
> > char *get_line(char **stringp)
> > {
> >        char *orig = *stringp;
>
> ^^^ this still segfaults with get_line(NULL)


This is OK.

get_line(NULL) should crash because we never expect
the case  ' stringp == NULL'.

We need to care about the case ' *stringp == NULL'.
In this case, get_line() should return NULL.




> >        char *next;
> >
> >        /* do not return the unwanted extra line at EOF */
> >        if (!orig || *orig == '\0')
> >                return NULL;
> >
> >        next = strchr(orig, '\n');
> >        if (next)
> >                *next++ = '\0';
> >
> >        *stringp = next;
>
> Yes, this code is easier to understand than my while loop.
> And strchr() is POSIX.
>
> So should I submit an updated patch or do you want to submit
> it (with a suggested-by: H. Nikolaus Schaller <hns@goldelico.com>)

Please send a patch.
(Co-developed-by if you want to give some credit to me)

> BR and thanks,
> Nikolaus Schaller
>
>


--
Best Regards
Masahiro Yamada
