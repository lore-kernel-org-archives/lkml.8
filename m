Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C708C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 11:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2153820936
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 11:31:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730076AbgIHLav (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 07:30:51 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:40567 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729991AbgIHLWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 07:22:17 -0400
Received: by mail-oi1-f195.google.com with SMTP id t76so16064284oif.7;
        Tue, 08 Sep 2020 04:22:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iU+porO3OzIDM39i0qpuDlqKoX1If0peyqlGwOFV2Lw=;
        b=kpDYvuUEGqjdO7D1hj8onhlr1k82Fs3TYJa0vBr2trIwIt2f7ufO7bnReWQVJeibW1
         AEZCc1QdwzVuMjUPqfcsrzNcLP0eeYQ2T3TkRKrWXb6/8Ns951D13FqLqECj/qBSejyH
         VnVRVqUKCYkLGfZKx/hSEmAguiWWJ0oJ8OgmQpHNlFgLDh2dSnuvtWyS2FXQEQXsjM3C
         RImKl0bbgC55MrEzcxZpDarYVdU7Za9y8PlW4zoBtIofqp9Ci6Hmg8uPk1K1iKpk92ok
         rXmoH612Fv2KzFxQrrUcwXno+bRNTa471rFCswS3yy/55NxSWsJ87d2qEq1tNKfavsu2
         xwqA==
X-Gm-Message-State: AOAM5313UZh4wVTgs36a59g8L2aLvtLRF6B/IYbXUSSaOe0L7Gclkgyv
        /bYPMpltXeo2XdkmU25E6VLhonkkMPqUXQGYyiyREyi4
X-Google-Smtp-Source: ABdhPJzZZY3uxx6kly6khprrbhuaY+7eyHBu4Rltm/o5KeWvkoCBkCalHfuYR627xJRHUxvwfL6/+vqNOdMkD266n98=
X-Received: by 2002:aca:52d6:: with SMTP id g205mr2331146oib.54.1599564136491;
 Tue, 08 Sep 2020 04:22:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200908110640.5003-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20200908110640.5003-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 8 Sep 2020 13:22:05 +0200
Message-ID: <CAMuHMdXD88LKVUcXTa=yWreqWZ0O0G+dF7WK=ioVwJo2OTd_PQ@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: Kconfig: Update description for RCAR_DMAC config
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        dmaengine <dmaengine@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

On Tue, Sep 8, 2020 at 1:06 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> rcar-dmac driver is used on Renesas R-Car Gen2 and Gen3 devices
> update the same to reflect the description for RCAR_DMAC config.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Do you want to mention RZ/G1 and RZ/G2?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
