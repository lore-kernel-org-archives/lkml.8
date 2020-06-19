Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EA74C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 03:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 150AE2080D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 03:28:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jMf6x7Ak"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729982AbgFSD24 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 23:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726927AbgFSD2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 23:28:55 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD27C06174E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 20:28:54 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id r2so9740255ioo.4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 20:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XVvgSNSDtsxcUWZQpJFepMFACRYXaU7328HldZ9nvGo=;
        b=jMf6x7AkGagBU8CyXfuVwgwRFffghhZ7JHnellb+sRxNosxaJio3mRR0LAOyRX2+qZ
         vjjgNxrithNnI4exr4UwISSe6gzcdUAuh0oJvz3C784tgKJFatJubDqVqVUn4Msf4ntL
         TbVgaghvDjefMpY+m6d2RUsmA0Ppxfj87x+upM9L3TVLXNxjdh2mODNiI1ltaDmnDfuL
         EBwsgPlfmx/tl67f94G9hpfdDtH/UlQRzlHGhosKhM6+HJmYlrtX5n3Hw5yrSTbzg7pv
         yQRGUrfo9jxW3OovY/rL0fmWt4W+jwz5DLeSFlbMiV+ON8Pki+7ccYIsA3OxQFQUBY40
         a8+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XVvgSNSDtsxcUWZQpJFepMFACRYXaU7328HldZ9nvGo=;
        b=rKYAkLXMWsMy4DliZh357d57D4+TDo9B1yTAdj65lwp1JBoQNgxsv0Yjmf7PPgfyve
         RwXM67BuZzHDWhFBw4+e5bQ+EIE12Cf6MkYPynekZj++s7l8xsOcYEGipDQSD6ZYq3tB
         w8OBHoI2EzX+ZYFdk5uDgkvNguqgnVa1t9sWkCluNPT5/R95W0GLfRNT451OViBNEZB8
         +Tg2xe9FHjkqwcGgsWCis1wEGI/GkpsVeE8OpRyC3XSWDMJ4y6hUgJpcCOZXn9u4V446
         vlXsXTqlbZJKD5iLGX7wcVtXOEGM2rhB6umgwr+mbaO/9Uf06f7MWPOwFYzSWo8lNJtR
         RONA==
X-Gm-Message-State: AOAM533DtO2bCALLIBsFOc2HC7pauyJepAEtb0awotFBPVUv2td4aCe9
        IFb0cussOd9PVrPdtYtFMPKpEGkMaCRISlckUZo=
X-Google-Smtp-Source: ABdhPJzjagCdebZlS8m6JXrZGP9z70lgYtHO1GQuEMRsPz/ePxtJEpwTF8B/BbAvUPdcRywX1bmw0JxcKzegyAQo3ig=
X-Received: by 2002:a05:6602:2c0a:: with SMTP id w10mr2152043iov.46.1592537334338;
 Thu, 18 Jun 2020 20:28:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200601230607.31740-1-andrew.smirnov@gmail.com>
In-Reply-To: <20200601230607.31740-1-andrew.smirnov@gmail.com>
From:   Chris Healy <cphealy@gmail.com>
Date:   Thu, 18 Jun 2020 20:28:19 -0700
Message-ID: <CAFXsbZqJMVscHo2J8qDErQ3uxTz0v4LXJWkE_18+skZoE_c+Dw@mail.gmail.com>
Subject: Re: [PATCH] clk: imx: vf610: add CAAM clock
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     linux ARM <linux-arm-kernel@lists.infradead.org>,
        =?UTF-8?Q?Horia_Geant=C4=83?= <horia.geanta@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, linux-imx@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On a Vybrid VF610 based platform I tested this with 5.8-rc1.  With the
necessary DTS patch, the CAAM worked correctly for me.

Tested-by: Chris Healy <cphealy@gmail.com>

On Mon, Jun 1, 2020 at 4:06 PM Andrey Smirnov <andrew.smirnov@gmail.com> wr=
ote:
>
> According to Vybrid Security RM, CCM_CCGR11[CG176] can be used to gate
> CAAM ipg clock.
>
> Signed-off-by: Horia Geant=C4=83 <horia.geanta@nxp.com>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-imx@nxp.com
> ---
>  drivers/clk/imx/clk-vf610.c             | 1 +
>  include/dt-bindings/clock/vf610-clock.h | 3 ++-
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/clk/imx/clk-vf610.c b/drivers/clk/imx/clk-vf610.c
> index cd04e7dc1878..5129ef8e1d6e 100644
> --- a/drivers/clk/imx/clk-vf610.c
> +++ b/drivers/clk/imx/clk-vf610.c
> @@ -438,6 +438,7 @@ static void __init vf610_clocks_init(struct device_no=
de *ccm_node)
>         clk[VF610_CLK_SNVS] =3D imx_clk_gate2("snvs-rtc", "ipg_bus", CCM_=
CCGR6, CCM_CCGRx_CGn(7));
>         clk[VF610_CLK_DAP] =3D imx_clk_gate("dap", "platform_bus", CCM_CC=
SR, 24);
>         clk[VF610_CLK_OCOTP] =3D imx_clk_gate("ocotp", "ipg_bus", CCM_CCG=
R6, CCM_CCGRx_CGn(5));
> +       clk[VF610_CLK_CAAM] =3D imx_clk_gate2("caam", "ipg_bus", CCM_CCGR=
11, CCM_CCGRx_CGn(0));
>
>         imx_check_clocks(clk, ARRAY_SIZE(clk));
>
> diff --git a/include/dt-bindings/clock/vf610-clock.h b/include/dt-binding=
s/clock/vf610-clock.h
> index 95394f35a74a..0f2d60e884dc 100644
> --- a/include/dt-bindings/clock/vf610-clock.h
> +++ b/include/dt-bindings/clock/vf610-clock.h
> @@ -195,6 +195,7 @@
>  #define VF610_CLK_WKPU                 186
>  #define VF610_CLK_TCON0                        187
>  #define VF610_CLK_TCON1                        188
> -#define VF610_CLK_END                  189
> +#define VF610_CLK_CAAM                 189
> +#define VF610_CLK_END                  190
>
>  #endif /* __DT_BINDINGS_CLOCK_VF610_H */
> --
> 2.21.3
