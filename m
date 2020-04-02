Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E028C2BA12
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 07:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52DA420784
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 07:17:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qF6WMmu+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387553AbgDBHRE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 03:17:04 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45537 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728402AbgDBHRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 03:17:04 -0400
Received: by mail-lf1-f68.google.com with SMTP id f8so463754lfe.12
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 00:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fGCNVs5ms+lfI0CqvvFzJ8SjCEm1mygHViFV+/PrmR4=;
        b=qF6WMmu+6KzQwDt4TcfDAG/fnQND28dHhorj99K8/ZgLslOE0pB8tqgeQapcvDAlpV
         IW4ggkMHsjFymJWUzMRxbaqZhCDh0ScHLhoqc/Cqpd4L9rNp6UZ0EgcuuvZY78y//6WO
         DCGEyYiNuOZPnJZJrUC5nVWf6uF6q1Yf3zYAO2m2Obk/cd+ig7feCpRIcg8oI28jQunm
         4yCKjlRWf9UKUeXtUwUz6a0qulYEH9q0fDP5W1GA/Vc3oMnIZo21r8SL3fS6MIUOfqu9
         NuYt0xfKQoCkt0cAPPMo/rr5jcZL4aXHoVSJWIUsxWePAh4iYu/t3eI5vZCZ8GDlE8ex
         duuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fGCNVs5ms+lfI0CqvvFzJ8SjCEm1mygHViFV+/PrmR4=;
        b=VLrD7NwFaxa4PNHqzxFYJCportfOtNUmgZQd4V7PnybOmCLmR8z3FYaYDO9uPgKZpr
         6vxBAiUrufYEVsrBRk3XWQe5UHv9czJb4DeNPjVVyIVqj8boo5R3uoZqqZ8Y8Wxdj+02
         7MKLUpO4B7WoZ0ABRlHe0TtXGfHxiQ+w2qpZ2vwBiv30Cia7rVjJGQCindDHG+z4L3hu
         mtxZGkfoNCd4DejLuT5pUPVoVeOR+KAgahWK/fbMVZwqcFfaBG6CTXgKyutKFI+7I1y3
         IqezIpY9hMVqQGv9K6OerTmf2G1pQxw1Z+l62voODof2u063D4QNdg8C5v0mYypUWOmD
         /NHw==
X-Gm-Message-State: AGi0PuYFB7wOY5F6f4F5ZWxoMPC8S7NwVQDgoPcjZDs2eG3R/Ay6efJd
        JnDRhUVSFk+WDeA9GLgVZI9GbVhvlDzm5CcBVn6CT3FcdZ4=
X-Google-Smtp-Source: APiQypIKx3lN+NN6JUHXlyLWDQZ6Blqq6gPdb0V+mmQsewb2jzU0GTc0KYjU3uhwIdwbNat6G+7QnOFTaAbutVtTvkM=
X-Received: by 2002:a05:6512:685:: with SMTP id t5mr1232471lfe.47.1585811821663;
 Thu, 02 Apr 2020 00:17:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200401200527.2982450-1-thierry.reding@gmail.com>
In-Reply-To: <20200401200527.2982450-1-thierry.reding@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 2 Apr 2020 09:16:49 +0200
Message-ID: <CACRpkdZQ=S003MqmTKSD7QTp=j7NJ6xVyGbqkDyEoARW6+O54Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] gpio: Unconditionally assign .request()/.free()
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 1, 2020 at 10:05 PM Thierry Reding <thierry.reding@gmail.com> wrote:

> From: Thierry Reding <treding@nvidia.com>
>
> The gpiochip_generic_request() and gpiochip_generic_free() functions can
> now deal properly with chips that don't have any pin-ranges defined, so
> they can be assigned unconditionally.
>
> Suggested-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Patch applied.

Yours,
Linus Walleij
