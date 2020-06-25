Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A53B1C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 00:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D446207DD
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 00:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593045874;
	bh=eVp9tWQlzgqoCNiY2YM/qYEqSjzcQEgmoD76TAskP7M=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=ejxj/BDWPRgcVZgAIoqPe66e/dIrR64Aks2qbCOXOg+d4abD6J0s0RNrnjREqA4iu
	 FPxwviNjkFyri4lpHzxxDADyo2gtWU77k79swUvMO/FUJYbzbhlRgZpiML0xcYD6bp
	 Xxm2tb/2In/JwU7Jl0hUwfKDRaoiTEfrjE4GVox4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388942AbgFYAoc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 20:44:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:58194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388624AbgFYAoc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 20:44:32 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 089BC20781;
        Thu, 25 Jun 2020 00:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593045872;
        bh=eVp9tWQlzgqoCNiY2YM/qYEqSjzcQEgmoD76TAskP7M=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=aBKeXan4vTgSVF5NHBYg+bkaxjAgAf5xdOp2V4GciGmKBOXJ+FnJkqa5oFXgVRnYS
         fiL0TR3zLiYyKuVuTffkUdWY+fDyFvQBFE8C6iaVxBAtUEqPNtaILtimO6I45b+yz4
         VxP4jQPGbkowu53ARkarQlaUiDhxbIIMGllklK24=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <189407f54906d2b07c91de7a4eeb6d8c8934280f.1592210452.git-series.maxime@cerno.tech>
References: <cover.98f979c2af2337c57217016d21d7c68e1ac2ce8a.1592210452.git-series.maxime@cerno.tech> <189407f54906d2b07c91de7a4eeb6d8c8934280f.1592210452.git-series.maxime@cerno.tech>
Subject: Re: [PATCH v5 09/27] clk: bcm: rpi: Remove pllb_arm_lookup global pointer
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
Date:   Wed, 24 Jun 2020 17:44:31 -0700
Message-ID: <159304587118.62212.15548134071653686347@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Maxime Ripard (2020-06-15 01:40:49)
> The pllb_arm_lookup pointer in the struct raspberrypi_clk is not used for
> anything but to store the returned pointer to clkdev_hw_create, and is not
> used anywhere else in the driver.
>=20
> Let's remove that global pointer from the structure.
>=20
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: linux-clk@vger.kernel.org
> Acked-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Reviewed-by: Stephen Boyd <sboyd@kernel.org>
> Tested-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---

Applied to clk-next
