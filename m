Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA5E4C2BB1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 14:08:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CED420663
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 14:08:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H7DN/hrX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727619AbgCLOIM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 10:08:12 -0400
Received: from mail-vk1-f194.google.com ([209.85.221.194]:42972 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbgCLOIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 10:08:12 -0400
Received: by mail-vk1-f194.google.com with SMTP id e20so1590600vke.9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 07:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6J9Ig2oz1bb7guvVXYyRNpRVz0RKMu9DYxVEd/SzgXI=;
        b=H7DN/hrXC5SOfs2915ZbQulRR7iAHtt3uIi89leVhH11cRIYwJ9rIM5rrJTWqrQc9c
         k6W4+S7mPhWQ2G271UpAF2UqqOBhfUyXVTTOQeRHxJK7VosV9dmfY0UvneGlfP+dqukd
         ba3Z/Ki7tJ2JemSrkSaxjoOoJtCIg6pMKZ3j9UHyB38C1Ah7aqbxMCC2r+nHacnypqbc
         r3A4lgiLdqxs92Kk3ltPbguQYkRSI1unHNO6GWPHWvlAERBw4nfA4AMns8o44eOr+zKm
         BUJ0/BKeCLxznbuOfoSnK76G/tzMHiPgKc78DV+nGGwt69TptpgDvh0rOWdTy6i018Jm
         ag0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6J9Ig2oz1bb7guvVXYyRNpRVz0RKMu9DYxVEd/SzgXI=;
        b=HL1r76gL47EXRbceWDXeT5RNhD5hJDMDW8B50s5UFsZlnSfMWnfz/D1CDWkYO6aC3h
         jMdPw/8rXkX/kmZN1keWBYxGKWDbVi4JLQIj2LuPeyyTB/Lh8Lxw5e7L5fELncMvjqce
         3rXUBGXKF5Iwg1YEX5Ag7YqzjVK0+5ytJ/SRjKlw/Jwqr7ieQ1JwrYSjg8mxtT4Juz7W
         ZrHauvcoyodVQQEIu88HU547fot+5Eme+y/hE09pzAYx4BxHf366BOK5O/m0h98M6iiO
         l7ksOzdLKW1r3emWLs3dQtKB6P7dcYSUJqpnWVTsaEKOnP9hlHMneAngzs5pdY4Tdt9a
         6uyQ==
X-Gm-Message-State: ANhLgQ2sITydve6oD98lu5t3RnHq/QqWY7q0xTTXl0oim605xq/X4inC
        xjXjt3Rhh2JDgYB0TFEkJflc8FcG5CDOEpUMBHuwTw==
X-Google-Smtp-Source: ADFU+vsGDaiiav8lo5THUgIDY0HPzi+5T5mlfmPdJyURWCmQInX4drk2MUTv+qfoecTOl54d4a4OmoBfL83ZlRl3Who=
X-Received: by 2002:a1f:5c84:: with SMTP id q126mr5449459vkb.5.1584022089616;
 Thu, 12 Mar 2020 07:08:09 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1583952275.git.amanharitsh123@gmail.com> <d12a15f496ca472e100798ac2cd256fbfc1de15d.1583952276.git.amanharitsh123@gmail.com>
In-Reply-To: <d12a15f496ca472e100798ac2cd256fbfc1de15d.1583952276.git.amanharitsh123@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 12 Mar 2020 15:07:58 +0100
Message-ID: <CACRpkdYv0U0RmT7snp+UejEXecq4wLkhc11DUniUfGYAgyXC=A@mail.gmail.com>
Subject: Re: [PATCH 1/5] pci: handled return value of platform_get_irq correctly
To:     Aman Sharma <amanharitsh123@gmail.com>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Mans Rullgard <mans@mansr.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 11, 2020 at 8:19 PM Aman Sharma <amanharitsh123@gmail.com> wrote:

> Signed-off-by: Aman Sharma <amanharitsh123@gmail.com>
> ---
>  drivers/pci/controller/pci-v3-semi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/controller/pci-v3-semi.c b/drivers/pci/controller/pci-v3-semi.c
> index bd05221f5a22..a5bf945d2eda 100644
> --- a/drivers/pci/controller/pci-v3-semi.c
> +++ b/drivers/pci/controller/pci-v3-semi.c
> @@ -777,9 +777,9 @@ static int v3_pci_probe(struct platform_device *pdev)
>
>         /* Get and request error IRQ resource */
>         irq = platform_get_irq(pdev, 0);
> -       if (irq <= 0) {
> +       if (irq < 0) {

Have you considered:
https://lwn.net/Articles/470820/

TL;DR Linus (both of them) are not with you on this.

And that is why the code is written like this.

Do you really have a platform that could return 0 as IRQ
here? In that case, can we fix it?

>                 dev_err(dev, "unable to obtain PCIv3 error IRQ\n");
> -               return -ENODEV;
> +               return irq;

That's OK with me.

Yours,
Linus Walleij
