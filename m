Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0255C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 08:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8E812072E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 08:52:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VBHhJCu/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbgFJIwl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 04:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726855AbgFJIwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 04:52:40 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A95C03E96F
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 01:52:40 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id a9so1469540ljn.6
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 01:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TZj9FRS2XY4VqFQxuNlqLqbv79Zq0nSJ0wqXA0WHqXg=;
        b=VBHhJCu/HbBJ2Q24M4THp6StoZHbqwa/jkSOPhIazusNP2uMVP594ATj7eMtCLLgFu
         wsV57vQYUFuXy1k8ZZHFINfMQJwnjJkiVX6w4rkRXu9PkYkufBcAp8i2vZ9h2jIwNw6l
         TA9TUmhZ1iLn9yRmX9qz623BCCkIvzo0b7Spt4rz4egY3u/JAv8Wve0MqOemyHbXi7K8
         fgZR3jXhb2RgDkHrXe3DTknMCjighQr02/nSDmhfS98rYUKMcVx9ruwdLgnOO4k0HQIv
         BGZjjDsYCuHsYj0Qd7KxK6Nc+e7ZNbrS4WtJkpzruTlt3pL1mSg72sTjPORf6bMHaSAO
         JhYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TZj9FRS2XY4VqFQxuNlqLqbv79Zq0nSJ0wqXA0WHqXg=;
        b=nUehrR7VMglfcmTjwfwzOrRlw7r4JYfJ+cXdweeWT4PA/8g1He5BRgIVgG6T2qSUXI
         IPvoQ9sUvINMQQhuS7R9MABgTYjyRilXp15Bc6xY9qxvdjnhMn8TPYZBMUWBdnXxnqw+
         Z0Q1hWapZRSWe6T6U0XmwuwnbF5gh/Wcix9e/N57QrFjUGdQgDW5/Y9chbiYPgZlKWft
         eiExGlON0TPUpf0ZG0EueSsa07spq+o7pq2TrXO1WZeAKBT7CB7hNTsz6/934mRAZalM
         oQj89bVa/pQLCKmpltSNPhjAfdm6xSw75qmk9psoQnkaDFNtBwdqEMGVeLK+tvca58Ug
         IIjg==
X-Gm-Message-State: AOAM533/eAygTSPe63KxB+8XQhMfMRUvgJg+4fWdYYGgfcGRSdmMsPTn
        8COn9M6Rs5UVd5iKxBgr2uGmo7k7u1Z1Agi8cEnglA==
X-Google-Smtp-Source: ABdhPJztWOIRy+Pmfhld9nG2TEcFdJeoDu3IbxxlhHk4JCQWGXBbF2DQUa89TWM40jKt/+uuCCMYWRPeG+Mn4NBekAk=
X-Received: by 2002:a2e:7303:: with SMTP id o3mr1282281ljc.100.1591779158505;
 Wed, 10 Jun 2020 01:52:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200605024919.56177-1-navid.emamdoost@gmail.com>
In-Reply-To: <20200605024919.56177-1-navid.emamdoost@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 10 Jun 2020 10:52:27 +0200
Message-ID: <CACRpkdbS7Vo+uV2LJTQNiqoPHWScDrgQiv=TakL1UFQ=ZGXxiQ@mail.gmail.com>
Subject: Re: [PATCH] gpio: rcar: handle pm_runtime_get_sync failure case
To:     Navid Emamdoost <navid.emamdoost@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Navid Emamdoost <emamd001@umn.edu>, wu000273@umn.edu,
        Kangjie Lu <kjlu@umn.edu>, smccaman@umn.edu
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 5, 2020 at 4:49 AM Navid Emamdoost
<navid.emamdoost@gmail.com> wrote:

> Calling pm_runtime_get_sync increments the counter even in case of
> failure, causing incorrect ref count. Call pm_runtime_put if
> pm_runtime_get_sync fails.
>
> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> ---
>  drivers/gpio/gpio-rcar.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/gpio-rcar.c b/drivers/gpio/gpio-rcar.c
> index 7284473c9fe3..eac1582c70da 100644
> --- a/drivers/gpio/gpio-rcar.c
> +++ b/drivers/gpio/gpio-rcar.c
> @@ -250,8 +250,10 @@ static int gpio_rcar_request(struct gpio_chip *chip, unsigned offset)
>         int error;
>
>         error = pm_runtime_get_sync(p->dev);
> -       if (error < 0)
> +       if (error < 0) {
> +               pm_runtime_put(p->dev);
>                 return error;
> +       }

I need Geert's review on this, he's usually on top of the Renesas stuff.

Yours,
Linus Walleij
