Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D7F1C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 08:38:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12F3F2072F
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 08:38:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbgFJIiZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 04:38:25 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:34871 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbgFJIiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 04:38:02 -0400
Received: by mail-oi1-f195.google.com with SMTP id k4so1380885oik.2;
        Wed, 10 Jun 2020 01:38:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wpr/vh763HjeZP+zP2FvdrT65wytnNPLkj0hJH5/HSU=;
        b=pLzci9jHCnsmZsXD0DiNzC3IFlDNKiVrp85s8t1tBs9HXAwxY+1OOqA1vJzYbh4+d6
         3BbX+Rogr0hOXtkrf1pu/WDtKQedB4GBAFBTjRXjdmtVtaxffhQ+bvWT4PjYSbP/sVhQ
         +vTUWBn7DHwPFqDc4KW3a1gb1Ph4Go/waLDaLy9J4ecO4QHtYaZyNHMCFUOzXYVIZJk8
         U1hRqEgZlyroFNu2w3ndf3EqNArnJyI+wOcTMXAGySD1a+s5ee0XorkM+zXZcxBCmA+i
         TzXUjREXs1sQCqjuJfBHrZyDglY6rgG1G7q33d/uKzLL7nETPo834H67JAphc3DkCGqu
         9LKQ==
X-Gm-Message-State: AOAM533t8HTUbbUcj8fhTCWnHdr3QwepnDExBHgL/+1EG3iHdwLkKfEI
        HJ1UzdXBeFCsvfgM9NJYxNTwIp9tTRtXWFxghDY=
X-Google-Smtp-Source: ABdhPJy/1U4soGDENhmLUY6tvEPackTNczKlnXGG0s9S/MpJevjbk+u+NWI9rauDUQubBnlkMAamXhasUns0Cr7+PGk=
X-Received: by 2002:aca:4255:: with SMTP id p82mr1559149oia.153.1591778280645;
 Wed, 10 Jun 2020 01:38:00 -0700 (PDT)
MIME-Version: 1.0
References: <1591736054-568-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1591736054-568-2-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <1591736054-568-2-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 10 Jun 2020 10:37:45 +0200
Message-ID: <CAMuHMdWGs+UHCNXPc3TCAiRTX3M_8FLUAG5pke+=ZDr0uaP3_g@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: spi: renesas,sh-msiof: Add r8a7742 support
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
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

On Tue, Jun 9, 2020 at 10:54 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Document RZ/G1H (R8A7742) SoC bindings.
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
