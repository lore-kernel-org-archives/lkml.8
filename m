Return-Path: <SRS0=AKQz=7N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E4BC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 08:38:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2D9320707
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 08:38:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbgEaIiS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 04:38:18 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37485 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbgEaIiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 04:38:17 -0400
Received: by mail-ot1-f65.google.com with SMTP id x22so5521946otq.4
        for <linux-kernel@vger.kernel.org>; Sun, 31 May 2020 01:38:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=il8HCm7VOhnKzl1XMZoe2G47NdOZUu6wpsg1d44qw+4=;
        b=sH9/qj50i/rxbJhL7vP3IsRmEreDDYooh1TwBJ1pfDeaWXpqJbeybL3cfkFtHTVGKo
         PPMwnSlPuytHTuwklWLA8aXrAPNiHIS7wPf9WljjBs82yd7K18A422NVj/TWmVV2RwhS
         7OXyQBUtIVOKLqh1Op8Crctg25eMKCQxiyBrTzpp5voIs6DqsPfqFaNYk9bFgQI9sbib
         eweSdhqFfxWxbW4e+IwoYEpVGW2wktlPb2Ad1QF2aBVang7IoEzVfQTCkXeT89GgTXmp
         Y+Pil/tYYSyFL1AWRU5LJP/yZV5vEwCZDtIMrE0E3RUw3yA9p3M6N6MJjvZIbB0Q3ate
         5cug==
X-Gm-Message-State: AOAM532+qGo+QjXY1/P5vu9i+pHwOw9/7OW4zkFFxMTpf7InDZs/D+hl
        XZwudfe4CFTdw8p9+5F593OW39SBFgNAEAYS1T/j7Q==
X-Google-Smtp-Source: ABdhPJyWAqRS0RRmaKRioJgNyQk6X8M+vph3CUcrrUDm59u0OhqrcmYDrag8OKeZfYreJFeDK2DjPdxpkmXZicd+u5A=
X-Received: by 2002:a05:6830:141a:: with SMTP id v26mr716939otp.250.1590914295626;
 Sun, 31 May 2020 01:38:15 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1590880623.git.fthain@telegraphics.com.au> <0fb7fdcd99d7820bb27faf1f27f7f6f1923914ef.1590880623.git.fthain@telegraphics.com.au>
In-Reply-To: <0fb7fdcd99d7820bb27faf1f27f7f6f1923914ef.1590880623.git.fthain@telegraphics.com.au>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 31 May 2020 10:38:04 +0200
Message-ID: <CAMuHMdUjrFDob01EWC4e04tAkj5JTm_2Ei5WsPqN1eGDz=x3+Q@mail.gmail.com>
Subject: Re: [PATCH 8/8] macintosh/adb-iop: Implement SRQ autopolling
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Joshua Thompson <funaho@jurai.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Finn,

On Sun, May 31, 2020 at 1:20 AM Finn Thain <fthain@telegraphics.com.au> wrote:
> The adb_driver.autopoll method is needed during ADB bus scan and device
> address assignment. Implement this method so that the IOP's list of
> device addresses can be updated. When the list is empty, disable SRQ
> autopolling.
>
> Cc: Joshua Thompson <funaho@jurai.org>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Tested-by: Stan Johnson <userm57@yahoo.com>
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

Thanks for your patch!

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

>  arch/m68k/include/asm/adb_iop.h |  1 +
>  drivers/macintosh/adb-iop.c     | 32 ++++++++++++++++++++++++++------

As this header file is used by a single source file only, perhaps it should
just be absorbed by the latter?
Then you no longer need my Acked-by for future changes ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
