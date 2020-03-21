Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE1AFC4332D
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 00:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B905620757
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 00:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584749786;
	bh=m+Zvx4eO/nsbf1lbau21HtkjwYo/Bu4reeRNy/T0ZyU=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=L/m2zM+Mkai1NBF6/LHMIymIOkeU5ceopcXY3RNl/C+v+oJ2UwJkkCRousm2idb+k
	 f+h7hd1IPM16+80reJZYqHeas4ArekYh29z1l3doxShjTsOD7fdOcVfWEntbBmkdRB
	 /eSlmU2c1KEyc+KYD7kfP8JLMfhpBK10K+88rNUE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727649AbgCUAQZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 20:16:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:52052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726738AbgCUAQZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 20:16:25 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A45A20658;
        Sat, 21 Mar 2020 00:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584749784;
        bh=m+Zvx4eO/nsbf1lbau21HtkjwYo/Bu4reeRNy/T0ZyU=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=WMR3qtpMGys6JzoCw5xNVh8CUfCNzMI2mZ5uJ+/t8V6mMhRqetzKgPyK8BCSQRqVz
         sagVUQY4OuaU+2TrAi1WL8C31n4ZEbZlfrzRoYGAudpdVR9jeyycVBPKqlU7NCuT64
         9PHLwNYQ4gRAEU0K371uIgFEdnQFMf/98DLwUdbU=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <3dc8502e78c986e284a1dc1c52b15f4b765e2aef.1584446053.git.mirq-linux@rere.qmqm.pl>
References: <cover.1584446053.git.mirq-linux@rere.qmqm.pl> <3dc8502e78c986e284a1dc1c52b15f4b765e2aef.1584446053.git.mirq-linux@rere.qmqm.pl>
Subject: Re: [PATCH v2 1/3] clk: at91: optimize pmc data allocation
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        <mirq-linux@rere.qmqm.pl>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Date:   Fri, 20 Mar 2020 17:16:23 -0700
Message-ID: <158474978337.125146.7055726274356736414@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quote
> Alloc whole data structure in one block. This makes the code shorter,
> more efficient and easier to extend in following patch.
>=20

Generally looks good to me.

> diff --git a/drivers/clk/at91/pmc.c b/drivers/clk/at91/pmc.c
> index b71515acdec1..fe788512fcc0 100644
> --- a/drivers/clk/at91/pmc.c
> +++ b/drivers/clk/at91/pmc.c
> @@ -76,48 +76,30 @@ struct clk_hw *of_clk_hw_pmc_get(struct of_phandle_ar=
gs *clkspec, void *data)
>         return ERR_PTR(-EINVAL);
>  }
> =20
> -void pmc_data_free(struct pmc_data *pmc_data)
> -{
> -       kfree(pmc_data->chws);
> -       kfree(pmc_data->shws);
> -       kfree(pmc_data->phws);
> -       kfree(pmc_data->ghws);
> -}
> -
>  struct pmc_data *pmc_data_allocate(unsigned int ncore, unsigned int nsys=
tem,
>                                    unsigned int nperiph, unsigned int ngc=
k)
>  {
> -       struct pmc_data *pmc_data =3D kzalloc(sizeof(*pmc_data), GFP_KERN=
EL);
> +       unsigned int num_clks =3D ncore + nsystem + nperiph + ngck;
> +       struct pmc_data *pmc_data;
> =20
> +       pmc_data =3D kzalloc(sizeof(*pmc_data) + num_clks * sizeof(struct=
 clk_hw *),

I think we have struct_size() for this?

> +                          GFP_KERNEL);
>         if (!pmc_data)
>                 return NULL;
> =20
>         pmc_data->ncore =3D ncore;
> -       pmc_data->chws =3D kcalloc(ncore, sizeof(struct clk_hw *), GFP_KE=
RNEL);
> -       if (!pmc_data->chws)
> -               goto err;
> +       pmc_data->chws =3D pmc_data->hwtable;
> =20
>         pmc_data->nsystem =3D nsystem;
> -       pmc_data->shws =3D kcalloc(nsystem, sizeof(struct clk_hw *), GFP_=
KERNEL);
> -       if (!pmc_data->shws)
> -               goto err;
> +       pmc_data->shws =3D pmc_data->chws + ncore;
> =20
>         pmc_data->nperiph =3D nperiph;
> -       pmc_data->phws =3D kcalloc(nperiph, sizeof(struct clk_hw *), GFP_=
KERNEL);
> -       if (!pmc_data->phws)
> -               goto err;
> +       pmc_data->phws =3D pmc_data->shws + nsystem;
> =20
>         pmc_data->ngck =3D ngck;
> -       pmc_data->ghws =3D kcalloc(ngck, sizeof(struct clk_hw *), GFP_KER=
NEL);
> -       if (!pmc_data->ghws)
> -               goto err;
> +       pmc_data->ghws =3D pmc_data->phws + nperiph;
> =20
>         return pmc_data;
> -
> -err:
> -       pmc_data_free(pmc_data);
> -
> -       return NULL;
>  }
> =20
>  #ifdef CONFIG_PM
> diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
> index 9b8db9cdcda5..49cc3d67b98e 100644
> --- a/drivers/clk/at91/pmc.h
> +++ b/drivers/clk/at91/pmc.h
> @@ -24,6 +24,8 @@ struct pmc_data {
>         struct clk_hw **phws;
>         unsigned int ngck;
>         struct clk_hw **ghws;
> +
> +       struct clk_hw *hwtable[0];

I've seen people making this C99 compliant for clang. Please make it

	struct clk_hw *hwtable[];

instead.

>  };
>
