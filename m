Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD43C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 00:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 397E12078D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 00:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593045762;
	bh=RC/5b7K+2q17iSzorVeB5nMh86Dfg+CDxXaxH+xbimU=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=B5vZz2Dzj6BkzG5zv8OmfDI0SBCrbI26TdLjztqajDFY4/U+Gg+1uPGAEj5G5q0IJ
	 tzPQDEFXqmWj3AhjDPyu2xao9VS9kjCtmSmCUcMbUsjf1vd5dfrT1zhAS9IFHk9IrU
	 B4DjEVxSmDZWKDXYASTMZOMFGuWbVwPsPDycBTXc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389077AbgFYAmk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 20:42:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:56810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388985AbgFYAme (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 20:42:34 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0783F2078D;
        Thu, 25 Jun 2020 00:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593045754;
        bh=RC/5b7K+2q17iSzorVeB5nMh86Dfg+CDxXaxH+xbimU=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=lJjXTU/qkiR2AgwZOFgkCBaTkyTzonBm9F1uSwpK1Y3ubTWRpi0+H+qI4nUnBhep7
         2taQLhFizeLiSyorLOCo6GIcGIbRvRckYU6igRdfZrQYCurWEtmTvW6g99xn/bb41I
         4yKxSnaNlnyA36FQEVJnUNT/WRLVTj/lCBd37l3k=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <cb8203b862e386ac6c3df3eff0bb5a238b6ec97a.1592210452.git-series.maxime@cerno.tech>
References: <cover.98f979c2af2337c57217016d21d7c68e1ac2ce8a.1592210452.git-series.maxime@cerno.tech> <cb8203b862e386ac6c3df3eff0bb5a238b6ec97a.1592210452.git-series.maxime@cerno.tech>
Subject: Re: [PATCH v5 04/27] clk: bcm: rpi: Allow the driver to be probed by DT
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
Date:   Wed, 24 Jun 2020 17:42:33 -0700
Message-ID: <159304575336.62212.12293766174704501693@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Maxime Ripard (2020-06-15 01:40:44)
> The current firmware clock driver for the RaspberryPi can only be probed =
by
> manually registering an associated platform_device.
>=20
> While this works fine for cpufreq where the device gets attached a clkdev
> lookup, it would be tedious to maintain a table of all the devices using
> one of the clocks exposed by the firmware.
>=20
> Since the DT on the other hand is the perfect place to store those
> associations, make the firmware clocks driver probe-able through the devi=
ce
> tree so that we can represent it as a node.
>=20
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: linux-clk@vger.kernel.org
> Reviewed-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Reviewed-by: Stephen Boyd <sboyd@kernel.org>
> Tested-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---

Applied to clk-next
