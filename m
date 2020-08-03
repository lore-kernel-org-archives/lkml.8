Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AAFAC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 23:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77B0A2076C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 23:23:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ekvkT2Ee"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729258AbgHCXXY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 19:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726350AbgHCXXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 19:23:23 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87CEBC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 16:23:23 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id x9so41544190ljc.5
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 16:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iIqkaLsmRYNwvI6bANOrm3GY7t2TYOib7K7xtc0Wnx8=;
        b=ekvkT2EenRR1kmAkT6UQ9M/f2BfPNY/k7bzVRiOSaH8nhlJEjF17GKclZ4IfW+5bko
         fvzPAqqBfIePDWUc6FZ+AUsfn/03vAzON+BkgNVZC7zp98Ayp1EbOImCwIiQKE2ZrOc1
         7rpm7BrRXeVXUDJE2mzyUpbRPj9r+46ThGxQ2xj7ZaOQh0I8jiJtSv/rvZdr/BWs/Rmd
         6FMC3Xo2piygZJy9W38tVIx9+pC+wX13ftICj8HA+M44U5356voiWpEpQ0SaLLkKEgmo
         fgf+LKy0okYBqwhp1arfSMfzBJKbjfWUd3nDTZDeXSJ8yTnScrmBuE5TvQhUgBTt67RE
         wzvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iIqkaLsmRYNwvI6bANOrm3GY7t2TYOib7K7xtc0Wnx8=;
        b=OqnV0t3U6F4kMJ4akaNZcTbTihgt+5snKYnRglUBQ9Xq1KOQGih54cgUdKNfnaeuH1
         MCAhWHs1RZaKtG/7eBf0XbsbKH7/MtDDwFnsbiFYDc+r0UIHkjkdqEgJSwOkb8bEmJi6
         aP08Z+r+0dXpPy2Yr8F6TISQYOcawImdnpspBXgq32dmCnNw9/wB9dQPeUb+faW3ct9o
         /1BggFKJ4USWdWT5tAyXoKIOmFe7XtjnXRrrA3NODn1iShO6EzXLq32xyCwMe80hqrbg
         VsciAkJOUaqr+PWh7zFMS9LSWT+1fjMZn9olIUOB4uuj3Zq+IAfL5UkBmONCnUQwfr0p
         hSuA==
X-Gm-Message-State: AOAM531/gjUBBp3n/fi6mRPsQyrAJsfE6Yk/IQCPQoK2HavMpu3yLMly
        0nWsUl50/MLoZfSCgFsJrH51P0khUYAaI2co3TWByQ==
X-Google-Smtp-Source: ABdhPJy993KCvqmJ6qcVxr7LQlERMXDim7CepdvPMvnSY0k2p0mtfSTk1djJW/0pxxuNiCxxXGo/UQippmenT+ukDcI=
X-Received: by 2002:a2e:b80b:: with SMTP id u11mr5428827ljo.286.1596497002032;
 Mon, 03 Aug 2020 16:23:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200731123835.8003-1-a.fatoum@pengutronix.de>
In-Reply-To: <20200731123835.8003-1-a.fatoum@pengutronix.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 4 Aug 2020 01:23:11 +0200
Message-ID: <CACRpkdbhpFae+Phf6Vxih7f2eMWAkYArmi8Bwp_yMEsVpG5xgQ@mail.gmail.com>
Subject: Re: [PATCH] gpio: don't use same lockdep class for all
 devm_gpiochip_add_data users
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Thierry Reding <treding@nvidia.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 31, 2020 at 2:39 PM Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:

> Commit 959bc7b22bd2 ("gpio: Automatically add lockdep keys") documents
> in its commits message its intention to "create a unique class key for
> each driver".
>
> It does so by having gpiochip_add_data add in-place the definition of
> two static lockdep classes for LOCKDEP use. That way, every caller of
> the macro adds their gpiochip with unique lockdep classes.
>
> There are many indirect callers of gpiochip_add_data, however, via
> use of devm_gpiochip_add_data. devm_gpiochip_add_data has external
> linkage and all its users will share the same lockdep classes, which
> probably is not intended.
>
> Fix this by replicating the gpio_chip_add_data statics-in-macro for
> the devm_ version as well.
>
> Fixes: 959bc7b22bd2 ("gpio: Automatically add lockdep keys")
> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
> ---
> This doesn't fix any particular problem I ran into, but the code
> looked buggy, at least to my lockdep-user-not-developer eyes.

Thanks patch applied, I think we had this fixed before
but managed to loose it in some API rewrite. Thanks for
fixing it up!

Yours,
Linus Walleij
