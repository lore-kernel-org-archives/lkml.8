Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFDE3C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 00:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FE2A207DD
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 00:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593045766;
	bh=dR9E4HhUJ5qnG0JO1ZiYFIT9TNxSCP6TdmL1mbcb1qk=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=z66F41cugWOVPRDINOWTnnsV3g0GenMpKNgDhuc4jQlRjPoRnV+5G8gbD7XsG3eC3
	 qjZhUGe8XU3TlPRVv7flknfCme8QWqsoukpBl3uRlCUdIB1VKPTt/+eQLm2WGzwCIi
	 nPDQi6LsXOh9M58ssUaZaCNVqeDUoXfguYCfse/I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389121AbgFYAmp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 20:42:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:56934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389054AbgFYAmk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 20:42:40 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9649F2078D;
        Thu, 25 Jun 2020 00:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593045759;
        bh=dR9E4HhUJ5qnG0JO1ZiYFIT9TNxSCP6TdmL1mbcb1qk=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=DhR47hUtA67b17haoDR4pzfB8yZ0xJNni+0r2H3JoiMsLV8IWDGZN+q+movkC9xKB
         Cl95DyvpX9xVmNjU0sqkP7tElV5qayA27IpUjb7cIjogAWCa6cLmvOhWhA0Crbdejv
         KSeA7dDl5+1R1e5HpGqx4a3CA6p86kAL6rstg2Fg=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <0342572daa561dc1bb4c9fd10641b2016493e32b.1592210452.git-series.maxime@cerno.tech>
References: <cover.98f979c2af2337c57217016d21d7c68e1ac2ce8a.1592210452.git-series.maxime@cerno.tech> <0342572daa561dc1bb4c9fd10641b2016493e32b.1592210452.git-series.maxime@cerno.tech>
Subject: Re: [PATCH v5 05/27] clk: bcm: rpi: Statically init clk_init_data
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
Date:   Wed, 24 Jun 2020 17:42:38 -0700
Message-ID: <159304575897.62212.17561160982634673134@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Maxime Ripard (2020-06-15 01:40:45)
> Instead of declaring the clk_init_data and then calling memset on it, just
> initialise properly.
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
