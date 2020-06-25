Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBDF0C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 00:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 957942078D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 00:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593045742;
	bh=x2m/Ep1fMvoupjuf3NdrtoqfW84hsrK7rwpUV6U0Ldc=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=QIQy/4faG2IV6KksAkZy7omLJGDkVLRKCBg5+VU0qablJ9zfzFN4H8o4CoDAiWG4j
	 szANGSlPxrjOMeoE6sVt98CpVTEXlB7cy67jRll1dbVfByE0Se97rk3wrJR9Ijnz23
	 bCLlOxCTy0k4v4A/G/i82ajS/LpwliRZeDa1ph4g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388810AbgFYAmV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 20:42:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:56510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388467AbgFYAmU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 20:42:20 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52DA020781;
        Thu, 25 Jun 2020 00:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593045740;
        bh=x2m/Ep1fMvoupjuf3NdrtoqfW84hsrK7rwpUV6U0Ldc=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Si1kpCSwDvJFqurX+mCFOJaf9utQdUenkHY4T2s3VXNFOLCdPHPdWjymH+AYRPxb4
         byeRfNTzpU14lPPP6CyJaNPnXCXIt8DAC5Y/c29TkTAr1OFwxk2WKcp2rKuqHUUvWy
         KJ3D8itfV/ZS1dS9578nDKp38Rd7MCSjzXzlJi7s=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <5bc0b9be8544b07300fccab4d4f26e5e5d8e62b2.1592210452.git-series.maxime@cerno.tech>
References: <cover.98f979c2af2337c57217016d21d7c68e1ac2ce8a.1592210452.git-series.maxime@cerno.tech> <5bc0b9be8544b07300fccab4d4f26e5e5d8e62b2.1592210452.git-series.maxime@cerno.tech>
Subject: Re: [PATCH v5 01/27] dt-bindings: arm: bcm: Convert BCM2835 firmware binding to YAML
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
        Florian Fainelli <f.fainelli@gmail.com>
To:     Maxime Ripard <maxime@cerno.tech>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Date:   Wed, 24 Jun 2020 17:42:19 -0700
Message-ID: <159304573968.62212.13190239550223603077@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Maxime Ripard (2020-06-15 01:40:41)
> From: Florian Fainelli <f.fainelli@gmail.com>
>=20
> Convert the Raspberry Pi BCM2835 firmware binding document to YAML.
> Verified with dt_binding_check and dtbs_check.
>=20
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> Tested-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---

Applied to clk-next
