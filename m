Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7414C33CAD
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 05:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B72F9222C4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 05:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578978321;
	bh=INba1xdEIwGsxg5/+8HUTWAWDyD5+1mPLHM16YWCq7c=;
	h=In-Reply-To:References:Subject:To:Cc:From:Date:List-ID:From;
	b=r2paYvlmRQJYzNKAKcuSYP8Xv+YIRtM8Z+igxHqfPqzn8Yc3ls6btmhnh4WIck2TJ
	 taRg0M7cgkonsGWm+p/0rkrrYHndauOryNcvUZijmJHaY1d2O4bb1mWE5/rzlOCLhH
	 2FPwuHdat5/1zat6WBwg2drtiHUd9eOGLKPWFct4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726175AbgANFFU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 00:05:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:43306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725306AbgANFFT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 00:05:19 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3C40222C3;
        Tue, 14 Jan 2020 05:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578978318;
        bh=INba1xdEIwGsxg5/+8HUTWAWDyD5+1mPLHM16YWCq7c=;
        h=In-Reply-To:References:Subject:To:Cc:From:Date:From;
        b=M99tkshMFr0pBW9/iJtP0EuYu8ctbwBfQGSff/xDKd54TT8VlA4efJqny4g1mjL3f
         GPx2wdQffDodKpq6CIejkhJplIL0zrhzNgxbuawv+ORKnzwgej6xRJwF1yAzc6+S68
         M5Y60z4QqkHyoAFc9OAD+PSyonPu1g3TrjT2hB0o=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200113152656.2313846-1-heiko@sntech.de>
References: <20200113152656.2313846-1-heiko@sntech.de>
Subject: Re: [PATCH] clk: rockchip: convert rk3036 pll type to use internal lock status
To:     Heiko Stuebner <heiko@sntech.de>, linux-clk@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        mturquette@baylibre.com, heiko@sntech.de,
        christoph.muellner@theobroma-systems.com, zhangqing@rock-chips.com,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8.1
Date:   Mon, 13 Jan 2020 21:05:18 -0800
Message-Id: <20200114050518.D3C40222C3@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Heiko Stuebner (2020-01-13 07:26:56)
> diff --git a/drivers/clk/rockchip/clk-pll.c b/drivers/clk/rockchip/clk-pl=
l.c
> index 198417d56300..37378ded0993 100644
> --- a/drivers/clk/rockchip/clk-pll.c
> +++ b/drivers/clk/rockchip/clk-pll.c
> @@ -118,12 +118,30 @@ static int rockchip_pll_wait_lock(struct rockchip_c=
lk_pll *pll)
>  #define RK3036_PLLCON1_REFDIV_SHIFT            0
>  #define RK3036_PLLCON1_POSTDIV2_MASK           0x7
>  #define RK3036_PLLCON1_POSTDIV2_SHIFT          6
> +#define RK3036_PLLCON1_LOCK_STATUS             BIT(10)
>  #define RK3036_PLLCON1_DSMPD_MASK              0x1
>  #define RK3036_PLLCON1_DSMPD_SHIFT             12
> +#define RK3036_PLLCON1_PWRDOWN                 BIT(13)
>  #define RK3036_PLLCON2_FRAC_MASK               0xffffff
>  #define RK3036_PLLCON2_FRAC_SHIFT              0
> =20
> -#define RK3036_PLLCON1_PWRDOWN                 (1 << 13)
> +static int rockchip_rk3036_pll_wait_lock(struct rockchip_clk_pll *pll)
> +{
> +       u32 pllcon;
> +       int delay =3D 24000000;
> +
> +       /* poll check the lock status in rk3399 xPLLCON2 */
> +       while (delay > 0) {
> +               pllcon =3D readl_relaxed(pll->reg_base + RK3036_PLLCON(1)=
);
> +               if (pllcon & RK3036_PLLCON1_LOCK_STATUS)
> +                       return 0;
> +
> +               delay--;

There isn't any udelay here. So the timeout is just as fast as the CPU
can churn through this? Why not use an actual time? Or use the
readl_poll_timeout() APIs?

> +       }
> +
> +       pr_err("%s: timeout waiting for pll to lock\n", __func__);
> +       return -ETIMEDOUT;
> +}
> =20
>  static void rockchip_rk3036_pll_get_params(struct rockchip_clk_pll *pll,
>                                         struct rockchip_pll_rate_table *r=
ate)
