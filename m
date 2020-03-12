Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38866C2BB1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 01:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C89420753
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 01:41:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dEXMnPsU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387617AbgCLBlu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 21:41:50 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:45373 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387599AbgCLBlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 21:41:49 -0400
Received: by mail-vs1-f65.google.com with SMTP id x82so2661889vsc.12
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 18:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k+2wQEy+NMnEIDcA6S02pCEqP6eFCuK4Z4/8szPajwc=;
        b=dEXMnPsUOVToOowHXjjb6pViv6j7NYO7alRyodmH88IKDJ9teW/utBZ2GV7iOxO+Zc
         BrLj3iTeeQ+MIS6lFh5vpKzqi+cXFhOJrEjLbZciKYQInENdAVdYCjV2c3wwPVIHA+yu
         Z3R+683VAjC18js16mQ/SEe7KXz99FCSaNuSg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k+2wQEy+NMnEIDcA6S02pCEqP6eFCuK4Z4/8szPajwc=;
        b=CMYWlAFMfp6TNecRAXZbDJFwF/T4tKjubWmHQwzYDjgaeUU3gDNNDX2QdSgmSqV+m0
         HoRFz942VSGkyYR2wp6pGXgw2vwa5uTsm63+rXc195+6fQ4YeT67G6Tx86awXkCd+qZx
         VT9x/QB0sjv6o0sFbv5I2PRSZqapk4hvyxXmAKMTEKNDkckCkR+Y4rN7sikeC9wp5mvK
         c/Dnv8kv4q/67mFiMvINV3jV+SGkRdDJpKtxIWC7txvc+t8WV1COqPPnzJoIX5cks+oP
         UYkIEH4dfwpWhuVL34mGDF3aEHhUq9+pzVw371kVHLD0/31+LNY7f512NSFrSTEvSOLP
         RP2w==
X-Gm-Message-State: ANhLgQ0L1rdzA0cV5f/DMHMuabb1ovKFDrKUvp0SYEX6zA/NIjRrC3+O
        3uBmvpCCAzkKJLi7tStXCtI84Th4s46EcFtqBcjugw==
X-Google-Smtp-Source: ADFU+vtwixbNza+rk01UttXlhW3Uxqa+sfYsUCDCqXXbvWG6vOSRtdS02syicarawHJ6J0EPqdPba2S1Oz1D1r/xpoo=
X-Received: by 2002:a67:3201:: with SMTP id y1mr4190035vsy.54.1583977308293;
 Wed, 11 Mar 2020 18:41:48 -0700 (PDT)
MIME-Version: 1.0
References: <1583918223-22506-1-git-send-email-hsin-hsiung.wang@mediatek.com> <1583918223-22506-4-git-send-email-hsin-hsiung.wang@mediatek.com>
In-Reply-To: <1583918223-22506-4-git-send-email-hsin-hsiung.wang@mediatek.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Thu, 12 Mar 2020 09:41:37 +0800
Message-ID: <CANMq1KBdYPiWDHqSUwu86q3Kj=r0PWCoYcj28v5poNKNsB5U0w@mail.gmail.com>
Subject: Re: [PATCH v10 3/5] mfd: Add support for the MediaTek MT6358 PMIC
To:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Sebastian Reichel <sre@kernel.org>,
        Eddie Huang <eddie.huang@mediatek.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Frank Wunderlich <frank-w@public-files.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Richard Fontana <rfontana@redhat.com>,
        Josef Friedl <josef.friedl@speed.at>,
        Ran Bi <ran.bi@mediatek.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        linux-rtc@vger.kernel.org,
        srv_heupstream <srv_heupstream@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 11, 2020 at 5:17 PM Hsin-Hsiung Wang
<hsin-hsiung.wang@mediatek.com> wrote:
>
> This adds support for the MediaTek MT6358 PMIC. This is a
> multifunction device with the following sub modules:
>
> - Regulator
> - RTC
> - Codec
> - Interrupt
>
> It is interfaced to the host controller using SPI interface
> by a proprietary hardware called PMIC wrapper or pwrap.
> MT6358 MFD is a child device of the pwrap.
>
> Signed-off-by: Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>

Reviewed-by: Nicolas Boichat <drinkcat@chromium.org>

> ---
>  drivers/mfd/Makefile                 |   2 +-
>  drivers/mfd/mt6358-irq.c             | 236 +++++++++++++++++++++++++++++
>  drivers/mfd/mt6397-core.c            |  55 ++++++-
>  include/linux/mfd/mt6358/core.h      | 158 ++++++++++++++++++++
>  include/linux/mfd/mt6358/registers.h | 282 +++++++++++++++++++++++++++++++++++
>  include/linux/mfd/mt6397/core.h      |   3 +
>  6 files changed, 731 insertions(+), 5 deletions(-)
>  create mode 100644 drivers/mfd/mt6358-irq.c
>  create mode 100644 include/linux/mfd/mt6358/core.h
>  create mode 100644 include/linux/mfd/mt6358/registers.h
