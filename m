Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72ACBC54E8B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 13:11:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4480D206CC
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 13:11:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XXYe6w33"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729889AbgELNLT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 09:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726891AbgELNLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 09:11:19 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 020B0C061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 06:11:17 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id u15so13583197ljd.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 06:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fNfgxj6D87Y6aWL+yxcHi3/ZDBy+NqsDMh/WXoRdX1U=;
        b=XXYe6w33B97BoR/z6hG5JEkETOvNGNMrZV96hfo5kh1O8zhaVuGYzOPweM95vq0kjU
         57EFOdkvWl3WAQHXg6Q3o4JWFKEZSbnpmV/bqR9djJc6ms9oMHzk5NXs7kURhR8pGUq0
         RBLUP8xcQSN69u+il8uS+gDxeN99P9wC428Q4zyI+v5miNcPdGXE3x03jXF0iWESZJc/
         QP7APn9LIfbzIqgsFhVNU/CbuytCzkybv5IBz9YA7Ig9LIpwkYfGo2cnUmS5zhHj1vse
         QuhgnzamTqzY9r93jiDGKGasVJQBKPE4HMO+FM9bR/8XVlpKeaTTdLFF+hB9mmHt4OUL
         iKNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fNfgxj6D87Y6aWL+yxcHi3/ZDBy+NqsDMh/WXoRdX1U=;
        b=SS8SBlHX4svF5s/CmSosd9Nx9YEDH0e4AqEW1R50vFQcey1UxwEUMkrLEIIJRktHnC
         ARlc4mJCo2+YVCWwMXG9xNi7I6JgTeU7mSPVasV2SjL45cZkxzYXdcFpuq+qseHX53Ij
         pM2WXAurF5PxqSClqMo/pihJuEFtcLVAzeJXFCaQA+teSbQibpfmieZ/hSgIDlqBatg5
         7vlB2JfM1N0+86H5TKy92c9mfqVEQTr2x8sZPbBrIAXLdK4LgC0w3jtsRujen0lc9voL
         vras9QW6MaZDjwQCw2pCdfJK9qPzd23R6/J5n7YgAym+5PipcnZnsADAERG5UjuK1Ttj
         EbUw==
X-Gm-Message-State: AOAM5301HkLYcL1MhH5Yd2fkZheU1hWe5lLScXjXCddPgVARageHzNpb
        Mv1SEDJqh/fOt8jwyyS80Dk5w5BfcIJvGG61pM2y+Q==
X-Google-Smtp-Source: ABdhPJyseI75vZ2crF7NrcrcTQnpEY6FN7zltnf0g/qE5/ZQT6YyGMv6RCtLFh0M/N1vs0bqqMnH4EcVGx1QC2FlSGw=
X-Received: by 2002:a2e:8087:: with SMTP id i7mr12781831ljg.99.1589289076229;
 Tue, 12 May 2020 06:11:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200505140848.554957-1-arnd@arndb.de>
In-Reply-To: <20200505140848.554957-1-arnd@arndb.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 12 May 2020 15:11:05 +0200
Message-ID: <CACRpkdZCVY6ph5WH+fUdbuc4yzEGkmDmUZ7L9HFHffB=73Cc+Q@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: mediatek: add pinctrl-mtk-common-v2 module license
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Sean Wang <sean.wang@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Light Hsieh <light.hsieh@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        YueHaibing <yuehaibing@huawei.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 5, 2020 at 4:08 PM Arnd Bergmann <arnd@arndb.de> wrote:

> Kbuild warns when this file is built as a loadable module:
>
> WARNING: modpost: missing MODULE_LICENSE() in drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.o
> see include/linux/module.h for more information
>
> Add the missing license/author/description tags.
>
> Fixes: 8174a8512e3e ("pinctrl: mediatek: make MediaTek pinctrl v2 driver ready for buidling loadable module")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Patch applied.

Yours,
Linus Walleij
