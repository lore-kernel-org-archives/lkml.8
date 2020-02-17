Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFC47C35254
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 12:09:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96A8620578
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 12:09:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n9Fo11L3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729324AbgBQMJo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 07:09:44 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:44822 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729129AbgBQMJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 07:09:44 -0500
Received: by mail-vs1-f67.google.com with SMTP id p6so10165276vsj.11
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 04:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oBb0QJcwW+pMZoqAADG1spPncuL+ePZDiuNfTdr7G6M=;
        b=n9Fo11L3tsX8rT+JJuwBqExamkqDnSsrTvIm73Lm3v11fT2ph8ApQNVAWPO9piMy/r
         kfs+HR32fHUQWjhfJFgQ6ALQHRtkEH7r1KICZVikMs1FMv+VAoh/Y2zazCcMWaERSCAD
         iyp9jGqRNE2Kc00U9IOqJhwDd7XRzKGU1qYF4dtFGicuO2jmJ/ClwFCewmbb4Xx5qIIj
         D5xJTsz4EXssLKk5X8wb9FFsmk7+VlAj0upv3mwFDSmFdmNqS/Edo3Z28CAZBtj6w2n/
         M2Mw7mYDO0E6wZWfNkCZ05Fp8IaANY9Pe/cQzSLeKanQbhcpyjNdm5KCfoOE6Y8f0Mzr
         RNsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oBb0QJcwW+pMZoqAADG1spPncuL+ePZDiuNfTdr7G6M=;
        b=ulVXFTXP15bl08lu3UotdTilUi9dl6WoVnfWNiMh7htkUSRn+O71G/j/QAj3s/zsZ1
         HkKwrZEz3ZgX6dB3V0Y3eH8BZbb6zdwIeSvezep5KGHADVm+WkIVYxoWZgSlYwJsHkby
         tdFcuDyn9ORK/+mPsOfNTSW470xX9cJoZ11jUByadj9/dWLMYbxJiCwmX4qJ+8RnTmOv
         FzPA2Z+UySRq8WNn1CKs/xXHxxjH8tLBKKeY/jR8V85Amk7V6ScqfcBMR4VRbazKe3B2
         j+KOKz5C/OGe+jyC5LDhKx4QYKSqhyPGWdjGw+5/hFKbdKKeJBX7gzBx/ZthPZKze4pl
         m5tQ==
X-Gm-Message-State: APjAAAWMYuX1ok6cxyv5xDXdIBcUYH4MeCa5WOs545LdV83xrN7Mn/eA
        B001e1FT2hFtNmIRU2c3/gDj1ZtZTQJmkw3ZBE0=
X-Google-Smtp-Source: APXvYqzE28bMSvm3esuK1ePYqHVwAWtjFcUl9pdJGqvpNIXoHf065oCttNfTauV/xZthVWFo5Df8q1VcpMKGsb7tlTc=
X-Received: by 2002:a67:fc8c:: with SMTP id x12mr7125965vsp.96.1581941383156;
 Mon, 17 Feb 2020 04:09:43 -0800 (PST)
MIME-Version: 1.0
References: <20200124084359.16817-1-christian.gmeiner@gmail.com>
 <CAH9NwWfMwN9cRgMHPF5zPCmdmnrfX7E6cAYW8yfUGTf+t3=HzA@mail.gmail.com>
 <CAJKOXPdM4s8DAVPh1zOt5kYyEjp4dmbseC3RdrKaVk4H41XOwg@mail.gmail.com>
 <CAH9NwWdg5r1T9TkXAe4=3Zui2vMcnOc2UJ=e02NFbiPhb5n48w@mail.gmail.com> <20200217041936.GH5395@dragon>
In-Reply-To: <20200217041936.GH5395@dragon>
From:   Christian Gmeiner <christian.gmeiner@gmail.com>
Date:   Mon, 17 Feb 2020 13:09:32 +0100
Message-ID: <CAH9NwWeT=h=hPzDbwRggNYNx-mSdQkjUypPWk2nmsLDOfw8Zqw@mail.gmail.com>
Subject: Re: [PATCH] ARM: multi_v7_defconfig: enable drm imx support
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Olof Johansson <olof@lixom.net>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Patrice Chotard <patrice.chotard@st.com>,
        Joel Stanley <joel@jms.id.au>,
        Tony Lindgren <tony@atomide.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-arm-kernel@lists.infradead.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mo., 17. Feb. 2020 um 05:19 Uhr schrieb Shawn Guo <shawnguo@kernel.org>:
>
> On Mon, Feb 10, 2020 at 02:30:12PM +0100, Christian Gmeiner wrote:
> > Am Mo., 10. Feb. 2020 um 11:58 Uhr schrieb Krzysztof Kozlowski
> > <krzk@kernel.org>:
> > >
> > > On Mon, 10 Feb 2020 at 11:54, Christian Gmeiner
> > > <christian.gmeiner@gmail.com> wrote:
> > > >
> > > > Am Fr., 24. Jan. 2020 um 09:44 Uhr schrieb Christian Gmeiner
> > > > <christian.gmeiner@gmail.com>:
> > > > >
> > > > > Makes it possible to multi v7 defconfig for stm32 and imx based devices with
>
> What do you mean by stm32 based devices here?
>

CONFIG_ARCH_STM32 - I have a STM32MP157C-DK2 in my board farm and
would love to use
multi_v7 for imx6 and stm32.

-- 
greets
--
Christian Gmeiner, MSc

https://christian-gmeiner.info/privacypolicy
