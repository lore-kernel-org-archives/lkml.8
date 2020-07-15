Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CAE7C433E4
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 21:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E52202065F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 21:30:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A14AiHsk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgGOVaR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 17:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbgGOVaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 17:30:16 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82CE9C061755;
        Wed, 15 Jul 2020 14:30:16 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id h13so2633372otr.0;
        Wed, 15 Jul 2020 14:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gg4JrqfCgBGC6t6EzVXSJJQHBX5kSrQQVUjGzeSKHF0=;
        b=A14AiHsks+5grSbpMzsN/lJAbv3gaayhst+jtITpIhkxWO7Te4qRCV0vhCJpxujQwv
         MSHcKryEA+4NjmAtKpqjxCDFutA7IbmY38R9zB4/bMgfgUw78uPO5Uz7FK0KUiaBnvl/
         7qS6LNNmXNVcO/QJx7skMi/dUezf7cYF7XARsGJR6ol+XOVaSibV9f0UIFyYx6n1rU0q
         0/aE58X92RvpHqxjUVT4370HyafZRQWN6th1EOjkfLFZW/T8tpTHm2zBcPQd61PSPBAm
         kZJmrczd38wnLTYCEPJh/lyTwbhZjxS9Z7Im9kjpWyZzKRLTrpq1oW5K8dpNTBanMHMr
         8ALA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gg4JrqfCgBGC6t6EzVXSJJQHBX5kSrQQVUjGzeSKHF0=;
        b=lIRI87scLBZ4AMYgPeooPcCviRE/kzM/RMWe2UCJQCRSlQlIDVcluo/hhD9qaDkRkN
         6q9IejgvK1JihIw1j9j8ronkvYSJZ9mOjYn5XXy/AyhTCSyHCKTNM0F9ckEVcXecYZ9l
         qcpSYdVmrZuP6BkrNYhjhp/gmOOHmOfNPVSnl/UG6T8oo/IDdrTPfUD8K2JXBeHfj1Qs
         H3vqx3sB1bo9JpzuNyO1DrEiMjwojg0jRqoskVIEJT0JtHoSQkCetsOAoghlFRQUyi/Y
         2C39UtHdLQzZelPHmBwWGqMgTccoqbF6CNENI57jWxU0fdTzz892FCxfJ+EwPdQLcPtR
         JzrA==
X-Gm-Message-State: AOAM530H8ojmyEwgQLCGvYcsaypwIiaXeyBaf0SUh8Q1PXIpRoHIGaQp
        OnngRvvDE8RC8KY5x+ExwLuIMHu8m1Zlqs4ycPNu1LIYIjLU3g==
X-Google-Smtp-Source: ABdhPJzu5gR3kxgIlN3HLfyszBwlsUj6J/lk0upH7IO4tJs0hTwNMDyBBI+po0DLwAufxSOsmvdX8ErBf5KicFaw4FE=
X-Received: by 2002:a9d:6c09:: with SMTP id f9mr1514735otq.362.1594848615745;
 Wed, 15 Jul 2020 14:30:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200305111047.147355-1-enric.balletbo@collabora.com>
In-Reply-To: <20200305111047.147355-1-enric.balletbo@collabora.com>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Wed, 15 Jul 2020 23:30:04 +0200
Message-ID: <CAFqH_52LhfV9AsnPRZi_ZPsgYX8WrUrKEsV-E7VHOw3ZZtHd-w@mail.gmail.com>
Subject: Re: [RESEND RESEND PATCH] arm/arm64: defconfig: Update configs to use
 the new CROS_EC options
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Patrice Chotard <patrice.chotard@st.com>,
        linux-tegra@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Olof Johansson <olof@lixom.net>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Kukjin Kim <kgene@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Amelie Delaunay <amelie.delaunay@st.com>,
        Joel Stanley <joel@jms.id.au>,
        Russell King <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Tony Lindgren <tony@atomide.com>,
        Anson Huang <Anson.Huang@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi arm/arm64 maintainers,

Missatge de Enric Balletbo i Serra <enric.balletbo@collabora.com> del
dia dj., 5 de mar=C3=A7 2020 a les 12:11:
>
> We refactored the CrOS EC drivers moving part of the code from the MFD
> subsystem to the platform chrome subsystem. During this change we needed
> to rename some config options, so, update the defconfigs accordingly.
>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
> Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
> Tested-by: Gwendal Grignou <gwendal@chromium.org>
> Acked-by: Lee Jones <lee.jones@linaro.org>
> ---

A gentle ping. I'd like to land this if is possible because that way I
can remove some legacy code in platform/chrome subsystem.

Thanks,
  Enric

> Dear all,
>
> This is a resend of a resend patch [3]. In some previous discussions
> maintainers would prefer to have this merged through the arm-soc tree
> but wasn't merged yet and I forget to ping again, hence, sending a new
> resend.
>
> To give some context to some discussions that can arise again (i.e
> whether some symbols should be built-in or not) please look at the
> previous resends [1] and [2].
>
> Thanks,
>  Enric
>
> [1] https://lkml.org/lkml/2019/8/23/518
> [2] https://lkml.org/lkml/2019/8/23/475
> [3] https://patchwork.kernel.org/patch/11267741/
>
>  arch/arm/configs/exynos_defconfig   | 4 +++-
>  arch/arm/configs/multi_v7_defconfig | 5 ++++-
>  arch/arm/configs/pxa_defconfig      | 4 +++-
>  arch/arm/configs/tegra_defconfig    | 2 +-
>  arch/arm64/configs/defconfig        | 5 ++++-
>  5 files changed, 15 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_=
defconfig
> index c8e0c14092e8..cb030549dd69 100644
> --- a/arch/arm/configs/exynos_defconfig
> +++ b/arch/arm/configs/exynos_defconfig
> @@ -160,7 +160,9 @@ CONFIG_DEVFREQ_THERMAL=3Dy
>  CONFIG_THERMAL_EMULATION=3Dy
>  CONFIG_WATCHDOG=3Dy
>  CONFIG_S3C2410_WATCHDOG=3Dy
> -CONFIG_MFD_CROS_EC=3Dy
> +CONFIG_MFD_CROS_EC_DEV=3Dy
> +CONFIG_CHROME_PLATFORMS=3Dy
> +CONFIG_CROS_EC=3Dy
>  CONFIG_MFD_MAX14577=3Dy
>  CONFIG_MFD_MAX77686=3Dy
>  CONFIG_MFD_MAX77693=3Dy
> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi=
_v7_defconfig
> index 017d65f86eba..9099787ccf70 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -938,7 +938,7 @@ CONFIG_SERIO_NVEC_PS2=3Dy
>  CONFIG_NVEC_POWER=3Dy
>  CONFIG_NVEC_PAZ00=3Dy
>  CONFIG_STAGING_BOARD=3Dy
> -CONFIG_MFD_CROS_EC=3Dm
> +CONFIG_MFD_CROS_EC_DEV=3Dm
>  CONFIG_CROS_EC_I2C=3Dm
>  CONFIG_CROS_EC_SPI=3Dm
>  CONFIG_COMMON_CLK_MAX77686=3Dy
> @@ -1118,3 +1118,6 @@ CONFIG_CMA_SIZE_MBYTES=3D64
>  CONFIG_PRINTK_TIME=3Dy
>  CONFIG_MAGIC_SYSRQ=3Dy
>  CONFIG_DEBUG_FS=3Dy
> +CONFIG_CHROME_PLATFORMS=3Dy
> +CONFIG_CROS_EC=3Dm
> +CONFIG_CROS_EC_CHARDEV=3Dm
> diff --git a/arch/arm/configs/pxa_defconfig b/arch/arm/configs/pxa_defcon=
fig
> index b817c57f05f1..f1b084ace88d 100644
> --- a/arch/arm/configs/pxa_defconfig
> +++ b/arch/arm/configs/pxa_defconfig
> @@ -393,7 +393,9 @@ CONFIG_SA1100_WATCHDOG=3Dm
>  CONFIG_MFD_AS3711=3Dy
>  CONFIG_MFD_BCM590XX=3Dm
>  CONFIG_MFD_AXP20X=3Dy
> -CONFIG_MFD_CROS_EC=3Dm
> +CONFIG_MFD_CROS_EC_DEV=3Dm
> +CONFIG_CHROME_PLATFORMS=3Dy
> +CONFIG_CROS_EC=3Dm
>  CONFIG_CROS_EC_I2C=3Dm
>  CONFIG_CROS_EC_SPI=3Dm
>  CONFIG_MFD_ASIC3=3Dy
> diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra_de=
fconfig
> index a27592d3b1fa..7bfae67d2016 100644
> --- a/arch/arm/configs/tegra_defconfig
> +++ b/arch/arm/configs/tegra_defconfig
> @@ -147,7 +147,7 @@ CONFIG_SENSORS_LM95245=3Dy
>  CONFIG_WATCHDOG=3Dy
>  CONFIG_TEGRA_WATCHDOG=3Dy
>  CONFIG_MFD_AS3722=3Dy
> -CONFIG_MFD_CROS_EC=3Dy
> +CONFIG_MFD_CROS_EC_DEV=3Dy
>  CONFIG_MFD_MAX8907=3Dy
>  CONFIG_MFD_STMPE=3Dy
>  CONFIG_MFD_PALMAS=3Dy
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 905109f6814f..2095e61c8665 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -705,9 +705,12 @@ CONFIG_VIRTIO_BALLOON=3Dy
>  CONFIG_VIRTIO_MMIO=3Dy
>  CONFIG_XEN_GNTDEV=3Dy
>  CONFIG_XEN_GRANT_DEV_ALLOC=3Dy
> -CONFIG_MFD_CROS_EC=3Dy
> +CONFIG_MFD_CROS_EC_DEV=3Dy
> +CONFIG_CHROME_PLATFORMS=3Dy
> +CONFIG_CROS_EC=3Dy
>  CONFIG_CROS_EC_I2C=3Dy
>  CONFIG_CROS_EC_SPI=3Dy
> +CONFIG_CROS_EC_CHARDEV=3Dm
>  CONFIG_COMMON_CLK_RK808=3Dy
>  CONFIG_COMMON_CLK_SCPI=3Dy
>  CONFIG_COMMON_CLK_CS2000_CP=3Dy
> --
> 2.25.1
>
