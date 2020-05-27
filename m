Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C945C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 10:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 696D3208FE
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 10:01:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="er5fM2Ho"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729758AbgE0KB2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 06:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729742AbgE0KBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 06:01:22 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9174BC061A0F
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 03:01:22 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id w15so14064935lfe.11
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 03:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Va7soqusV/pdX9tabvM6g0huhayPHF2tLgZz5g1TrtQ=;
        b=er5fM2Hoac4j802txN7dnFe/VMac5Z1uiqpUvVHBZRsItWJGX2nBXXgSCD5xv59IAw
         OIFp5S1meBWMm2jiXgQ4dmt1qVuFoYMoXwa/ql/zSLiAN1koy3KMagzKJXnRqZvEOdFV
         Q/Jr9giSseACvmbhwJohxqTkwsIGnNcJSnq33coGd03Bz4D9ulo9EVpoB52fVQZThMUk
         bztmJYvT8duUTqDKf9mjdzIrefqn4yjrk90JprHQ08BWcuvBI3f2DVFSu3V0VYOsBuIJ
         +ajnTO49uPzK4UJvraEkVbOssPQi9UTAfczQ22CwxF0Y3sLOdp6AtmzUgVKxJuvyHIQP
         HYEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Va7soqusV/pdX9tabvM6g0huhayPHF2tLgZz5g1TrtQ=;
        b=BiNZqKSD8betAScfltPMzUXrG4dCOq2jJ87I5QvUVo63UdFj2gOXJWVszHTkphrFcw
         Z0z9RpnoGYDROI2XIvCs3mGq3pBFLFoloBKsc7NWIeq5cJ9+Wgmicxmx0bksiBzUJsdN
         7/mNrzzaGvgQYx/B7JtWkgec0i1ouXMYMFLShYyizfeDf7mrPQ6D+c8tleecCTDIucKz
         jIospj6Jnem4oKG5Zcjn01LnkcERHY8+8c918bKHLD+FPb2XuvrfS8dYdqvc3JR77V7A
         H3Ynckl5bfkerTblZeKPB/fwZpAULuAxkbZt7ICWCKRA0GJJ4/T1vETwlyXKoSAsUq0Q
         E+MA==
X-Gm-Message-State: AOAM530aqvVM6CuBf00LOHMk8ZBET/kZ2u4E856W6NLxZZ9UHW7uh5fm
        XCa7miZEteKcavF06r99NGyVTqvKE9KythPVsEQKzg==
X-Google-Smtp-Source: ABdhPJwJMc/iLATSVKnz6wFO/n1A8JOQkVapY2CtSQNb7jD8SK+z5fyjU/dyFH4YKfFGarV6i66uDukk31I4Xbvmpgw=
X-Received: by 2002:ac2:560f:: with SMTP id v15mr2772568lfd.160.1590573680894;
 Wed, 27 May 2020 03:01:20 -0700 (PDT)
MIME-Version: 1.0
References: <1590560759-21453-1-git-send-email-sumit.garg@linaro.org>
 <1590560759-21453-2-git-send-email-sumit.garg@linaro.org> <20200527082907.wfvdsekmyzbpu3tu@holly.lan>
In-Reply-To: <20200527082907.wfvdsekmyzbpu3tu@holly.lan>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Wed, 27 May 2020 15:31:09 +0530
Message-ID: <CAFA6WYON1c6jA88BkaH_2DBhA9=sCjH=xUi14MU8SOcpPm9GGA@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] kdb: Re-factor kdb_printf() message write code
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     kgdb-bugreport@lists.sourceforge.net,
        Jason Wessel <jason.wessel@windriver.com>,
        Douglas Anderson <dianders@chromium.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 May 2020 at 13:59, Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Wed, May 27, 2020 at 11:55:56AM +0530, Sumit Garg wrote:
> > Re-factor kdb_printf() message write code in order to avoid duplication
> > of code and thereby increase readability.
> >
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > ---
> >  kernel/debug/kdb/kdb_io.c | 61 +++++++++++++++++++++++++----------------------
> >  1 file changed, 32 insertions(+), 29 deletions(-)
> >
> > diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
> > index 924bc92..f6b4d47 100644
> > --- a/kernel/debug/kdb/kdb_io.c
> > +++ b/kernel/debug/kdb/kdb_io.c
> > @@ -542,6 +542,33 @@ static int kdb_search_string(char *searched, char *searchfor)
> >       return 0;
> >  }
> >
> > +static void kdb_io_write(char *cp, int len, void (*io_put_char)(u8 ch))
>
> Don't use a function pointer here. Just pick it up from dbg_io_ops as
> usual.

My initial intent to use function pointer here was to extend this API
in patch #4 for poll_put_char() as well. But it just came to my mind
after your comment that internally dbg_io_ops->write_char() fallbacks
to tty_drv->ops->poll_put_char() API only. So I don't need to do any
crazy things with function pointers here in order to avoid a duplicate
loop but can simply invoke dbg_io_ops->write_char() here instead.

>
> > +{
> > +     if (len <= 0)
> > +             return;
>
> How can len ever be negative?
>

The only rationale to have this check is for completeness as the type
of variable: "len" being "int". If you don't prefer such checks, then
I can replace it with an "==" check.

>
> > +
> > +     while (len--) {
> > +             io_put_char(*cp);
> > +             cp++;
> > +     }
> > +}
> > +
> > +static void kdb_msg_write(char *msg, int msg_len)
> > +{
> > +     struct console *c;
> > +
> > +     if (msg_len <= 0)
> > +             return;
>
> How can msg_len ever be negative?
>

Same as above.

-Sumit

>
> > +
> > +     if (dbg_io_ops && !dbg_io_ops->is_console)
> > +             kdb_io_write(msg, msg_len, dbg_io_ops->write_char);
> > +
> > +     for_each_console(c) {
> > +             c->write(c, msg, msg_len);
> > +             touch_nmi_watchdog();
> > +     }
> > +}
> > +
> >  int vkdb_printf(enum kdb_msgsrc src, const char *fmt, va_list ap)
> >  {
> >       int diag;
> > @@ -553,7 +580,6 @@ int vkdb_printf(enum kdb_msgsrc src, const char *fmt, va_list ap)
> >       int this_cpu, old_cpu;
> >       char *cp, *cp2, *cphold = NULL, replaced_byte = ' ';
> >       char *moreprompt = "more> ";
> > -     struct console *c;
> >       unsigned long uninitialized_var(flags);
> >
> >       /* Serialize kdb_printf if multiple cpus try to write at once.
> > @@ -687,22 +713,11 @@ int vkdb_printf(enum kdb_msgsrc src, const char *fmt, va_list ap)
> >        */
> >       retlen = strlen(kdb_buffer);
> >       cp = (char *) printk_skip_headers(kdb_buffer);
> > -     if (!dbg_kdb_mode && kgdb_connected) {
> > +     if (!dbg_kdb_mode && kgdb_connected)
> >               gdbstub_msg_write(cp, retlen - (cp - kdb_buffer));
> > -     } else {
> > -             if (dbg_io_ops && !dbg_io_ops->is_console) {
> > -                     len = retlen - (cp - kdb_buffer);
> > -                     cp2 = cp;
> > -                     while (len--) {
> > -                             dbg_io_ops->write_char(*cp2);
> > -                             cp2++;
> > -                     }
> > -             }
> > -             for_each_console(c) {
> > -                     c->write(c, cp, retlen - (cp - kdb_buffer));
> > -                     touch_nmi_watchdog();
> > -             }
> > -     }
> > +     else
> > +             kdb_msg_write(cp, retlen - (cp - kdb_buffer));
> > +
> >       if (logging) {
> >               saved_loglevel = console_loglevel;
> >               console_loglevel = CONSOLE_LOGLEVEL_SILENT;
> > @@ -751,19 +766,7 @@ int vkdb_printf(enum kdb_msgsrc src, const char *fmt, va_list ap)
> >                       moreprompt = "more> ";
> >
> >               kdb_input_flush();
> > -
> > -             if (dbg_io_ops && !dbg_io_ops->is_console) {
> > -                     len = strlen(moreprompt);
> > -                     cp = moreprompt;
> > -                     while (len--) {
> > -                             dbg_io_ops->write_char(*cp);
> > -                             cp++;
> > -                     }
> > -             }
> > -             for_each_console(c) {
> > -                     c->write(c, moreprompt, strlen(moreprompt));
> > -                     touch_nmi_watchdog();
> > -             }
> > +             kdb_msg_write(moreprompt, strlen(moreprompt));
> >
> >               if (logging)
> >                       printk("%s", moreprompt);
> > --
> > 2.7.4
> >
