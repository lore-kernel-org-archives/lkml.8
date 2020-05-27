Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39ED1C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 13:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18A80208DB
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 13:45:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cEtxG1QB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388660AbgE0Npo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 09:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388651AbgE0Npk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 09:45:40 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E22C08C5C2
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 06:45:39 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id x22so14495078lfd.4
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 06:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pqMjF481/emegOTyAnp90i2QSPi+4HPq/HRpDph3sd4=;
        b=cEtxG1QBb6k0/9pivnXsIM4fxxgTmO6eKy3cb4jjp5+kQNfHVlksx1KW++A7tdPXNv
         oY2Ob0P9vNNprE6p4NGP04bu/InKQ/EF4F2+wJwW+oY9E8YyJqJNZGtPMuzc5qLL0HWI
         fbhtYM7PcCz7DfVylsOzqby5Qs3IHhHLLbl9blKfUGBSf4zaaAgjnl5o0dbVSJ4DvPoW
         Lx+VZEycnhRAGhdVQAj29L9RY0uZ6YY2m8X2b2LqnnTUPWNtVuoZ+MHCVqwRrOEjYOq/
         EKnUL6kl2azL30dBaSZuMa/KxZcpN6UCJO8YV+KqgmxgC4f8GArCvy88KgPw8b2F4xLC
         ixNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pqMjF481/emegOTyAnp90i2QSPi+4HPq/HRpDph3sd4=;
        b=Xb9ngJ7tDiSOpsccAacB+5kXe4GVVWNaF+DmEZi5sQ1ws03J0vT2sS/EucH+04KIRz
         W573pBbKjr76INzbCk49NfxQQobyI8oE2w1fzLjMorKraqxX8pBSm88m82KAuDYfRF8b
         xQGhbTQSj0DA/JG0NNJR5pyght8QZ36bIGmKbDxRg90Y+96+i+E/lkJZq2kcIp6lxfGZ
         20XPUXA/T+fjf7VNokgeA8LhyOeYI+IIB18lrtM7gUZfOwD1ike5cG4gUcS07QRq0bBo
         sPpESaU7EXp1TGjrClRLN480fCxaj2YBQLVdQagi0Ku6TyI8OFzARz5OZkTC3UD16Eke
         WnNQ==
X-Gm-Message-State: AOAM5337CnrIWW9gkaqU+Sv/WoMe/vXzIq56AMMbMhRx4TOrwWUWQJ1R
        kRc/JqdoX5sAisawoYwWvprlAtWcqSHwuxCVShkRvQ==
X-Google-Smtp-Source: ABdhPJywnRjyy63BmYPCVd6xtABhxO8rvnbtGtftY9/L9Axjxr/II+eDgYpm5vNmJPSCVWS3wWgZuzCOQirdIHM52xc=
X-Received: by 2002:ac2:5473:: with SMTP id e19mr3147605lfn.21.1590587138395;
 Wed, 27 May 2020 06:45:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200513141134.25819-1-lars.povlsen@microchip.com>
 <20200513141134.25819-2-lars.povlsen@microchip.com> <CACRpkdZa7OM3bqB+zRprEQ3M4m9hG3uPCoYxrdH_O=oxD8zi8Q@mail.gmail.com>
 <87pnb1nf2j.fsf@soft-dev15.microsemi.net> <CACRpkdYesD9sRQZXQNEaBY2Ouu3bjKKGWpRtU-Lpa4AcjyPwXw@mail.gmail.com>
 <87r1v8oz9f.fsf@soft-dev15.microsemi.net> <CACRpkdaJvaqPptPD-A1DriVgBOZGZ4Qf0UsbsjG39ptx6bSJKg@mail.gmail.com>
 <87pnappzun.fsf@soft-dev15.microsemi.net>
In-Reply-To: <87pnappzun.fsf@soft-dev15.microsemi.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 27 May 2020 15:45:27 +0200
Message-ID: <CACRpkdbfNPWKDU5zDaKT0kvJhCpL3X=jvTpLpicm1yMD5brA8Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: pinctrl: Add bindings for mscc,ocelot-sgpio
To:     Lars Povlsen <lars.povlsen@microchip.com>
List-Id: <soc.lore.kernel.org>
Cc:     SoC Team <soc@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 10:05 AM Lars Povlsen
<lars.povlsen@microchip.com> wrote:

> The only issue is that the gpios on the same "port" have restrictions on
> their status - they can only be enabled "all" or "none" for gpios that
> map to the same port. F.ex. gpio0, gpio32, gpio64 and gpio96 must all be
> enabled or disabled because at the hardware level you control the
> _port_.

This is fairly common. For example that an entire port/block share
a clock.

> But as I noted earlier, that could just be the driver enforcing
> this.

Yeps.

Yours,
Linus Walleij
