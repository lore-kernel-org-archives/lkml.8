Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED15DC433E3
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 07:20:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD5C720760
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 07:20:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ld9zTaPA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730408AbgGHHU3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 03:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730387AbgGHHUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 03:20:22 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F639C061755
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 00:20:22 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id e8so18663937ljb.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 00:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SqcGE0kJwdQW0MaumCMD2Mj12V83G3gfirZKPTfcKM8=;
        b=Ld9zTaPAOzICRq5QA2zVtoPXWoqr4A8Rquyj9l6aZJ8/GSs0ijfw1CxdKDLxwPuipQ
         J7eCr3rsrPY2BYv3TcNS/RZZQTyMF76DT3aA+hEa1qLuEvhlTzss4AcfS3KCZuzBQLcJ
         lqVWRr4uBKlAf3WEl3/uUKIvlRzOJhTtG7B6Vz5GSSAXNLSoc32rxxBp111ShD12xPFc
         A15XhhZYxGCdkkNPBIZDb/+WWVNfaEa/VqpCO9W0VFIUWojDuTT/3ovqeDlXWVDlE/uw
         jh/x1mzUa2gLj1goSHaS8UHmOGR8VrBfly66MlDBNFMJegFwAp6p0myqnMe5fMH8R25F
         c+4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SqcGE0kJwdQW0MaumCMD2Mj12V83G3gfirZKPTfcKM8=;
        b=NkrwC3hk1YILzysLBPgtfaIYudh6xhSjJ8hV2slC59BDx/uIlEWjZjKQGwrEFjdnpO
         hIOlRwU3wD+pMtOEUVZJgXuUcqrmOYJCPu90eXytsXVM8JesZ1zvBtz/DHYNf4v9qxaF
         Si4dxMWr2SNb8HseHvHogdoka9U45cYFRLFNlzTbvEc2nsqXcN/Ydmbd+DyqJHgrTvmJ
         dZuOfxUqs9J9W6vTuIdi1r0oEuyYHWCsvqdjNbxUX5yPdqGQx8LwS+TJvXJ5AzfExjFA
         IkyCrwXqbE+47meQo21ojnBN+mjvMHh+WymiKKX7E7JUO/4u7XWDyRlhKQ0Gy5nfkmCD
         LukA==
X-Gm-Message-State: AOAM532ac3wC+l9SqPb3/1dBwPZdRzShWGNFJhCnFD+P01hxsvioCgSd
        AQ7i5YsjtgTvoBjeBuiaYOsMge5Bhi7j+5+YTc4kNg==
X-Google-Smtp-Source: ABdhPJzcU7X5ZIS5gNc4O3Ld+YSNcrmkC8WbKsbyCxTWNcAfHGiwwcrB2f/EhMeP3LQ6BIPEaYlypAuxNNX6D5NZlno=
X-Received: by 2002:a05:651c:1291:: with SMTP id 17mr31551028ljc.286.1594192820602;
 Wed, 08 Jul 2020 00:20:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200630133345.2232932-1-lee.jones@linaro.org> <20200630133345.2232932-9-lee.jones@linaro.org>
In-Reply-To: <20200630133345.2232932-9-lee.jones@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 8 Jul 2020 09:20:09 +0200
Message-ID: <CACRpkdb3hjK6CC4LTRX_S0X+AVSA6hZctuV6XF67Qn_UcrihWQ@mail.gmail.com>
Subject: Re: [PATCH 08/10] gpio: gpio-mlxbf: Tell the compiler that ACPI
 functions may not be used
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Shravan Kumar Ramani <sramani@mellanox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 30, 2020 at 3:33 PM Lee Jones <lee.jones@linaro.org> wrote:

> ... as is the case when !CONFIG_ACPI.
>
> Fixes the following W=3D1 kernel build warning:
>
>  drivers/gpio/gpio-mlxbf.c:130:36: warning: =E2=80=98mlxbf_gpio_acpi_matc=
h=E2=80=99 defined but not used [-Wunused-const-variable=3D]
>  130 | static const struct acpi_device_id mlxbf_gpio_acpi_match[] =3D {
>  | ^~~~~~~~~~~~~~~~~~~~~
>
> Cc: Shravan Kumar Ramani <sramani@mellanox.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Patch applied!

Yours,
Linus Walleij
