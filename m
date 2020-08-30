Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D645C433E2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 17:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE35020707
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 17:43:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aNTY8VtI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbgH3Rnz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 13:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbgH3Rny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 13:43:54 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5430BC061573;
        Sun, 30 Aug 2020 10:43:54 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id d19so2991471pgl.10;
        Sun, 30 Aug 2020 10:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gllTnfpjhA71bQa3AHonqvl1Wti0WUACZxPWejafO/Y=;
        b=aNTY8VtIuFAE7L7IoX8HyazHeu3tNOCdjOiJq/ylr78l47+28zGNqsn0W8SxZnFA0e
         839PVyt81IkcegqvlRR+A081oDz4VRaVOi/7/sFsxUahal6JYlW3y6Unux8nGnqNVWdi
         Sl2Wmk7HG16lXOvcsfrmKNHsE2ZCBmrVMqTf/PJimTKt2vF01qD+ILEkYeEGhuwITIop
         yZgOfE1qTxnOuWE12d4viV5n9dm0zfUUIAFJPKRvUJ1qA/41uJs9ZUrMsmpbAKEaZBKh
         UmLvrct6KOiiw6xUzVGLp7US83siB9JBgqBI1DDiZesPjpzD55fUQbSZoCxILhtuTSJ+
         LGDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gllTnfpjhA71bQa3AHonqvl1Wti0WUACZxPWejafO/Y=;
        b=RPpM5CmEBx6T3tknI0Rw+syfGf/n3byotVptcFeXp04qivB5OMZfYlfRq4mc5DKPbh
         1lZ6wU/ALhx5Jjsf61lM/sW07nmewu4dey/zurG7THblOTjnhW3vmBGGXdnMH3X6zWPj
         2fvB8hPFWj7BiDE/Hm/e92YClP21kC0PfPwUWRjUEloKLZLUIrFALyrKc6jTG5QzO8PU
         JQtbNFELycNETVAXxFa3JHr11xg+VxCyM9X8o7b0z0ywYLbdtia+pY6PmlwvVHDJaGnh
         yuet9gySPxyLgBzjUSK0dTq3wCuC3XqWJSVSFQn6KYRiCwNVzeuoSa0fmkxepC7GI4rB
         161g==
X-Gm-Message-State: AOAM532onjLe0qVUiYVSWNcoiPvY09YAF2wsTuVe97z3prAM15MNors5
        hCuK0QqUWDr8A64bI9iYVDKF5QmWcEaJrdaFKCk=
X-Google-Smtp-Source: ABdhPJwAKDhV+KU3T46+qklPeJTKooPMmp8/QhFMmenoUMc4QVp6rWePqScrCIRkRHiwLUCuhxh7vcxdJ7NabsXU5qQ=
X-Received: by 2002:a62:7c86:: with SMTP id x128mr1133707pfc.268.1598809431997;
 Sun, 30 Aug 2020 10:43:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200828213226.1734264-1-thomas.preston@codethink.co.uk> <20200828213226.1734264-3-thomas.preston@codethink.co.uk>
In-Reply-To: <20200828213226.1734264-3-thomas.preston@codethink.co.uk>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 30 Aug 2020 20:43:35 +0300
Message-ID: <CAHp75VenLVCARSJ9oTZRF4uuq9QHy4zrrVpwjEdXxMAHJNvzsQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] pinctrl: mcp23s08: Fix mcp23x17 precious range
To:     Thomas Preston <thomas.preston@codethink.co.uk>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?B?SmFuIEt1bmRyw6F0?= <jan.kundrat@cesnet.cz>,
        Phil Reid <preid@electromag.com.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 29, 2020 at 12:33 AM Thomas Preston
<thomas.preston@codethink.co.uk> wrote:
>
> On page 23 of the datasheet [0] it says "The register remains unchanged
> until the interrupt is cleared via a read of INTCAP or GPIO." Include
> INTCAPA and INTCAPB registers in precious range, so that they aren't
> accidentally cleared when we read via debugfs.
>

> [0] https://ww1.microchip.com/downloads/en/DeviceDoc/20001952C.pdf

I would convert it to tag Datasheet: https://...

Maybe Linus can amend this when applying.

> Fixes: 8f38910ba4f6 ("pinctrl: mcp23s08: switch to regmap caching")
> Signed-off-by: Thomas Preston <thomas.preston@codethink.co.uk>
> ---
>  drivers/pinctrl/pinctrl-mcp23s08.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pinctrl/pinctrl-mcp23s08.c b/drivers/pinctrl/pinctrl-mcp23s08.c
> index 87cde8fb08dd9..7edb067f5e76a 100644
> --- a/drivers/pinctrl/pinctrl-mcp23s08.c
> +++ b/drivers/pinctrl/pinctrl-mcp23s08.c
> @@ -109,7 +109,7 @@ static const struct regmap_access_table mcp23x17_volatile_table = {
>  };
>
>  static const struct regmap_range mcp23x17_precious_range = {
> -       .range_min = MCP_GPIO << 1,
> +       .range_min = MCP_INTCAP << 1,
>         .range_max = MCP_GPIO << 1,
>  };
>
> --
> 2.26.2
>


-- 
With Best Regards,
Andy Shevchenko
