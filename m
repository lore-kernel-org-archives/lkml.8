Return-Path: <SRS0=pQss=CP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8664AC433E2
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 22:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 551D420838
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 22:34:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbgIFWeN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Sep 2020 18:34:13 -0400
Received: from gloria.sntech.de ([185.11.138.130]:38258 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726165AbgIFWeJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 18:34:09 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1kF3EY-0002WD-Mo; Mon, 07 Sep 2020 00:34:02 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Elaine Zhang <zhangqing@rock-chips.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, xxx@rock-chips.com,
        xf@rock-chips.com, huangtao@rock-chips.com,
        kever.yang@rock-chips.com, Elaine Zhang <zhangqing@rock-chips.com>
Subject: Re: [PATCH v3 2/6] clk: rockchip: Export rockchip_clk_register_ddrclk()
Date:   Mon, 07 Sep 2020 00:34:01 +0200
Message-ID: <2532557.3DXEvePdfh@diego>
In-Reply-To: <20200904074405.24439-3-zhangqing@rock-chips.com>
References: <20200904074405.24439-1-zhangqing@rock-chips.com> <20200904074405.24439-3-zhangqing@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 4. September 2020, 09:44:01 CEST schrieb Elaine Zhang:
> This is used by the Rockchip clk driver, export it to allow that
> driver to be compiled as a module..
> 
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
> ---
>  drivers/clk/rockchip/clk-ddr.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/clk/rockchip/clk-ddr.c b/drivers/clk/rockchip/clk-ddr.c
> index 9273bce4d7b6..282b6f22eb22 100644
> --- a/drivers/clk/rockchip/clk-ddr.c
> +++ b/drivers/clk/rockchip/clk-ddr.c
> @@ -136,3 +136,4 @@ struct clk *rockchip_clk_register_ddrclk(const char *name, int flags,
>  
>  	return clk;
>  }
> +EXPORT_SYMBOL(rockchip_clk_register_ddrclk);

EXPORT_SYMBOL_GPL perhaps?

The rest of clock-framework exports are already the _GPL variant anyway,
so ours should probably be too.



