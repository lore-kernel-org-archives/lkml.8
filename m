Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F09DDC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 02:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD5BB22DA7
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 02:33:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kVSbdH9S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731906AbgFTCc5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 22:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731880AbgFTCc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 22:32:56 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 057A2C0613EF
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 19:32:55 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id n70so8796790ota.5
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 19:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0D6RM81CHxtLSPNd2h5o+DyxuvzJSa5Nzy3+jmmUj6k=;
        b=kVSbdH9SLZhwQmFcOG+gMjul+MkxrpcfmmL5nmRC8j3xNsYEAGsXj5Ad47nXUniYS1
         PZc0bfZYz5BSae/9VozU/EhlVyuy4YFoz3hPBpPgIHrjmMrlFKZiZhnofnPcILGl4ScO
         t7vzCj+Zum03GDj4Q9ndBVVMKYO7bUhHNf8ha76qXC2YG6tlYcXK9v8Is/4HfwPCKgR3
         HIjbrPfrot3wmhDhuPovWXb8NCmq4ZkzpEsNF/lcfeOS/bT3d9I5vKROM2bKMjG5YIAL
         BrehL9e118MzeTeXR11y6VOZtXts/3lPlw2h1duJUZzom6sHt70zltClI55Q0ZNh3vKq
         FZgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0D6RM81CHxtLSPNd2h5o+DyxuvzJSa5Nzy3+jmmUj6k=;
        b=hKxMgpZe2S+WgSyoNgSoIkznXi9Fxz5tvDBvSFU9GF6bqVQHacdxET/4qu8vRrRJ9y
         RCzzFX0NBu7Mj0276k1mnnOLAXCWeRpHcDXYytbUpCQy4anMSweZc0yBgHGPy0kSDgqK
         a6b0MTieMYpDanQF+Veq80r5oZkNNc0ppuih7c+S9BG+Yi+2q4rLfTsqLcx61jYSBPYe
         1s/avXCQ4+jneYj7qd0VFvYfWwYkzJfKNuQZjSub+sfoJBdP4FDZiMnqCj0A3h2JSgIm
         ANMciJFmXSMWHjf6vnkOoLNVmrM2VcUhj0naY9h98onb/S6QF+Dq/cM3+ulVmQAvF9vR
         cqnA==
X-Gm-Message-State: AOAM5336cKM/89Hrx6vi7QnQ1/t8kJwARAs62QLcQWD/oDKlXXpeFafK
        J1+WasyLdWyrNZNMJHhd28pp74qY9wT+mbEwCJYBEg==
X-Google-Smtp-Source: ABdhPJxEiXH06dVVQQgwAAkquvCNpg4wOXt0fbkrP+XzPPPLx6X3/Hj0NM4tYLWfkqawUdxNY3Oz2MPc1FLWO8yu84s=
X-Received: by 2002:a9d:67d6:: with SMTP id c22mr5217355otn.221.1592620374200;
 Fri, 19 Jun 2020 19:32:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200617105950.3165360-1-vkoul@kernel.org>
In-Reply-To: <20200617105950.3165360-1-vkoul@kernel.org>
From:   John Stultz <john.stultz@linaro.org>
Date:   Fri, 19 Jun 2020 19:32:43 -0700
Message-ID: <CALAqxLWSBrYWK8ggzd7JU4F8QGuLpP6D5ENxzYc8XXype84Jyw@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Add LT9611 DSI to HDMI bridge
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Rob Clark <robdclark@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 17, 2020 at 4:00 AM Vinod Koul <vkoul@kernel.org> wrote:
>
> This series adds driver and bindings for Lontium LT9611 bridge chip which
> takes MIPI DSI as input and HDMI as output.
>
> This chip can be found in 96boards RB3 platform [1] commonly called DB845c.
>
> [1]: https://www.96boards.org/product/rb3-platform/
>
> Changes in v3:
>  - fix kbuild reported error
>  - rebase on v5.8-rc1
>
> Changes in v2:
>  - Add acks by Rob
>  - Fix comments reported by Emil and rename the file to lontium-lt9611.c
>  - Fix comments reported by Laurent on binding and driver
>  - Add HDMI audio support
>
> Vinod Koul (3):
>   dt-bindings: vendor-prefixes: Add Lontium vendor prefix
>   dt-bindings: display: bridge: Add documentation for LT9611
>   drm/bridge: Introduce LT9611 DSI to HDMI bridge

Hey Vinod,
  Thanks for pushing these!
I know same-company tags aren't super valuable, but I'm actively using
these patches for HDMI/audio support on the db845c w/ AOSP.

So for what it's worth, for the series:
Tested-by: John Stultz <john.stultz@linaro.org>

thanks
-john
