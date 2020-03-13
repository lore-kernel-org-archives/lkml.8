Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B8CDC2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 01:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C07B206EB
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 01:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584061312;
	bh=x5AeLJyWyoIGFX+5Aa87kt9hQBBmnyGXbQ3/T3AqMkQ=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=hr+f0X3iDgNFK5A69rKFtVh9sBUbvegZJnvNkmYPLXJE/D1H+yH4fP3WKL4JteWId
	 2x7U9fp16aE2b6HoeLRY88TMZJPOSuI1V90B4wznZxuhZBaFtWQn+qQvGulLaroEAX
	 hD7rCMgFNgP9YKKtfklRh4alBABx4O/lJ5jlu9/I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbgCMBBv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 21:01:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:60790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726620AbgCMBBu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 21:01:50 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 54B3220637;
        Fri, 13 Mar 2020 01:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584061310;
        bh=x5AeLJyWyoIGFX+5Aa87kt9hQBBmnyGXbQ3/T3AqMkQ=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=W9pRQZvOYY6JUPfum0Gaehu89VEbg3YArAi7o1G9YMddG1IH8VX4dSmBjuQz0WpDi
         MFHtvxjrx/LmGY9yOgvy2Nc+JfNT48HMz2UEZ725Ql2oWw2oOeGqGCekvIqILo+O/J
         07nTyLQzg7Tx/jiayemVhFKQGpPmXxGjUYbdH6aA=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <6a1fc860262ecec585cbe8ff268318a0783f3296.1582533919.git-series.maxime@cerno.tech>
References: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech> <6a1fc860262ecec585cbe8ff268318a0783f3296.1582533919.git-series.maxime@cerno.tech>
Subject: Re: [PATCH 20/89] clk: bcm: rpi: Make the PLLB registration function return a clk_hw
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
Date:   Thu, 12 Mar 2020 18:01:49 -0700
Message-ID: <158406130956.149997.16470857788374770112@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Maxime Ripard (2020-02-24 01:06:22)
> The raspberrypi_register_pllb has been returning an integer so far to
> notify whether the functions has exited successfully or not.
>=20
> However, the OF provider functions in the clock framework require access =
to
> the clk_hw structure so that we can expose those clocks to device tree
> consumers.
>=20
> Since we'll want that for the future clocks, let's return a clk_hw pointer
> instead of the return code.
>=20
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: linux-clk@vger.kernel.org
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
