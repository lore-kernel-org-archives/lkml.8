Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 847EEC43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 14:56:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B9B9215A4
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 14:56:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730071AbgIGO4Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 10:56:24 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:45997 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729661AbgIGOrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 10:47:48 -0400
Received: by mail-oi1-f195.google.com with SMTP id d189so13744969oig.12;
        Mon, 07 Sep 2020 07:47:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QcjiiAfx+9k9N5nfOR2G/TrS6pvq+Cvo4vzFD0ysl/k=;
        b=MwaqAuEEw7q/sR6nExBQUc3HwYHaFcnMhsS25KrKyII/cMr7jCU5liMJKQ6/Xg8wFI
         3/DS7SnwX92vHlNzsft69T27eYmivyjNtiUksW0C/7N3XCjfCOuRpa1g806FMzi+wgvT
         HQCaV22/q1vKBdNQfZe23a0tGiiTw2YGQ9xrJpydwWgdKc/tlQYsYZxyQBCqPZLQrkss
         mhc3PA1G4AblJqXuYNQJ0viP7MQtqUsfb5P1DxE7/AuLrfJ59wP+PVpQU9pB2GNm0HmL
         fijpd6bkB3yHSSfvc7QfhkKzKD/6TGLBRMrCJ8LHgTynmhSbUH3dyFKnmqIta5/x0s2M
         fr1A==
X-Gm-Message-State: AOAM531aqJnKRRkNeaHsnZvvW1fIirVRwbb+vwlZyoucNit0QqBJUB2E
        3tCk1iGewaSPodUmYwDJ667HloQCJDipNSJA2bQ=
X-Google-Smtp-Source: ABdhPJyY+mdyDZV49zKGIPNu9C6xRs+fpbm9lxoTKNZqCdCFCV/vcvj1uvGnRbxs8d7YoKMermrp1Bu/17LgaaygxOw=
X-Received: by 2002:aca:52d6:: with SMTP id g205mr12624421oib.54.1599490065211;
 Mon, 07 Sep 2020 07:47:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200907144509.8861-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20200907144509.8861-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20200907144509.8861-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 7 Sep 2020 16:47:34 +0200
Message-ID: <CAMuHMdWGG+7dnrKxeA3S_g01jk3fSO_n2uP1-r0R279VF5TVcQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: media: renesas,vin: Add device tree
 support for r8a7742
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
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

On Mon, Sep 7, 2020 at 4:46 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Add compatible string for r8a7742. No driver change is needed as
> "renesas,rcar-gen2-vin" will activate the right code.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
