Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D47DBC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 07:36:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A123F23B5C
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 07:36:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hMUPfG1N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731424AbgFVHgy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 03:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731354AbgFVHgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 03:36:53 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD2BC061795
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 00:36:53 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id y11so18113001ljm.9
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 00:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8jMd68d9AA5HKRSwD8btncLpXQpP12S2zPFIYOSY6iI=;
        b=hMUPfG1NvzklTAO84EV2hfqw9q8vRlb17BtAPtKzrxDuauzTU9TdVJ19q+ctkvKrpJ
         lxFGho4TmZSCcTAqrLqo0PGFQP/yJnE4m1KUetOuKUhCfEz2udC/n0gQX95fa0WugnBh
         uJ3tPAQ+BvlkpYCkRfTxht7PjweJtsPxVEeObz84OElS05vMoHrkLRPgbGMb0E56Lynx
         JOo/7zwJlYUdDziU+J0As7CSj+7FKn6bkoX8Rrha9nQRxh+5aIN3oec79oyQ3k5gNgVs
         vtQXZ5EWcmOxfVuS1JZ5Ot4JY6CI0y1/BITzYt6ezNORuPBKyjz0NZUQ6u4OfmkmgBZa
         G+DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8jMd68d9AA5HKRSwD8btncLpXQpP12S2zPFIYOSY6iI=;
        b=lu6gAKH3qm68C/Ri5eROf4iktmpE+WRwe5CrIWvimnzIRgXw5g71kvwwOqKtAYG9wq
         PoVJaLQI2WgsAVmnuPaOR6neszqjBUdB6fWh/i9sHmmLkmAeP1p164zxY4XC0RSdukx+
         54E8FMcSeM8jhU/skm2KoLZzxvnG5m9Nhn+oBKiuhzWMUvXTXfBM+AQGAOkveSbvVY24
         kHOoHfU71wR0glKv1fz73mWP8J4S/M79Cri+YHYcsk22VPQiy6wMhk/AlIfWux0gJxeH
         6rrF+iH27Mblzj5vyHQM7bes4RxkM17OodeUQvPjZBXWEIQOOPIyRE2Me4oh1bqHvq+Z
         Cn6Q==
X-Gm-Message-State: AOAM5330JNqCRNbtv4tyXm0Zf3sSH/Ty8p+LNTAVHHvvRutJtLr+NhSg
        yrSdk97yYR1zwSL8F62Se5yWt/kdsYpotMpCCkLaGg==
X-Google-Smtp-Source: ABdhPJwHMBfbNH8fHLFwGb0U4Poyr72O07MbwbdDDd5vaN6Cets0kr4TApTjHKoHivQYCbHDp3CzGhYjAFPqe1YH+Rk=
X-Received: by 2002:a05:651c:112e:: with SMTP id e14mr7364725ljo.338.1592811411727;
 Mon, 22 Jun 2020 00:36:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200616015024.287683-1-hengqing.hu@gmail.com>
In-Reply-To: <20200616015024.287683-1-hengqing.hu@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 22 Jun 2020 09:36:40 +0200
Message-ID: <CACRpkdZNS7JD4Po9d4TXzB=+bn9qUez-eFwUjp=cF3yE8nrE0w@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: amd: fix npins for uart0 in kerncz_groups
To:     Jacky Hu <hengqing.hu@gmail.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 16, 2020 at 3:50 AM Jacky Hu <hengqing.hu@gmail.com> wrote:

> uart0_pins is defined as:
> static const unsigned uart0_pins[] = {135, 136, 137, 138, 139};
>
> which npins is wronly specified as 9 later
>         {
>                 .name = "uart0",
>                 .pins = uart0_pins,
>                 .npins = 9,
>         },
>
> npins should be 5 instead of 9 according to the definition.
>
> Signed-off-by: Jacky Hu <hengqing.hu@gmail.com>

Seems like an obvious bug so patch applied for fixes.

Yours,
Linus Walleij
