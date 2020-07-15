Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F908C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 09:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C864206D5
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 09:33:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730571AbgGOJdT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 05:33:19 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42928 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726988AbgGOJdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 05:33:19 -0400
Received: by mail-ot1-f67.google.com with SMTP id g37so943762otb.9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 02:33:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2zSBza/A2TbTL8HuxHQLfop5BTTpNoqMx+x88U5xSCg=;
        b=V4vV9/ZlZ6vGQk1y6KFh+whw9J9EAhSHVn2S5su/kkHIfB2iuhXMqT/4A4gT6nyhKu
         KBJfOaonaba9oSepYH8mS3tvRz7kCp1MZ/fU2crHscw3WXFGGLkhECJyymzBFoW72INZ
         vBosBB4egGhX6yCpCGOvYAZ1G7u352IY+O4dUhlg1gy/3p8cxFmw/wuVjzSgdnwrIidk
         mEIPprQm33WtLXMUedSX+tllzXL9v6cdnbGTZB0/bRPRJziYKp0/EsTVhlfUzIyZaJcf
         qTOa0UdJcBbyVZIDuSe9B3kpFtvv2qJK3OBQPNMzNupjWhymPdamxjJRm62ED/AYIroL
         EQqQ==
X-Gm-Message-State: AOAM533RDjSMKYTCBglCh2QUW0IUFsxbETsTswZy9DcWyQVCRxQI7eNZ
        7sNDpR5ggucbZqavduSxmfjS15xfgP7XSD2Pwog=
X-Google-Smtp-Source: ABdhPJzzj1yYj1U/ZCf95+Q2ORWnAZ+lygEjLDT7captY+3H5kw2r+KzelfwvLYQjScnf26pKt+qpkoPFsnNPuoqAI4=
X-Received: by 2002:a9d:2646:: with SMTP id a64mr7514251otb.107.1594805598066;
 Wed, 15 Jul 2020 02:33:18 -0700 (PDT)
MIME-Version: 1.0
References: <1594722055-9298-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1594722055-9298-2-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <1594722055-9298-2-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 15 Jul 2020 11:33:07 +0200
Message-ID: <CAMuHMdWOgYkWNj0UTUvqi_8O5tKf6NOc61RpEyNWoJPxeC_rqw@mail.gmail.com>
Subject: Re: [PATCH 1/2] iommu/ipmmu-vmsa: Hook up R8A774E1 DT matching code
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
> From: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
>
> Add support for RZ/G2H (R8A774E1) SoC IPMMUs.
>
> Signed-off-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
