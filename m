Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB360C18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 15:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A15D8215A4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 15:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583854219;
	bh=x9TTahJxeurA/dj2Lv1aiCuQmJlmVgZLVjy7+fgJVAs=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=KZYR+crFfofFWtnkWZ2aytYxdHNAqy1gQXkZlsbP3g76i0iNDIU1Q8MVs8xGHmsJd
	 szHQyGrs4aKBNXmKEZ2O1iSLOKmf9dS25+87fcM7MsGKSFDlFjme2qW+5iEHVT4GDE
	 52iM39hO8SuctU5Mn2jKbiAZ34v+f4aobqBVUjlA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgCJPaS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 11:30:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:51416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726269AbgCJPaS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 11:30:18 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E467620578;
        Tue, 10 Mar 2020 15:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583854216;
        bh=x9TTahJxeurA/dj2Lv1aiCuQmJlmVgZLVjy7+fgJVAs=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=ujoeTcG5YxNtIUP5KoYndnrjlN910E1kmF3TVlZmy0Io2ZocEsUqtOSSO2QIqCdmZ
         5Y9yCWJEFpNjVs90Tr3woBiR14yvY+EPYyUC6DQjzs4MMnCWXXFJSFxRHeVIQbZyVf
         oZNo92Sn7Y7ywv/T+v4LNxbfRLyol5CozeExj1OU=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200306130058.27F388030797@mail.baikalelectronics.ru>
References: <20200306130048.8868-1-Sergey.Semin@baikalelectronics.ru> <20200306130058.27F388030797@mail.baikalelectronics.ru>
Subject: Re: [PATCH 4/5] clk: Add Baikal-T1 CCU PLLs driver
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
To:     Michael Turquette <mturquette@baylibre.com>,
        Sergey.Semin@baikalelectronics.ru
Date:   Tue, 10 Mar 2020 08:30:15 -0700
Message-ID: <158385421510.149997.8848277501063917345@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sergey.Semin@baikalelectronics.ru (2020-03-06 05:00:47)
> From: Serge Semin <Sergey.Semin@baikalelectronics.ru>
>=20
> Baikal-T1 is supposed to be supplied with a high-frequency external
> oscillator. But in order to create signals suitable for each IP-block
> embedded into the SoC the oscillator output is primarily connected to
> a set of CCU PLLs. There are five of them to create clocks for the MIPS
> P5600 cores, the embedded DDR controller, SATA, Ethernet and PCIe
> domains. The last three domains though named by the biggest system
> interfaces in fact include nearly all of the rest SoC peripherals.
> Each of the PLLs is based on True Circuits TSMC CLN28HPM IP-core with
> an interface wrapper (so called safe PLL' clocks switcher) to simplify
> the PLL configuration procedure.
>=20
> This driver creates the of-based hardware clocks to use them then in
> the corresponding subsystems. In order to simplify the driver code we
> split the functionality up into the PLLs clocks operations and hardware
> clocks declaration/registration procedures. So if CLK_BT1_CCU is
> defined, then the first part is available in the kernel, while
> CLK_BT1_CCU_PLL config makes the actual clocks being registered at the
> time of_clk_init() is called.
>=20
> Even though the PLLs are based on the same IP-core, they actually may
> have some differences. In particular, some CCU PLLs supports the output
> clock change without gating them (like CPU or PCIe PLLs), while the
> others don't, some CCU PLLs are critical and aren't supposed to be
> gated. In order to cover all of these cases the hardware clocks driver
> is designed with a info-descriptor pattern. So there are special static
> descriptors declared for each PLL, which is then used to create a
> hardware clock with proper operations. Additionally debugfs-files are
> provided for each PLL' field to make sure the implemented
> rate-PLLs-dividers calculation algorithm is correct.
>=20
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Signed-off-by: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: Paul Burton <paulburton@kernel.org>
> Cc: Ralf Baechle <ralf@linux-mips.org>

> diff --git a/drivers/clk/baikal-t1/Kconfig b/drivers/clk/baikal-t1/Kconfig
> new file mode 100644
> index 000000000000..0e2fc86f3ab8
> --- /dev/null
> +++ b/drivers/clk/baikal-t1/Kconfig
> @@ -0,0 +1,35 @@
> +# SPDX-License-Identifier: GPL-2.0
> +config CLK_BAIKAL_T1
> +       bool "Baikal-T1 Clocks Control Unit interface"
> +       depends on (MIPS_BAIKAL_T1 || COMPILE_TEST) && OF

Does it actually depend on OF for any compilation?

> +       default y

Please no default y. Maybe default MIPS_BAIKAL_T1?

> +       help
> +         Clocks Control Unit is the core of Baikal-T1 SoC responsible fo=
r the
> +         chip subsystems clocking and resetting. It consists of multiple
> +         global clock domains, which can be reset by means of the CCU co=
ntrol
> +         registers. These domains and devices placed in them are fed with
> +         clocks generated by a hierarchy of PLLs, configurable and fixed
> +         dividers. In addition CCU exposes several unrelated functional =
blocks
> +         like irqless Designware i2c controller with indirectly accessed
> +         registers, AXI bus errors detector, DW PCIe controller PM/clock=
s/reset
> +         manager, etc.
> +
> +         This driver provides a set of functions to create the kernel cl=
ock
> +         devices of Baikal-T1 PLLs and dividers, and to manipulate the r=
eset
> +         signals of the SoC.
> +
> +if CLK_BAIKAL_T1
> +
> +config CLK_BT1_CCU_PLL
> +       bool "Baikal-T1 CCU PLLs support"
> +       default y

default MIPS_BAIKAL_T1?

> +       help
> +         Enable this to support the PLLs embedded into the Baikal-T1 SoC=
s.
> +         These are five PLLs placed at the root of the clocks hierarchy,
> +         right after the external reference osciallator (normally of 25M=
Hz).
> +         They are used to generate a high frequency signals, which are

s/generate a high/generate high/

> +         either directly wired to the consumers (like CPUs, DDR) or pass=
ed
> +         over the clock dividers to be only then used as an individual
> +         reference clocks of a target device.

s/clocks/clock/

> +
> +endif
> diff --git a/drivers/clk/baikal-t1/ccu-pll.c b/drivers/clk/baikal-t1/ccu-=
pll.c
> new file mode 100644
> index 000000000000..f2087a80b64d
> --- /dev/null
> +++ b/drivers/clk/baikal-t1/ccu-pll.c
> @@ -0,0 +1,474 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2019 BAIKAL ELECTRONICS, JSC
> + *
> + * Authors:
> + *   Serge Semin <Sergey.Semin@baikalelectronics.ru>
> + *   Dmitry Dunaev <dmitry.dunaev@baikalelectronics.ru>
> + *
> + * Baikal-T1 CCU PLL interface driver.
> + */
> +
> +#define pr_fmt(fmt) "bt1-ccu-pll: " fmt
> +
> +#include <linux/kernel.h>
> +#include <linux/printk.h>
> +#include <linux/limits.h>
> +#include <linux/bits.h>
> +#include <linux/slab.h>
> +#include <linux/clk-provider.h>
> +#include <linux/of.h>
> +#include <linux/spinlock.h>
> +#include <linux/delay.h>
> +#include <linux/time64.h>
> +#include <linux/rational.h>
> +#include <linux/debugfs.h>
> +
> +#include "ccu-pll.h"
> +#include "common.h"
> +
> +#define CCU_PLL_CTL                    0x00
> +#define CCU_PLL_CTL_EN                 BIT(0)
> +#define CCU_PLL_CTL_RST                        BIT(1)
> +#define CCU_PLL_CTL_CLKR_FLD           2
> +#define CCU_PLL_CTL_CLKR_MASK          GENMASK(7, CCU_PLL_CTL_CLKR_FLD)
> +#define CCU_PLL_CTL_CLKF_FLD           8
> +#define CCU_PLL_CTL_CLKF_MASK          GENMASK(20, CCU_PLL_CTL_CLKF_FLD)
> +#define CCU_PLL_CTL_CLKOD_FLD          21
> +#define CCU_PLL_CTL_CLKOD_MASK         GENMASK(24, CCU_PLL_CTL_CLKOD_FLD)
> +#define CCU_PLL_CTL_BYPASS             BIT(30)
> +#define CCU_PLL_CTL_LOCK               BIT(31)
> +#define CCU_PLL_CTL1                   0x04
> +#define CCU_PLL_CTL1_BWADJ_FLD         3
> +#define CCU_PLL_CTL1_BWADJ_MASK                GENMASK(14, CCU_PLL_CTL1_=
BWADJ_FLD)
> +
> +#define CCU_PLL_RST_DELAY_US           5
> +#define CCU_PLL_LOCK_DELAY_US(_ref_rate, _nr) ({       \
> +       uint64_t _n =3D 500ULL * (_nr) * USEC_PER_SEC;    \
> +       do_div(_n, _ref_rate);                          \
> +       _n;                                             \
> +})

Can this be a static inline function? We get to learn what the types are
then.

> +#define CCU_PLL_LOCK_CHECK_RETRIES     50
> +
> +#define CCU_PLL_NR_MAX \
> +       ((CCU_PLL_CTL_CLKR_MASK >> CCU_PLL_CTL_CLKR_FLD) + 1)
> +#define CCU_PLL_NF_MAX \
> +       ((CCU_PLL_CTL_CLKF_MASK >> (CCU_PLL_CTL_CLKF_FLD + 1)) + 1)
> +#define CCU_PLL_OD_MAX \
> +       ((CCU_PLL_CTL_CLKOD_MASK >> CCU_PLL_CTL_CLKOD_FLD) + 1)
> +#define CCU_PLL_NB_MAX \
> +       ((CCU_PLL_CTL1_BWADJ_MASK >> CCU_PLL_CTL1_BWADJ_FLD) + 1)
> +#define CCU_PLL_FDIV_MIN               427000UL
> +#define CCU_PLL_FDIV_MAX               3500000000UL
> +#define CCU_PLL_FOUT_MIN               200000000UL
> +#define CCU_PLL_FOUT_MAX               2500000000UL
> +#define CCU_PLL_FVCO_MIN               700000000UL
> +#define CCU_PLL_FVCO_MAX               3500000000UL
> +#define CCU_PLL_CLKOD_FACTOR           2
> +
> +#define CCU_PLL_CALC_FREQ(_ref_rate, _nr, _nf, _od) \
> +       ((_ref_rate) / (_nr) * (_nf) / (_od))

Static inline function please. Does this need to be 64-bit math?

> +
> +static int ccu_pll_reset(struct ccu_pll *pll, unsigned long ref_clk,
> +                        unsigned long nr)
> +{
> +       unsigned long ud;
> +       int count;
> +       u32 val;
> +
> +       ud =3D CCU_PLL_LOCK_DELAY_US(ref_clk, nr);
> +
> +       ccu_update(pll->regs + CCU_PLL_CTL, CCU_PLL_CTL_RST, CCU_PLL_CTL_=
RST);
> +
> +       count =3D CCU_PLL_LOCK_CHECK_RETRIES;
> +       do {
> +               udelay(ud);
> +               val =3D ccu_read(pll->regs + CCU_PLL_CTL);
> +       } while (!(val & CCU_PLL_CTL_LOCK) && --count);
> +
> +       return (val & CCU_PLL_CTL_LOCK) ? 0 : -ETIMEDOUT;

Looks like readl_poll_timeout().

> +}
> +
> +static int ccu_pll_enable(struct clk_hw *hw)
> +{
> +       struct clk_hw *parent_hw =3D clk_hw_get_parent(hw);
> +       struct ccu_pll *pll =3D to_ccu_pll(hw);
> +       unsigned long flags;
> +       int ret;
> +       u32 val;
> +
> +       if (!parent_hw) {
> +               pr_err("Can't enable '%s' with no parent", clk_hw_get_nam=
e(hw));
> +               return -EINVAL;
> +       }
> +
> +       val =3D ccu_read(pll->regs + CCU_PLL_CTL);
> +       if (val & CCU_PLL_CTL_EN)
> +               return 0;
> +
> +       spin_lock_irqsave(&pll->regs_lock, flags);
> +       ccu_write(pll->regs + CCU_PLL_CTL, val | CCU_PLL_CTL_EN);
> +       ret =3D ccu_pll_reset(pll, clk_hw_get_rate(parent_hw),
> +                           CCU_GET_FLD(CCU_PLL_CTL_CLKR, val) + 1);
> +       spin_unlock_irqrestore(&pll->regs_lock, flags);
> +       if (ret)
> +               pr_err("PLL '%s' reset timed out\n", clk_hw_get_name(hw));
> +
> +       return ret;
> +}
> +
> +static void ccu_pll_disable(struct clk_hw *hw)
> +{
> +       struct ccu_pll *pll =3D to_ccu_pll(hw);
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&pll->regs_lock, flags);
> +       ccu_update(pll->regs + CCU_PLL_CTL, CCU_PLL_CTL_EN, 0);
> +       spin_unlock_irqrestore(&pll->regs_lock, flags);
> +}
> +
> +static int ccu_pll_is_enabled(struct clk_hw *hw)
> +{
> +       struct ccu_pll *pll =3D to_ccu_pll(hw);
> +
> +       return !!(ccu_read(pll->regs + CCU_PLL_CTL) & CCU_PLL_CTL_EN);
> +}
> +
> +static unsigned long ccu_pll_recalc_rate(struct clk_hw *hw,
> +                                        unsigned long parent_rate)
> +{
> +       struct ccu_pll *pll =3D to_ccu_pll(hw);
> +       unsigned long nr, nf, od;
> +       u32 val;
> +
> +       val =3D ccu_read(pll->regs + CCU_PLL_CTL);
> +       nr =3D CCU_GET_FLD(CCU_PLL_CTL_CLKR, val) + 1;

We have FIELD_GET macros for this. Please use them instead of creating
your own.

> +       nf =3D CCU_GET_FLD(CCU_PLL_CTL_CLKF, val) + 1;
> +       od =3D CCU_GET_FLD(CCU_PLL_CTL_CLKOD, val) + 1;
> +
> +       return CCU_PLL_CALC_FREQ(parent_rate, nr, nf, od);
> +}
> +
> +static void ccu_pll_calc_factors(unsigned long rate, unsigned long paren=
t_rate,
> +                                unsigned long *nr, unsigned long *nf,
> +                                unsigned long *od)
> +{
> +       unsigned long err, freq, min_err =3D ULONG_MAX;
> +       unsigned long num, denom, n1, d1, nri;
> +       unsigned long nr_max, nf_max, od_max;
> +
> +       /*
> +        * Make sure PLL is working with valid input signal (Fdiv). If
> +        * you want to speed the function up just reduce CCU_PLL_NR_MAX.
> +        * This will cause a worse approximation though.
> +        */
> +       nri =3D (parent_rate / CCU_PLL_FDIV_MAX) + 1;
> +       nr_max =3D min(parent_rate / CCU_PLL_FDIV_MIN, CCU_PLL_NR_MAX);
> +
> +       /*
> +        * Find a closest [nr;nf;od] vector taking into account the
> +        * limitations like: 1) 700MHz <=3D Fvco <=3D 3.5GHz, 2) PLL Od is
> +        * either 1 or even number within the acceptable range (alas 1s
> +        * is also excluded by the next loop).
> +        */
> +       for (; nri <=3D nr_max; ++nri) {
> +               /* Use Od factor to fulfill the limitation 2). */
> +               num =3D CCU_PLL_CLKOD_FACTOR * rate;
> +               denom =3D parent_rate / nri;
> +
> +               /*
> +                * Make sure Fvco is within the acceptable range to fulfi=
ll
> +                * the condition 1). Note due to the CCU_PLL_CLKOD_FACTOR=
 value
> +                * the actual upper limit is also divided by that factor.
> +                * It's not big problem for us since practically there is=
 no
> +                * need in clocks with that high frequency.
> +                */
> +               nf_max =3D min(CCU_PLL_FVCO_MAX / denom, CCU_PLL_NF_MAX);
> +               od_max =3D CCU_PLL_OD_MAX / CCU_PLL_CLKOD_FACTOR;
> +
> +               /*
> +                * Bypass the out-of-bound values, which can't be properly
> +                * handled by the rational fraction approximation algorit=
hm.
> +                */
> +               if (num / denom >=3D nf_max) {
> +                       n1 =3D nf_max;
> +                       d1 =3D 1;
> +               } else if (denom / num >=3D od_max) {
> +                       n1 =3D 1;
> +                       d1 =3D od_max;
> +               } else {
> +                       rational_best_approximation(num, denom, nf_max, o=
d_max,
> +                                                   &n1, &d1);
> +               }
> +
> +               /* Select the best approximation of the target rate. */
> +               freq =3D (((parent_rate / nri) * n1) / d1);

Please drop extra parenthesis.

> +               err =3D abs((int64_t)freq - num);
> +               if (err < min_err) {
> +                       min_err =3D err;
> +                       *nr =3D nri;
> +                       *nf =3D n1;
> +                       *od =3D CCU_PLL_CLKOD_FACTOR * d1;
> +               }
> +       }
> +}
> +
> +static long ccu_pll_round_rate(struct clk_hw *hw, unsigned long rate,
> +                              unsigned long *parent_rate)
> +{
> +       unsigned long nr =3D 1, nf =3D 1, od =3D 1;
> +
> +       ccu_pll_calc_factors(rate, *parent_rate, &nr, &nf, &od);
> +
> +       return CCU_PLL_CALC_FREQ(*parent_rate, nr, nf, od);
> +}
> +
> +/*
> + * This method is used for PLLs, which support the on-the-fly dividers
> + * adjustment. So there is no need in gating such clocks.
> + */
> +static int ccu_pll_set_rate_reset(struct clk_hw *hw, unsigned long rate,
> +                                 unsigned long parent_rate)
> +{
> +       struct ccu_pll *pll =3D to_ccu_pll(hw);
> +       unsigned long nr, nf, od;
> +       unsigned long flags;
> +       u32 mask, val;
> +       int ret;
> +
> +       ccu_pll_calc_factors(rate, parent_rate, &nr, &nf, &od);
> +
> +       mask =3D CCU_PLL_CTL_CLKR_MASK | CCU_PLL_CTL_CLKF_MASK |
> +              CCU_PLL_CTL_CLKOD_MASK;
> +       val =3D CCU_SET_FLD(CCU_PLL_CTL_CLKR, 0, nr - 1) |
> +             CCU_SET_FLD(CCU_PLL_CTL_CLKF, 0, nf - 1) |
> +             CCU_SET_FLD(CCU_PLL_CTL_CLKOD, 0, od - 1);
> +
> +       spin_lock_irqsave(&pll->regs_lock, flags);
> +       ccu_update(pll->regs + CCU_PLL_CTL, mask, val);
> +       ret =3D ccu_pll_reset(pll, parent_rate, nr);
> +       spin_unlock_irqrestore(&pll->regs_lock, flags);
> +       if (ret)
> +               pr_err("PLL '%s' reset timed out\n", clk_hw_get_name(hw));
> +
> +       return ret;
> +}
> +
> +/*
> + * This method is used for PLLs, which don't support the on-the-fly divi=
ders
> + * adjustment. So the corresponding clocks are supposed to be gated firs=
t.
> + */
> +static int ccu_pll_set_rate_norst(struct clk_hw *hw, unsigned long rate,
> +                                 unsigned long parent_rate)
> +{
> +       struct ccu_pll *pll =3D to_ccu_pll(hw);
> +       unsigned long nr, nf, od;
> +       unsigned long flags;
> +       u32 mask, val;
> +
> +       ccu_pll_calc_factors(rate, parent_rate, &nr, &nf, &od);
> +
> +       /*
> +        * Disable PLL if it was enabled by default or left enabled by the
> +        * system bootloader.
> +        */
> +       mask =3D CCU_PLL_CTL_CLKR_MASK | CCU_PLL_CTL_CLKF_MASK |
> +              CCU_PLL_CTL_CLKOD_MASK | CCU_PLL_CTL_EN;
> +       val =3D CCU_SET_FLD(CCU_PLL_CTL_CLKR, 0, nr - 1) |
> +             CCU_SET_FLD(CCU_PLL_CTL_CLKF, 0, nf - 1) |
> +             CCU_SET_FLD(CCU_PLL_CTL_CLKOD, 0, od - 1);
> +
> +       spin_lock_irqsave(&pll->regs_lock, flags);
> +       ccu_update(pll->regs + CCU_PLL_CTL, mask, val);
> +       spin_unlock_irqrestore(&pll->regs_lock, flags);
> +
> +       return 0;
> +}
> +
> +#ifdef CONFIG_DEBUG_FS
> +
> +#define CCU_PLL_DBGFS_BIT_ATTR(_name, _reg, _mask)                     \
> +static int ccu_pll_dbgfs_##_name##_get(void *priv, u64 *val)           \
> +{                                                                      \
> +       struct ccu_pll *pll =3D priv;                                    =
 \
> +                                                                       \
> +       *val =3D !!(ccu_read(pll->regs + (_reg)) & (_mask));             =
 \
> +                                                                       \
> +       return 0;                                                       \
> +}                                                                      \
> +static int ccu_pll_dbgfs_##_name##_set(void *priv, u64 val)            \
> +{                                                                      \
> +       struct ccu_pll *pll =3D priv;                                    =
 \
> +       unsigned long flags;                                            \
> +                                                                       \
> +       spin_lock_irqsave(&pll->regs_lock, flags);                      \
> +       ccu_update(pll->regs + (_reg), (_mask), val ? (_mask) : 0);     \
> +       spin_unlock_irqrestore(&pll->regs_lock, flags);                 \
> +                                                                       \
> +       return 0;                                                       \
> +}                                                                      \
> +DEFINE_DEBUGFS_ATTRIBUTE(ccu_pll_dbgfs_##_name##_fops,                 \
> +       ccu_pll_dbgfs_##_name##_get, ccu_pll_dbgfs_##_name##_set, "%llu\n=
")
> +
> +#define CCU_PLL_DBGFS_FLD_ATTR(_name, _reg, _fld, _min, _max)          \
> +static int ccu_pll_dbgfs_##_name##_get(void *priv, u64 *val)           \
> +{                                                                      \
> +       struct ccu_pll *pll =3D priv;                                    =
 \
> +       u32 data;                                                       \
> +                                                                       \
> +       data =3D ccu_read(pll->regs + (_reg));                           =
 \
> +       *val =3D CCU_GET_FLD(_fld, data) + 1;                            =
 \
> +                                                                       \
> +       return 0;                                                       \
> +}                                                                      \
> +static int ccu_pll_dbgfs_##_name##_set(void *priv, u64 val)            \
> +{                                                                      \
> +       struct ccu_pll *pll =3D priv;                                    =
 \
> +       unsigned long flags;                                            \
> +       u32 data;                                                       \
> +                                                                       \
> +       val =3D clamp_t(u64, val, _min, _max);                           =
 \
> +       data =3D CCU_SET_FLD(_fld, 0, val - 1);                          =
 \
> +                                                                       \
> +       spin_lock_irqsave(&pll->regs_lock, flags);                      \
> +       ccu_update(pll->regs + (_reg), _fld ## _MASK, data);            \
> +       spin_unlock_irqrestore(&pll->regs_lock, flags);                 \
> +                                                                       \
> +       return 0;                                                       \
> +}                                                                      \
> +DEFINE_DEBUGFS_ATTRIBUTE(ccu_pll_dbgfs_##_name##_fops,                 \
> +       ccu_pll_dbgfs_##_name##_get, ccu_pll_dbgfs_##_name##_set, "%llu\n=
")
> +
> +CCU_PLL_DBGFS_BIT_ATTR(en, CCU_PLL_CTL, CCU_PLL_CTL_EN);
> +CCU_PLL_DBGFS_BIT_ATTR(rst, CCU_PLL_CTL, CCU_PLL_CTL_RST);
> +CCU_PLL_DBGFS_FLD_ATTR(nr, CCU_PLL_CTL, CCU_PLL_CTL_CLKR, 1, CCU_PLL_NR_=
MAX);
> +CCU_PLL_DBGFS_FLD_ATTR(nf, CCU_PLL_CTL, CCU_PLL_CTL_CLKF, 1, CCU_PLL_NF_=
MAX);
> +CCU_PLL_DBGFS_FLD_ATTR(od, CCU_PLL_CTL, CCU_PLL_CTL_CLKOD, 1, CCU_PLL_OD=
_MAX);
> +CCU_PLL_DBGFS_BIT_ATTR(bypass, CCU_PLL_CTL, CCU_PLL_CTL_BYPASS);
> +CCU_PLL_DBGFS_BIT_ATTR(lock, CCU_PLL_CTL, CCU_PLL_CTL_LOCK);
> +CCU_PLL_DBGFS_FLD_ATTR(nb, CCU_PLL_CTL1, CCU_PLL_CTL1_BWADJ, 1, CCU_PLL_=
NB_MAX);
> +
> +static const struct debugfs_reg32 ccu_pll_dbgfs_regs[] =3D {
> +       CCU_DBGFS_REG("ctl", CCU_PLL_CTL),
> +       CCU_DBGFS_REG("ctl1", CCU_PLL_CTL1)
> +};
> +
> +static void ccu_pll_debug_init(struct clk_hw *hw, struct dentry *dentry)
> +{
> +       struct ccu_pll *pll =3D to_ccu_pll(hw);
> +       struct debugfs_regset32 *regset;
> +
> +       regset =3D kzalloc(sizeof(*regset), GFP_KERNEL);
> +       if (!regset)
> +               return;
> +
> +       regset->regs =3D ccu_pll_dbgfs_regs;
> +       regset->nregs =3D ARRAY_SIZE(ccu_pll_dbgfs_regs);
> +       regset->base =3D pll->regs;
> +       debugfs_create_regset32("registers", 0400, dentry, regset);
> +
> +       debugfs_create_file_unsafe("en", 0600, dentry, pll,

Why unsafe?

> +                                  &ccu_pll_dbgfs_en_fops);
> +       debugfs_create_file_unsafe("rst", 0200, dentry, pll,
> +                                  &ccu_pll_dbgfs_rst_fops);
> +       debugfs_create_file_unsafe("nr", 0600, dentry, pll,
> +                                  &ccu_pll_dbgfs_nr_fops);
> +       debugfs_create_file_unsafe("nf", 0600, dentry, pll,
> +                                  &ccu_pll_dbgfs_nf_fops);
> +       debugfs_create_file_unsafe("od", 0600, dentry, pll,
> +                                  &ccu_pll_dbgfs_od_fops);
> +       debugfs_create_file_unsafe("bypass", 0600, dentry, pll,
> +                                  &ccu_pll_dbgfs_bypass_fops);
> +       debugfs_create_file_unsafe("lock", 0400, dentry, pll,
> +                                  &ccu_pll_dbgfs_lock_fops);
> +       debugfs_create_file_unsafe("nb", 0600, dentry, pll,
> +                                  &ccu_pll_dbgfs_nb_fops);
> +}

Is there any usage of these outside of development of this driver? I'd
rather not see us expose blanket register write access with code in
debugfs. If you're interested in poking register why not use /dev/mem?

> +
> +#else /* !CONFIG_DEBUG_FS */
> +
> +#define ccu_pll_debug_init NULL
> +
> +#endif /* !CONFIG_DEBUG_FS */
> +
> +static const struct clk_ops ccu_pll_gate_to_set_ops =3D {
> +       .enable =3D ccu_pll_enable,
> +       .disable =3D ccu_pll_disable,
> +       .is_enabled =3D ccu_pll_is_enabled,
> +       .recalc_rate =3D ccu_pll_recalc_rate,
> +       .round_rate =3D ccu_pll_round_rate,
> +       .set_rate =3D ccu_pll_set_rate_norst,
> +       .debug_init =3D ccu_pll_debug_init
> +};
> +
> +static const struct clk_ops ccu_pll_straight_set_ops =3D {
> +       .enable =3D ccu_pll_enable,
> +       .disable =3D ccu_pll_disable,
> +       .is_enabled =3D ccu_pll_is_enabled,
> +       .recalc_rate =3D ccu_pll_recalc_rate,
> +       .round_rate =3D ccu_pll_round_rate,
> +       .set_rate =3D ccu_pll_set_rate_reset,
> +       .debug_init =3D ccu_pll_debug_init
> +};
> +
> +struct ccu_pll *ccu_pll_hw_register(struct ccu_pll_init_data *pll_init)

Can pll_init be const?

> +{
> +       struct clk_parent_data parent_data =3D {0};
> +       struct clk_init_data hw_init =3D {0};
> +       struct ccu_pll *pll;
> +       int ret;
> +
> +       if (!pll_init)
> +               return ERR_PTR(-EINVAL);
> +
> +       pll =3D kzalloc(sizeof(*pll), GFP_KERNEL);
> +       if (!pll)
> +               return ERR_PTR(-ENOMEM);
> +
> +       pll->hw.init =3D &hw_init;
> +       pll->id =3D pll_init->id;
> +       pll->regs =3D pll_init->regs;
> +       spin_lock_init(&pll->regs_lock);
> +
> +       hw_init.name =3D pll_init->name;
> +       hw_init.flags =3D CLK_IGNORE_UNUSED;

Why ignore unused? Please have a comment.

> +
> +       if (pll_init->flags & CCU_PLL_GATE_TO_SET) {
> +               hw_init.flags |=3D CLK_SET_RATE_GATE;
> +               hw_init.ops =3D &ccu_pll_gate_to_set_ops;
> +       } else {
> +               hw_init.ops =3D &ccu_pll_straight_set_ops;
> +       }
> +
> +       if (pll_init->flags & CCU_PLL_CRITICAL)
> +               hw_init.flags |=3D CLK_IS_CRITICAL;
> +
> +       if (!pll_init->parent_name) {
> +               ret =3D -EINVAL;
> +               goto err_free_pll;
> +       }
> +       parent_data.fw_name =3D pll_init->parent_name;
> +       hw_init.parent_data =3D &parent_data;
> +       hw_init.num_parents =3D 1;
> +
> +       ret =3D of_clk_hw_register(pll_init->np, &pll->hw);
> +       if (ret)
> +               goto err_free_pll;
> +
> +       return pll;
> +
> +err_free_pll:
> +       kfree(pll);
> +
> +       return ERR_PTR(ret);
> +}
> +
> +void ccu_pll_hw_unregister(struct ccu_pll *pll)
> +{
> +       if (!pll)
> +               return;

That would be quite bad. Just let that blow up if so.

> +
> +       clk_hw_unregister(&pll->hw);
> +
> +       kfree(pll);
> +}
> diff --git a/drivers/clk/baikal-t1/ccu-pll.h b/drivers/clk/baikal-t1/ccu-=
pll.h
> new file mode 100644
> index 000000000000..6921516311fb
> --- /dev/null
> +++ b/drivers/clk/baikal-t1/ccu-pll.h
> @@ -0,0 +1,73 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2019 BAIKAL ELECTRONICS, JSC
> + *
> + * Baikal-T1 CCU PLL interface driver.
> + */
> +#ifndef __CLK_BT1_CCU_PLL_H__
> +#define __CLK_BT1_CCU_PLL_H__
> +
> +#include <linux/clk-provider.h>
> +#include <linux/spinlock.h>
> +#include <linux/bits.h>
> +#include <linux/of.h>
> +
> +/*
> + * CCU PLL private flags.
> + * @CCU_PLL_GATE_TO_SET: Some PLLs output clock can't be changed on-the-=
fly,
> + *                      so according to documentation they need to be ga=
ted
> + *                      first.
> + * @CCU_PLL_CRITICAL: Even though there is a way to switch any PLL off, =
there
> + *                   might be some, which shouldn't be in any case.
> + */
> +#define CCU_PLL_GATE_TO_SET            BIT(0)
> +#define CCU_PLL_CRITICAL               BIT(1)
> +
> +/*
> + * struct ccu_pll_init_data - CCU PLL initialization data.
> + * @id: Clock private identifier.
> + * @regs: PLL registers base address.
> + * @name: Clocks name.
> + * @parent_name: Clocks parent name in a fw node.
> + * @np: Pointer to the node describing the CCU PLLs.
> + * @flags: PLL private flags.
> + */
> +struct ccu_pll_init_data {
> +       unsigned int id;
> +       void __iomem *regs;
> +       const char *name;
> +       const char *parent_name;
> +       struct device_node *np;
> +       unsigned long flags;
> +};
> +
> +/*
> + * struct ccu_pll - CCU PLL descriptor.

Please drop the full stop on title

> + * @hw: clk_hw of the PLL.
> + * @id: Clock private identifier.
> + * @regs: PLL registers base address.
> + * @regs_lock: The registers exclusive access spin-lock.
> + */
> +struct ccu_pll {
> +       struct clk_hw hw;
> +       unsigned int id;
> +       void __iomem *regs;
> +       spinlock_t regs_lock;
> +};
> +#define to_ccu_pll(_hw) container_of(_hw, struct ccu_pll, hw)
> +
> +static inline struct clk_hw *ccu_pll_get_clk_hw(struct ccu_pll *pll)
> +{
> +       return pll ? &pll->hw : NULL;
> +}
> +
> +static inline unsigned int ccu_pll_get_clk_id(struct ccu_pll *pll)
> +{
> +       return pll ? pll->id : -1;

It's unsigned return value, but return -1? Can this be inlined in the
one call site and if !pll just continue instead of having to turn it
into a negative value returned through an unsigned int?

> +}
> +
> +extern struct ccu_pll *ccu_pll_hw_register(struct ccu_pll_init_data *ini=
t);
> +
> +extern void ccu_pll_hw_unregister(struct ccu_pll *pll);
> +
> +#endif /* __CLK_BT1_CCU_PLL_H__ */
> diff --git a/drivers/clk/baikal-t1/clk-ccu-pll.c b/drivers/clk/baikal-t1/=
clk-ccu-pll.c
> new file mode 100644
> index 000000000000..990f0a4a12f9
> --- /dev/null
> +++ b/drivers/clk/baikal-t1/clk-ccu-pll.c
> @@ -0,0 +1,217 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2019 BAIKAL ELECTRONICS, JSC
> + *
> + * Authors:
> + *   Serge Semin <Sergey.Semin@baikalelectronics.ru>
> + *   Dmitry Dunaev <dmitry.dunaev@baikalelectronics.ru>
> + *
> + * Baikal-T1 CCU PLL clocks driver.
> + */
> +
> +#define pr_fmt(fmt) "bt1-ccu-pll: " fmt
> +
> +#include <linux/kernel.h>
> +#include <linux/printk.h>
> +#include <linux/slab.h>
> +#include <linux/clk-provider.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/ioport.h>
> +
> +#include <dt-bindings/clock/bt1-ccu.h>
> +
> +#include "ccu-pll.h"
> +
> +#define CCU_CPU_PLL_BASE               0x000
> +#define CCU_SATA_PLL_BASE              0x008
> +#define CCU_DDR_PLL_BASE               0x010
> +#define CCU_PCIE_PLL_BASE              0x018
> +#define CCU_ETH_PLL_BASE               0x020
> +
> +#define CCU_PLL_INFO(_id, _name, _pname, _base, _flags)        \
> +       {                                               \
> +               .id =3D _id,                              \
> +               .name =3D _name,                          \
> +               .parent_name =3D _pname,                  \
> +               .base =3D _base,                          \
> +               .flags =3D _flags                         \
> +       }
> +
> +#define CCU_PLL_NUM                    ARRAY_SIZE(pll_info)
> +
> +struct ccu_pll_info {
> +       unsigned int id;
> +       const char *name;
> +       const char *parent_name;
> +       unsigned int base;
> +       unsigned long flags;
> +};
> +
> +static const struct ccu_pll_info pll_info[] =3D {
> +       CCU_PLL_INFO(CCU_CPU_PLL, "cpu_pll", "ref_clk", CCU_CPU_PLL_BASE,
> +                    CCU_PLL_CRITICAL),
> +       CCU_PLL_INFO(CCU_SATA_PLL, "sata_pll", "ref_clk", CCU_SATA_PLL_BA=
SE,
> +                    CCU_PLL_CRITICAL | CCU_PLL_GATE_TO_SET),

Please comment all CLK_IS_CRITICAL usage and don't make your own version
of the same flags in the common clk framework. Just use the ones in the
framework.

> +       CCU_PLL_INFO(CCU_DDR_PLL, "ddr_pll", "ref_clk", CCU_DDR_PLL_BASE,
> +                    CCU_PLL_CRITICAL | CCU_PLL_GATE_TO_SET),
> +       CCU_PLL_INFO(CCU_PCIE_PLL, "pcie_pll", "ref_clk", CCU_PCIE_PLL_BA=
SE,
> +                    CCU_PLL_CRITICAL),
> +       CCU_PLL_INFO(CCU_ETH_PLL, "eth_pll", "ref_clk", CCU_ETH_PLL_BASE,
> +                    CCU_PLL_GATE_TO_SET)
> +};
> +
> +struct ccu_pll_data {
> +       struct device_node *np;
> +       void __iomem *regs;
> +       struct ccu_pll *plls[CCU_PLL_NUM];
> +};
> +
> +static struct ccu_pll *ccu_pll_find_desc(struct ccu_pll_data *data,
> +                                        unsigned int clk_id)
> +{
> +       struct ccu_pll *pll;
> +       int idx;
> +
> +       for (idx =3D 0; idx < CCU_PLL_NUM; ++idx) {
> +               pll =3D data->plls[idx];
> +               if (clk_id =3D=3D ccu_pll_get_clk_id(pll))
> +                       return pll;
> +       }
> +
> +       return ERR_PTR(-EINVAL);
> +}
> +
> +static struct ccu_pll_data *ccu_pll_create_data(struct device_node *np)
> +{
> +       struct ccu_pll_data *data;
> +
> +       data =3D kzalloc(sizeof(*data), GFP_KERNEL);
> +       if (!data)
> +               return ERR_PTR(-ENOMEM);
> +
> +       data->np =3D np;
> +
> +       return data;
> +}
> +
> +static void ccu_pll_free_data(struct ccu_pll_data *data)
> +{
> +       kfree(data);
> +}
> +
> +static int ccu_pll_request_regs(struct ccu_pll_data *data)
> +{
> +       data->regs =3D of_io_request_and_map(data->np, 0,
> +                                          of_node_full_name(data->np));
> +       if (IS_ERR(data->regs)) {
> +               pr_err("Failed to request PLLs '%s' regs\n",
> +                       of_node_full_name(data->np));
> +               return PTR_ERR(data->regs);
> +       }
> +
> +       return 0;
> +}
> +
> +static void ccu_pll_release_regs(struct ccu_pll_data *data)
> +{
> +       struct resource res;
> +
> +       iounmap(data->regs);
> +
> +       /* Try to release the resource as well. */
> +       if (of_address_to_resource(data->np, 0, &res))
> +               return;
> +
> +       (void)release_mem_region(res.start, resource_size(&res));
> +}

Instead of having these three functions please inline them at the one call
site.

> +
> +static struct clk_hw *ccu_pll_of_clk_hw_get(struct of_phandle_args *clks=
pec,
> +                                           void *priv)
> +{
> +       struct ccu_pll_data *data =3D priv;
> +       struct ccu_pll *pll;
> +       unsigned int clk_id;
> +
> +       clk_id =3D clkspec->args[0];
> +       pll =3D ccu_pll_find_desc(data, clk_id);
> +       if (IS_ERR(pll)) {
> +               pr_info("Invalid PLL clock ID %d specified\n", clk_id);
> +               return ERR_CAST(pll);
> +       }
> +
> +       return ccu_pll_get_clk_hw(pll);
> +}
> +
> +static int ccu_pll_clk_register(struct ccu_pll_data *data)
> +{
> +       int idx, ret;
> +
> +       for (idx =3D 0; idx < CCU_PLL_NUM; ++idx) {
> +               const struct ccu_pll_info *info =3D &pll_info[idx];
> +               struct ccu_pll_init_data init =3D {0};
> +
> +               init.id =3D info->id;
> +               init.regs =3D data->regs + info->base;
> +               init.parent_name =3D info->parent_name;
> +               init.np =3D data->np;
> +               init.flags =3D info->flags;
> +
> +               ret =3D of_property_read_string_index(data->np,
> +                       "clock-output-names", init.id, &init.name);

Do you need this property ever? It would be nice to not have it if
possible.

> +               if (ret)
> +                       init.name =3D info->name;
> +
> +               data->plls[idx] =3D ccu_pll_hw_register(&init);
> +               if (IS_ERR(data->plls[idx])) {
> +                       ret =3D PTR_ERR(data->plls[idx]);
> +                       pr_err("Couldn't register PLL hw '%s'\n",
> +                               init.name);
> +                       goto err_hw_unregister;
> +               }
> +       }
> +
> +       ret =3D of_clk_add_hw_provider(data->np, ccu_pll_of_clk_hw_get, d=
ata);
> +       if (ret) {
> +               pr_err("Couldn't register PLL provider of '%s'\n",
> +                       of_node_full_name(data->np));
> +               goto err_hw_unregister;
> +       }
> +
> +       return 0;
> +
> +err_hw_unregister:
> +       for (--idx; idx >=3D 0; --idx)
> +               ccu_pll_hw_unregister(data->plls[idx]);
> +
> +       return ret;
> +}
> +
> +static __init void ccu_pll_init(struct device_node *np)
> +{
> +       struct ccu_pll_data *data;
> +       int ret;
> +
> +       data =3D ccu_pll_create_data(np);
> +       if (IS_ERR(data))
> +               return;
> +
> +       ret =3D ccu_pll_request_regs(data);
> +       if (ret)
> +               goto err_free_data;
> +
> +       ret =3D ccu_pll_clk_register(data);
> +       if (ret)
> +               goto err_release_regs;
> +
> +       pr_info("CCU CPU/SATA/DDR/PCIe/Ethernet PLLs are initialized\n");

Please don't have I'm alive probe messages at info level. Just slows
down boot for developer comfort.

> +
> +       return;
> +
> +err_release_regs:
> +       ccu_pll_release_regs(data);
> +
> +err_free_data:
> +       ccu_pll_free_data(data);
> +}
> +CLK_OF_DECLARE(ccu_pll, "be,bt1-ccu-pll", ccu_pll_init);

Any reason this can't be a platform device driver?

> diff --git a/drivers/clk/baikal-t1/common.h b/drivers/clk/baikal-t1/commo=
n.h
> new file mode 100644
> index 000000000000..07c8d67f5275
> --- /dev/null
> +++ b/drivers/clk/baikal-t1/common.h
> @@ -0,0 +1,44 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2019 BAIKAL ELECTRONICS, JSC
> + *
> + * Baikal-T1 CCU common methods.
> + */
> +#ifndef __CLK_BT1_COMMON_H__
> +#define __CLK_BT1_COMMON_H__
> +
> +#include <linux/debugfs.h>
> +#include <linux/io.h>
> +
> +#define CCU_GET_FLD(_name, _data) \
> +       (((u32)(_data) & _name ## _MASK) >> _name ## _FLD)
> +
> +#define CCU_SET_FLD(_name, _data, _val) \
> +       (((u32)(_data) & ~_name ## _MASK) | \
> +       (((u32)(_val) << _name ## _FLD) & _name ## _MASK))
> +
> +#define CCU_DBGFS_REG(_name, _off)     \
> +{                                      \
> +       .name =3D _name,                  \
> +       .offset =3D _off                  \
> +}
> +
> +static inline u32 ccu_read(void __iomem *reg)
> +{
> +       return readl(reg);
> +}
> +
> +static inline void ccu_write(void __iomem *reg, u32 data)
> +{
> +       writel(data, reg);
> +}
> +
> +static inline void ccu_update(void __iomem *reg, u32 mask, u32 data)
> +{
> +       u32 old;
> +
> +       old =3D readl_relaxed(reg);
> +       writel((old & ~mask) | (data & mask), reg);
> +}

Please just write the code in line as readl/writel/etc. This whole file
doesn't look necessary.
