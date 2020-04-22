Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E24C55186
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4617D20784
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587549618;
	bh=fTbTECVBN+Kz09FDYc7YbldgvRd8WnH3neoB4D6wj34=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=vu50IWCtsxv++NZsrTN/ZwDyQnk/vp8GdYqj/s6aKMZkvC+qNhIVtJzuYrdyroIzJ
	 BUS9Q+ajGEEV75fbEFISVppQL6pdGEU0hT4lklPN8yCTd3tWs08e3fOfWWe4WtuAxh
	 M0xYiNkMn923+iyS7jq2KtX2pQr97RjE0Z6Azfe0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgDVKAR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:00:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:47054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726590AbgDVKAD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:00:03 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1CF0320776;
        Wed, 22 Apr 2020 10:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587549602;
        bh=fTbTECVBN+Kz09FDYc7YbldgvRd8WnH3neoB4D6wj34=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=CyXnhtVQc/tjmkDRIYakYjCI5CAGw3rGlNL21QcC8sdhycajuvegJUEGK6GEUDnEz
         te+rOS0eVTHZKW4ZCrTH3neUWbLJqt2rMAOOmJGQvCrt1ID0sBcQxwAZPtGxFb6+1t
         LEZr/4pkNDHM8aSZQ3K75+O1a+/FaU4LRlcqPAy8=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200414193616.1368209-2-aford173@gmail.com>
References: <20200414193616.1368209-1-aford173@gmail.com> <20200414193616.1368209-2-aford173@gmail.com>
Subject: Re: [PATCH 2/3] clk: vc5: Enable addition output configurations of the Versaclock
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     aford@beaconembedded.com, charles.stevens@logicpd.com,
        Adam Ford <aford173@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Adam Ford <aford173@gmail.com>, linux-clk@vger.kernel.org
Date:   Wed, 22 Apr 2020 03:00:01 -0700
Message-ID: <158754960123.132238.9912757167863379129@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Adam Ford (2020-04-14 12:36:15)
> @@ -865,6 +904,77 @@ static int vc5_probe(struct i2c_client *client,
>                                 init.name);
>                         goto err_clk;
>                 }
> +
> +               /* Fetch Clock Output configuration from DT (if specified=
) */
> +               child_name =3D kasprintf(GFP_KERNEL, "OUT%d", n);
> +               np_output =3D of_get_child_by_name(client->dev.of_node, c=
hild_name);
> +               kfree(child_name);
> +               if (!np_output)
> +                       continue;
> +               if (!(ret || of_property_read_u32(np_output,
> +                       "idt,mode", &value))) {
> +                       vc5->clk_out[n].clk_output_cfg0_mask |=3D VC5_CLK=
_OUTPUT_CFG0_CFG_MASK;
> +                       switch (value) {
> +                       case VC5_CLK_OUTPUT_CFG0_CFG_LVPECL:
> +                       case VC5_CLK_OUTPUT_CFG0_CFG_CMOS:
> +                       case VC5_CLK_OUTPUT_CFG0_CFG_HCSL33:
> +                       case VC5_CLK_OUTPUT_CFG0_CFG_LVDS:
> +                       case VC5_CLK_OUTPUT_CFG0_CFG_CMOS2:
> +                       case VC5_CLK_OUTPUT_CFG0_CFG_CMOSD:
> +                       case VC5_CLK_OUTPUT_CFG0_CFG_HCSL25:
> +                               vc5->clk_out[n].clk_output_cfg0 |=3D valu=
e << VC5_CLK_OUTPUT_CFG0_CFG_SHIFT;
> +                               break;
> +                       default:
> +                               ret =3D -EINVAL;
> +                               break;
> +                       }
> +               }

Can these three things be functions that are called and passed a
vc5->clk_out[n] pointer? Then the code would be something like=20

 ret =3D prop1_parse_and_update(vc5->clk_out[n]);
 if (ret)
 	goto err_clk;
 ret =3D prop2_parse_and_update(...)
 if (ret)
 	goto err_clk;


> +               if (!(ret || of_property_read_u32(np_output,
> +                       "idt,voltage-microvolts", &value))) {
> +                       vc5->clk_out[n].clk_output_cfg0_mask |=3D VC5_CLK=
_OUTPUT_CFG0_PWR_MASK;
> diff --git a/include/dt-bindings/clk/versaclock.h b/include/dt-bindings/c=
lk/versaclock.h
> new file mode 100644
> index 000000000000..30add3488713
> --- /dev/null
> +++ b/include/dt-bindings/clk/versaclock.h
> @@ -0,0 +1,13 @@
> +/* HEADER */

Any SPDX license for this in place of HEADER?

> +
> +/* This file defines field values used by the versaclock 6 family
> + * for defining output type
> + */
> +
> +#define VC5_LVPECL     0
> +#define VC5_CMOS       1
> +#define VC5_HCSL33     2
> +#define VC5_LVDS       3
> +#define VC5_CMOS2      4
> +#define VC5_CMOSD      5
> +#define VC5_HCSL25     6
