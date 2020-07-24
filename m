Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 326DBC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 09:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B9942074F
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 09:22:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ueR30Swb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728349AbgGXJWc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 05:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728340AbgGXJWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 05:22:30 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0BE3C0619E4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 02:22:29 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id d17so9279917ljl.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 02:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NIN2eG6kxQsTMBpOwVSU6dRg3bbC+qayNO9Wkv9P+PQ=;
        b=ueR30SwbJ+rAmb+W+yOnb26b9Bq1/lkv19P4z+FB0L2SeIkegmvr6F6TdSscAoD6JI
         3cERgk3EAOpgR3fsis+BCYgSh3bFlS+jKkpBZkSN/kY3V+B4+UmGrt6QxidB7/JijXJz
         lsD0e8pAcV7u4ePXMK5g0aRWn+oXYzksG/ZbyjRjofaBY68qvHzm20fk/kTyJbw1N4dQ
         G2dhUKBrUvIOGxW36HmMyC6QKxiZPr7W7piXKEqxYB1j22wXEbVhCS3dLZs4nTjy0KCv
         wH/rQHC0jK6EcdVdeZ1OWUzwqUNQUAWu8dHOOpiQBGMh0DpxsqiPuodFq0e8HJmv+caa
         KXLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NIN2eG6kxQsTMBpOwVSU6dRg3bbC+qayNO9Wkv9P+PQ=;
        b=IbTtjuwVt+K+R1OATyvAgY2+IOex1ry66UfDgHzzao7gshYNIf+s+H+Z3PIzYjiU4m
         +s/tatICMQOqOpFlxJUltnDgS+3QBqBePlRTGfGMJ99E5hug3YpwUnJhbev7m+zJtBDC
         JY3m3eR/qe20T7sMd3GS7FZmVc3mLEVcVAt8Z2TcpdzMaSZJSvm3m9epDaE2mdxh2msL
         4BItxRzDiRiLVkA3s5uUeIohWjYA+PoyssGqz5GN2gVfAWdPk3z+YmJKnU0ooNQzXWpN
         IBfCo+fUH5EiN3juN6VlQNVh8JzJgFSA5NJmFoSeYKziDxpp9Mc6WXgXASP1hlaGANh9
         U9PQ==
X-Gm-Message-State: AOAM532FTwWoXfEEm7Oot1d8tkEtYzNBfQGaz2xKxc7QzNOgfBJFdFwn
        Kn0X/hnTsxtUGO/jYoeUPz4paqS1WKhK4JoTxIRNkw==
X-Google-Smtp-Source: ABdhPJy1kxaa4/qH3lXM5ZPK1KAZ7uW0S11/tRncapyJVFPYOfPxHvEk9ABpsCyBSKAwlbvbZ811yX3n+1ZLG46V/7M=
X-Received: by 2002:a2e:810a:: with SMTP id d10mr3848032ljg.144.1595582548179;
 Fri, 24 Jul 2020 02:22:28 -0700 (PDT)
MIME-Version: 1.0
References: <1595513168-11965-3-git-send-email-srinivas.neeli@xilinx.com> <202007241241.Eamn0vcf%lkp@intel.com>
In-Reply-To: <202007241241.Eamn0vcf%lkp@intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 24 Jul 2020 11:22:16 +0200
Message-ID: <CACRpkda0YiUQTUDOEo7gnuegtPFauUyeLWs7wDkapzrUC-nwAw@mail.gmail.com>
Subject: Re: [PATCH V2 2/3] gpio: xilinx: Add interrupt support
To:     kernel test robot <lkp@intel.com>
Cc:     Srinivas Neeli <srinivas.neeli@xilinx.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        sgoud@xilinx.com, kbuild-all@lists.01.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        git@xilinx.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 24, 2020 at 6:12 AM kernel test robot <lkp@intel.com> wrote:

>    drivers/gpio/gpio-xilinx.c: In function 'xgpio_probe':
>    drivers/gpio/gpio-xilinx.c:638:10: error: 'struct gpio_chip' has no member named 'of_gpio_n_cells'
>      638 |  chip->gc.of_gpio_n_cells = cells;
>          |          ^
> >> drivers/gpio/gpio-xilinx.c:639:10: error: 'struct gpio_chip' has no member named 'of_xlate'
>      639 |  chip->gc.of_xlate = xgpio_xlate;
>          |          ^

This is probably because your driver needs:

depends on OF_GPIO

in KConfig

Yours,
Linus Walleij
