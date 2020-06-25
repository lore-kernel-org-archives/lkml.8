Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F09C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 00:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D729207DD
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 00:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593045979;
	bh=gnlllVEVjTFt6Hd4vAPi+nYTtxlVF6HKlz/NCG9gd7I=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=giXOngiKgPxhsVjEXAh8+JfFF20OTTRVB1H36zfPlLOw1cQqWuUVDgFtkDZ+w9fOd
	 GdGeQiAOCArYt01D60mP40qbkeFNWzMr/tBReLlj8vlhOPnt9qrWUTrzz6boeJhnmn
	 6CZp451rcttYdrBf6wJH+mI/ypj1MSNQK0aV1PXQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389567AbgFYAqR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 20:46:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:60238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729175AbgFYAqQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 20:46:16 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 918132078D;
        Thu, 25 Jun 2020 00:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593045976;
        bh=gnlllVEVjTFt6Hd4vAPi+nYTtxlVF6HKlz/NCG9gd7I=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=jcNTffsD6mpjdFU0gw0zkEzuf47ANktRekzjUZkk4WpE1SZMzjrVGhZ28ZV4Hd0Uh
         2HlsVUMAQIcY8LwUx+LNuf75p31w4AIQ/btbixJO9nuE0N9RoFmriCiFbbnpYj7rPR
         I3Nxje/eUxu2kElCNWkXcWf6huQiWv5Ec9LaPG0U=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <9864daba2f584ed49aee5ed1d2f4d48507c58197.1592210452.git-series.maxime@cerno.tech>
References: <cover.98f979c2af2337c57217016d21d7c68e1ac2ce8a.1592210452.git-series.maxime@cerno.tech> <9864daba2f584ed49aee5ed1d2f4d48507c58197.1592210452.git-series.maxime@cerno.tech>
Subject: Re: [PATCH v5 26/27] clk: bcm2835: Don't cache the PLLB rate
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
Date:   Wed, 24 Jun 2020 17:46:15 -0700
Message-ID: <159304597593.62212.10576370083427696438@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Maxime Ripard (2020-06-15 01:41:06)
> The PLLB rate will be changed through the firmware clocks drivers and will
> change behind this drivers' back, so we don't want to cache the rate.
>=20
> Acked-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Tested-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---

Applied to clk-next
