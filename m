Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 395D2C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 07:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08AC9206E2
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 07:23:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ERVIiViD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730349AbgGHHXT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 03:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730190AbgGHHXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 03:23:19 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D430C08C5F5
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 00:23:18 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id y18so26248398lfh.11
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 00:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ols8fE88SOECty4ug3M3JHhI6m5+t3LRMsYguz2UCws=;
        b=ERVIiViD/iI07aPNMiZegbsH2kVCDifsiyM7h9FotGZUkC+BE9yb5iEpRWefKTJnkd
         jReQfyFSiRV8jK7vXeMOXJeEAOLJT48CLEv3e2jRwzs4+OeYlSQC0NYsZFlvbGBnrDmI
         XvAq1Puv9oLu2GH99BVBlWbMYhsa4sL/iKLN6isDfuXORZ1GIEzSjU57Wq09WZrx4U3Y
         y2LPZLVrbECvVf9m+MD7bkPcBzaVrGLesjJhBKT4/FAabPEfAgEU13B+zk4z0+8lUBnk
         rX2KJK3j1Dt4ttJR41YT2eellrR5IHkjJwEQm6an1VijL05wsIEpFXsancfjD4bYgLQ1
         mv+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ols8fE88SOECty4ug3M3JHhI6m5+t3LRMsYguz2UCws=;
        b=D94pl2WWsBojwm8eK/XyIBqCjKNrPYUBp++zg/i+XglpI+5HNc2cYgnvQcQUG59+ie
         eWYr1KJDu1PnO6USECFT+dQgsJL2WKEFzql5nGKTTZE/u5SKJBmE+asZIR6VR9fvKkUt
         I4fArL7TCWBB8liCivyVmRsdfbrIdpRRIKOSYKidGN1AQFtKIQPDbYAnjUAe7OSATNqA
         tM73IC6uctWflk3n98kBzViqs3O4eRPqJbg4HC8Z10gC9DxFrP/THWJTaNzhHTyhW8yu
         RWrSBHdG/psRZ8mMyXNT5CUP7XRjuAce8JI9vsKLUs2mQYFQ+dqqUNVBT77zmzB08xPv
         lguA==
X-Gm-Message-State: AOAM5310DBuhgBAGLVlk/KVMJNX5SPQnKXGgYYgGoIxHufC/CEhyWDgL
        HYvOmxPwIaH5u4UoReh1dQqt6wi9yui75aAOQ3sSyg==
X-Google-Smtp-Source: ABdhPJw7rifWiraCKDisMMtwfhzfhSSUEzk6UZkGaSDEQ9v2SD4J/7mMqL1Gdv/j4APtHu5Ifpwdpn20zoEoTGYflcU=
X-Received: by 2002:a19:e05d:: with SMTP id g29mr35015008lfj.217.1594192997140;
 Wed, 08 Jul 2020 00:23:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200630133345.2232932-1-lee.jones@linaro.org> <20200630133345.2232932-11-lee.jones@linaro.org>
In-Reply-To: <20200630133345.2232932-11-lee.jones@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 8 Jul 2020 09:23:06 +0200
Message-ID: <CACRpkdZWeJ=aVR7F2_aLYe-P7ZWGJkSQrcfVUL9vBf8C1nxWfw@mail.gmail.com>
Subject: Re: [PATCH 10/10] gpio: gpio-mlxbf2.c: Provide __releases()
 annotation to stop confusing Sparse
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Asmaa Mnebhi <Asmaa@mellanox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 30, 2020 at 3:34 PM Lee Jones <lee.jones@linaro.org> wrote:

> Sparse cannot peer into other functions to see when and if locks are
> acquired and released, thus it simply warns that a 'context imbalance'
> is detected instead.  Let's be kind to Sparse and let it know that
> this behaviour is intentional.
>
>  drivers/gpio/gpio-mlxbf2.c:125:12: warning: context imbalance in 'mlxbf2_gpio_lock_acquire' - different lock contexts for basic block
>  drivers/gpio/gpio-mlxbf2.c:151:13: warning: context imbalance in 'mlxbf2_gpio_lock_release' - unexpected unlock
>
> Cc: Asmaa Mnebhi <Asmaa@mellanox.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Patch applied!

Yours,
Linus Walleij
