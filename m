Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3154C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 00:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB12A20781
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 00:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593045912;
	bh=+9u6Xy/kdguVoR5WsElQh9oqTXaYn/qypGKf+qtfmek=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=EwSTOi8fAQtjUWXPzNHib6GzSPQVxSeNmWwmTOGTtLeoOVmuWpcKOVcNQDtLo/FXe
	 mszPD23P98A9KgB1PrqBf/HwAKjmEL5Pn/cmPicFpntkfMn1affQbhzgP5smwPems4
	 l1R54CIgd2P/neRjNfZJzEeJfxgsLLPxhIf7h6LI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389422AbgFYApL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 20:45:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:58942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388776AbgFYApJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 20:45:09 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC765207DD;
        Thu, 25 Jun 2020 00:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593045909;
        bh=+9u6Xy/kdguVoR5WsElQh9oqTXaYn/qypGKf+qtfmek=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=SjRI70sb9a5pzD5JNlWMSgtUw/Ozn95qVmhMLGs5AaVVvhnRpO0dwo7TiTOkRcOjX
         VjggJsvlRx+yskkufr8aEj+Qtdz0x4y63Ls0HjNKjPkLAL9RxVam34hQgu/j8/lol6
         3Qmn4njV+hFZ5g1Ex7/uL1xwdcvNQdcYHfaMiOjs=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <d7a3b4df3ca23feb6e0d9c7ae2d232bfb913f926.1592210452.git-series.maxime@cerno.tech>
References: <cover.98f979c2af2337c57217016d21d7c68e1ac2ce8a.1592210452.git-series.maxime@cerno.tech> <d7a3b4df3ca23feb6e0d9c7ae2d232bfb913f926.1592210452.git-series.maxime@cerno.tech>
Subject: Re: [PATCH v5 15/27] clk: bcm: rpi: Pass the clocks data to the firmware function
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Mike Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>,
        Maxime Ripard <maxime@cerno.tech>
To:     Maxime Ripard <maxime@cerno.tech>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Date:   Wed, 24 Jun 2020 17:45:08 -0700
Message-ID: <159304590823.62212.1070025177113811374@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Maxime Ripard (2020-06-15 01:40:55)
> The raspberry_clock_property only takes the clock ID as an argument, but
> now that we have a clock data structure it makes more sense to just pass
> that structure instead.
>=20
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: linux-clk@vger.kernel.org
> Acked-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Reviewed-by: Stephen Boyd <sboyd@kernel.org>
> Tested-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---

Applied to clk-next
