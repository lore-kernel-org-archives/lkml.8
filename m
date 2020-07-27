Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02890C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 08:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF61D20738
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 08:15:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sZRmTr2Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbgG0IPv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 04:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727893AbgG0IPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 04:15:50 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F25CEC0619D2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 01:15:49 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id f5so16196558ljj.10
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 01:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qhp3zn/S5T76H2y1nHGP53o8P3SYGgo1t7ExJQ94lRo=;
        b=sZRmTr2QRJtlZat87Jw5tvCZ+Jgj01sf9HOfH/YE2swB7dy6haxMsR3ILQ2xha9wbr
         mo+uePkbI/JtL+MZN9+5pC+2UsTCxAzoJtQFERKikXxIwlXjm6DASru9V3BATBIVVpa2
         xTiUHcKo6misCIAdyhQ1iVgoWok3mv4cQjYQsowXoGnhMx1DyE1gwxLX/ANAe+ssDCm7
         byOMHq3dnLGXyM4czAwqRuKqVTiCAFBQKSWmn1fNh8bfrsYzgCaFrdB51Fg/pj31vsuU
         4J9GJoUIqLICJYmiw+gcaKAVJqS9GFJPgx87DUw8RG2Z52avKWq29V0L4yW6PgtQTbrG
         5jpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qhp3zn/S5T76H2y1nHGP53o8P3SYGgo1t7ExJQ94lRo=;
        b=oDZ6VyaqG/5KusbsFvu1hrPbVQu2wrlCORodRcSJLkmUvACZH9Mszmg36vzeeUg4t7
         slOOgDKQPaOperMMIZ2pmQ2ENGXPFNLAsZ06CsPSCEHbFr8aHHhvfe9LrDz1SkJbrV4l
         223WW9PYwdqBMGYEjYn+cFdCHhrIXLlLiaTu99Knt+nNtPs/rW/7JBzrwZyOx5xIP81U
         fWxEi/pIsw1AMqFZbQf0qLDgmv1pmCtXQYB7Jqagdmp4JHyoBlVsiUlk/TPBzA/e6Cbs
         XYcoz4ruD8x1HJ2E9HXvqjIMZtN1TS/vuiRBDXOLULW05s4Um9CCqiGke61MhJr5Kd6n
         OdmA==
X-Gm-Message-State: AOAM533/S+/CTx6bQJbqPmt1gAaKqllvC3sN8J+yo7LGDqGFOL6BTydt
        55MezPIYWKp8n1EQUNzDHQcCRNcZsFsgNSxNyvUSsQ==
X-Google-Smtp-Source: ABdhPJxVIa9xAHnjxtyOcmkJgGyRDGwKS4oGmRuA05wfeBkGj7qWk30nngtb1A5tbjqvxi//U9Kq253CWspCCcze/I4=
X-Received: by 2002:a2e:810a:: with SMTP id d10mr9270946ljg.144.1595837748514;
 Mon, 27 Jul 2020 01:15:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200725041955.9985-1-warthog618@gmail.com> <20200725041955.9985-4-warthog618@gmail.com>
 <CACRpkdZymmO9ku5OmCO74eiX3Y3jq_1g5De9Tx4hg3Lyrdt6bQ@mail.gmail.com>
 <20200727014601.GA10761@sol> <20200727055730.GA29606@sol>
In-Reply-To: <20200727055730.GA29606@sol>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 27 Jul 2020 10:15:37 +0200
Message-ID: <CACRpkdYNaeunyQ4ymq9WOOEZhF7NH3USVNVJ1EcY68-=oOUVdQ@mail.gmail.com>
Subject: Re: [PATCH v2 03/18] gpiolib: make cdev a build option
To:     Kent Gibson <warthog618@gmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 27, 2020 at 7:57 AM Kent Gibson <warthog618@gmail.com> wrote:

> I've gone with this:
>
> +config GPIO_CDEV
> +       bool
> +       prompt "Character device (/dev/gpiochipN) support" if EXPERT
> +       default y
>
> so the entry is always present in menuconfig, and GPIO_CDEV_V1 can still
> depend on it, but GPIO_CDEV can only be disabled if EXPERT is set.

This is perfect, thanks Kent!

Yours,
Linus Walleij
