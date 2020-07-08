Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E30C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 07:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF8DA20708
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 07:19:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VwpEs87i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730226AbgGHHTc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 03:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729972AbgGHHTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 03:19:31 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10CE6C061755
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 00:19:31 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id e8so18661477ljb.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 00:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LnT3eplntVSO3TnnKwfNokLnknmvXCFbv6W9zfuLUC0=;
        b=VwpEs87iiiMruiQ5/fxvjctR1D7yZnGtEa3Un/i7qCRT4L+wpDUWQGSSOS+D1+21/R
         VIufQny35zNcZ4zh6YQC6tyH6o1M0H4ebsGuPxBHjUGesgtvon3KpitKJu9Gb9O4N76/
         MP4UMllpNN47WlgN9Do5VRG/sztbWPnt/Gv3hjwaXXQDuYCXltZc0sfNi6jO6p7UuU5m
         cVTXFx4N5Mv8EVERaxNtyS6YvzPc57t0aAqkl13c0zvjE99vEccSfA9sXXwwpdVtbnPN
         f26ZXNkQjUdHGDa8ZU0aI1p1ErJuxSQu4DOYn7EffkUmZPCQKluVmbqdULmQgWi0HDu0
         118w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LnT3eplntVSO3TnnKwfNokLnknmvXCFbv6W9zfuLUC0=;
        b=ZfkFNsAB83FbZWVS8JOURb69k5rgRot5g9P5PIUpkDXkdiDJR/JA59EC0vG+rTQb/G
         hrPBwupMyM2OXUv0YLKtz0a7nj1c3GYOhQdzc5OoZRfZNBlW1LVAk52O5IkCt26dwULO
         ktKiDcY8aOcAkzBaIL33o/UezS9rOMieJC5VD6PhFez8425TXwI8MO+VWystNwyBiX1h
         RH743tv/XU2k8yp8/NzUvmp8OaXatLUfvqP/5z+f1YzQzRznPwW73F5mKsrcLQv49LIh
         IU7OjjAM3PJrvrDmYT6r/vVPfgb/7ttMBCQ3lKKrFcU8zEo7HC+QTzXnZYVxsVDNqCio
         0qdA==
X-Gm-Message-State: AOAM5329h89YgBqQt76zCiyvvayq1dcSNs4pMo4SljAhW6lQYeohmLRm
        S9tL+FYHLQYfpEHxtuvMMHBDfCMwcA2YhDsFuq/S/A==
X-Google-Smtp-Source: ABdhPJxlzaPzh7OZySnwtS2i+Y3my8fK+xpWXozFM6l6b8JYiDjlQi/s6JbdvsOKAAhxInlnD6DMbCxjZCPvl3UVXsg=
X-Received: by 2002:a2e:8046:: with SMTP id p6mr18621360ljg.100.1594192769561;
 Wed, 08 Jul 2020 00:19:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200630133345.2232932-1-lee.jones@linaro.org> <20200630133345.2232932-8-lee.jones@linaro.org>
In-Reply-To: <20200630133345.2232932-8-lee.jones@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 8 Jul 2020 09:19:18 +0200
Message-ID: <CACRpkdZW9GDcmEwsb8KOCrH9s6JJEAX_2=Qhw1h4bkcogiygaA@mail.gmail.com>
Subject: Re: [PATCH 07/10] gpio: gpio-it87: Fix formatting issues which
 confuse kerneldoc
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        =?UTF-8?Q?Diego_Elio_Petten=C3=B2?= <flameeyes@flameeyes.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 30, 2020 at 3:33 PM Lee Jones <lee.jones@linaro.org> wrote:

> Kerneldoc expects struct properties to be documented using the syntax
> '@.*: ', but no ':' has been provided in 'struct it87_gpio's
> header.  Add them to stop confusing kerneldoc.
>
> Fixes the following W=3D1 warnings:
>
>  drivers/gpio/gpio-it87.c:69: warning: Function parameter or member 'chip=
' not described in 'it87_gpio'
>  drivers/gpio/gpio-it87.c:69: warning: Function parameter or member 'lock=
' not described in 'it87_gpio'
>  drivers/gpio/gpio-it87.c:69: warning: Function parameter or member 'io_b=
ase' not described in 'it87_gpio'
>  drivers/gpio/gpio-it87.c:69: warning: Function parameter or member 'io_s=
ize' not described in 'it87_gpio'
>  drivers/gpio/gpio-it87.c:69: warning: Function parameter or member 'outp=
ut_base' not described in 'it87_gpio'
>  drivers/gpio/gpio-it87.c:69: warning: Function parameter or member 'simp=
le_base' not described in 'it87_gpio'
>  drivers/gpio/gpio-it87.c:69: warning: Function parameter or member 'simp=
le_size' not described in 'it87_gpio'
>
> Cc: "Diego Elio Petten=C3=B2" <flameeyes@flameeyes.eu>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Patch applied!

Yours,
Linus Walleij
