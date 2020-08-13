Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17397C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 20:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E526C20675
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 20:49:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CiD03k6n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbgHMUto (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 16:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726486AbgHMUto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 16:49:44 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1154BC061383
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 13:49:44 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id v6so5892955ota.13
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 13:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=icwPTzlOzlLq94sgyZZU9ElTfcuw2eVVedKrZCYX64A=;
        b=CiD03k6nzQTEW7iZEhNO/BAlUPZ+kTO8GZS9ZykH2f7VJvoLeYKKtoAsEgIqb6J18H
         7rCLU+ZjZKQPhaNflNoc0frGFbQmkQht9N/kHKRK76cnASqVbNYfmf7W/DZPSzqR/Cn9
         g1fLiFqOXxjWz9K9a2xJRE25UVnQiQ+3UHvsFdwYeHSQ3A3kcRw9zKCVJURFOrxgm1PC
         T6goTWX7LaQIyalyBCGCT0z5wCgUlLFB/Dd0Np9bpYk7NMgGFOpwsTgO51tQ7XlEV4v0
         eyXQxSOxZY+qzcV/Y8Un3JjisENXDUfeT7X79tB0s08qlJ/vf8HOQmXgUtBlLcqse3sp
         +Fwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=icwPTzlOzlLq94sgyZZU9ElTfcuw2eVVedKrZCYX64A=;
        b=Z3U5uWOtJbXXi5zyXyrSwbj/dq+d9oKuhhgDIqmq0H57fCaTBqi0TThXSg+YGIfqQ5
         kg5JlBGDQu0atgT5dd9e6uA8WPU28y0ICwsMWNotFZ1yqYkYnKR6Vab5XQfPAzcr9Ydu
         jYzIQJFzPKASR1p15cJgx06e9zzWnFGnkMaiFFp7SG2Vh5MWji71QG1ivOFUtZcfSSVu
         uTy8gd0d/VmoZ8C8NPYT+Q9hhZJuwSC1sW+46WD9LwTgjvjCjYZFcWGRm4q1/gPcaod5
         kfj9tYAYRc3c98H8+a09/He8lJEwGeP9HRI6f5JHhpDUFNa2WFSO+TTmBqvb3t8KWOrQ
         IeZg==
X-Gm-Message-State: AOAM530jUX/eCQwhbnK6QMkqixTmeN6/6Fbyt4EWzjdcv9uF66gpPCUn
        HmQenvOoGPRPTO1UH4kuhrfpwK6c/E1m08ad80Tubll4
X-Google-Smtp-Source: ABdhPJySUMbmOi8682FCf9k0rtc40K/rMkthT8G3y5DkT35881HaaKNvapQkArVfY7QS4LZKhTQ7ilhXunWdFsRafQs=
X-Received: by 2002:a05:6830:614:: with SMTP id w20mr6050894oti.283.1597351783206;
 Thu, 13 Aug 2020 13:49:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200806174326.3577537-1-urielguajardojr@gmail.com>
 <20200806174326.3577537-2-urielguajardojr@gmail.com> <CAFd5g47AO64WMvQvz2an_ak-ReL9UT3oBMpFBdC_pFmQK3scfQ@mail.gmail.com>
In-Reply-To: <CAFd5g47AO64WMvQvz2an_ak-ReL9UT3oBMpFBdC_pFmQK3scfQ@mail.gmail.com>
From:   Uriel Guajardo <urielguajardo@google.com>
Date:   Thu, 13 Aug 2020 15:49:31 -0500
Message-ID: <CAG30EeeL9m7fcvZVj+6_d2v17e1P1vSSK6qBof2Gkvq7APp33w@mail.gmail.com>
Subject: Re: [PATCH 2/2] kunit: ubsan integration
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     Uriel Guajardo <urielguajardojr@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 10, 2020 at 3:43 PM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> On Thu, Aug 6, 2020 at 10:43 AM Uriel Guajardo
> <urielguajardojr@gmail.com> wrote:
> >
> > Integrates UBSAN into the KUnit testing framework. It fails KUnit tests
> > whenever it reports undefined behavior.
> >
> > Signed-off-by: Uriel Guajardo <urielguajardo@google.com>
>
> You should resend this to the UBSAN maintainers as well; they will
> need to sign off on this.
>
> In the future, make sure to run get_maintainers.pl

There are no listed UBSAN maintainers. Will instead resend to the
suggestions from get_maintainers.

>
> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
>
> > ---
> >  lib/ubsan.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/lib/ubsan.c b/lib/ubsan.c
> > index cb9af3f6b77e..1460e2c828c8 100644
> > --- a/lib/ubsan.c
> > +++ b/lib/ubsan.c
> > @@ -14,6 +14,7 @@
> >  #include <linux/types.h>
> >  #include <linux/sched.h>
> >  #include <linux/uaccess.h>
> > +#include <kunit/test.h>
> >
> >  #include "ubsan.h"
> >
> > @@ -137,6 +138,7 @@ static void ubsan_prologue(struct source_location *loc, const char *reason)
> >  {
> >         current->in_ubsan++;
> >
> > +       kunit_fail_current_test();
> >         pr_err("========================================"
> >                 "========================================\n");
> >         pr_err("UBSAN: %s in %s:%d:%d\n", reason, loc->file_name,
> > --
> > 2.28.0.163.g6104cc2f0b6-goog
> >
