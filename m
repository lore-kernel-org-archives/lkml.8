Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1BDCC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 07:18:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E5B320771
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 07:18:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hbhaqiwe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730205AbgGHHSn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 03:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730196AbgGHHSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 03:18:42 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA943C08C5DC
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 00:18:41 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id z24so28042339ljn.8
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 00:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zIm1nTTtroh3jSlQCc4nRT6z0BXJtM8UPxEVaJ3cdLQ=;
        b=HbhaqiwehhVEfm4RXj6ezjnjj3skiTF36bLdw0wq3Js0HZ+q47/PQ19bQ9it3Le/ZO
         kIisM0AyOOAEQMiohpkCTxaAPUL6Dz7zw0xGdJI2gYf+Dy/iLT6rh7HerQ5uaLNAgVfI
         e69jZzP4+X27rz0je+uDqsReALXKWsHYDVlsVj4cL8RkVMj1rYFxQ0auzpTj5hj22uD8
         bP4v673Ap9IfGu4wfv8KKuPbOG7KxTOtCt5/2EtRVTupKNy9Cve6LnGGtS/A6a9hCqkx
         KbhZ55JRq3es6MI/n87mmUjLM53ZKQSENEioEIUNtk2K8ZaskCuKtvMfqFxLAprDv5k8
         aM0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zIm1nTTtroh3jSlQCc4nRT6z0BXJtM8UPxEVaJ3cdLQ=;
        b=UmG+nmiOAeLEvelYzV7pVOYqIFuJ17uITy7j5Zda4RwVXyC9sAzyBg/Yh7XdjSh74r
         /raNycvdog/WEIQhWm429AVZzpZT9rJhjmKmQQ71DwGV7N+gFA+S0sD/4tY/2/sHiznA
         RDwKL8I3Y49jYv1sQrroK9/LQMAc9wsnesCXHjm1lWRgPDyeefkYo/8SuoAwIRmXSR8a
         uK65GmfnLLjLk/d/fS8UUBpAJR6f3cGrkPLNLGL/2XrZKLlOSHjXzRkgVAO0XE4+ElET
         Ty1dcC4hBoNzbiImjcZ8wPEjyffXx4OW8ofLffPJSM6tttH+s13Cmt76tUUdxTGdG/gz
         iUhw==
X-Gm-Message-State: AOAM531rgAEwAem+csFskl2EB0tuxr+JR72HNUuH5M7oWaBAdm1hDxqo
        F3d53RLlDl+AdjSoJGpM8TFwuwY503oG5mqPfjTM1g==
X-Google-Smtp-Source: ABdhPJxeR9wevkAjhUg6iANqN39oApGw6BnyXI8B+rYDzmMCbtxZ9tcyP9q2LYQH3/SAsU5Fp4RtftyI9ozwwBiT/ws=
X-Received: by 2002:a2e:810a:: with SMTP id d10mr26812174ljg.144.1594192720209;
 Wed, 08 Jul 2020 00:18:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200630133345.2232932-1-lee.jones@linaro.org> <20200630133345.2232932-7-lee.jones@linaro.org>
In-Reply-To: <20200630133345.2232932-7-lee.jones@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 8 Jul 2020 09:18:29 +0200
Message-ID: <CACRpkdbszVdmRY4V=Z=vVPAdbx4q=26F-OcnZu2w3-BNk+0ohQ@mail.gmail.com>
Subject: Re: [PATCH 06/10] gpio: gpio-syscon: Fix formatting issues which
 confuse kerneldoc
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Alexander Shiyan <shc_work@mail.ru>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 30, 2020 at 3:33 PM Lee Jones <lee.jones@linaro.org> wrote:

> Kerneldoc expects struct properties to be documented using the syntax
> '@.*: ', but no '@' has been provided in 'struct syscon_gpio_data's
> header.  Add them to stop confusing kerneldoc.
>
> Fixes the following W=1 warnings:
>
>  drivers/gpio/gpio-syscon.c:48: warning: Function parameter or member 'compatible' not described in 'syscon_gpio_data'
>  drivers/gpio/gpio-syscon.c:48: warning: Function parameter or member 'flags' not described in 'syscon_gpio_data'
>  drivers/gpio/gpio-syscon.c:48: warning: Function parameter or member 'bit_count' not described in 'syscon_gpio_data'
>  drivers/gpio/gpio-syscon.c:48: warning: Function parameter or member 'dat_bit_offset' not described in 'syscon_gpio_data'
>  drivers/gpio/gpio-syscon.c:48: warning: Function parameter or member 'dir_bit_offset' not described in 'syscon_gpio_data'
>  drivers/gpio/gpio-syscon.c:48: warning: Function parameter or member 'set' not described in 'syscon_gpio_data'
>
> Cc: Alexander Shiyan <shc_work@mail.ru>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Patch applied!

Yours,
Linus Walleij
