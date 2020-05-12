Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E81C54E8B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 12:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BD6C206A5
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 12:15:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g1XpMo8T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729560AbgELMP4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 08:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbgELMPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 08:15:55 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C68BC061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 05:15:54 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id u20so3069578ljo.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 05:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ccKOdwRe3iqeZSagNuE5XkunpZg3mt6JpF6qvoS7Ef8=;
        b=g1XpMo8TF7t4f6zVYEweNwAI8Xk50lfP6d27IehOWdIvNoMqK6nyLV8t08ANmCaD4+
         pvDi6YDCBzNKq89VZ1U8vtV0q4tHTotYLCtJQp4Y28cBgTLCrSNOdJLdqszeZEgE1eCf
         LpqcMPXgpK93bH4dQ7OooyRkrQ4W3Qzu3FZNMue7Agpms7aFaqAWXLM59S0R5TW3lOUX
         TB3UavKDUp03/Ze1R6KSY/BZXuDlLddJWmQcVU682QXLHTuLc1K3Yn9ZP1oZZ2BBuC/V
         diBSq9EYcTzYLccxhU+/sQ4v5oy3HY2xJnHXGMKGzbflqu8te/RW8NrsZr9DEj0ZyKLv
         mczQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ccKOdwRe3iqeZSagNuE5XkunpZg3mt6JpF6qvoS7Ef8=;
        b=ih8+jz+GpRD9lRRCwrDDvRa1i1o5N+UROsxtr6x2YXAsQbCeQstxXzGVoLF8JOUoZa
         B1vo6bumJRqlir3EMAbVS0aBKVeOtdd/FK7yH+vH99va8QIsE1639E1qrg3MGhJP9Djb
         bRHEdGzqh+Z/NFRUkPAr3xDU7O/okEnxS2zzd5IRSzjDf4VUx3Pyu+guWyUtfoFGhyNM
         Sc9MrIoTBnD9JnGGu/nFqE6VBM53vji/wvYB1xLMrrebTpMomMKxttiv1fsS46mNXpXd
         8u04nizbxoL2uL7eIs2uPOG3QWF5DKkA9cawaszdwflEe8ORaq+UJ4k9STtLN4WBU1ka
         HT8w==
X-Gm-Message-State: AOAM530NtWNSP7KKTLdoDXaPKQZ6SYR8VO8fY0O5UCCiPBz3T4lMaRIY
        skEknpRMpGgzw5D/wDhlL3KBGSy98PZyGKqSZ2vHNA==
X-Google-Smtp-Source: ABdhPJzzFcmf7nPjGcBG/Cdu0kwKO+w/24JLBkomICqKKfEEx8rLHtcWxInOvM6+OmT2C66Q9tBx42aLEAhCRR1J9qc=
X-Received: by 2002:a2e:b6cf:: with SMTP id m15mr13019356ljo.168.1589285752348;
 Tue, 12 May 2020 05:15:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200430143019.1704-1-brgl@bgdev.pl> <20200430143019.1704-2-brgl@bgdev.pl>
In-Reply-To: <20200430143019.1704-2-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 12 May 2020 14:15:41 +0200
Message-ID: <CACRpkdb3LkeMKjg3Kh2YwCiJkBQy5X2v4eShb0WG9PivGLizzQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] irq: make irq_domain_reset_irq_data() available
 even for non-V2 users
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 30, 2020 at 4:30 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> irq_domain_reset_irq_data() doesn't modify the parent data, so it can be
> made available even if irq domain hierarchy is not being built. We'll
> subsequently use it in irq_sim code.
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Makes sense to me.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
