Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34ED5C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 09:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 078E22063A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 09:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595582477;
	bh=yzvA6x1K/ofORRNFxS/YTkcSJBuP70GnO9DHjdCbaMA=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=OT+1abc6nC31WqYqFZIhjBtoNjDvdcc/kEQcfk5Z+BxrL1x4CCHw7KKod3ze9r8DZ
	 ovbSEsa/uUKBF60pbVyPAjpUO2EyU+L125vmdKV4BMxMkTMYC42IaAn0ibuwvzmzZ5
	 t699HvBeD0eKjzFfYtrWPtZ/VtPX8PngOYt7xyBM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728222AbgGXJVP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 05:21:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:51434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726591AbgGXJVP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 05:21:15 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A63E62063A;
        Fri, 24 Jul 2020 09:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595582474;
        bh=yzvA6x1K/ofORRNFxS/YTkcSJBuP70GnO9DHjdCbaMA=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=NJlRJhXTl8XsGo38uM2Ja8bXfVGyN6Lm6IdeZrbBININLdzbH64PNSPFfaWjrF0mY
         btdrI6PtMEXnT3eO0BY8TC1UflVNpGUDJsEEstgxzBGAipxGZjBLspjivn3qa5uV01
         T8ky+3yBuKzde6xWOFcUwOBHa9XB5pWxs3wQ4Jds=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1595403506-8209-7-git-send-email-claudiu.beznea@microchip.com>
References: <1595403506-8209-1-git-send-email-claudiu.beznea@microchip.com> <1595403506-8209-7-git-send-email-claudiu.beznea@microchip.com>
Subject: Re: [PATCH v2 06/18] clk: at91: sam9x60-pll: use frac when setting frequency
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     bbrezillon@kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com,
        mturquette@baylibre.com, nicolas.ferre@microchip.com
Date:   Fri, 24 Jul 2020 02:21:14 -0700
Message-ID: <159558247402.3847286.15323044899350602191@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Claudiu Beznea (2020-07-22 00:38:14)
> In commit a436c2a447e59 ("clk: at91: add sam9x60 PLL driver")
> the fractional part of PLL wasn't set on registers but it was
> calculated and taken into account for determining div and mul
> (see sam9x60_pll_get_best_div_mul()).
>=20
> Fixes: a436c2a447e59 ("clk: at91: add sam9x60 PLL driver")
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---

Applied to clk-next
