Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D296C55196
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 06:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 390A520700
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 06:16:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbgDZGQb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 02:16:31 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:57024 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbgDZGQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 02:16:30 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 18A57803078C;
        Sun, 26 Apr 2020 06:16:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id RHB9wjOlPcBt; Sun, 26 Apr 2020 09:16:13 +0300 (MSK)
Date:   Sun, 26 Apr 2020 09:16:12 +0300
From:   Sergey Semin <Sergey.Semin@baikalelectronics.ru>
To:     Stephen Boyd <sboyd@kernel.org>
CC:     <fancer.lancer@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
Subject: Re: [PATCH 4/5] clk: Add Baikal-T1 CCU PLLs driver
Message-ID: <20200426061612.cwcp7s4ixcyy3j4o@mobilestation>
References: <20200306130048.8868-1-Sergey.Semin@baikalelectronics.ru>
 <20200306130058.27F388030797@mail.baikalelectronics.ru>
 <158385421510.149997.8848277501063917345@swboyd.mtv.corp.google.com>
 <20200407120834.sysd3mluyhw7aen4@ubsrv2.baikal.int>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200407120834.sysd3mluyhw7aen4@ubsrv2.baikal.int>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Stephen,
It has been a while since I responded with a few backward questions. Do you
have anything to answer? I am going to send v2 soon, so I need to have those
questions cleared before that.

Regards,
-Sergey

On Tue, Apr 07, 2020 at 03:08:35PM +0300, Sergey Semin wrote:
> On Tue, Mar 10, 2020 at 08:30:15AM -0700, Stephen Boyd wrote:
> > Quoting Sergey.Semin@baikalelectronics.ru (2020-03-06 05:00:47)
> > > From: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > > 
> > > Baikal-T1 is supposed to be supplied with a high-frequency external
> > > oscillator. But in order to create signals suitable for each IP-block
> > > embedded into the SoC the oscillator output is primarily connected to
> > > a set of CCU PLLs. There are five of them to create clocks for the MIPS
> > > P5600 cores, the embedded DDR controller, SATA, Ethernet and PCIe
> > > domains. The last three domains though named by the biggest system
> > > interfaces in fact include nearly all of the rest SoC peripherals.
> > > Each of the PLLs is based on True Circuits TSMC CLN28HPM IP-core with
> > > an interface wrapper (so called safe PLL' clocks switcher) to simplify
> > > the PLL configuration procedure.
> > > 
> > > This driver creates the of-based hardware clocks to use them then in
> > > the corresponding subsystems. In order to simplify the driver code we
> > > split the functionality up into the PLLs clocks operations and hardware
> > > clocks declaration/registration procedures. So if CLK_BT1_CCU is
> > > defined, then the first part is available in the kernel, while
> > > CLK_BT1_CCU_PLL config makes the actual clocks being registered at the
> > > time of_clk_init() is called.
> > > 
> > > Even though the PLLs are based on the same IP-core, they actually may
> > > have some differences. In particular, some CCU PLLs supports the output
> > > clock change without gating them (like CPU or PCIe PLLs), while the
> > > others don't, some CCU PLLs are critical and aren't supposed to be
> > > gated. In order to cover all of these cases the hardware clocks driver
> > > is designed with a info-descriptor pattern. So there are special static
> > > descriptors declared for each PLL, which is then used to create a
> > > hardware clock with proper operations. Additionally debugfs-files are
> > > provided for each PLL' field to make sure the implemented
> > > rate-PLLs-dividers calculation algorithm is correct.
> > > 
> > > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > > Signed-off-by: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> > > Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> > > Cc: Paul Burton <paulburton@kernel.org>
> > > Cc: Ralf Baechle <ralf@linux-mips.org>
> > 
> > > diff --git a/drivers/clk/baikal-t1/Kconfig b/drivers/clk/baikal-t1/Kconfig
> > > new file mode 100644
> > > index 000000000000..0e2fc86f3ab8
> > > --- /dev/null
> > > +++ b/drivers/clk/baikal-t1/Kconfig
> > > @@ -0,0 +1,35 @@
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +config CLK_BAIKAL_T1
> > > +       bool "Baikal-T1 Clocks Control Unit interface"
> > > +       depends on (MIPS_BAIKAL_T1 || COMPILE_TEST) && OF
> > 
> > Does it actually depend on OF for any compilation?
> 
> Hm, good question. AFAICS it doesn't. The compilation should work for
> both of these configs. While AFAIU it is meaningful to have
> (MIPS_BAIKAL_T1 && OF) only instead of making the compile test depending
> on the OF as well.
> 
> On the other hand MIPS_BAIKAL_T1 indirectly selects OF. I knew about
> this reverse dependency, but still preferred to signify that the driver
> relies on the OF functionality to properly work. What do you think would
> be the best solution in this case:
> 1) just drop OF, which would mean to have (MIPS_BAIKAL_T1 ||
> COMPILE_TEST),
> 2) redefine the statement to (MIPS_BAIKAL_T1 && OF) || COMPILE_TEST ?
> 
> BTW AFAICS OF API is dummy defined if no CONFIG_OF is enabled. So there
> is no need in having OF-dependency for any compile-test usecase. Right?
> Do you know any case when it's required? For instance, I've found the
> similar OF-based conditional statement for CLK_QORIQ,
> COMMON_CLK_FIXED_MMIO and COMMON_CLK_KEYSTONE. Do you think these
> configs are wrong and have to be fixed by removing the "&& OF" statement
> as well?
> 
> > 
> > > +       default y
> > 
> > Please no default y. Maybe default MIPS_BAIKAL_T1?
> 
> Do you mean that in case if COMPILE_TEST is enabled only, the
> drivers below shouldn't be available by default? If so then ok.
> I'll use MIPS_BAIKAL_T1 here. If no, then "default y" would be more
> appropriate.
> 
> > 
> > > +       help
> > > +         Clocks Control Unit is the core of Baikal-T1 SoC responsible for the
> > > +         chip subsystems clocking and resetting. It consists of multiple
> > > +         global clock domains, which can be reset by means of the CCU control
> > > +         registers. These domains and devices placed in them are fed with
> > > +         clocks generated by a hierarchy of PLLs, configurable and fixed
> > > +         dividers. In addition CCU exposes several unrelated functional blocks
> > > +         like irqless Designware i2c controller with indirectly accessed
> > > +         registers, AXI bus errors detector, DW PCIe controller PM/clocks/reset
> > > +         manager, etc.
> > > +
> > > +         This driver provides a set of functions to create the kernel clock
> > > +         devices of Baikal-T1 PLLs and dividers, and to manipulate the reset
> > > +         signals of the SoC.
> > > +
> > > +if CLK_BAIKAL_T1
> > > +
> > > +config CLK_BT1_CCU_PLL
> > > +       bool "Baikal-T1 CCU PLLs support"
> > > +       default y
> > 
> > default MIPS_BAIKAL_T1?
> 
> see the comment above.
> 
> > 
> > > +       help
> > > +         Enable this to support the PLLs embedded into the Baikal-T1 SoCs.
> > > +         These are five PLLs placed at the root of the clocks hierarchy,
> > > +         right after the external reference osciallator (normally of 25MHz).
> > > +         They are used to generate a high frequency signals, which are
> > 
> > s/generate a high/generate high/
> 
> Ok.
> 
> > 
> > > +         either directly wired to the consumers (like CPUs, DDR) or passed
> > > +         over the clock dividers to be only then used as an individual
> > > +         reference clocks of a target device.
> > 
> > s/clocks/clock/
> 
> Ok.
> 
> > 
> > > +
> > > +endif
> > > diff --git a/drivers/clk/baikal-t1/ccu-pll.c b/drivers/clk/baikal-t1/ccu-pll.c
> > > new file mode 100644
> > > index 000000000000..f2087a80b64d
> > > --- /dev/null
> > > +++ b/drivers/clk/baikal-t1/ccu-pll.c
> > > @@ -0,0 +1,474 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Copyright (C) 2019 BAIKAL ELECTRONICS, JSC
> > > + *
> > > + * Authors:
> > > + *   Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > > + *   Dmitry Dunaev <dmitry.dunaev@baikalelectronics.ru>
> > > + *
> > > + * Baikal-T1 CCU PLL interface driver.
> > > + */
> > > +
> > > +#define pr_fmt(fmt) "bt1-ccu-pll: " fmt
> > > +
> > > +#include <linux/kernel.h>
> > > +#include <linux/printk.h>
> > > +#include <linux/limits.h>
> > > +#include <linux/bits.h>
> > > +#include <linux/slab.h>
> > > +#include <linux/clk-provider.h>
> > > +#include <linux/of.h>
> > > +#include <linux/spinlock.h>
> > > +#include <linux/delay.h>
> > > +#include <linux/time64.h>
> > > +#include <linux/rational.h>
> > > +#include <linux/debugfs.h>
> > > +
> > > +#include "ccu-pll.h"
> > > +#include "common.h"
> > > +
> > > +#define CCU_PLL_CTL                    0x00
> > > +#define CCU_PLL_CTL_EN                 BIT(0)
> > > +#define CCU_PLL_CTL_RST                        BIT(1)
> > > +#define CCU_PLL_CTL_CLKR_FLD           2
> > > +#define CCU_PLL_CTL_CLKR_MASK          GENMASK(7, CCU_PLL_CTL_CLKR_FLD)
> > > +#define CCU_PLL_CTL_CLKF_FLD           8
> > > +#define CCU_PLL_CTL_CLKF_MASK          GENMASK(20, CCU_PLL_CTL_CLKF_FLD)
> > > +#define CCU_PLL_CTL_CLKOD_FLD          21
> > > +#define CCU_PLL_CTL_CLKOD_MASK         GENMASK(24, CCU_PLL_CTL_CLKOD_FLD)
> > > +#define CCU_PLL_CTL_BYPASS             BIT(30)
> > > +#define CCU_PLL_CTL_LOCK               BIT(31)
> > > +#define CCU_PLL_CTL1                   0x04
> > > +#define CCU_PLL_CTL1_BWADJ_FLD         3
> > > +#define CCU_PLL_CTL1_BWADJ_MASK                GENMASK(14, CCU_PLL_CTL1_BWADJ_FLD)
> > > +
> > > +#define CCU_PLL_RST_DELAY_US           5
> > > +#define CCU_PLL_LOCK_DELAY_US(_ref_rate, _nr) ({       \
> > > +       uint64_t _n = 500ULL * (_nr) * USEC_PER_SEC;    \
> > > +       do_div(_n, _ref_rate);                          \
> > > +       _n;                                             \
> > > +})
> > 
> > Can this be a static inline function? We get to learn what the types are
> > then.
> 
> Ok I'll convert it to the explicit static inline version cause' you asked it.
> Personally I don't see the necessity of this here. The arithmetics is
> converted to u64, which is more than enough to cover any possible
> nr-value.
> 
> > 
> > > +#define CCU_PLL_LOCK_CHECK_RETRIES     50
> > > +
> > > +#define CCU_PLL_NR_MAX \
> > > +       ((CCU_PLL_CTL_CLKR_MASK >> CCU_PLL_CTL_CLKR_FLD) + 1)
> > > +#define CCU_PLL_NF_MAX \
> > > +       ((CCU_PLL_CTL_CLKF_MASK >> (CCU_PLL_CTL_CLKF_FLD + 1)) + 1)
> > > +#define CCU_PLL_OD_MAX \
> > > +       ((CCU_PLL_CTL_CLKOD_MASK >> CCU_PLL_CTL_CLKOD_FLD) + 1)
> > > +#define CCU_PLL_NB_MAX \
> > > +       ((CCU_PLL_CTL1_BWADJ_MASK >> CCU_PLL_CTL1_BWADJ_FLD) + 1)
> > > +#define CCU_PLL_FDIV_MIN               427000UL
> > > +#define CCU_PLL_FDIV_MAX               3500000000UL
> > > +#define CCU_PLL_FOUT_MIN               200000000UL
> > > +#define CCU_PLL_FOUT_MAX               2500000000UL
> > > +#define CCU_PLL_FVCO_MIN               700000000UL
> > > +#define CCU_PLL_FVCO_MAX               3500000000UL
> > > +#define CCU_PLL_CLKOD_FACTOR           2
> > > +
> > > +#define CCU_PLL_CALC_FREQ(_ref_rate, _nr, _nf, _od) \
> > > +       ((_ref_rate) / (_nr) * (_nf) / (_od))
> > 
> > Static inline function please. Does this need to be 64-bit math?
> 
> Ok for the same reason. In our platform 32-bit data is enough here.
> Though you are right. Some NF may overflow the unsigned long ref_rate
> data. I'll add the 64-bit arithmetics in this function too.
> 
> BTW I thought about 64-bits here in first place, but then I decided it
> may cause the performance drop in ccu_pll_calc_factors() and in
> ccu_pll_recalc_rate() so I left the unsigned long calc here.
> 
> > 
> > > +
> > > +static int ccu_pll_reset(struct ccu_pll *pll, unsigned long ref_clk,
> > > +                        unsigned long nr)
> > > +{
> > > +       unsigned long ud;
> > > +       int count;
> > > +       u32 val;
> > > +
> > > +       ud = CCU_PLL_LOCK_DELAY_US(ref_clk, nr);
> > > +
> > > +       ccu_update(pll->regs + CCU_PLL_CTL, CCU_PLL_CTL_RST, CCU_PLL_CTL_RST);
> > > +
> > > +       count = CCU_PLL_LOCK_CHECK_RETRIES;
> > > +       do {
> > > +               udelay(ud);
> > > +               val = ccu_read(pll->regs + CCU_PLL_CTL);
> > > +       } while (!(val & CCU_PLL_CTL_LOCK) && --count);
> > > +
> > > +       return (val & CCU_PLL_CTL_LOCK) ? 0 : -ETIMEDOUT;
> > 
> > Looks like readl_poll_timeout().
> 
> Nice catch. readl_poll_timeout() perfectly fits here. Though the atomic
> version is more appropriate, since the delays are normally small and the
> method is executed in the atomic context.
> 
> > 
> > > +}
> > > +
> > > +static int ccu_pll_enable(struct clk_hw *hw)
> > > +{
> > > +       struct clk_hw *parent_hw = clk_hw_get_parent(hw);
> > > +       struct ccu_pll *pll = to_ccu_pll(hw);
> > > +       unsigned long flags;
> > > +       int ret;
> > > +       u32 val;
> > > +
> > > +       if (!parent_hw) {
> > > +               pr_err("Can't enable '%s' with no parent", clk_hw_get_name(hw));
> > > +               return -EINVAL;
> > > +       }
> > > +
> > > +       val = ccu_read(pll->regs + CCU_PLL_CTL);
> > > +       if (val & CCU_PLL_CTL_EN)
> > > +               return 0;
> > > +
> > > +       spin_lock_irqsave(&pll->regs_lock, flags);
> > > +       ccu_write(pll->regs + CCU_PLL_CTL, val | CCU_PLL_CTL_EN);
> > > +       ret = ccu_pll_reset(pll, clk_hw_get_rate(parent_hw),
> > > +                           CCU_GET_FLD(CCU_PLL_CTL_CLKR, val) + 1);
> > > +       spin_unlock_irqrestore(&pll->regs_lock, flags);
> > > +       if (ret)
> > > +               pr_err("PLL '%s' reset timed out\n", clk_hw_get_name(hw));
> > > +
> > > +       return ret;
> > > +}
> > > +
> > > +static void ccu_pll_disable(struct clk_hw *hw)
> > > +{
> > > +       struct ccu_pll *pll = to_ccu_pll(hw);
> > > +       unsigned long flags;
> > > +
> > > +       spin_lock_irqsave(&pll->regs_lock, flags);
> > > +       ccu_update(pll->regs + CCU_PLL_CTL, CCU_PLL_CTL_EN, 0);
> > > +       spin_unlock_irqrestore(&pll->regs_lock, flags);
> > > +}
> > > +
> > > +static int ccu_pll_is_enabled(struct clk_hw *hw)
> > > +{
> > > +       struct ccu_pll *pll = to_ccu_pll(hw);
> > > +
> > > +       return !!(ccu_read(pll->regs + CCU_PLL_CTL) & CCU_PLL_CTL_EN);
> > > +}
> > > +
> > > +static unsigned long ccu_pll_recalc_rate(struct clk_hw *hw,
> > > +                                        unsigned long parent_rate)
> > > +{
> > > +       struct ccu_pll *pll = to_ccu_pll(hw);
> > > +       unsigned long nr, nf, od;
> > > +       u32 val;
> > > +
> > > +       val = ccu_read(pll->regs + CCU_PLL_CTL);
> > > +       nr = CCU_GET_FLD(CCU_PLL_CTL_CLKR, val) + 1;
> > 
> > We have FIELD_GET macros for this. Please use them instead of creating
> > your own.
> 
> Right. I'll use it instead.
> 
> > 
> > > +       nf = CCU_GET_FLD(CCU_PLL_CTL_CLKF, val) + 1;
> > > +       od = CCU_GET_FLD(CCU_PLL_CTL_CLKOD, val) + 1;
> > > +
> > > +       return CCU_PLL_CALC_FREQ(parent_rate, nr, nf, od);
> > > +}
> > > +
> > > +static void ccu_pll_calc_factors(unsigned long rate, unsigned long parent_rate,
> > > +                                unsigned long *nr, unsigned long *nf,
> > > +                                unsigned long *od)
> > > +{
> > > +       unsigned long err, freq, min_err = ULONG_MAX;
> > > +       unsigned long num, denom, n1, d1, nri;
> > > +       unsigned long nr_max, nf_max, od_max;
> > > +
> > > +       /*
> > > +        * Make sure PLL is working with valid input signal (Fdiv). If
> > > +        * you want to speed the function up just reduce CCU_PLL_NR_MAX.
> > > +        * This will cause a worse approximation though.
> > > +        */
> > > +       nri = (parent_rate / CCU_PLL_FDIV_MAX) + 1;
> > > +       nr_max = min(parent_rate / CCU_PLL_FDIV_MIN, CCU_PLL_NR_MAX);
> > > +
> > > +       /*
> > > +        * Find a closest [nr;nf;od] vector taking into account the
> > > +        * limitations like: 1) 700MHz <= Fvco <= 3.5GHz, 2) PLL Od is
> > > +        * either 1 or even number within the acceptable range (alas 1s
> > > +        * is also excluded by the next loop).
> > > +        */
> > > +       for (; nri <= nr_max; ++nri) {
> > > +               /* Use Od factor to fulfill the limitation 2). */
> > > +               num = CCU_PLL_CLKOD_FACTOR * rate;
> > > +               denom = parent_rate / nri;
> > > +
> > > +               /*
> > > +                * Make sure Fvco is within the acceptable range to fulfill
> > > +                * the condition 1). Note due to the CCU_PLL_CLKOD_FACTOR value
> > > +                * the actual upper limit is also divided by that factor.
> > > +                * It's not big problem for us since practically there is no
> > > +                * need in clocks with that high frequency.
> > > +                */
> > > +               nf_max = min(CCU_PLL_FVCO_MAX / denom, CCU_PLL_NF_MAX);
> > > +               od_max = CCU_PLL_OD_MAX / CCU_PLL_CLKOD_FACTOR;
> > > +
> > > +               /*
> > > +                * Bypass the out-of-bound values, which can't be properly
> > > +                * handled by the rational fraction approximation algorithm.
> > > +                */
> > > +               if (num / denom >= nf_max) {
> > > +                       n1 = nf_max;
> > > +                       d1 = 1;
> > > +               } else if (denom / num >= od_max) {
> > > +                       n1 = 1;
> > > +                       d1 = od_max;
> > > +               } else {
> > > +                       rational_best_approximation(num, denom, nf_max, od_max,
> > > +                                                   &n1, &d1);
> > > +               }
> > > +
> > > +               /* Select the best approximation of the target rate. */
> > > +               freq = (((parent_rate / nri) * n1) / d1);
> > 
> > Please drop extra parenthesis.
> 
> Ok. Thanks for noticing this. I'll replace it with ccu_pll_calc_freq() function.
> 
> > 
> > > +               err = abs((int64_t)freq - num);
> > > +               if (err < min_err) {
> > > +                       min_err = err;
> > > +                       *nr = nri;
> > > +                       *nf = n1;
> > > +                       *od = CCU_PLL_CLKOD_FACTOR * d1;
> > > +               }
> > > +       }
> > > +}
> > > +
> ...
> > > +
> > > +#ifdef CONFIG_DEBUG_FS
> > > +
> > > +#define CCU_PLL_DBGFS_BIT_ATTR(_name, _reg, _mask)                     \
> > > +static int ccu_pll_dbgfs_##_name##_get(void *priv, u64 *val)           \
> > > +{                                                                      \
> > > +       struct ccu_pll *pll = priv;                                     \
> > > +                                                                       \
> > > +       *val = !!(ccu_read(pll->regs + (_reg)) & (_mask));              \
> > > +                                                                       \
> > > +       return 0;                                                       \
> > > +}                                                                      \
> > > +static int ccu_pll_dbgfs_##_name##_set(void *priv, u64 val)            \
> > > +{                                                                      \
> > > +       struct ccu_pll *pll = priv;                                     \
> > > +       unsigned long flags;                                            \
> > > +                                                                       \
> > > +       spin_lock_irqsave(&pll->regs_lock, flags);                      \
> > > +       ccu_update(pll->regs + (_reg), (_mask), val ? (_mask) : 0);     \
> > > +       spin_unlock_irqrestore(&pll->regs_lock, flags);                 \
> > > +                                                                       \
> > > +       return 0;                                                       \
> > > +}                                                                      \
> > > +DEFINE_DEBUGFS_ATTRIBUTE(ccu_pll_dbgfs_##_name##_fops,                 \
> > > +       ccu_pll_dbgfs_##_name##_get, ccu_pll_dbgfs_##_name##_set, "%llu\n")
> > > +
> > > +#define CCU_PLL_DBGFS_FLD_ATTR(_name, _reg, _fld, _min, _max)          \
> > > +static int ccu_pll_dbgfs_##_name##_get(void *priv, u64 *val)           \
> > > +{                                                                      \
> > > +       struct ccu_pll *pll = priv;                                     \
> > > +       u32 data;                                                       \
> > > +                                                                       \
> > > +       data = ccu_read(pll->regs + (_reg));                            \
> > > +       *val = CCU_GET_FLD(_fld, data) + 1;                             \
> > > +                                                                       \
> > > +       return 0;                                                       \
> > > +}                                                                      \
> > > +static int ccu_pll_dbgfs_##_name##_set(void *priv, u64 val)            \
> > > +{                                                                      \
> > > +       struct ccu_pll *pll = priv;                                     \
> > > +       unsigned long flags;                                            \
> > > +       u32 data;                                                       \
> > > +                                                                       \
> > > +       val = clamp_t(u64, val, _min, _max);                            \
> > > +       data = CCU_SET_FLD(_fld, 0, val - 1);                           \
> > > +                                                                       \
> > > +       spin_lock_irqsave(&pll->regs_lock, flags);                      \
> > > +       ccu_update(pll->regs + (_reg), _fld ## _MASK, data);            \
> > > +       spin_unlock_irqrestore(&pll->regs_lock, flags);                 \
> > > +                                                                       \
> > > +       return 0;                                                       \
> > > +}                                                                      \
> > > +DEFINE_DEBUGFS_ATTRIBUTE(ccu_pll_dbgfs_##_name##_fops,                 \
> > > +       ccu_pll_dbgfs_##_name##_get, ccu_pll_dbgfs_##_name##_set, "%llu\n")
> > > +
> > > +CCU_PLL_DBGFS_BIT_ATTR(en, CCU_PLL_CTL, CCU_PLL_CTL_EN);
> > > +CCU_PLL_DBGFS_BIT_ATTR(rst, CCU_PLL_CTL, CCU_PLL_CTL_RST);
> > > +CCU_PLL_DBGFS_FLD_ATTR(nr, CCU_PLL_CTL, CCU_PLL_CTL_CLKR, 1, CCU_PLL_NR_MAX);
> > > +CCU_PLL_DBGFS_FLD_ATTR(nf, CCU_PLL_CTL, CCU_PLL_CTL_CLKF, 1, CCU_PLL_NF_MAX);
> > > +CCU_PLL_DBGFS_FLD_ATTR(od, CCU_PLL_CTL, CCU_PLL_CTL_CLKOD, 1, CCU_PLL_OD_MAX);
> > > +CCU_PLL_DBGFS_BIT_ATTR(bypass, CCU_PLL_CTL, CCU_PLL_CTL_BYPASS);
> > > +CCU_PLL_DBGFS_BIT_ATTR(lock, CCU_PLL_CTL, CCU_PLL_CTL_LOCK);
> > > +CCU_PLL_DBGFS_FLD_ATTR(nb, CCU_PLL_CTL1, CCU_PLL_CTL1_BWADJ, 1, CCU_PLL_NB_MAX);
> > > +
> > > +static const struct debugfs_reg32 ccu_pll_dbgfs_regs[] = {
> > > +       CCU_DBGFS_REG("ctl", CCU_PLL_CTL),
> > > +       CCU_DBGFS_REG("ctl1", CCU_PLL_CTL1)
> > > +};
> > > +
> > > +static void ccu_pll_debug_init(struct clk_hw *hw, struct dentry *dentry)
> > > +{
> > > +       struct ccu_pll *pll = to_ccu_pll(hw);
> > > +       struct debugfs_regset32 *regset;
> > > +
> > > +       regset = kzalloc(sizeof(*regset), GFP_KERNEL);
> > > +       if (!regset)
> > > +               return;
> > > +
> > > +       regset->regs = ccu_pll_dbgfs_regs;
> > > +       regset->nregs = ARRAY_SIZE(ccu_pll_dbgfs_regs);
> > > +       regset->base = pll->regs;
> > > +       debugfs_create_regset32("registers", 0400, dentry, regset);
> > > +
> > > +       debugfs_create_file_unsafe("en", 0600, dentry, pll,
> > 
> > Why unsafe?
> 
> I don't need full proxy file-operations in this case. Moreover since all
> fops are defined by means of DEFINE_DEBUGFS_ATTRIBUTE() the set/get
> callbacks used will be automatically protected against the corresponding
> files removal. See the comment to the debugfs_create_file_unsafe() for
> details and commit e7e6198c6056 ("clk: tegra: dfll: Fix debugfs_simple_attr.cocci
> warnings") as an example of why unsafe is appropriate here. BTW The commit
> has got your SoB.
> 
> > 
> > > +                                  &ccu_pll_dbgfs_en_fops);
> > > +       debugfs_create_file_unsafe("rst", 0200, dentry, pll,
> > > +                                  &ccu_pll_dbgfs_rst_fops);
> > > +       debugfs_create_file_unsafe("nr", 0600, dentry, pll,
> > > +                                  &ccu_pll_dbgfs_nr_fops);
> > > +       debugfs_create_file_unsafe("nf", 0600, dentry, pll,
> > > +                                  &ccu_pll_dbgfs_nf_fops);
> > > +       debugfs_create_file_unsafe("od", 0600, dentry, pll,
> > > +                                  &ccu_pll_dbgfs_od_fops);
> > > +       debugfs_create_file_unsafe("bypass", 0600, dentry, pll,
> > > +                                  &ccu_pll_dbgfs_bypass_fops);
> > > +       debugfs_create_file_unsafe("lock", 0400, dentry, pll,
> > > +                                  &ccu_pll_dbgfs_lock_fops);
> > > +       debugfs_create_file_unsafe("nb", 0600, dentry, pll,
> > > +                                  &ccu_pll_dbgfs_nb_fops);
> > > +}
> > 
> > Is there any usage of these outside of development of this driver? I'd
> > rather not see us expose blanket register write access with code in
> > debugfs. If you're interested in poking register why not use /dev/mem?
> 
> These parameters are indeed mostly useful in the driver development. But
> they can be useful to diagnose the peripheral device problems like data
> corruption or weird clock consumers behaviour. Moreover some of the
> parameters aren't utilized by the driver like bypass and nb, but might
> be theoretically useful in fixing the problems.
> 
> Anyway I do understand your concern regarding write access to these
> fields. What about if I implemented the same approach as the one used in
> drivers/clk/clk.c? By default the fields are exported in RO-mode.
> If a developer needs to debug a clock-based problem one will need to
> recompile the driver with #define CLOCK_ALLOW_WRITE_DEBUGFS macro
> specified. What do you think?
> 
> > 
> > > +
> > > +#else /* !CONFIG_DEBUG_FS */
> > > +
> > > +#define ccu_pll_debug_init NULL
> > > +
> > > +#endif /* !CONFIG_DEBUG_FS */
> > > +
> > > +static const struct clk_ops ccu_pll_gate_to_set_ops = {
> > > +       .enable = ccu_pll_enable,
> > > +       .disable = ccu_pll_disable,
> > > +       .is_enabled = ccu_pll_is_enabled,
> > > +       .recalc_rate = ccu_pll_recalc_rate,
> > > +       .round_rate = ccu_pll_round_rate,
> > > +       .set_rate = ccu_pll_set_rate_norst,
> > > +       .debug_init = ccu_pll_debug_init
> > > +};
> > > +
> > > +static const struct clk_ops ccu_pll_straight_set_ops = {
> > > +       .enable = ccu_pll_enable,
> > > +       .disable = ccu_pll_disable,
> > > +       .is_enabled = ccu_pll_is_enabled,
> > > +       .recalc_rate = ccu_pll_recalc_rate,
> > > +       .round_rate = ccu_pll_round_rate,
> > > +       .set_rate = ccu_pll_set_rate_reset,
> > > +       .debug_init = ccu_pll_debug_init
> > > +};
> > > +
> > > +struct ccu_pll *ccu_pll_hw_register(struct ccu_pll_init_data *pll_init)
> > 
> > Can pll_init be const?
> 
> Can't believe I missed this. Yes, it can. Thanks.
> 
> > 
> > > +{
> > > +       struct clk_parent_data parent_data = {0};
> > > +       struct clk_init_data hw_init = {0};
> > > +       struct ccu_pll *pll;
> > > +       int ret;
> > > +
> > > +       if (!pll_init)
> > > +               return ERR_PTR(-EINVAL);
> > > +
> > > +       pll = kzalloc(sizeof(*pll), GFP_KERNEL);
> > > +       if (!pll)
> > > +               return ERR_PTR(-ENOMEM);
> > > +
> > > +       pll->hw.init = &hw_init;
> > > +       pll->id = pll_init->id;
> > > +       pll->regs = pll_init->regs;
> > > +       spin_lock_init(&pll->regs_lock);
> > > +
> > > +       hw_init.name = pll_init->name;
> > > +       hw_init.flags = CLK_IGNORE_UNUSED;
> > 
> > Why ignore unused? Please have a comment.
> 
> Ok. I thought it was obvious, since the flag naming said by itself.
> These PLLs are supposed to be left enabled even if they are unused by
> any of the drivers. System bootloader makes sure that required clocks
> are enabled by default like CPU and DDR PLLs. So we don't want to let
> the clock subsystem to disable the PLLs if they are left unused.
> 
> > 
> > > +
> > > +       if (pll_init->flags & CCU_PLL_GATE_TO_SET) {
> > > +               hw_init.flags |= CLK_SET_RATE_GATE;
> > > +               hw_init.ops = &ccu_pll_gate_to_set_ops;
> > > +       } else {
> > > +               hw_init.ops = &ccu_pll_straight_set_ops;
> > > +       }
> > > +
> > > +       if (pll_init->flags & CCU_PLL_CRITICAL)
> > > +               hw_init.flags |= CLK_IS_CRITICAL;
> > > +
> > > +       if (!pll_init->parent_name) {
> > > +               ret = -EINVAL;
> > > +               goto err_free_pll;
> > > +       }
> > > +       parent_data.fw_name = pll_init->parent_name;
> > > +       hw_init.parent_data = &parent_data;
> > > +       hw_init.num_parents = 1;
> > > +
> > > +       ret = of_clk_hw_register(pll_init->np, &pll->hw);
> > > +       if (ret)
> > > +               goto err_free_pll;
> > > +
> > > +       return pll;
> > > +
> > > +err_free_pll:
> > > +       kfree(pll);
> > > +
> > > +       return ERR_PTR(ret);
> > > +}
> > > +
> > > +void ccu_pll_hw_unregister(struct ccu_pll *pll)
> > > +{
> > > +       if (!pll)
> > > +               return;
> > 
> > That would be quite bad. Just let that blow up if so.
> 
> Ok.
> 
> > 
> > > +
> > > +       clk_hw_unregister(&pll->hw);
> > > +
> > > +       kfree(pll);
> > > +}
> > > diff --git a/drivers/clk/baikal-t1/ccu-pll.h b/drivers/clk/baikal-t1/ccu-pll.h
> > > new file mode 100644
> > > index 000000000000..6921516311fb
> > > --- /dev/null
> > > +++ b/drivers/clk/baikal-t1/ccu-pll.h
> > > @@ -0,0 +1,73 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +/*
> > > + * Copyright (C) 2019 BAIKAL ELECTRONICS, JSC
> > > + *
> > > + * Baikal-T1 CCU PLL interface driver.
> > > + */
> > > +#ifndef __CLK_BT1_CCU_PLL_H__
> > > +#define __CLK_BT1_CCU_PLL_H__
> > > +
> > > +#include <linux/clk-provider.h>
> > > +#include <linux/spinlock.h>
> > > +#include <linux/bits.h>
> > > +#include <linux/of.h>
> > > +
> > > +/*
> > > + * CCU PLL private flags.
> > > + * @CCU_PLL_GATE_TO_SET: Some PLLs output clock can't be changed on-the-fly,
> > > + *                      so according to documentation they need to be gated
> > > + *                      first.
> > > + * @CCU_PLL_CRITICAL: Even though there is a way to switch any PLL off, there
> > > + *                   might be some, which shouldn't be in any case.
> > > + */
> > > +#define CCU_PLL_GATE_TO_SET            BIT(0)
> > > +#define CCU_PLL_CRITICAL               BIT(1)
> > > +
> > > +/*
> > > + * struct ccu_pll_init_data - CCU PLL initialization data.
> > > + * @id: Clock private identifier.
> > > + * @regs: PLL registers base address.
> > > + * @name: Clocks name.
> > > + * @parent_name: Clocks parent name in a fw node.
> > > + * @np: Pointer to the node describing the CCU PLLs.
> > > + * @flags: PLL private flags.
> > > + */
> > > +struct ccu_pll_init_data {
> > > +       unsigned int id;
> > > +       void __iomem *regs;
> > > +       const char *name;
> > > +       const char *parent_name;
> > > +       struct device_node *np;
> > > +       unsigned long flags;
> > > +};
> > > +
> > > +/*
> > > + * struct ccu_pll - CCU PLL descriptor.
> > 
> > Please drop the full stop on title
> 
> Ok.
> 
> > 
> > > + * @hw: clk_hw of the PLL.
> > > + * @id: Clock private identifier.
> > > + * @regs: PLL registers base address.
> > > + * @regs_lock: The registers exclusive access spin-lock.
> > > + */
> > > +struct ccu_pll {
> > > +       struct clk_hw hw;
> > > +       unsigned int id;
> > > +       void __iomem *regs;
> > > +       spinlock_t regs_lock;
> > > +};
> > > +#define to_ccu_pll(_hw) container_of(_hw, struct ccu_pll, hw)
> > > +
> > > +static inline struct clk_hw *ccu_pll_get_clk_hw(struct ccu_pll *pll)
> > > +{
> > > +       return pll ? &pll->hw : NULL;
> > > +}
> > > +
> > > +static inline unsigned int ccu_pll_get_clk_id(struct ccu_pll *pll)
> > > +{
> > > +       return pll ? pll->id : -1;
> > 
> > It's unsigned return value, but return -1? Can this be inlined in the
> > one call site and if !pll just continue instead of having to turn it
> > into a negative value returned through an unsigned int?
> 
> Right, unsigned int, but return -1, which was supposed to be an invalid
> value. (unsigned int)-1 => 0xFFFFFFFF is good portable way of setting
> FFs to any int.
> 
> Anyway your solution seems better. I'll use it instead.
> 
> > 
> > > +}
> > > +
> > > +extern struct ccu_pll *ccu_pll_hw_register(struct ccu_pll_init_data *init);
> > > +
> > > +extern void ccu_pll_hw_unregister(struct ccu_pll *pll);
> > > +
> > > +#endif /* __CLK_BT1_CCU_PLL_H__ */
> > > diff --git a/drivers/clk/baikal-t1/clk-ccu-pll.c b/drivers/clk/baikal-t1/clk-ccu-pll.c
> > > new file mode 100644
> > > index 000000000000..990f0a4a12f9
> > > --- /dev/null
> > > +++ b/drivers/clk/baikal-t1/clk-ccu-pll.c
> > > @@ -0,0 +1,217 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Copyright (C) 2019 BAIKAL ELECTRONICS, JSC
> > > + *
> > > + * Authors:
> > > + *   Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > > + *   Dmitry Dunaev <dmitry.dunaev@baikalelectronics.ru>
> > > + *
> > > + * Baikal-T1 CCU PLL clocks driver.
> > > + */
> > > +
> > > +#define pr_fmt(fmt) "bt1-ccu-pll: " fmt
> > > +
> > > +#include <linux/kernel.h>
> > > +#include <linux/printk.h>
> > > +#include <linux/slab.h>
> > > +#include <linux/clk-provider.h>
> > > +#include <linux/of.h>
> > > +#include <linux/of_address.h>
> > > +#include <linux/ioport.h>
> > > +
> > > +#include <dt-bindings/clock/bt1-ccu.h>
> > > +
> > > +#include "ccu-pll.h"
> > > +
> > > +#define CCU_CPU_PLL_BASE               0x000
> > > +#define CCU_SATA_PLL_BASE              0x008
> > > +#define CCU_DDR_PLL_BASE               0x010
> > > +#define CCU_PCIE_PLL_BASE              0x018
> > > +#define CCU_ETH_PLL_BASE               0x020
> > > +
> > > +#define CCU_PLL_INFO(_id, _name, _pname, _base, _flags)        \
> > > +       {                                               \
> > > +               .id = _id,                              \
> > > +               .name = _name,                          \
> > > +               .parent_name = _pname,                  \
> > > +               .base = _base,                          \
> > > +               .flags = _flags                         \
> > > +       }
> > > +
> > > +#define CCU_PLL_NUM                    ARRAY_SIZE(pll_info)
> > > +
> > > +struct ccu_pll_info {
> > > +       unsigned int id;
> > > +       const char *name;
> > > +       const char *parent_name;
> > > +       unsigned int base;
> > > +       unsigned long flags;
> > > +};
> > > +
> > > +static const struct ccu_pll_info pll_info[] = {
> > > +       CCU_PLL_INFO(CCU_CPU_PLL, "cpu_pll", "ref_clk", CCU_CPU_PLL_BASE,
> > > +                    CCU_PLL_CRITICAL),
> > > +       CCU_PLL_INFO(CCU_SATA_PLL, "sata_pll", "ref_clk", CCU_SATA_PLL_BASE,
> > > +                    CCU_PLL_CRITICAL | CCU_PLL_GATE_TO_SET),
> > 
> > Please comment all CLK_IS_CRITICAL usage
> 
> Ok. CPU and DDR PLLs are sources of CPU cores and DDR controller reference clocks,
> which obviously shouldn't be ever gated. SATA and PCIe PLLs are the parents of
> APB-bus and DDR controller AXI-bus clocks, which if gated would cause
> the system being unusable too.
> 
> > and don't make your own version
> > of the same flags in the common clk framework. Just use the ones in the
> > framework.
> 
> This was my first design of the clock flags, but then I had to create a
> set of custom flags for the CCU dividers driver. That time I turned to
> be at a fork either to have two sets of flags: common clock and custom
> ones, or a single set of custom flags, some of which then I would
> translate to the common clock flags. So I've chosen the latter solution.
> I see you suggest the former. Since I was in doubt which one would be
> better, I'll implement yours then.
> 
> > 
> > > +       CCU_PLL_INFO(CCU_DDR_PLL, "ddr_pll", "ref_clk", CCU_DDR_PLL_BASE,
> > > +                    CCU_PLL_CRITICAL | CCU_PLL_GATE_TO_SET),
> > > +       CCU_PLL_INFO(CCU_PCIE_PLL, "pcie_pll", "ref_clk", CCU_PCIE_PLL_BASE,
> > > +                    CCU_PLL_CRITICAL),
> > > +       CCU_PLL_INFO(CCU_ETH_PLL, "eth_pll", "ref_clk", CCU_ETH_PLL_BASE,
> > > +                    CCU_PLL_GATE_TO_SET)
> > > +};
> > > +
> > > +struct ccu_pll_data {
> > > +       struct device_node *np;
> > > +       void __iomem *regs;
> > > +       struct ccu_pll *plls[CCU_PLL_NUM];
> > > +};
> > > +
> > > +static struct ccu_pll *ccu_pll_find_desc(struct ccu_pll_data *data,
> > > +                                        unsigned int clk_id)
> > > +{
> > > +       struct ccu_pll *pll;
> > > +       int idx;
> > > +
> > > +       for (idx = 0; idx < CCU_PLL_NUM; ++idx) {
> > > +               pll = data->plls[idx];
> > > +               if (clk_id == ccu_pll_get_clk_id(pll))
> > > +                       return pll;
> > > +       }
> > > +
> > > +       return ERR_PTR(-EINVAL);
> > > +}
> > > +
> > > +static struct ccu_pll_data *ccu_pll_create_data(struct device_node *np)
> > > +{
> > > +       struct ccu_pll_data *data;
> > > +
> > > +       data = kzalloc(sizeof(*data), GFP_KERNEL);
> > > +       if (!data)
> > > +               return ERR_PTR(-ENOMEM);
> > > +
> > > +       data->np = np;
> > > +
> > > +       return data;
> > > +}
> > > +
> > > +static void ccu_pll_free_data(struct ccu_pll_data *data)
> > > +{
> > > +       kfree(data);
> > > +}
> > > +
> > > +static int ccu_pll_request_regs(struct ccu_pll_data *data)
> > > +{
> > > +       data->regs = of_io_request_and_map(data->np, 0,
> > > +                                          of_node_full_name(data->np));
> > > +       if (IS_ERR(data->regs)) {
> > > +               pr_err("Failed to request PLLs '%s' regs\n",
> > > +                       of_node_full_name(data->np));
> > > +               return PTR_ERR(data->regs);
> > > +       }
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static void ccu_pll_release_regs(struct ccu_pll_data *data)
> > > +{
> > > +       struct resource res;
> > > +
> > > +       iounmap(data->regs);
> > > +
> > > +       /* Try to release the resource as well. */
> > > +       if (of_address_to_resource(data->np, 0, &res))
> > > +               return;
> > > +
> > > +       (void)release_mem_region(res.start, resource_size(&res));
> > > +}
> > 
> > Instead of having these three functions please inline them at the one call
> > site.
> 
> This time I disagree. Inlining them won't gain much of the performance
> benefit, while combination of weakly coherent code into a single function
> will cause worse readability. In my drivers I prefer separating unrelated
> or weakly related functionality from each other and creating a set of functions
> with coherent code (in this case it's memory allocation for the driver private
> data and registers mapping, which are only related in the order of execution).
> By this approach I improve the driver code readability making it better
> structured. So instead of having a pile of weakly coherent code in the probe
> I have a set of work methods and their antagonists (if necessary),
> which are called in the required order. Similar design I normally
> prefer in callbacks, event handlers, etc, if coherent code can't be
> embedded into them.
> 
> Moreover I don't see any requirement by which I would have to rearrange the
> code in this case, while following my way will perfectly fit to the
> kernel coding style described in Documentation/process/coding-style.rst as
> "Functions should be short and sweet, and do just one thing." Sorry, I
> would prefer to leave this part of the driver being structured as is.
> 
> Anyway, this part of the driver will be changed in v2 due to implementing
> an alternative approach of Baikal-T1 System Controller DT node design I've
> described in RFC: https://lkml.org/lkml/2020/3/22/393 . According to it I
> will use a syscon_node_to_regmap(parent) method to get the registers map
> from the parental node instead of requesting a dedicated registers range.
> 
> > 
> > > +
> > > +static struct clk_hw *ccu_pll_of_clk_hw_get(struct of_phandle_args *clkspec,
> > > +                                           void *priv)
> > > +{
> > > +       struct ccu_pll_data *data = priv;
> > > +       struct ccu_pll *pll;
> > > +       unsigned int clk_id;
> > > +
> > > +       clk_id = clkspec->args[0];
> > > +       pll = ccu_pll_find_desc(data, clk_id);
> > > +       if (IS_ERR(pll)) {
> > > +               pr_info("Invalid PLL clock ID %d specified\n", clk_id);
> > > +               return ERR_CAST(pll);
> > > +       }
> > > +
> > > +       return ccu_pll_get_clk_hw(pll);
> > > +}
> > > +
> > > +static int ccu_pll_clk_register(struct ccu_pll_data *data)
> > > +{
> > > +       int idx, ret;
> > > +
> > > +       for (idx = 0; idx < CCU_PLL_NUM; ++idx) {
> > > +               const struct ccu_pll_info *info = &pll_info[idx];
> > > +               struct ccu_pll_init_data init = {0};
> > > +
> > > +               init.id = info->id;
> > > +               init.regs = data->regs + info->base;
> > > +               init.parent_name = info->parent_name;
> > > +               init.np = data->np;
> > > +               init.flags = info->flags;
> > > +
> > > +               ret = of_property_read_string_index(data->np,
> > > +                       "clock-output-names", init.id, &init.name);
> > 
> > Do you need this property ever? It would be nice to not have it if
> > possible.
> 
> It isn't needed other than to provide a custom output clock names for the
> predefined set of clocks. I've seen it has been used for this purpose in
> many drivers of the common clk subsystem. Is this enough to have it
> supported in the driver or should I remove it anyway?
> 
> > 
> > > +               if (ret)
> > > +                       init.name = info->name;
> > > +
> > > +               data->plls[idx] = ccu_pll_hw_register(&init);
> > > +               if (IS_ERR(data->plls[idx])) {
> > > +                       ret = PTR_ERR(data->plls[idx]);
> > > +                       pr_err("Couldn't register PLL hw '%s'\n",
> > > +                               init.name);
> > > +                       goto err_hw_unregister;
> > > +               }
> > > +       }
> > > +
> > > +       ret = of_clk_add_hw_provider(data->np, ccu_pll_of_clk_hw_get, data);
> > > +       if (ret) {
> > > +               pr_err("Couldn't register PLL provider of '%s'\n",
> > > +                       of_node_full_name(data->np));
> > > +               goto err_hw_unregister;
> > > +       }
> > > +
> > > +       return 0;
> > > +
> > > +err_hw_unregister:
> > > +       for (--idx; idx >= 0; --idx)
> > > +               ccu_pll_hw_unregister(data->plls[idx]);
> > > +
> > > +       return ret;
> > > +}
> > > +
> > > +static __init void ccu_pll_init(struct device_node *np)
> > > +{
> > > +       struct ccu_pll_data *data;
> > > +       int ret;
> > > +
> > > +       data = ccu_pll_create_data(np);
> > > +       if (IS_ERR(data))
> > > +               return;
> > > +
> > > +       ret = ccu_pll_request_regs(data);
> > > +       if (ret)
> > > +               goto err_free_data;
> > > +
> > > +       ret = ccu_pll_clk_register(data);
> > > +       if (ret)
> > > +               goto err_release_regs;
> > > +
> > > +       pr_info("CCU CPU/SATA/DDR/PCIe/Ethernet PLLs are initialized\n");
> > 
> > Please don't have I'm alive probe messages at info level. Just slows
> > down boot for developer comfort.
> 
> Ok.
> 
> > 
> > > +
> > > +       return;
> > > +
> > > +err_release_regs:
> > > +       ccu_pll_release_regs(data);
> > > +
> > > +err_free_data:
> > > +       ccu_pll_free_data(data);
> > > +}
> > > +CLK_OF_DECLARE(ccu_pll, "be,bt1-ccu-pll", ccu_pll_init);
> > 
> > Any reason this can't be a platform device driver?
> 
> I thought it was normal to have the clock devices available as early
> as possible. Especially when it comes to the system-wide PLLs and dividers.
> So the question is kind of surprising for me.
> 
> Anyway in my case the platform-specific code is using the CPU PLLs rate
> to get the  MIPS count/compare timer reference clock. At least due to this
> the PLL clock providers must be available at the system initialization stage.
> Platform device probe stage wouldn't work for us here.
> 
> Moreover we can't rely on the order of the devices probe procedure, because
> the CCU PLLs and CCU dividers will be sub-nodes of the Baikal-T1 System Controller,
> which will be a sub-node of the APB-bus node consuming the corresponding CCU
> divider clock. The CCU PLL and divider clocks are utilized literally by each
> device in the system, so there might be too many PROBE_DEFER errors before we get
> to the clock devices binding with drivers.
> 
> To sum up I'd leave both PLL, AXI-bus and System device dividers
> clocks being populated in the init stage by means of the CLK_OF_DECLARE
> macro.
> 
> > 
> > > diff --git a/drivers/clk/baikal-t1/common.h b/drivers/clk/baikal-t1/common.h
> > > new file mode 100644
> > > index 000000000000..07c8d67f5275
> > > --- /dev/null
> > > +++ b/drivers/clk/baikal-t1/common.h
> > > @@ -0,0 +1,44 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +/*
> > > + * Copyright (C) 2019 BAIKAL ELECTRONICS, JSC
> > > + *
> > > + * Baikal-T1 CCU common methods.
> > > + */
> > > +#ifndef __CLK_BT1_COMMON_H__
> > > +#define __CLK_BT1_COMMON_H__
> > > +
> > > +#include <linux/debugfs.h>
> > > +#include <linux/io.h>
> > > +
> > > +#define CCU_GET_FLD(_name, _data) \
> > > +       (((u32)(_data) & _name ## _MASK) >> _name ## _FLD)
> > > +
> > > +#define CCU_SET_FLD(_name, _data, _val) \
> > > +       (((u32)(_data) & ~_name ## _MASK) | \
> > > +       (((u32)(_val) << _name ## _FLD) & _name ## _MASK))
> > > +
> > > +#define CCU_DBGFS_REG(_name, _off)     \
> > > +{                                      \
> > > +       .name = _name,                  \
> > > +       .offset = _off                  \
> > > +}
> > > +
> > > +static inline u32 ccu_read(void __iomem *reg)
> > > +{
> > > +       return readl(reg);
> > > +}
> > > +
> > > +static inline void ccu_write(void __iomem *reg, u32 data)
> > > +{
> > > +       writel(data, reg);
> > > +}
> > > +
> > > +static inline void ccu_update(void __iomem *reg, u32 mask, u32 data)
> > > +{
> > > +       u32 old;
> > > +
> > > +       old = readl_relaxed(reg);
> > > +       writel((old & ~mask) | (data & mask), reg);
> > > +}
> > 
> > Please just write the code in line as readl/writel/etc. This whole file
> > doesn't look necessary.
> 
> Agreed.
> 
> ---
> 
> Stephen, thank you very much for the very thorough review. v2 will be
> sent shortly after I get answers to a few question I've asked in this
> message, after I fix the issues you raised here and get to refactor
> the System Controller DT node design described in the RFC
> (https://lkml.org/lkml/2020/3/22/393). Should you have any comments
> regarding it please reply right to the RFC. You must have received a
> copy in your email.
> 
> I'll also do my best to take into account the fixes suggested here by you
> in [Patch 5/5] "clk: Add Baikal-T1 CCU dividers driver" of this
> patchset.
> 
> Regards,
> -Sergey

