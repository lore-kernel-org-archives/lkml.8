Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3565DC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 00:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13C7E207DD
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 00:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593045949;
	bh=LKxq1vCKLKIpADMZ+UDI12WU+rf1I5MZCsFlCu3RmsI=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=GXCSA+/+zWmi4t2BZKkKPaQCI9nORKroktfsuwc2Wh+xI1ISdAXlYbK/pLYwgor+Z
	 eCRh42FxFfRViu32W/8yUjvIwA7K+uWePccqDun+JJSlNgYMRFzIjtOPpX5Npw9Piq
	 TIxDI1++K9AdPzX3truUQAfBUUoQfuUsrpqe3tOs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389215AbgFYApr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 20:45:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:59716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388776AbgFYApq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 20:45:46 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6402207E8;
        Thu, 25 Jun 2020 00:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593045945;
        bh=LKxq1vCKLKIpADMZ+UDI12WU+rf1I5MZCsFlCu3RmsI=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=PpuT6A3uyqiexFIAtumZQFZftY2Ya/myj3q1BDdR0jGf2hCogFJelmoO4vbtQPnuu
         nBRbDWcAIAh1hZRT1SbJwEhcbjti35FsOlRd/yybjjnPynfqBDXHxQ9/G2OAZ5o/Rw
         XoQH+DXRbXsgAjrzb9eRUVJsO6PGztrAEotAvjXk=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <438d73962741a8c5f7c689319b7443b930a87fde.1592210452.git-series.maxime@cerno.tech>
References: <cover.98f979c2af2337c57217016d21d7c68e1ac2ce8a.1592210452.git-series.maxime@cerno.tech> <438d73962741a8c5f7c689319b7443b930a87fde.1592210452.git-series.maxime@cerno.tech>
Subject: Re: [PATCH v5 21/27] clk: bcm: rpi: Discover the firmware clocks
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
Date:   Wed, 24 Jun 2020 17:45:45 -0700
Message-ID: <159304594514.62212.1189188813523273350@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Maxime Ripard (2020-06-15 01:41:01)
> The RaspberryPi4 firmware actually exposes more clocks than are currently
> handled by the driver and we will need to change some of them directly
> based on the pixel rate for the display related clocks, or the load for t=
he
> GPU.
>=20
> Since the firmware implements DVFS, this rate change can have a number of
> side-effects, including adjusting the various PLL voltages or the PLL
> parents. The firmware also implements thermal throttling, so even some
> thermal pressure can change those parameters behind Linux back.
>=20
> DVFS is currently implemented on the arm, core, h264, v3d, isp and hevc
> clocks, so updating any of them using the MMIO driver (and thus behind the
> firmware's back) can lead to troubles, the arm clock obviously being the
> most problematic.
>=20
> In order to make Linux play as nice as possible with those constraints, it
> makes sense to rely on the firmware clocks as much as possible. However,
> the firmware doesn't seem to provide some equivalents to their MMIO
> counterparts, so we can't really replace that driver entirely.
>=20
> Fortunately, the firmware has an interface to discover the clocks it
> exposes.
>=20
> Let's use it to discover, register the clocks in the clocks framework and
> then expose them through the device tree for consumers to use them.
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
