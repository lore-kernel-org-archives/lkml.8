Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41AD1C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 13:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1375620734
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 13:10:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Nvyzw1f2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbgFINKn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 09:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbgFINK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 09:10:29 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C167FC05BD1E
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 06:10:28 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id n24so22310909ejd.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 06:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WTT7IKjpcsE5Mp5edVXpMG+kNpU/LPg9ObpL4+ooCUI=;
        b=Nvyzw1f2MKdAhdIkiS5X8YSaMyO2WhkjwA8TWvObxQ0WRdRvsw3Q4pEJztanXrmWN3
         VQobsCiOYWm/7HgQr2De0iXxmRcr6tuvD5LhUpRN+7fJ5HE+HW5UbZ7L8hPcbG6rRlRB
         ThmJ58n71EDlVsqmXb8E18t4blmgb6CpF8P+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WTT7IKjpcsE5Mp5edVXpMG+kNpU/LPg9ObpL4+ooCUI=;
        b=GCci2LvHFrObGr37hgiJa95+3x4n3ELkqA5zU1Jj1naAqd+tardpOfRGkYr9HCtMn/
         IU2i44I7Tw6u+w9lVJPt4+cgFxXG6ai94pAGoTwcRlJ5clXZcjGaDMYRfjhHUr/B15eJ
         QexUqQ3H63ny3yrHshTRNjj/42Gj6gB4l7eyeyUQaIyW3LckcsVzhWIr0YNotzrfUTaj
         KpcGz4n3OxXrhFwFAzgkef46zNHWXKJATIHFVo6OkAsG4QcF04KmRxPxqU1c1vxtJqzt
         gW3C7R6jDxkfW3wJK4FfManNjVg5tBzXvRVBoXpqasJGf5QqFA4EHlIYZFx3b0f5tvqd
         Hf0w==
X-Gm-Message-State: AOAM533gPRiiF+QExBxYKDDnLyoDuz2hAeT7GeymfCB7PG13NF9rv9nP
        /eO+5I8MHiktI/q8zdZMJX0FYvAHai4w85/2EcjvjY9VWCt4mw==
X-Google-Smtp-Source: ABdhPJzolqp64VJFj8WV1rL0fsdfm30ZHAXUsoX2GUGlYVaIFV6P3q54p95W6c8+qtWTBNfOWBCxtH52fAxNUllUqPg=
X-Received: by 2002:a17:906:4310:: with SMTP id j16mr24334724ejm.511.1591708226713;
 Tue, 09 Jun 2020 06:10:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200606215114.380723277@linutronix.de>
In-Reply-To: <20200606215114.380723277@linutronix.de>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 9 Jun 2020 15:10:15 +0200
Message-ID: <CAJfpegtgQZvjjapsgQsG6AGGmNsHoGaczVc9=nw941a4-atmGw@mail.gmail.com>
Subject: Re: [patch 0/3] vdso: Unbreak VDSO with PV and HyperV clocksources
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 7, 2020 at 11:36 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Miklos reported [1] that the recent VDSO changes broke paravirt clocksource
> based VDSO in the case that the clocksource is invalidated by the
> hypervisor which happens after a suspend/resume cycle of the host.
>
> The result is a stale clocksource which is about 2200 seconds ahead of the
> actual time and jumps forward by 2200 seconds once 2200 seconds have
> elapsed.
>
> The reason for this is the core code change which optimized the VDSO
> clocksource validation by checking for the clocksource mode instead of
> using the rather subtle check for the clocksource read return value whether
> it has bit 63 set.
>
> For some reason my brain blanked when doing that change, even if I should
> have known better.
>
> The following series restores the previous behaviour but preserves the
> initially intended optimization for architectures which don't need that PV
> handling.

Thanks for fixing.

Tested-by: Miklos Szeredi <mszeredi@redhat.com>

Miklos
