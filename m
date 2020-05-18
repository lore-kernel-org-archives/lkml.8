Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3A52C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCCE42081A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:53:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a84EmTd7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729461AbgERSxA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 14:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728402AbgERSw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 14:52:59 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B3CC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 11:52:59 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id q16so4608305plr.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 11:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dFak8/mdn0uAmUBsx2tXCAV4WCKdaMa+D5ub/JVb32o=;
        b=a84EmTd7Tp4Pbn+CkrTqRzCc9g1R2avRZs0ToXDlNwKWovnLKeUoMqxYCcT8OdRnuh
         kOexfXAYAL+KHDoNg7U20KPSIBzA7Szr/zYqZk1ERuAOfOViF2O7TKSEJZZqdJwAqpMN
         pI1+wDVlgTDzs3nwvN48hyGtwiD0oVtj8Cg4xsl5LUKsSYlK0UH7lmURJ9Ao5E+OATu9
         oQ1HjwsSWFFBUt+Zj9fNShLRAvZ5wlViWzQB7myPFPyLnjeEwlkv4uf7wdZsiL36p4ml
         9qY4OUM1FPwT2O/LdnL4yLpeaTnE0+TzO8IB3pjzuc9XPDH3J+9XYVdd/oCQ87bBMjz9
         Tn4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dFak8/mdn0uAmUBsx2tXCAV4WCKdaMa+D5ub/JVb32o=;
        b=DL8G1TupOgJdkQVj3BaLOAZIAwhYW7u3QxBQghdahHX184/X7dcUynxe0Y/tyuy2Rr
         VGtDwm+ew4gvb22/FNQpae1n8BqwyUXgoyANiQ4ANniG3fR4y67WwYYWQ8gEA+7XGSnj
         GtL6n9SIqJiadrSPvGWJfdNKjMEBPtRkdwmpcLqFUdMUSddGUVa7UFdRbEkgvlcBBGwY
         BPkOgzFJJklXnhpvZuwzIS22mtqHKgQ+77AJdyQvWtjt8iru089f0I4YYqD2OaLrr3za
         J16rQpfC9+KiDYXSJ+GHP/y7lawdqslA9OoBSVsUqHqMGqkCDfctafUZNQYjiMiBGocs
         0Qdg==
X-Gm-Message-State: AOAM533hhNPXeRe4+VvHYGaq0tt1i4LvYSl5ZRtpu2ku0UsQTgau7hYJ
        Wn1mdvbn3n7k99TSM0Jc4Pbxkn4EFg14blDfplrobg==
X-Google-Smtp-Source: ABdhPJwD4+q9rE52VUN1KmW84Ac+bxZIw4F46mR/IkVNPqXIvZlTgE2/S2ihGw8kx4s+4gkQ/0I9rnCcyC4gaCDzGIc=
X-Received: by 2002:a17:902:82c9:: with SMTP id u9mr6715535plz.179.1589827978379;
 Mon, 18 May 2020 11:52:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200408205323.44490-1-natechancellor@gmail.com> <20200518093117.GA719849@ubuntu-s3-xlarge-x86>
In-Reply-To: <20200518093117.GA719849@ubuntu-s3-xlarge-x86>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 18 May 2020 11:52:47 -0700
Message-ID: <CAKwvOdmXgYThHRDpt5dFZy5T1zS6MYQhcBNcq6-rsuc5fjiE6Q@mail.gmail.com>
Subject: Re: [PATCH] x86: mmiotrace: Use cpumask_available for cpumask_var_t variables
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Karol Herbst <karolherbst@gmail.com>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        nouveau@lists.freedesktop.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Sedat Dilek <sedat.dilek@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 18, 2020 at 2:31 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> On Wed, Apr 08, 2020 at 01:53:23PM -0700, Nathan Chancellor wrote:
> > When building with Clang + -Wtautological-compare and
> > CONFIG_CPUMASK_OFFSTACK unset:
> >
> > arch/x86/mm/mmio-mod.c:375:6: warning: comparison of array 'downed_cpus'
> > equal to a null pointer is always false [-Wtautological-pointer-compare]
> >         if (downed_cpus == NULL &&
> >             ^~~~~~~~~~~    ~~~~
> > arch/x86/mm/mmio-mod.c:405:6: warning: comparison of array 'downed_cpus'
> > equal to a null pointer is always false [-Wtautological-pointer-compare]
> >         if (downed_cpus == NULL || cpumask_weight(downed_cpus) == 0)
> >             ^~~~~~~~~~~    ~~~~
> > 2 warnings generated.
> >
> > Commit f7e30f01a9e2 ("cpumask: Add helper cpumask_available()") added
> > cpumask_available to fix warnings of this nature. Use that here so that
> > clang does not warn regardless of CONFIG_CPUMASK_OFFSTACK's value.
> >
> > Link: https://github.com/ClangBuiltLinux/linux/issues/982
> > Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Thanks for the patch, sorry I'm falling behind on code review!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> > ---
> >  arch/x86/mm/mmio-mod.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/x86/mm/mmio-mod.c b/arch/x86/mm/mmio-mod.c
> > index 109325d77b3e..43fd19b3f118 100644
> > --- a/arch/x86/mm/mmio-mod.c
> > +++ b/arch/x86/mm/mmio-mod.c
> > @@ -372,7 +372,7 @@ static void enter_uniprocessor(void)
> >       int cpu;
> >       int err;
> >
> > -     if (downed_cpus == NULL &&
> > +     if (!cpumask_available(downed_cpus) &&
> >           !alloc_cpumask_var(&downed_cpus, GFP_KERNEL)) {
> >               pr_notice("Failed to allocate mask\n");
> >               goto out;
> > @@ -402,7 +402,7 @@ static void leave_uniprocessor(void)
> >       int cpu;
> >       int err;
> >
> > -     if (downed_cpus == NULL || cpumask_weight(downed_cpus) == 0)
> > +     if (!cpumask_available(downed_cpus) || cpumask_weight(downed_cpus) == 0)
> >               return;
> >       pr_notice("Re-enabling CPUs...\n");
> >       for_each_cpu(cpu, downed_cpus) {
> >
> > base-commit: ae46d2aa6a7fbe8ca0946f24b061b6ccdc6c3f25
> > --
> > 2.26.0
> >
>
> Gentle ping for acceptance, I am not sure who should take this.

Looks like Steven or Ingo are the listed maintainers for MMIOTRACE?

-- 
Thanks,
~Nick Desaulniers
