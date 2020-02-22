Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFC02C35666
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 11:23:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2346206EF
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 11:23:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KIwfoweW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbgBVLWn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 06:22:43 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33398 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726836AbgBVLWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 06:22:43 -0500
Received: by mail-lf1-f65.google.com with SMTP id n25so3429093lfl.0
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2020 03:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ROzac2uLC7kqowxE+PDOREiBLkFFQM2vDr6O0hYhD9w=;
        b=KIwfoweWr/ifwgofjrdkqltpUNUZq2GNDeSDGFKuhqsdvHJNxmdIxPEpmCMmgi/7Mq
         aMNKFsPFkoFR5pSysGd/DtosSaTDyNSQwX32AvZz47DqFgj2J3Pu3PTt8ehOQWDMIj7z
         YguRXfiiCPKKDVLkQPE15O6mibJ3joOzalY+zwbwEyW6QBrNqbP/UPX6dQxgQjcGg9uG
         uG+DSdYsOSKa7fmNjuDqUqftgkjNvFclBcaIgv0HckE0dX8kDuJJAjZOOQr/yerUveRt
         MTaTskaDiRciaXesfQanOGD6eGT2vwIw/nsWgXKLpCAH17zZvIGn9QThhQIVOqQ8ybcL
         YZdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ROzac2uLC7kqowxE+PDOREiBLkFFQM2vDr6O0hYhD9w=;
        b=nQwI3sGBQaU+N14L+5lnQZNbxrGjrTZb6t96+kKCWwvoD6lt6l1XodpsuCpmYRgswV
         QewpbCq881ftQea6BwiGI4Y/ZNm4bkjPyyVrAVnBB2UuIvb8oohsZZ3QM/BPgkgpCmq1
         NR+l0PgD+NNH4MmgRG56s53HEfhqfOXRpd1hs0hRTUGpG7SQc7zVC2INhGgiJat9CZNk
         yajt16fO45ed7rVbRicGepycr0uoq5Nipwphl9vTEx8ffiv4vdvJjyJ9hqk4DePZH5Ul
         cX2ex95t/gsmmDGEAxOotJ0GZSn9ycM+Da9skEZS/Fa+0rtB5+5ZlTbMpWzyBiw6jd3+
         gSPA==
X-Gm-Message-State: APjAAAUKwEvTK/pWIyLoGXE28arjzrUKb3xO5LpZ0xJR4Qw6naHNUjEk
        +6cXRs4dZWWhSsEpNKNP7dWCINGs1Juko9U3yeDJAcHnwiE=
X-Google-Smtp-Source: APXvYqyTywaJiSpbnWFC1W2YkgVQEnrOsf/OK0dEWuaZYFukmvPYTaNDVbNpAJK2yXNZtbzIrXL2ZU197DHrl6cNTek=
X-Received: by 2002:a19:dc14:: with SMTP id t20mr22063257lfg.47.1582370561607;
 Sat, 22 Feb 2020 03:22:41 -0800 (PST)
MIME-Version: 1.0
References: <20200203140425.26579-1-erwan.leray@st.com> <609b5744-cc1e-8ada-fe14-6cc199c0a91d@st.com>
In-Reply-To: <609b5744-cc1e-8ada-fe14-6cc199c0a91d@st.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 22 Feb 2020 12:22:30 +0100
Message-ID: <CACRpkdbZDaX71gLvmLTB5XxeE+6R9pGzhUiFEWjhFQUjS2yP8Q@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] STM32 early console
To:     Alexandre Torgue <alexandre.torgue@st.com>
Cc:     Erwan Le Ray <erwan.leray@st.com>,
        Russell King <linux@armlinux.org.uk>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Nathan Huckleberry <nhuck15@gmail.com>,
        Gerald Baeza <gerald.baeza@st.com>,
        Clement Peron <peron.clem@gmail.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2020 at 4:58 PM Alexandre Torgue
<alexandre.torgue@st.com> wrote:

> > Erwan Le Ray (4):
> >    ARM: debug: stm32: add UART early console configuration for STM32F4
> >    ARM: debug: stm32: add UART early console configuration for STM32F7
> >    ARM: debug: stm32: add UART early console support for STM32H7
> >    ARM: debug: stm32: add UART early console support for STM32MP1
(...)
> Do I have to take this series in my next PR ? or you'll ?

Sign it off and send a PR to ARM SoC.

Yours,
Linus Walleij
