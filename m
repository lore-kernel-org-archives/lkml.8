Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75EE9C33CB2
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 09:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4303D20705
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 09:33:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZFGCWzJ7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbgAaJdO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 04:33:14 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:37254 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728224AbgAaJdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 04:33:14 -0500
Received: by mail-qk1-f194.google.com with SMTP id 21so5898109qky.4
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jan 2020 01:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ggsk5m45Iq08tg/59tBeb3ygmKhNUeTQE+tA0pzhyiw=;
        b=ZFGCWzJ7yVOPdjPtgKOY907nKKiLS+bH1Kr8qfbdkHg+QrxONQ+w+kryugi0Mxma0p
         zDMmW4LplAKzS6hrUBOcDqHOLYcFX1h3kRw1qwTc006sPGJ5lWSZiOShszzD2p/nSkz1
         rcIBTc+RUcNztdkq8dE36MG0obqTOfh+ekngGpWAAjlws7AiK/tNwCtouWJ5VvfK9Kl9
         l1b18PuZy8Kfg/d67ZwRM/ZU2zWDI1yrIzmejZQWE/lauphgDNhAWzee8mC9ZWAoZpl5
         eEU2x9TT3E59iR92P/EAofOV5eNkXJPf05sPW1aOHX1TViJ4IL+q3Zu/xTASPTPgSCQb
         mUEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ggsk5m45Iq08tg/59tBeb3ygmKhNUeTQE+tA0pzhyiw=;
        b=IpNhGb6PHZNPNOJBoPM1Ij35nqPcay6dlkwKVTWDcgvOVAaDXcZcOynPjgPjbM6DYo
         4OCMz28uIm1YdNcnzKtC835mqkhsqG194FseFLmQlRKt7qH73yDfE3yhKJWSzE2lkCCL
         wHhMBu6FGGjEhvdn2m2+LiC1LPez6j3jnoCqBRBMKV4gtX8mD98FBpqGweMQ+IHMAEqi
         8Q7g/J8Os73woxyHOlKGg3WqbkV+gzfcMo/DHOylEpTXkfGjRouNnCK4XJmqJx0pC2vB
         vyYngJEO7J4whT28nBTaJn2OYGLpYOxmgv9nG4AH6dUrJ7oyBAXLYQsodOkIGAAW83Rn
         a6xA==
X-Gm-Message-State: APjAAAXyCcv77CR2bYFnZ1U2jEGHyuoTrPG335FNCibZWPtdVr3kLiSU
        z4vxVoGCjOjAvQlk9xI4wDC3OVjcMVdTNOrOxxk=
X-Google-Smtp-Source: APXvYqwuYkBYnJ/WUUkF3xiv2NRSJ4vRVBXiZiAuilsH3jvhx1xgeQtOoBSOwL1k1h8jgaN45FLoBPVHKdSEW57E8gY=
X-Received: by 2002:a05:620a:139b:: with SMTP id k27mr9708402qki.112.1580463191671;
 Fri, 31 Jan 2020 01:33:11 -0800 (PST)
MIME-Version: 1.0
References: <20200130192024.2516-1-krzk@kernel.org>
In-Reply-To: <20200130192024.2516-1-krzk@kernel.org>
From:   Greentime Hu <green.hu@gmail.com>
Date:   Fri, 31 Jan 2020 17:32:34 +0800
Message-ID: <CAEbi=3eb+UsNz4V-yCWYn4AB96XiVWTrUBnTNthbJ0xeGWiAEw@mail.gmail.com>
Subject: Re: [PATCH] nds32: configs: Cleanup CONFIG_CROSS_COMPILE
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Nick Hu <nickhu@andestech.com>, Vincent Chen <deanbo422@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Kozlowski <krzk@kernel.org> =E6=96=BC 2020=E5=B9=B41=E6=9C=8831=
=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8A=E5=8D=883:20=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> CONFIG_CROSS_COMPILE is gone since commit f1089c92da79 ("kbuild: remove
> CONFIG_CROSS_COMPILE support").
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  arch/nds32/configs/defconfig | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/nds32/configs/defconfig b/arch/nds32/configs/defconfig
> index 40313a635075..f9a89cf00aa6 100644
> --- a/arch/nds32/configs/defconfig
> +++ b/arch/nds32/configs/defconfig
> @@ -1,4 +1,3 @@
> -CONFIG_CROSS_COMPILE=3D"nds32le-linux-"
>  CONFIG_SYSVIPC=3Dy
>  CONFIG_POSIX_MQUEUE=3Dy
>  CONFIG_HIGH_RES_TIMERS=3Dy
> --
> 2.17.1
>
Thank you, Kozlowski.

Let me know if you like to put in your tree or nds32's.
Acked-by: Greentime Hu <green.hu@gmail.com>
