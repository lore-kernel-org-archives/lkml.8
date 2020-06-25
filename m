Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE45EC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 00:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 890C820781
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 00:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593045917;
	bh=iA6poNxIvDJ0EZkA/v+9J52LsbnOHsENyll8SuSe+nQ=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=Ro/r1SS+nKw22EkyGHxRNFfu6IfT9yauHbHQLHkO8CIXroz5rqlpBMJeVNbmcOWKt
	 cgdyXpFOHkcN2VgBf7HLEKGWw7J2unGFwvUSoYzZFWlliJ89K3zRwW5u8sY1H1UqTs
	 MnSbOHOJM/yL6iADUJCM+4xr+Nyzcc/BRbGIc+jo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389447AbgFYApP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 20:45:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:59040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388776AbgFYApO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 20:45:14 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5AFD120781;
        Thu, 25 Jun 2020 00:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593045914;
        bh=iA6poNxIvDJ0EZkA/v+9J52LsbnOHsENyll8SuSe+nQ=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=bZpCiJ6Y7azzwhbFQBm3dQg0GF0S8WnVWFNcTxyk4E2imANJrVGUnePRHR7HsRmti
         zZZgjSayJFfEhtKapcykaGf7jUREZxPQaFXjCw7MUFq1HwKJ0LW5MBG6bQ1TL3GJA2
         w9pLr/VgpynPbLNmxHJtbj/njiHzZxip8bMbzB38=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ac93cc4e245316bb7e7426ac5ab0de8f3d919731.1592210452.git-series.maxime@cerno.tech>
References: <cover.98f979c2af2337c57217016d21d7c68e1ac2ce8a.1592210452.git-series.maxime@cerno.tech> <ac93cc4e245316bb7e7426ac5ab0de8f3d919731.1592210452.git-series.maxime@cerno.tech>
Subject: Re: [PATCH v5 16/27] clk: bcm: rpi: Rename is_prepared function
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
Date:   Wed, 24 Jun 2020 17:45:13 -0700
Message-ID: <159304591377.62212.4061892478238859056@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Maxime Ripard (2020-06-15 01:40:56)
> The raspberrypi_fw_pll_is_on function doesn't only apply to PLL
> registered in the driver, but any clock exposed by the firmware.
>=20
> Since we also implement the is_prepared hook, make the function
> consistent with the other function names.
>=20
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: linux-clk@vger.kernel.org
> Acked-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Reviewed-by: Stephen Boyd <sboyd@kernel.org>
> Tested-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---

Applied to clk-next
