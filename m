Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDC32C433E6
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 09:34:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC5FF206E9
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 09:34:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730273AbgGOJeJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 05:34:09 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:37724 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728043AbgGOJeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 05:34:08 -0400
Received: by mail-oi1-f193.google.com with SMTP id 12so1729501oir.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 02:34:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EvU8f9uqtqhKQi1upBV6M7odRgHTJO0NIPiNBIO/iso=;
        b=WGSmOAK17cViYw49pHuVHA8/wJ62VUvDNk5LRf8MA+d0k++nmNRpHiL/ySlZ4p0u45
         XGPfjN/WnAkIdL2WxVBKoGRI3029EbU3cpGxh1BoRhbYp9kFiUGS6O3AukkGS3ybmGc3
         zVsqdMXmWvICUhPi1e4hNZZzeiw+asBipSEgQ9T37bB0l2TbGAQkiQyjraJaEhJIz/9/
         Lge5E/O+og5OC2aSPyHILJ0q9UFDfozdcatmRfruhzzhSTJhoPeApvmM6MppjEZxAL/R
         syJmjtnKrjnEcFVSvbarPwc2gCGC4hN2hDM7abSJLRoaEcH44DSjtjPN84Z7qLeCf5ol
         9/lA==
X-Gm-Message-State: AOAM5333Hrq88Es0RWZoV1O2jGRRDpGMzjEPfgVeNf024TQrhLeFU93e
        EvCgjZr7p2KG/zo9TkQN1w5FMT89JC1I8G00rjk=
X-Google-Smtp-Source: ABdhPJy9IvsxtdXlInbx2uqQJkVU+nPkqyYw7WEzAKfjGHtwKAFf4Tb1kkO8UbWyyEt9nm9bbZrbFwjGHDrSB0oKqCc=
X-Received: by 2002:aca:5c41:: with SMTP id q62mr6800166oib.148.1594805648341;
 Wed, 15 Jul 2020 02:34:08 -0700 (PDT)
MIME-Version: 1.0
References: <1594722055-9298-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1594722055-9298-3-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <1594722055-9298-3-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 15 Jul 2020 11:33:57 +0200
Message-ID: <CAMuHMdXOBVn1HAxN6yB+bv+VtBPs4F4dUwvPZHkLj6Sz7KmRDQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] iommu/ipmmu-vmsa: Add an entry for r8a77961 in soc_rcar_gen3[]
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 12:21 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Add an entry for r8a77961 in soc_rcar_gen3[] list so that we dont
> enable iommu unconditionally.
>
> Fixes: 17fe161816398 ("iommu/renesas: Add support for r8a77961")
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
