Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E090FC433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 12:56:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEF942072A
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 12:56:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728940AbgICM4v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 08:56:51 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:38988 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728928AbgICMpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 08:45:03 -0400
Received: by mail-oi1-f193.google.com with SMTP id r64so2965787oib.6;
        Thu, 03 Sep 2020 05:42:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ml+p0f4/lZUonascXc6jcxVxCdORbfnV0c6JRtVN0WI=;
        b=HqOcrBtX2WPaNk/2BW0lQhuIhp+AHrXY0aBuF/V1qESiMtiGtdlHdE7oooXg9/hOvr
         8+dEmiylwJ3ZU60c8NQC+UY0goW4TFFOX1gpWHAw243d+oCniLM3Wn2lHXxCGv30n5ZY
         GCBDG0kNsRGi72+CwBE7+BQnDP2vNJfQhHP/atdFo/3I5f3iWKp0DZ4rNd2lh6/hy8Yr
         yGwB54AkewSaDTOFAO4kL6MV2EvidQpfy/WrnacVhguLyNoM8spIbLWwz0imOKIFsSlK
         eE03s8ScBdwWmULfiWoSJC3qGgcsefhWXV6r4f6a873w+alPosvDOidNdBfgLIV/0nPJ
         tN3Q==
X-Gm-Message-State: AOAM531qoEXFvVePIxy3C01uwre+PNWOjAn1xK8BHln666M7Ljf5RVFm
        bsbO8asRW02j4Y5+MIgRKZYtE8zWnSt9MHHlVTk=
X-Google-Smtp-Source: ABdhPJwZcz/ujowdJByh5kbHpCBfa3Mpr/OPyUnuyyZK6ceNjumcCEmczP0uPpBwRxXaF/qOFQ+eA/665+uKpJ+OxTA=
X-Received: by 2002:aca:3402:: with SMTP id b2mr1797687oia.153.1599136958847;
 Thu, 03 Sep 2020 05:42:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200831180312.7453-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20200831180312.7453-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 3 Sep 2020 14:42:27 +0200
Message-ID: <CAMuHMdXWxYgAZx7bCET-U2S9KUo2tAT2gqKn3W5LTTtH-oRS0Q@mail.gmail.com>
Subject: Re: [PATCH v2] clk: renesas: r8a7742-cpg-mssr: Add clk entry for VSPR
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Prabhakar <prabhakar.csengg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 31, 2020 at 8:03 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Add clock entry 130 for VSPR (VSP for Resizing) module, so that this module
> can be used on R8A7742 (RZ/G1H) SoC.
>
> Alongside rename clock entry "vsp1-sy" to "vsps" (VSP Standard), so that
> VSP1 clock names are in sync.
>
> Note: The entry for VSPR clock was accidentally dropped from RZ/G manual
> when all the information related to RT were removed.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v1->v2
> * Alongside renamed "vsp1-sy" to "vsps"
> * Updated commit message

Thanks for the update!

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in clk-renesas-for-v5.10.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
