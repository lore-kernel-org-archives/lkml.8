Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80445C2BB1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 23:21:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4975C20716
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 23:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584055267;
	bh=sjbzlgfG0M7ByXrwtWMDuZpQMY36kbz6RtWjf+35/zI=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=L5wmI40D5qbwfsSdALJI9f38Tt7dGXJfwJHQvFtGfqhfjKRQYtlLZIPuJJpwY8hML
	 foGeng3NwRBUG4EL/m8977KfG3IGioenGBaLJeVka4sGS0KCHNXfCIDq65TEXYXQU2
	 k+9bM5w8IBnRTfqd1g0jBJojW2ITo5G8pX2aMrFo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbgCLXVG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 19:21:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:34180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726710AbgCLXVF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 19:21:05 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DB3020637;
        Thu, 12 Mar 2020 23:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584055265;
        bh=sjbzlgfG0M7ByXrwtWMDuZpQMY36kbz6RtWjf+35/zI=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=LdQA6bv+ggc65ar4RKV9KiEkNkg8VfUntIZxoeg89qMN7G9jB8yZQ+iCfxZOs04Yk
         2+Dz8rnMx+V94kttfsjdsiIyqJmYGkgPB7QdXNWYz2gLnlFesOvI095Z4PCzh5Zbmq
         o4nbWepq7FwftmfJLWN/TodqrZB1SvFEuFSAXxQ4=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <703e21467f23f63acdac0e078b58040c39b852bf.1582533919.git-series.maxime@cerno.tech>
References: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech> <703e21467f23f63acdac0e078b58040c39b852bf.1582533919.git-series.maxime@cerno.tech>
Subject: Re: [PATCH 12/89] clk: bcm: rpi: Remove pllb_arm_lookup global pointer
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
Date:   Thu, 12 Mar 2020 16:21:04 -0700
Message-ID: <158405526432.149997.18229341448233214911@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Maxime Ripard (2020-02-24 01:06:14)
> The pllb_arm_lookup pointer in the struct raspberrypi_clk is not used for
> anything but to store the returned pointer to clkdev_hw_create, and is not
> used anywhere else in the driver.
>=20
> Let's remove that global pointer from the structure.
>=20
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: linux-clk@vger.kernel.org
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
