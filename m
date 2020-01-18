Return-Path: <SRS0=3sb/=3H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 212F3C33CB7
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 09:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB6282468C
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 09:19:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r5Osyi+5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbgARJT1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jan 2020 04:19:27 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:32973 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbgARJT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 04:19:26 -0500
Received: by mail-qt1-f196.google.com with SMTP id d5so23784845qto.0
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jan 2020 01:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z7V6E0TDaKraOo9dTt7jhc6TLdoMlUlp/uyIAC+ZTcI=;
        b=r5Osyi+5S7I7ieJbRoinobkAaTllvHQz6AIaLQiYADUQlxAhGTpSFct10Rbv/qtQPE
         XeQcvA/TRKGpFLwD5gVeUdVLPE5SFwnaYYXJ09z9LSlZ97mXMTSlaIdv3kesQ6zD7o+C
         Iqilhd9nvoenPTM0cdlDK9qXTOP7vvglydomTJkikqduytMLU706Obi4jiFowybtbViF
         93GtIc0xCZ7BAhaBAOlOKgSo77ZOJ/h/4ntx0g05wHFtFKwmmVfV8Rw7DmZrwumRApv6
         2JN3gsKiuVf1UXzL0PyPH/jOaFC4nlRGCFG5rOk/4sjfNUfOFYWVYrG8VrH/xB4a1Yc6
         0VkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z7V6E0TDaKraOo9dTt7jhc6TLdoMlUlp/uyIAC+ZTcI=;
        b=qgr0cYbmEBmgLmtkuWZcbHkHUFbMOrxyjeJHN8TCXuDPJzQu94gnMw832DuR0m1rnY
         ICjIzrjou/V2B+0UbLEMjOurTuu1XAeaEwZ5bua8iUJuDLNARC4HUF/qDfmh0+DMeIjq
         k5nvrxaev9cf7npc6bo+Wy0EYVN1256cfoNUWR1HNNWtWfq9o0yHWFkqUKfQAUQZfOJZ
         7URKLIoPEqwcfXVfkqsPXNiz3+E8fKXQUcR8yj2/oA9u+tPWpJhxhp4AcWZ4GdeUQT2H
         kgLNneTb/284U3ePET3EN7o8kBIhx7ct4wd0xyPlW+t5EDs0pj7ogHc1fwb9TZzcvvbB
         +jFw==
X-Gm-Message-State: APjAAAWgSVvO2jp9kAFEBYGZKYDfx5OsxlNOSwYZcjSOpWGlejKzn/5i
        9EAKj/W1/9rWGAr74mHpWld/JyeBOKPbDXVRIxYegQ==
X-Google-Smtp-Source: APXvYqySu7QSqXqUmm7G/+6P0CGxNfV2qDMzuVTo/0NaUw5yglIxMT0d3on5SEunQ2/Vpk1yqcdlYTa4b1UTbvflla4=
X-Received: by 2002:aed:3b6e:: with SMTP id q43mr11061878qte.57.1579339163936;
 Sat, 18 Jan 2020 01:19:23 -0800 (PST)
MIME-Version: 1.0
References: <20200116012321.26254-1-keescook@chromium.org> <20200116012321.26254-6-keescook@chromium.org>
 <CACT4Y+batRaj_PaDnfzLjpLDOCChhpiayKeab-rNLx5LAj1sSQ@mail.gmail.com>
 <202001161548.9E126B774F@keescook> <CACT4Y+Z9o4B37-sNU2582FBv_2+evgyKVbVo-OAufLrsney=wA@mail.gmail.com>
 <202001171317.5E3C106F@keescook>
In-Reply-To: <202001171317.5E3C106F@keescook>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sat, 18 Jan 2020 10:19:12 +0100
Message-ID: <CACT4Y+ansnGK3woNmiZurj1eGfygbz7anxRqYe_VPs-_HE2u6g@mail.gmail.com>
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

On Fri, Jan 17, 2020 at 10:20 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Fri, Jan 17, 2020 at 10:54:36AM +0100, Dmitry Vyukov wrote:
> > On Fri, Jan 17, 2020 at 12:49 AM Kees Cook <keescook@chromium.org> wrote:
> > >
> > > On Thu, Jan 16, 2020 at 06:23:01AM +0100, Dmitry Vyukov wrote:
> > > > On Thu, Jan 16, 2020 at 2:24 AM Kees Cook <keescook@chromium.org> wrote:
> > > > >
> > > > > As done in the full WARN() handler, panic_on_warn needs to be cleared
> > > > > before calling panic() to avoid recursive panics.
> > > > >
> > > > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > > > > ---
> > > > >  mm/kasan/report.c | 10 +++++++++-
> > > > >  1 file changed, 9 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> > > > > index 621782100eaa..844554e78893 100644
> > > > > --- a/mm/kasan/report.c
> > > > > +++ b/mm/kasan/report.c
> > > > > @@ -92,8 +92,16 @@ static void end_report(unsigned long *flags)
> > > > >         pr_err("==================================================================\n");
> > > > >         add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
> > > > >         spin_unlock_irqrestore(&report_lock, *flags);
> > > > > -       if (panic_on_warn)
> > > > > +       if (panic_on_warn) {
> > > > > +               /*
> > > > > +                * This thread may hit another WARN() in the panic path.
> > > > > +                * Resetting this prevents additional WARN() from panicking the
> > > > > +                * system on this thread.  Other threads are blocked by the
> > > > > +                * panic_mutex in panic().
> > > >
> > > > I don't understand part about other threads.
> > > > Other threads are not necessary inside of panic(). And in fact since
> > > > we reset panic_on_warn, they will not get there even if they should.
> > > > If I am reading this correctly, once one thread prints a warning and
> > > > is going to panic, other threads may now print infinite amounts of
> > > > warning and proceed past them freely. Why is this the behavior we
> > > > want?
> > >
> > > AIUI, the issue is the current thread hitting another WARN and blocking
> > > on trying to call panic again. WARNs encountered during the execution of
> > > panic() need to not attempt to call panic() again.
> >
> > Yes, but the variable is global and affects other threads and the
> > comment talks about other threads, and that's the part I am confused
> > about (for both comment wording and the actual behavior). For the
> > "same thread hitting another warning" case we need a per-task flag or
> > something.
>
> This is duplicating the common panic-on-warn logic (see the generic bug
> code), so I'd like to just have the same behavior between the three
> implementations of panic-on-warn (generic bug, kasan, ubsan), and then
> work to merge them into a common handler, and then perhaps fix the
> details of the behavior. I think it's more correct to allow the panicing
> thread to complete than to care about what the other threads are doing.
> Right now, a WARN within the panic code will either a) hang the machine,
> or b) not panic, allowing the rest of the threads to continue, maybe
> then hitting other WARNs and hanging. The generic bug code does not
> suffer from this.

I see. Then:

Acked-by: Dmitry Vyukov <dvyukov@google.com>
