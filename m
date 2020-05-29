Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04536C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 21:17:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC63620810
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 21:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590787064;
	bh=WRzLoeTKcpJYlb0xcRQnIBu/6jhB4bJJj8u1DGLiyf8=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=iFatQYUyEXxGLlrf65trkM9GhvJ1DZ/x+3meuiBqBFY/7TMReZvEVBcyp6aDdHE27
	 BfRruNgaEtBCenxJJco4BdW12AuhaL7K6SaOWeW8Q6znGY/Ix/mo+HA7dOgI+Kx/es
	 SxnRF1Vde8L7mvuPsle50aoZyRZoVnusRJQQBu5o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbgE2VRo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 17:17:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:37382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727851AbgE2VRn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 17:17:43 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3EACC2071A;
        Fri, 29 May 2020 21:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590787063;
        bh=WRzLoeTKcpJYlb0xcRQnIBu/6jhB4bJJj8u1DGLiyf8=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=t5FPO0ex15hYRl/UqkT1WKbNoPgVa8e0dXXfRLmz8LQX4TPl9UW66C1km4DeuOluw
         yVfv7T+aroE3bhvpvaXUm7tRqTHDXPrSqVW0MFAHoTeMowJ3pvneXIZ8t30AVV6nZ+
         g7BG7FOTnOzLuiekSFF8cp2JkHKkp9s/4PR9y2r8=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <fa709f71b27aadf987685f7cae2a65cc3cef8e3d.1590594293.git-series.maxime@cerno.tech>
References: <cover.662a8d401787ef33780d91252a352de91dc4be10.1590594293.git-series.maxime@cerno.tech> <fa709f71b27aadf987685f7cae2a65cc3cef8e3d.1590594293.git-series.maxime@cerno.tech>
Subject: Re: [PATCH v3 04/25] clk: bcm: rpi: Allow the driver to be probed by DT
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org
To:     Maxime Ripard <maxime@cerno.tech>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Date:   Fri, 29 May 2020 14:17:42 -0700
Message-ID: <159078706249.69627.8608582887590685081@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Maxime Ripard (2020-05-27 08:45:00)
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
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: linux-clk@vger.kernel.org
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
