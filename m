Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A19FC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 10:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC9C420760
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 10:05:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nhrKiqzO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728099AbgFJKFu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 06:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727884AbgFJKFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 06:05:49 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28286C03E96B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 03:05:48 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id q19so1740211lji.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 03:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aJWA5EpqlX1BZBX+8gqs4zVSU/BhYrj1d2QAoQsiYgk=;
        b=nhrKiqzOFvLR0OC1NX/xCGyKdJBwnxJ23IZ3mj+TDKpSSFR0QZJVWUdu5pbAJy6nN2
         kP70DZX/YVAlL2kWeI7k/GucL/aKQzheoLwmLs0USyNS6D7yIvpZzYOOZT/w0oThuJNi
         s+OOqVCCbnwhKwq5NwQ/2SZy8uywYfk/iF1JccXlNiu0+/HRNU8fjlOzyGi/orbJriJS
         FIq6uzayOVG1AaGTmEc2F/i48Hrvf3p2w27Js5WWQlhauk0FqvVmJ30o7Ow8SObCj6Nt
         nYEo52Etk3d51C/ktOXVYUXFrHSS09kr/q6i/YU/m5wl1UMIJv4b5AnTofFut2k7EOB1
         IikQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aJWA5EpqlX1BZBX+8gqs4zVSU/BhYrj1d2QAoQsiYgk=;
        b=PsLYB74Ps63gTENiZG3xi+/6AP4OkjD8bWiFsJEMfLhQkD5iBfNljhoydFVGyKo4PL
         NS7kyZjEMzLsM8ruQg4RWhNRxCbGANhuYvj43GxFAw1QDD/DY58J37W1GtRN2c1vxOsU
         xaxcc0wLKyBQds0C0g0XjAJxuUpsKECPxe596RmZii3sEeRVU3LuRL14hLbglGLxfNdg
         0qBFQglhVpOLLkZhT3UDPXthq86hucDHaSvXESkLOaKcboFJbqiPZc17LoplD26wVroc
         d2WdhCHIsMUDdZGhROX5KvvXuIRkH2afsHGG+9yV8lCgLb0y9mhr7eNUWaZB6w2zqPvp
         56nQ==
X-Gm-Message-State: AOAM5302OYd66eABUIlCmtL+LK4cR0JTISGpcSCiOYebnwWVe618Pc34
        QK0foTrI7IdCuKEozkLUuMgafCV7TLGnahhkQzTrbg==
X-Google-Smtp-Source: ABdhPJxSCEjghdjwebsJyukomoJ1ZbRO+EZF84d3444cwUPi2mrnedD3WOTV2G9VFBg7F5ZOi8/Qqh95qYa7Q8oNEyo=
X-Received: by 2002:a2e:974a:: with SMTP id f10mr1395304ljj.283.1591783546553;
 Wed, 10 Jun 2020 03:05:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200607174243.2361664-1-paul@crapouillou.net>
In-Reply-To: <20200607174243.2361664-1-paul@crapouillou.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 10 Jun 2020 12:05:35 +0200
Message-ID: <CACRpkdaRND-WWr_4umLwK3VHmizTStLQRoVa6MAhRYAaBVYHcg@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: ingenic: Add NAND FRE/FWE pins for JZ4740
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        od@zcrc.me
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 7, 2020 at 7:43 PM Paul Cercueil <paul@crapouillou.net> wrote:

> Add the FRE/FWE pins for the JZ4740.
>
> These pins must be in function #0 for the NAND to work. The reason it
> worked before was because the bootloader did set these pins to the
> correct function beforehand.
>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

Patch applied for next (v5.9).

Yours,
Linus Walleij
