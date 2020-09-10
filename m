Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9B38C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 07:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7AEF2078E
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 07:12:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730430AbgIJHMd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 03:12:33 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40013 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729990AbgIJHKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 03:10:32 -0400
Received: by mail-ot1-f67.google.com with SMTP id e23so4518284otk.7;
        Thu, 10 Sep 2020 00:10:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bfcaWzDdv7oE1xRBeWrafJxuLxpPCJ95L1Zw2Z0Vkbw=;
        b=GaHQ23ilwPKCKQ/JjYVx4wPQJc6xxsqZ4o74NWGM6qTX9dPtQY1vwPNbT/hZa/rZNn
         sjKKfjciiqLeVUkOeSaj8GHNEes2zMvDai33U9Be+k/5DqALctYq+kQcJSEYSCTzrlFX
         nQq5iMDDqwVvkhfQ75P8lKVwWOQ8+QKfKYTK/mUvDrI2vC/fCZk1Gq820Sk+duWCl0+P
         4kWoNlYZshILwGB82jJBYFCm3VQZEeBQBI7c6ghK1saCIyBkk1bBa8GTTguF9V7JWgsY
         aYzTn26wuJLZf9Fvu6uCDMDOEVOaYlfaPVzH3u28TSQkocWVE/xZsc8ac/NdU/wM1MeE
         RkQg==
X-Gm-Message-State: AOAM532YcHDw3CBwuSRiTizph5hWjD96H1SaftUboL/OW077Sg7NNrc/
        uIAfpbbEp89GtvC9U3KI+rje3TZqqRx4rRFR57tZOKy9
X-Google-Smtp-Source: ABdhPJx6mowMcqvb9A2X5A93sUbQO+14kcxardEqgpqHGX52EfeHnRXM+J1DbzmRAv27mFbtUkj6mwqDXLrId4O3BaA=
X-Received: by 2002:a05:6830:1008:: with SMTP id a8mr2869064otp.107.1599721831996;
 Thu, 10 Sep 2020 00:10:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200907073214.13929-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20200907073214.13929-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 10 Sep 2020 09:10:21 +0200
Message-ID: <CAMuHMdXRHyXCEbnvCQZmT+rq+tN8i_y0eOZTFwBbb09yx3K1TA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: renesas: r8a774e1-hihope-rzg2h-ex: Enable sata
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Prabhakar <prabhakar.csengg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 7, 2020 at 9:32 AM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Enable sata interface on HiHope RZ/G2H board.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v5.10.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
