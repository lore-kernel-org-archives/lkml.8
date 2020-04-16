Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA3FC2BB85
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 09:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 649CA21BE5
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 09:41:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ObziAsNZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503991AbgDPJln (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 05:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2503869AbgDPJlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 05:41:06 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E762C061A10
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 02:41:06 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id y4so7074014ljn.7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 02:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8dAk70I1p4hnhRGOefpbJT7ms2GQjkjqrJGg81hx6OQ=;
        b=ObziAsNZFmML/a7d7NyFT7NUp0TNcEQoe/JcKNJRXlvCU3WayEVxd+oN3RnNbY2YK9
         fdwRkA2KoGhzenGHSQwzhrnXNIAvYHWxmiS/2E0x/Ti3lsohU1KAS/vGFGhbV/JKJGru
         IZakD4MQ73Hb+ddeolKSS/3O/BATf1tH82knHsUXb4ZnWDnSnn/Uo1r2Z8bgJaBg/oSQ
         jvDe9T3HDh61oUWZvHkDZrlF7Fpj4VNr3ji1FKygGOrcPWMqXpluT5PKq6TaE2BdX5WZ
         A2bUMW2Ip9GH5STT7BwaS4KvoAbcvYu2Eq5P+JT8ilaLA2T+PcZqATJAP1T/UlQMOTMC
         sRcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8dAk70I1p4hnhRGOefpbJT7ms2GQjkjqrJGg81hx6OQ=;
        b=lEbbceYaL2BEzoAsUnrmZdRA1elWVuiEl5103FS9V2jttS9cUovYBnOXSwZ3nwNjO2
         Y9Bx4eSKv7zB4QJ7AmenGE+AL11o1VQ5jO35mAf4xz+MFbHega78GDYwTGFdj8RBK0AV
         GWK0XSV3hm5dOFWADYdRxnIsY5xasfryx+g+TBjMMT5lWKA9A1GvdHmN2aTsM1jST0LH
         CaH609PEjEwgaq+EryR1l83J63Lg9kYsqF2Qa9PifflKi/VObOQCJo9GO+znTznwqcZS
         qfStPCpugmpLQkUL75VZzoPayEJ82z/WQWaSBuISa3GAw414m4AxA6+beDyQrTYXT8Fb
         mqXQ==
X-Gm-Message-State: AGi0PuZ+PjxCdthTg/jKT/mVKpUlRe/jM+yZqVXBboVO+5MXVy0YKGhu
        Fvsw4Y7UFz6SBkNi02SRy/OR3sT4PvmRPvvL6czhMA==
X-Google-Smtp-Source: APiQypK8qx4sDjdMlKaIAgsSnv1jrL4D1nl6jj30y6f4zJEOB93Qgx1Jwe4YMT5gUNKLU95XB+kIvZo1wtO6/Q3eFao=
X-Received: by 2002:a2e:8805:: with SMTP id x5mr2401076ljh.223.1587030064671;
 Thu, 16 Apr 2020 02:41:04 -0700 (PDT)
MIME-Version: 1.0
References: <1585306559-13973-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1585306559-13973-1-git-send-email-Anson.Huang@nxp.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 16 Apr 2020 11:40:53 +0200
Message-ID: <CACRpkda7U5M0OU+dQ9CKNqqmZ0XU=LsWqZAOy6faDqknaDCaQw@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: arm: fsl-scu: Add imx8dxl pinctrl support
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Sascha Hauer <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        Peng Fan <peng.fan@nxp.com>, Andy Duan <fugang.duan@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Leo Li <leoyang.li@nxp.com>, Olof Johansson <olof@lixom.net>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        NXP Linux Team <Linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 27, 2020 at 12:03 PM Anson Huang <Anson.Huang@nxp.com> wrote:

> Update binding doc to support i.MX8DXL pinctrl.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Patch applied.

Yours,
Linus Walleij
