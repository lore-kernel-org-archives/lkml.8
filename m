Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3F1CC433E7
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 14:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0C6120639
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 14:30:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kIEIT1BC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbgH1Oa0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 10:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727815AbgH1OaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 10:30:13 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25775C061264;
        Fri, 28 Aug 2020 07:30:12 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id u126so1401349iod.12;
        Fri, 28 Aug 2020 07:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oIurT9NnRMICNXs1unTV39g8GKqfYQZhBJKD6PuXkBQ=;
        b=kIEIT1BCstEYEHMwMC4RZZV+EDytYneUK+PJfUj0poGcIHIZHweoj7tdraNnwSvNj6
         Z04fw9gM8wo5UmjdBdCgBKDj6CpGZNLsanoklyg4Db3aT657yfHgvxDteFIkjoHiEvCl
         NjAfv2TDab+Frw3dly6dr43QItQdgjyzdFESNfhJ3zwMVHQ3RVFjidUrheYZt9TGArfR
         wRByYHtiOJlD0UHr6rgfbukN7AlIJpb2Dsr+JCfjTGCYOh//2xicddGxeL+ryANiL/dd
         YU7FM0Eew8M0aI7z/Aa5ARMAMez0Iun4t/KH37lDvcf0upO004UUhQsOAnxtYpq9b+CG
         HUTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oIurT9NnRMICNXs1unTV39g8GKqfYQZhBJKD6PuXkBQ=;
        b=StVSwYlxlSN0IROYeXiv78+7TXu/9UzCFEk5bLmdUH1n/PZ9CyaMAIVhRsZWrRGu0u
         YDgv3NXxjKQUdM/XOMjiWfh69Fcay/mYe9VQrmUijv2IaLmlMCFWrgZDcJ797plw6B22
         WhhK3U6UNmrKAPNMbH3Ej3T/BwpjY9g+Jci9bBjtaG60CFZ3Y4I21n9BkwPomsw45LIH
         ZfR5EcbGLsB3iPwWx+Tyvhl1CeEeI4TzY42Ra56ASY+M05NV3ieBG1PFW5Y9WgCPQWnR
         5bEZBP+WCylDi8HcVvtXHDMQLzygg1PrihErJEYRgLKXIaqsczTuIfBXm7gH/rYeC6X9
         h6Ww==
X-Gm-Message-State: AOAM532cILcgyirAaeZpmjvsbF1cj3pd7PmAJNqdUQLfRoTVkn9RXunQ
        hkXA6rtFGgL7qF6qAI6n2ZlpkwstsQvy8eRE8KA=
X-Google-Smtp-Source: ABdhPJzuT2eph4LucKaa7svK138E8jC2IC4brqlxG2Y/KFo0tvGHyV/Ij30PdVjqFx3uU4yjILA80JrJf9IdXdC/FEU=
X-Received: by 2002:a02:730b:: with SMTP id y11mr1441273jab.126.1598625011513;
 Fri, 28 Aug 2020 07:30:11 -0700 (PDT)
MIME-Version: 1.0
References: <c33df0ebe8be16b56741ce7f873221ab9087a0a6.1598564619.git.stefan@agner.ch>
In-Reply-To: <c33df0ebe8be16b56741ce7f873221ab9087a0a6.1598564619.git.stefan@agner.ch>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Fri, 28 Aug 2020 20:00:00 +0530
Message-ID: <CANAwSgT1bQh+vhzYxygTkN7NP5zq-2jaspvvTfjx3rWxZ07hGw@mail.gmail.com>
Subject: Re: [PATCH] clk: meson: g12a: mark fclk_div2 as critical
To:     Stefan Agner <stefan@agner.ch>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        linux-amlogic@lists.infradead.org,
        "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan,

On Fri, 28 Aug 2020 at 03:14, Stefan Agner <stefan@agner.ch> wrote:
>
> On Amlogic Meson G12b platform, similar to fclk_div3, the fclk_div2
> seems to be necessary for the system to operate correctly as well.
>
> Typically, the clock also gets chosen by the eMMC peripheral. This
> probably masked the problem so far. However, when booting from a SD
> card the clock seems to get disabled which leads to a system freeze.
>
> Let's mark this clock as critical, fixing boot from SD card on G12b
> platforms.
>
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---

Thank you for this patch. I reported this a long time ago but could
not solve it.
Please add my
Tested-by: Anand Moon <linux.amoon@gmail.com>



>  drivers/clk/meson/g12a.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
> index fad616cac01e..2214b974f748 100644
> --- a/drivers/clk/meson/g12a.c
> +++ b/drivers/clk/meson/g12a.c
> @@ -298,6 +298,7 @@ static struct clk_regmap g12a_fclk_div2 = {
>                         &g12a_fclk_div2_div.hw
>                 },
>                 .num_parents = 1,
> +               .flags = CLK_IS_CRITICAL,
>         },
>  };
>
> --
> 2.28.0
>
>
> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic
