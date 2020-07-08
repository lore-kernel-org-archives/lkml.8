Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39695C433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 07:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1178D20760
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 07:15:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pNTkKnbb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729923AbgGHHPO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 03:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729740AbgGHHPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 03:15:13 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37635C061755
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 00:15:13 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id f5so37071822ljj.10
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 00:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XRilmb1Jngnk7k/9K5uAaSX/0kCWr8sNf6kcRHVMY8w=;
        b=pNTkKnbb3hm+A+HQN5rOzozN/kmm1vVVSMgCB0LBOI8R1nunHbWZwUEelAOtheH0GO
         wO9AabHTuWsSBZT8qzYUHWZuSppM3d3h//+tF8HbkX7cOcVKJ2+Ey98jOPgRmMqHt/vu
         4O1LSHNgxdIxTbmQRRpInCaRmZCJ+fTbaJSIJ7KuDK+Ay/NvlJtdK4rcbkmhHF1COedM
         YGrkeGmvEEDEwRrXDB8bh152Vv9mLFwWrVMhObHQQnGIrEmx20tA5aiyFWT0YP66APeE
         vQ6d9VW4N0kft+tfC+ZUyoSW0HkLv9E0Y8RkFioicZhrfo/a+kNPCjn+PFvhBzFbSjRI
         817g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XRilmb1Jngnk7k/9K5uAaSX/0kCWr8sNf6kcRHVMY8w=;
        b=XGowUVcuQmB8drL1Ngr3e2mtc63UfsumvGsN9PvZUEnB1YebKuCZpnVJ7lHOfjfc8t
         ZBSgtbgPCiX3+szglRirZIA7+9Q8bj4HzaQEvUP5C6KhR6kt8SHN6dcVgWQXPJCeq8U/
         1RBYCdkSXt2U7Cl5pgUFTDboaItVeHgncsRIVm03E46pcTXctIcIRILM/pJ1Eezp97ZN
         S55q6tywkwCWBI9yHyDPa1UAh79b4WvJwZX4gw10NbCk47KX17bgtCadhI5JvFo7/Pqs
         DX2NJ0ZEjxEL0wl7nfeSYiRVvUd4x5/86FSnpk3e2GQZrA9UQlas7hWhLlCDN3MFNhUN
         38eg==
X-Gm-Message-State: AOAM531EoQI7LrwtER2vR2MrVD+hY9tw+YeZ31267t8FwNNGAfZ0WeMV
        IjnCY9KrXQySqwxn32/ic89gXB5mT8DHjpAoPZKeSQ==
X-Google-Smtp-Source: ABdhPJz3MZXHxkiizN62clTohAU0g4h+DH6Xo1PXwi1CusMZHaGTT7dQWRauM5eiBDYVxbBHJhKYbKpNH502nmMeHHI=
X-Received: by 2002:a2e:9a4d:: with SMTP id k13mr11201719ljj.283.1594192511738;
 Wed, 08 Jul 2020 00:15:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200630133345.2232932-1-lee.jones@linaro.org> <20200630133345.2232932-3-lee.jones@linaro.org>
In-Reply-To: <20200630133345.2232932-3-lee.jones@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 8 Jul 2020 09:15:01 +0200
Message-ID: <CACRpkdZ-0L=ONVbneB5pUoDkwS0btT2FnnDWc7YL0LsZj4fhWw@mail.gmail.com>
Subject: Re: [PATCH 02/10] gpio: gpio-altera: Add missing kerneldoc entry and
 demote comment
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Joyce Ooi <joyce.ooi@intel.com>,
        Tien Hock Loh <thloh@altera.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 30, 2020 at 3:33 PM Lee Jones <lee.jones@linaro.org> wrote:

> 'struct altera_gpio_chip's 'irq_chip' property is undocumented.  So
> add property description to the struct's kerneldoc header.  Also
> demote comment block which is clearly not in kerneldoc format.
>
> Fixes the following W=1 warnings:
>
>  drivers/gpio/gpio-altera.c:34: warning: Function parameter or member 'irq_chip' not described in 'altera_gpio_chip'
>  drivers/gpio/gpio-altera.c:78: warning: Function parameter or member 'd' not described in 'altera_gpio_irq_set_type'
>  drivers/gpio/gpio-altera.c:78: warning: Function parameter or member 'type' not described in 'altera_gpio_irq_set_type'
>
> Cc: Joyce Ooi <joyce.ooi@intel.com>
> Cc: Tien Hock Loh <thloh@altera.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Patch applied!

Yours,
Linus Walleij
