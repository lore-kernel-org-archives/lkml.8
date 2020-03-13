Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB7A8C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 01:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D1542071C
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 01:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584061320;
	bh=4Mb1/ZjU5Y5Lyt/H0AGgn+Vo8yCzq8TNH/LS6T+ozbw=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=jALDeZjv0JD0n0wcvrDDeLOqy2ADeNTTqd7mhVa9LIjIW/ew/CJHNgnoPpbRSyKrz
	 oEiw2Z8jsRhCoWiBgAQ67zVFJzi/YqsRhlpE8Yzk5etMIoUy1L9ENAOGR9PSMTNQzE
	 ULBKrTT4FpxVhHcjVCYfQQ+ENBkwP7Df7Y1Hom3E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbgCMBB7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 21:01:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:60956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727176AbgCMBB7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 21:01:59 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92B54206EB;
        Fri, 13 Mar 2020 01:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584061318;
        bh=4Mb1/ZjU5Y5Lyt/H0AGgn+Vo8yCzq8TNH/LS6T+ozbw=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Fq9UtREVlN2Xoe570gYbnJzmN6eqzaIXzngUH2AD1doDUatpiGh+Cp50SJfwDM5Wi
         kmHq4sT7QkTBoyga6B+9wztjnGtkDlzt8BSmQ4ovOm/Zli9u1mZ2afSuPOS9gZKYUR
         cQfCHQvr5qVbEcDDSbp6WeUy3ic+MlKih78Jank8=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <f38e173f73f9c9c06291d96d095f5a42002720c9.1582533919.git-series.maxime@cerno.tech>
References: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech> <f38e173f73f9c9c06291d96d095f5a42002720c9.1582533919.git-series.maxime@cerno.tech>
Subject: Re: [PATCH 21/89] clk: bcm: rpi: Add DT provider for the clocks
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
Date:   Thu, 12 Mar 2020 18:01:57 -0700
Message-ID: <158406131784.149997.17413643401851348290@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Maxime Ripard (2020-02-24 01:06:23)
> For the upcoming registration of the clocks provided by the firmware, make
> sure it's exposed to the device tree providers.
>=20
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: linux-clk@vger.kernel.org
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
