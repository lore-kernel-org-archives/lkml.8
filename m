Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF3CC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 00:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B3AE2078D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 00:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593045768;
	bh=PcUydYqCNth993+HfcQufpfx+vvAPPjOCB6GTFtsxXQ=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=TH9PrVPVxhg9gIy07APese1BjtUp5MxLDBCMzwaaIR9M8F8KCSI39F3umrXpNjkxc
	 gWrSJHJUzszN1PSdawm6X4Tn6dbwlmJ8aeXNeie77Fq0daxxg25Odx4dJp94Y9X6bh
	 s1KyAdN3M8bzv7oQuinmdiaebf3SVEWKPfAJ1vsM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389153AbgFYAmr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 20:42:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:57042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389124AbgFYAmp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 20:42:45 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00E3A2078D;
        Thu, 25 Jun 2020 00:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593045765;
        bh=PcUydYqCNth993+HfcQufpfx+vvAPPjOCB6GTFtsxXQ=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=WydtSU7lInm6xL11HamevpG/267c3/2HRcfy77jKh81z1OYA1lkXij2Ec0w3fcuUX
         jWhi7zqZa2COUL5oHWozOpz8zuLTq+MSB9tF1dNRRjydQ4rTWjR8U83lx2cAf5MZuP
         5bqr8ajHse40BNG/mBf8XLtcZndu2uU+V7o1/1CY=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1146177664999eeda65856d28ce94025021dd85e.1592210452.git-series.maxime@cerno.tech>
References: <cover.98f979c2af2337c57217016d21d7c68e1ac2ce8a.1592210452.git-series.maxime@cerno.tech> <1146177664999eeda65856d28ce94025021dd85e.1592210452.git-series.maxime@cerno.tech>
Subject: Re: [PATCH v5 06/27] clk: bcm: rpi: Use clk_hw_register for pllb_arm
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
Date:   Wed, 24 Jun 2020 17:42:44 -0700
Message-ID: <159304576432.62212.14289486170605189002@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Maxime Ripard (2020-06-15 01:40:46)
> The pllb_arm clock is defined as a fixed factor clock with the pllb
> clock as a parent. However, all its configuration is entirely static,
> and thus we don't really need to call clk_hw_register_fixed_factor() but
> can simply call clk_hw_register() with a static clk_fixed_factor
> structure.
>=20
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: linux-clk@vger.kernel.org
> Acked-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Reviewed-by: Stephen Boyd <sboyd@kernel.org>
> Tested-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---

Applied to clk-next
