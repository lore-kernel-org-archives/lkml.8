Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB0FBC2BB1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 23:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4EB020716
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 23:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584054838;
	bh=KdJ376DrupqSBe4hSilpFPULBV8+maazUojKqMfa2Hs=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=GLN8eLkjdBE9lM2lqT3V8VhLCn/y+nrz8cNKR5sw1yetGHzbz3ce02WxNxX26NV9G
	 1un/MnIj2RSZI8yuru0Eu0l1WCvcxDZFwK41LHQLnlplwdmKCFdnvFa1FO2zlXFLaY
	 7AvzXJYQbNF7lKE3Tk6s0wP/fzQ6znuD4SDGfzlU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbgCLXN6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 19:13:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:59326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726608AbgCLXN5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 19:13:57 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC2D3206F7;
        Thu, 12 Mar 2020 23:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584054837;
        bh=KdJ376DrupqSBe4hSilpFPULBV8+maazUojKqMfa2Hs=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=OPQZ9/crlt1D8ScrMECNiBOu3Ewxf1OnMJkB6zbrAZUkT4KA0/XSQZ7E+XiLRoIfV
         CtME35UK548pS59QOb5MmyuPCYA7AxrPTGjW6qQ6ZPj2wTNFRaQY4DFbg0bNE2EKMr
         AGmSq5wEHbayZYhgGVSng7s7xs0zFYDuiL3S8eZI=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ab03d578775df76c12e1dcff5d5cc5c1eb4d6fa7.1582533919.git-series.maxime@cerno.tech>
References: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech> <ab03d578775df76c12e1dcff5d5cc5c1eb4d6fa7.1582533919.git-series.maxime@cerno.tech>
Subject: Re: [PATCH 05/89] clk: Return error code when of provider pointer is NULL
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
Date:   Thu, 12 Mar 2020 16:13:56 -0700
Message-ID: <158405483605.149997.16173757299414738003@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Maxime Ripard (2020-02-24 01:06:07)
> The clock framework DT provider helpers don't check the pointers in the
> array registered by the clock provider before returning it.
>=20
> This means that if the array is sparse, we will end up returning a NULL
> pointer while the caller expects an error pointer, resulting in a crash.
>=20
> Let's test the pointer returned and properly return an error if the point=
er
> is NULL.
>=20
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: linux-clk@vger.kernel.org
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---
>  drivers/clk/clk.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index f0f2b599fd7e..8532b5ed1060 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -4318,13 +4318,18 @@ struct clk *of_clk_src_onecell_get(struct of_phan=
dle_args *clkspec, void *data)
>  {
>         struct clk_onecell_data *clk_data =3D data;
>         unsigned int idx =3D clkspec->args[0];
> +       struct clk *clk;
> =20
>         if (idx >=3D clk_data->clk_num) {
>                 pr_err("%s: invalid clock index %u\n", __func__, idx);
>                 return ERR_PTR(-EINVAL);
>         }
> =20
> -       return clk_data->clks[idx];
> +       clk =3D clk_data->clks[idx];
> +       if (!clk)

NULL is a valid clk. That should keep working and not be overriden with
an error pointer. If you want to return an error pointer either fill it
in with an error pointer or write your own version of this.

> +               return ERR_PTR(-ENODEV);
> +
> +       return clk;
>  }
>  EXPORT_SYMBOL_GPL(of_clk_src_onecell_get);
> =20
> @@ -4333,13 +4338,18 @@ of_clk_hw_onecell_get(struct of_phandle_args *clk=
spec, void *data)
>  {
>         struct clk_hw_onecell_data *hw_data =3D data;
>         unsigned int idx =3D clkspec->args[0];
> +       struct clk_hw *hw;
> =20
>         if (idx >=3D hw_data->num) {
>                 pr_err("%s: invalid index %u\n", __func__, idx);
>                 return ERR_PTR(-EINVAL);
>         }
> =20
> -       return hw_data->hws[idx];
> +       hw =3D hw_data->hws[idx];
> +       if (!hw)

And this one is the same. We let NULL be returned so that it can be
returned as a NULL pointer to the caller if desired. That indicates a
clk that does nothing when used.

> +               return ERR_PTR(-ENODEV);
> +
> +       return hw;
>  }
>  EXPORT_SYMBOL_GPL(of_clk_hw_onecell_get);
