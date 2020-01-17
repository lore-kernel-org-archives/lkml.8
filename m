Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE9A6C33C9E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 21:20:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 816222082F
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 21:20:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IjpQ6Aru"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbgAQVUD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 16:20:03 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:52965 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbgAQVUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 16:20:03 -0500
Received: by mail-pj1-f65.google.com with SMTP id a6so3695139pjh.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 13:20:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0ov/MSAN6f4SPopx5kOpmENhTI+79DbFyHl+2GkJMEA=;
        b=IjpQ6AruYOQXtDxHd+zKg5GsKnESXxpMZo+UVz/wmImaZBIE8VKhbVzLt2LoklC5bD
         l9h3c2KcYAhdV9hV9YOSoz+vrrcgb6HYYAfoqYyQcq4NzvKbdOmBgQtBZ8VIsv4SWiyq
         XINwdMI5Yig58QPf0z8GIetXCQQjMGEz/8v98=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0ov/MSAN6f4SPopx5kOpmENhTI+79DbFyHl+2GkJMEA=;
        b=QnQj6su2n4pGnLqZlsMyzfPvipw5JRKAy0vdWmW231BUgUPvtMkyiek/bSFCNEGU9l
         C358karvdbpIrf/eY99F61WVU+QH37nADzIZLQ/OpNuLg2ZXgwinxxnenDWwDlE/v+oN
         zaGKZItKRfwZmFbreYjZdyEYqLDUzufJutJgP0Mr1bY8/7Bb88mnuSX8SFDcU2LT889X
         MKhDQSEjVGiCw8rDXtz8dl+LYdRWOzFAAqP19I4K4NcXQwoCnb72zUeZgsZhp3hU3UJu
         M0aQPYgX1LugY1QFlzsTsbIdF8QBA6Ux+Wsck5RhWbXARMCo/OnD14Jaztf72bnks0AW
         Au6g==
X-Gm-Message-State: APjAAAWBZ283A1zMO9dQFikMdPzJugMtuXOoyaZcyzmrYBrzR8C6ASq8
        Hp44D7O67lsUFrPoGXAAHfBURA==
X-Google-Smtp-Source: APXvYqy3GM8G96xZEmnB/alOHFkZv4nSmr+HVZwvtwVaFU/LFlURsKL++MNAsUwSkHdtG7mGhpS4tw==
X-Received: by 2002:a17:902:b401:: with SMTP id x1mr1280965plr.326.1579296002758;
        Fri, 17 Jan 2020 13:20:02 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w11sm29039174pfn.4.2020.01.17.13.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 13:20:01 -0800 (PST)
Date:   Fri, 17 Jan 2020 13:20:00 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Dmitry Vyukov <dvyukov@google.com>
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
Subject: Re: [PATCH v3 5/6] kasan: Unset panic_on_warn before calling panic()
Message-ID: <202001171317.5E3C106F@keescook>
References: <20200116012321.26254-1-keescook@chromium.org>
 <20200116012321.26254-6-keescook@chromium.org>
 <CACT4Y+batRaj_PaDnfzLjpLDOCChhpiayKeab-rNLx5LAj1sSQ@mail.gmail.com>
 <202001161548.9E126B774F@keescook>
 <CACT4Y+Z9o4B37-sNU2582FBv_2+evgyKVbVo-OAufLrsney=wA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+Z9o4B37-sNU2582FBv_2+evgyKVbVo-OAufLrsney=wA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 17, 2020 at 10:54:36AM +0100, Dmitry Vyukov wrote:
> On Fri, Jan 17, 2020 at 12:49 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Thu, Jan 16, 2020 at 06:23:01AM +0100, Dmitry Vyukov wrote:
> > > On Thu, Jan 16, 2020 at 2:24 AM Kees Cook <keescook@chromium.org> wrote:
> > > >
> > > > As done in the full WARN() handler, panic_on_warn needs to be cleared
> > > > before calling panic() to avoid recursive panics.
> > > >
> > > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > > > ---
> > > >  mm/kasan/report.c | 10 +++++++++-
> > > >  1 file changed, 9 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> > > > index 621782100eaa..844554e78893 100644
> > > > --- a/mm/kasan/report.c
> > > > +++ b/mm/kasan/report.c
> > > > @@ -92,8 +92,16 @@ static void end_report(unsigned long *flags)
> > > >         pr_err("==================================================================\n");
> > > >         add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
> > > >         spin_unlock_irqrestore(&report_lock, *flags);
> > > > -       if (panic_on_warn)
> > > > +       if (panic_on_warn) {
> > > > +               /*
> > > > +                * This thread may hit another WARN() in the panic path.
> > > > +                * Resetting this prevents additional WARN() from panicking the
> > > > +                * system on this thread.  Other threads are blocked by the
> > > > +                * panic_mutex in panic().
> > >
> > > I don't understand part about other threads.
> > > Other threads are not necessary inside of panic(). And in fact since
> > > we reset panic_on_warn, they will not get there even if they should.
> > > If I am reading this correctly, once one thread prints a warning and
> > > is going to panic, other threads may now print infinite amounts of
> > > warning and proceed past them freely. Why is this the behavior we
> > > want?
> >
> > AIUI, the issue is the current thread hitting another WARN and blocking
> > on trying to call panic again. WARNs encountered during the execution of
> > panic() need to not attempt to call panic() again.
> 
> Yes, but the variable is global and affects other threads and the
> comment talks about other threads, and that's the part I am confused
> about (for both comment wording and the actual behavior). For the
> "same thread hitting another warning" case we need a per-task flag or
> something.

This is duplicating the common panic-on-warn logic (see the generic bug
code), so I'd like to just have the same behavior between the three
implementations of panic-on-warn (generic bug, kasan, ubsan), and then
work to merge them into a common handler, and then perhaps fix the
details of the behavior. I think it's more correct to allow the panicing
thread to complete than to care about what the other threads are doing.
Right now, a WARN within the panic code will either a) hang the machine,
or b) not panic, allowing the rest of the threads to continue, maybe
then hitting other WARNs and hanging. The generic bug code does not
suffer from this.

-Kees

> 
> > -Kees
> >
> > >
> > > > +                */
> > > > +               panic_on_warn = 0;
> > > >                 panic("panic_on_warn set ...\n");
> > > > +       }
> > > >         kasan_enable_current();
> > > >  }
> >
> > --
> > Kees Cook

-- 
Kees Cook
