Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3806C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 06:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C911D2078C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 06:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590562187;
	bh=Mk0WhkBIU2YaD9/TvTDR7cnluLj0/U9QGU8sM8xfkQY=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=lGBcx4oY9coINk/3MpOjqx95uplacpxqSwhJOefu27ckYAxgvnRNazwmU8ieytAS0
	 CZAOEp4tlvbg0abPokE7reqJuIBJIsuBj1JsivY4hhK1EdUd87UTivxtmIq5tbb4Q8
	 a/WH1028Rm7pC8oH8xcl9lHlg0IGBFJeoHyo/TbY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729090AbgE0Gtr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 02:49:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:33136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728611AbgE0Gtq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 02:49:46 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43B4820787;
        Wed, 27 May 2020 06:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590562186;
        bh=Mk0WhkBIU2YaD9/TvTDR7cnluLj0/U9QGU8sM8xfkQY=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=t/jLS7Hn7JIrLhyly00O4MTUvM8vxasos/btmdCHde4Kfjcod0t6KxYiej7F+A9H5
         HkTWW0NNbrKCBVwMGeELjC+OKMwQCjrF2wzoGayM+oVZXsqwZSPyXkhwf1qIYJzpRr
         Y2fBI1is3w0dfNxNBJYIAm3mhy06JopaziSFi2xc=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <db082ca433f69533e4cdf41c80a0699a61aa285e.1587742492.git-series.maxime@cerno.tech>
References: <cover.d1e741d37e43e1ba2d2ecd93fc81d42a6df99d14.1587742492.git-series.maxime@cerno.tech> <db082ca433f69533e4cdf41c80a0699a61aa285e.1587742492.git-series.maxime@cerno.tech>
Subject: Re: [PATCH v2 15/91] clk: bcm: rpi: Pass the clocks data to the firmware function
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
Date:   Tue, 26 May 2020 23:49:45 -0700
Message-ID: <159056218564.88029.2045421244450515235@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Maxime Ripard (2020-04-24 08:33:56)
> The raspberry_clock_property only takes the clock ID as an argument, but
> now that we have a clock data structure it makes more sense to just pass
> that structure instead.
>=20
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: linux-clk@vger.kernel.org
> Acked-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
