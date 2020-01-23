Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F073EC2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 14:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C382E214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 14:50:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qNzbAggN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729108AbgAWOun (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 09:50:43 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42910 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbgAWOum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 09:50:42 -0500
Received: by mail-lf1-f67.google.com with SMTP id y19so2476002lfl.9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 06:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fNTKUOvPaK7NGZPdn9RrwLDwm3nxspv1+FNYwv3C3hM=;
        b=qNzbAggNf44Rjyi3xYv12GbLVPoWqZaEGnVV865MBvv6jFfDzRtp4lOna6Rgm4rgvc
         pXliObXDmabJwqfsEkby+uUceYrj9wJFfeWWmo7UIi7yjws0apqOXVdy6sq+tifkxkyJ
         WJ1w2CzfVPxAiHupGieQE0pSn3n43ScymKcvFNCn7HGnmo9TVWnuAL8CSvRgn37iGczT
         +QToDC6Zr4hjR2FvfO97FxNd9RacVRcMy+5gfNp8sdObik/cuPXSxrq5pSLv/lQBQcos
         Emm0PCLfAkk60QWURSKRv/BYfrvv/11/Cfrb785duxuKS4o1Nx6SQwiIUcp2P08VKKXW
         7ppQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fNTKUOvPaK7NGZPdn9RrwLDwm3nxspv1+FNYwv3C3hM=;
        b=Z14MHopMQUuQnLYOlGEKqo/Jr0EQod7hPSVMxEL33ygaHZnbtmqWxeKk5HcAdaFafb
         XThUtkvC3vNbuwUrnU2pggFaLKP4fKHJVkcBoW9rhl7rnNeK93dwWQoXwwZHYBi50n3m
         /K3yuPWC5PfS+/r3l+6HyH3oBiCX0EPIc+GNflBel+syejxi4/nUUrK2HhmPjNhJKNFy
         OD5aY7aI/iyRObBj+xnOvcv0zC04XDjQExQwnAmK2Sb021zXx/900ViLFB73n+vQiA9G
         TiZmRr6QgRHwPDM+iq9xxiux20MhPLbd8Z3BP/XCo+GHVMaybh8/2LwQpfGHAFEGhGdK
         V+bg==
X-Gm-Message-State: APjAAAWlvrIves3QKUzW5vw/zMl7WB9EAq6bznk2g8sFmzyPMOH0ilwr
        GIer/APKaUnxD280vqxiH7k4W1O2nisapJCdeUQolA==
X-Google-Smtp-Source: APXvYqxGwUR1H9HYGs2wE0Gbmgjwgzwz74XfSo69PdeiRrNPsM7q47aeOmg84PC9sjlXyry/YWLldmwkbBajFIoCZ68=
X-Received: by 2002:ac2:4d04:: with SMTP id r4mr4985943lfi.77.1579791040844;
 Thu, 23 Jan 2020 06:50:40 -0800 (PST)
MIME-Version: 1.0
References: <1579052348-32167-1-git-send-email-Anson.Huang@nxp.com> <1579052348-32167-2-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1579052348-32167-2-git-send-email-Anson.Huang@nxp.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 23 Jan 2020 15:50:30 +0100
Message-ID: <CACRpkdZ_v93Laaz-=1-CyOWPr86VAaeeArGRc5a18NgHNiuf=g@mail.gmail.com>
Subject: Re: [PATCH V9 2/3] pinctrl: freescale: Add i.MX8MP pinctrl driver support
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Sascha Hauer <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Abel Vesa <abel.vesa@nxp.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Olof Johansson <olof@lixom.net>, maxime@cerno.tech,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        NXP Linux Team <Linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 15, 2020 at 2:43 AM Anson Huang <Anson.Huang@nxp.com> wrote:

> Add the pinctrl driver support for i.MX8MP.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> Reviewed-by: Abel Vesa <abel.vesa@nxp.com>

Patch applied with Fabio's review tag.

Yours,
Linus Walleij
