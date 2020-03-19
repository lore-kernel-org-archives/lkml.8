Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44ADCC4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 14:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DD11208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 14:14:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AZOPCFBQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbgCSOOk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 10:14:40 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40763 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727188AbgCSOOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 10:14:40 -0400
Received: by mail-lf1-f65.google.com with SMTP id j17so1753964lfe.7
        for <linux-kernel@vger.kernel.org>; Thu, 19 Mar 2020 07:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OxjXVpGbkMkJ0WExSWqPpSaBQvMwnWJnTr1Wx+V8SG8=;
        b=AZOPCFBQYSqsz/AEYGuuPOzJTdJ/ZTsTX/5uwunSTWHVK4GeC09eczWB8hdsOqDQsH
         NE8V3RKBTTt/IsOKfyue6IUukFCUmj3uB93xzQ16sNd3pX1n2wcUou3DKPqS5PevTns+
         5LNt1lCgFE2eWtnlkTxMBQdN+pvFJKsgupqIqdXFoBTY7yLdtCl4MwY5foZ598hflKd0
         QT2gQX4or7spIgIPXs8+H8T97cA1BW9Up0Z2Vcurti7BHsL+aF7uRlooa5KRFECreWJz
         bd8L7aFaU+J0uvbvpWCM1DHhdsSBSToFgHhOJr52xfwt7vvwoFoygtLsq273UwCfnbVy
         J3Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OxjXVpGbkMkJ0WExSWqPpSaBQvMwnWJnTr1Wx+V8SG8=;
        b=IU5eWQfQL7X1cM5rG/yInjThnf4HD9lshZ0F6pEW9XRQxkRbgCWP5TI+JfhO3qY8DZ
         NXvyySFeuGwJG9XQtQvFx0UPHLOV2Bs8+qvFDbh0su1FKIa5gCqzkpcY7gA4/VfKMVQ1
         Z8K+Wb8GB1aDF9LqdgmfE9oZsIEkcfzV0hZpXZoBSXyPWAkO9amN5WrtqGoxFXykZCgK
         Z3JzyXh8XLWdN9ZCArt3MrxlCvyyBcTdzmjJXINAdxPFF9MFMIDrPqJbZ4nuW1GkmjRk
         hustI+ITijK6nRMKvxC4AT/2h6rJJhoPbV3T/ftvHC6/0gnVfm4PQdBnoPC+m6gmzQv8
         JOcg==
X-Gm-Message-State: ANhLgQ0RzTCbwyHaYZmhyA5PE2wwrQ+0XWJO0GKIMzbFvERyBqqcBNQ0
        jzjw/i4IFNtc/lSmL1Y2JC5MeUcA+F3z+KFFF+Kx5Q==
X-Google-Smtp-Source: ADFU+vt1yS1vI9ljM0gwVaf68ZRjuY1p2nfT2WzK32ag3cYSnzmKGhQi4YvVl/W8DZtvTQtWWxSu7seu9AnqnrT9Fjo=
X-Received: by 2002:a19:2353:: with SMTP id j80mr2188497lfj.4.1584627278167;
 Thu, 19 Mar 2020 07:14:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200316133503.144650-1-icenowy@aosc.io> <20200316133503.144650-3-icenowy@aosc.io>
In-Reply-To: <20200316133503.144650-3-icenowy@aosc.io>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 19 Mar 2020 15:14:27 +0100
Message-ID: <CACRpkdaVrfd1p+WyACy-gq-3BPsXJ_CZwi2OZe+=csseBcvcaA@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] dt-bindings: panel: add binding for Xingbangda
 XBD599 panel
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Ondrej Jirman <megous@megous.com>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Icenowy,

On Mon, Mar 16, 2020 at 2:37 PM Icenowy Zheng <icenowy@aosc.io> wrote:

> Xingbangda XBD599 is a 5.99" 720x1440 MIPI-DSI LCD panel.
>
> Add its device tree binding.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
(...)

> +properties:
> +  compatible:
> +    const: xingbangda,xbd599

As noticed in the review of the driver, this display is very close to
himax,hx8363.

I think the best is to determin what actual display controller it is,
I think it is some kind of Ilitek controller since Ilitek ili9342 is
clearly very similar.

The best would be something like name the bindings
ilitek-ili9342.yaml and then:

properties:
  compatible:
    items:
      - const: xingbangda,xbd599
      - const: ilitek,ili9342

Possibly use oneOf and add support for the himax,hx8363
already while you're at it.

Yours,
Linus Walleij
