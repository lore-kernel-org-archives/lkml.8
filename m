Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEDE5C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 21:17:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B917820725
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 21:17:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UqNakKmZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbgGKVR5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 17:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726779AbgGKVR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 17:17:57 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB68C08C5DE
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jul 2020 14:17:56 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id q7so10422821ljm.1
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jul 2020 14:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wqb18s+NYtJBD4ijNg7d8R2/EPoJeQ86xG7wEDLp5I0=;
        b=UqNakKmZZ125zE7aCrUB/FRrke2hYX8bYIK72Azll6JhZ9g46WilSX2lPkVONVzkUn
         38oy1jIZbRqpBJqkOD51aYCJmb4Q4ElI2SAzJzDx2C0I0q7XCi1+zbT/MjHXnpnjHz+B
         lGug/VLskaWGmyA3bbZaudgCg2sieCTvxiamZDlgPXJDizun+WoNnsonxdYKxE4AT229
         FcWc98rUvcWF3JXBq/Gwr55pydfM5BitCAzvjIymtpl+dfRDYQtrsmnHsEKEM1/bein5
         iuAgSGLetrR08XSBvlJGEFzCLZo4AwNPGS2Wh3mZEJP/crq5RsZ3dA1A75XozhvnO5ES
         yJrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wqb18s+NYtJBD4ijNg7d8R2/EPoJeQ86xG7wEDLp5I0=;
        b=UvnrTITIoBex34m2BOHDwTg97D+oDLtNiVa79UmHhtXg/m3jEfajPtiMfzQ8F3Fxdp
         2YeXuxsuFVqp6KDweaPEGPi+mtv3HtAEPd7qioxrqoJnhJuHgaUq7GEf6ET0mlfIHgQW
         Mr9/QMEJPI9s64djA04vwqgcQNhHTQHSlvufVDJBxYg7XiAWMitr+zIcLu2ihFvoCpj5
         nKUlR4ltwJ5cDJUaLia6FfWeKyOQrBSolonVFswhbPf1skeOjJ67K1qgwO7VnlpbdlpU
         0gPIsF9jbuSMdK7fThJZZHCCGukMDk5A35j6YYI2BRVZtwrXZtTrwvLjEemOUyEdPlpD
         7TYw==
X-Gm-Message-State: AOAM5321oX6/g8EpzW/75UyhcZz8YR+IeuED/gBJsRId1yolIcOb1OFa
        EZ2HNB19jNJ2skIUe57dJvYYJg+MYrwzjtuMqTtiFw==
X-Google-Smtp-Source: ABdhPJxTb9eukJ235AFc+OGGaO7D1n9aCXDniaL1t98L7aPdbqsBZfzXdMGSsKdhxtpjBTSzm37thnqZs2YYXtskJPc=
X-Received: by 2002:a2e:8597:: with SMTP id b23mr27400495lji.338.1594502275360;
 Sat, 11 Jul 2020 14:17:55 -0700 (PDT)
MIME-Version: 1.0
References: <1594164323-14920-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1594164323-14920-1-git-send-email-Anson.Huang@nxp.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 11 Jul 2020 23:17:44 +0200
Message-ID: <CACRpkdYP4J+MZjxWUnkM-XGaMmFFZfMCfY13r7G6r2=v3F6zQw@mail.gmail.com>
Subject: Re: [PATCH 1/3] gpio: mxc: Support module build
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        oleksandr.suvorov@toradex.com, Adam Ford <aford173@gmail.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        hverkuil-cisco@xs4all.nl,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Leo Li <leoyang.li@nxp.com>, Vinod Koul <vkoul@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Olof Johansson <olof@lixom.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        NXP Linux Team <Linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 8, 2020 at 1:28 AM Anson Huang <Anson.Huang@nxp.com> wrote:

>  subsys_initcall(gpio_mxc_init);
> +
> +MODULE_AUTHOR("Shawn Guo <shawn.guo@linaro.org>");
> +MODULE_DESCRIPTION("i.MX GPIO Driver");
> +MODULE_LICENSE("GPL");

You are making this modualrizable but keeping the subsys_initcall(),
which doesn't make very much sense. It is obviously not necessary
to do this probe at subsys_initcall() time, right?

Take this opportunity to convert the driver to use
module_platform_driver() as well.

Yours,
Linus Walleij
