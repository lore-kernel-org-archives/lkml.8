Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4F82C54E90
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 12:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94B26206CC
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 12:22:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fRMfmTqU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729677AbgELMWP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 08:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729336AbgELMWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 08:22:14 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E66C05BD09
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 05:22:12 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id j3so13358865ljg.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 05:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6rE0fPu5jCjuTK0cRn6PVF83ctsvQUR9eqdpVEWEcp8=;
        b=fRMfmTqU/svnwd/DeHQpZqANKDRENpPQrFnFCdA6XrC7CAjuUBlWO5WlHhJX1VdFZx
         GMq8lToALBRe4c2J8T+QxKo9JnROag//KysTHoivaIxpklZerMhBClnLLRGkf6GTvxAZ
         HkmO3moxLpKmk6A6rO8oP7BDRG8DnImZgtRVlxbihuFkbxwz1Ua1Vkr2ST+iiVDtsiMz
         +M1+jQ3zq3lb0Xi3P6DDhvioJsSDIiVLJW6i37AU92QD1VUuBYzTzk/eg8zmrLXxDlHD
         ODaToJfeFvwuXa2LV7sZKRly/f9mFOUS9o9v8dILxoPCrjdsYLDHOnR6njLXYMKzYGwc
         5uhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6rE0fPu5jCjuTK0cRn6PVF83ctsvQUR9eqdpVEWEcp8=;
        b=qdU381/itdldaCZOzZYFfaxPsbN/txlmSgBBlRZMCfLcSm5kxR9ero+DIcVpXE7zkE
         zT1yfzbTPd2Sj8Ip2HA3k41G7Wp5wfjP8vfpV3hzJW6bikGdfEZyD6OgDv62q1bjP6bV
         Z+3WsS0az6DJWS4LmKQGdfH0aEGxKZusQ7XJioeC6EKSORN4opvTdmEE8AbtMazXn6TS
         sHF+EfH0Hz7EPHA9NAr0yW+obMibfsN83ocUQn5hKqtNffCvv3PXIpiRLrPcwfX+E32R
         YBOXQV/XG7lsu218AcM30vRC1lAZujvnAkS33JqsnqsH+0+t+XGem+PfUgMrH0oDlecd
         DrBA==
X-Gm-Message-State: AOAM531umjXj4osltBjHWyt3N7kfmj9B0hbzUh/dJLwjex8Ar+zXLDfO
        NImTPP0BR/EmNSKZg00Lt4LW50zRxfhEe2eGAG/92g==
X-Google-Smtp-Source: ABdhPJwIPX2HNFOXh8yU8/OwdxhhRENdd70ug7z8dIHFgzX2fvXuP4+XvRAkuMUcWF3Sb2fH8n4awGxwbFbw77QNBx8=
X-Received: by 2002:a2e:9c97:: with SMTP id x23mr1647314lji.39.1589286131013;
 Tue, 12 May 2020 05:22:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200430194617.197510-1-dianders@chromium.org>
 <20200430124442.v4.1.Ia50267a5549392af8b37e67092ca653a59c95886@changeid> <CAD=FV=WHoxdr++f7Y_NO=VnrnEPkP=+WS5u3j_5ifEjekhBWcA@mail.gmail.com>
In-Reply-To: <CAD=FV=WHoxdr++f7Y_NO=VnrnEPkP=+WS5u3j_5ifEjekhBWcA@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 12 May 2020 14:22:00 +0200
Message-ID: <CACRpkdb22QrOcJXrR1je9Cf8S9LnKCcnQ92ML2xQhncraKC1Pw@mail.gmail.com>
Subject: Re: [PATCH v4 1/6] drm/bridge: ti-sn65dsi86: Export bridge GPIOs to Linux
To:     Doug Anderson <dianders@chromium.org>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Sandeep Panda <spanda@codeaurora.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Rob Clark <robdclark@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Stephen Boyd <swboyd@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 7, 2020 at 4:39 PM Doug Anderson <dianders@chromium.org> wrote:

> One suggestion that came off-list is to change the code to make the
> numbering match up better with the datasheet.  Right now if you want
> GPIO 2 you have to refer to it like:
>
> hpd-gpios = <&sn65dsi86_bridge 1 GPIO_ACTIVE_HIGH>;
>
> That's because the code right now numbers things starting at 0 even if
> the datasheet numbers things starting at 1.

This is the hallmark of mixed-mode IC engineers at work.
They are at heart analog IC designers so of course they
enumerate everything starting at 1.

Digital IC designers are like programmers and start on 0.

Never the twain shall meet...

Yours,
Linus Walleij
