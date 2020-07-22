Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D24DC433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 14:37:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EE4220771
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 14:37:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732547AbgGVOh2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 10:37:28 -0400
Received: from gloria.sntech.de ([185.11.138.130]:43734 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728837AbgGVOh1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 10:37:27 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1jyFs1-0003sN-NZ; Wed, 22 Jul 2020 16:37:21 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Alex Bee <knaerzche@gmail.com>
Cc:     linux-rockchip@lists.infradead.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: rockchip: add CLK_IGNORE_UNUSED to RK3188 sclk_mac_lbtest
Date:   Wed, 22 Jul 2020 16:37:21 +0200
Message-ID: <3075813.JVNIx54Eim@diego>
In-Reply-To: <20200722143137.863-1-knaerzche@gmail.com>
References: <20200722143137.863-1-knaerzche@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am Mittwoch, 22. Juli 2020, 16:31:37 CEST schrieb Alex Bee:
> Since the loopbacktest clock is not exported and is not touched in the
> driver, it needs the CLK_IGNORE_UNUSED flag in order to get the emac
> working.

could you please add it to the rk3188_critical_clocks array instead.
CLK_IGNORE_UNUSED only protects it against the clock subsystem
disabling it on boot, while as critical clock it also gets protected later.

Thanks
Heiko


> 
> Signed-off-by: Alex Bee <knaerzche@gmail.com>
> ---
>  drivers/clk/rockchip/clk-rk3188.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/rockchip/clk-rk3188.c b/drivers/clk/rockchip/clk-rk3188.c
> index 77aebfb1d6d5..892b1edc3444 100644
> --- a/drivers/clk/rockchip/clk-rk3188.c
> +++ b/drivers/clk/rockchip/clk-rk3188.c
> @@ -354,7 +354,7 @@ static struct rockchip_clk_branch common_clk_branches[] __initdata = {
>  			RK2928_CLKGATE_CON(2), 5, GFLAGS),
>  	MUX(SCLK_MAC, "sclk_macref", mux_sclk_macref_p, CLK_SET_RATE_PARENT,
>  			RK2928_CLKSEL_CON(21), 4, 1, MFLAGS),
> -	GATE(0, "sclk_mac_lbtest", "sclk_macref", 0,
> +	GATE(0, "sclk_mac_lbtest", "sclk_macref", CLK_IGNORE_UNUSED,
>  			RK2928_CLKGATE_CON(2), 12, GFLAGS),
>  
>  	COMPOSITE(0, "hsadc_src", mux_pll_src_gpll_cpll_p, 0,
> 




