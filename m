Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFEECC433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 03:04:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C03420720
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 03:04:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iCYB/lVV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbgGBDEe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 23:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbgGBDEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 23:04:33 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6543C08C5C1;
        Wed,  1 Jul 2020 20:04:32 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id lx13so8676380ejb.4;
        Wed, 01 Jul 2020 20:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FpIuHqd5KI6HhW+opWkcagnunsZmxTBUoBCE/7zJhkA=;
        b=iCYB/lVVT1+NqE8FFtNgxtUN5LmFUeytp9Rpw3DZeYc5LjMItcIq1ohzRm58IbVtTW
         /hjKz+BYT/YvS4Pj3iiXrrmXgWBZSya2jDg/413SN7BJHpfm//HiiSJeOLWimYTU40mz
         IBBvrWxz3FhcJ5yBkSKR61eRLvYdPOis8u7S9NZAXtlur/N7XqMHXXPrchxnpmffza20
         dsn0Xap8kRJlqGbpMPakbb4YrenE1AVyDYsz4o9V/LnN52XICW4ud/m6q4cWz+eEQn5H
         Qmtc8UyT1vds9jSZhmdUbEhxJ4jDlQv5Zrwj8uwqV2I+jBu/oYdelfjboQYeN5bX20cD
         oTzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FpIuHqd5KI6HhW+opWkcagnunsZmxTBUoBCE/7zJhkA=;
        b=GjSoQIcVOCtugrpVLs8uvOrckiXsr5isl5EcONXeXolrhuLHZzUqz306HcLRhac6UL
         QRVRbNHp+FnSZgSs/NQBr64mRGDHbiYL3YVCz9NTyHd1f1rgo4qxg579dOBMCK2+Zruh
         QJfS8zd6z5aRuQMn6rjASwu9v7WqCmqzZt10T7IrvjjFSaNjHstEzWDUowyvi6l+QJUB
         cT0ZXmz0WTCHEUjiQVfFLmI6oKYnRF6RooJnB206F4lTxW+zWykGUqpKnUq4oS75YMol
         rOujyFZHaHZ+k5hj41p/IeJtP9u7uFLsrdJlqe78RedKZzZOBr9bZNXHrKlxcJegMzbR
         9kMA==
X-Gm-Message-State: AOAM530b0GWsp4QZT62FZdouvPJ5EigztWXxyzdT15lqr9l42ER1KkYH
        b5RJoCAlqTfy+AMysrRei7PRnanETHm6vcP2teU=
X-Google-Smtp-Source: ABdhPJyfRvLHV/l0UeMHzlZLrAQi70tnWENql2mOJF2FUMsN98RD9JUFZZyLiW9zApryEsuPY7Vd6YLscXuu0I6PMEQ=
X-Received: by 2002:a17:906:6d56:: with SMTP id a22mr26516414ejt.440.1593659071611;
 Wed, 01 Jul 2020 20:04:31 -0700 (PDT)
MIME-Version: 1.0
References: <1593656074-10092-1-git-send-email-Anson.Huang@nxp.com> <1593656074-10092-4-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1593656074-10092-4-git-send-email-Anson.Huang@nxp.com>
From:   Dong Aisheng <dongas86@gmail.com>
Date:   Thu, 2 Jul 2020 10:50:30 +0800
Message-ID: <CAA+hA=S0G7Na0ieEpPq3aN6GN1BEHtYp9vbF9x2tjmknDSVjZw@mail.gmail.com>
Subject: Re: [PATCH V4 3/5] clk: imx: Support building i.MX common clock
 driver as module
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Peng Fan <peng.fan@nxp.com>, Arnd Bergmann <arnd@arndb.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fugang Duan <fugang.duan@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-clk <linux-clk@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <Linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 2, 2020 at 10:19 AM Anson Huang <Anson.Huang@nxp.com> wrote:
>
> There are more and more requirements of building SoC specific drivers
> as modules, add support for building i.MX common clock driver as module
> to meet the requirement.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> Changes since V3:
>         - ONLY include __setup_param() build for built-in, module build no need
>           to have it.
> ---
>  drivers/clk/imx/Kconfig            |  8 ++++++--
>  drivers/clk/imx/Makefile           | 40 +++++++++++++++++++-------------------
>  drivers/clk/imx/clk-composite-8m.c |  2 ++
>  drivers/clk/imx/clk-cpu.c          |  2 ++
>  drivers/clk/imx/clk-frac-pll.c     |  2 ++
>  drivers/clk/imx/clk-gate2.c        |  2 ++
>  drivers/clk/imx/clk-pll14xx.c      |  5 +++++
>  drivers/clk/imx/clk-sscg-pll.c     |  2 ++
>  drivers/clk/imx/clk.c              | 22 +++++++++++++++------
>  9 files changed, 57 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/clk/imx/Kconfig b/drivers/clk/imx/Kconfig
> index 09fc8ad..f6ddf76 100644
> --- a/drivers/clk/imx/Kconfig
> +++ b/drivers/clk/imx/Kconfig
> @@ -1,8 +1,8 @@
>  # SPDX-License-Identifier: GPL-2.0
>  # common clock support for NXP i.MX SoC family.
>  config MXC_CLK
> -       bool
> -       def_bool ARCH_MXC
> +       tristate "IMX clock"
> +       depends on ARCH_MXC
>
>  config MXC_CLK_SCU
>         bool
> @@ -101,24 +101,28 @@ config CLK_VF610
>  config CLK_IMX8MM
>         bool "IMX8MM CCM Clock Driver"
>         depends on ARCH_MXC
> +       select MXC_CLK
>         help
>             Build the driver for i.MX8MM CCM Clock Driver
>
>  config CLK_IMX8MN
>         bool "IMX8MN CCM Clock Driver"
>         depends on ARCH_MXC
> +       select MXC_CLK
>         help
>             Build the driver for i.MX8MN CCM Clock Driver
>
>  config CLK_IMX8MP
>         bool "IMX8MP CCM Clock Driver"
>         depends on ARCH_MXC
> +       select MXC_CLK
>         help
>             Build the driver for i.MX8MP CCM Clock Driver
>
>  config CLK_IMX8MQ
>         bool "IMX8MQ CCM Clock Driver"
>         depends on ARCH_MXC
> +       select MXC_CLK
>         help
>             Build the driver for i.MX8MQ CCM Clock Driver
>
> diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
> index 394ade7..17f5d12 100644
> --- a/drivers/clk/imx/Makefile
> +++ b/drivers/clk/imx/Makefile
> @@ -1,25 +1,25 @@
>  # SPDX-License-Identifier: GPL-2.0
>
> -obj-$(CONFIG_MXC_CLK) += \
> -       clk.o \
> -       clk-busy.o \
> -       clk-composite-8m.o \
> -       clk-cpu.o \
> -       clk-composite-7ulp.o \
> -       clk-divider-gate.o \
> -       clk-fixup-div.o \
> -       clk-fixup-mux.o \
> -       clk-frac-pll.o \
> -       clk-gate-exclusive.o \
> -       clk-gate2.o \
> -       clk-pfd.o \
> -       clk-pfdv2.o \
> -       clk-pllv1.o \
> -       clk-pllv2.o \
> -       clk-pllv3.o \
> -       clk-pllv4.o \
> -       clk-sscg-pll.o \
> -       clk-pll14xx.o
> +mxc-clk-objs += clk.o
> +mxc-clk-objs += clk-busy.o
> +mxc-clk-objs += clk-composite-7ulp.o
> +mxc-clk-objs += clk-composite-8m.o
> +mxc-clk-objs += clk-cpu.o
> +mxc-clk-objs += clk-divider-gate.o
> +mxc-clk-objs += clk-fixup-div.o
> +mxc-clk-objs += clk-fixup-mux.o
> +mxc-clk-objs += clk-frac-pll.o
> +mxc-clk-objs += clk-gate2.o
> +mxc-clk-objs += clk-gate-exclusive.o
> +mxc-clk-objs += clk-pfd.o
> +mxc-clk-objs += clk-pfdv2.o
> +mxc-clk-objs += clk-pllv1.o
> +mxc-clk-objs += clk-pllv2.o
> +mxc-clk-objs += clk-pllv3.o
> +mxc-clk-objs += clk-pllv4.o
> +mxc-clk-objs += clk-pll14xx.o
> +mxc-clk-objs += clk-sscg-pll.o
> +obj-$(CONFIG_MXC_CLK) += mxc-clk.o
>
>  obj-$(CONFIG_MXC_CLK_SCU) += \
>         clk-scu.o \
> diff --git a/drivers/clk/imx/clk-composite-8m.c b/drivers/clk/imx/clk-composite-8m.c
> index d2b5af8..78fb7e5 100644
> --- a/drivers/clk/imx/clk-composite-8m.c
> +++ b/drivers/clk/imx/clk-composite-8m.c
> @@ -5,6 +5,7 @@
>
>  #include <linux/clk-provider.h>
>  #include <linux/errno.h>
> +#include <linux/export.h>
>  #include <linux/io.h>
>  #include <linux/slab.h>
>
> @@ -243,3 +244,4 @@ struct clk_hw *imx8m_clk_hw_composite_flags(const char *name,
>         kfree(mux);
>         return ERR_CAST(hw);
>  }
> +EXPORT_SYMBOL_GPL(imx8m_clk_hw_composite_flags);
> diff --git a/drivers/clk/imx/clk-cpu.c b/drivers/clk/imx/clk-cpu.c
> index cb182be..cb6ca4c 100644
> --- a/drivers/clk/imx/clk-cpu.c
> +++ b/drivers/clk/imx/clk-cpu.c
> @@ -5,6 +5,7 @@
>
>  #include <linux/clk.h>
>  #include <linux/clk-provider.h>
> +#include <linux/export.h>
>  #include <linux/slab.h>
>  #include "clk.h"
>
> @@ -104,3 +105,4 @@ struct clk_hw *imx_clk_hw_cpu(const char *name, const char *parent_name,
>
>         return hw;
>  }
> +EXPORT_SYMBOL_GPL(imx_clk_hw_cpu);
> diff --git a/drivers/clk/imx/clk-frac-pll.c b/drivers/clk/imx/clk-frac-pll.c
> index 101e0a3..c703056 100644
> --- a/drivers/clk/imx/clk-frac-pll.c
> +++ b/drivers/clk/imx/clk-frac-pll.c
> @@ -10,6 +10,7 @@
>
>  #include <linux/clk-provider.h>
>  #include <linux/err.h>
> +#include <linux/export.h>
>  #include <linux/io.h>
>  #include <linux/iopoll.h>
>  #include <linux/slab.h>
> @@ -233,3 +234,4 @@ struct clk_hw *imx_clk_hw_frac_pll(const char *name,
>
>         return hw;
>  }
> +EXPORT_SYMBOL_GPL(imx_clk_hw_frac_pll);
> diff --git a/drivers/clk/imx/clk-gate2.c b/drivers/clk/imx/clk-gate2.c
> index b87ab3c..512f675 100644
> --- a/drivers/clk/imx/clk-gate2.c
> +++ b/drivers/clk/imx/clk-gate2.c
> @@ -7,6 +7,7 @@
>   */
>
>  #include <linux/clk-provider.h>
> +#include <linux/export.h>
>  #include <linux/module.h>
>  #include <linux/slab.h>
>  #include <linux/io.h>
> @@ -177,3 +178,4 @@ struct clk_hw *clk_hw_register_gate2(struct device *dev, const char *name,
>
>         return hw;
>  }
> +EXPORT_SYMBOL_GPL(clk_hw_register_gate2);
> diff --git a/drivers/clk/imx/clk-pll14xx.c b/drivers/clk/imx/clk-pll14xx.c
> index f9eb189..f5c3e7e 100644
> --- a/drivers/clk/imx/clk-pll14xx.c
> +++ b/drivers/clk/imx/clk-pll14xx.c
> @@ -6,6 +6,7 @@
>  #include <linux/bitops.h>
>  #include <linux/clk-provider.h>
>  #include <linux/err.h>
> +#include <linux/export.h>
>  #include <linux/io.h>
>  #include <linux/iopoll.h>
>  #include <linux/slab.h>
> @@ -68,6 +69,7 @@ struct imx_pll14xx_clk imx_1443x_pll = {
>         .rate_table = imx_pll1443x_tbl,
>         .rate_count = ARRAY_SIZE(imx_pll1443x_tbl),
>  };
> +EXPORT_SYMBOL_GPL(imx_1443x_pll);
>
>  struct imx_pll14xx_clk imx_1443x_dram_pll = {
>         .type = PLL_1443X,
> @@ -75,12 +77,14 @@ struct imx_pll14xx_clk imx_1443x_dram_pll = {
>         .rate_count = ARRAY_SIZE(imx_pll1443x_tbl),
>         .flags = CLK_GET_RATE_NOCACHE,
>  };
> +EXPORT_SYMBOL_GPL(imx_1443x_dram_pll);
>
>  struct imx_pll14xx_clk imx_1416x_pll = {
>         .type = PLL_1416X,
>         .rate_table = imx_pll1416x_tbl,
>         .rate_count = ARRAY_SIZE(imx_pll1416x_tbl),
>  };
> +EXPORT_SYMBOL_GPL(imx_1416x_pll);
>
>  static const struct imx_pll14xx_rate_table *imx_get_pll_settings(
>                 struct clk_pll14xx *pll, unsigned long rate)
> @@ -436,3 +440,4 @@ struct clk_hw *imx_dev_clk_hw_pll14xx(struct device *dev, const char *name,
>
>         return hw;
>  }
> +EXPORT_SYMBOL_GPL(imx_dev_clk_hw_pll14xx);
> diff --git a/drivers/clk/imx/clk-sscg-pll.c b/drivers/clk/imx/clk-sscg-pll.c
> index 773d8a5..9d6cdff 100644
> --- a/drivers/clk/imx/clk-sscg-pll.c
> +++ b/drivers/clk/imx/clk-sscg-pll.c
> @@ -10,6 +10,7 @@
>
>  #include <linux/clk-provider.h>
>  #include <linux/err.h>
> +#include <linux/export.h>
>  #include <linux/io.h>
>  #include <linux/iopoll.h>
>  #include <linux/slab.h>
> @@ -537,3 +538,4 @@ struct clk_hw *imx_clk_hw_sscg_pll(const char *name,
>
>         return hw;
>  }
> +EXPORT_SYMBOL_GPL(imx_clk_hw_sscg_pll);
> diff --git a/drivers/clk/imx/clk.c b/drivers/clk/imx/clk.c
> index 87ab8db..6f2a94d 100644
> --- a/drivers/clk/imx/clk.c
> +++ b/drivers/clk/imx/clk.c
> @@ -3,6 +3,7 @@
>  #include <linux/clk-provider.h>
>  #include <linux/err.h>
>  #include <linux/io.h>
> +#include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/slab.h>
>  #include <linux/spinlock.h>
> @@ -13,6 +14,7 @@
>  #define CCDR_MMDC_CH1_MASK             BIT(16)
>
>  DEFINE_SPINLOCK(imx_ccm_lock);
> +EXPORT_SYMBOL_GPL(imx_ccm_lock);
>
>  void imx_unregister_clocks(struct clk *clks[], unsigned int count)
>  {
> @@ -29,8 +31,9 @@ void imx_unregister_hw_clocks(struct clk_hw *hws[], unsigned int count)
>         for (i = 0; i < count; i++)
>                 clk_hw_unregister(hws[i]);
>  }
> +EXPORT_SYMBOL_GPL(imx_unregister_hw_clocks);
>
> -void __init imx_mmdc_mask_handshake(void __iomem *ccm_base,
> +void imx_mmdc_mask_handshake(void __iomem *ccm_base,
>                                     unsigned int chn)
>  {
>         unsigned int reg;
> @@ -59,8 +62,9 @@ void imx_check_clk_hws(struct clk_hw *clks[], unsigned int count)
>                         pr_err("i.MX clk %u: register failed with %ld\n",
>                                i, PTR_ERR(clks[i]));
>  }
> +EXPORT_SYMBOL_GPL(imx_check_clk_hws);
>
> -static struct clk * __init imx_obtain_fixed_clock_from_dt(const char *name)
> +static struct clk *imx_obtain_fixed_clock_from_dt(const char *name)
>  {
>         struct of_phandle_args phandle;
>         struct clk *clk = ERR_PTR(-ENODEV);
> @@ -80,7 +84,7 @@ static struct clk * __init imx_obtain_fixed_clock_from_dt(const char *name)
>         return clk;
>  }
>
> -struct clk * __init imx_obtain_fixed_clock(
> +struct clk *imx_obtain_fixed_clock(
>                         const char *name, unsigned long rate)
>  {
>         struct clk *clk;
> @@ -91,7 +95,7 @@ struct clk * __init imx_obtain_fixed_clock(
>         return clk;
>  }
>
> -struct clk_hw * __init imx_obtain_fixed_clock_hw(
> +struct clk_hw *imx_obtain_fixed_clock_hw(
>                         const char *name, unsigned long rate)
>  {
>         struct clk *clk;
> @@ -113,6 +117,7 @@ struct clk_hw * imx_obtain_fixed_clk_hw(struct device_node *np,
>
>         return __clk_get_hw(clk);
>  }
> +EXPORT_SYMBOL_GPL(imx_obtain_fixed_clk_hw);
>
>  /*
>   * This fixups the register CCM_CSCMR1 write value.
> @@ -143,16 +148,18 @@ void imx_cscmr1_fixup(u32 *val)
>  static int imx_keep_uart_clocks;
>  static struct clk ** const *imx_uart_clocks;
>
> -static int __init imx_keep_uart_clocks_param(char *str)
> +static int __maybe_unused imx_keep_uart_clocks_param(char *str)
>  {
>         imx_keep_uart_clocks = 1;
>
>         return 0;
>  }
> +#ifndef MODULE
>  __setup_param("earlycon", imx_keep_uart_earlycon,
>               imx_keep_uart_clocks_param, 0);
>  __setup_param("earlyprintk", imx_keep_uart_earlyprintk,
>               imx_keep_uart_clocks_param, 0);

I feel not only the __setup_param, the whole logic of keep_uart_clocks
are not needed for Module case. Is it true?

Regards
Aisheng

> +#endif
>
>  void imx_register_uart_clocks(struct clk ** const clks[])
>  {
> @@ -164,8 +171,9 @@ void imx_register_uart_clocks(struct clk ** const clks[])
>                         clk_prepare_enable(*imx_uart_clocks[i]);
>         }
>  }
> +EXPORT_SYMBOL_GPL(imx_register_uart_clocks);
>
> -static int __init imx_clk_disable_uart(void)
> +static int imx_clk_disable_uart(void)
>  {
>         if (imx_keep_uart_clocks && imx_uart_clocks) {
>                 int i;
> @@ -177,3 +185,5 @@ static int __init imx_clk_disable_uart(void)
>         return 0;
>  }
>  late_initcall_sync(imx_clk_disable_uart);
> +
> +MODULE_LICENSE("GPL v2");
> --
> 2.7.4
>
