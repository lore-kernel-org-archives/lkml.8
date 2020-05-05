Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1EE5C47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 16:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8219D20735
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 16:24:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="sUkReXun"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730427AbgEEQYH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 12:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728807AbgEEQYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 12:24:07 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 054CAC061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 09:24:07 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id b188so2871932qkd.9
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 09:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=URyHbD0b6VvGXIAxJMtFkLfSxA+pJ99LyvYiCEW+Gvw=;
        b=sUkReXunZvh2bYEUD2/LaykRe129h0P5H5gZUPSANBLDCWkmySs2Uo73yXHbIDLFih
         zEuOip4QQWVXcz2XFh5Wi0n9wps37xfAWgzKCxEcWaqkqJu8X7RbML/jyquRs2uaZHZ2
         Tg64yy96y/vvenBNLjcYjRZojl4bWo/RIiYdFdQtfsBtf7hjSsC1c8+tRPLFQpCLnnZv
         /o3L9XxkrYoHT6UiA4+FiFHXYMGdn6ycRgUD+mWfnCy2Z6UZWxdlAhj9m1Xp3nJ5TLLj
         eYVwzrEfhT4AZHPwUPPUz0AReVA7E4q1NlOiSg8pl6a5hteljqLUpMb9AZDF8zAkQ226
         LQ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=URyHbD0b6VvGXIAxJMtFkLfSxA+pJ99LyvYiCEW+Gvw=;
        b=HRLI2oTBbQMpFFnFq+7kBRBJcpiLLuw0Ejggs2m02wTb4Wy2RwCi+85Pub4oy4sSxG
         g01EfZv6Ji7t+XnOhDIRttpAUx1CcBRhsyAjWyvgvTwht47EErN4bvW+/o9t/CqCwUqE
         +nWwFkTP4UvstJxkKrJ1DrsDm/2r4c8xeRKRX7c/aeRNvPsMFoV2aY7CwyY2/eS9O6ZW
         2LFfIA0OV7k2810DvtY41dW+3VaIR5FqjqsTlNnfTxroveuWYVx+oUGCAyKcKp9fHp/X
         YS/ZHjxYBQhbEn1RbmMAkDPVPluIRf6wCXbaS5xiIIGD5R+Y0xzyIjI5ArfbjZCJpYyX
         eXTg==
X-Gm-Message-State: AGi0PuaSNb5ZQ2SirKdarIl5TfY2CR8oCU3ramrrBhgWuFrNpIiORh7P
        7CCXXDMnQbx5vLae/Wgl5HWGvZmSb1D5m5X5kazopzzl
X-Google-Smtp-Source: APiQypKmH4QXCDccUEG7B64ooa0b5Bx+mw9OszfIv/3xB2iMzegem6Yn83znXSgFEK56y6AoEaM733iPBrf93ND74Fo=
X-Received: by 2002:a05:620a:1395:: with SMTP id k21mr4338823qki.120.1588695846247;
 Tue, 05 May 2020 09:24:06 -0700 (PDT)
MIME-Version: 1.0
References: <4340a212-89f5-8c62-db61-f061e494d6b1@kiho.fi>
In-Reply-To: <4340a212-89f5-8c62-db61-f061e494d6b1@kiho.fi>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Tue, 5 May 2020 18:23:55 +0200
Message-ID: <CAMpxmJWytUARKF_2N4vkUcFbX7P6Lf=oaRYOn8BP_b3eKrEp9A@mail.gmail.com>
Subject: Re: [PATCH] gpio-f7188x: Add GPIO support for F81865
To:     Petteri Jokinen <petteri@kiho.fi>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sob., 2 maj 2020 o 19:22 Petteri Jokinen <petteri@kiho.fi> napisa=C5=82(a):
>
> Add GPIO support for Fintek F81865 chip.
>
> Datasheet: http://www.hardwaresecrets.com/datasheets/F81865_V028P.pdf
>
> Signed-off-by: Petteri Jokinen <petteri@kiho.fi>

Patch applied, thanks!

Bart
