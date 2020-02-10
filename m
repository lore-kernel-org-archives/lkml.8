Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D01AC352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1342E214DB
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:55:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DRgSEasH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbgBJMzd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 07:55:33 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34553 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729987AbgBJMzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:55:24 -0500
Received: by mail-lj1-f196.google.com with SMTP id x7so7046236ljc.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 04:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=if4MUnW+MXwsU+saJV38n0v9tUH8Lchg2aKYG4Eb7X4=;
        b=DRgSEasHs7rZLw8lwalhqqVwwrJjzEeFMhK6P7OyXSdnl1DnOjoLg7S3gtTFtG1htL
         8PqvxVm0XTS0ARlV0Rhr7kA/HGQ98L++ubs/qGWrRLGfGhT3sbDc3YwalzhPLs6a74J1
         0zs5HgYZS0WfWx4rXHM1ViEZd6aQ2LPaODzPEUHW4doJisbhmv3LJDVkk9uNQ9AGMU48
         rOCv+R3N2LIgD24H2MZaSb8xHONLDBmb9N6AXv9x8UQQNdNVv8WrCeIyoE7TBNormu9u
         SwACo3uBmfPBjB3nMNEDFgCiR27a6t8gUVOj/myILUNlkzfVpDhWmNFUOBlD1+ODtgre
         aNLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=if4MUnW+MXwsU+saJV38n0v9tUH8Lchg2aKYG4Eb7X4=;
        b=MylFL7an2jbdbwiUwOklSLiwlrdSyD3Qecw9JjDe9vBVGNhptfLSCzDoYk7DCays0c
         FdU7Adf78WL1ft9nL2itGe2OIKQJ6+dujS5NYauoWBUKuywDfp8gJXbkvm/jK42Sl5Mt
         gCoghXzXFSijkSg+G5ud4BrCRsvN34yvKJRezh87napJacs3G61eESGGH4XAL8kkLeYI
         xspEKeu3+kDjrkgbHzPIBIJHFV96VvZVJIu9UBTihMfeqJ12ird49149XqWXj+6j0Kh2
         SS6dW0JVptCUVciu3NW47wW8AueJShjS11Izs1iI+Q4E4Ok7ES5yXBZUSzbci46Ju1Oh
         R0JA==
X-Gm-Message-State: APjAAAXzl95bYlQPYhXiw+28QUwWwZYsKDYuICu3Fhoqo3zbA6CwAsYo
        LbAccFvuiFThgaRylc5K1MnzUx3ieozo6xRLBhWDiQ==
X-Google-Smtp-Source: APXvYqw+civ1ODb6zso+c7GW7rfrr9mBNsfxXp5/xK8t7tww8joCEz2Wgykxa4HgCnO9fVri1gLiHP82cmonCoITb+A=
X-Received: by 2002:a2e:2a84:: with SMTP id q126mr847097ljq.258.1581339321285;
 Mon, 10 Feb 2020 04:55:21 -0800 (PST)
MIME-Version: 1.0
References: <1580189061-14091-1-git-send-email-yash.shah@sifive.com>
In-Reply-To: <1580189061-14091-1-git-send-email-yash.shah@sifive.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 10 Feb 2020 13:55:10 +0100
Message-ID: <CACRpkdY2Zahr0mLUp+dBOzZbthsttLS=oKitPJVS_xQh8RwZqA@mail.gmail.com>
Subject: Re: [PATCH] gpio/sifive: fix static checker warning
To:     Yash Shah <yash.shah@sifive.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Wesley W. Terpstra" <wesley@sifive.com>,
        Marc Zyngier <maz@kernel.org>,
        Atish Patra <atish.patra@wdc.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-riscv@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sachin Ghadi <sachin.ghadi@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2020 at 6:24 AM Yash Shah <yash.shah@sifive.com> wrote:

> Typcasting "irq_state" leads to the below static checker warning:
> The fix is to declare "irq_state" as unsigned long instead of u32.
>
>         drivers/gpio/gpio-sifive.c:97 sifive_gpio_irq_enable()
>         warn: passing casted pointer '&chip->irq_state' to
>         'assign_bit()' 32 vs 64.
>
> Fixes: 96868dce644d ("gpio/sifive: Add GPIO driver for SiFive SoCs")
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Yash Shah <yash.shah@sifive.com>

Patch applied for GPIO fixes.

Yours,
Linus Walleij
