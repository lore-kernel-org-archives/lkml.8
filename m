Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E34CDC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 00:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE1F620836
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 00:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593045779;
	bh=/hGQyas9wOOqovRHctel1hvHi4SK31n8HK8JgzQ0rbs=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=qmrhbHiDdUPqCDfvAwcgfdCwxZK0m4G0yIPu7YFjfnYxXyFNHDHWE2alL/yB4xSFe
	 TiPAY02feRplQZVuib7OwyapFWfvwC2nX3UTwVSgX3hXS/ru77IRsHHVo49K1Jp73p
	 RRq7zWqB/x8jgPLXloiWbg4w+fSl69Fyz9o3BZS8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389239AbgFYAm5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 20:42:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:57222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388862AbgFYAmx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 20:42:53 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85ABC207DD;
        Thu, 25 Jun 2020 00:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593045773;
        bh=/hGQyas9wOOqovRHctel1hvHi4SK31n8HK8JgzQ0rbs=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=sQMfqVxfUr6xdPnfrn+8YN54FRsN/lsxw1gnRHl7fHyXlVVWDx7u4iSBiddbLby+n
         1ed2IZwrDb/A66A21RVD7agmG/oZ9r0nXR7xg1s3e2wRzxUabF8YomKFk1e5pYw9N7
         eaP9YgCJYKs/NqcrvADe2A1WUbr5syv9HA8C5d6o=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <34254ed1556614658e5dad5cca4cf4fe617df7fc.1592210452.git-series.maxime@cerno.tech>
References: <cover.98f979c2af2337c57217016d21d7c68e1ac2ce8a.1592210452.git-series.maxime@cerno.tech> <34254ed1556614658e5dad5cca4cf4fe617df7fc.1592210452.git-series.maxime@cerno.tech>
Subject: Re: [PATCH v5 08/27] clk: bcm: rpi: Make sure pllb_arm is removed
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
Date:   Wed, 24 Jun 2020 17:42:52 -0700
Message-ID: <159304577293.62212.9130293865858644352@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Maxime Ripard (2020-06-15 01:40:48)
> The pllb_arm clock was created at probe time, but was never removed if
> something went wrong later in probe, or if the driver was ever removed fr=
om
> the system.
>=20
> Now that we are using clk_hw_register(), we can just use its managed vari=
ant
> to take care of that for us.
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
