Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08AE1C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 00:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8F402078D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 00:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593045931;
	bh=4EJKTeGmxhXd21FJI2zpa9B+gOQKhi/iMp10zYWR5u8=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=DtwzZzZjBQRDpQydcoJyQBaiuqmgzgIo02Fzrq6lPAVndfqRroWHrwnAxtsGVnk7m
	 w9Fb7of2wHXKq5d8P3DgixLmBPEZu8BSjQLBg6QqD+MvrSQWVzaYn96HU79SrdwWyu
	 D2QiYvyPHzUT37nQhfVru1YxFaxCsBnQbMx83HAU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389478AbgFYApa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 20:45:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:59280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388776AbgFYAp2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 20:45:28 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 813502078D;
        Thu, 25 Jun 2020 00:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593045928;
        bh=4EJKTeGmxhXd21FJI2zpa9B+gOQKhi/iMp10zYWR5u8=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=ZIsf8S3+7yEHCF0spHfihQXBwdMJi8U29W9I7ZSPM6fIWrQDXMAa1fHxCTlIxDhpZ
         NQnYvkwuvU8B4bQYAhPvP9xj20d0FB6Q+I5FHRENepkg7PaVPQtCj4O+ja/M6F0yZZ
         HMxkW800c6Wa9ns3dzEMjVAbalLDaTLaOarQTcBY=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <97218559db643e62fdd2b5e3046a2a05b8c2e769.1592210452.git-series.maxime@cerno.tech>
References: <cover.98f979c2af2337c57217016d21d7c68e1ac2ce8a.1592210452.git-series.maxime@cerno.tech> <97218559db643e62fdd2b5e3046a2a05b8c2e769.1592210452.git-series.maxime@cerno.tech>
Subject: Re: [PATCH v5 18/27] clk: bcm: rpi: Make the PLLB registration function return a clk_hw
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
Date:   Wed, 24 Jun 2020 17:45:27 -0700
Message-ID: <159304592785.62212.2642388326297780385@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Maxime Ripard (2020-06-15 01:40:58)
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
> Cc: linux-clk@vger.kernel.org
> Acked-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Reviewed-by: Stephen Boyd <sboyd@kernel.org>
> Tested-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---

Applied to clk-next
