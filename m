Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2DEDC433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 21:54:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70AC020663
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 21:54:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f+pV7H/j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728967AbgGGVyr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 17:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728001AbgGGVyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 17:54:46 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F24C061755;
        Tue,  7 Jul 2020 14:54:46 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id f5so35953827ljj.10;
        Tue, 07 Jul 2020 14:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mw9ocWXI/3Winsjd/zdOzkKp5mXluvkjruXDIwHGnG8=;
        b=f+pV7H/jxE5A09vwSKi25mWaiihc0xW+2LyKOKYlv/LaC3mO4H9vIezvnidmNHPMaG
         hpchsJhFEsmfk0oLazYcoqh6UPVLkgwnSims1jnpGVeVshHqH3z5Sc3Gz1a4B5Y1Cgh1
         7F2L7/PEATU7DhJj9/8OuzG53kjE3ABUn6RmBueXD0lB6qyZwjN8iBfm+l8H0yuKjpWw
         4RTe78vdX+AfWfsK2YlVFcvXLstOFW7yno+KG/OE0iln2zyLKSA38kMiJsXI8J62HwTv
         aFtCAkHwrzBTDIAzCkHLXVCT/keV1xSU/lHc3vlgEaQhSc0YxPm9Ob2bPRioK/2MpmLM
         M56w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mw9ocWXI/3Winsjd/zdOzkKp5mXluvkjruXDIwHGnG8=;
        b=PmxVJM/ykm2Irj/MOZAR8pO7kBKr7FX+RuBvSzUoQdTEdr7iRwkfrLeZae4GNj2GGs
         Ay5Z1zh9tSxyB5REaOwWorZA9C1aXOx27ruQemtLWqAoj0uoIMLvmh4GIIg+s0cBmZ5z
         qvFQsDEnxIwE6nd3oHOTKmRfZgXtDdxYNN3X/V8EdXiy69EFA14JE/y7sLSTBjDeHNle
         wNNJKOvDO1rtOytdZj8HSJrDew/r+nQNqNKlt0CktsP5cSnw42qfCu1XzkPD0Gm0gOJd
         9SoUfdLz7pRA+pHHIWstHMKyX/iewk++XYXrLHffwe2P4kigTqVAvwVoq+vZEDCzaj1w
         NhPg==
X-Gm-Message-State: AOAM5310H1a9MI4kCLfGTMo5sGfNlFjzJ1i4PvsPkPhkPYdnt8RSrcTy
        BThs9TTjj93bRbTT2x7FMXc4RTf2iKb6c5BZbQUxGSeBNUQ=
X-Google-Smtp-Source: ABdhPJy/DPq/DWTnFO6suZ0QEd4jhHjniD95rpRqxsWkQ3qXaxxBDq5fHv8MdM3C8Z/5X5gofXFVCY2KR1NMS3oh0qo=
X-Received: by 2002:a2e:a168:: with SMTP id u8mr2842548ljl.178.1594158884940;
 Tue, 07 Jul 2020 14:54:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAFXsbZrVZjiyO_G6z6T82t0xT36Zi2gGo0kPnt6n58R-rO3TVg@mail.gmail.com>
In-Reply-To: <CAFXsbZrVZjiyO_G6z6T82t0xT36Zi2gGo0kPnt6n58R-rO3TVg@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 7 Jul 2020 18:54:33 -0300
Message-ID: <CAOMZO5DctkSWri+6Zh1HfSWFJcz=nb8eUHZsvwFwRZ_B9ZCSTg@mail.gmail.com>
Subject: Re: [PATCH] ARM64: dts: update MDIO speed and preamble for zii-ultra device
To:     Chris Healy <cphealy@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris,

The subject pattern used for ARM64 i.MX patches is like:

arm64: dts: zii-ultra: update MDIO speed and preamble

On Sat, Jul 4, 2020 at 10:26 PM Chris Healy <cphealy@gmail.com> wrote:
>
> Update MDIO configuration with zii-ultra device to fully utilize
> MDIO endpoint capabilities.  Device supports 12.5MHz clock and
> doesn't require MDIO preamble.
>
> Signed-off-by: Chris Healy <cphealy@gmail.com>

Other than that:

Reviewed-by: Fabio Estevam <festevam@gmail.com>
