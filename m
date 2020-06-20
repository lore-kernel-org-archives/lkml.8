Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4529DC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 21:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 246BA246BF
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 21:23:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BEK7VN2O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729029AbgFTVW6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jun 2020 17:22:58 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43205 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728999AbgFTVW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jun 2020 17:22:56 -0400
Received: by mail-lf1-f66.google.com with SMTP id g139so6711570lfd.10
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jun 2020 14:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bu69mp6xYWLDQSTwZZePNMWDQ59FaV2SiSFYy8pjBQY=;
        b=BEK7VN2OmrlKRSG/e9OsYVGM9t0SGut4yO1XoCDqBns+EyWe9Og4n1eX2t4nRltuL+
         x5wfhHR7jj3CWrLxOCc/LnjcDRGn+rRWym+xRsNFal5F7BVlIaNboF1Ff5lY7mkcVhWE
         /JEM0Eo8ek/fwjZ64aZFUCx4MEpNUiR4uNUdjQTfPproxhWLhl/CMnd6vRMJ/Vh+olps
         ESgLuxAtySplCfoo6fYq9gGdfDhkF3xosvL8nhrcKABMAJduOdka/pQcUaJgAO8l26Vm
         kbfRxelGF5uRFZcgvdniVOyCHhz8FcHM95iT57XAuctop0mBCkRlA/zLwFo1hkKAXzsg
         Ss8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bu69mp6xYWLDQSTwZZePNMWDQ59FaV2SiSFYy8pjBQY=;
        b=s7vjfbicg7HxOWW+z6tLhFzJiN4AJZnBQBUEPtQyzcBib1cdNb+GpcxFcgDwKqMnFP
         iD4QvUDqIpt0qly3p+te6xJqX20RqxfNy32HeVOO2VkB5nWdDCzN1aZBIqkDO3z/a44n
         NBJFvA1Mth2JT3DP0CSZl7s2txv9jp5zau3x4Q+ddZD0iOzUSojqs/tv1QQFpn6up65L
         pHx8/YGBLTmL4lMjD117oUXA5cHxu0NyJudKO+isY/Iw4ciOdLD4XAZs0WlSnPbhIagm
         9rxf7VzOUAoOFNoawKGo/PtyOHScRGOUr7SIvNyan7lM66meYODQ3xFFIOPyO7YM4YSF
         dXMw==
X-Gm-Message-State: AOAM530CEZa3thm0olOM1z2QBpb3GYlV4pV+yjdNJBiRDKt1tZO1g3ZE
        IcadUyY+BSDxA/IBCmVb0d6pjeRhb9Ws/0D9zF+dJw==
X-Google-Smtp-Source: ABdhPJy/RkTLIDBZFRMNpiPSsRVm5Ak3I4Hbs3gJhBT50nyx7v4sALg7fToWgIJskHBwAdm4KDklfhLMkVmhKWNt8Ak=
X-Received: by 2002:a19:ccd0:: with SMTP id c199mr2956592lfg.194.1592688113991;
 Sat, 20 Jun 2020 14:21:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200616061338.109499-1-john.stultz@linaro.org> <20200616061338.109499-5-john.stultz@linaro.org>
In-Reply-To: <20200616061338.109499-5-john.stultz@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 20 Jun 2020 23:21:42 +0200
Message-ID: <CACRpkda35FZC=uXr-ipxZQ2SWU2tUincOztJmDt+Sa52FKQs=w@mail.gmail.com>
Subject: Re: [RFC][PATCH 4/5] pinctrl: qcom: Allow pinctrl-msm code to be
 loadable as a module
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Saravana Kannan <saravanak@google.com>,
        Todd Kjos <tkjos@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 16, 2020 at 8:13 AM John Stultz <john.stultz@linaro.org> wrote:

> Tweaks to allow pinctrl-msm code to be loadable as a module.
> This is needed in order to support having the qcom-scm driver,
> which pinctrl-msm calls into, configured as a module.
>
> Cc: Andy Gross <agross@kernel.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Lina Iyer <ilina@codeaurora.org>
> Cc: Saravana Kannan <saravanak@google.com>
> Cc: Todd Kjos <tkjos@google.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-arm-msm@vger.kernel.org
> Cc: iommu@lists.linux-foundation.org
> Cc: linux-gpio@vger.kernel.org
> Signed-off-by: John Stultz <john.stultz@linaro.org>

Unless there are dependencies on the irqchip patches I can apply
this if Bjorn is OK with it.

Yours,
Linus Walleij
