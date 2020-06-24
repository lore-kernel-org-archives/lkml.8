Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F26E5C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 07:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D43012082F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 07:34:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389874AbgFXHe0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 03:34:26 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37301 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388489AbgFXHe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 03:34:26 -0400
Received: by mail-ot1-f67.google.com with SMTP id v13so1042225otp.4;
        Wed, 24 Jun 2020 00:34:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j5iJaAmcwIz93ZsJcMmiCbrU1gnAgWj1jKvFm1JtK38=;
        b=NE1sTZZLk+CtEKLsY9GmDuJF+nCrHxYUXDYxESgF62X5cZZThxTBD80cg3TO0SuF0k
         IZiim3QKwi2btGz1ucU4P/8IFZEjwSYysBJfZp79C6AiIPJ3xkTtMvPclhtGAqzqiBn5
         452rlzZfc+bvNAjQXWpBMkMT2IQgsoCEY+d2+LiG1Ku1qWORO9WvkNfg8Hg5Jxo+vY9E
         BdDzwUqY1S6fMVrgOiu8dXxaMCV8zvaGfhXY08KKQe83FQa5vfWkDsongQ7AG1oZFaSb
         sBaCPi87DyeMEc49+GxvLaXz4afGpOyDcwOL3EDk7FWcjrt04cJNNy7XWE+mKS7gxbEz
         ldiw==
X-Gm-Message-State: AOAM531i4jVbQ8VQB6+J55vZsjX1NZ5jAJnLaq488J4NavvHtKK9Ktqf
        6071GagnkTnwP9GtYnEnZ3JjJqgKY1Bk4FaYSG2SJAK6
X-Google-Smtp-Source: ABdhPJysMLeTgnT1zZNYcM9UUaX0LYbwwd5YK/jR2CfMmZxWqVy6gv8jlfq9DQ03hq5B5ML5uSUVwBSO6NQzv9Qjgg8=
X-Received: by 2002:a4a:b804:: with SMTP id g4mr22189953oop.40.1592984065134;
 Wed, 24 Jun 2020 00:34:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200603154329.31579-1-aford173@gmail.com>
In-Reply-To: <20200603154329.31579-1-aford173@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 24 Jun 2020 09:34:13 +0200
Message-ID: <CAMuHMdW1radtuje+z85TLXO8EAEdVYp3gF2ZE9aYbHUHdrY-Fg@mail.gmail.com>
Subject: Re: [PATCH V3 1/3] clk: vc5: Allow Versaclock driver to support
 multiple instances
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-clk <linux-clk@vger.kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adam,

On Wed, Jun 3, 2020 at 5:44 PM Adam Ford <aford173@gmail.com> wrote:
> Currently, the Versaclock driver is only expecting one instance and
> uses hard-coded names for the various clock names.  Unfortunately,
> this is a problem when there is more than one instance of the driver,
> because the subsequent instantiations of the driver use the identical
> name.  Each clock after the fist fails to load, because the clock
> subsystem cannot handle two clocks with identical name.

Thanks for your patch, which is now commit f491276a51685987 ("clk: vc5:
Allow Versaclock driver to support multiple instances") in clk-next.

> This patch removes the hard-coded name arrays and uses kasprintf to
> assign clock names based on names of their respective node and parent
> node which gives each clock a unique identifying name.
>
> For a verasaclock node with a name like:
>    versaclock5: versaclock_som@6a
>
> The updated clock names would appear like:
>     versaclock_som.mux
>        versaclock_som.out0_sel_i2cb
>        versaclock_som.pfd
>           versaclock_som.pll
>              versaclock_som.fod3
>                 versaclock_som.out4
>              versaclock_som.fod2
>                 versaclock_som.out3
>              versaclock_som.fod1
>                 versaclock_som.out2
>              versaclock_som.fod0
>                 versaclock_som.out1

I'm afraid this won't help, as all versaclock nodes should be named
"clock-controller@<unit-address>", as per DT generic node name
recommendations.
Incorporating the unit-address won't help, as you can have multiple
i2c buses in the system.
How do other drivers handle this?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
