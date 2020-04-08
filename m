Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD72C2BA16
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 21:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72C7A206C0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 21:37:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hco7MSfh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729410AbgDHVhC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 17:37:02 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52238 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728438AbgDHVhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 17:37:01 -0400
Received: by mail-wm1-f67.google.com with SMTP id t203so1486840wmt.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 14:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=q4sLyktfrOExuEZEYqjNYRWtmjYeOihRLdSqSzM0jBQ=;
        b=Hco7MSfhBD/kWrXXtSZaT1Uq3HYjzmA4BWBwNBTzpupRmSLiC2ehWSbJaPcx3LKRRE
         CQqagdrVOrJ/io0IH4/tm+to4FWYgZe/eGUtOcscYiApxnKXriXLXv38HTjEeEg/PCPa
         7jH3H1kS+tK3/P0PTvbiMQjfiXJAXQqygCxS1+ZIWRhUZOifADjfUPbjizrY86rqz0tb
         +M0lWtS/+Szy0sKswMs5UQEYcEWqLtVp3Vh2Ihc3s//nQfufc7sK+LtMin3WlJxTAeFy
         /ApET9dWMGVw+ovEvY5VB98kZNucRGPdwWZYkGZcPszR413B2k6Vw0JUiCaVw+zujUxK
         x0cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=q4sLyktfrOExuEZEYqjNYRWtmjYeOihRLdSqSzM0jBQ=;
        b=b8E1japoTJF9PphxBtr9S2cfj8W8FIiUqHW4gSKK/42MK6HX/X24VZiCqiVNAW2PSq
         fii/JbfdFFhcoDAaSmwyxKbvZ6TOYZLe/VrMyHMgsujZJVwGMla2+gBf/tU+W2fsBdNa
         0xj4bN4yszMwTzQpMOJDJa7/x8SidQ6P1fUfglrqyDkQ42njFmCOrzdwRRFA3OevH77Q
         E4QhxlQi4W0mVMt/Gzrg5W9rLrLO+T+FsRcm49UbYgvlh+Pvqyj5VXoVdH4arwHlLHU4
         b2FDa2sTle5wli284tHOs/FNU62+yijxRe1eLZOYD8D45kXfs2gjz8tpEFgMZ1Y1HGYK
         /D3Q==
X-Gm-Message-State: AGi0PuZN23OIEIU3kg3FlLnvE4Bo4XYDaUgmEZO16/+r1TSeTciEMcbA
        A31zgtPz3f/ZPijc2mkfWnFPVcwgVRrFdfbYLLrMwZdQ
X-Google-Smtp-Source: APiQypKkyO/X4F3zpkuwxZGJdH1jCd8hOH5NdPfJtHGzrLYyMWWO6zubYykoEYC7/vylnfuleQnGTAC7qDAAd4gYDiA=
X-Received: by 2002:a7b:cb86:: with SMTP id m6mr6258988wmi.64.1586381820060;
 Wed, 08 Apr 2020 14:37:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200408205323.44490-1-natechancellor@gmail.com> <CA+icZUUTEEZww3qT0jfFP0ZgUPXoF1_uOHMT4ZecrQxumE1Zmg@mail.gmail.com>
In-Reply-To: <CA+icZUUTEEZww3qT0jfFP0ZgUPXoF1_uOHMT4ZecrQxumE1Zmg@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Wed, 8 Apr 2020 23:36:47 +0200
Message-ID: <CA+icZUWq=_qjvAf40PqQAj3tQ0WAZ2QAR9hojTuYqZH_=RWd_w@mail.gmail.com>
Subject: Re: [PATCH] x86: mmiotrace: Use cpumask_available for cpumask_var_t variables
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Karol Herbst <karolherbst@gmail.com>,
        Pekka Paalanen <ppaalanen@gmail.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, nouveau@lists.freedesktop.org,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 8, 2020 at 11:12 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Wed, Apr 8, 2020 at 10:53 PM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > When building with Clang + -Wtautological-compare and
> > CONFIG_CPUMASK_OFFSTACK unset:
> >
>
> Hi Nathan,
>
> thanks for the quick patch.
>
> I can confirm I have no CONFIG_CPUMASK_OFFSTACK set.
>

Feel free to add appropriate credits:

   Tested-by: Sedat Dilek <sedat.dilek@gmail.com>

Regards,
- Sedat -

>
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
> > ---
> >  arch/x86/mm/mmio-mod.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/x86/mm/mmio-mod.c b/arch/x86/mm/mmio-mod.c
> > index 109325d77b3e..43fd19b3f118 100644
> > --- a/arch/x86/mm/mmio-mod.c
> > +++ b/arch/x86/mm/mmio-mod.c
> > @@ -372,7 +372,7 @@ static void enter_uniprocessor(void)
> >         int cpu;
> >         int err;
> >
> > -       if (downed_cpus == NULL &&
> > +       if (!cpumask_available(downed_cpus) &&
> >             !alloc_cpumask_var(&downed_cpus, GFP_KERNEL)) {
> >                 pr_notice("Failed to allocate mask\n");
> >                 goto out;
> > @@ -402,7 +402,7 @@ static void leave_uniprocessor(void)
> >         int cpu;
> >         int err;
> >
> > -       if (downed_cpus == NULL || cpumask_weight(downed_cpus) == 0)
> > +       if (!cpumask_available(downed_cpus) || cpumask_weight(downed_cpus) == 0)
> >                 return;
> >         pr_notice("Re-enabling CPUs...\n");
> >         for_each_cpu(cpu, downed_cpus) {
> >
> > base-commit: ae46d2aa6a7fbe8ca0946f24b061b6ccdc6c3f25
> > --
> > 2.26.0
> >
