Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D08C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 00:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33105207DD
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 00:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593045898;
	bh=Yfq9epKEOsnoqFKy7y+t/TuM8WxcBGwdRarD8vBYbTc=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=vO5YT/FBMSJO31+zO50Cl0ZPQ/HNFowbUdGzh36RjKHtlR1Z1VKyN65LAG/HESjQX
	 9udUtQsEDCqdWVb+/cXJzpCayd9aRf1/E+u0o/eaU+cuUA3AFUF1xibH4KCDZ6g3KN
	 Bf97wyOWnMpEMqcSHMoqaGbv1K8LVuIM+s1RYlG8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389074AbgFYAo5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 20:44:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:58664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388987AbgFYAo4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 20:44:56 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7243207DD;
        Thu, 25 Jun 2020 00:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593045895;
        bh=Yfq9epKEOsnoqFKy7y+t/TuM8WxcBGwdRarD8vBYbTc=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=E3U3xLsTpkw0eEQB9wOe00wSo7toWVQSPlzeGVpaqzZWRL6FCXEPMnAeu0dPrU94e
         Zo8x/kI6sHa9Sa0B8DSyKQgfEEwKiF/mEWsrApQ7UaQHO5WV2styvcwZl/buWkF7Y6
         KJazsHn4lvpeybrr5ZKrCJuIbdRM06jr4S+njHAk=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ee7f508db226214fab4add7f93a351f4137c86a1.1592210452.git-series.maxime@cerno.tech>
References: <cover.98f979c2af2337c57217016d21d7c68e1ac2ce8a.1592210452.git-series.maxime@cerno.tech> <ee7f508db226214fab4add7f93a351f4137c86a1.1592210452.git-series.maxime@cerno.tech>
Subject: Re: [PATCH v5 13/27] clk: bcm: rpi: Create a data structure for the clocks
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
Date:   Wed, 24 Jun 2020 17:44:55 -0700
Message-ID: <159304589502.62212.2964782757255663354@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Maxime Ripard (2020-06-15 01:40:53)
> So far the driver has really only been providing a single clock, and stor=
ed
> both the data associated to that clock in particular with the data
> associated to the "controller".
>=20
> Since we will change that in the future, let's decouple the clock data fr=
om
> the provider data.
>=20
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: linux-clk@vger.kernel.org
> Acked-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Reviewed-by: Stephen Boyd <sboyd@kernel.org>
> Tested-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---

Applied to clk-next
