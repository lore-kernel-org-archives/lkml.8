Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E44B6C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 13:27:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6AA220674
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 13:27:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732335AbgGVN1O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 09:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727825AbgGVN1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 09:27:14 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 195D2C0619DC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 06:27:14 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mtr@pengutronix.de>)
        id 1jyEm5-0002P5-1w; Wed, 22 Jul 2020 15:27:09 +0200
Received: from mtr by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mtr@pengutronix.de>)
        id 1jyEm4-0005Hr-Fu; Wed, 22 Jul 2020 15:27:08 +0200
Date:   Wed, 22 Jul 2020 15:27:08 +0200
From:   Michael Tretter <m.tretter@pengutronix.de>
To:     Amit Sunil Dhamne <amit.sunil.dhamne@xilinx.com>
Cc:     mturquette@baylibre.com, sboyd@codeaurora.org, sboyd@kernel.org,
        michal.simek@xilinx.com, mark.rutland@arm.com,
        linux-clk@vger.kernel.org, rajanv@xilinx.com, jollys@xilinx.com,
        tejasp@xilinx.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rajan Vaja <rajan.vaja@xilinx.com>,
        Tejas Patel <tejas.patel@xilinx.com>
Subject: Re: [PATCH v2 2/3] clk: zynqmp: Use firmware specific divider clock
 flags
Message-ID: <20200722132708.GD21264@pengutronix.de>
References: <1595400932-303612-1-git-send-email-amit.sunil.dhamne@xilinx.com>
 <1595400932-303612-3-git-send-email-amit.sunil.dhamne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1595400932-303612-3-git-send-email-amit.sunil.dhamne@xilinx.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 15:24:05 up 153 days, 20:54, 130 users,  load average: 0.16, 0.13,
 0.15
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mtr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jul 2020 23:55:31 -0700, Amit Sunil Dhamne wrote:
> From: Rajan Vaja <rajan.vaja@xilinx.com>
> 
> Use ZynqMP specific divider clock flags instead of using CCF flags.
> 
> Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
> Signed-off-by: Tejas Patel <tejas.patel@xilinx.com>
> Signed-off-by: Amit Sunil Dhamne <amit.sunil.dhamne@xilinx.com>
> ---
>  drivers/clk/zynqmp/clk-zynqmp.h |  9 +++++++++
>  drivers/clk/zynqmp/divider.c    | 16 +++++++++++++++-
>  2 files changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/zynqmp/clk-zynqmp.h b/drivers/clk/zynqmp/clk-zynqmp.h
> index 3cb6149..ec33525 100644
> --- a/drivers/clk/zynqmp/clk-zynqmp.h
> +++ b/drivers/clk/zynqmp/clk-zynqmp.h
> @@ -32,6 +32,15 @@
>  /* do not gate, ever */
>  #define ZYNQMP_CLK_IS_CRITICAL         BIT(11)
> 
> +/* Type Flags for divider clock */
> +#define ZYNQMP_CLK_DIVIDER_ONE_BASED           BIT(0)
> +#define ZYNQMP_CLK_DIVIDER_POWER_OF_TWO                BIT(1)
> +#define ZYNQMP_CLK_DIVIDER_ALLOW_ZERO          BIT(2)
> +#define ZYNQMP_CLK_DIVIDER_HIWORD_MASK         BIT(3)
> +#define ZYNQMP_CLK_DIVIDER_ROUND_CLOSEST       BIT(4)
> +#define ZYNQMP_CLK_DIVIDER_READ_ONLY           BIT(5)
> +#define ZYNQMP_CLK_DIVIDER_MAX_AT_ZERO         BIT(6)
> +
>  enum topology_type {
>         TYPE_INVALID,
>         TYPE_MUX,
> diff --git a/drivers/clk/zynqmp/divider.c b/drivers/clk/zynqmp/divider.c
> index 3ab57d9..86cb785 100644
> --- a/drivers/clk/zynqmp/divider.c
> +++ b/drivers/clk/zynqmp/divider.c
> @@ -320,7 +320,21 @@ struct clk_hw *zynqmp_clk_register_divider(const char *name,
>         /* struct clk_divider assignments */
>         div->is_frac = !!((nodes->flag & CLK_FRAC) |
>                           (nodes->custom_type_flag & CUSTOM_FLAG_CLK_FRAC));
> -       div->flags = nodes->type_flag;
> +       div->flags = 0;
> +       div->flags |= (nodes->type_flag & ZYNQMP_CLK_DIVIDER_ONE_BASED) ?
> +                     CLK_DIVIDER_ONE_BASED : 0;
> +       div->flags |= (nodes->type_flag & ZYNQMP_CLK_DIVIDER_POWER_OF_TWO) ?
> +                     CLK_DIVIDER_POWER_OF_TWO : 0;
> +       div->flags |= (nodes->type_flag & ZYNQMP_CLK_DIVIDER_ALLOW_ZERO) ?
> +                     CLK_DIVIDER_ALLOW_ZERO : 0;
> +       div->flags |= (nodes->type_flag & ZYNQMP_CLK_DIVIDER_POWER_OF_TWO) ?
> +                     CLK_DIVIDER_HIWORD_MASK : 0;
> +       div->flags |= (nodes->type_flag & ZYNQMP_CLK_DIVIDER_ROUND_CLOSEST) ?
> +                     CLK_DIVIDER_ROUND_CLOSEST : 0;
> +       div->flags |= (nodes->type_flag & ZYNQMP_CLK_DIVIDER_READ_ONLY) ?
> +                     CLK_DIVIDER_READ_ONLY : 0;
> +       div->flags |= (nodes->type_flag & ZYNQMP_CLK_DIVIDER_MAX_AT_ZERO) ?
> +                     CLK_DIVIDER_MAX_AT_ZERO : 0;

Add a helper function for converting the flags.

Michael

>         div->hw.init = &init;
>         div->clk_id = clk_id;
>         div->div_type = nodes->type;
> --
> 2.7.4
> 
> This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
> 
