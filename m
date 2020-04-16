Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37EF0C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 13:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F18421BE5
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 13:22:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="J5nuE74u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895188AbgDPNWV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 09:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2895064AbgDPNV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:21:57 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C36BCC061A0F
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 06:21:56 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id q31so1932577qvf.11
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 06:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=avRb3vLQGDTEWZLFL5bXMrEXh+qhpxFWoqH669TEkSU=;
        b=J5nuE74uERUTtbCQhaVb6lN2px7tBz8nBjdjaloWli9LlHu86qVRpxY/XKDMJdmjzG
         BeSYOHoRovGTYnDivdxWRpzCmemE0pWWE+2H9dPutd9ZypvWa3HQNBMY0HQAgcUf/t5V
         /w5JBp99Bjfo0qsf6b45nXUuz4iCaJSrV7u7yqck4690fCBJwt1Iqxsnuz+qTGMtzoIx
         6djHp0kOGO/Z0KcGacj1hcSg892w9wkl+SS+Wgmt0AwNhbiia5M4d8itueuP4UAbIxcu
         fxIYS3tOhzeIzfdjerKNpK7W9BXiB4bc8hwDndGYyCYxVjJ6PmBlfZBCd+L0pt4TaKU2
         Ni0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=avRb3vLQGDTEWZLFL5bXMrEXh+qhpxFWoqH669TEkSU=;
        b=VSbLAxGlPqxeuAEnNWRk5LRz4uY/fw3UJtexUdZQJe9sCO9aLk0aDcF7me+un30tfH
         L3v3S18+3y5kCwbIXy3WhLY+zj7/Fx20fSzAdJbo4MsFfCkOnLVrkOF/6bSYMwFx6GL7
         SfD0cwAmspKQNhwVhmhWYnkg6Nfx11z4p5I4QwSB47jGY/cWQQtp0DIx2UKnyt38PljZ
         3IN9H4R7SKiPj5nSM5UCPXE9ur/0c93X19iWYhQeo/E+D8T6FzCCuuD3FRb/xx8PJGga
         rrer6VhrLSYQrqVj5t0q//PXduDB5mkdmAQ+GS+sJpCM0JwkjSaYqzAZClyDTe0/YEDX
         tORw==
X-Gm-Message-State: AGi0PuazuKbm1utW6aG5dA3ol7zbhDJHmMONrDCe5WJ6RjITjre8Sp5Y
        w9itJwUEJ6EXlkSh/Qb8IiuhVib8skO5OfsILuDsaQ==
X-Google-Smtp-Source: APiQypJWh/fFacLzkG78hbwLnxl5+BCUaI/XcNkBeTLfNrmfcZs6wqz1Gez3UoQW17XmSn3R7x9XVhg78QA48w/zWvQ=
X-Received: by 2002:ad4:4951:: with SMTP id o17mr9910253qvy.76.1587043315884;
 Thu, 16 Apr 2020 06:21:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200414152843.32129-1-pthomas8589@gmail.com> <CACRpkdaPc-rxNmdq7KFKZ-Qi7Tqy2RJ5Lkcv-8bTAh0GX7VygQ@mail.gmail.com>
In-Reply-To: <CACRpkdaPc-rxNmdq7KFKZ-Qi7Tqy2RJ5Lkcv-8bTAh0GX7VygQ@mail.gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Thu, 16 Apr 2020 15:21:44 +0200
Message-ID: <CAMpxmJWZEhKho0+6zf=Ca8tif=Z7PcdNv2=tAsDnOUzeZLYqLg@mail.gmail.com>
Subject: Re: [PATCH v2] gpio: gpio-pca953x, Add get_multiple function
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Paul Thomas <pthomas8589@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

czw., 16 kwi 2020 o 13:22 Linus Walleij <linus.walleij@linaro.org> napisa=
=C5=82(a):
>
> On Tue, Apr 14, 2020 at 5:30 PM Paul Thomas <pthomas8589@gmail.com> wrote=
:
>
> > Implement a get_multiple function for gpio-pca953x. If a driver
> > leaves get_multiple unimplemented then gpio_chip_get_multiple()
> > in gpiolib.c takes care of it by calling chip->get() as needed.
> > For i2c chips this is very inefficient. For example if you do an
> > 8-bit read then instead of a single i2c transaction there are
> > 8 transactions reading the same byte!
> >
> > This has been tested with max7312 chips on a 5.2 kernel.
> >
> > Signed-off-by: Paul Thomas <pthomas8589@gmail.com>
> > ---
> >  changes from v1: rebased to 5.7-rc1
>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>
> Since I know Bartosz is queueing other patches for this driver I
> let him pick it up.
>
> Yours,
> Linus Walleij

Patch applied. I removed the last line of the commit message since I
guess you did test it on v5.7-rc1 after all?

Bart
