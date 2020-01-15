Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF243C33CB1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 10:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A06FE24679
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 10:23:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E4jE3An7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729701AbgAOKX2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 05:23:28 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41112 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729602AbgAOKX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 05:23:28 -0500
Received: by mail-lf1-f65.google.com with SMTP id m30so12260078lfp.8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 02:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0kDyGOaxaI1GMqThNHth9V/5VSfUUwVFewl6E0xy0nc=;
        b=E4jE3An78Ex2CgQPVi5COQjsp0vDCZeW6pA72WOdA+dPszIB5smmk5ZEh4dswC0+er
         OwY2CCBnl8JnyoX02lSRZpLJK2slg7BhZGnfdOXQwQN9j/Nro48Xxg0+Chv3rwmAm5Mi
         KXIfKiTiWjOg3GKkjypiRFqPKGBWBOWc3wP5bfSNKDgTRWafDjGWwvNGaXdMMVtZ0pwy
         viXP7tzxMcPo7JTth0XG6xK5L5A71EcSTOdGLMhHbmfsg7LPtruMwMMJR+kDpLKT8cg2
         rdPsl9+BkssxuDwNvACevxoT4h3y7ObHKDLDGl8vSgBhdVpG7QIuvsQIP7Z7+oEQnjkR
         20aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0kDyGOaxaI1GMqThNHth9V/5VSfUUwVFewl6E0xy0nc=;
        b=QIQn66JFND2f7zcsf109w6wdoy8rmBW0EMK53d1EKmaT5AMJIB7YlnnsEbORTeClBa
         9cPhDZvxdZJ/scduQJDLIQH0JbeJeGFJV3D/IWO6j1AKuNq6mdvLOXX0gD862uMVWTgH
         pei5oyx1ud7/ZhTid93dLDFW+fgp5ODNdXDUfOTcWs65jg1S2nXh5Ne2ovZsB/xKCMwZ
         Fxw8qi3EGAHwJqE9WLWTkv+Tr9aj2gFGPmWA2hxjgnC+tVPxALZzQwp63xrtVMWn/SG2
         +MHNUDY3uDwEDIZ47X1JR8d+ZSlOTq10cq+XCQelTB88uX4m8bWm/ynFmFozMXOP/Ynv
         /FaQ==
X-Gm-Message-State: APjAAAVdfYGOUEmbd9/n+EAsi/DKYWj/83CTyP6LzLnp6MVAohFe9MZV
        Gji5tKjOOx748cuX2sivT2duyMDOWZPu52mc6g1/7A==
X-Google-Smtp-Source: APXvYqzoH/cbCUM9WkqwMpVkWL8950Zqu8b72maR4cxbaUVrgqLDgiiLP876Lez3Tc1YvlB2kW9QJ7yqo7qN1cw9djc=
X-Received: by 2002:a19:5513:: with SMTP id n19mr4126113lfe.205.1579083806398;
 Wed, 15 Jan 2020 02:23:26 -0800 (PST)
MIME-Version: 1.0
References: <20200114231103.85641-1-swboyd@chromium.org>
In-Reply-To: <20200114231103.85641-1-swboyd@chromium.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 15 Jan 2020 11:23:15 +0100
Message-ID: <CACRpkdbzqeAo9+muiTez3PjSLS3-pCocktFe2Lm8tDMVzSnr4A@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: Set lockdep class for hierarchical irq domains
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        Brian Masney <masneyb@onstation.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Marc Zyngier <maz@kernel.org>,
        Maulik Shah <mkshah@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 15, 2020 at 12:11 AM Stephen Boyd <swboyd@chromium.org> wrote:

> I see the following lockdep splat in the qcom pinctrl driver when
> attempting to suspend the device.
>
>  ============================================
>  WARNING: possible recursive locking detected

Thanks Stephen, patch applied!

Yours,
Linus Walleij
