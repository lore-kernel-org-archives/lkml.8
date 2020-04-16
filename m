Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F4EEC2BB85
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 09:27:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5626206E9
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 09:27:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ug54GZiq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392180AbgDPJ16 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 05:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2392063AbgDPJ1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 05:27:51 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC74C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 02:27:50 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id k21so2529332otl.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 02:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cZyNZ/PomFpedyOsDDa7ffLGcZMQ7O0BTntcLMz/kdI=;
        b=Ug54GZiqLCZNF1AZgHx9DWEXBYW4tYFy1zr4hBZgAfstt/GYWDUs47wBklzo+23+t9
         YmJnbAXg3WprGHCkIHEuVKvkwWlMcOVfdp5nhomCpAghySge7K0p9tSUXoHaiHrFaUDS
         6LUoS0NA1VVy03IXqcwJy1FQiCyoacIF88eC2KAmrONcZUgaL0czwpNVPEWjBLcGd6RG
         IW5LOFZva6W/aaz69R3Af3Zjj9vpXgse3Os37aVsJS9QTh/JCL89nx4IjTrmC1IYpbzN
         uPeNyIPbRLogasFjum3DuNvw1aAHieSYrF0q/4Zco0rCFcgXpEHDnEjL3qAHC7lGCQXB
         ZmqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cZyNZ/PomFpedyOsDDa7ffLGcZMQ7O0BTntcLMz/kdI=;
        b=pyRBO1vw5y0AJ5OJT8wtCUa2GGVAgvRzE9OgsqKRjHmf+mx/CNjFVBf66eULpk5qLZ
         HLfda1LbixaxFkFb7ODtL2r+v9YyT8ix8FronCHd4YzbRP830L3bYkGfVL7S/+Aj7sKp
         l9e2vKCzi0wpYE50R3qx4ZtBqPUYM+NaFro10vVJYa/VKCK6im8LlGaLtUyNbXAe4sBf
         OZ0wzFfmsLcw+NIyjm+305CmLm+fSu6e0Qm2clqamwUzi/xW6JMRuzXcIq3IG47ScYsC
         q0lKrVOBsLcmRWY6w/f9Ro0Ms4ZyDPXpDNlLycTMd8YEybyCuM0TgmCL9HnwEaGf/1Cl
         mVIQ==
X-Gm-Message-State: AGi0PuYRljwCH5T6cvymA8vwffSxqe+FLW3vZgXZuNA940J8MB/k72CJ
        oZkL4dS603+sLNtfJMOs4V6xKRmtA0HorBnmxWzoXw==
X-Google-Smtp-Source: APiQypIHbHNvQL/JlVxmqXgUhr8PsOpNX/QEyz/TKaO2G/fMjv9IYaoRYLfVebjbSHhQkxDbHoMtIB4y94qcuZRWnrw=
X-Received: by 2002:a9d:509:: with SMTP id 9mr14157880otw.17.1587029270015;
 Thu, 16 Apr 2020 02:27:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200401101714.44781-1-elver@google.com> <9de4fb8fa1223fc61d6d8d8c41066eea3963c12e.camel@perches.com>
In-Reply-To: <9de4fb8fa1223fc61d6d8d8c41066eea3963c12e.camel@perches.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 16 Apr 2020 11:27:38 +0200
Message-ID: <CANpmjNOSo2WqquKJwePdsA1VXS2V94DQZ=RVY9bULbVwGPx1RA@mail.gmail.com>
Subject: Re: [PATCH] checkpatch: Warn about data_race() without comment
To:     Joe Perches <joe@perches.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>, apw@canonical.com,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Apr 2020 at 17:19, Joe Perches <joe@perches.com> wrote:
>
> On Wed, 2020-04-01 at 12:17 +0200, Marco Elver wrote:
> > Warn about applications of data_race() without a comment, to encourage
> > documenting the reasoning behind why it was deemed safe.
> []
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> []
> > @@ -5833,6 +5833,14 @@ sub process {
> >                       }
> >               }
> >
> > +# check for data_race without a comment.
> > +             if ($line =~ /\bdata_race\s*\(/) {
> > +                     if (!ctx_has_comment($first_line, $linenr)) {
> > +                             WARN("DATA_RACE",
> > +                                  "data_race without comment\n" . $herecurr);
> > +                     }
> > +             }
> > +
> >  # check for smp_read_barrier_depends and read_barrier_depends
> >               if (!$file && $line =~ /\b(smp_|)read_barrier_depends\s*\(/) {
> >                       WARN("READ_BARRIER_DEPENDS",

Do we still want to do this? Which tree can pick this up? Or was there
anything left that we missed?

> Sensible enough but it looks like ctx_has_comment should
> be updated to allow c99 comments too, but that should be
> a separate change from this patch.

AFAIK the C99 comment patch is in -mm now.

> Otherwise, this style emits a message:
>
> WARNING: data_race without comment
> #135: FILE: kernel/rcu/tasks.h:135:
> +       int i = data_race(rtp->gp_state); // Let KCSAN detect update races
>

Thanks,
-- Marco
