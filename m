Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC90CC433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 18:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9216820639
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 18:34:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U4eAYvx/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbgHXSeG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 14:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbgHXSeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 14:34:05 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97643C061573;
        Mon, 24 Aug 2020 11:34:04 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id c15so5022904lfi.3;
        Mon, 24 Aug 2020 11:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JNOq4E4cvfpmPdPCLKK6f2uzsT1zQF0NRfrUU9+LfAw=;
        b=U4eAYvx/kxLwZw54thXu8yryQZAgc+tB7TMc85skS72oJfFI9unWe+e/RDgyLNEvMO
         2fANCT5bK12eZW/2Rub1v68bWvIupR2x83t9kcQ7Er6rhKUM0b9dBIi16rcgCO0PxBLr
         KoxOxmltlnOPFa6j4TcEW6bt+8CLqVnkNQki7nTdbhf2HIlrLfCld3r5bLqQiyXyVysZ
         158J1JCkDYkdcy7+3zxo5UsTz72by7mprWhKJpwX5jsXn2yeebzUCCbES114n3GmZI32
         osgIF292j68j0RsvC7jpCn7kRttGb4Ft+Rt4GTk72oAYEzl0UC0r4xHncmRG+v2AWHhH
         S0Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JNOq4E4cvfpmPdPCLKK6f2uzsT1zQF0NRfrUU9+LfAw=;
        b=RszmDrMl0zXdGfk5eQVJVmPlqbLgaVacacM7rBNuPPexbi9MaAdL8fu2F9H9FDqK6D
         tljqjvJ/AHXtCmW3t5jFfzRnZO/Ko89M+qTe6NQr6e0XSlBJEEdaQAOi3OdKHBRlWSYq
         USJ/Re7bX8srvr0EBho6uHY43LV017k6/+FwuxAQtcYxLnSg3luTRIoblhAWYbKvKwiL
         Bh6aKSFMQLrEzzq7rInatT3FVfk3eeUuJ94szCYvNzb27L7PBfBh66oPxGalD2EQiIAE
         SyCaWHp9BBQD0Mxy4xpj4bF9MWlvNEG9zI+4m8A8y8NKFyQzeOJgDgQy59hrVwPkRvwM
         NGSA==
X-Gm-Message-State: AOAM531vxQ3EGsuK58ps9/NRrxVUinzzgD3lai7IaZCm6seXKkbkHaq/
        tW7l/lP/8Xo08P/fi+yRCwQUQwBmqdnACWljhCo=
X-Google-Smtp-Source: ABdhPJzDwCnS91Cqcg32QV8kn9uBgPQ4OWRAsBDMQ3TEiOw2TmWj+gEqu/Wf0YCgvrwla0biCk0IjW6KNxmvFza5img=
X-Received: by 2002:ac2:4c2a:: with SMTP id u10mr3060651lfq.66.1598294041512;
 Mon, 24 Aug 2020 11:34:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200824160247.19032-1-krzk@kernel.org> <20200824160247.19032-3-krzk@kernel.org>
In-Reply-To: <20200824160247.19032-3-krzk@kernel.org>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 24 Aug 2020 15:33:50 -0300
Message-ID: <CAOMZO5DquPR9BmQP0kZfTqNJmRabPe1Vtc801M9CVCPFCd1usQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] arm64: dts: imx8mm-var-som: Add Variscite
 VAR-SOM-MX8MM System on Module
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Mon, Aug 24, 2020 at 1:03 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:

> +&ecspi1 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_ecspi1>;
> +       cs-gpios = <&gpio1 14 GPIO_ACTIVE_HIGH>,
> +                  <&gpio1  0 GPIO_ACTIVE_HIGH>;

These should be active low as 'spi-cs-high' is not passed.
