Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79833C3B186
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 22:38:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4388B2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 22:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581374320;
	bh=t32JE0QwQ5xFG7CfQw/0jqZEZpeufpgLfqsDlYUyH7g=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:List-ID:From;
	b=YbrEcvTD2uzplJZPl8TZ3EflN2Au0rjJ3gPN2xtoS68S20rYowReAjYEbByIA0A3p
	 gQxf/WNIXkpv2CR0niua4nIXXSqxWMiammFXffYVvrj/egPKR6GE6CNY6t2X9PDize
	 IrhJ1xbfw+Nzvc8DNFgIASfV9Hnz6+DjWItpqrdo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727569AbgBJWij (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 17:38:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:42132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727422AbgBJWij (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 17:38:39 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 23C822072C;
        Mon, 10 Feb 2020 22:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581374318;
        bh=t32JE0QwQ5xFG7CfQw/0jqZEZpeufpgLfqsDlYUyH7g=;
        h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
        b=mkGl0Y/H7+dXMRabvHhLPPjq+rZueI2K+k1Gmd3pBO3oriGnP4aH9T0Psx+0tcfEw
         YN62mNRsHAKsQ+qEm6lh6lzFHOUNvwjWmEmm+OR/64tQkfDE3Jm3NxYTyuXLJchlsf
         5kae0OQVPN5owza0USiyqPP9EjWgqROHucpsvtec=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1580823277-13644-5-git-send-email-peng.fan@nxp.com>
References: <1580823277-13644-1-git-send-email-peng.fan@nxp.com> <1580823277-13644-5-git-send-email-peng.fan@nxp.com>
Subject: Re: [PATCH 4/7] clk: imx: add imx_hw_clk_cpuv2 for i.MX7ULP
From:   Stephen Boyd <sboyd@kernel.org>
To:     abel.vesa@nxp.com, aisheng.dong@nxp.com, leonard.crestez@nxp.com,
        peng.fan@nxp.com, s.hauer@pengutronix.de, shawnguo@kernel.org
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        ping.bai@nxp.com, Anson.Huang@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Date:   Mon, 10 Feb 2020 14:38:37 -0800
Message-ID: <158137431730.121156.17920534869042984062@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting peng.fan@nxp.com (2020-02-04 05:34:34)
> From: Peng Fan <peng.fan@nxp.com>
>=20
> Add a clk api for i.MX7ULP ARM core clk usage.
> imx_hw_clk_cpu could not be reused, because i.MX7ULP ARM core
> clk has totally different design. To simplify ARM core clk
> change logic, add a new clk api.
>=20
> A draft picture to show the ARM core clock.
>                                                       |-sirc
>      |->   run(500MHz)    ->  div -> mux -------------|-firc
>   ARM|                                                |
>      |->   hsrun(720MHz)  ->  hs div -> hs mux -------|-spll pfd
>                                                       |-....
>=20
> Need to configure PMC when ARM core runs in HSRUN or RUN mode.
>=20
> RUN and HSRUN related registers are not same, but their
> mux has same clocks as input.
>=20
> The API takes arm core, div, hs div, mux, hs mux, mux parent, pfd, step
> as params for switch clk freq.
>=20
> When set rate, need to switch mux to take firc as input, then
> set spll pfd freq, then switch back mux to spll pfd as parent.
>=20
> Per i.MX7ULP requirement, when clk runs in HSRUN mode, it could
> only support arm core wfi idle, so add pm qos to support it.
>=20
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/clk/imx/Makefile    |   1 +
>  drivers/clk/imx/clk-cpuv2.c | 137 ++++++++++++++++++++++++++++++++++++++=
++++++
>  drivers/clk/imx/clk.h       |   9 +++
>  3 files changed, 147 insertions(+)
>  create mode 100644 drivers/clk/imx/clk-cpuv2.c
>=20
> diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
> index 928f874c73d2..9707fef8da98 100644
> --- a/drivers/clk/imx/Makefile
> +++ b/drivers/clk/imx/Makefile
> @@ -5,6 +5,7 @@ obj-$(CONFIG_MXC_CLK) +=3D \
>         clk-busy.o \
>         clk-composite-8m.o \
>         clk-cpu.o \
> +       clk-cpuv2.o \
>         clk-composite-7ulp.o \
>         clk-divider-gate.o \
>         clk-fixup-div.o \
> diff --git a/drivers/clk/imx/clk-cpuv2.c b/drivers/clk/imx/clk-cpuv2.c
> new file mode 100644
> index 000000000000..a73d97a782aa
> --- /dev/null
> +++ b/drivers/clk/imx/clk-cpuv2.c
> @@ -0,0 +1,137 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright 2020 NXP
> + *
> + * Peng Fan <peng.fan@nxp.com>
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/clk-provider.h>
> +#include <linux/slab.h>
> +#include <linux/pm_qos.h>
> +#include "clk.h"
> +
> +static struct pm_qos_request pm_qos_hsrun;
> +
> +#define MAX_NORMAL_RUN_FREQ    528000000
> +
> +struct clk_cpu {
> +       struct clk_hw   hw;
> +       struct clk_hw   *core;
> +       struct clk_hw   *div_nor;
> +       struct clk_hw   *div_hs;
> +       struct clk_hw   *mux_nor;
> +       struct clk_hw   *mux_hs;
> +       struct clk_hw   *mux_parent;
> +       struct clk_hw   *pfd;
> +       struct clk_hw   *step;
> +};
> +
> +static inline struct clk_cpu *to_clk_cpu(struct clk_hw *hw)
> +{
> +       return container_of(hw, struct clk_cpu, hw);
> +}
> +
> +static unsigned long clk_cpu_recalc_rate(struct clk_hw *hw,
> +                                        unsigned long parent_rate)
> +{
> +       struct clk_cpu *cpu =3D to_clk_cpu(hw);
> +
> +       return clk_hw_get_rate(cpu->core);
> +}
> +
> +static long clk_cpu_round_rate(struct clk_hw *hw, unsigned long rate,
> +                              unsigned long *prate)
> +{
> +       return rate;
> +}
> +
> +static int clk_cpu_set_rate(struct clk_hw *hw, unsigned long rate,
> +                           unsigned long parent_rate)
> +{
> +       struct clk_cpu *cpu =3D to_clk_cpu(hw);
> +       int ret;
> +       struct clk_hw *div, *mux_now;
> +       unsigned long old_rate =3D clk_hw_get_rate(cpu->core);
> +
> +       div =3D clk_hw_get_parent(cpu->core);
> +
> +       if (div =3D=3D cpu->div_nor)
> +               mux_now =3D cpu->mux_nor;
> +       else
> +               mux_now =3D cpu->mux_hs;
> +
> +       ret =3D clk_hw_set_parent(mux_now, cpu->step);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D clk_set_rate(cpu->pfd->clk, rate);
> +       if (ret) {
> +               clk_hw_set_parent(mux_now, cpu->mux_parent);
> +               return ret;
> +       }
> +
> +       if (rate > MAX_NORMAL_RUN_FREQ) {
> +               pm_qos_add_request(&pm_qos_hsrun, PM_QOS_CPU_DMA_LATENCY,=
 0);
> +               clk_hw_set_parent(cpu->mux_hs, cpu->mux_parent);
> +               clk_hw_set_parent(cpu->core, cpu->div_hs);
> +       } else {
> +               clk_hw_set_parent(cpu->mux_nor, cpu->mux_parent);
> +               clk_hw_set_parent(cpu->core, cpu->div_nor);
> +               if (old_rate > MAX_NORMAL_RUN_FREQ)
> +                       pm_qos_remove_request(&pm_qos_hsrun);
> +       }
> +

This is a cpufreq driver. Please write a cpufreq driver instead of
trying to make "clk_set_rate()" conform to the requirements that
cpufreq-dt mandates, which is that one clk exists and that clk rate
change changes the frequency of the CPU.

If cpufreq-dt can work with the clk framework is up to the
implementation of the hardware and the software. From what I see here,
the clk framework is being subverted through the use of
clk_hw_set_parent() and clk_set_rate() calls from within the framework
to make the cpufreq-dt driver happy. Don't do that. Either write a
proper clk driver for the clks that are there and have that manage the
clk tree when clk_set_rate() is called, or write a cpufreq driver that
controls various clks and adjusts their frequencies.

I assume there is a mux or something that eventually clks the CPU, so
that can certainly be modeled as a clk with the parents set some way.
That will make clk_set_rate() mostly work as long as you can hardcode a
min/max value to change the parents, etc. Should work!

The use of pm_qos_add_request() is also pretty horrifying. We're deep in
the clk framework implementation here and we're calling out to pm_qos.
That shouldn't need to happen. If anything, we should do that from the
core framework, but I don't know why we would. It's probably some sort
of cpufreq thing.
