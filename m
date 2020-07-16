Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C79BC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 01:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76FF52078C
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 01:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594861399;
	bh=6oZhkB9EWxV3GBYwjhNGD/mi4wQQrv5Y+A8n809Z7PU=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=bQizoRRxtvJwNCrgAcHp10TcQozVaNWtBPO2ig/tj2aZPomxQBxdTNVD6S9/jiYud
	 kjIuAyu/vc0+/06EIMmtKs0ZJzaH1YsZl1eDZxaHpaKNnOAUmvMchH/5LfBHybKO1d
	 yDGrr3tGloYele9HYj5+ytW/urYh+h+R1G4QNlkQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbgGPBDS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 21:03:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:38886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726479AbgGPBDR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 21:03:17 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F2EF2078C;
        Thu, 16 Jul 2020 01:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594861397;
        bh=6oZhkB9EWxV3GBYwjhNGD/mi4wQQrv5Y+A8n809Z7PU=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=ha9iSYJxgqg5SF24utqMLGdWN6TNR9WG7Bwyear+4qjGZk8W8TVdt/HY6OC0u/cjK
         SF8vyHqa5x9AR6BWHFW5aan3mNP4Ijs0k88TKBlAwBXeQWNzzVRBaRqHn7QWiXlDsi
         +wZyDWTyIBGQCDIoitwQgW/rsoPu13TYYKObhNjU=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200713010001.18976-4-akshu.agrawal@amd.com>
References: <20200713010001.18976-1-akshu.agrawal@amd.com> <20200713010001.18976-4-akshu.agrawal@amd.com>
Subject: Re: [PATCH 4/5] clk: x86: Support RV architecture
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To:     akshu.agrawal@amd.com
Date:   Wed, 15 Jul 2020 18:03:16 -0700
Message-ID: <159486139638.1987609.10837351469119432355@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Akshu Agrawal (2020-07-12 17:59:52)
> There is minor difference between previous family of SoC and
> the current one. Which is the there is only 48Mh fixed clk.
> There is no mux and no option to select another freq as there in previous.
>=20
> Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
> ---

I only see four out of five patches and there isn't a cover letter. I
have no idea if I can apply this change or if you're expecting me to ack
it. Please help make my life a little easier!

>  drivers/clk/x86/clk-fch.c | 55 ++++++++++++++++++++++++++++-----------
>  1 file changed, 40 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/clk/x86/clk-fch.c b/drivers/clk/x86/clk-fch.c
> index b252f0cf0628..a8aac71a3b65 100644
> --- a/drivers/clk/x86/clk-fch.c
> +++ b/drivers/clk/x86/clk-fch.c
> @@ -61,9 +78,17 @@ static int fch_clk_probe(struct platform_device *pdev)
>  static int fch_clk_remove(struct platform_device *pdev)
>  {
>         int i;
> +       struct fch_clk_data *fch_data;
> +
> +       fch_data =3D dev_get_platdata(&pdev->dev);
> =20
> -       for (i =3D 0; i < ST_MAX_CLKS; i++)
> -               clk_hw_unregister(hws[i]);
> +       if (!fch_data->is_rv) {
> +               for (i =3D 0; i < ST_MAX_CLKS; i++)
> +                       clk_hw_unregister(hws[i]);
> +       } else {
> +               for (i =3D 0; i < RV_MAX_CLKS; i++)
> +                       clk_hw_unregister(hws[i]);

Can ST_MAX_CLKS or RV_MAX_CLKS be a local variable and then the loop
consolidated.
