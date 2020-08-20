Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB4AC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 22:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA396208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 22:01:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hB8rGo68"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728373AbgHTWBn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 18:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728350AbgHTWBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 18:01:42 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5EB7C061385;
        Thu, 20 Aug 2020 15:01:41 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id v4so3803867ljd.0;
        Thu, 20 Aug 2020 15:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FgcODlr4E6A8//aA0EDpJkZYU4kK0bAL6cRITsU0h1Q=;
        b=hB8rGo68iZ4Q840IFDbTgoLOYJCefYtSAozw+yxtnnS1+Rtcz/PO7yqg9BMWStJNsj
         ty0gCe5sGEiYAj8SwxW4kJUDoy25i6BeVCfuu+oQMSCmpg16MbKF/ZgaDQxhXjXvbyFU
         vmZVavaeev2BDBDAyhAoJzv0UqSRUaW6ty5tNcq84vEzJnUMBPKInF/9MV/EVtWTeFu7
         anZD0DA8cl8mRXEprmonP/98+NGLW/TZmL7WLaAKTmh29jTD+rcs5kckPFTwjA/d7nFe
         mTsT/r93VMOU6vegFljRKfjU1SQltt3bgqfaHvSo5KQ9IchwG8OREw+j/rZ+Hzpo+853
         nlfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FgcODlr4E6A8//aA0EDpJkZYU4kK0bAL6cRITsU0h1Q=;
        b=luc4uUnNM/cVm5h7kXSCP8EBRGQwHq7pWnvtQTs40z/Zw8ZP+MPZI04sBX6SkGOPcD
         bdCY5SIsmNsA4JnKuxIXRSCR9PvzHVu8B6Wva9UPKoBA5CCO5qdmnngv5/qxiFmo4sOn
         AenJC9m7ep2xPPx0KrBQi1+4T4Taou/cYQoCWpmg2a/58kDvvPwEy7UwC4IvtZ87oljc
         8tFyRondOjX1hhZlH6BZMmsLEZpI66Pm9NQhF6FoFuS7UK576AaQVx0rJWKQSLu+htSm
         xxd5Kyt63O2+t8VDI7XJERayveJxrmoGkaUe23BrGadRU04jAZopG9qZEShKVDGU2IaE
         wmVg==
X-Gm-Message-State: AOAM530CabuEYTBhxQqyUugNdS9D88j96WgsoW6UXfzBkG+jkevDaXdw
        sozZO4XEEqE2Nev2edsV3FDqF0npdZw08Q/0VJ+AVR4E
X-Google-Smtp-Source: ABdhPJysn/j9f8dyPXMiSs+Jk6L+kEp2L+3crAXd2jTQ6PrUbFIR18fsGNBqdWLKXdN0qOPBiSzeaeRG7wQIJJalAYo=
X-Received: by 2002:a2e:1417:: with SMTP id u23mr42773ljd.44.1597960900155;
 Thu, 20 Aug 2020 15:01:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200731082725.21878-1-martin.kepplinger@puri.sm>
In-Reply-To: <20200731082725.21878-1-martin.kepplinger@puri.sm>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 20 Aug 2020 19:01:28 -0300
Message-ID: <CAOMZO5AZSu-_bKZ+_ym-Dtk7GCiHnR2cd7YZumOoE6Q6D6kB9A@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] arm64: dts: Add a device tree for the Librem 5 phone
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     Rob Herring <robh@kernel.org>, kernel@puri.sm,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Yongcai Huang <Anson.Huang@nxp.com>,
        =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Mark Brown <broonie@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Daniel Baluta <daniel.baluta@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

This looks good.

Only some minor comments:

On Fri, Jul 31, 2020 at 5:28 AM Martin Kepplinger
<martin.kepplinger@puri.sm> wrote:

> +       sound {
> +               compatible = "simple-audio-card";
> +               pinctrl-0 = <&pinctrl_hp>;

Please pass pinctrl-names = "default"; prior to pinctrl-0. Please
check globally in this patch.

> +&ecspi1 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_ecspi1>;
> +       cs-gpios = <&gpio5 9 GPIO_ACTIVE_HIGH>;

This should be active low instead.

After 8cdcd8aeee28 ("spi: imx/fsl-lpspi: Convert to GPIO descriptors")
you should a similar message as in the kernel log:

flash@0 enforce active low on chipselect handle

> +       pinctrl_ecspi1: spi1grp {

ecspigrp {

> +       flash@53 {
> +               compatible = "lm3560";

This seems to be not documented. It also misses the vendor.

> +&i2c3 {
> +       clock-frequency = <387000>;
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_i2c3>;
> +       status = "okay";
> +
> +       codec: audio-codec@1a {
> +               compatible = "wlf,wm8962";
> +               reg = <0x1a>; // 0x4a is the test address

Remove the comment, maybe?

Reviewed-by: Fabio Estevam <festevam@gmail.com>
