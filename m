Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 474D0C33CB1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 16:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B46D24656
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 16:27:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B/+xH4/E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729162AbgAOQ1I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 11:27:08 -0500
Received: from mail-oi1-f178.google.com ([209.85.167.178]:38210 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbgAOQ1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 11:27:07 -0500
Received: by mail-oi1-f178.google.com with SMTP id l9so15927386oii.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 08:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J/jN6ywbZWrd/e8wYUMEIXDZGBzSANaQq7yRDAP83uc=;
        b=B/+xH4/Eyp1dZWuwN1qXlcnEbTiaIUXw/zmnO4Y6MoV4k/4b2iNTvNyaZhqAM4CGtq
         fHJeB+YOuhn5WfoFBtoRru9xTPQ4PajJiJnSKedbVonXe95HUhzEDuqWwhOaoOgn81iM
         LHecuREADg4u5m7mmnxYjFqU6qv+PQb8lOeFEhBPuBEfQicxP66s9nx84LROlbjNswRa
         OG3z6Z+Pm4p/eVq6bLaqSf4Nkok7ohkH9mmGEHduPOLkd+QDnK1i54BEQg8Nond9vTcF
         ZBPasnleuQA3UsLlu2TgysfoVVYD5jzO2gbt0PKpty8q+NjriD3JDjX7IOxf+RYUYVQi
         aC5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J/jN6ywbZWrd/e8wYUMEIXDZGBzSANaQq7yRDAP83uc=;
        b=USumyuHrwnfIt8G21YwtElcosqPHwt/qvHVRIztFxBsjmDWZLXe6rBry6bJ87BmrFV
         v04R8Cz++E/go12exh3/Sjj1B7gP058UuwmoJUBz2GL24kebQ+lGYRm1egFfDUITkBqi
         7RcdEj1M5AUjkNLISs7muxV/jgVfWmiLy8C/uGAsphMvqtSJIRd6ETeqk9qARhVYngw5
         uBcVg8RLR5VUK5id1IAnp/LvoEMC/ox2hUIH3v/Bg22jm9uc61F1eSWFuB1U/zCe/rHh
         6NYkRYh92NikWejbuvNyWi1wfZoEfOg6wtbEzCxCJabMI7Y8O75JuXUJGXfmMqCfgeK4
         gsCw==
X-Gm-Message-State: APjAAAXSoaJcLDaG0lH0xRlJciuO7ArT1NG4EoZPR8sPyJV6GzGxw6Qm
        TLQptupgTyY+aE411G/wwVrWvOGgFbVyndkuLioLVw==
X-Google-Smtp-Source: APXvYqzR8LTgGm365RkfsuoKvbZoY28BmfWLpQCIRElF/Ak1oay/+JhQpn/p6sl0OfHOxyt/vnuBT0ybBwrsH+DkgCw=
X-Received: by 2002:aca:36c1:: with SMTP id d184mr501516oia.70.1579105626648;
 Wed, 15 Jan 2020 08:27:06 -0800 (PST)
MIME-Version: 1.0
References: <20200114124919.11891-1-elver@google.com> <CAG_fn=X1rFGd1gfML3D5=uiLKTmMbPUm0UD6D0+bg+_hJtQMqA@mail.gmail.com>
In-Reply-To: <CAG_fn=X1rFGd1gfML3D5=uiLKTmMbPUm0UD6D0+bg+_hJtQMqA@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 15 Jan 2020 17:26:55 +0100
Message-ID: <CANpmjNP6+NTr7_rkNPVDbczst5vutW2K6FXXqkqFg6GGbQC31Q@mail.gmail.com>
Subject: Re: [PATCH -rcu] kcsan: Make KCSAN compatible with lockdep
To:     Alexander Potapenko <glider@google.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Qian Cai <cai@lca.pw>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Jan 2020 at 18:24, Alexander Potapenko <glider@google.com> wrote:
>
> > --- a/kernel/kcsan/core.c
> > +++ b/kernel/kcsan/core.c
> > @@ -337,7 +337,7 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
> >          *      detection point of view) to simply disable preemptions to ensure
> >          *      as many tasks as possible run on other CPUs.
> >          */
> > -       local_irq_save(irq_flags);
> > +       raw_local_irq_save(irq_flags);
>
> Please reflect the need to use raw_local_irq_save() in the comment.
>
> >
> >         watchpoint = insert_watchpoint((unsigned long)ptr, size, is_write);
> >         if (watchpoint == NULL) {
> > @@ -429,7 +429,7 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
> >
> >         kcsan_counter_dec(KCSAN_COUNTER_USED_WATCHPOINTS);
> >  out_unlock:
> > -       local_irq_restore(irq_flags);
> > +       raw_local_irq_restore(irq_flags);
>
> Ditto

Done. v2: http://lkml.kernel.org/r/20200115162512.70807-1-elver@google.com

Thanks,
-- Marco
