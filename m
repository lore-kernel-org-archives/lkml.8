Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99718C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 21:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7431F20787
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 21:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589490149;
	bh=BpiNhcYdcKddO8cs3Vt8IZUscWTK1/Is8oqrDfZkC6w=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=zC/nyZdy8QS/QbBkG+f3f1cV4I4JDvV6gI57sBIjfejIZrguaDkvDR4/bicBekvlx
	 Zxsb3j0KfA9rOoXzH5RpL0N9rJ9Lgf5DJec+QszFnOlv8MgXgmSVmWJK5HT/FYzw2H
	 hlKAQ7OgpNmIfmMJePcGXGCyUEuyC7Vt8KXzSe9A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727904AbgENVC3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 17:02:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:41318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726201AbgENVC2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 17:02:28 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4298206F1;
        Thu, 14 May 2020 21:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589490148;
        bh=BpiNhcYdcKddO8cs3Vt8IZUscWTK1/Is8oqrDfZkC6w=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=hyfFgR+GL76NQf566ZtlB+WOryIov5DSxhUL5b5JUGfd+iX0ldBn3aeIuHEmGYr5F
         EJi9Wz7J28FNtt08VJYBztNyXwTQJ6uHS1pGhU4g7jeCKpOQ1WCr4QwXnoluVb/vcF
         CFUnP5fIMuLO3vUY90BKaBpUzqs5HHWHXbnfeD0k=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1589267017-17294-5-git-send-email-dillon.minfei@gmail.com>
References: <1589267017-17294-1-git-send-email-dillon.minfei@gmail.com> <1589267017-17294-5-git-send-email-dillon.minfei@gmail.com>
Subject: Re: [PATCH v3 4/5] clk: stm32: Fix stm32f429 ltdc driver loading hang in clk set rate. keep ltdc clk running after kernel startup
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-clk@vger.kernel.org,
        dillon.minfei@gmail.com
To:     airlied@linux.ie, alexandre.torgue@st.com, daniel@ffwll.ch,
        dillon.minfei@gmail.com, mcoquelin.stm32@gmail.com,
        mturquette@baylibre.com, robh+dt@kernel.org, sam@ravnborg.org,
        thierry.reding@gmail.com
Date:   Thu, 14 May 2020 14:02:27 -0700
Message-ID: <158949014721.215346.12197373767247910756@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting dillon.minfei@gmail.com (2020-05-12 00:03:36)
> From: dillon min <dillon.minfei@gmail.com>
>=20
> as store stm32f4_rcc_register_pll return to the wrong offset of clks,

Use () on functions, i.e. stm32f4_rcc_register_pll().

> so ltdc gate clk is null. need change clks[PLL_VCO_SAI] to clks[PLL_SAI]

And quote variables like 'clks[PLL_VCO_SAI]'

>=20
> add CLK_IGNORE_UNUSED for ltdc to make sure clk not be freed by
> clk_disable_unused

clk_disable_unused() doesn't free anything. Why does ltdc not need to be
turned off if it isn't used? Is it critical to system operation? Should
it be marked with the critical clk flag then? The CLK_IGNORE_UNUSED flag
is almost always wrong to use.

>=20
> Signed-off-by: dillon min <dillon.minfei@gmail.com>
> ---
>  drivers/clk/clk-stm32f4.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/clk/clk-stm32f4.c b/drivers/clk/clk-stm32f4.c
> index 18117ce..0ba73de 100644
> --- a/drivers/clk/clk-stm32f4.c
> +++ b/drivers/clk/clk-stm32f4.c
> @@ -129,7 +129,8 @@ static const struct stm32f4_gate_data stm32f429_gates=
[] __initconst =3D {
>         { STM32F4_RCC_APB2ENR, 20,      "spi5",         "apb2_div" },
>         { STM32F4_RCC_APB2ENR, 21,      "spi6",         "apb2_div" },
>         { STM32F4_RCC_APB2ENR, 22,      "sai1",         "apb2_div" },
> -       { STM32F4_RCC_APB2ENR, 26,      "ltdc",         "apb2_div" },
> +       { STM32F4_RCC_APB2ENR, 26,      "ltdc",         "apb2_div",
> +               CLK_IGNORE_UNUSED },
>  };
> =20
>  static const struct stm32f4_gate_data stm32f469_gates[] __initconst =3D {
> @@ -1757,7 +1758,7 @@ static void __init stm32f4_rcc_init(struct device_n=
ode *np)
>         clks[PLL_VCO_I2S] =3D stm32f4_rcc_register_pll("vco_in",
>                         &data->pll_data[1], &stm32f4_clk_lock);
> =20
> -       clks[PLL_VCO_SAI] =3D stm32f4_rcc_register_pll("vco_in",
> +       clks[PLL_SAI] =3D stm32f4_rcc_register_pll("vco_in",
>                         &data->pll_data[2], &stm32f4_clk_lock);
> =20
>         for (n =3D 0; n < MAX_POST_DIV; n++) {
