Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C392C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 14:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 269EB206D5
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 14:45:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbgDTOps (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 10:45:48 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43862 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbgDTOpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 10:45:47 -0400
Received: by mail-ot1-f67.google.com with SMTP id g14so8286572otg.10;
        Mon, 20 Apr 2020 07:45:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aP14/hLIQEtKrRiPb3jxBvvF9Jrfe8E9/W9LdvCgbPk=;
        b=BKmifzH/0hmVw2mQBaOtz3Tft7uk/iA7M4vWyTfRYk6kERI6GoP21D24aScPWWbliB
         PhLqdec/rsWnXgDaD2xGjWKlkPP6R4JkbXeMq6VcZASGJWCupDQ+EiMkxsoQ5YQSiqgL
         JUhUkGCfsd7F0hMr8jnIfTlCepeNdW0U6Ok4QQ7c99ohP2Qd+sq41iEUjiqxR3UXYqDY
         ZV2161VNZJPTuycXp209JZhcozWmmz6AiY2th7GsdLdHvzWJiwgrDbtlH4g1KDObSLXj
         RzdbCXNZthLttriT4ot0dnt6bWqnh6mfv6uX3S8tm3G2IVu5cOOi+l14ymSDd1ShOJjb
         U01w==
X-Gm-Message-State: AGi0PubzQQcpXjMAc3vbdGosfmvhnAejZvS1zSPdFYEOTgiDvJUi8Vct
        QUI0bstRwy2pmUxwTGURaOuGk6lnrzp6/4VdoNI=
X-Google-Smtp-Source: APiQypIduQRGj+wrIUt89zm5p/icNmheSWQWaAYOzV+rB5jsX8bn3z9HLLXKUExd9BVA+QO5FehRvP7Gjqz+pwhJqZU=
X-Received: by 2002:a9d:7d85:: with SMTP id j5mr6993456otn.107.1587393946834;
 Mon, 20 Apr 2020 07:45:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200420123844.3998746-1-arnd@arndb.de> <20200420123844.3998746-2-arnd@arndb.de>
In-Reply-To: <20200420123844.3998746-2-arnd@arndb.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 20 Apr 2020 16:45:35 +0200
Message-ID: <CAMuHMdVpMP1NrXSO=4MJRpkXVgbuahvbZGVaAy3YJ2Oew9kGAQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] sh: remove unused sh5 files
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

On Mon, Apr 20, 2020 at 2:39 PM Arnd Bergmann <arnd@arndb.de> wrote:
> None of these files are used now that sh5 has been
> disabled, so they can be completely removed.

Thanks a lot!

> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

The following can be removed, too:
    arch/sh/boot/compressed/head_64.S
    arch/sh/mm/extable_64.c
    arch/sh/mm/tlbex_64.c
    arch/sh/mm/tlbflush_64.c

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
