Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78CF4C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 14:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 526A020775
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 14:42:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbgDTOmq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 10:42:46 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:35492 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbgDTOmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 10:42:45 -0400
Received: by mail-ot1-f66.google.com with SMTP id e20so8306941otl.2;
        Mon, 20 Apr 2020 07:42:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/0iPR1O3qunbIhZVQ4co+p81u1gdnBbCUAcTKszG3gQ=;
        b=S7CWDe32yK2gUxYmCEC7wpzlK9bwOKfblkwswhUxzmlI+ww+gja/SXeir47SkNQG08
         n5ZmC/bxclqmhdBajvCowPAbqVnpBD/qiLCSM9sgtxKSlJyzJydyUi40tZs+Bxo9FB2r
         sdkvmcjZZ50y6TRU5SOKdyCrK7JCNmKbzWAqclfNgBENZ9Wj1MMh0yqM9RNC8h7vhIp3
         Sbl+riuYnD5B8M+pnulveoBX2NUIPbZ4fkF86rstyk0Dvp8FYAIH+U5+cFxmkaL/rDh0
         0Tvr6ejyTEvxOQcTyiDuSKhC8YT3NbzBr0yPJF4co/MV91tFXdPehsyE+56kwYUwk+mj
         T0Pg==
X-Gm-Message-State: AGi0PuaDSVth7U6waw6NJ1DyEFiAZkLetIu5RKUbxPPEQdvtyWAygtT5
        /zsYjKiSv0nYqUNxIklj0GwBYMk7mlKcNdF7xWs=
X-Google-Smtp-Source: APiQypJVZhEWlt61sSw6aMlHMo7uq4tg6FD+GTCFw6LUo5Dk0IkGTpzkprVW9qCB/iAUZbr73lbcHAWqiO3zQJBTGVU=
X-Received: by 2002:a9d:7d85:: with SMTP id j5mr6982682otn.107.1587393763564;
 Mon, 20 Apr 2020 07:42:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200420123844.3998746-1-arnd@arndb.de> <CAMuHMdUZR9A+nCYL_uUOJt48FQnJTJ9eMwWUuV-Z0UWJZ8SaSA@mail.gmail.com>
In-Reply-To: <CAMuHMdUZR9A+nCYL_uUOJt48FQnJTJ9eMwWUuV-Z0UWJZ8SaSA@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 20 Apr 2020 16:42:32 +0200
Message-ID: <CAMuHMdUWZ9SG_x_tEctMUTDt754kOATDTJbem0Ai-94EO8c0ZA@mail.gmail.com>
Subject: Re: [PATCH 1/2] sh: remove sh5 support
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linux-sh list <linux-sh@vger.kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Magnus Damm <magnus.damm@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Mon, Apr 20, 2020 at 4:40 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Mon, Apr 20, 2020 at 2:40 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > sh5 never became a product and has probably never really worked.
> >
> > Remove it by recursively deleting all associated Kconfig options
> > and all corresponding files.
>
> Thanks a lot!
>
> > For review purposes, this leaves out the files that can now be
> > removed, in particular
> >
> >  arch/sh/drivers/pci/*-sh5.c
> >  arch/sh/include/asm/*_64.h
> >  arch/sh/include/uapi/asm/*_64.h
> >  arch/sh/include/cpu-sh5/*
> >  arch/sh/kernel/cpu/sh5/*
> >  arch/sh/lib64/*
> >  arch/sh/mm/*-sh5.c
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> A few nits below...

And you forgot to remove the tlbex_64 stuff from arch/sh/mm/Makefile.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
