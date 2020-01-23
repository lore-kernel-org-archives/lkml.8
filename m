Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E5C5C33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 10:32:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E9B324673
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 10:32:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbgAWKcp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 05:32:45 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:40164 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbgAWKco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 05:32:44 -0500
Received: by mail-oi1-f196.google.com with SMTP id c77so2432627oib.7;
        Thu, 23 Jan 2020 02:32:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QcZp4gfVUSDInEQle12WovyUYPuFeimVii8rBuqstqk=;
        b=aioYFC+j2S0XmHJhDY6v/Qh7liRYfsoaXL9M6CfktN4Se/8PTtPXoOtYtwabONctmJ
         dzu7jKsh8ZcjztB4lElzRHVzphEHgguRFJbZFfogC9ezQxd7WIU0yifEp8cMr7uO6rDl
         dwg6aFqkuTdTyp82nao/JyoISOcdFGZP0tVNAPspjJdA1kAOUVr2fRBfBkR+Kflv+oyu
         kcWI/q+/Iw0lVMI5Sx4vRPNH1mNNh/2vNEk7tjY62kvY4FVtjgwH03azNZ+X7+2ZcgTT
         j5XsCnNB6FfMSzhk6wPKPtPpWyxwysrZY/WOY7dCSgsaRwBoj/AlRUZr4fuk9cZKRlia
         cJ/A==
X-Gm-Message-State: APjAAAWlEprQ3noA9n7m/4UQ0+2tDlbT7HJO9fHPV1wI22HEVUaKcvr3
        hUmGLFpjJ/r/tYNkfLXNra4tiWS1nZo2BDa9T3w=
X-Google-Smtp-Source: APXvYqy2H34MWaUdGdf1bbSGCmjx+hi8NQGrCSPpVJ9h7cLecMi626nnbrNMNEVvCTAVxOtrtW3m1l6awh+14xF2ZtM=
X-Received: by 2002:aca:1a06:: with SMTP id a6mr9548275oia.148.1579775564167;
 Thu, 23 Jan 2020 02:32:44 -0800 (PST)
MIME-Version: 1.0
References: <56c7b6d5-1248-15bd-8441-5d80557455b3@free.fr> <CAMuHMdX3kZoEfCeGamreeWq0-Tu2+Mw8MYEbRUZV8wBS+e2K=A@mail.gmail.com>
 <8f1f01a1-b0c7-77d5-7d01-dd53811fa217@free.fr>
In-Reply-To: <8f1f01a1-b0c7-77d5-7d01-dd53811fa217@free.fr>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 23 Jan 2020 11:32:32 +0100
Message-ID: <CAMuHMdW=0Qf=bdE8Vy75wySRV5wzWhgM=-vhXjc0RhLGwomF_g@mail.gmail.com>
Subject: Re: [RFC PATCH v2] clk: Use a new helper in managed functions
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Guenter Roeck <linux@roeck-us.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On Thu, Jan 23, 2020 at 11:13 AM Marc Gonzalez <marc.w.gonzalez@free.fr> wrote:
> On 22/01/2020 14:33, Geert Uytterhoeven wrote:
> > On Wed, Jan 22, 2020 at 2:02 PM Marc Gonzalez wrote:
> >> Introduce devm_add() to factorize devres_alloc/devres_add calls.
> >>
> >> Using that helper produces simpler code and smaller object size:
> >>
> >> 1 file changed, 27 insertions(+), 66 deletions(-)
> >>
> >>     text           data     bss     dec     hex filename
> >> -   1708             80       0    1788     6fc drivers/clk/clk-devres.o
> >> +   1508             80       0    1588     634 drivers/clk/clk-devres.o
> >>
> >> Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>

> >> --- a/drivers/base/devres.c
> >> +++ b/drivers/base/devres.c
> >> @@ -685,6 +685,20 @@ int devres_release_group(struct device *dev, void *id)
> >>  }
> >>  EXPORT_SYMBOL_GPL(devres_release_group);
> >>
> >> +void *devm_add(struct device *dev, dr_release_t func, void *arg, size_t size)
> >
> > Is there any advantage of using dr_release_t over "void (*action)(void *)",
> > like devm_add_action() does?  The latter lacks the "device *" parameter.
>
> (I did forget to mention that v1 used devm_add_action.)
> https://patchwork.kernel.org/patch/11262685/
>
> A limitation of devm_add_action is that it stores the void *data argument "as is".
> Users cannot pass the address of a struct on the stack. devm_add() addresses that
> specific use-case, while being a minimal wrapper around devres_alloc + devres_add.
> (devm_add_action adds an extra level of indirection.)

I didn't mean the advantage of devm_add() over devm_add_action(),
but the advantage of dr_release_t, which has a device pointer.

> >> +{
> >> +       void *data = devres_alloc(func, size, GFP_KERNEL);
> >> +
> >> +       if (data) {
> >> +               memcpy(data, arg, size);
> >> +               devres_add(dev, data);
> >> +       } else
> >> +               func(dev, arg);
> >> +
> >> +       return data;
> >
> > Why return data or NULL, instead of 0 or -Efoo, like devm_add_action()?
>
> My intent is to make devm_add a minimal wrapper (it even started out as
> a macro). As such, I just transparently pass the result of devres_alloc.
>
> Do you see an advantage in processing the result?

There are actually two questions to consider here:
  1. Is there a use case for returning the data pointer?
     I.e. will the caller ever use it?
  2. Can there be another failure mode than out-of-memory?
     Changing from NULL to ERR_PTR() later means that all callers
     need to be updated.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
