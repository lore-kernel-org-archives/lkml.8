Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED735C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 12:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D338C2071A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 12:30:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbgFVMaM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 08:30:12 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:44491 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728096AbgFVMaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 08:30:11 -0400
Received: by mail-oi1-f194.google.com with SMTP id x202so15447217oix.11;
        Mon, 22 Jun 2020 05:30:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wUf2mgqzANpf58KfTkdrvQevUYdxCsq8Gy2S0qYPluE=;
        b=XA6lMltiwyuj74ldP2cyqJIPMzY72M9/U6C5m7VaUuQS2POY/SBwQvUYyRqeK71d1a
         b/O+3+blJicLkoc5UPqfaSioh7oWgVfDWsTJDZMnzQ9lNFKjSskvJsUct5GDVDbv8R0d
         Qf8U1SGVlDoduuNcSffoqxp8u3Q5dxVhShrEsYOhpNqteQo6q39nY+tlmla+BRqY8mxn
         umXBIKZgoPdyXjo9LcDXxfJ7ttOeBtobcAJOnIAc8ql9HB1DxIgmhQfy5zBRzYitpBwL
         BTCTVEzrR0hhJD7rQvTF8nOWARQO54Y7CoTgDRfJxL/obXxOQh0cg/Yv/H7qrJOUjp7n
         Pv+A==
X-Gm-Message-State: AOAM531syVYDfOniVTYCUUUT541yfnjdiJ4SHXKoOX3UYvbX9KQr3TfW
        rgutWFnvkuJYZ37DQ1A0+Q5nIKM9g/zrFHhJm60=
X-Google-Smtp-Source: ABdhPJxlQo1tJrJJVaafpm79N7qRXn2WYE8WaGELUD+n01IZGPz7ANHXWS3syVTv3yGjIDor8rlhUuJPHyHEuMK4U8w=
X-Received: by 2002:aca:849:: with SMTP id 70mr11777168oii.153.1592829010830;
 Mon, 22 Jun 2020 05:30:10 -0700 (PDT)
MIME-Version: 1.0
References: <1591555267-21822-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1591555267-21822-4-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <1591555267-21822-4-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 22 Jun 2020 14:29:59 +0200
Message-ID: <CAMuHMdXTMUwdPVVMq2jyYy4nphu0nNsaN9xTFtuOvkncn77UvA@mail.gmail.com>
Subject: Re: [PATCH 04/11] arm64: dts: renesas: Add HiHope RZ/G2M[N]
 Rev.3.0/4.0 specific into common file
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
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

Hi Prabhakar,

On Sun, Jun 7, 2020 at 8:41 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Rev.3.0 and Rev.4.0 are identical and can be identified by using GP5_19
> and GP5_21.
>
>         Rev             GP5_19  GP5_21
>         ==============================
>         Rev.3.0         0       0
>         Rev.4.0         0       1
>
> This patch creates hihope-common-rev4.dtsi file with
> Rev.3.0/4.0 specific changes for HopeRun HiHope RZ/G2M[N] boards.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
