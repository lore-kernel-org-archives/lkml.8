Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C3D5C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 13:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CA1C20674
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 13:22:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732179AbgGVNWj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 09:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbgGVNWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 09:22:39 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2331BC0619DC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 06:22:39 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mtr@pengutronix.de>)
        id 1jyEhd-0001tq-EI; Wed, 22 Jul 2020 15:22:33 +0200
Received: from mtr by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mtr@pengutronix.de>)
        id 1jyEhc-00057o-72; Wed, 22 Jul 2020 15:22:32 +0200
Date:   Wed, 22 Jul 2020 15:22:32 +0200
From:   Michael Tretter <m.tretter@pengutronix.de>
To:     Amit Sunil Dhamne <amit.sunil.dhamne@xilinx.com>
Cc:     mturquette@baylibre.com, sboyd@codeaurora.org, sboyd@kernel.org,
        michal.simek@xilinx.com, mark.rutland@arm.com,
        linux-clk@vger.kernel.org, rajanv@xilinx.com, jollys@xilinx.com,
        tejasp@xilinx.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rajan Vaja <rajan.vaja@xilinx.com>,
        Tejas Patel <tejas.patel@xilinx.com>
Subject: Re: [PATCH v2 1/3] clk: zynqmp: Use firmware specific common clock
 flags
Message-ID: <20200722132232.GC21264@pengutronix.de>
References: <1595400932-303612-1-git-send-email-amit.sunil.dhamne@xilinx.com>
 <1595400932-303612-2-git-send-email-amit.sunil.dhamne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1595400932-303612-2-git-send-email-amit.sunil.dhamne@xilinx.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 15:06:47 up 153 days, 20:37, 130 users,  load average: 0.14, 0.29,
 0.20
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mtr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jul 2020 23:55:30 -0700, Amit Sunil Dhamne wrote:
> From: Rajan Vaja <rajan.vaja@xilinx.com>
> 
> Currently firmware passes CCF specific flags to ZynqMP clock driver.
> So firmware needs to be updated if CCF flags are changed. The firmware
> should have its own 'flag number space' that is distinct from the
> common clk framework's 'flag number space'. So define and use ZynqMP
> specific common clock flags instead of using CCF flags.
> 
> Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
> Signed-off-by: Tejas Patel <tejas.patel@xilinx.com>
> Signed-off-by: Amit Sunil Dhamne <amit.sunil.dhamne@xilinx.com>
> ---
>  drivers/clk/zynqmp/clk-gate-zynqmp.c |  4 +++-
>  drivers/clk/zynqmp/clk-mux-zynqmp.c  |  4 +++-
>  drivers/clk/zynqmp/clk-zynqmp.h      | 25 +++++++++++++++++++++++++
>  drivers/clk/zynqmp/clkc.c            | 31 ++++++++++++++++++++++++++++++-
>  drivers/clk/zynqmp/divider.c         |  5 +++--
>  drivers/clk/zynqmp/pll.c             |  4 +++-
>  6 files changed, 67 insertions(+), 6 deletions(-)
> 
[snip]
> diff --git a/drivers/clk/zynqmp/clkc.c b/drivers/clk/zynqmp/clkc.c
> index db8d0d7..11351f6 100644
> --- a/drivers/clk/zynqmp/clkc.c
> +++ b/drivers/clk/zynqmp/clkc.c
> @@ -271,6 +271,32 @@ static int zynqmp_pm_clock_get_topology(u32 clock_id, u32 index,
>         return ret;
>  }
> 
> +void zynqmp_clk_map_common_ccf_flags(const u32 zynqmp_flag,
> +                                    unsigned long *ccf_flag)
> +{
> +       *ccf_flag = 0;
> +       *ccf_flag |= (zynqmp_flag & ZYNQMP_CLK_SET_RATE_GATE) ?
> +                     CLK_SET_RATE_GATE : 0;
> +       *ccf_flag |= (zynqmp_flag & ZYNQMP_CLK_SET_PARENT_GATE) ?
> +                     CLK_SET_PARENT_GATE : 0;
> +       *ccf_flag |= (zynqmp_flag & ZYNQMP_CLK_SET_RATE_PARENT) ?
> +                     CLK_SET_RATE_PARENT : 0;
> +       *ccf_flag |= (zynqmp_flag & ZYNQMP_CLK_IGNORE_UNUSED) ?
> +                     CLK_IGNORE_UNUSED : 0;
> +       *ccf_flag |= (zynqmp_flag & ZYNQMP_CLK_GET_RATE_NOCACHE) ?
> +                     CLK_GET_RATE_NOCACHE : 0;
> +       *ccf_flag |= (zynqmp_flag & ZYNQMP_CLK_SET_RATE_NO_REPARENT) ?
> +                     CLK_SET_RATE_NO_REPARENT : 0;
> +       *ccf_flag |= (zynqmp_flag & ZYNQMP_CLK_GET_ACCURACY_NOCACHE) ?
> +                     CLK_GET_ACCURACY_NOCACHE : 0;
> +       *ccf_flag |= (zynqmp_flag & ZYNQMP_CLK_RECALC_NEW_RATES) ?
> +                     CLK_RECALC_NEW_RATES : 0;
> +       *ccf_flag |= (zynqmp_flag & ZYNQMP_CLK_SET_RATE_UNGATE) ?
> +                     CLK_SET_RATE_UNGATE : 0;
> +       *ccf_flag |= (zynqmp_flag & ZYNQMP_CLK_IS_CRITICAL) ?
> +                     CLK_IS_CRITICAL : 0;
> +}

What is the reason for returning the resulting flags via pointer? I would have
expected something like the following function:

unsigned long zynqmp_clk_flags_to_clk_flags(const u32 zyqnmp_flags)
{
	unsigned long flags = 0;

	if (zynqmp_flag & ZYNQMP_CLK_SET_RATE_GATE)
		flags |= CLK_SET_RATE_GATE;
	/* ... */

	return flags;
}

Michael

> +
>  /**
>   * zynqmp_clk_register_fixed_factor() - Register fixed factor with the
>   *                                     clock framework
> @@ -292,6 +318,7 @@ struct clk_hw *zynqmp_clk_register_fixed_factor(const char *name, u32 clk_id,
>         struct zynqmp_pm_query_data qdata = {0};
>         u32 ret_payload[PAYLOAD_ARG_CNT];
>         int ret;
> +       unsigned long flag;
> 
>         qdata.qid = PM_QID_CLOCK_GET_FIXEDFACTOR_PARAMS;
>         qdata.arg1 = clk_id;
> @@ -303,9 +330,11 @@ struct clk_hw *zynqmp_clk_register_fixed_factor(const char *name, u32 clk_id,
>         mult = ret_payload[1];
>         div = ret_payload[2];
> 
> +       zynqmp_clk_map_common_ccf_flags(nodes->flag, &flag);
> +
>         hw = clk_hw_register_fixed_factor(NULL, name,
>                                           parents[0],
> -                                         nodes->flag, mult,
> +                                         flag, mult,
>                                           div);
> 
>         return hw;
> diff --git a/drivers/clk/zynqmp/divider.c b/drivers/clk/zynqmp/divider.c
> index 66da02b..3ab57d9 100644
> --- a/drivers/clk/zynqmp/divider.c
> +++ b/drivers/clk/zynqmp/divider.c
> @@ -311,8 +311,9 @@ struct clk_hw *zynqmp_clk_register_divider(const char *name,
> 
>         init.name = name;
>         init.ops = &zynqmp_clk_divider_ops;
> -       /* CLK_FRAC is not defined in the common clk framework */
> -       init.flags = nodes->flag & ~CLK_FRAC;
> +
> +       zynqmp_clk_map_common_ccf_flags(nodes->flag, &init.flags);
> +
>         init.parent_names = parents;
>         init.num_parents = 1;
> 
> diff --git a/drivers/clk/zynqmp/pll.c b/drivers/clk/zynqmp/pll.c
> index 92f449e..1b7e231 100644
> --- a/drivers/clk/zynqmp/pll.c
> +++ b/drivers/clk/zynqmp/pll.c
> @@ -302,7 +302,9 @@ struct clk_hw *zynqmp_clk_register_pll(const char *name, u32 clk_id,
> 
>         init.name = name;
>         init.ops = &zynqmp_pll_ops;
> -       init.flags = nodes->flag;
> +
> +       zynqmp_clk_map_common_ccf_flags(nodes->flag, &init.flags);
> +
>         init.parent_names = parents;
>         init.num_parents = 1;
> 
> --
> 2.7.4
> 
> This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
> 
