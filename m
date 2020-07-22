Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37BD5C433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 13:28:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C921206E3
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 13:28:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732410AbgGVN2p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 09:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbgGVN2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 09:28:45 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A0AFC0619DC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 06:28:45 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mtr@pengutronix.de>)
        id 1jyEnX-0002az-JQ; Wed, 22 Jul 2020 15:28:39 +0200
Received: from mtr by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mtr@pengutronix.de>)
        id 1jyEnW-0005IW-On; Wed, 22 Jul 2020 15:28:38 +0200
Date:   Wed, 22 Jul 2020 15:28:38 +0200
From:   Michael Tretter <m.tretter@pengutronix.de>
To:     Amit Sunil Dhamne <amit.sunil.dhamne@xilinx.com>
Cc:     mturquette@baylibre.com, sboyd@codeaurora.org, sboyd@kernel.org,
        michal.simek@xilinx.com, mark.rutland@arm.com,
        linux-clk@vger.kernel.org, rajanv@xilinx.com, jollys@xilinx.com,
        tejasp@xilinx.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rajan Vaja <rajan.vaja@xilinx.com>,
        Tejas Patel <tejas.patel@xilinx.com>
Subject: Re: [PATCH v2 3/3] clk: zynqmp: Use firmware specific mux clock flags
Message-ID: <20200722132838.GE21264@pengutronix.de>
References: <1595400932-303612-1-git-send-email-amit.sunil.dhamne@xilinx.com>
 <1595400932-303612-4-git-send-email-amit.sunil.dhamne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1595400932-303612-4-git-send-email-amit.sunil.dhamne@xilinx.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 15:28:18 up 153 days, 20:58, 130 users,  load average: 0.04, 0.11,
 0.13
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mtr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jul 2020 23:55:32 -0700, Amit Sunil Dhamne wrote:
> From: Rajan Vaja <rajan.vaja@xilinx.com>
> 
> Use ZynqMP specific mux clock flags instead of using CCF flags.
> 
> Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
> Signed-off-by: Tejas Patel <tejas.patel@xilinx.com>
> Signed-off-by: Amit Sunil Dhamne <amit.sunil.dhamne@xilinx.com>
> ---
>  drivers/clk/zynqmp/clk-mux-zynqmp.c | 14 +++++++++++++-
>  drivers/clk/zynqmp/clk-zynqmp.h     |  8 ++++++++
>  2 files changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/zynqmp/clk-mux-zynqmp.c b/drivers/clk/zynqmp/clk-mux-zynqmp.c
> index 1dc17a0..10cf021 100644
> --- a/drivers/clk/zynqmp/clk-mux-zynqmp.c
> +++ b/drivers/clk/zynqmp/clk-mux-zynqmp.c
> @@ -125,7 +125,19 @@ struct clk_hw *zynqmp_clk_register_mux(const char *name, u32 clk_id,
> 
>         init.parent_names = parents;
>         init.num_parents = num_parents;
> -       mux->flags = nodes->type_flag;
> +       mux->flags = 0;
> +       mux->flags |= (nodes->type_flag & ZYNQMP_CLK_MUX_INDEX_ONE) ?
> +                     CLK_MUX_INDEX_ONE : 0;
> +       mux->flags |= (nodes->type_flag & ZYNQMP_CLK_MUX_INDEX_BIT) ?
> +                     CLK_MUX_INDEX_BIT : 0;
> +       mux->flags |= (nodes->type_flag & ZYNQMP_CLK_MUX_HIWORD_MASK) ?
> +                     CLK_MUX_HIWORD_MASK : 0;
> +       mux->flags |= (nodes->type_flag & ZYNQMP_CLK_MUX_READ_ONLY) ?
> +                     CLK_MUX_READ_ONLY : 0;
> +       mux->flags |= (nodes->type_flag & ZYNQMP_CLK_MUX_ROUND_CLOSEST) ?
> +                     CLK_MUX_ROUND_CLOSEST : 0;
> +       mux->flags |= (nodes->type_flag & ZYNQMP_CLK_MUX_BIG_ENDIAN) ?
> +                     CLK_MUX_BIG_ENDIAN : 0;

Add a helper function for converting the flags.

Michael

>         mux->hw.init = &init;
>         mux->clk_id = clk_id;
> 
> diff --git a/drivers/clk/zynqmp/clk-zynqmp.h b/drivers/clk/zynqmp/clk-zynqmp.h
> index ec33525..b1ac7e8 100644
> --- a/drivers/clk/zynqmp/clk-zynqmp.h
> +++ b/drivers/clk/zynqmp/clk-zynqmp.h
> @@ -41,6 +41,14 @@
>  #define ZYNQMP_CLK_DIVIDER_READ_ONLY           BIT(5)
>  #define ZYNQMP_CLK_DIVIDER_MAX_AT_ZERO         BIT(6)
> 
> +/* Type Flags for mux clock */
> +#define ZYNQMP_CLK_MUX_INDEX_ONE               BIT(0)
> +#define ZYNQMP_CLK_MUX_INDEX_BIT               BIT(1)
> +#define ZYNQMP_CLK_MUX_HIWORD_MASK             BIT(2)
> +#define ZYNQMP_CLK_MUX_READ_ONLY               BIT(3)
> +#define ZYNQMP_CLK_MUX_ROUND_CLOSEST           BIT(4)
> +#define ZYNQMP_CLK_MUX_BIG_ENDIAN              BIT(5)
> +
>  enum topology_type {
>         TYPE_INVALID,
>         TYPE_MUX,
> --
> 2.7.4
> 
> This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
> 

-- 
Pengutronix e.K.                           | Michael Tretter             |
Steuerwalder Str. 21                       | https://www.pengutronix.de/ |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
