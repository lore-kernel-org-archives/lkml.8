Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D32C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 03:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFFE220748
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 03:39:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PqS7lTzh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbgGADjh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 23:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgGADjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 23:39:36 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24AD0C061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 20:39:36 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id h19so25198796ljg.13
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 20:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cRZEv9laBJjItTkcPmDv0nxHsH8mvQg1w2Jj+z5T4OI=;
        b=PqS7lTzhNkz6VcE0/0YutfI9xLl98MuBoAqD8FdDN3cBNzmYkMP9OEhrYV+c1K3QEu
         qt8Z6Q3VJOwnSeDEwkx8a84C8RW/La/XCstbp2ReLNUoz5jaZmKYMBzAiqYOn6+vVZcJ
         3Jnx68MxSlQg+mWMa1+4GKx4kTQIS356KXeWKvCA40JuqEUpdhzH2EgojIohUyIkQrUC
         wUxRKc1LOFqMW9e5/F3gaubiTjQm0g494FbMIbtUGmVggosvPR1+UnDma8buTLMqeMlm
         MN2t8bag/3xeFSSa8/M90Q8vLQ3pwrdD0Vaxe/jzoA9m1E4Gve7Z2d6BPNGZl6CTJWRb
         soiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cRZEv9laBJjItTkcPmDv0nxHsH8mvQg1w2Jj+z5T4OI=;
        b=WjQ60uWyry3KpXIww+F//SYpUoAVTkfZRFbuAwVzIV3O9kDbdnhpXmFMi1MN13t3/o
         vp8mIPLy1Um61h2QdFyom/ISXMEuWuQdeZCgeg23LHEEPrM9AhHCbGvOO/jJGrK6MkhI
         w05Mfzxoc89tW22Nf6DwK7up7dsuAlevLVE2Zstog6aTAY2TRQYaw1qfWxzK+CtO0MvL
         HmQvA+5Q2fNKX2tppe5AcOO/Imy5HsXZNHY0yQqe9lgr0Qw+CLGCA3kHCSJXqCypVorJ
         vkwH4AIUwLfvfjIAutLCqu40k3y3eunkvgsNGIQ7pzOx8wENo2AYXBRReYuh2U/jFqgh
         iA4A==
X-Gm-Message-State: AOAM533lb2dkjdBuf5Omc2gc/sbFhEHOZ1W/dFh9qNF7+Otg4iUtQiPV
        mQIdjIbMQAOep2Ep3Oo0IxYdoRNR+7gjjgwTorC5P53A
X-Google-Smtp-Source: ABdhPJxI0om2qmtzqXP7h9JwVhT5YTX3W2xRGcWgXtDpVHjd8p11rhyy/ZJ4gijS9GaIvF3jyKugZM0mxA/5Na2CB6U=
X-Received: by 2002:a2e:9e87:: with SMTP id f7mr12728799ljk.44.1593574774510;
 Tue, 30 Jun 2020 20:39:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200625140105.14999-1-TheSven73@gmail.com> <20200625140105.14999-2-TheSven73@gmail.com>
 <CAOMZO5AWiHWSLAcd=dj9dDFj8jLPAVAuoiOAJ8qKGPwRq1Q41g@mail.gmail.com>
 <CAGngYiXJy4ASTNfT+R+qzJ3wA=Wy2h6XZm+8oo09sD+Jmse02w@mail.gmail.com>
 <CAOMZO5Cr3k+oy_Sf0kL9gge7bwqkvJR8BQhY-FvxVXN00A2ARw@mail.gmail.com>
 <CAGngYiW=Pc_QjsjCv4Pc_R9OZk7nOAKm=k=b4TMbYRZ-08zKrQ@mail.gmail.com>
 <AM6PR0402MB36077C422DABCB4F2EA650A0FF6F0@AM6PR0402MB3607.eurprd04.prod.outlook.com>
 <CAGngYiV9HqxSLV=PCPg10vqVC-SaayF5wakcWs2gBbXxgcUEPQ@mail.gmail.com> <AM6PR0402MB3607986330B844B161E271FAFF6C0@AM6PR0402MB3607.eurprd04.prod.outlook.com>
In-Reply-To: <AM6PR0402MB3607986330B844B161E271FAFF6C0@AM6PR0402MB3607.eurprd04.prod.outlook.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 1 Jul 2020 00:39:23 -0300
Message-ID: <CAOMZO5B-XVaZ-t2T7UBdCqqde3bJREiQhR71ET8p=9EHJ-DQbA@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH v4 2/2] ARM: imx6plus: enable internal routing
 of clk_enet_ref where possible
To:     Andy Duan <fugang.duan@nxp.com>
Cc:     Sven Van Asbroeck <thesven73@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Wed, Jul 1, 2020 at 12:18 AM Andy Duan <fugang.duan@nxp.com> wrote:

> --- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
> @@ -202,6 +202,8 @@
>  &fec {
>         pinctrl-names = "default";
>         pinctrl-0 = <&pinctrl_enet>;
> +       assigned-clocks = <&clks IMX6QDL_CLK_ENET_REF>;
> +       assigned-clock-rates = <125000000>;

I don't think this is an acceptable solution as it breaks old dtb's.
