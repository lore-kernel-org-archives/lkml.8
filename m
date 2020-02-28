Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE29CC3F2CD
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 13:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB031246B5
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 13:16:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HxJHR12d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbgB1NQy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 08:16:54 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34865 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbgB1NQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 08:16:53 -0500
Received: by mail-lf1-f67.google.com with SMTP id z9so2097454lfa.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 05:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d2j+xwWiY9wlH7AtLJK3OvsykaZ/u5FJZyPROvoiy1g=;
        b=HxJHR12dqabYx6zhDgCZD/hJGDITKwemITUtUDZOyk/Yt7H+qaUfjQtBS/a0AHDTzC
         F9AA33/VUSLG5pULibxByHL4WExkcYA0R5mgTQdjitbAuZ9jivnhui2PTI5d8OFXXBIw
         Sd5Jh0q+CFejsuT54GGnaxVCFCg+fZT38NtsU6g9igX2qJOGrGmMXLehFdtxjurISOhD
         rG5lk92ewSrN83PbluJZfi41RM+GlMWm7cgd5Oc5Rcgx01IwMZr2N30HPz8lo7WOgnqd
         Lx80wMZIZEe9EbHWposU9rNFo4LVI1unkD5T8Pc46K0n+6N5p1DZHyP88AlSVmmYW7pW
         ZSgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d2j+xwWiY9wlH7AtLJK3OvsykaZ/u5FJZyPROvoiy1g=;
        b=PkDhtWeYmekLK/zQCSPIt7c+gjxs6MBmBAVJc46yWJdMaPLWrvgP6m81wlk4DgP0vE
         4ZcB/ak9SsMuuKeu68uhmi6JoR3h/mjMh5v8TiK4y7WOaf8KWe0dBrrMJz/D+TnFhkYF
         QfToNBSieDDLVljUqGwUiQBa8xBpgiVnNbGwx2+f6RZSe3V3TfVdkpiErQvkjvYXQGpQ
         G1O1Kw9RzRb2/Yf3JxQvb8wnPWs16CRP0RTSTA/GSasF/qClWOQose8LT4dYng0wm6JN
         IIiOmt3ukABDT19C3bAk8shkoDDQ8ZrZhhn8Nl3cFvZDwjjiKmkyCTP0WgMxXAwj8jSt
         28lA==
X-Gm-Message-State: ANhLgQ3efLoVbweGpGNl2S1zdR3kLz/GQdpDaWM1xuGmJ31l/rvVNauN
        nBz8erpwmN22i2cetwuYnxR2kDDmXwlzBYjaEfeLcg==
X-Google-Smtp-Source: ADFU+vsgVdf5ixS/e74l5Eg9jm2LlOCk+LwWAKinRI2yuiFWgmTOny7+7QQPst2uBqeBcz3Eq8WslUWOUECUikODDqA=
X-Received: by 2002:ac2:5328:: with SMTP id f8mr2636959lfh.47.1582895810190;
 Fri, 28 Feb 2020 05:16:50 -0800 (PST)
MIME-Version: 1.0
References: <20200228040047.14808-1-yuehaibing@huawei.com> <20200228063429.47528-1-yuehaibing@huawei.com>
In-Reply-To: <20200228063429.47528-1-yuehaibing@huawei.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 28 Feb 2020 14:16:39 +0100
Message-ID: <CACRpkda3=z80WY_W3EN=tiYruYfGjxPAHYjBALNj39kqDtjkzA@mail.gmail.com>
Subject: Re: [PATCH v2 -next] pinctrl: da9062: Fix error gpiolib.h path
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Support Opensource <support.opensource@diasemi.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2020 at 7:35 AM YueHaibing <yuehaibing@huawei.com> wrote:

> gcc 7.4.0 build fails:
>
> drivers/pinctrl/pinctrl-da9062.c:28:10: fatal error: ../gpio/gpiolib.h: No such file or directory
>  #include <../gpio/gpiolib.h>
>           ^~~~~~~~~~~~~~~~~~~
>
> Fix this wrong include path.
>
> Fixes: 56cc3af4e8c8 ("pinctrl: da9062: add driver support")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
> v2: Fix wrong path

Good catch!

Patch applied with Marco's ACK.

Yours,
Linus Walleij
