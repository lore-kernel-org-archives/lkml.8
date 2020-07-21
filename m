Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E735C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 16:08:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53BE22073A
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 16:08:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SgGhE5dG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730145AbgGUQIE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 12:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbgGUQID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 12:08:03 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FBA0C061794;
        Tue, 21 Jul 2020 09:08:03 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id gc15so1594765pjb.0;
        Tue, 21 Jul 2020 09:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JGXo1HLmj0B/GHBmTJocAxawqfuB0THi+fafWm8sJoM=;
        b=SgGhE5dGd1GGv7R6MekmRlLAzrwTBb7Yt/cmaO/QHOjnZtnqP+30V+zBneRksbOrpR
         ICMM5jJrYJXKZvGMrWeoz4QTskzVcERx3qLv1Dy2Zob2qcZz8/1OARoznA+S+m+C2u0R
         0gU01M+jBrxABByQvuxJ4Nkot6y8BLA/5zefqyPkwZS/FaeAVIC0EFxpIC7K9BvcSDRp
         GRyQa4xJQlT0VBQxDIKKDp1zietiJdPxXeZOZEdStcRCOEqk4JGqeW3D6b2Bt9+eO848
         Wu4B+nwfXEkOT7dD31NpKLQu9EkxbOP/quN1dC0ZHP7gtpI/ki5cBaNrAEBzYLBqGb24
         SzWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JGXo1HLmj0B/GHBmTJocAxawqfuB0THi+fafWm8sJoM=;
        b=TVNI16TXVbynWpz8FKpv2szINOPsHevR3z5tlcZ/Iq4CEfKfxoQmQd3M61IfG9j9N0
         Mz/VPFONib4IAncIjzYCUz4Ld7Cu3H0YIR8UsFdvOyeUoKOVwJkk+HbBUVhO7V0mU4el
         ge32JtAUzRSkw7LYvfwD56mhGzfACAgPI0On+SSbF5CZRSfszwwlv1DrbigUzqb0wDfB
         6WxiuZSQQ8qlqmML/M3fkdDURN/LPKaI7WvoYblmn/zRgUDHtFHyPQ/LCHDTXBITTFun
         1wNgxiS9zISNjTuULPYmYgQzbwY5uyr3xL2A8YwmgoLyG0fGzfqt3EOjtcD2UJOkKhO9
         pznA==
X-Gm-Message-State: AOAM5326Nhy4F/G+D2Ja3NBas76nkwY7HH2uNqp7zBdurIcqYu9B3Zs0
        HvHjdJDk26dOuRuHnzMzLFZ2kudJOSLwxkquHMI=
X-Google-Smtp-Source: ABdhPJyiXTE2HFEP5bOjdrn/0LJH83a/0k69meejxpHmT0qCaFXIGgJ7jjvV7BwTawzOPSRNLSq4Dk7q69eLIMFapjs=
X-Received: by 2002:a17:90b:3547:: with SMTP id lt7mr5481243pjb.181.1595347682901;
 Tue, 21 Jul 2020 09:08:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200721145046.773419-1-abanoubsameh@protonmail.com> <20200721145046.773419-2-abanoubsameh@protonmail.com>
In-Reply-To: <20200721145046.773419-2-abanoubsameh@protonmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 21 Jul 2020 19:07:48 +0300
Message-ID: <CAHp75VdOHtTNLfSweKJwGNb70=gJ=CXxBrj=rhCd6Z-qRYOPfg@mail.gmail.com>
Subject: Re: [PATCH 2/2] gpio: gpio-pch.c: fixed coding style issue
To:     Abanoub Sameh <abanoubsameh8@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abanoub Sameh <abanoubsameh@protonmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 21, 2020 at 5:51 PM Abanoub Sameh <abanoubsameh8@gmail.com> wrote:
>
> Added a lined between a declaration and other statements according to the
> kenel coding style.

Besides the typo in the word 'kernel' the subject is not okay.
I fixed this locally this time.

I also highly recommend to read https://chris.beams.io/posts/git-commit/.

-- 
With Best Regards,
Andy Shevchenko
