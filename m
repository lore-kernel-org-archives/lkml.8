Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BCA6C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 00:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3499D207DD
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 00:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593045887;
	bh=RhLRw/uYXxHupfqCwi1DO/uOEegAI2B9r8fj8Y/WRIM=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=ATJit2+ZrVd6XKp+fjRzaPRhLplV5jBeRHztQ41OphFYizlnl6XxBfTgcK30cTqnq
	 Jhkae9RhPUvs2E+N2StHWBc8Fft7TyV8SvOHYC3P5YbYjTp+3fAtRBBjHIUB8H45D+
	 UkT5Kphe9fooa6tPR2J6nMYhr4Ayb6HnBo9A42u8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389326AbgFYAop (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 20:44:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:58408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388624AbgFYAoo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 20:44:44 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D3442078D;
        Thu, 25 Jun 2020 00:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593045884;
        bh=RhLRw/uYXxHupfqCwi1DO/uOEegAI2B9r8fj8Y/WRIM=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=xWBUjqqqJJ7vSxoVu6/TjoI05BRFqmDlwYjHn1Zb0jiewhTTNVjpgdf6uPwvsRiB8
         fI3kl1WDvZE/Y5S6RoqT5rLOea+9VZAaz4NS1ER6kCKJMDfz4aIg1TcGeUS4eGTNX2
         rvVB9PAa526cMkzrTBMwUCSiSN+/BsCqII0WfuKc=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <075e2c6d315eccdaf8fb72b320712b86e6c25b22.1592210452.git-series.maxime@cerno.tech>
References: <cover.98f979c2af2337c57217016d21d7c68e1ac2ce8a.1592210452.git-series.maxime@cerno.tech> <075e2c6d315eccdaf8fb72b320712b86e6c25b22.1592210452.git-series.maxime@cerno.tech>
Subject: Re: [PATCH v5 11/27] clk: bcm: rpi: Make sure the clkdev lookup is removed
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
Date:   Wed, 24 Jun 2020 17:44:43 -0700
Message-ID: <159304588380.62212.13689179218284927202@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Maxime Ripard (2020-06-15 01:40:51)
> The clkdev lookup created for the cpufreq device is never removed if
> there's an issue later in probe or at module removal time.
>=20
> Let's convert to the managed variant of the clk_hw_register_clkdev functi=
on
> to make sure it happens.
>=20
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: linux-clk@vger.kernel.org
> Acked-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Reviewed-by: Stephen Boyd <sboyd@kernel.org>
> Tested-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---

Applied to clk-next
