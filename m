Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FFF9C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 13:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3941206B6
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 13:27:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732007AbgF3N1I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 09:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729539AbgF3N1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 09:27:07 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A07C03E979
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 06:27:06 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mtr@pengutronix.de>)
        id 1jqGHt-0000M5-TH; Tue, 30 Jun 2020 15:27:01 +0200
Received: from mtr by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mtr@pengutronix.de>)
        id 1jqGHs-0004tI-Eq; Tue, 30 Jun 2020 15:27:00 +0200
Date:   Tue, 30 Jun 2020 15:27:00 +0200
From:   Michael Tretter <m.tretter@pengutronix.de>
To:     Amit Sunil Dhamne <amit.sunil.dhamne@xilinx.com>
Cc:     mturquette@baylibre.com, sboyd@codeaurora.org, sboyd@kernel.org,
        michal.simek@xilinx.com, mark.rutland@arm.com,
        linux-clk@vger.kernel.org, Rajan Vaja <rajan.vaja@xilinx.com>,
        tejasp@xilinx.com, linux-kernel@vger.kernel.org, jollys@xilinx.com,
        rajanv@xilinx.com, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de
Subject: Re: [PATCH 1/3] clk: zynqmp: Use firmware specific common clock flags
Message-ID: <20200630132700.GA15753@pengutronix.de>
References: <1593477014-18443-1-git-send-email-amit.sunil.dhamne@xilinx.com>
 <1593477014-18443-2-git-send-email-amit.sunil.dhamne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1593477014-18443-2-git-send-email-amit.sunil.dhamne@xilinx.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 15:13:03 up 131 days, 20:43, 122 users,  load average: 0.08, 0.15,
 0.16
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mtr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Jun 2020 17:30:12 -0700, Amit Sunil Dhamne wrote:
> From: Rajan Vaja <rajan.vaja@xilinx.com>
> 
> Currently firmware passes CCF specific flags to ZynqMP clock driver.
> So firmware needs to be updated if CCF flags are changed. The firmware
> should have its own 'flag number space' that is distinct from the
> common clk framework's 'flag number space'. So define and use ZynqMP
> specific common clock flags instead of using CCF flags.
> 
> Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
> Signed-off-by: Amit Sunil Dhamne <amit.sunil.dhamne@xilinx.com>
> ---
>  drivers/clk/zynqmp/clk-zynqmp.h | 22 ++++++++++++++++++++++
>  drivers/clk/zynqmp/clkc.c       | 25 +++++++++++++++++++++++--
>  2 files changed, 45 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/zynqmp/clk-zynqmp.h b/drivers/clk/zynqmp/clk-zynqmp.h
> index 5beeb41..d8e580b 100644
> --- a/drivers/clk/zynqmp/clk-zynqmp.h
> +++ b/drivers/clk/zynqmp/clk-zynqmp.h
> @@ -10,6 +10,28 @@
> 
>  #include <linux/firmware/xlnx-zynqmp.h>
> 
> +/* Common Flags */
> +/* must be gated across rate change */
> +#define ZYNQMP_CLK_SET_RATE_GATE       BIT(0)
> +/* must be gated across re-parent */
> +#define ZYNQMP_CLK_SET_PARENT_GATE     BIT(1)
> +/* propagate rate change up one level */
> +#define ZYNQMP_CLK_SET_RATE_PARENT     BIT(2)
> +/* do not gate even if unused */
> +#define ZYNQMP_CLK_IGNORE_UNUSED       BIT(3)
> +/* do not use the cached clk rate */
> +#define ZYNQMP_CLK_GET_RATE_NOCACHE    BIT(6)
> +/* don't re-parent on rate change */
> +#define ZYNQMP_CLK_SET_RATE_NO_REPARENT        BIT(7)
> +/* do not use the cached clk accuracy */
> +#define ZYNQMP_CLK_GET_ACCURACY_NOCACHE        BIT(8)
> +/* recalc rates after notifications */
> +#define ZYNQMP_CLK_RECALC_NEW_RATES    BIT(9)
> +/* clock needs to run to set rate */
> +#define ZYNQMP_CLK_SET_RATE_UNGATE     BIT(10)
> +/* do not gate, ever */
> +#define ZYNQMP_CLK_IS_CRITICAL         BIT(11)
> +
>  enum topology_type {
>         TYPE_INVALID,
>         TYPE_MUX,
> diff --git a/drivers/clk/zynqmp/clkc.c b/drivers/clk/zynqmp/clkc.c
> index db8d0d7..8663587 100644
> --- a/drivers/clk/zynqmp/clkc.c
> +++ b/drivers/clk/zynqmp/clkc.c
> @@ -385,14 +385,35 @@ static int __zynqmp_clock_get_topology(struct clock_topology *topology,
>  {
>         int i;
>         u32 type;
> +       u32 flag;
> 
>         for (i = 0; i < ARRAY_SIZE(response->topology); i++) {
>                 type = FIELD_GET(CLK_TOPOLOGY_TYPE, response->topology[i]);
>                 if (type == TYPE_INVALID)
>                         return END_OF_TOPOLOGY_NODE;
>                 topology[*nnodes].type = type;
> -               topology[*nnodes].flag = FIELD_GET(CLK_TOPOLOGY_FLAGS,
> -                                                  response->topology[i]);
> +               flag = FIELD_GET(CLK_TOPOLOGY_FLAGS, response->topology[i]);
> +               topology[*nnodes].flag = 0;
> +               topology[*nnodes].flag |= (flag & ZYNQMP_CLK_SET_RATE_GATE) ?
> +                                          CLK_SET_RATE_GATE : 0;
> +               topology[*nnodes].flag |= (flag & ZYNQMP_CLK_SET_RATE_PARENT) ?
> +                                          CLK_SET_RATE_PARENT : 0;
> +               topology[*nnodes].flag |= (flag & ZYNQMP_CLK_IGNORE_UNUSED) ?
> +                                          CLK_IGNORE_UNUSED : 0;
> +               topology[*nnodes].flag |= (flag & ZYNQMP_CLK_GET_RATE_NOCACHE) ?
> +                                          CLK_GET_RATE_NOCACHE : 0;
> +               topology[*nnodes].flag |= (flag &
> +                                          ZYNQMP_CLK_SET_RATE_NO_REPARENT) ?
> +                                          CLK_SET_RATE_NO_REPARENT : 0;
> +               topology[*nnodes].flag |= (flag &
> +                                          ZYNQMP_CLK_GET_ACCURACY_NOCACHE) ?
> +                                          CLK_GET_ACCURACY_NOCACHE : 0;
> +               topology[*nnodes].flag |= (flag & ZYNQMP_CLK_RECALC_NEW_RATES) ?
> +                                          CLK_RECALC_NEW_RATES : 0;
> +               topology[*nnodes].flag |= (flag & ZYNQMP_CLK_SET_RATE_UNGATE) ?
> +                                          CLK_SET_RATE_UNGATE : 0;
> +               topology[*nnodes].flag |= (flag & ZYNQMP_CLK_IS_CRITICAL) ?
> +                                          CLK_IS_CRITICAL : 0;

I don't think that this is the right location for converting the ZYNQMP_CLK_*
flags to CLK_* flags. Here we are writing the flags to the struct
clock_topology, which is still ZynqMP specific. The conversion should rather
happen in the zynqmp_clk_register_*() functions, because these functions write
the flags to struct clk_init_data, which is part of the common clock
framework.

Maybe you could also add a helper function for converting the flags to make
this more readable.

Michael

>                 topology[*nnodes].type_flag =
>                                 FIELD_GET(CLK_TOPOLOGY_TYPE_FLAGS,
>                                           response->topology[i]);
> --
> 2.7.4
> 
> This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
