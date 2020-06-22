Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A3BC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 12:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1494A20732
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 12:56:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728319AbgFVM4Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 08:56:16 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39448 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728283AbgFVM4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 08:56:15 -0400
Received: by mail-ot1-f66.google.com with SMTP id g5so12927783otg.6;
        Mon, 22 Jun 2020 05:56:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W2/npDxslABzMP+lsb+TRWa+dPeA+OuRjrH8pGzwIiI=;
        b=GgnhsEH7/CIa7IGoqltfqAvZ2bsGBz99E9CTupnxePHXv5kZ3C6TTp6gLbJXqYpxk7
         W2N9KUPzEy8oaTHppFTlnIqyXQrHHp/+b12cKCLpfC2Z73vJH+pnTHeSRCyurJXBkth3
         Th28Oba5nLQ7V2rz6+nXKpgorZNwvA80+FP3w/2ihPzOYK95b8y5/cIa+1K7HY+xNGt2
         ZFqMQpV9dE9pLLV0mfiCWT0wIcxjvAr20OKZDl9iEkB0Jekvntc4G+yOIzfTk/F/voKT
         8/fiR6WwW/SGTJfxuijWuzuKuu5dZbj+paIVoH0/lkZjY78nXqfC4PjmVc7ny7IVss2u
         2agg==
X-Gm-Message-State: AOAM530dXblQbqxSOy2R2jmfCER6PtDTpEyJKXbhq9gI6AOirPL4lnxU
        9sBkJ3VH6sYT34q482IX96iFCuLyK6tejYZosHQ=
X-Google-Smtp-Source: ABdhPJya3auRFmW6YCkZmii0NzzBrvm6evQV/FVJT+gX0rpfa+HZT8aH/NONbRcr5BEerjb+V0oIfxYMQdHgTfZ4vBY=
X-Received: by 2002:a9d:62c2:: with SMTP id z2mr13480632otk.145.1592830574988;
 Mon, 22 Jun 2020 05:56:14 -0700 (PDT)
MIME-Version: 1.0
References: <1591555267-21822-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1591555267-21822-11-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <1591555267-21822-11-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 22 Jun 2020 14:56:03 +0200
Message-ID: <CAMuHMdUyfv7jQ=kmWRy-zehrgLhE=5=8Pg50seAqnTWV3yKziA@mail.gmail.com>
Subject: Re: [PATCH 11/11] arm64: dts: renesas: Add HiHope RZ/G2N
 Rev2.0/3.0/4.0 board with idk-1110wr display
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

Hi Prabhakar,

On Sun, Jun 7, 2020 at 8:42 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> The HiHope RZ/G2N variants are advertised as compatible with panel
> idk-1110wr from Advantech, however the panel isn't sold alongside the
> board. New dts's, enabling the lvds node to get the panel to work with
> all the HiHope RZ/G2N variants.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/arch/arm64/boot/dts/renesas/Makefile
> +++ b/arch/arm64/boot/dts/renesas/Makefile
> @@ -9,6 +9,8 @@ dtb-$(CONFIG_ARCH_R8A774B1) += r8a774b1-hihope-rzg2n.dtb \
>                                r8a774b1-hihope-rzg2n-rev2.dtb
>  dtb-$(CONFIG_ARCH_R8A774B1) += r8a774b1-hihope-rzg2n-ex.dtb \
>                                r8a774b1-hihope-rzg2n-rev2-ex.dtb
> +dtb-$(CONFIG_ARCH_R8A774B1) += r8a774b1-hihope-rzg2n-ex-idk-1110wr.dtb \
> +                              r8a774b1-hihope-rzg2n-rev2-ex-idk-1110wr.dtb
>  dtb-$(CONFIG_ARCH_R8A774C0) += r8a774c0-cat874.dtb r8a774c0-ek874.dtb \
>                                r8a774c0-ek874-idk-2121wr.dtb \
>                                r8a774c0-ek874-mipi-2.1.dtb

BTW, the grouping may be more obvious if there would be only a single
"dtb-$(CONFIG_<FOO>)" for each value of <FOO>.
But as that is a pre-existing issue, perhaps I'll just fix all of them
after applying
(the next revision of) this series.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
