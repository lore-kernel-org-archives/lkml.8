Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD20C4CECE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 01:08:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BBC22071C
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 01:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584061711;
	bh=GZXF1jbEMHNkWN+8nJgNpRV11roNj+xqkyTJlQsyCsg=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=Qh6Y8xDQlUGaBcHWcj2cOOmG3QxMnLvJl2CN4x2qWzIpICbb0eDfsTI5WX1Z9II5F
	 7i1u0hQKr32SWmGv3mYNOMIkr3tW21rkrkvJSksxJtUZZSxVP8yntKMFY+N3mDO58Z
	 yWumgeSwnUZmwftLNbok83N/lNIZn9SdKijQaKLs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbgCMBIa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 21:08:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:33972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726647AbgCMBIa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 21:08:30 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A039206EB;
        Fri, 13 Mar 2020 01:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584061709;
        bh=GZXF1jbEMHNkWN+8nJgNpRV11roNj+xqkyTJlQsyCsg=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=eR6+dcJpWpjNfwnVeJzuK3xox8/tEOS1wOokhuk4NTBoQfP5Bvu0x88mdzjgBKBCX
         uef9agDZTbZ2IJp0OZaMQxQZMQa2n6L4hHT/RVBdirmx6AVnCuxIDwlV5boXG+vsqr
         21765VUGy9wpS57nBFY4jA2jYYpzI6dHpSIJVuIM=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <5a40506025566ddab97109fc0a66eb9e0c80d9ab.1582533919.git-series.maxime@cerno.tech>
References: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech> <5a40506025566ddab97109fc0a66eb9e0c80d9ab.1582533919.git-series.maxime@cerno.tech>
Subject: Re: [PATCH 19/89] clk: bcm: rpi: Split pllb clock hooks
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
Date:   Thu, 12 Mar 2020 18:08:28 -0700
Message-ID: <158406170873.149997.17369022998670776550@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Maxime Ripard (2020-02-24 01:06:21)
> The driver only supports the pllb for now and all the clock framework hoo=
ks
> are a mix of the generic firmware interface and the specifics of the pllb.
> Since we will support more clocks in the future let's split the generic a=
nd
> specific hooks
>=20
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: linux-clk@vger.kernel.org
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
