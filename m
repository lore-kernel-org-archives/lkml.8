Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AFD8C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 07:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64741207D8
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 07:29:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KdzqRAP4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbgERH3z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 03:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbgERH3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 03:29:55 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E03D5C05BD0A
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 00:29:53 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id c12so3653326lfc.10
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 00:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0QQj8C5JeEmDZ6ZApGtOW1NT9hev78BCGty9WyW8HQU=;
        b=KdzqRAP43Jx15JsBd7CMIo/2/+5tguTprPLSwNIyfoZQ0+ufPuN6S/BANnhJsjrhDD
         DtP3v+cVRz1H4W7gZemFOLYygUe9Nnqc8CiVseZ1qH7MkopzW0uYIM/6QDifbVQUaEzY
         I9Io5hrtK55gyaPukpP3UulY28GmqBr7704IEqyzsek9z5cWKXKh+nj6/8N35gBEzKLB
         z7UbsMop5bQJkCqzM/P6qv2TYsuzenpxX9AvppK/Ewkg0FlUbL6cOIGLnAWxK13GtB1K
         pL1FPAWkCnhD9H5FlvEDJp4hPMXkM7uAmjEi0J/HlDU7NpDvA7JOV3+ynsGeu4wzmRsg
         XxWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0QQj8C5JeEmDZ6ZApGtOW1NT9hev78BCGty9WyW8HQU=;
        b=XacWjHJpUCV77qZxZpD3X0M9HTm9lqEafW/WR3bI3TSJLIv3jTHyC2M+GyoJBQGXOH
         ThDPqT/8v1UZQvla9681HxilKNnWbksNYmIelOiK6URRVGIWxoVuDfio+mGbo93BijjA
         IEqVVVhUdWu3C8Ti/KfZbtDfKzufYngBpzcliNci7l1ySiiaO84cCOsPofIrHhTlAmDs
         99wk4DubwUFpAPCcn9FCCQ9kE3WxYgaySZ4YJ5XcdZjeTjqYanJbDd74I8QKs8s3qWz9
         AICHzv0oVdbbFXDTSJr3fRQUaVAysIW2a4OekhQJ/N9NOhmmvp/09jfvVsHo7Z91FpiT
         6OoA==
X-Gm-Message-State: AOAM532jpaVvX7w84/u5JhEuvMuoUfvDmnp8NepC9ilOuZZ3unyzTpAV
        jPEh3RYaSPalByg0y1egbRhrCyG+ezFCiAqGoSE8Hw==
X-Google-Smtp-Source: ABdhPJx6fCXx6eAlYEP7owDMWFfg7cz4sOJv/yQfCTAhywTwMqJW95DyJ7NsllwioD8AhEiAVzPb9dcty/D6ToHML3U=
X-Received: by 2002:a19:c8cb:: with SMTP id y194mr7741076lff.89.1589786992310;
 Mon, 18 May 2020 00:29:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200513125532.24585-1-lars.povlsen@microchip.com> <20200513125532.24585-2-lars.povlsen@microchip.com>
In-Reply-To: <20200513125532.24585-2-lars.povlsen@microchip.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 18 May 2020 09:29:41 +0200
Message-ID: <CACRpkdZF++0AExBvDHNT+whKP2sNKnbczV4w9SXksG2Dyctecw@mail.gmail.com>
Subject: Re: [PATCH 01/14] pinctrl: ocelot: Should register GPIO's even if not
 irq controller
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

On Wed, May 13, 2020 at 2:56 PM Lars Povlsen <lars.povlsen@microchip.com> wrote:

> This fixes the situation where the GPIO controller is not used as an
> interrupt controller as well.
>
> Previously, the driver would silently fail to register even the
> GPIO's. With this change, the driver will only register as an
> interrupt controller if a parent interrupt is provided.
>
> Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>

This patch applied to the pinctrl tree.

Yours,
Linus Walleij
