Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8BE3C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 07:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C112A206D7
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 07:15:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728516AbgFOHPc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 03:15:32 -0400
Received: from mail-oo1-f66.google.com ([209.85.161.66]:33031 "EHLO
        mail-oo1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728285AbgFOHPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 03:15:32 -0400
Received: by mail-oo1-f66.google.com with SMTP id v1so3166124ooh.0;
        Mon, 15 Jun 2020 00:15:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c129osLBvwj36wCwYdAa3u6Nb4ia1CPxwVpn8wkhC50=;
        b=RKj1gFo8aqogHupeFPN2APPeaNcq8edYsQEXPpPwIUCmy5P6jdd4NJ8LaryBYgLDpM
         DX8wODc/0RplNf3Wfzlb8hQuSc8fapZZkTmr/2/ssSWrmpB0VWhuQfuPppj2wRFFLvGM
         vxU/g1HXIoDpjvPjgvqpIs0pNIjmHW3JYel64HawFxmarfO3KtIwSqLfQ7oeaJoLuMkd
         bQNZp/pn3tht5qWkBpf+WaM7sJPMta5JlXGcnV35c9MfWQ+Pv1mZRozrRhwa/yQ6JFTx
         hFNqAlvb2ikoGtjksh52kAuUnw8qFkQHol2D7qGujm7hj3C8zJ/O/+ldPc8fgzSyY877
         yoqw==
X-Gm-Message-State: AOAM5315l1IBGIfDw9/PXO7jt2FcugT1vP/qE0nw7lQVa/k54pbGLusR
        rmfBaNOiLtkeulpYJBm4HbCcYdzK1ngaqQBBinkopA==
X-Google-Smtp-Source: ABdhPJzkjT3l+mR1TBMdNeEm8reXfsDFfhZUDdjZbcl2X7SCYURc62B/Es1CKceEXtrPOMKUWEn10qFiRujDo6SySMU=
X-Received: by 2002:a4a:b804:: with SMTP id g4mr19317941oop.40.1592205330184;
 Mon, 15 Jun 2020 00:15:30 -0700 (PDT)
MIME-Version: 1.0
References: <71e1f336-ef5c-f5e9-25cf-16bd4439b9f9@infradead.org>
In-Reply-To: <71e1f336-ef5c-f5e9-25cf-16bd4439b9f9@infradead.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 15 Jun 2020 09:15:19 +0200
Message-ID: <CAMuHMdUNtBcd-q0skJVxz2TcJAJTZfEEVtnSPPLgBtmTAqkSfQ@mail.gmail.com>
Subject: Re: [PATCH] Documentation: remove SH-5 index entries
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Rich Felker <dalias@libc.org>, Christoph Hellwig <hch@lst.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 4:59 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
>
> Remove SH-5 documentation index entries following the removal
> of SH-5 source code.
>
> Error: Cannot open file ../arch/sh/mm/tlb-sh5.c
> Error: Cannot open file ../arch/sh/mm/tlb-sh5.c
> Error: Cannot open file ../arch/sh/include/asm/tlb_64.h
> Error: Cannot open file ../arch/sh/include/asm/tlb_64.h
>
> Fixes: 3b69e8b45711 ("Merge tag 'sh-for-5.8' of git://git.libc.org/linux-sh")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
