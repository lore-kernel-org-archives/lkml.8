Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E3FC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 08:02:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 330B32063A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 08:02:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kmiwBLiG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728391AbgGGICW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 04:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728370AbgGGICW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 04:02:22 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83475C08C5DB
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 01:02:21 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id s9so48771351ljm.11
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 01:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jtUOyKVPfoqn53IJY34j6NjtojqZ+ul+fKHV5uiQxGk=;
        b=kmiwBLiGpZZvtNTeKIU15ceN7oNeR238ooJAt0CvbsVCRioMTMtD1x4K9zbkRWKQfj
         W7RgeINwBObWyC5/fs3l+iztnAPnFlO+7+rT6TlvFxObY1g1gx3t3JQjKxE6FyUa9juo
         5N8AYr3CY5BYyDuMbcSRhA0X+wn/rOYZ8rkv5KuIj68/y3Xy1IWztOLZ/SwuJntz+jrv
         Vt9rGJw2piKJn4szUdPZwshV+vMr/O1n7q77GXP+6ZIdII0HAE3ejY83wE1+z2nQ/E+d
         7uBzrhj0+a6r2uqpZpQ5jycmEYlAqNFMZ6fT6hAcoUqpziWRbqwswmZSjiDqbSu9jA0q
         nVNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jtUOyKVPfoqn53IJY34j6NjtojqZ+ul+fKHV5uiQxGk=;
        b=aHt/PMWsuPXNAQlAlr86qEc2/9xNySaLcyoByAX090WoS4GVW6GKqYW/Z2wFqMbaUt
         kHRBEQ/yOLK2EYd3eXMwUcp2CT0RVyqJyteRwEugmIeh1u/oXXKs1GkjBBRJKrOIgJRu
         SyRnbzAuGOWzNZiB/YreCpxAsMlwFDtQKBKhfhM1tywmwGl22BFyjGidIg3Tt2e/J8W2
         hBdzPYapR0azBi6yZ1SCdqVhDx9gCTqByWtdcdSm7WlNhnpT/EL5GAHPb9p7WgQtfhgz
         tVo7DsroBRx0Gw6Y7WACRqvNfbmQNrkhIdK7UWCpSyEEyL1ORH0LacHiNgdz7YvWLZt+
         aa5g==
X-Gm-Message-State: AOAM532DR6q82E+T8sPXV8iVZYmXe89f1OdBGWA0SKqao0iuZLwRALpj
        XmqdsCuy94u3+T1Eu9sg/+dtxxoB5N0IYjocuQPDSw==
X-Google-Smtp-Source: ABdhPJyCTsje409P42BtkQ0ytfSdmbTULZn92mJJL2yEDwiZIrlVL3eLoJyeVqyBJtF11vUkJyptRe6bOJBOKNMOG8s=
X-Received: by 2002:a2e:8046:: with SMTP id p6mr15386545ljg.100.1594108939830;
 Tue, 07 Jul 2020 01:02:19 -0700 (PDT)
MIME-Version: 1.0
References: <1592979844-18833-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1592979844-18833-1-git-send-email-Anson.Huang@nxp.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 7 Jul 2020 10:02:08 +0200
Message-ID: <CACRpkdYYJfA9uur0R+9ONkEk1pEABJnzrPe7U0VX4-QVQHgLcQ@mail.gmail.com>
Subject: Re: [PATCH V6 0/9] Support i.MX8 SoCs pinctrl drivers built as module
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Sascha Hauer <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        NXP Linux Team <Linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 8:35 AM Anson Huang <Anson.Huang@nxp.com> wrote:

> There are more and mroe requirements that SoC specific modules should be built
> as module in order to support generic kernel image, such as Android GKI concept.
>
> This patch series supports i.MX8 SoCs pinctrl drivers to be built as module,
> including i.MX8MQ/MM/MN/MP/QXP/QM/DXL SoCs, i.MX common pinctrl driver and i.MX
> SCU common pinctrl driver as still built-in.
>
> Compared to V5, the changes are as below:
>         - Keep i.MX common pinctrl libary built in, ONLY i.MX SoC pinctrl driver
>           support built as module.
>
> Anson Huang (9):
>   pinctrl: imx: Support i.MX8 SoCs pinctrl driver built as module
>   pinctrl: imx: scu: Support i.MX8 SCU SoCs pinctrl driver built as
>     module
>   pinctrl: imx8mm: Support building as module
>   pinctrl: imx8mn: Support building as module
>   pinctrl: imx8mq: Support building as module
>   pinctrl: imx8mp: Support building as module
>   pinctrl: imx8qxp: Support building as module
>   pinctrl: imx8qm: Support building as module
>   pinctrl: imx8dxl: Support building as module

Patches applied to the pinctrl devel branch for v5.9.

Yours,
Linus Walleij
