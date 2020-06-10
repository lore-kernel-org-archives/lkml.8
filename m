Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F52EC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 09:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A060206F4
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 09:13:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TWzngnQI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbgFJJNU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 05:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726948AbgFJJNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 05:13:20 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5772C03E96F
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 02:13:18 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id h188so1011533lfd.7
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 02:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C38mlKFbKcn0KxflluI+40IimgVnduQnhaBOHbkWa8E=;
        b=TWzngnQIgK9IeP2unLrjbP2Nq3Pxntzaj1eVDSWc25mWOIpm8isZibtRz6skHc1PfG
         uuoXBeQTDjC6NmfpP0ZwdZ1GHRFKXlJDI8QctYnsr2ubz+wkvDC295kESRHh0HLIfFZB
         WwG1yaDH+MjUFA5cruCUKV4z9FWeU7hkwMmnn3GIcXK8VO1iUZR1HDyp5bFzCbI51tLl
         W79qWy35Ib1RhXQzkfwuVBUPIXntIKiGc1NXQso1Nrl9RPZAtAQqAnP7MTArEVHqA2Re
         Wc4xWwm5lbUyl2Z5Bb6ptXu76oedSrvofnMELcMiPNBFBTPbddKU1MrE+vxuUQaxDkYH
         eVKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C38mlKFbKcn0KxflluI+40IimgVnduQnhaBOHbkWa8E=;
        b=dwZXtvdFNXza2sLdBziKRsfNKOSXZ5QmW1rd0qxnT1V3B21ncilLYXj2lPFzRUItPY
         SNMghaecH+Nl0jcwYunFnhSvCnUtUZm1+rv97PRisqJZcqOsFh/2/+7+M1fuWIqCVS2y
         oYEajpFm7mh/NJbIp0TK56fzLT0OSI5l/QhotqZnr28YJadj7xwSeMwZG2SEYQ3dp4gn
         lTPOXS4jqMmLN2RGzXQwyp8+nPZpvQfAf41Wl7aEDxQoF5iL/Fu0P5PFt6vrC3LWrWEi
         vAFO4KlzJmHj/oeE015Rv2CY4wOZswMumAQnmSCbmz3qx4OhJPj2d7yCjZbfxM2i2k/Y
         NCNg==
X-Gm-Message-State: AOAM533EVEPHpHELcdOxy9ARluZE3au/WdADWH72aFD/TwPiSJFhQ9EP
        jibQ5/K0Fkye2TChI6Vp1Mu724L8goe1LMuIVXOAkg==
X-Google-Smtp-Source: ABdhPJz+O3CiP/rQT2+fskrv9NUMEXKRdot09KjDq1C18L6A+qUjVgcXu1eTGOkzU+Rmxr5tJWULYao3d+wWZfCgSsk=
X-Received: by 2002:ac2:4823:: with SMTP id 3mr1184193lft.194.1591780397116;
 Wed, 10 Jun 2020 02:13:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200602141048.1995-1-warthog618@gmail.com>
In-Reply-To: <20200602141048.1995-1-warthog618@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 10 Jun 2020 11:13:06 +0200
Message-ID: <CACRpkdbVmrjgqXHvav3JWmncrKhNnroJKvTYm57dgKu1VrVfUQ@mail.gmail.com>
Subject: Re: [PATCH v2] gpiolib: split character device into gpiolib-cdev
To:     Kent Gibson <warthog618@gmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 2, 2020 at 4:11 PM Kent Gibson <warthog618@gmail.com> wrote:

> Split the cdev specific functionality out of gpiolib.c and into
> gpiolib-cdev.c. This improves the readability and maintainability of both
> the cdev and core gpiolib code.
>
> Suggested-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> Signed-off-by: Kent Gibson <warthog618@gmail.com>

Patch applied as early v5.9 development.

I will include it into linux-next after v5.8-rc1 is out.

Yours,
Linus Walleij
