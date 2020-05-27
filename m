Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EDFFC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 09:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DC0B2084C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 09:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590571061;
	bh=uj+VcJwxkpklmPgy3gadF9fMpUuRFAx2IxDyKKwUYjQ=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=RNwE+vhQPRvnCzqK3ASNuje1qHonCsAQTrHeTNxKiblDnGddk3UvWKG4EbW1kalG5
	 RpXB950wtHCNC1D/lP1Kd9YYYt2mnPTjS+HLoLYLoozHIfYuapmepM1b1Mae/xpAHJ
	 F5h5X79m/4KvJUffyWpi0gR9gCpwv1XnmxCG7+/M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbgE0JRk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 05:17:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:40534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725820AbgE0JRk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 05:17:40 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BFA02084C;
        Wed, 27 May 2020 09:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590571059;
        bh=uj+VcJwxkpklmPgy3gadF9fMpUuRFAx2IxDyKKwUYjQ=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=APTlp4+GzRdPiU2yOYmZla3pudgN/B7c+J6/X75D1qd8Y/R8dazrJCYwgjfc29RRX
         n/kNkqW0mclE5s4i6PemxBK+65EqkcikWSRdofb7GJHWTyQVrW7/qgMzYD1tZQdxYL
         EUUla8ViZtwvYMfirc04GcjZN7Oq7idq3JplCI+k=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200519170440.294601-1-jbrunet@baylibre.com>
References: <20200519170440.294601-1-jbrunet@baylibre.com>
Subject: Re: [PATCH] clk: add api to get clk consummer from clk_hw
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Wed, 27 May 2020 02:17:38 -0700
Message-ID: <159057105860.88029.17177553048016076314@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jerome Brunet (2020-05-19 10:04:40)
> clk_register() is deprecated. Using 'clk' member of struct clk_hw is
> discouraged. With this constrainst, it is difficult for driver to

s/constrainst/constraint/

> register clocks using the clk_hw API and then use the clock with
> the consummer API

s/consummer/consumer/

>=20
> This add a simple helper, clk_hw_get_clk(), to get a struct clk from
> a struct clk_hw. Like other clk_get() variant, each call to this helper
> must be balanced with a call to clk_put().
>=20
> Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

I like it!

> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 6fd23ce3cb03..d9946e192cbc 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -3625,6 +3625,23 @@ struct clk *clk_hw_create_clk(struct device *dev, =
struct clk_hw *hw,
>         return clk;
>  }
> =20
> +/**
> + * clk_hw_get_clk: get clk consummer given an clk_hw

s/consummer/consumer/

> + * @hw: clk_hw associated with the clk being consumed
> + *
> + * Returns: new clk consummer
> + * This is the function to be used by providers which need
> + * to get a consummer clk and act on the clock element

s/consummer/consumer/

> + * Calls to this function must be balanced with calls clk_put()

calls to clk_put()

> + */
> +struct clk *clk_hw_get_clk(struct clk_hw *hw)

Can it also take a const char *id argument? That will let us "name" the
clk structure for situations where we want to keep track of who is using
the clk pointer for things. If that doesn't seem useful then I suppose
we can pass a string like "clk_hw_get_clk" for con_id below and hope it
doesn't become useful later.

> +{
> +       struct device *dev =3D hw->core->dev;
> +
> +       return clk_hw_create_clk(dev, hw, dev_name(dev), NULL);
> +}
> +EXPORT_SYMBOL(clk_hw_get_clk);
> +
>  static int clk_cpy_name(const char **dst_p, const char *src, bool must_e=
xist)
>  {
>         const char *dst;
