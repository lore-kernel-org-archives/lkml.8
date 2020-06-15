Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25544C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 13:14:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00F462074D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 13:14:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lUdiYSSn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730359AbgFONOa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 09:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729875AbgFONO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 09:14:29 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DE3AC061A0E;
        Mon, 15 Jun 2020 06:14:28 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id s135so6926160pgs.2;
        Mon, 15 Jun 2020 06:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2yPNE4v0GGjg/LGgicOMRnn1QF+hlGYZig2nfmjhJfQ=;
        b=lUdiYSSn0elzj7x0t5itdYinwzTDqFsKF0tKh5Qq19WYIERw448oAZnLEp4NcjySLT
         UOE/SM6NUH6PLxiF0fCVxGjSCIOkwKSWy1EEZYV/yTzWq1P9mQo7wIWvTt5WSZ5dN2lN
         CFzpmp/B73XAQ2sL10ytA5EtsTwHsqvhnktrLcq8h3fjtTFb1LZPxe16ysnAzzayPpFh
         HkCSGypIIg38LKRYWxDx+UjidmBK3jWScUKxcQHh9nirJr2H+98F3XVmapPw1JTvEka/
         LTXTbr2eryDDHp6xHwb9KWSYcHcOLvpJkNsarOMCgdsE3EiCKGgZCMoG9JDIOaCsS74m
         yThQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2yPNE4v0GGjg/LGgicOMRnn1QF+hlGYZig2nfmjhJfQ=;
        b=mOcfcRV7nchUJ5HHCrL/Su4KLwnYUIQO/ng+8LetR9TpXkDD7s4v4jZ+yG0403u4Z6
         BabBOiwFiBgwxsKA6XF/o6enWPlltHExnP6fnyeCV55IdYrck1+cyJVY1bDRdk+wpUKe
         gfb1utZmMrdTsa2kK8zmI9FkKXL8oTIvNQnKGQVf3AeEWssyFDYo1hmgzZBZ3rW3B+/t
         hFeWX/3mB93yLkaZiKpgQ5sLwI9iMcG6uR5uuMCY6ICyoKqYJLPaYD7b3vSZzDgnkIHl
         oOqt+OhYZhnH6zJrfNt9VaHWiaeUklXQqTgv+HXf8Hv02hUEtZ+vunbsj3jxROE/4wsl
         MKxA==
X-Gm-Message-State: AOAM533Jq2xc74cgHedlgtqwTG0IOogq096/or6GmlkdW663Nekm8vRy
        IFKXcgufv2x7An6Ta1/SfvluAGFw8O2xP4a4w4I=
X-Google-Smtp-Source: ABdhPJwB3v9szrYE8Z/bKHCBsiBEJXEwQXLqZ+PI7R7PvuV9hsuNN1YzIxRvX0LlgiDZomsii24TUWFZpH6fZGVYEBQ=
X-Received: by 2002:a62:3103:: with SMTP id x3mr22390663pfx.130.1592226867580;
 Mon, 15 Jun 2020 06:14:27 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1592209703.git.jan.kiszka@siemens.com> <b4548638f5eee6919f0a74f52c1a6ddba8fea678.1592209703.git.jan.kiszka@siemens.com>
In-Reply-To: <b4548638f5eee6919f0a74f52c1a6ddba8fea678.1592209703.git.jan.kiszka@siemens.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 15 Jun 2020 16:14:15 +0300
Message-ID: <CAHp75Vdy5UbyW6v_AbHywA9v7HC_PVagEuqdfN5ZSZmBt7BQXA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] gpio: pca953x: Add support for the PCAL9535
To:     Jan Kiszka <jan.kiszka@siemens.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 11:46 AM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>
> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> The PCAL9535 [1] is compatible to the PCA9535. Additionally, it comes
> with interrupt support and input latching. Other features are not
> supported by the GPIO subsystem.

Same comments as per v1.

> [1] https://www.nxp.com/docs/en/data-sheet/PCAL9535A.pdf

Datasheet: ...

...

> @@ -1131,6 +1131,7 @@ static const struct of_device_id pca953x_dt_ids[] = {

i2c ID table

-- 
With Best Regards,
Andy Shevchenko
