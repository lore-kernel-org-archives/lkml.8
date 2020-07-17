Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9CD6C433E5
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 13:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A4812076A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 13:44:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cZMposf8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgGQNoc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 09:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbgGQNo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 09:44:27 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 435FFC08C5C0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 06:44:27 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id b30so3778299lfj.12
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 06:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1cUJdFz7tKiJruju+faOa4LG72A7NyvpvJU3G6JjCco=;
        b=cZMposf8Bdnm371NM5sPZlM/Is0F5t0m+S9ezxyz5F0ewN5dQ4z9Gz4kV19AV/oGv7
         AHwH4yY0xZA85B8vd03RqF+47bHBNo+zh9Gn0WtV4oYw7yuzYJg94UEpD+yhv+YuCIFk
         DBN11Ba0xu3uapZyMG133CrLeSV5g0Md5zrsihIFZYDxIvcKlFifAd4KzKRbmJ8fUs13
         nW3qsfXWmjnoRjIk8xtLhgfZyupBJncmE7HMrBGg3zdfRQpIbiS/0fkEZv6YRmM10hjo
         1IDc22DAV+kyFgNesZmJCV92yMZpf8ajo9bFcrPoKc3k2puE/9sa3gjwE+Tl3cnJflBQ
         2lQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1cUJdFz7tKiJruju+faOa4LG72A7NyvpvJU3G6JjCco=;
        b=b6E3ck6UtTPT1lAcNyXHBj9yPqnF4og2o3Fq5iWZ+WWeMbj1vBosP6H1bSy0Pnz7zN
         hYG2djlryWlcZ6q0pY8QK6vI7tpx+hsJcoEbUJMbFkfkvMb2O8tVwHR6NYmoSGg4n6TT
         WgRFM+C+uU9t98VbISdUCVX/7Q+5GV0w9QBDDfeyuIjBHaWZwFuvqL4jTsIJnk26whAI
         E5aD2JSkAe0zHhDNkCxk2lcFcQRqJnGNUTuHIbxCHqsj2NnkwoZDBangTo0KH2yHjmdK
         puvRQ9DKWz9wIqGDPv7rLgY0GzDsJRjx+6h82YIYmE1wZTRKFOTzzqHQC2baDHowHjJ5
         Uj6g==
X-Gm-Message-State: AOAM5312DlrDkibIKdkBLH8LMc/vuGBYQZO4iOleK5PtkSGixkFbLGAa
        4Z3MLZEDRKeLLzhDATgvGvxHIgwz2T8bWyauL+MlDw==
X-Google-Smtp-Source: ABdhPJz9OaEbmRdr7tZ9xjj6gzeKrgTKyKKbHvXy2wlCBJ59h3kvRdQYhaDAYRnQwuY9xk+M8U0GuJTdEB6TDm8UksU=
X-Received: by 2002:a19:203:: with SMTP id 3mr4730864lfc.77.1594993465647;
 Fri, 17 Jul 2020 06:44:25 -0700 (PDT)
MIME-Version: 1.0
References: <1594164323-14920-1-git-send-email-Anson.Huang@nxp.com>
 <CACRpkdYP4J+MZjxWUnkM-XGaMmFFZfMCfY13r7G6r2=v3F6zQw@mail.gmail.com>
 <DB3PR0402MB39168FEA9306CBF90A596E31F5630@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <DB3PR0402MB3916FB27846F462C2210C3BFF57E0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CACRpkda2gdu8FsSM0MC6g8C1mebmVc5dFWJZwNvQUPXNi5bnkQ@mail.gmail.com>
 <DB3PR0402MB39167A4BB808A0679257DEF9F57F0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CACRpkdbCVZaHqijqMck+jLAJuCAT31HA=9wwcV_EnQc=hsXLwg@mail.gmail.com> <20200717121436.GA2953399@kroah.com>
In-Reply-To: <20200717121436.GA2953399@kroah.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 17 Jul 2020 15:44:14 +0200
Message-ID: <CACRpkdYd1g6GScFitPkf-VSn2kTmWOjUi07ZeVhZiP2=0qCUbA@mail.gmail.com>
Subject: Re: [PATCH 1/3] gpio: mxc: Support module build
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Anson Huang <anson.huang@nxp.com>,
        John Stultz <john.stultz@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "oleksandr.suvorov@toradex.com" <oleksandr.suvorov@toradex.com>,
        Adam Ford <aford173@gmail.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Leo Li <leoyang.li@nxp.com>, Vinod Koul <vkoul@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Olof Johansson <olof@lixom.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>, Jon Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 17, 2020 at 2:14 PM Greg KH <gregkh@linuxfoundation.org> wrote:

> So moving drivers to modules is good.  If a module can be removed, even
> better, but developers should not be lazy and just flat out not try at
> all to make their code unloadable if at all possible.
>
> Does that help?

Yeah it confirms my intuitive maintenance approach: developer submits
modularization patch, I will be a bit inquisitive and "can't you attempt
to make this thing unload too" and if they conclude that that is
an unfathomable effort I will likely merge it anyway as very likely
the kernel looks better after than before provided all build and test
coverage stays the same as well.

Thanks!
Linus Walleij
