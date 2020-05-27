Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F2DEC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 07:03:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 168F1207E8
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 07:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590563000;
	bh=LhwzZ24hfZZZERXjwv0SCDky3MmpIWrKK1ViT7H5PAk=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=CdbAtA9JUoOwyMjb7jWE2v57VFwRT1iYy5dwwzCuvqOMzsdK57JN60OWcI6dDLPfb
	 HpLv61UWleWRlV311Eb1aCni5DlXLCy9zRNkd9SpJMIiPCoyI+BuznGCs60Gj8C93D
	 Fi8qxb/KpnBj/dbdBuebN+DG3MefOotbN6P00/1k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729018AbgE0HDT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 03:03:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:35748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726025AbgE0HDT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 03:03:19 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47E85207CB;
        Wed, 27 May 2020 07:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590562998;
        bh=LhwzZ24hfZZZERXjwv0SCDky3MmpIWrKK1ViT7H5PAk=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=tSeNvf8xROTQJAx1K3QWz2fmLTWCWIDKHQBVpNUyMIf1kjPdgTkhUpLSlmpmTQvYu
         Cu3XCk/RAU33/h8rJ5ZQSZj4PzzuEurNELuVWI1nFF5+WmhTej4Zn7qgx0wpldILyq
         2XNUQdrpZewLdaclffsYXC0o9+OKgz6AfJr34His=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1a25b4f079dcdc669d4b29d3658ef0b72be2651e.1587742492.git-series.maxime@cerno.tech>
References: <cover.d1e741d37e43e1ba2d2ecd93fc81d42a6df99d14.1587742492.git-series.maxime@cerno.tech> <1a25b4f079dcdc669d4b29d3658ef0b72be2651e.1587742492.git-series.maxime@cerno.tech>
Subject: Re: [PATCH v2 20/91] clk: bcm: rpi: Discover the firmware clocks
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     dri-devel@lists.freedesktop.org,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org
To:     Eric Anholt <eric@anholt.net>, Maxime Ripard <maxime@cerno.tech>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Date:   Wed, 27 May 2020 00:03:17 -0700
Message-ID: <159056299757.88029.2814367530440231587@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Maxime Ripard (2020-04-24 08:34:01)
> The RaspberryPi4 firmware actually exposes more clocks than are currently
> handled by the driver and we will need to change some of them directly
> based on the pixel rate for the display related clocks, or the load for t=
he
> GPU.
>=20
> This rate change can have a number of side-effects, including adjusting t=
he
> various PLL voltages or the PLL parents. The firmware will also update
> those clocks by itself for example if the SoC runs too hot.
>=20
> In order to make Linux play as nice as possible with those constraints, it
> makes sense to rely on the firmware clocks as much as possible.
>=20
> Fortunately,t he firmware has an interface to discover the clocks it

Fortunately, the

> exposes.
>=20
> Let's use it to discover, register the clocks in the clocks framework and
> then expose them through the device tree for consumers to use them.
>=20
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: linux-clk@vger.kernel.org
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
