Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD648C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79B842064C
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:49:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KwvjQE6K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388819AbgAPXtm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 18:49:42 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44789 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729923AbgAPXtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 18:49:42 -0500
Received: by mail-pf1-f196.google.com with SMTP id 62so4384062pfu.11
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 15:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OBxWYYcj5NPKpHkfAvk0D+yaQt02q3V7O1jMrLi++8s=;
        b=KwvjQE6Km2etTVhaE8nM7iQgSseVckSPoFXS9z+61asz/2ydl2l/LbosucQ6amtpmp
         fWlc71/0KBd52vPDs17gTauBeKCkWZCnvN84QFS8KBmhRwyICKbV5BfsSMnxRla368u5
         tAw1bQ/sDNosVbDntEEHkjhH9DLmKgsfCIQJw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OBxWYYcj5NPKpHkfAvk0D+yaQt02q3V7O1jMrLi++8s=;
        b=iNMPmVwAqjuCMkMSgaykfn/bsb2mmIikE0ndHQgA25FWn9d0YPeJonlPVR117GySf4
         DSvUNFL+9K22qqw5D83vtDQfVNQXg8TL6pXhKwwQ2TskU4//yjjOnoNfwmRsBo1IS7NX
         bYtE885WRbrnzfr16+9oAFljMH34BiIcW1+dHCcljvl1+n5S+gpDC9RGOa85UDdLy4LM
         kxivRO8AxCzU73W9O1KbFIM3A06fz1dtfCnoDcgThcRCGg5oZoRoBHHpPfYueFcL8+S8
         bJeZIqq8WLXLQAmnYlSf5n2GVcUBD4mCuHsBlNb9y0lFF/0VGibsqeA4DQlFe5dW4SXr
         709g==
X-Gm-Message-State: APjAAAVgPWoxtniDrdYzOpygDrhmKjnwq1TUFhD8noQIqSkCFEyho2iY
        RnOBuW+WYz9HkV7qhl77Y2VybA==
X-Google-Smtp-Source: APXvYqyTkCmgC2RjcsZ0Ylbb4YhfLljHgWOdH3ZZOWEWWwjqeDUK0+AGE5a35VIRuk7qsju46ToEZg==
X-Received: by 2002:a62:158c:: with SMTP id 134mr44301pfv.81.1579218581788;
        Thu, 16 Jan 2020 15:49:41 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p5sm25618874pgs.28.2020.01.16.15.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 15:49:40 -0800 (PST)
Date:   Thu, 16 Jan 2020 15:49:39 -0800
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
Message-ID: <202001161548.9E126B774F@keescook>
References: <20200116012321.26254-1-keescook@chromium.org>
 <20200116012321.26254-6-keescook@chromium.org>
 <CACT4Y+batRaj_PaDnfzLjpLDOCChhpiayKeab-rNLx5LAj1sSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+batRaj_PaDnfzLjpLDOCChhpiayKeab-rNLx5LAj1sSQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 16, 2020 at 06:23:01AM +0100, Dmitry Vyukov wrote:
> On Thu, Jan 16, 2020 at 2:24 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > As done in the full WARN() handler, panic_on_warn needs to be cleared
> > before calling panic() to avoid recursive panics.
> >
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  mm/kasan/report.c | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> > index 621782100eaa..844554e78893 100644
> > --- a/mm/kasan/report.c
> > +++ b/mm/kasan/report.c
> > @@ -92,8 +92,16 @@ static void end_report(unsigned long *flags)
> >         pr_err("==================================================================\n");
> >         add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
> >         spin_unlock_irqrestore(&report_lock, *flags);
> > -       if (panic_on_warn)
> > +       if (panic_on_warn) {
> > +               /*
> > +                * This thread may hit another WARN() in the panic path.
> > +                * Resetting this prevents additional WARN() from panicking the
> > +                * system on this thread.  Other threads are blocked by the
> > +                * panic_mutex in panic().
> 
> I don't understand part about other threads.
> Other threads are not necessary inside of panic(). And in fact since
> we reset panic_on_warn, they will not get there even if they should.
> If I am reading this correctly, once one thread prints a warning and
> is going to panic, other threads may now print infinite amounts of
> warning and proceed past them freely. Why is this the behavior we
> want?

AIUI, the issue is the current thread hitting another WARN and blocking
on trying to call panic again. WARNs encountered during the execution of
panic() need to not attempt to call panic() again.

-Kees

> 
> > +                */
> > +               panic_on_warn = 0;
> >                 panic("panic_on_warn set ...\n");
> > +       }
> >         kasan_enable_current();
> >  }

-- 
Kees Cook
