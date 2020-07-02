Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99151C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 05:07:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77F78207CD
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 05:07:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="criUw8gg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbgGBFHL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 01:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbgGBFHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 01:07:09 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA5B5C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 22:07:09 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id r12so15889806ilh.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 22:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qald6rTjM4Ozy8eAzbgJVI8/UFGWkxBCP1h2R/b2HEE=;
        b=criUw8gg4UsLv4wS6rOpUP57mfy4z/RM9vYloRYpnSo3OSFmJxYpVDBCZgRD07wZE/
         yRhAEuqYghRTI9LzdhTQUyYEfgqC3u4upk0J63naiTxemEG/hJ2c1zFXXstvC1Eqkxzw
         UaOujL74VTxd2aKyhFIxcvPa0DhYLEagppAwI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qald6rTjM4Ozy8eAzbgJVI8/UFGWkxBCP1h2R/b2HEE=;
        b=HaA4yGXnFz7y5yCJ8WKsi9ffdqxMFY3qtnqbMYuywqm1jKCdjulfyZZ1613Bq/6AEO
         Yo8edyv1gjGVH0O2Jvg69YFwa/Jj8WTC87JzFt6yvcXsTjnEInTlnJgAtkVcjX6/K51B
         GwU+EY7sDcnOEcBRMY9A5E97UT55VRpUK+NEmaN7ztrC363F+MCOznzBy1+zFQLlyTTJ
         Cv/F5bez0IA7p41IqGf2SiMgQS/XsCHJWXTZu14v/f6RhqLfn9qRanoK+1A7CiVowCCG
         5Ij5TPZa81xkNuCHZkr72WpsfI7mPldfcVPJ7btSZth+QDxjpsRZ3zOaE2wmFMQt4Ti/
         YLDQ==
X-Gm-Message-State: AOAM530ik+mSJCnCHC6YQk4iU6lfEg+Gy0+I2jr+xaebddlZ/eYstPdS
        WybZyesoCvoXwvr7WOS2klp3WZJiVIwGk8brEayA4g==
X-Google-Smtp-Source: ABdhPJzfV9z2gnPuOKbbS2NygSGMccIzKO2/dmQEKUKLyjJzRE7KdaCnjYq7UNkKeomd2DQ15Rdu7uZJ+R84y36nxKg=
X-Received: by 2002:a92:4b08:: with SMTP id m8mr10499872ilg.150.1593666429155;
 Wed, 01 Jul 2020 22:07:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200625101757.101775-1-enric.balletbo@collabora.com> <20200625101757.101775-6-enric.balletbo@collabora.com>
In-Reply-To: <20200625101757.101775-6-enric.balletbo@collabora.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Thu, 2 Jul 2020 13:06:43 +0800
Message-ID: <CAJMQK-jm4kuT+cB-mS+hMD5SxWHZAyn8WJ+chgn-BKQAANpgGw@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] arm64: dts: mt8183-evb: Fix unit name warnings
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        erwanaliasr1@gmail.com, Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 25, 2020 at 6:18 PM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> Remove the unit address from the DT nodes that doesn't have a reg
> property. This fixes the following unit name warnings:
>
>     Warning (unit_address_vs_reg): /soc/pinctrl@10005000/mmc0@0: node has a unit name, but no reg or ranges property
>     Warning (unit_address_vs_reg): /soc/pinctrl@10005000/mmc1@0: node has a unit name, but no reg or ranges property
>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Tested-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
>
> Changes in v2: None
>
>  arch/arm64/boot/dts/mediatek/mt8183-evb.dts | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-evb.dts b/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
> index afd6ddbcbdf2c..ae405bd8f06b0 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
> @@ -205,7 +205,7 @@ pins_rst {
>                 };
>         };
>
> -       mmc0_pins_uhs: mmc0@0{
> +       mmc0_pins_uhs: mmc0 {
>                 pins_cmd_dat {
>                         pinmux = <PINMUX_GPIO123__FUNC_MSDC0_DAT0>,
>                                  <PINMUX_GPIO128__FUNC_MSDC0_DAT1>,
> @@ -264,7 +264,7 @@ pins_pmu {
>                 };
>         };
>
> -       mmc1_pins_uhs: mmc1@0{
> +       mmc1_pins_uhs: mmc1 {
>                 pins_cmd_dat {
>                         pinmux = <PINMUX_GPIO31__FUNC_MSDC1_CMD>,
>                                    <PINMUX_GPIO32__FUNC_MSDC1_DAT0>,
> --
> 2.27.0
>
