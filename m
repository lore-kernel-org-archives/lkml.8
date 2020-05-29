Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06317C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 14:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7D6E2072D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 14:37:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbgE2OhW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 10:37:22 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:47086 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726838AbgE2OhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 10:37:20 -0400
Received: by mail-ot1-f68.google.com with SMTP id g25so2039956otp.13;
        Fri, 29 May 2020 07:37:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jj4mzsZRsuulNyYkFaO1ypi6y1uFCcozwvQiDRIxL5g=;
        b=Z3036X0P1Du7BIsLa8sjZn3lc1hdGcXNxteyzhdcsMrC93ce0ZYZT+7LJEC07/4pxm
         O6V8f9nzNDbP7ggkc/LyvVMKc0LKlNE+P5R/B8QekEGEeYmfHaovZY8ubdCdMG4qvBtK
         ttbyzfDixpzjPAdgWrUOupqqzqKA/ji9HPasP7BOwnXpUvfjaudtBA6f8RGZ2mi1G41n
         FRsi794fYIPffKqGAJqNIadC05MV9/Hz1zGyAgv7xiIWseOeFF+sGD9kIRVrwA5i8H//
         npet4urc5FLPEJb6PzSttY3exalr0vji0LGpnwjdIDGGGPOfhWXlIYVfEc5/4jZZWCMy
         yevA==
X-Gm-Message-State: AOAM532XWlcHvI5X5xZXMkGW27ZjSA+k5yGx/HJvQ8D1u9MvPPT7WN8i
        6/jk403htdFazWa9tFWcoR/uwWgFzOEGeZbnvfI=
X-Google-Smtp-Source: ABdhPJw2pXqw5uoHxXylWsls/iOUECUt5BLseUa85DJo57fsATIt2sp7i3jvjAN/BW6n98bBGYolPwQBjnuy65KKT2o=
X-Received: by 2002:a9d:7e92:: with SMTP id m18mr6155020otp.145.1590763034829;
 Fri, 29 May 2020 07:37:14 -0700 (PDT)
MIME-Version: 1.0
References: <1590611013-26029-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1590611013-26029-4-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <1590611013-26029-4-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 29 May 2020 16:36:58 +0200
Message-ID: <CAMuHMdU888FN+gGdh6F_4z-kDKWuhaMrG-UokVhU4TS_S3JsLw@mail.gmail.com>
Subject: Re: [PATCH 3/3] ARM: dts: r8a7742-iwg21d-q7: Sound DMA support via
 DVC on DTS
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 10:24 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Enable sound with DMA support on carrier board.
>
> DMA transfer uses DVC
>
>      DMA               DMApp
> [MEM] -> [SRC] -> [DVC] -> [SSIU] -> [SSI]
>
>      DMA               DMApp
> [MEM] <- [DVC] <- [SRC] <- [SSIU] <- [SSI]
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>

To the best of my (limited) auto knowledge...
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v5.9.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
