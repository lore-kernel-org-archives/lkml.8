Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76722C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 00:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54C9A22596
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 00:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592612301;
	bh=osikKDkM850lR2FBmD5l5HMIHMluq1zlBDZidv0be0k=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=I0qxZXwDedVEqJ0G8aELo7w40Wey672QV13iU9RWzsSh+NobSCu/d62voI1Da37uJ
	 W6q48mcpyISbD8QrUQFeXjYAR/Mc2D16FwiMkoP4yy2SwyAteSwwEpsrCJxu7ObpeC
	 VMRPFcBaubR0DGLPlOcXITNeP9QF0c4yKUYmyhc8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730776AbgFTASS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 20:18:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:42748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730616AbgFTASS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 20:18:18 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E339F22581;
        Sat, 20 Jun 2020 00:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592612298;
        bh=osikKDkM850lR2FBmD5l5HMIHMluq1zlBDZidv0be0k=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=vV1qjd7v/nu1m8XNt4Z55lOGttAL9lFS/r1smZk7czRSYezM08gVosZQdPStl7i15
         ztZE7FXvEcM0Y0pLyiWPjYHX5ZxPCUbceYQujiaIXfxzgyOAjjqJR5irfa3Jls1Tnr
         317j9Kt8lFlNhfmWGZQ/5mT+YQjedwjko4GHO8f4=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <bb60d97fc76b61c2eabef5a02ebd664c0f57ede0.1591867332.git-series.maxime@cerno.tech>
References: <cover.4c4625a8e076f3163b800b3d8986b282ee98d908.1591867332.git-series.maxime@cerno.tech> <bb60d97fc76b61c2eabef5a02ebd664c0f57ede0.1591867332.git-series.maxime@cerno.tech>
Subject: Re: [PATCH v4 2/3] clk: bcm: Add BCM2711 DVP driver
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Mike Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>,
        Maxime Ripard <maxime@cerno.tech>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
To:     Maxime Ripard <maxime@cerno.tech>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Date:   Fri, 19 Jun 2020 17:18:17 -0700
Message-ID: <159261229723.62212.14539741371772719130@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Maxime Ripard (2020-06-11 02:23:16)
> The HDMI block has a block that controls clocks and reset signals to the
> HDMI0 and HDMI1 controllers.
>=20
> Let's expose that through a clock driver implementing a clock and reset
> provider.
>=20
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: linux-clk@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Reviewed-by: Stephen Boyd <sboyd@kernel.org>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---

Applied to clk-next
