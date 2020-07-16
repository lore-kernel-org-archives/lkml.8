Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE90C433E4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 13:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D09E2065F
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 13:50:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UPe+Ak5h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728791AbgGPNuK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 09:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728087AbgGPNuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 09:50:09 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB4CC08C5CE
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 06:50:09 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id e8so7276043ljb.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 06:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W0iuDU+qCWBUM7ba2OgUNPdlmGMl1pYMR/idMsHed54=;
        b=UPe+Ak5h0P6Z8onkrvDvi6QUVwIWIGpi7uVLXWjnR50zvyoG8zkGEuyKrRvZqzeaVs
         7flptBJJLbpHGwORkLYAmufCmWvGfUkoNyHT5bGmX36i/a0HegWUvz96XnbuJRHWAfmR
         vaKpbaNCPOFd9kZAqffwVWkCSOErYcQim25VAwe6+We+6xCAbwHI++HQ5iwpKnw3NA6Z
         AMU1wu9f4MKmZW6eE79d+LPAU3N+Gs/b0koGCHXt4m65RerZFlF0HvBXdiSkWQUAeFAp
         VoAuMgRT2f502rMCwgG6H9qyyTldwRfWJxb6dzlxVVget/xx4QR57S/61FyI8/bRXMjq
         g+ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W0iuDU+qCWBUM7ba2OgUNPdlmGMl1pYMR/idMsHed54=;
        b=EY3hAxmMpjytmtVAjymJAHrkGyGbA2394yK7iO6HOTVrsQ9lVpbQD/H/vfVKuRV1AU
         R8XZMSm+IXXaeTJPjMMBrxQkNEzm3fP2Dr1ceQx18WmB7hnbRp+X9PZpy4x+M2hqDJqA
         ZUMqRdAepK+IJifi5qqMO9vWhqXhIYNuDAcDu3/OQ6r5UR/B0/hLici4xL9W6CclIbQq
         TDc8bq+TWNfSdCsnGa3MdFuQztUB9NxSZxXJxBBDvZkc7/Y6MV8yb9ppMZ6yK4mUFGOY
         Pcz+fyYHrW33aQvqbKpZhAJYlDlFGYKZW+Oenx8vOEP/RTckYXDnCbq15N7hAOvx+39f
         isxg==
X-Gm-Message-State: AOAM531YAOcRVfNzzaSJ/AQauMOx5aoyXIzvJKXR3FcuAEdDfobim5ED
        +6QDk9y2BghQ9NcmAge1+NrftEpuUzf/X8qWOASiMQ==
X-Google-Smtp-Source: ABdhPJyuZR3go+MjRH0QD2hTjIiPi2nGSy2AbPjYJo0SRP7oWmUGCCRWXTzrLI3Eps1+wMn3Fs9p2fh605lNHa8lJsM=
X-Received: by 2002:a2e:7a1a:: with SMTP id v26mr2010346ljc.104.1594907407852;
 Thu, 16 Jul 2020 06:50:07 -0700 (PDT)
MIME-Version: 1.0
References: <1594718402-20813-1-git-send-email-hanks.chen@mediatek.com> <1594718402-20813-2-git-send-email-hanks.chen@mediatek.com>
In-Reply-To: <1594718402-20813-2-git-send-email-hanks.chen@mediatek.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 16 Jul 2020 15:49:57 +0200
Message-ID: <CACRpkdYOtp027AOMgw_spyRdO2XjGjr4BOoEVfOJN9Y2TtJ=Kw@mail.gmail.com>
Subject: Re: [PATCH v8 1/7] pinctrl: mediatek: update pinmux definitions for mt6779
To:     Hanks Chen <hanks.chen@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sean Wang <sean.wang@kernel.org>,
        mtk01761 <wendell.lin@mediatek.com>,
        Andy Teng <andy.teng@mediatek.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        wsd_upstream@mediatek.com, CC Hwang <cc.hwang@mediatek.com>,
        Loda Chou <loda.chou@mediatek.com>,
        Mars Cheng <mars.cheng@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 11:20 AM Hanks Chen <hanks.chen@mediatek.com> wrote:

> Add devicetree bindings for Mediatek mt6779 SoC Pin Controller.
>
> Acked-by: Sean Wang <sean.wang@kernel.org>
> Signed-off-by: Mars Cheng <mars.cheng@mediatek.com>
> Signed-off-by: Andy Teng <andy.teng@mediatek.com>
> Signed-off-by: Hanks Chen <hanks.chen@mediatek.com>

Sorry for responding to old patches :/

This and the rest of the pinctrl patches are now applied
to the pinctrl tree for v5.9.

The DTS and clock patches need to be applied elsewhere.

Yours,
Linus Walleij
