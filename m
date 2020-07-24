Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E59FCC433E4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 08:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB8A420748
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 08:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595580982;
	bh=q5Y5JzRZKOaWS852eosBJ8/rxA9bzs1JuRaWbHGtJwc=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=xJOc/Dc7yLlPH2cI3uC4M1j52DLea5XJhMSpG3FxDQjKeNOaH58eqmgaou6tdoDKv
	 czwgMz+mYhuA0JZUMRcBnIxSzFHxbK0tMXfUrjQ+Gn4D5UrvE7KOaEyHEEpLrctfNw
	 cDu02JFRM1A5i+xwkVEhLIaX2DRbLPCnUvY57dmU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbgGXI4V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 04:56:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:39690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726945AbgGXI4U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 04:56:20 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 887E4206D8;
        Fri, 24 Jul 2020 08:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595580980;
        bh=q5Y5JzRZKOaWS852eosBJ8/rxA9bzs1JuRaWbHGtJwc=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=vyGspKAkyhpkj8Js5hqkFnzcw/q5HDDlDkninmBbc6o+XVxgBL7sGwQUKXAuIIC9A
         8nNFRSt3IBBsaA5mjzSNMu6NJie3hsGfRfEKxVt0gN73oAwGy+/3heqaMdxsr5Pef8
         r3JAEVZn1ZgZ9CwEZvFrQdZPEwQ63x4JWY7uAYnA=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <26624b65d0e6b958c4765a406b9929d1a9ce1c2c.1594880946.git.rahul.tanwar@linux.intel.com>
References: <7ef7009b4e9f986fd6dfbf487c0e85de68a4ba9b.1594880946.git.rahul.tanwar@linux.intel.com> <26624b65d0e6b958c4765a406b9929d1a9ce1c2c.1594880946.git.rahul.tanwar@linux.intel.com>
Subject: Re: [PATCH v2 3/3] clk: intel: Avoid unnecessary memset by improving code
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, andriy.shevchenko@intel.com,
        qi-ming.wu@intel.com, yixin.zhu@linux.intel.com,
        cheol.yong.kim@intel.com, rahul.tanwar.linux@gmail.com,
        Rahul Tanwar <rahul.tanwar@linux.intel.com>
To:     Rahul Tanwar <rahul.tanwar@linux.intel.com>,
        linux-clk@vger.kernel.org, mturquette@baylibre.com
Date:   Fri, 24 Jul 2020 01:56:19 -0700
Message-ID: <159558097978.3847286.7904651694237654748@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rahul Tanwar (2020-07-15 23:30:32)
> memset can be avoided in a loop if the variables used are declared
> inside the loop. Move such variables declaration inside the loop
> to avoid memset.
>=20
> Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>
> ---
>  drivers/clk/x86/clk-cgu.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/clk/x86/clk-cgu.c b/drivers/clk/x86/clk-cgu.c
> index c379fedfb9f2..9a1be7035fd0 100644
> --- a/drivers/clk/x86/clk-cgu.c
> +++ b/drivers/clk/x86/clk-cgu.c
> @@ -581,19 +581,18 @@ int lgm_clk_register_ddiv(struct lgm_clk_provider *=
ctx,
>                           unsigned int nr_clk)
>  {
>         struct device *dev =3D ctx->dev;
> -       struct clk_init_data init =3D {};
> -       struct lgm_clk_ddiv *ddiv;
>         struct clk_hw *hw;
>         unsigned int idx;
>         int ret;
> =20
>         for (idx =3D 0; idx < nr_clk; idx++, list++) {
> -               ddiv =3D NULL;
> +               struct clk_init_data init =3D {};
> +               struct lgm_clk_ddiv *ddiv =3D NULL;

Assigning to NULL isn't necessary...

> +
>                 ddiv =3D devm_kzalloc(dev, sizeof(*ddiv), GFP_KERNEL);

because it's assigned right here. I'll just fix it.

>                 if (!ddiv)
>                         return -ENOMEM;
> =20
> -               memset(&init, 0, sizeof(init));
>                 init.name =3D list->name;
>                 init.ops =3D &lgm_clk_ddiv_ops;
>                 init.flags =3D list->flags;
