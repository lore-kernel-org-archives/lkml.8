Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FBF5C3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 23:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03EBD246B0
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 23:20:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AiUb6onF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbgB1XU4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 18:20:56 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38023 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbgB1XU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 18:20:56 -0500
Received: by mail-lf1-f68.google.com with SMTP id w22so2311215lfk.5
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 15:20:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IUCuvsoT8/LPUAazzHuf3BSlY/LuzBm/RZCQW8qkafc=;
        b=AiUb6onFScs/DAQJxoWCQUJu07Ygr0wcS1Pv2MbH6OyAjWjgozRxwf6cNtCwOtlfVR
         StL7/AuHIW0sbWv7NYip4IeQ3WOfVl8K+fzviBHY+O0vwd3X7fxSjz41UytCU5pFjIoA
         Aj9gufEaX3ovYzGXMaPshc1QkuAjwholpDgzRax7GEvEpmZf06tYZ3d9zzaIeuFHWZIm
         j41Pn3Li/q7s/VutdqRXw+8LiL7jgl4AFztDLVpC3ruoqCw4G8iPpD6CP1ybCpQkNhP6
         GQksQkjbHI7sVqDVLH42/NIVMLVijAowK7Z57JkUzabEyP7k8fCQWxnPc8tyA+Bj8Onq
         U+eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IUCuvsoT8/LPUAazzHuf3BSlY/LuzBm/RZCQW8qkafc=;
        b=is/x8tbtvcyFMIN9oPWQIZU5zYX0PfxkVzSEtp2vQiSJvBWICJeXrii1zS0t3uCIzZ
         qjUp+jPdT4lL39JFvtW0LT+aA7n2Mw36bsHmSLAFvu/IiYLkVZMBryE7jDP2PDyt3E+r
         yzE2sYch0c6V6hBD7I2lwyPq7pryC+JvRgd+tAvA9AiaJGgvckEU1dgcVKEmecQi6tJt
         pZHBWG7kJk5CUhb3NYuEBtYP4dioxIDmU4SklBYwAimxNhr2ZOnY71dJkDtbDhXIwtYh
         GkaysZpnFs8jmnnDhd4vW4MTsIucRfAbKix8x5+BPrB38NCMsh/eaXh/Ftvc0ADRHyoa
         Ms4Q==
X-Gm-Message-State: ANhLgQ1zP7aUzEQiap7FmoBRTr2yGt9Mngxh9PBiiCn4x7V2ohCEaEzS
        AjYj6YzrfdGn2oDq+Voxq+6vGzS4sXanOY/nOvUhFw==
X-Google-Smtp-Source: ADFU+vvIU0LlYeHeLDZSjyzG9od8EC9fwjBLEALNd8L/0q/e9uAE6B+ghoG9n8TaFthveqPymw6YMKolM/LvPYLRYQQ=
X-Received: by 2002:a19:110:: with SMTP id 16mr3859186lfb.21.1582932052865;
 Fri, 28 Feb 2020 15:20:52 -0800 (PST)
MIME-Version: 1.0
References: <20200226135323.1840-1-brgl@bgdev.pl>
In-Reply-To: <20200226135323.1840-1-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 29 Feb 2020 00:20:41 +0100
Message-ID: <CACRpkdY4=bU-gMywttvnRbgu=CG0TtKx5DFiV-Gio5DBDV08-g@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: fix bitmap operations related to line event watching
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Kent Gibson <warthog618@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2020 at 2:53 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> When operating on the bits of watched_lines bitmap, we're using
> desc_to_gpio() which returns the GPIO number from the global numberspace.
> This leads to all sorts of memory corruptions and invalid behavior. We
> should switch to using gpio_chip_hwgpio() instead.
>
> Fixes: 51c1064e82e7 ("gpiolib: add new ioctl() for monitoring changes in line info")
> Reported-by: Kent Gibson <warthog618@gmail.com>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This looks good but where should it be applied?
It fails to apply to my devel branch where this lives.

Yours,
Linus Walleij
