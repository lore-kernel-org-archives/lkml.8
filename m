Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1BD0C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 12:31:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8059620678
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 12:31:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GYLRyR3O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725997AbgFCMb2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 08:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbgFCMb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 08:31:26 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A0B3C08C5C2
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 05:31:26 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id a25so2492941ljp.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 05:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L1NJYuTKReAQCzwmp21v6oxd6VH6o0/1AXhj3Xbp+FA=;
        b=GYLRyR3OR2you4gt5Qoe94eTqGpHQxHxJtDqtMFwAwycpFKpORilUHJ+cpxeyB10dZ
         HZZIncnj4Nc5euIkBmYg91PiCtTZXQoWLM//bJq/8ljVCqKGsEkudebxu1rD/xFge7XX
         gUcQtcfaYyLClnFKKSzUJFm9UdTCKp09CFDZ/ll0z2c+BjIUHXiTXK0/xIsaBmZFPgzW
         5PcPHAb51hM1T8b69zqjgmxhk7njDjDVmtYtpuT0xSkK8+vIbM4iI1M6M5/VlhCf0/Sn
         7xxUT6j3nTgizmvd+kLannVm19nUGA+BXHohp50BOfs5E71QhnvSDS02jxYWWK3eWHCv
         fbxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L1NJYuTKReAQCzwmp21v6oxd6VH6o0/1AXhj3Xbp+FA=;
        b=N8cGE4vz7b51FIi28EMcM1s3boHDWeof7kx0glcmg5wefO/IWZHpYlrDXDenHcCDDe
         z9X7/SIsoC8PDFHYH01XD3/B+5yGban+/Brou+zk6iJsn1T4bbbfiKKiUv4MHZKkQe9j
         sWak9mQqUh6n5ZqnI4ZjX4IiQzYab7eMHvhoPwB7Pn0LNCGMkf88v+wSRNXOdkFoDvPT
         uQMbe1F2YHDSxAq8i3BI0VC9+5TFh7GXN7XHjVDWn++upJ/VPQtYqbV564tmI5XkFtjP
         Bk8TK7AeNIiP2hwKCeJ3vrJ/uTwVJZpAg6+p6TU1CP1fvLyqOaRQoV6RQjt4bPlhDy3u
         o5jw==
X-Gm-Message-State: AOAM530CMuAn1yYVwXkdhJP8jYYZVq1UyYSixZ5+GGiTir787V4QOvhb
        KJbR7O33sPP4bn8cPNyRTGQhOPmlH9nxZoU80O/uOg==
X-Google-Smtp-Source: ABdhPJzeYHCrqoAKbg/iXMZc2UHkSMqVGpsvQRy6zx+BK4rdk3W1fxIGP76BKw3wR0/nVnq2bumPP8UA4bGzDwuUJyc=
X-Received: by 2002:a2e:350a:: with SMTP id z10mr1920234ljz.104.1591187484286;
 Wed, 03 Jun 2020 05:31:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200530201952.585798-1-christophe.jaillet@wanadoo.fr>
In-Reply-To: <20200530201952.585798-1-christophe.jaillet@wanadoo.fr>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 3 Jun 2020 14:31:13 +0200
Message-ID: <CACRpkdYvoe8o8Db1mszfgcHA3XZF7LJ3P1u5pnKOfEfS99F0Ew@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: imxl: Fix an error handling path in 'imx1_pinctrl_core_probe()'
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Sascha Hauer <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 30, 2020 at 10:20 PM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:

> When 'pinctrl_register()' has been turned into 'devm_pinctrl_register()',
> an error handling path has not been updated.
>
> Axe a now unneeded 'pinctrl_unregister()'.
>
> Fixes: e55e025d1687 ("pinctrl: imxl: Use devm_pinctrl_register() for pinctrl registration")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Patch applied.

Yours,
Linus Walleij
