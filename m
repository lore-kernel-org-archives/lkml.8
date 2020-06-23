Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F999C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 08:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7995720738
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 08:49:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732043AbgFWItU convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 04:49:20 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:40762 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731775AbgFWItT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 04:49:19 -0400
Received: by mail-oi1-f194.google.com with SMTP id t25so18183221oij.7;
        Tue, 23 Jun 2020 01:49:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KYYkTy+n5vlKKt6FVVpIMkxXIMyGrQIro4YFJXSFp/Q=;
        b=Z49XcmnkJkCrXdxkwm0MB1QNxW2yEqKzNkNDq6y+FQyWJRqPBgQGJ49auccg2qeWKp
         6jV32/Rnz2DqXY1q/cRcsvFEcSZ1OOQEkhFLfi/99EAUykfXP/SVTaWJsz8XoxO7a0kX
         lEnRhd7I9LqG1miK831CZJKtywoCJBMgmw0B7D088LYHFBRdCFEThh/Lvdoug87UeDqs
         tQn7PxtlYQce/jndNXC8xkGqkqWsKfmBEnSls9pBDcMzz4jRW1q7k4daOK+ryZuMc23B
         5YI4L7KYJ0Ffoy5YZ0bFaYs8lWa+Ima76HAwrOTNGi3H3tS4kSHXOz/GFkXRXaDvaIFP
         L3Uw==
X-Gm-Message-State: AOAM5311R4Cvjv7XN7bJLmCSXU6DYgEuWShQCzbAKYN8xeKGjuo6u4sO
        Li0UN164yoaPDa7/ySttL/z8n/61WvaGvjGu3nVvwQ==
X-Google-Smtp-Source: ABdhPJyZuQJULxx3zeAGfh1M7qa212mqMA6kl+nmL+q8rj5M2TP5jMtfN8t8iYl5v54dJMOwofhHC5BjrzV1nV2gUFY=
X-Received: by 2002:a54:4006:: with SMTP id x6mr14938101oie.148.1592902158608;
 Tue, 23 Jun 2020 01:49:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200212101651.9010-1-geert+renesas@glider.be>
 <CAEbi=3fMRq++Eot+BEtCedeyhM65kTc+nS7=inCTR8MkT5srww@mail.gmail.com> <CAMuHMdU+VLpg5Yezo2Ea9v2vmvbA=nEcKObBgZYwjSV10OkY=A@mail.gmail.com>
In-Reply-To: <CAMuHMdU+VLpg5Yezo2Ea9v2vmvbA=nEcKObBgZYwjSV10OkY=A@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 23 Jun 2020 10:49:07 +0200
Message-ID: <CAMuHMdWaRw+61y4Ykk4niagPOtY3dL28fhtB=3jdR16ZODGgfg@mail.gmail.com>
Subject: Re: [PATCH] nds32: Replace <linux/clk-provider.h> by <linux/of_clk.h>
To:     Greentime Hu <green.hu@gmail.com>
Cc:     Nick Hu <nickhu@andestech.com>, Vincent Chen <deanbo422@gmail.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greentime,

On Wed, Feb 12, 2020 at 1:25 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Wed, Feb 12, 2020 at 11:52 AM Greentime Hu <green.hu@gmail.com> wrote:
> > Geert Uytterhoeven <geert+renesas@glider.be> 於 2020年2月12日 週三 下午6:16寫道：
> > > The Andes platform code is not a clock provider, and just needs to call
> > > of_clk_init().
> > >
> > > Hence it can include <linux/of_clk.h> instead of <linux/clk-provider.h>.
> > >
> > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > ---
> > >  arch/nds32/kernel/time.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/arch/nds32/kernel/time.c b/arch/nds32/kernel/time.c
> > > index ac9d78ce3a818926..574a3d0a853980a9 100644
> > > --- a/arch/nds32/kernel/time.c
> > > +++ b/arch/nds32/kernel/time.c
> > > @@ -2,7 +2,7 @@
> > >  // Copyright (C) 2005-2017 Andes Technology Corporation
> > >
> > >  #include <linux/clocksource.h>
> > > -#include <linux/clk-provider.h>
> > > +#include <linux/of_clk.h>
> > >
> > >  void __init time_init(void)
> > >  {
> >
> > Thank you, Geert.
> >
> > Let me know if you like to put in your tree or nds32's.
> > Acked-by: Greentime Hu <green.hu@gmail.com>
>
> Please take it in the nds32 tree.
> Thanks!

And so you did. But it disappeared after June 12, when the nds32 tree
was reset to v5.7, losing the following 2 commits:

de9a5650b611014c52b1ad994f63253593d8eddf nds32: Replace
<linux/clk-provider.h> by <linux/of_clk.h>
d785c5a324cd8812720a409dc85050558281a567 nds32: configs: Cleanup
CONFIG_CROSS_COMPILE

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
