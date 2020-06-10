Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF515C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 11:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 989342072E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 11:18:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q6IUMGq1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728407AbgFJLSU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 07:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728264AbgFJLST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 07:18:19 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B59AC03E96B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 04:18:19 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id e4so1978654ljn.4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 04:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R/H/MbVOF2wG1dAksFZHKza8JjVA0mBuXbjfgXmU1gI=;
        b=q6IUMGq1BoyrzF+yphtauVJSkEKnYVpLrCpHxSKEezsjWMWsSneZ9MYEZWLufzYv4m
         WB77pudqkIPq6h8aSKtcawWDrMyuyYGSYoPz17sFJ/BYCfBHD9A3DHYrWfjUFKpprjh/
         q4LWZnmqgeJJr9AObHAQPaOoFzNGEYnTOX0xjDfNvmVANSGexwCLUNdWIPjSYskLdxMR
         GGEMS42Kcoiij8ZCTppz+8QMyN3zCO80Yplre+E0lPj/0pRIfppGHm9IQrkERGt0sCpB
         xL3cuSSmEXLwhqu5Yp+z0o+3pgf1BIRAtIMP7019kxuiRumrgAAbRi4zQWbzrt8V7teP
         J/Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R/H/MbVOF2wG1dAksFZHKza8JjVA0mBuXbjfgXmU1gI=;
        b=bPnzdI0Meg9SmmQBVXZ6ImoV1LRv5e0h68++STzw2TJXVqC+IpMdElMYn5C9cD9Au7
         dUKWBzg8mERq3HKKQtkomCa9eBLET40gOOejR2rMG316F1qAFYMn//rInsw/R4jtMN90
         1rJ/P8vfu7LNiNByWrtuH2dWdqabl4kHugnwbWsL5QgQuPHgC1pXuOHjAp88ajSoivWO
         eFpyu01vOt7UNSvKrTZ69NlPUBlOqEkF6Wau2rB8t/Nk254ihblJkHNfapIgf5vs/l8K
         Mgzmb+D+334dullEUeLIAhC7GqIPclorwetTWOmHzQ6j3u7dxTzXWmGmMV+5HJ0ZShEO
         kSFQ==
X-Gm-Message-State: AOAM530ZghWSlVytwxGd/QmwwBnI7OLAktuqpeMM2cey07cJ4PdA2pJP
        wIDAz+3+VylcN2/zWIXvj8TRauPjWTTxNlRqzliVlw==
X-Google-Smtp-Source: ABdhPJwYHSqLY8+MZktVcG/jK3d2tobvKvb5DukA5J3ghqqrGvCncKgJl0YY4MKk7oh9UCfApO7oANgemtP3qCfhFRk=
X-Received: by 2002:a2e:7303:: with SMTP id o3mr1616150ljc.100.1591787897894;
 Wed, 10 Jun 2020 04:18:17 -0700 (PDT)
MIME-Version: 1.0
References: <bafd8df9e743c433196c727293c5015620fae2b8.1591428452.git.christophe.leroy@csgroup.eu>
In-Reply-To: <bafd8df9e743c433196c727293c5015620fae2b8.1591428452.git.christophe.leroy@csgroup.eu>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 10 Jun 2020 13:18:06 +0200
Message-ID: <CACRpkdasvyWRLiaHuZ+vkDC4MxNqx3qvjhy7Q8Qnfn+d74Xpkg@mail.gmail.com>
Subject: Re: [PATCH] tty: serial: cpm_uart: Fix behaviour for non existing GPIOs
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe!

On Sat, Jun 6, 2020 at 9:30 AM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:


>                 gpiod = devm_gpiod_get_index(dev, NULL, i, GPIOD_ASIS);
>
> -               if (gpiod) {
> +               if (!IS_ERR_OR_NULL(gpiod)) {
>                         if (i == GPIO_RTS || i == GPIO_DTR)
>                                 ret = gpiod_direction_output(gpiod, 0);
>                         else

This code, and the way descriptors are used in the driver leads
me to believe that the right solution is to use the optional
call with a hard error check:

gpiod = devm_gpiod_get_index_optional(...);

if (IS_ERR(gpiod))
    return PTR_ERR(gpiod);

if (gpiod) {
... followed by the old code ...

This makes sure that the array member is left NULL if there is no
GPIO on this line, and all other errors, such as -EPROBE_DEFER
which currently absolutely does not work, will lead to us properly
exiting with an error.

Yours,
Linus Walleij
