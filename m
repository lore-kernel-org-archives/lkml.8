Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E94CC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 08:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 748A72084C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 08:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590568507;
	bh=4P6drQSHi9/fWQsr/Ga8r0JMRYT3l59WI9ynWwuCi20=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=v1mhSg9QfegQNFjmIBAauDBXMN5pPLToyU2o6m6ZUWv9NZ9sVks4a9XuSMQoFk3do
	 XXHoTa+VCnpTlNm7F4zX8+Q1fMWkUMS08EYcDOfP0aMxA20si4AwzgIDh3Ji4xxc0w
	 0pR2gWxV9AHA15JX200HsVLkJpnYoi6taTGhMzZc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388118AbgE0IfG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 04:35:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:40340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388082AbgE0IfE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 04:35:04 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7453D20723;
        Wed, 27 May 2020 08:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590568504;
        bh=4P6drQSHi9/fWQsr/Ga8r0JMRYT3l59WI9ynWwuCi20=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=OjqOTc1g6ZzEGZuUAXSx989Y9yhyWypaASH76M03vrBHEMdC2kKDvUqSFrGWTrFmH
         1HPFcNZTtVVMVJUpFSVbdN9ObGVTdQznRmcwESXxXFFL1NCa3d9/N9vuwCqVXrJ7bO
         igkQZANuQEZyBwRcwAGYW/38P863/fZt08cACyao=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1590564453-24499-6-git-send-email-dillon.minfei@gmail.com>
References: <1590564453-24499-1-git-send-email-dillon.minfei@gmail.com> <1590564453-24499-6-git-send-email-dillon.minfei@gmail.com>
Subject: Re: [PATCH v6 5/9] clk: stm32: Fix stm32f429's ltdc driver hang in set clock rate
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        dri-devel@lists.freedesktop.org, linux-clk@vger.kernel.org,
        dillonhua@gmail.com, dillon min <dillon.minfei@gmail.com>
To:     airlied@linux.ie, alexandre.torgue@st.com,
        andy.shevchenko@gmail.com, broonie@kernel.org, daniel@ffwll.ch,
        dillon.minfei@gmail.com, linus.walleij@linaro.org,
        mcoquelin.stm32@gmail.com, mturquette@baylibre.com,
        noralf@tronnes.org, p.zabel@pengutronix.de, robh+dt@kernel.org,
        sam@ravnborg.org, thierry.reding@gmail.com
Date:   Wed, 27 May 2020 01:35:03 -0700
Message-ID: <159056850384.88029.10852284922297394339@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting dillon.minfei@gmail.com (2020-05-27 00:27:29)
> From: dillon min <dillon.minfei@gmail.com>
>=20
> This is due to misuse \u2018PLL_VCO_SAI' and'PLL_SAI' in clk-stm32f4.c
> 'PLL_SAI' is 2, 'PLL_VCO_SAI' is 7(defined in
> include/dt-bindings/clock/stm32fx-clock.h).
>=20
> 'post_div' point to 'post_div_data[]', 'post_div->pll_num'
> is PLL_I2S or PLL_SAI.
>=20
> 'clks[PLL_VCO_SAI]' has valid 'struct clk_hw* ' return
> from stm32f4_rcc_register_pll() but, at line 1777 of
> driver/clk/clk-stm32f4.c, use the 'clks[post_div->pll_num]',
> equal to 'clks[PLL_SAI]', this is invalid array member at that time.
>=20
> Fixes: 517633ef630e ("clk: stm32f4: Add post divisor for I2S & SAI PLLs")
> Signed-off-by: dillon min <dillon.minfei@gmail.com>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>
