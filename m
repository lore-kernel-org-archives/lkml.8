Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F146AC433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 21:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC5F9246AD
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 21:12:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ejwQKsS9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728993AbgFTVMM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jun 2020 17:12:12 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37834 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728980AbgFTVMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jun 2020 17:12:10 -0400
Received: by mail-lj1-f194.google.com with SMTP id e4so15277708ljn.4
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jun 2020 14:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XJEVsWfbn8aRBSjCUjQoaB/zi3FIbrrLmSUqtBf4ufc=;
        b=ejwQKsS9R74OVx4oleO34kJ/97nhPXE5oUxGSV3txe70SwiGWv62+473pSxKiEXCDL
         U5tedGRDKcJ42HmweVyL/YeRulQyKi1SjAM3wF5aYfzAVtLFlSXfhdyjkmS73imjEvlu
         mUf0ycwAmGlre8Y5z0bue63mfiIvmQf9NqndNnegmKmECrygz6SfWdTy7X3xxiGd+gRR
         +yQfN3RYHAGEDVUXCzjyj1IrM2oscTM+NA2sd3pyB8aGw9ES6CX3evJhV43ja5C7okJ1
         pGlD4rxPQ9+Lg427gcKNTxNbkPUt1/zLlPM8E2ZhiDJtCxpWA0tEg/WZnrnmtzOhiXsc
         0PrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XJEVsWfbn8aRBSjCUjQoaB/zi3FIbrrLmSUqtBf4ufc=;
        b=LA1bvqp5nHj6+9/R4HDHhuzvE9OqA3zeuvVSZEpjlZXf8vNBJtqvLKThw3IiQ0TivQ
         mncJiWp++NkFnA0ihU4ReZsMBzJWcG80Kkn4NRJBJxjlnasKr6Cmx7lp90mIP57ssMHT
         VYBsp7IomEv5NtU2CJGokUeRKIbiA3+25HRJ1clUniL34n3G+1wX2/Up7EqkzBSi1O4L
         l+uDzur+G8NKtnxgCbKZ2NeOQdOhQwAbWe66dJQs5zW2cVgJ3C+HFRve6DGq2GCqs/fs
         OGWvXKNZF3d2gG/gdoW5o5bB54FTm7HIGmEHJdrlU7EO2d33lITeauAPx5qQgZPZCCct
         uSNg==
X-Gm-Message-State: AOAM530rUxr7kyyW1eLdTMoczwNITFakBPL2ZiR2jL6ohDZGY2ea4gc/
        mtBuKc6ka5CSgtHUFNvQdamyuVQTP/Cds7FvSw7HOQ==
X-Google-Smtp-Source: ABdhPJyNzj8lntNB+gPdQZorIuGyuglVZ2GRN4JTEikAZoHXf3zt4iKWY8HyVoOjoJhJdUnny/FjxeRZZMdO0eg8d0w=
X-Received: by 2002:a2e:351a:: with SMTP id z26mr4790421ljz.144.1592687468252;
 Sat, 20 Jun 2020 14:11:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200615133242.24911-1-lars.povlsen@microchip.com> <20200615133242.24911-6-lars.povlsen@microchip.com>
In-Reply-To: <20200615133242.24911-6-lars.povlsen@microchip.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 20 Jun 2020 23:10:57 +0200
Message-ID: <CACRpkdaWZeMCNuwUNzyYd+g9Q75F_8o7K1Npxr46V+-Y4z-6wA@mail.gmail.com>
Subject: Re: [PATCH v3 05/10] pinctrl: ocelot: Add Sparx5 SoC support
To:     Lars Povlsen <lars.povlsen@microchip.com>
List-Id: <soc.lore.kernel.org>
Cc:     SoC Team <soc@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Olof Johansson <olof@lixom.net>,
        Michael Turquette <mturquette@baylibre.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 3:33 PM Lars Povlsen <lars.povlsen@microchip.com> wrote:

> This add support for Sparx5 pinctrl, using the ocelot drives as
> basis. It adds pinconfig support as well, as supported by the
> platform.
>
> Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>

Is it fine if I just apply this driver to the pinctrl tree?
Otherwise Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
