Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86641C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 21:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6555120723
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 21:33:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cVMoA007"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436684AbgE1Vdw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 17:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436551AbgE1Vdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 17:33:49 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 006CFC08C5C6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 14:33:48 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id d7so11585lfi.12
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 14:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ldVlqqZ3FDUO39GbWvCw2m+scSFkVJIhpIYkWdVQ4CU=;
        b=cVMoA007x0WC8P0Eavx6zVMKjLDuUr4glWhnKahRTky7N7NQY5u4NOXaXnObdxzHuT
         oVdEJBQaFNTsXW3avIkZOOcA4a7MOEgPpG1FTYTJlr3H/A+5MsdKZuYHLALKA1hTsTsz
         nmdMr1H6K7UXf6Khy7HIzTdpfXrHaDFe20jiAvk9VqkwIjY/N7IUTipZv3UPs8h6qbch
         Ur20WUC4/3hoEy/O/EmxRehOJOPOYfjdGCp+svegVCMF+BHbcZgQ2peyPhSc/VLi1njQ
         DIYeC2j9gPhC5m8ns0cRjv0Sc1WhJ4nQ2GJ1Y5fgGOKFL54iW5TzCvQmUv4nwiYgMgrH
         OdVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ldVlqqZ3FDUO39GbWvCw2m+scSFkVJIhpIYkWdVQ4CU=;
        b=FI4v7pvGduF3VEJCnuNs3z3o5QZM4WPO4b96h0PJgdZGdRNzE+vIjy+vo2ickv92o/
         4yt1056yX6HlxKAg2A9Xau98SZkLKSyfxree9dr//SFGHU5VPfRgQJxouWcX+0lFZXMe
         anG2yXjm/7JiVjN7TjJyBGwKJbLF6FLbEEc2IZ/hZaBRp9V/dShpWFiXQ4lBzadNXo86
         6Kh+A7sY7Qfl2twrPEXli3vv6xr/fPDdFbV986B6EE+0pnwHdvmQd9w1IkaIu+VgSVF/
         4wNiq5sv6IZ9Mi9bIV1Na3PyP80NSmC3/AX6uNWzpPJwkq1yfsGwA4U2+bSBl+NrN6c8
         6Jzg==
X-Gm-Message-State: AOAM533gjji+gPnpDbQZnFwlvNFNRAzF+shDiMP9/I/PBfx8vaRvr3iu
        YD2vYHkUiND5uv83d6/fmYMitP/joRs9J/86CqohfQ==
X-Google-Smtp-Source: ABdhPJxytp5+z8yLyBf5URWT6WAXg7xT4q74X2N/N/glj43Z+YJ+j8wb6XzV80aoF25inuWQUDvoZnwgps7IqCez6bU=
X-Received: by 2002:ac2:4823:: with SMTP id 3mr2638792lft.194.1590701627388;
 Thu, 28 May 2020 14:33:47 -0700 (PDT)
MIME-Version: 1.0
References: <1590253873-11556-1-git-send-email-mkshah@codeaurora.org> <1590253873-11556-2-git-send-email-mkshah@codeaurora.org>
In-Reply-To: <1590253873-11556-2-git-send-email-mkshah@codeaurora.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 28 May 2020 23:33:36 +0200
Message-ID: <CACRpkdaMS2G6qLtGp05pZgUCGxdS2xA2a5_ahgrwqgzLmybWcg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] gpio: gpiolib: Allow GPIO IRQs to lazy disable
To:     Maulik Shah <mkshah@codeaurora.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Doug Anderson <dianders@chromium.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Lina Iyer <ilina@codeaurora.org>, lsrao@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 23, 2020 at 7:11 PM Maulik Shah <mkshah@codeaurora.org> wrote:

> With 'commit 461c1a7d4733 ("gpiolib: override irq_enable/disable")' gpiolib
> overrides irqchip's irq_enable and irq_disable callbacks. If irq_disable
> callback is implemented then genirq takes unlazy path to disable irq.
>
> Underlying irqchip may not want to implement irq_disable callback to lazy
> disable irq when client drivers invokes disable_irq(). By overriding
> irq_disable callback, gpiolib ends up always unlazy disabling IRQ.
>
> Allow gpiolib to lazy disable IRQs by overriding irq_disable callback only
> if irqchip implemented irq_disable. In cases where irq_disable is not
> implemented irq_mask is overridden. Similarly override irq_enable callback
> only if irqchip implemented irq_enable otherwise irq_unmask is overridden.
>
> Fixes: 461c1a7d47 (gpiolib: override irq_enable/disable)
> Signed-off-by: Maulik Shah <mkshah@codeaurora.org>

I applied this patch 1/4 to the GPIO tree since it is nice on its own
and it is soon merge window.

Yours,
Linus Walleij
