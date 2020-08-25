Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 618F0C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 13:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 396CC20639
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 13:22:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726570AbgHYNWB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 09:22:01 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:32932 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbgHYNVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 09:21:50 -0400
Received: by mail-ot1-f68.google.com with SMTP id t7so10340679otp.0;
        Tue, 25 Aug 2020 06:21:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DlSyZ7fMYZgHVXExxIJRY2RprZTRuT9I6yW6uVrsj98=;
        b=QqZ0zaQwxcC6O5ibiUZSpx3b6ryxO/EtKZ4s4OsjYESsIPEs3CXvfq1tnHGn6VDxHJ
         x3F3RwhXy/SgUO7QOQDNHRmxk1XvYyv06hZ+3TgDaSqzw6BHhM5mxw2o9UKGl4jrJrTW
         SCsxyH9wo0PJ4Y0ekYno3P/EjSnNQnx8rclOvtfOm82F6v6MHebosXw7WSrMHDiaJXXe
         dAxFUnL3yGNUEBCzOuh4gpVEGr9ptq18STD4uh7iI+9qyin0jsAFuPpHoleqzLi3WrT4
         QA5wTwV+QcSh12WgmYGD9emyqPuuVP0Ry5dKtmj8VCweCYVszT3Gl9jsQ8pyNJwON4lt
         W6Wg==
X-Gm-Message-State: AOAM532U2ejNdvMAoA001EAaxmvpIFxPjCZWAJfBsNRInWXLeSeroAw1
        VSl9PPfPS8o3195IrdyqYW3m7rxpYy8GdJNdioU=
X-Google-Smtp-Source: ABdhPJxCrYtK4zeIcWJudWDZNus4uDhmZJ7N4CYJHgcAKHlzXhAgVucRNkb7+cC81TIp/udAx8UzaPk8NL90p0wVKiE=
X-Received: by 2002:a9d:1b62:: with SMTP id l89mr6625987otl.145.1598361709295;
 Tue, 25 Aug 2020 06:21:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200825085435.8744-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20200825085435.8744-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 25 Aug 2020 15:21:38 +0200
Message-ID: <CAMuHMdX4JruJNX=Ezrrf_X_-WK0xy+MzYTvmbTnrLDFb1NCTYA@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: dts: r8a7742-iwg21m: Add SPI NOR support
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.or>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 25, 2020 at 10:54 AM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Add support for the SPI NOR device used to boot up the system
> to the System on Module DT.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
> ---
> Hi all,
>
> This patch is part of series [1], since rest of the patches have been
> acked I am just resending patch 3/3 from the series.
>
> [1] https://patchwork.kernel.org/project/linux-renesas-soc/list/?series=333197
>
> v1->v2
> * Dropped #address-cells/#size-cells from flash node.
> * Added partitions for flash node.

Thanks for the update!

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v5.10.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
