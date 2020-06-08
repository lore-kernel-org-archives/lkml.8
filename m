Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46ED1C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 18:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 266862078D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 18:15:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oIwYbMCn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbgFHSPX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 14:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgFHSPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 14:15:21 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26D4C08C5C2
        for <linux-kernel@vger.kernel.org>; Mon,  8 Jun 2020 11:15:20 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id v6so6189596uam.10
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 11:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EGpe1/DmAZEAKC2EbhqvjHPxfTMYfr/m0SisqKdbZdo=;
        b=oIwYbMCnIsfKNwYT8md93PfuP9r3WakuHjByQqasLAlm2TSsnJdX7xymMGbPH1plWN
         Nos3Z+kA0XluxPtrS6ygw5fiEaBGd2U5+fGB+CSIsEv3CpJXlW7HyDc/8r406Yso9AQ9
         Ka/1KynuFafizTnKPJB0DxSRmZgeoyXY5/tOA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EGpe1/DmAZEAKC2EbhqvjHPxfTMYfr/m0SisqKdbZdo=;
        b=jsyheaSlwf90Kv2/ednMWJhoZ0guOBCWQAmQV1yd4EK4MU49K/IYhdN0E4BfKkx8J8
         NVEaIR0kKn6+MVzjvQ+vKZMzG2rdLbYnugjqBgBSrXzLznOFaHbHi4OgOzMkeSUzjyRj
         90T55X63Y76TlbmTQrcqbP6/aVkhlHWLQ8egwHtqHmVJ2G/JYVUHIHfLXw7/9NrIyVyY
         /3iasBCOKL+OkOQykGgoOm3xMzbHey5dmJHaaEFcm2vUlAJ/TR1KFfT98FHGgwKysH5C
         4goXcUvWFVyXf2MEOsWQf6cs7LYz8LWJPh5CugKT9GbHQOF152N+eSxFaCHX0TClS+X3
         BxzA==
X-Gm-Message-State: AOAM533UBKajZmXXAzHGMrvoOa3WsjB+LDXTLgzqJMrJjhsKUbPqM1mv
        x0LU69MLbfX6dyE70Y02ELWM/STPkMo=
X-Google-Smtp-Source: ABdhPJxavH8hoxxSDetVljWVh5oAlOb4hVYMfQ5lE79ap2xqmNghk4auBmdyZu8aeoHuc8YHL2U9WQ==
X-Received: by 2002:ab0:2358:: with SMTP id h24mr15771185uao.82.1591640119406;
        Mon, 08 Jun 2020 11:15:19 -0700 (PDT)
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com. [209.85.221.171])
        by smtp.gmail.com with ESMTPSA id a21sm74415vsq.15.2020.06.08.11.15.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2020 11:15:18 -0700 (PDT)
Received: by mail-vk1-f171.google.com with SMTP id i1so4219183vkp.8
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 11:15:18 -0700 (PDT)
X-Received: by 2002:ac5:ce86:: with SMTP id 6mr15986500vke.75.1591640117928;
 Mon, 08 Jun 2020 11:15:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200608162226.3259186-1-hslester96@gmail.com>
In-Reply-To: <20200608162226.3259186-1-hslester96@gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 8 Jun 2020 11:15:06 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U-Cn=Ze=6nY=E3LmxmrJPbnzKKd9h1dvtwx__u3KUQzw@mail.gmail.com>
Message-ID: <CAD=FV=U-Cn=Ze=6nY=E3LmxmrJPbnzKKd9h1dvtwx__u3KUQzw@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-of-arasan: Add missed checks for devm_clk_register()
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jun 8, 2020 at 9:22 AM Chuhong Yuan <hslester96@gmail.com> wrote:
>
> These functions do not check the return value of devm_clk_register():
>   - sdhci_arasan_register_sdcardclk()
>   - sdhci_arasan_register_sampleclk()
>
> Therefore, add the missed checks to fix them.
>
> Fixes: c390f2110adf1 ("mmc: sdhci-of-arasan: Add ability to export card clock")
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> ---
>  drivers/mmc/host/sdhci-of-arasan.c | 4 ++++
>  1 file changed, 4 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
