Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69B5CC1975A
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 01:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 450DA2071C
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 01:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584061780;
	bh=UYPz1qlE+Zrh/CUYv1EYC2BXtJL9mTAshrMUYOFb/20=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=DNqxihCAovmYlE19rcusQCI8xKAlERQy90594BLO1ACcST/xAzbQQ4uhSMP0xmoqX
	 kXTzSIGfYryPQK06hXfaKa7BMrIZwdohBK0/r9LhSaJJkNz4SPWUyLmr2duZOAToBe
	 2GfPcnyip8J2CcrY7KX3OqBZRZImhrRo5+u6IagY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbgCMBJj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 21:09:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:34446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726838AbgCMBJi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 21:09:38 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 641AA20637;
        Fri, 13 Mar 2020 01:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584061778;
        bh=UYPz1qlE+Zrh/CUYv1EYC2BXtJL9mTAshrMUYOFb/20=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=cchNDvcp5xxo+4kktYIBl1aqjS0gJMnOJdEn09uE/82+DBNyz/X+RrSZl8jq0lPZP
         r9l0+uvv43KujDYCuDIIy/Gj9Kal/SYN6PFHv2j+siPAqv4/S3bn01YeBUYwCBH5aL
         XtueSHO0lPPwNI7yQWREmyFbDeAqdarMEvLibcKE=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <5a02a46e899abfca7257a725678f1131490e6b11.1582533919.git-series.maxime@cerno.tech>
References: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech> <5a02a46e899abfca7257a725678f1131490e6b11.1582533919.git-series.maxime@cerno.tech>
Subject: Re: [PATCH 17/89] clk: bcm: rpi: Pass the clocks data to the firmware function
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
Date:   Thu, 12 Mar 2020 18:09:37 -0700
Message-ID: <158406177763.149997.8595594316904810473@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Maxime Ripard (2020-02-24 01:06:19)
> The raspberry_clock_property only takes the clock ID as an argument, but
> now that we have a clock data structure it makes more sense to just pass
> that structure instead.
>=20
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: linux-clk@vger.kernel.org
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---
>  drivers/clk/bcm/clk-raspberrypi.c | 29 ++++++++++++++---------------
>  1 file changed, 14 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/clk/bcm/clk-raspberrypi.c b/drivers/clk/bcm/clk-rasp=
berrypi.c
> index e796dabbc641..3b2da62a72f5 100644
> --- a/drivers/clk/bcm/clk-raspberrypi.c
> +++ b/drivers/clk/bcm/clk-raspberrypi.c
> @@ -67,11 +67,12 @@ struct raspberrypi_firmware_prop {
>         __le32 disable_turbo;
>  } __packed;
> =20
> -static int raspberrypi_clock_property(struct rpi_firmware *firmware, u32=
 tag,
> -                                     u32 clk, u32 *val)
> +static int raspberrypi_clock_property(struct rpi_firmware *firmware,
> +                                     struct raspberrypi_clk_data *data,

Can data be const?

> +                                     u32 tag, u32 *val)
>  {
>         struct raspberrypi_firmware_prop msg =3D {
> -               .id =3D cpu_to_le32(clk),
> +               .id =3D cpu_to_le32(data->id),
>                 .val =3D cpu_to_le32(*val),
>                 .disable_turbo =3D cpu_to_le32(1),
>         };
