Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF55C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 09:17:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BC8E2068D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 09:17:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WvfWywp4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbgFCJRs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 05:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgFCJRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 05:17:47 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF8CC05BD43;
        Wed,  3 Jun 2020 02:17:46 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id k22so1415138qtm.6;
        Wed, 03 Jun 2020 02:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=84iaa6ox5weH7kefZdUhLMHC+fH+BOKw3QcA2B/VmwY=;
        b=WvfWywp49Q714kxln+0+02WSqRP8wSpnNGiuDnpd+unfvOxdjThdcruD9b5rvKrQ9A
         KUvvsDPLb88ujZNbNSZcZ30zZNYNilcRuzvUTYZy9eDBQ4ToL82B9FHGIxoltgg1SdqO
         NEwvXzSadMFQwW4Am8pVQHo133JHkgZASzQNipoTowtHlZ0JWxcWgfSly0GKM0u8zid1
         unSgCpNmme60GsRbMy3tCfs7/gyljmFtX/IMnx+mouQJY8KPUKO0twYUjo767QuWpWbZ
         LnhQI8aFMQfHZqo6TYU5Etz0LKH8LcaawyYrRsFfXUh4k5DHPjDzitGGpj0usXwbm08G
         pcng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=84iaa6ox5weH7kefZdUhLMHC+fH+BOKw3QcA2B/VmwY=;
        b=t/xWeGX7WCQ+kq8y8dEckuTz7sTqqbKWi+ghucN0U2kx/J2w55xoYyZuc8nydfMynA
         /CcmetP+E3dFghbrmniP8bsD/PknN7Y/2XCMJt4lplXOnqGJp5IZFporxqV23hVGDamr
         LRl4p0b/ooi4mL4+sIJBNwsVLT4o1cg2R7s4VrweSPFydmOEE4TipsBCdEdztRBdytfW
         pT3tZjT+mms7Qb0EsYT5oC16JwpjAntlSc3iG7d3SoAlqZXNrFdE5uDr3Z/4q+9Zk7Qn
         OYFQk20IE20WuTd6H6XqWvJgLaaKC5ydq7yR807dRaKKQqrxcyvtzy6yXazoDB1I1QjB
         AZJw==
X-Gm-Message-State: AOAM533AbxvXPxej0fmqxh86GekM+Nk5K/DhmzgJa2AjJaiiU36fZM/i
        Y0X4nartEEuupqd+FVKAu3Zx44QEMf6WWkwXxFY=
X-Google-Smtp-Source: ABdhPJzTpwCjvdBNmr/2AurTsBqmgDRRKdUKkL/Y4n9mpC9/kMnCGqC9klUkvGW1xqFqbxX66ajpJHlxLVYO6sbk4Qc=
X-Received: by 2002:ac8:260b:: with SMTP id u11mr31717479qtu.380.1591175865574;
 Wed, 03 Jun 2020 02:17:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200408160044.2550437-1-arnd@arndb.de>
In-Reply-To: <20200408160044.2550437-1-arnd@arndb.de>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Wed, 3 Jun 2020 17:17:34 +0800
Message-ID: <CABOV4+WerpJqsy0-uBPBZfpnDaPn56fn0Zvv1aMUJJSjEqGhAQ@mail.gmail.com>
Subject: Re: [PATCH] [RFC] clk: sprd: fix compile-testing
To:     Arnd Bergmann <arnd@arndb.de>, sboyd@kernel.org
Cc:     catalin.marinas@arm.com, will@kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>, linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 9, 2020 at 2:57 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> I got a build failure with CONFIG_ARCH_SPRD=m when the
> main portion of the clock driver failed to get linked into
> the kernel:
>
> ERROR: modpost: "sprd_pll_sc_gate_ops" [drivers/clk/sprd/sc9863a-clk.ko] undefined!
> ERROR: modpost: "sprd_pll_ops" [drivers/clk/sprd/sc9863a-clk.ko] undefined!
> ERROR: modpost: "sprd_div_ops" [drivers/clk/sprd/sc9863a-clk.ko] undefined!
> ERROR: modpost: "sprd_comp_ops" [drivers/clk/sprd/sc9863a-clk.ko] undefined!
> ERROR: modpost: "sprd_mux_ops" [drivers/clk/sprd/sc9863a-clk.ko] undefined!
> ERROR: modpost: "sprd_gate_ops" [drivers/clk/sprd/sc9863a-clk.ko] undefined!
> ERROR: modpost: "sprd_sc_gate_ops" [drivers/clk/sprd/sc9863a-clk.ko] undefined!
> ERROR: modpost: "sprd_clk_probe" [drivers/clk/sprd/sc9863a-clk.ko] undefined!
> ERROR: modpost: "sprd_clk_regmap_init" [drivers/clk/sprd/sc9863a-clk.ko] undefined!
> ERROR: modpost: "sprd_pll_ops" [drivers/clk/sprd/sc9860-clk.ko] undefined!
> ERROR: modpost: "sprd_div_ops" [drivers/clk/sprd/sc9860-clk.ko] undefined!
> ERROR: modpost: "sprd_mux_ops" [drivers/clk/sprd/sc9860-clk.ko] undefined!
>
> This is a combination of two trivial bugs:
>
> - A platform should not be 'tristate', it should be a 'bool' symbol
>   like the other platforms, if only for consistency, and to avoid
>   surprises like this one.
>
> - The clk Makefile does not traverse into the sprd subdirectory
>   if the platform is disabled but the drivers are enabled for
>   compile-testing.
>
> Fixing either of the two would be sufficient to address the link failure,
> but for correctness, both need to be changed.
>
> Fixes: 2b1b799d7630 ("arm64: change ARCH_SPRD Kconfig to tristate")
> Fixes: d41f59fd92f2 ("clk: sprd: Add common infrastructure")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Hi,

This patch seems not been applied to next branch? I haven't seen it on
linux-next.
Arnd, can you please pick it to your tree.
In case you need my ack:
Acked-by: Chunyan Zhang <chunyan.zhang@unisoc.com>

Thanks,
Chunyan

> ---
>  arch/arm64/Kconfig.platforms | 2 +-
>  drivers/clk/Makefile         | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
> index 55d70cfe0f9e..3c7e310fd8bf 100644
> --- a/arch/arm64/Kconfig.platforms
> +++ b/arch/arm64/Kconfig.platforms
> @@ -248,7 +248,7 @@ config ARCH_TEGRA
>           This enables support for the NVIDIA Tegra SoC family.
>
>  config ARCH_SPRD
> -       tristate "Spreadtrum SoC platform"
> +       bool "Spreadtrum SoC platform"
>         help
>           Support for Spreadtrum ARM based SoCs
>
> diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
> index f4169cc2fd31..60e811d3f226 100644
> --- a/drivers/clk/Makefile
> +++ b/drivers/clk/Makefile
> @@ -105,7 +105,7 @@ obj-$(CONFIG_CLK_SIFIVE)            += sifive/
>  obj-$(CONFIG_ARCH_SIRF)                        += sirf/
>  obj-$(CONFIG_ARCH_SOCFPGA)             += socfpga/
>  obj-$(CONFIG_PLAT_SPEAR)               += spear/
> -obj-$(CONFIG_ARCH_SPRD)                        += sprd/
> +obj-y                                  += sprd/
>  obj-$(CONFIG_ARCH_STI)                 += st/
>  obj-$(CONFIG_ARCH_STRATIX10)           += socfpga/
>  obj-$(CONFIG_ARCH_SUNXI)               += sunxi/
> --
> 2.26.0
>
