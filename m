Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83554C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 19:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6303E2076C
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 19:59:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Vo8PAURx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbgHYT7a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 15:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbgHYT70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 15:59:26 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98291C061755
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 12:59:26 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id a13so40598vso.12
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 12:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8b4RVU+WnTo74tNhlNkNqnD8k6zvXZjBOKRfwHkRmnI=;
        b=Vo8PAURx7ORtd6yU5einn0LAVp/LY4DkDOYh0P4dgOmDIaVsQRPmUDC28SYLYa9rqq
         SDKtkNjLuobPZZ5I+QrAE/JInPIxlmrhZKHva5dOV+4H+EK1EvC/dDnBaL2d0qUPuW5s
         ACUhet6iMVgWy7rrxhpcnQ6E2hoN0yuhAH4f4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8b4RVU+WnTo74tNhlNkNqnD8k6zvXZjBOKRfwHkRmnI=;
        b=TfTegqaUMJpucL5FQ6dliryoxpjoXrzEz5QIFIp84ImKlOPYsE9KzXFy9dC89cWMU7
         ZYHkXujB74SWeJy3zH801vODo8Lo8HTVud9K6Gfek/UQ2Xj+xEKMMs3d9N5yiuBA+sGH
         mBgOJrGnJ0J+pixHYoV0HcSq8YPunV124DIldMDoP71xD2BrxGPuLPn2Ysos6YtLBRPJ
         O3q1TiKntLtgn1/dMG8bQtSLlz4PMeMMoPHnM5ujahlXP71YbZCaVoxlo7KZ3vighPM5
         lR/MrNrnozPh68BnUVyB/EooqzUedynWMi6xKBys8gUJWnY6Kq85A5RUaYEiKK+luhFo
         jQCw==
X-Gm-Message-State: AOAM5330tUZAWHDFxb3YW7GtL2rA3Zdw95cm0FZoRvykjCT70vIMFGl9
        XFscWIu0MjKCxm2urTfiG7N7PW7SPeAjhA==
X-Google-Smtp-Source: ABdhPJzAUmm4ooW+N6mB1YBBR4GVrrmIOTMAnepeh6IfNX0yWgDk27+nn+sn8iI4ugbXPnt/O99nMA==
X-Received: by 2002:a67:6896:: with SMTP id d144mr7078009vsc.92.1598385565542;
        Tue, 25 Aug 2020 12:59:25 -0700 (PDT)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com. [209.85.217.43])
        by smtp.gmail.com with ESMTPSA id f16sm18461vka.7.2020.08.25.12.59.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2020 12:59:24 -0700 (PDT)
Received: by mail-vs1-f43.google.com with SMTP id a1so63832vsp.4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 12:59:24 -0700 (PDT)
X-Received: by 2002:a67:2787:: with SMTP id n129mr7024016vsn.219.1598385564167;
 Tue, 25 Aug 2020 12:59:24 -0700 (PDT)
MIME-Version: 1.0
References: <1598113021-4149-1-git-send-email-mkshah@codeaurora.org> <1598113021-4149-6-git-send-email-mkshah@codeaurora.org>
In-Reply-To: <1598113021-4149-6-git-send-email-mkshah@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 25 Aug 2020 12:59:13 -0700
X-Gmail-Original-Message-ID: <CAD=FV=ViaBn-HJ3d3ofLXNRKVaVDTKeOrMruvmEj9cVAGBntww@mail.gmail.com>
Message-ID: <CAD=FV=ViaBn-HJ3d3ofLXNRKVaVDTKeOrMruvmEj9cVAGBntww@mail.gmail.com>
Subject: Re: [PATCH v5 5/6] irqchip: qcom-pdc: Set IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND
 flag
To:     Maulik Shah <mkshah@codeaurora.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        LinusW <linus.walleij@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Srinivas Rao L <lsrao@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Aug 22, 2020 at 9:18 AM Maulik Shah <mkshah@codeaurora.org> wrote:
>
> Set IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND flag to enable/unmask the
> wakeirqs during suspend entry.
>
> Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
> ---
>  drivers/irqchip/qcom-pdc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
