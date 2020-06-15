Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 980FCC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 08:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73AF72067B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 08:39:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729046AbgFOIjf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 04:39:35 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40771 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728861AbgFOIje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 04:39:34 -0400
Received: by mail-ot1-f65.google.com with SMTP id s13so12473792otd.7;
        Mon, 15 Jun 2020 01:39:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7wf5WtePaBKPY0Bp8z4FODm50aRt5JbGt5tRztVB4pk=;
        b=GxfOrI1cqhdfHllY7jIIaXlG5+1oR+SAP3raeaCQrxST021ONB8s86oXUOW6v13Yya
         FVZX9DUpJS5J+ne6PwN7GHAwW1XF1xevjVt8XntZU3zSXZUpsIA8b9ErW/TKiCRdyK94
         C+Ag3pgsmCaQv/6u3cM4GKwcJmUvyuDzYU4Z+SBPt3JOGDEiZakl9FIostp9uTSnMqT+
         u7+5KSpLF4WjOPP07gr93aNoKrozzWwptiPXc/frrOum12BbAaqq3xK4pZB8a9ioxlxP
         KsXmx4weN7+oul8aGMgtsEVAueL8gjs3LeFn70r751yPDaWxUqH9wZR1DE8CIZVGGww4
         iaRg==
X-Gm-Message-State: AOAM532B4Jo0o1VBGrq2xQFwaradZ/D7f7sXKtIv4/aXPkssV7v9kK91
        lNfJKXms+o3C2fMOJI+jvOE/YP4MdOxxKcN6RhE=
X-Google-Smtp-Source: ABdhPJwuMKW/S2T3+nGDgfWQJsU+Elnk3Z4DUyNzB+BrCwdb2xIAo2LW2mswFqh60WvA1fIgh73z1U7cDAVx7nbKNKw=
X-Received: by 2002:a9d:c29:: with SMTP id 38mr19347614otr.107.1592210373272;
 Mon, 15 Jun 2020 01:39:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200506123236.7463-1-geert+renesas@glider.be>
 <20200506123236.7463-3-geert+renesas@glider.be> <20200507200410.GB2981633@ulmo>
In-Reply-To: <20200507200410.GB2981633@ulmo>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 15 Jun 2020 10:39:21 +0200
Message-ID: <CAMuHMdUkNiVU3Df-VvGbSxEx-R29=OtLzrqjb0+mbt6gYYCfhw@mail.gmail.com>
Subject: Re: [PATCH 2/2] memory: tegra: Drop <linux/clk-provider.h>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Joseph Lo <josephl@nvidia.com>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thierry,

On Thu, May 7, 2020 at 10:04 PM Thierry Reding <thierry.reding@gmail.com> wrote:
> On Wed, May 06, 2020 at 02:32:36PM +0200, Geert Uytterhoeven wrote:
> > The Tegra EMC scaling support code is not a clock provider, but merely a
> > clock consumer, and thus does not need to include
> > <linux/clk-provider.h>.
> >
> > Fixes: ec37a9a17afbfad5 ("memory: tegra: Add EMC scaling support code for Tegra210")
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> >  drivers/memory/tegra/tegra210-emc-core.c | 1 -
> >  drivers/memory/tegra/tegra210-emc.h      | 1 -
> >  2 files changed, 2 deletions(-)
>
> Applied to for-5.8/memory, thanks.

Which hasn't made it into v5.8-rc1, and was rebased.
New fixes tag is
Fixes: 01218c59f9bcf067 ("memory: tegra: Add EMC scaling support code
for Tegra210")

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
