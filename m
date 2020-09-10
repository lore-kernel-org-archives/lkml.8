Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53004C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BD8D21D92
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:27:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728282AbgIJV1w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 17:27:52 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42952 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731065AbgIJOJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 10:09:47 -0400
Received: by mail-ot1-f67.google.com with SMTP id g10so5429198otq.9;
        Thu, 10 Sep 2020 07:06:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/JTzeYOL/MUZ0luIwiE6sB1J7IDRIRK13Ar1a9wfQGM=;
        b=ADAZL5aU0reK9wzydvINildKyiP25tbMkIkKvuMN62OMTC/g7POyN7mSYie06k/wC5
         p/BZyXjM3867TRaj0+S9KZ7jxk/dIUYuuq96frjGMfsDxfXmJZyNbBK5YsJWEO4DDmRt
         0K1woiTvI2n7u/eJJkdQ454VAqGrO2h1Uo6QSQgpS39F2c/B4IuBjAh8A5e6ujg1EsZi
         YOVKKwBdjwpCMo2Z9lkHbWYeoxSjWD+eHzp6Fs8imy7Dx+b/R2HRwRJn17FQ9qqzTBcP
         OsqwD8E3rm3lxH4epclQ0BhwiN/oFyACYLMoEe0j/rYmK2TqCkt1BtRNk2H6CKM6yl2S
         Y4FQ==
X-Gm-Message-State: AOAM532kVCChnQDVlO/ueXXBlnKS3UcffeXkd/+q90FYPFP9bVd3S4fT
        25SWhZvvZt+dT1a43PuHY1hHywBUIiNzCOm/4HoFU6W9
X-Google-Smtp-Source: ABdhPJzA8ekVNoPsDkNHeejFHRZriL9kziI6Qhs0VkHhQmXcp1PivgYbXh7+aNN+IChJD8Ai6bvaxJtyBepAoJpLn5A=
X-Received: by 2002:a9d:3b76:: with SMTP id z109mr4110588otb.250.1599746170203;
 Thu, 10 Sep 2020 06:56:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200907144509.8861-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20200907144509.8861-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20200907144509.8861-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 10 Sep 2020 15:55:59 +0200
Message-ID: <CAMuHMdUyRagPz-Fv+Z-30BbaxrZJkPzV=PSAUe4_GhGUozeYKg@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: dts: r8a7742: Add VIN DT nodes
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
> Add VIN[0123] instances found in the r8a7742 SoC.
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
