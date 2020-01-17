Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02274C33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 09:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C66DD2073A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 09:54:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="My897psD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbgAQJyu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 04:54:50 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:46808 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbgAQJyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 04:54:49 -0500
Received: by mail-qk1-f195.google.com with SMTP id r14so22059805qke.13
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 01:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9kFTYGfEs/9SAwkwxZ+xsP/qfPJbE8uiwbZB2GtkwYs=;
        b=My897psDZMBwagGQ6Yi8DBTaWGenjkCZMzRCLm8NPW/mGNtq38BSN08w5wQQM+67Kd
         ZZ2l3SSjTkNAcsHHgtSilAg0k1IiFrAMAeC6viap/LEsk69WKbKDIK2uFP9brFczpQ6Q
         YYKHCsf99brQVXdGMqvuMpMh3ldHkPT9S1CgoEk5UPuqwjxUeY2OLJlHo6Fi/iVo6Cm9
         cKDVEGrlLDyvWXrf2I72c+Zbe9NeYw1sU/I4QINM9DWHruo8lPgjy8VFCUlxOyZMdtiL
         cNkv6OUZqUD8HHRUaSlxfDEvM7E2iSljjRMoIn0KnMl2rNhrf3/B608b8ftO7y6BcFV9
         W/ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9kFTYGfEs/9SAwkwxZ+xsP/qfPJbE8uiwbZB2GtkwYs=;
        b=ipOC3qoo3pAZvKTVvQLSNHl5F153d5aIOhCN/kHTMSfd8GdtMKJJKNRE68NsjImiTX
         VASBFJZsi+IGrI7nuRcNhNh91py3xKGrw4Umlv0v+FnHSdJSb/aFyJ59BYDovyB5Xf0S
         H1rFBJB4N551YpmqX4qimpLsAMS48Tqg0Qfmhdgz8zqjF0Eqpk/otSEwYArj7k04YPFl
         xcddeGTRDNZtdvUbhycQ0SLHviqAn8unZG0dRIxma7T/cYXQFNiCJvP4VJClzbDoYRGR
         Pb5Z4O79/7cD2DgTiSA/1Lzny3a+1zv6p8I11Lo2SW4z/cwlze6EYOwsxOoryiKCZZeR
         tvYA==
X-Gm-Message-State: APjAAAWD6aRZMhWnph1rQ0OsqApAjHunEnckJmEc5nVvO1J2AKEbjvDf
        4MwgVyHpANp0gUbfhwnEBCTlyItXfyZxZWrAf36AVg==
X-Google-Smtp-Source: APXvYqyeAb62xWiJYO2EfOnZ6vBYKZ/xLoxyS448Kg9u42z1XSWmFokBtRGediMr1jNmAm9go9FNWbbQw82+syEo1ho=
X-Received: by 2002:a05:620a:1136:: with SMTP id p22mr37884710qkk.8.1579254888242;
 Fri, 17 Jan 2020 01:54:48 -0800 (PST)
MIME-Version: 1.0
References: <20200116012321.26254-1-keescook@chromium.org> <20200116012321.26254-6-keescook@chromium.org>
 <CACT4Y+batRaj_PaDnfzLjpLDOCChhpiayKeab-rNLx5LAj1sSQ@mail.gmail.com> <202001161548.9E126B774F@keescook>
In-Reply-To: <202001161548.9E126B774F@keescook>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 17 Jan 2020 10:54:36 +0100
Message-ID: <CACT4Y+Z9o4B37-sNU2582FBv_2+evgyKVbVo-OAufLrsney=wA@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] kasan: Unset panic_on_warn before calling panic()
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Elena Petrova <lenaptr@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-hardening@lists.openwall.com,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 17, 2020 at 12:49 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Thu, Jan 16, 2020 at 06:23:01AM +0100, Dmitry Vyukov wrote:
> > On Thu, Jan 16, 2020 at 2:24 AM Kees Cook <keescook@chromium.org> wrote:
> > >
> > > As done in the full WARN() handler, panic_on_warn needs to be cleared
> > > before calling panic() to avoid recursive panics.
> > >
> > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > > ---
> > >  mm/kasan/report.c | 10 +++++++++-
> > >  1 file changed, 9 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> > > index 621782100eaa..844554e78893 100644
> > > --- a/mm/kasan/report.c
> > > +++ b/mm/kasan/report.c
> > > @@ -92,8 +92,16 @@ static void end_report(unsigned long *flags)
> > >         pr_err("==================================================================\n");
> > >         add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
> > >         spin_unlock_irqrestore(&report_lock, *flags);
> > > -       if (panic_on_warn)
> > > +       if (panic_on_warn) {
> > > +               /*
> > > +                * This thread may hit another WARN() in the panic path.
> > > +                * Resetting this prevents additional WARN() from panicking the
> > > +                * system on this thread.  Other threads are blocked by the
> > > +                * panic_mutex in panic().
> >
> > I don't understand part about other threads.
> > Other threads are not necessary inside of panic(). And in fact since
> > we reset panic_on_warn, they will not get there even if they should.
> > If I am reading this correctly, once one thread prints a warning and
> > is going to panic, other threads may now print infinite amounts of
> > warning and proceed past them freely. Why is this the behavior we
> > want?
>
> AIUI, the issue is the current thread hitting another WARN and blocking
> on trying to call panic again. WARNs encountered during the execution of
> panic() need to not attempt to call panic() again.

Yes, but the variable is global and affects other threads and the
comment talks about other threads, and that's the part I am confused
about (for both comment wording and the actual behavior). For the
"same thread hitting another warning" case we need a per-task flag or
something.

> -Kees
>
> >
> > > +                */
> > > +               panic_on_warn = 0;
> > >                 panic("panic_on_warn set ...\n");
> > > +       }
> > >         kasan_enable_current();
> > >  }
>
> --
> Kees Cook
