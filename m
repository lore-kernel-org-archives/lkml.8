Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03483C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 14:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB6F9206D5
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 14:46:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbgDTOqa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 10:46:30 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:46484 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbgDTOq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 10:46:29 -0400
Received: by mail-oi1-f194.google.com with SMTP id q204so8917598oia.13;
        Mon, 20 Apr 2020 07:46:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fzYgOWwIlHvb2YgSTjbaMJ1vN0vIlzfEeZJNGUAav98=;
        b=F1b0VudSehIFfmOk8gyQP09KzbP9S8YbJYD/lBVrsm+puoH/SGfk87oT0W2jp00Gi2
         XkA1gzkyr+7WBhyYejUhF1Zau16yNKK/uWd43utsWVyZxdT3W+3r/DLoartjXiIn04WT
         4Jnr9pjcgsBktjQACta+fw6QfuK/huJIdUrIfQEn0FOATogGdSngknfFSDD6xILv2UB/
         JotFMQb0uSyTRuh1xIx20zdAFUQL8K+vGweAf4qr+ZvwB6MCCIreAJSazyvFWhMdZwSz
         xLCQu9LBVlGKO5WZgfPAwaFQFDw93bStsoBvjR43z+0QWS6uVTA462KDuN2fv1z7Oj+D
         dmFA==
X-Gm-Message-State: AGi0PuZaXTsQu/qr6MoQ2vgTb54sLyByj+6j8V8hvSOs9PnYzLTAiiwd
        rNMLoRzLFThQrGiBeCyuCXnEU6gq3L4C5SV14Jbd3rTy
X-Google-Smtp-Source: APiQypJaGnc7F2KFmiaogOJr2KbOageqPyhkYQLKbbHwPb3BkPy9RbZ7TF5nsiU4kFW2HhQZfmGp/92JsvD38MS17ag=
X-Received: by 2002:aca:f541:: with SMTP id t62mr10318360oih.148.1587393988425;
 Mon, 20 Apr 2020 07:46:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200420123844.3998746-1-arnd@arndb.de> <CAMuHMdUZR9A+nCYL_uUOJt48FQnJTJ9eMwWUuV-Z0UWJZ8SaSA@mail.gmail.com>
 <CAMuHMdUWZ9SG_x_tEctMUTDt754kOATDTJbem0Ai-94EO8c0ZA@mail.gmail.com>
In-Reply-To: <CAMuHMdUWZ9SG_x_tEctMUTDt754kOATDTJbem0Ai-94EO8c0ZA@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 20 Apr 2020 16:46:15 +0200
Message-ID: <CAMuHMdUJp4m-wifSgLXmRJ5Zqmsiw++VtkK7LY1FHhtnbrbGFg@mail.gmail.com>
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

On Mon, Apr 20, 2020 at 4:42 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Mon, Apr 20, 2020 at 4:40 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Mon, Apr 20, 2020 at 2:40 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > sh5 never became a product and has probably never really worked.
> > >
> > > Remove it by recursively deleting all associated Kconfig options
> > > and all corresponding files.

And all the remaining BITS stuff:

arch/sh/Makefile:BITS                   := 32
arch/sh/Makefile:export ld-bfd BITS
arch/sh/Makefile:head-y := arch/sh/kernel/head_$(BITS).o
arch/sh/boot/compressed/Makefile:                  head_$(BITS).o misc.o piggy.o
arch/sh/boot/compressed/Makefile:OBJECTS = $(obj)/head_$(BITS).o
$(obj)/misc.o $(obj)/cache.o
arch/sh/boot/compressed/Makefile:ifeq ($(BITS),64)
arch/sh/boot/compressed/Makefile:       lib1funcs-dir   := $(addsuffix
$(BITS), $(lib1funcs-dir))
arch/sh/mm/Makefile:mmu-$(CONFIG_MMU)   := extable_$(BITS).o fault.o
ioremap.o kmap.o \
arch/sh/mm/Makefile:                       pgtable.o tlbex_$(BITS).o
tlbflush_$(BITS).o

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
