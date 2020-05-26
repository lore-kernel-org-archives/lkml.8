Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE245C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 07:58:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87534208B6
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 07:58:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731721AbgEZH6d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 03:58:33 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:43081 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726971AbgEZH6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 03:58:32 -0400
Received: by mail-oi1-f195.google.com with SMTP id i22so17887254oik.10;
        Tue, 26 May 2020 00:58:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fFg5VInugckNYRSPB/5nIRNnLiledbeloAVGrfPRVwo=;
        b=hSpwME0Jvgp74EvN7EW0C8X9UQZRdAFT7kg9kl4M96AEOfkbXqkXhL7GAHoP69kQ4j
         2Fd0GTcSAQzM0RRWMlDLi1QPBWWsQ+8SMZ9h++0U02tmf3kkkrbQzcw58COvCfVlZBij
         XkH5T9cbo8mzCzL1RMagL5ink7VQbYL5mbB9RdHe3sZU0q8nJX2aJpOT+66D+avRmey+
         RHy6dinofB6hTIZimaKt+ECAaT0qtBVJG7v2UfwFQKC54wsO0YMT8iO2FIn8N9dd9eQM
         QuYgqNAnCA03NmWzV0+y7RnKWt26IgeL6k3oMV8qJw3y4FszIVTOvlSaIt7UKRoMvdJ1
         2BvA==
X-Gm-Message-State: AOAM5323OTmrwGIkjTsfi2lYXE2zlI+ZtTKLKXivrpLMcqOGs8ItRumK
        waQ86cH0IUGVj/SRgrv3lz7BrpO4B5/jUfv7iJE=
X-Google-Smtp-Source: ABdhPJxREYi5U3JmV9gwphb6VMEMF7Qq5pOiGcCkf+XNeuGntebapZGhN/8WTuy5s/pp0mLmYXoBpoVLF0Z7FGrn0a4=
X-Received: by 2002:a05:6808:1:: with SMTP id u1mr13638964oic.54.1590479911282;
 Tue, 26 May 2020 00:58:31 -0700 (PDT)
MIME-Version: 1.0
References: <1590420129-7531-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1590420129-7531-4-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <1590420129-7531-4-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 26 May 2020 09:58:20 +0200
Message-ID: <CAMuHMdXq3PseC-KxWgYenCr+fJ7CkseJeVsZ0vnCxPqhT7xaaA@mail.gmail.com>
Subject: Re: [PATCH 3/4] ARM: dts: r8a7742-iwg21d-q7: Enable Ethernet avb
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

On Mon, May 25, 2020 at 5:23 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Enable ethernet avb on iWave RZ/G1H carrier board.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v5.9.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
