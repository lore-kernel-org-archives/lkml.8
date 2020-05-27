Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 729ADC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 06:48:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4867F2078C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 06:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590562114;
	bh=QVSv/eb+VqUx20IrppSTxxSk6FOlJWNSoSE9v/4b+o4=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=qdHNw4Jok08BpcAoWFaLZAjrRr+CYaoCwRYCrQzn78Ek30MkX8UJgkFT+4BpUlVcy
	 qJpNs1RYaqVajwD1gU2ouVAADZiCl07MWoEDqtYdEK/KQK7KJOhesM7vGEUuz6EUgg
	 AN5Y+vBFcpjivptG8Tu8di9QRstFrNgSriUE6NEM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728877AbgE0Gsd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 02:48:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:60792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725914AbgE0Gsd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 02:48:33 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA8EB20787;
        Wed, 27 May 2020 06:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590562113;
        bh=QVSv/eb+VqUx20IrppSTxxSk6FOlJWNSoSE9v/4b+o4=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=sY66UC0UDqpw/g+yCCCvubhw5ZbzmnCsujv60Pq17U8hDZO2YQBHCDnpCkyx3Klz5
         bijWCbFnTPv6nM9qBx8oPaUGDkzEsMUGISWfg9JbrjVW7LoXHgV0WDjq1PW2DDa5N8
         g5pcg6sPGeggCG9EYAspKqc9c8YUh1HZqytBK7/s=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <cf81ef7d0235e7f7fdc70e1628180bebe692e3a5.1587742492.git-series.maxime@cerno.tech>
References: <cover.d1e741d37e43e1ba2d2ecd93fc81d42a6df99d14.1587742492.git-series.maxime@cerno.tech> <cf81ef7d0235e7f7fdc70e1628180bebe692e3a5.1587742492.git-series.maxime@cerno.tech>
Subject: Re: [PATCH v2 08/91] clk: bcm: rpi: Remove global pllb_arm clock pointer
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
Date:   Tue, 26 May 2020 23:48:32 -0700
Message-ID: <159056211232.88029.9677590709324133849@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Maxime Ripard (2020-04-24 08:33:49)
> The pllb_arm clk_hw pointer in the raspberry_clk structure isn't used
> anywhere but in the raspberrypi_register_pllb_arm.
>=20
> Let's remove it, this will make our lives easier in future patches.
>=20
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: linux-clk@vger.kernel.org
> Acked-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
