Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 693A8C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 18:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52257206F5
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 18:27:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731979AbgGVS1D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 14:27:03 -0400
Received: from gloria.sntech.de ([185.11.138.130]:47192 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726539AbgGVS1C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 14:27:02 -0400
Received: from x2f7fa19.dyn.telefonica.de ([2.247.250.25] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1jyJSB-0005E0-6A; Wed, 22 Jul 2020 20:26:55 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Elaine Zhang <zhangqing@rock-chips.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, xxx@rock-chips.com,
        xf@rock-chips.com, huangtao@rock-chips.com,
        kever.yang@rock-chips.com
Subject: Re: [PATCH v1] clk: Export __clk_lookup()
Date:   Wed, 22 Jul 2020 20:26:50 +0200
Message-ID: <14639646.VOZsFJ8Tpa@phil>
In-Reply-To: <20200722023230.10826-1-zhangqing@rock-chips.com>
References: <20200722023230.10826-1-zhangqing@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Elaine,

Am Mittwoch, 22. Juli 2020, 04:32:30 CEST schrieb Elaine Zhang:
> Export __clk_lookup() to support user built as module.
> 
> ERROR:
> drivers/clk/rockchip/clk.ko: In function
> `rockchip_clk_protect_critical':
> drivers/clk/rockchip/clk.c:741:
> undefined reference to `__clk_lookup'

can you elaborate a bit more on why this would be needed?

Because right now the Rockchip clocks are of course built into
the main kernel image (especially due to them being needed during early
boot) and __clk_lookup actually is a pretty deep part of the clock-
framework itself, as probably also denoted by the "__" in the function
name.


Heiko

> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> ---
>  drivers/clk/clk.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 3f588ed06ce3..600284fbb257 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -618,6 +618,7 @@ struct clk *__clk_lookup(const char *name)
>  
>  	return !core ? NULL : core->hw->clk;
>  }
> +EXPORT_SYMBOL_GPL(__clk_lookup);
>  
>  static void clk_core_get_boundaries(struct clk_core *core,
>  				    unsigned long *min_rate,
> 




