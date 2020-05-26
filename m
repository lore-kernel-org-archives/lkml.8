Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B61C1C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 23:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95F5B207ED
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 23:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590534149;
	bh=Zq44PfuDktc96J3Rzwf4OkzMWVQnCBBaKPlqmC7C92A=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=HdjFNVhacKdEyhaYGm2JasP4y9RDjUufMjrsB/nyih2Fp5FDyBW2pkA6WcjG101zm
	 +uZc5PD+gKKBFq33ekbqTzW1+Xz32G6M5IzDFa4R09dGEXFJSqb4wpbxKufBnXTwAb
	 FkD9neHaM2yP4WjfmwcHEMT4o0VQmvDyqgkJsLgg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391638AbgEZXC2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 19:02:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:33402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389565AbgEZXC2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 19:02:28 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F02B72075F;
        Tue, 26 May 2020 23:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590534148;
        bh=Zq44PfuDktc96J3Rzwf4OkzMWVQnCBBaKPlqmC7C92A=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=JiAbfwAkWT13Sak9cQ02/1ythNiBMb+Fcfdn9bxdaPBuCJss0iJqjfSdPy0iBfJUs
         RVnmJ5EBuG+6jMCJWCcVSLwX51RwpQWsWPC59jAh0NmQj2qi0g9qVY7lAN7dErmpov
         PK5i0BpZTyH4MDsC4gYoeJaMO22KY6EFKHti8MHg=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1590377516-32117-1-git-send-email-yangtiezhu@loongson.cn>
References: <1590377516-32117-1-git-send-email-yangtiezhu@loongson.cn>
Subject: Re: [PATCH 1/2] clk: hisilicon: Use correct return value about hisi_reset_init()
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Michael Turquette <mturquette@baylibre.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>
Date:   Tue, 26 May 2020 16:02:27 -0700
Message-ID: <159053414719.88029.3577704206897582789@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Tiezhu Yang (2020-05-24 20:31:55)
> The return value about hisi_reset_init() is not correct, fix it.
>=20
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  drivers/clk/hisilicon/clk-hi3519.c      | 4 ++--
>  drivers/clk/hisilicon/crg-hi3516cv300.c | 4 ++--
>  drivers/clk/hisilicon/crg-hi3798cv200.c | 4 ++--
>  drivers/clk/hisilicon/reset.c           | 4 ++--
>  4 files changed, 8 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/clk/hisilicon/clk-hi3519.c b/drivers/clk/hisilicon/c=
lk-hi3519.c
> index ad0c7f3..803fa66 100644
> --- a/drivers/clk/hisilicon/clk-hi3519.c
> +++ b/drivers/clk/hisilicon/clk-hi3519.c
> @@ -149,8 +149,8 @@ static int hi3519_clk_probe(struct platform_device *p=
dev)
>                 return -ENOMEM;
> =20
>         crg->rstc =3D hisi_reset_init(pdev);
> -       if (!crg->rstc)
> -               return -ENOMEM;
> +       if (IS_ERR(crg->rstc))
> +               return PTR_ERR(crg->rstc);
> =20
>         crg->clk_data =3D hi3519_clk_register(pdev);
>         if (IS_ERR(crg->clk_data)) {

The code I see is returning NULL or a valid pointer from
hisi_reset_init(). Can you add a "Fixes" tag to this patch so we can
figure out which patch changed the behavior and where this patch needs
to be backported to?
