Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ACF2C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CE2422CAE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:02:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbgHETB4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 15:01:56 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:45523 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728413AbgHES7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 14:59:45 -0400
Received: by mail-oi1-f193.google.com with SMTP id o21so19829167oie.12;
        Wed, 05 Aug 2020 11:59:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HPsV2zoZzYtOhvNoZSOkLk25C0ml14YDgasXK3+w6VE=;
        b=tMR/PBhMUHMguPTr5Gyr8IQgCY3BIOBiiNqdGaYmGoT5LpVNd3g1v1P97cEqhEQdcq
         cOOOus0vdNjBaqhXSHuwu8xKRBApxY5Au4PGlUhbP6g103nA8PahjfZXyYJzfo+bdgLW
         FOv9BfNf1GR7ZhcwJhOkRMqVfFwHVrYg3WAh7aXsDrlzv1dtwy58iPYsfYka3gyiRClP
         sHVQxTS5HTWYBjgdCZW0dIJNPlZghH/o9PmiWxqtbnRoMtYAIq0Wpu5e/LcXnaiameBf
         DtI9UdeH+8xpjPNGvUj9pw+z0amgDG3c1RVjxz0IAsl7jV9UCLneQ7iR33FmDnmuiGhw
         10uQ==
X-Gm-Message-State: AOAM532KV/Q06JuNoNZaCEIb08uEaK63VHbcU/6tWsF+yB4H43hQcS5w
        5+xDIXR6se5Zzby54ddz3wvwm9dd2iUM0UXHz2AdSg==
X-Google-Smtp-Source: ABdhPJyjRO4HSKl3hSDUVF5bSG5jZ4RKTOAV+ZERBUYtGBdE78D2y4bJ+423aczt1eKUP/YF0MvfgAOfOKarZ6B+Nu4=
X-Received: by 2002:aca:b742:: with SMTP id h63mr3779425oif.148.1596653455300;
 Wed, 05 Aug 2020 11:50:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a2PK_bC5=3wcWm43=y5xk-Dq5-fGPExJMnOrNfGfB1m1A@mail.gmail.com>
 <20200805172629.GA1040@bug>
In-Reply-To: <20200805172629.GA1040@bug>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 5 Aug 2020 20:50:43 +0200
Message-ID: <CAMuHMdV20tZSu5gGsjf8h334+0xr1f=N9NvOoxHQGq42GYsj4g@mail.gmail.com>
Subject: Re: [Ksummit-discuss] [TECH TOPIC] Planning code obsolescence
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ksummit <ksummit-discuss@lists.linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On Wed, Aug 5, 2020 at 7:26 PM Pavel Machek <pavel@ucw.cz> wrote:
> > I have submitted the below as a topic for the linux/arch/* MC that Mike
> > and I run, but I suppose it also makes sense to discuss it on the
> > ksummit-discuss mailing list (cross-posted to linux-arch and lkml) as well
> > even if we don't discuss it at the main ksummit track.
>
> > * Latest kernel in which it was known to have worked
>
> For some old hardware, I started collecting kernel version, .config and dmesg from
> successful boots. github.com/pavelmachek, click on "missy".

You mean your complete hardware collection doesn't boot v5.8? ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
