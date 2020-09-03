Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE7DC433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 08:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 432E4208CA
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 08:12:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LNj9s0VD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728867AbgICIMC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 04:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728254AbgICIK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 04:10:28 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10AEBC061244
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 01:10:27 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id v5so395711uau.10
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 01:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LrOjlA1x52Sx3PNdexN+2X/ozkPpzSng8Vccaxs54Zw=;
        b=LNj9s0VDa9drWeLKU2VtX/B9wbQgZmQkc6JpKMfK3e9C+15ObehWeink4X7oCMDirp
         WPafqIvq9t4fj1FDRMiaapi9ohjzXf41O7a5YaafCVZPvVQ9M2pyoTOBkhB2a+84EXOK
         AiANcRalw5n97ufIUIOei9DTEGLrtbKe/WatzVK99QTXRF7K/qYw86pIst4ltUDzOJQd
         Gn04+W0cxdaZGW5nD0qXPij/7pKctDdjpM60SGN4pobi5xXjPsFhZ71Edv4qO8JPESdz
         B5NaqGd/yzgyFw8wRa5dCrYP9Mm74fIRm4/AmfvKAjITRKgEyNhX9nL3RBTyIQ0ByLE0
         bmzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LrOjlA1x52Sx3PNdexN+2X/ozkPpzSng8Vccaxs54Zw=;
        b=EmogsQwkB/Lw947tq7nYf2POOSCKeK0w9AxSfkd/jMdt8x7YnJmd/NoDvBrc6ULDpr
         d/ORmnk2apfxSGihWCfWPADaz9r8C3hama2Qw+KxL2ICXZOEYC4EYcgD8dKa1qjQ7tfU
         j/FavPyj37xAnHpNW5IMF3B5WUOX1U23bbUuUJgTG9wl5qQFrYtFFrj7nFS615ND/lI0
         P7TIuAk8HzqByyK4kkc5b8QEbSf3yhfHdmr5jUPooCDd7LoA7N5jHo1SiFZ5eguliJn7
         bhhfGqMHhONiAMwxhYUQFNFUjXAcXYasccz+kG7P/SlFNfMD42GX68rQNu+cMBfIZqN7
         e83A==
X-Gm-Message-State: AOAM530xUK1mMaYmVA99f+kJ5M2R0NpRN7OB2ILtkIOxubhwEkXoptZN
        DXqOj6SKRtmwRExtxv0p2lPtbBRLAbxSTM6PJ/3TxQ==
X-Google-Smtp-Source: ABdhPJw7qVTiuZksAFcWPUutKJ0zYg2tpTJGwRa2BumR3h5BzwPXYQoKG7VAuSHc8ImsX3M25x7A+yZZGSSWhcaYqhE=
X-Received: by 2002:ab0:6f91:: with SMTP id f17mr357139uav.129.1599120626145;
 Thu, 03 Sep 2020 01:10:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200902193658.20539-1-krzk@kernel.org>
In-Reply-To: <20200902193658.20539-1-krzk@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 3 Sep 2020 10:09:49 +0200
Message-ID: <CAPDyKFqBS-ws6fkirDQL8EEqh9At88K2vrG5fc8K5_JiXsmfyg@mail.gmail.com>
Subject: Re: [PATCH 00/11] mmc: Minor cleanups and compile test
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Jun Nie <jun.nie@linaro.org>, Shawn Guo <shawnguo@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Al Cooper <alcooperx@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-rpi-kernel@lists.infradead.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        linux-tegra <linux-tegra@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Sep 2020 at 21:37, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> Hi,
>
> Set of minor cleanups.  Patches requiring more attention:
>  - 6/11: Testing and review would be appreciated,
>  - 11/11: I build tested multiple architectures but not all and
>    definitely no all possible configs. This one could sit on the lists
>    for few days so 0-day would try it.
>
> Best regards,
> Krzysztof
>
> Krzysztof Kozlowski (11):
>   mmc: bcm2835: Simplify with dev_err_probe()
>   mmc: davinci: Simplify with dev_err_probe()
>   mmc: dw_mmc-zx: Simplify with dev_err_probe()
>   mmc: jz4740: Simplify with dev_err_probe()
>   mmc: meson: Simplify with dev_err_probe()
>   mmc: sdhci-brcmstb: Simplify with optional clock and dev_err_probe()
>   mmc: sdhci-of-arasan: Simplify with dev_err_probe()
>   mmc: sdhci-tegra: Simplify with dev_err_probe()
>   mmc: dw_mmc: Simplify with dev_err_probe()
>   mmc: sdhci-of-sparx5: Use proper printk format for dma_addr_t
>   mmc: host: Enable compile testing of multiple drivers
>
>  drivers/mmc/host/Kconfig           | 42 ++++++++++++++++--------------
>  drivers/mmc/host/bcm2835.c         |  4 +--
>  drivers/mmc/host/davinci_mmc.c     |  5 ++--
>  drivers/mmc/host/dw_mmc-zx.c       | 11 +++-----
>  drivers/mmc/host/dw_mmc.c          |  9 +++----
>  drivers/mmc/host/jz4740_mmc.c      |  5 ++--
>  drivers/mmc/host/meson-gx-mmc.c    | 16 ++++--------
>  drivers/mmc/host/sdhci-brcmstb.c   | 12 ++++-----
>  drivers/mmc/host/sdhci-of-arasan.c |  7 +++--
>  drivers/mmc/host/sdhci-of-sparx5.c |  4 +--
>  drivers/mmc/host/sdhci-tegra.c     |  7 ++---
>  11 files changed, 51 insertions(+), 71 deletions(-)
>
> --
> 2.17.1
>

Series applied for next, except 11, thanks!

Kind regards
Uffe
