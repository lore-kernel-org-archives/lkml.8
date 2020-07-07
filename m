Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7165C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 12:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0865206DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 12:22:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e2w+qLHC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbgGGMWe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 08:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727876AbgGGMWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 08:22:33 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49CA1C08C5E1
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 05:22:33 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id m26so24577446lfo.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 05:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8FZ6b+u5hIehEVHEyIzeSnPbhkCZR5qqkr1GS1FN368=;
        b=e2w+qLHC9gUCkhrQmqzM7pcqL4MQF71oL5qMBHAX5ratJP+59bnK/pgD0OdRSrPwW4
         7AOOLfsDr8mOOOi93MQ+vsZFEu5FSmXA3X7gbTIqw09NU8BtkIbifam82tZoVsNCsZ3g
         v/+EhHRjDh0T2V9z4AqrYYUyWORI6uz3ODSOOjD++nnw3LCH1w63npSnX/+atmBAqEbJ
         1reFAxRm1wH47R+DfUTQnWjdP0UirIikXXNbpKsOmdE5V87NQp4Y0BawMh5zHD6upwnN
         slGc2HIP4lZgUWLI5a95vK+Ea5VN3Z8jMI91hxy2apPtqQxu2G3OC5XpaeQa7vkNbVKn
         gr2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8FZ6b+u5hIehEVHEyIzeSnPbhkCZR5qqkr1GS1FN368=;
        b=b1PSQEV7RW8Fw1PfyTBwMravOSuDz6ktXhgieKnHitbWt/9YEwYHi/c/EjvmmR5Egp
         YP3buOCKgKNmuPsSJcsLHyEfzTVWYggjfilV/HQfdV5QXGsRTz53zxxFi1+dcz99aiuV
         x3pLgSzXi6UPmjIWjhN0FptTrsiO94OT2PVbl/9wtbT4RbVJUBiTtncu0LwiyrdraeVR
         pu7uBmEyGmxgaPesDKryEjcWWrKdd88JU4+NtA8KC8Hj164n/qvw6uvV5Un3EWwX0Ogj
         2WFcj0BPOvW6f301bTn5HOqrAasBbFB/pIdA9dmn/z81sPHsufmRCNXZ8t7bHeyJkf26
         LfUA==
X-Gm-Message-State: AOAM531vfMJHMdMz2dTykWHdmSjMZgY4qhuzXHXjntuB1aeWLlzVvMPs
        eNObFzEzNbZDdH9adegNAxK79Y/7xubXhyfMYds8Kw==
X-Google-Smtp-Source: ABdhPJy10kov8+Mkmk61f0WKp6Ld4d65E/TrwXZO1pVb4/ph9AvFTgkedwG7sd7BumQWUfn2llEmg5uClQm94RJryQ0=
X-Received: by 2002:a19:f20a:: with SMTP id q10mr33221646lfh.89.1594124551643;
 Tue, 07 Jul 2020 05:22:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200622214548.265417-1-paul@crapouillou.net>
In-Reply-To: <20200622214548.265417-1-paul@crapouillou.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 7 Jul 2020 14:22:21 +0200
Message-ID: <CACRpkdbb3RCuu52kyzWZr+mDaWrcP5_CTfEp4aN+GddOKxDcOA@mail.gmail.com>
Subject: Re: [PATCH 1/2] pinctrl: ingenic: Enhance support for IRQ_TYPE_EDGE_BOTH
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     od@zcrc.me,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        =?UTF-8?Q?Jo=C3=A3o_Henrique?= <johnnyonflame@hotmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 11:46 PM Paul Cercueil <paul@crapouillou.net> wrote=
:

> Ingenic SoCs don't natively support registering an interrupt for both
> rising and falling edges. This has to be emulated in software.
>
> Until now, this was emulated by switching back and forth between
> IRQ_TYPE_EDGE_RISING and IRQ_TYPE_EDGE_FALLING according to the level of
> the GPIO. While this worked most of the time, when used with GPIOs that
> need debouncing, some events would be lost. For instance, between the
> time a falling-edge interrupt happens and the interrupt handler
> configures the hardware for rising-edge, the level of the pin may have
> already risen, and the rising-edge event is lost.
>
> To address that issue, instead of switching back and forth between
> IRQ_TYPE_EDGE_RISING and IRQ_TYPE_EDGE_FALLING, we now switch back and
> forth between IRQ_TYPE_LEVEL_LOW and IRQ_TYPE_LEVEL_HIGH. Since we
> always switch in the interrupt handler, they actually permit to detect
> level changes. In the example above, if the pin level rises before
> switching the IRQ type from IRQ_TYPE_LEVEL_LOW to IRQ_TYPE_LEVEL_HIGH,
> a new interrupt will raise as soon as the handler exits, and the
> rising-edge event will be properly detected.
>
> Cc: stable@vger.kernel.org
> Fixes: e72394e2ea19 ("pinctrl: ingenic: Merge GPIO functionality")
> Reported-by: Jo=C3=A3o Henrique <johnnyonflame@hotmail.com>
> Tested-by: Jo=C3=A3o Henrique <johnnyonflame@hotmail.com>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

I have applied these two as non-urgent fixes for v5.9.

Are they urgent?
Are they causing regressions?
Tell me if they need to be merged to v5.8-rcs.

Yours,
Linus Walleij
