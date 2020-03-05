Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F77C3F2D2
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 18:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C6F2208C3
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 18:29:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jvOU9y2j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbgCES3f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 13:29:35 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:44418 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbgCES3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 13:29:34 -0500
Received: by mail-qk1-f193.google.com with SMTP id f198so6270308qke.11
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 10:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aO2Nq+upn1lfouLFIykWQjQaxMLKoHNR//pZLEIFyDY=;
        b=jvOU9y2jIyuus28lCdGSa29MRkBfX+AYfa5dfh0jIofGHb60Kox/pvSem+UEw4v45i
         bEK4m8apx06qK2bXZLYnmrQLG7H6sS962p/so7lwIXzHijeZ1GCFtKfq2u8atHdw211U
         q4YjG1gpJhref3SVpbLge9rRpDiEn5bk3H2y1jWijafqK1aPMHAgHsEtrB4wS7aVJH7V
         ITm4r4BXl4VO+6XWjwbvp5PE1U9Gbj4i9JFQsnAzHDzRSrVk0qWn4wgc709ZaaVdqKOQ
         bLddG18m4X9KkYtRuvEbYEhr5Y9Weui9eLIZrWbF2OEkP/iuXz3h5dx6S56m3q0IXKLa
         IA4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aO2Nq+upn1lfouLFIykWQjQaxMLKoHNR//pZLEIFyDY=;
        b=VRfoJEPuTQQeDORy6bTC6A7sg1LIHwyH1RU+7hA2utI0Hxsu8oIPrhHvOkteZPN/OM
         n+8RSdHJlzlxhGoURcgPYyVwWZC8+5x+8kgJu3KGiZ2LjjlDjf8eT+jJU8Ooozn2qyBO
         SD6h3J7rZHJ2xlzYiPOqIH5Jf7fq79q+IGuNfr7g0bkGTLb37Fieoz5AP5gaTjMGG+Q/
         FI3tTYG6mWueSGLSItyAtu0XMp+tBxBphK8JtmaMnYl61dr5CCYJRPAH081ZuyfDwkfw
         F/z9uiDBvk6525RsQvQubz/j7PiWRq+7lIdj1d2+oba1T71yZiE5sZ7LmbqfpYkp2URp
         Qhvw==
X-Gm-Message-State: ANhLgQ2b7Rv86gaJy8rjV6vvlvY3rTbCXpBBGqMpE6GkqbRL5mvaym5d
        pqS/v7KE9yRMWzwU9P0xspP2x/UkJO3LCVs5bT0=
X-Google-Smtp-Source: ADFU+vsq2/P0E2CDnX7KV7FdX1+WD1Ea4vTrjXDFHtSlnmi/MkBaggpukFlmsbWyGUmeM7eR/CtWPLqYjK5bAud44Y4=
X-Received: by 2002:a05:620a:12a2:: with SMTP id x2mr9530926qki.276.1583432974202;
 Thu, 05 Mar 2020 10:29:34 -0800 (PST)
MIME-Version: 1.0
References: <20200213145416.890080-1-enric.balletbo@collabora.com>
 <20200213145416.890080-2-enric.balletbo@collabora.com> <CA+E=qVffVzZwRTk9K7=xhWn-AOKExkew0aPcyL_W1nokx-mDdg@mail.gmail.com>
 <CAFqH_53crnC6hLExNgQRjMgtO+TLJjT6uzA4g8WXvy7NkwHcJg@mail.gmail.com>
 <CA+E=qVfGiQseZZVBvmmK6u2Mu=-91ViwLuhNegu96KRZNAHr_w@mail.gmail.com>
 <CAFqH_505eWt9UU7Wj6tCQpQCMZFMfy9e1ETSkiqi7i5Zx6KULQ@mail.gmail.com>
 <CA+E=qVff5_hdPFdaG4Lrg7Uzorea=JbEdPoy+sQd7rUGNTTZ5g@mail.gmail.com> <5245a8e4-2320-46bd-04fd-f86ce6b17ce7@collabora.com>
In-Reply-To: <5245a8e4-2320-46bd-04fd-f86ce6b17ce7@collabora.com>
From:   Vasily Khoruzhick <anarsoul@gmail.com>
Date:   Thu, 5 Mar 2020 10:29:33 -0800
Message-ID: <CA+E=qVcyRW4LNC5db27d-8x-T_Nk9QAhkBPwu5rwthTc6ewbYA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] drm/bridge: anx7688: Add anx7688 bridge driver support
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        =?UTF-8?Q?Ond=C5=99ej_Jirman?= <megous@megous.com>
Cc:     Enric Balletbo Serra <eballetbo@gmail.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        David Airlie <airlied@linux.ie>, Torsten Duwe <duwe@suse.de>,
        Jonas Karlman <jonas@kwiboo.se>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Collabora Kernel ML <kernel@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 5, 2020 at 7:28 AM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> Hi Vasily,

CC: Icenowy and Ondrej
>
> Would you mind to check which firmware version is running the anx7688 in
> PinePhone, I think should be easy to check with i2c-tools.

Icenowy, Ondrej, can you guys please check anx7688 firmware version?

> Thanks in advance,
>  Enric
>
> [snip]
