Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5945DC2BB85
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 08:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2840D2063A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 08:39:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O88sX/eY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2501957AbgDPIjI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 04:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502490AbgDPIfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 04:35:33 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 343B3C0610D5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 01:24:01 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id 198so4918921lfo.7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 01:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H9Z4l3hppp6TCIa45Hxja3dsjinLCm6mBL8W41Pph0k=;
        b=O88sX/eY/ZndHEXjyGgsfVESIDfup0ASEpFabBfcGOezZWo5R/Prw/qBIt8l4I/ayI
         sIDV7348QRlh/2mRxDSesMsCXA6I+YQa1siuyNJPz07mIxeZXs4JWb7Pdp5wvzCbl/Pq
         unltqkjacLW+WcBpwDxb1Lx2u+cmvi2eo2JYx3wLxlTJWEhdA985xjaanzgG5vJpkCoP
         +JyW3uGpDrBlBuEzOeizBJ+mEUZ1gEd2MbLFrluD055JDmtTb5d0w7Jzo3PbTNMxg5Y/
         kRi8cjn0qXEJ4qcpozAQ1O2TymcLquSv/EZ5Zc7ZuHfbCP53Hkm3FNoYMM/ThADrhrlC
         NUfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H9Z4l3hppp6TCIa45Hxja3dsjinLCm6mBL8W41Pph0k=;
        b=TNRY5T3k4nZ1rFwg0vtCEBnz/Xb7jo3ztZlWu4NUUOr5Hf87HnyzfM9pmrtYx2aJZM
         ls9IsA1+E0vNxfcwVZed8QUK2aLHD7Zx/ZdIVVYVeKjtlBNjQmoH6K8PGJByksO6wEGM
         mk911vo9VK7ramdQ6Le5kEVIjML0sivzwL3LOIgghVHsEFrRxwUtfAXCpGm6HjRdYy3a
         mSWW+xVOPFphhHZDDXZIuJacWFQJPNQdYhvTJ7JW+2wfHlQNiceu4XGCicNOEK1RQ6DF
         DyNDYQzEjDgKxHWy9aNtbMPchp+yDaUUjPfUEzd4nEbeHbQP1+4Ks+m0cs98SKjRjj++
         D9UQ==
X-Gm-Message-State: AGi0PuYAXT9G5BHaUT8iUG8vUtQtl9Hlj6tlaCTH/yJVsfkQOYca7yAl
        1jGaWTCpBhPSGJKWICQ0vfIWyXJ0qxHwNynypPhDuQ==
X-Google-Smtp-Source: APiQypI9PGqy9QkvtyKHNgt3xATf8GtqzRkowASz8B+RqstF66+T930LfeEf8r5btaykxEzUjQ6154Qbj9zh3YQYj1Y=
X-Received: by 2002:a19:cb41:: with SMTP id b62mr5448214lfg.21.1587025439678;
 Thu, 16 Apr 2020 01:23:59 -0700 (PDT)
MIME-Version: 1.0
References: <1585818532-23051-1-git-send-email-clabbe@baylibre.com>
In-Reply-To: <1585818532-23051-1-git-send-email-clabbe@baylibre.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 16 Apr 2020 10:23:48 +0200
Message-ID: <CACRpkdb_JztWo9XhWZw9einj2D1fgBiB+up3ZUrCOf5S-dT3VQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: sunxi: handle probe defferal
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 2, 2020 at 11:09 AM Corentin Labbe <clabbe@baylibre.com> wrote:

> When checking the logs on my sun8i-a33-olinuxino I saw:
> sun8i-a23-r-pinctrl 1f02c00.pinctrl: Reset controller missing
> but this driver was working after.
> This message is just here because the reset controller was still not probed.
> So don't say anything if the return code say to wait.
>
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>

Patch applied with Maxime's ACK!

Thanks,
Linus Walleij
