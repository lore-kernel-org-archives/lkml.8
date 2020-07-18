Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA695C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 02:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 957E82073E
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 02:29:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="ZDyrRic8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728614AbgGRC3t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 22:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726742AbgGRC3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 22:29:48 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 868C2C0619D2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 19:29:47 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id p3so7538484pgh.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 19:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jKRXb8NO4VDe7xli2FLvlxbzvfxHX+po/Q2oKaDoEEA=;
        b=ZDyrRic8jiij82oO0amZce4xu0dchvZ8O2XAEEr82oIwwUInQuyET2E40t3Y+ZaK/r
         YM77OaPtAXyEXWkEr+NtloGMKT4tzDbUfxFmP3sIiDpW74ob1nIq++5twng3fuk5mc6n
         msgLaKV4Rm6c34L+0OGRd4BUHyEAWp8c2681y3ta+518Y5jD7ah4qMCc4xX7HdoKweAJ
         Gg9W96X3nHG99pvu2jvBm7lsgsYRib/IhqnurMSQsbcqzwiRJ2UF9OCuCK8+gdSV8jZo
         hS+G3vpuKo1DCM03k9ZiyUx2FrXlF229nur+Dp2ymur5uwUCVS6o41y/4UlVjWlnOUCX
         ieMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jKRXb8NO4VDe7xli2FLvlxbzvfxHX+po/Q2oKaDoEEA=;
        b=kHFmLRMbS+2jlS7W/LLxp+FyoRRVC4SSp697RzWjvpq6yTsg4ctfAmU3BoYDahW8is
         1N76fpDR/DqhrnOrw6rNtab7CEiOBaZm9XrqFkP0vSWFtiH3ANSu1waGhmj2h6wxFLdq
         fT3Zx+NjyGeE4dUjppYhqoHbQbAgpLtGOpY8wp6SYd2qiqus8HfKJefyPgrSGnuo9PhA
         S3eMIOOR3ykN3lIAzt3h9xXIayqagRLLdf4/Fecz12AqCnoNBEisB+x/Mj8EYS9kvW1h
         +D7ySM0lVcHm4UkO2XYgODuX5BN9kddap0cmZ92JH8sgG+6ENt2icsKPwHDEBwp5OMfJ
         IOXA==
X-Gm-Message-State: AOAM530R4MNC/dInBZqO6OsRxGC06drchEyskpUFwN1t5Wlcyw9xASlp
        NFh3HYUzVllov/Ms2R6UHM4n4Ychm8MutI4P+VjCoA==
X-Google-Smtp-Source: ABdhPJz7d+BdHEWqPHXdZ3Umda2/5FpmJgMTQzQAQ9nnBLUb8hkA5dIQel1eCTAdxM0DthU302KyK8qovjW6Apz0pWM=
X-Received: by 2002:a63:6884:: with SMTP id d126mr10661799pgc.341.1595039386980;
 Fri, 17 Jul 2020 19:29:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200716070457.53255-1-songmuchun@bytedance.com> <87k0z1rj89.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87k0z1rj89.fsf@nanos.tec.linutronix.de>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Sat, 18 Jul 2020 10:29:11 +0800
Message-ID: <CAMZfGtX7gxky5MVFwz3k=BN7p1tL+PKN43TENbuCfa+AkSbzZg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH RESEND] smp: Fix a potential usage of stale nr_cpus
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org,
        bigeasy@linutronix.de, namit@vmware.com,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 18, 2020 at 4:15 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Muchun,
>
> Muchun Song <songmuchun@bytedance.com> writes:
>
> > The get_option() maybe return 0, it means that the nr_cpus is
> > not initialized.
>
> Good catch, but see below.
>
> > Then we will use the stale nr_cpus to initialize
>
> We use nothing. Please describe your changes in technical neutral
> language.
>
> > the nr_cpu_ids. So fix it.
>
> 'So fix it.' is not much valuable information. What about:
>
>     Check the return value to prevent this.
>
> Hmm?

Looks fine to me. Thanks.

>
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > ---
> >  kernel/smp.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/kernel/smp.c b/kernel/smp.c
> > index 472c2b274c65..2a9a04acf123 100644
> > --- a/kernel/smp.c
> > +++ b/kernel/smp.c
> > @@ -634,8 +634,7 @@ static int __init nrcpus(char *str)
> >  {
> >       int nr_cpus;
> >
> > -     get_option(&str, &nr_cpus);
> > -     if (nr_cpus > 0 && nr_cpus < nr_cpu_ids)
> > +     if (get_option(&str, &nr_cpus) && nr_cpus > 0 && nr_cpus < nr_cpu_ids)
> >               nr_cpu_ids = nr_cpus;
> >
> >       return 0;
>
> get_option() can return 0 - 3:
>
>  *      0 - no int in string
>  *      1 - int found, no subsequent comma
>  *      2 - int found including a subsequent comma
>  *      3 - hyphen found to denote a range
>
> For this parameter exists only one valid format: '1 - int found, no comma',
> right?

Yeah.

>
> So why fixing it just half and why returning '0' aka success if the
> parameter is bogus?

Thanks. Will fix it.

>
> Thanks,
>
>         tglx



-- 
Yours,
Muchun
