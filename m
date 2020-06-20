Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE89C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 20:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98BAF22B4B
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 20:40:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WCCD8G2J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728833AbgFTUkx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jun 2020 16:40:53 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41085 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728731AbgFTUkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jun 2020 16:40:52 -0400
Received: by mail-lj1-f194.google.com with SMTP id 9so15234276ljc.8
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jun 2020 13:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4NmmdrNBIU+TG1OWdFcJDhSqTnm7hEJLZEQZT2jG9cU=;
        b=WCCD8G2JNNtQ+CssTxWzTNoe5WMEYAL4To3tUApgI/ZRhqAglEEeXBoVu0oXvTtrZA
         TOazmNN991nWQpgYFHRQ9mUAwyegqXGTiCdK7L+finpke4+5m2uZzR9hbFY2OD4QeGxF
         dKtGOFpTzzVRFrv1QJc/OyJF1obk22AK4lvBUBYMElRV9DuLkArl2rtT+gqFhrssw0wv
         1wKHhoq42sCs5RiMwv8b3SnkOQa4HVVpxPyBhWJuevzTcuVPDY6D6Fmqb5Kf/GL4WPRq
         3rSa2tEB5SLiAu03RKdiEKCC/dghGkUkGmpcMYnqnRYADfUS8Yzw863AuiMG9pDXyV84
         6krw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4NmmdrNBIU+TG1OWdFcJDhSqTnm7hEJLZEQZT2jG9cU=;
        b=db3L8NdWURhzE0t9vqGv0OGRslUYUz7xdZ0dBRkVw7bXWGlcpzijQD6H7440zjm5B2
         Tw3ayULzttqV+f1mM44DgGVmciww4qW7fsQGiNBH6PXmJHY53+uBTSTFOeVW4nlL8B8o
         COE1plWliedIg98LVZanJiY00XOLGKycahxetkCeGCINqDj0p/odd3XPR1bUiqlZrLTH
         VH1h6IBYT4VMf294knqy7igxaZ1f9550inrAb+Tpsvabk0LdRuuoXq5ttt3Wo5j8mut3
         SGxQcy6U+sgYsMkSzsjRu8jNOkv7e2AUh0n3Sxj+N11ctExGMYtq4Vx5lQcBggxh1kCo
         3vow==
X-Gm-Message-State: AOAM5320COK5HnIOgtuVj0rz3mxwzT+PQuMcoQC2X+n23mYmgQFni3Vw
        t0QM0486/k833pXrUsK6TqMfHb9SE4h2q7Q9XBakPQ==
X-Google-Smtp-Source: ABdhPJySIZ40RE5xKJfwm81GVAWeTHKp7GQpe60vB8usHEm84H9NuwU/f4UCoPG/npPVnyAn//I88yf+VosHcKrEFok=
X-Received: by 2002:a2e:351a:: with SMTP id z26mr4753254ljz.144.1592685590114;
 Sat, 20 Jun 2020 13:39:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200616093615.5167-1-warthog618@gmail.com>
In-Reply-To: <20200616093615.5167-1-warthog618@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 20 Jun 2020 22:39:39 +0200
Message-ID: <CACRpkdaahnBak=FwSy9PtZpBMBniotHuFMWCrWJo-94u8j_59Q@mail.gmail.com>
Subject: Re: [PATCH v4] gpiolib: split character device into gpiolib-cdev
To:     Kent Gibson <warthog618@gmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 16, 2020 at 11:36 AM Kent Gibson <warthog618@gmail.com> wrote:

> Split the cdev specific functionality out of gpiolib.c and into
> gpiolib-cdev.c. This improves the readability and maintainability of both
> the cdev and core gpiolib code.
>
> Suggested-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> Signed-off-by: Kent Gibson <warthog618@gmail.com>
> ---
>
> Changed in v4:

This v4 version applied for v5.9.

Yours,
Linus Walleij
