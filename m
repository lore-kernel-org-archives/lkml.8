Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E70C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 13:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF47F20825
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 13:39:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gA+IMnIW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729500AbgEUNjw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 09:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726856AbgEUNjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 09:39:51 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E9CC061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 06:39:51 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id a68so5489553otb.10
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 06:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L/LyXHTvDj+xHsQkYhu/jnhClGb0G5rs8Coqbegx7nM=;
        b=gA+IMnIWefySBK7Y5AOEqA4qyb1T8MlYmmm7P7k0AUZBHz4PDZUxkPPqT2aVl/DMGz
         4h79R/h0tBYsUnlxxxy0w5mH/9Q6zCLbQDkoKTHhPfzuGDx2sSr2HJU7WnUdr2DjH0Bq
         HVTxm4b/OyI+DKssmHuDHNXJbXNr3v9f7IlXhMBbiiPbFElFlAtpVTI1tZLJ8Jaq3rJ4
         pEJMLtvm9JzTMbht9dx8r9trHuTZNAesMLYwY6fMH5nHAQl0EnPTBPsxAukl3QbhTGjj
         lXlF9HNhcIaguqk9ShQjfQCh6ibVIdl5IEEcpiDoSmfcCLvHw4eUZK0kQi6D6WriCW4U
         bavQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L/LyXHTvDj+xHsQkYhu/jnhClGb0G5rs8Coqbegx7nM=;
        b=mt9HOwbuPjy9uLRjIc3mGFg0hsy9Jiz7dK8cp4WcS+f+5Ofxwpy1vEUGkMgzb74okL
         a7vCoQdgJa2JXuxi90XuF2Ica0x30L9xU1VcQ48LFaZS9xgp1mxB7pCajiStzrtGXgcm
         04KDS90GzHiN9wLFVI2uX3tECTPc3kT1W1xD38x9kt25yQ+oJS+QNcAix8mYuxsPyLYk
         ma825IOY3QbRYwZ9gAendZbkznTY6CihClpjYoI+AQZCAfBAhntCUpbjFmcwHUQX+Ubp
         V2o0+MU9OarKfevuviwuii168tYc/GOpZLS9ulMJ5nqVp5Shjzdntr7efgjbentpETN9
         0bNw==
X-Gm-Message-State: AOAM530Gt/nbM0a9zRn0xObafNqeEGZOJl+1WhiVq0AoAuf8df9zR+rI
        PN98JIJ9A4SXvaWlvaYKrKDc+kaNRwq5Ix6+LArTcA==
X-Google-Smtp-Source: ABdhPJwOq36Y+mIz+5DCgsbu70M4gdvYgO0V0OBEd62YqF0CRbkZI4ZgIaWRmZqRYaw+eN0e00vchGKG87/NHhF5Njc=
X-Received: by 2002:a9d:27a3:: with SMTP id c32mr7608614otb.233.1590068390262;
 Thu, 21 May 2020 06:39:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200521110854.114437-1-elver@google.com> <20200521110854.114437-10-elver@google.com>
 <20200521133150.GB6608@willie-the-truck>
In-Reply-To: <20200521133150.GB6608@willie-the-truck>
From:   Marco Elver <elver@google.com>
Date:   Thu, 21 May 2020 15:39:38 +0200
Message-ID: <CANpmjNORDOZxpk8=dRNu86V5YcJeinAq0K=8PZs39HXDLwNNJw@mail.gmail.com>
Subject: Re: [PATCH -tip v2 09/11] data_race: Avoid nested statement expression
To:     Will Deacon <will@kernel.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 May 2020 at 15:31, Will Deacon <will@kernel.org> wrote:
>
> On Thu, May 21, 2020 at 01:08:52PM +0200, Marco Elver wrote:
> > It appears that compilers have trouble with nested statements
> > expressions, as such make the data_race() macro be only a single
> > statement expression. This will help us avoid potential problems in
> > future as its usage increases.
> >
> > Link: https://lkml.kernel.org/r/20200520221712.GA21166@zn.tnic
> > Signed-off-by: Marco Elver <elver@google.com>
> > ---
> > v2:
> > * Add patch to series in response to above linked discussion.
> > ---
> >  include/linux/compiler.h | 9 ++++-----
> >  1 file changed, 4 insertions(+), 5 deletions(-)
> >
> > diff --git a/include/linux/compiler.h b/include/linux/compiler.h
> > index 7444f026eead..1f9bd9f35368 100644
> > --- a/include/linux/compiler.h
> > +++ b/include/linux/compiler.h
> > @@ -211,12 +211,11 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
> >   */
> >  #define data_race(expr)                                                      \
> >  ({                                                                   \
> > +     __unqual_scalar_typeof(({ expr; })) __v;                        \
> >       __kcsan_disable_current();                                      \
> > -     ({                                                              \
> > -             __unqual_scalar_typeof(({ expr; })) __v = ({ expr; });  \
> > -             __kcsan_enable_current();                               \
> > -             __v;                                                    \
> > -     });                                                             \
> > +     __v = ({ expr; });                                              \
> > +     __kcsan_enable_current();                                       \
> > +     __v;                                                            \
>
> Hopefully it doesn't matter, but this will run into issues with 'const'
> non-scalar expressions.

Good point. We could move the kcsan_disable_current() into ({
__kcsan_disable_current(); expr; }).

Will fix for v3.

Thanks,
-- Marco

> Will
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20200521133150.GB6608%40willie-the-truck.
