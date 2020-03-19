Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95DA1C4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 15:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C65D2072C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 15:56:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qmwUl2cC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbgCSP4V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 11:56:21 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:37930 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727217AbgCSP4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 11:56:21 -0400
Received: by mail-il1-f193.google.com with SMTP id p1so2701935ils.5;
        Thu, 19 Mar 2020 08:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1Oe3tZnlY6/KuRlOI7OFPdet6pAve6TTNZgtPCWHdkQ=;
        b=qmwUl2cCOkv8Juu5QIjVv+mfJSgEvatbmp8Z9/F5NCLbSaZoSbRjhZ+/3KDEVmcSc3
         1fLfa1kxoxDOsY6FhZeEwDyrrpuYi5H2I0yMB08ACYc5qQKSK6mEeynlT8zDozNtkWXZ
         /Ohg+iN4Pajuno5gGqDaNe3P044rFVttjoZ7HvNZqods2cB/8a+/GKequWusxdx2+SQZ
         v2E9+WuP/v6ss24iUOCPgtDUMW0UcaeBT7vdbcTWa08SHz9iq2XjhG9A8ERe3AwmgZmj
         xuLLpJkDpFERfSXJ5HZEStbiCyd8wYcY2Ja/IamBb4hINSLtQ7yRi8tTUkjGhA080fP4
         1WMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1Oe3tZnlY6/KuRlOI7OFPdet6pAve6TTNZgtPCWHdkQ=;
        b=PCIaOyVxdJrVvfr6cGoSjMvq3YvBd7fWGSnaWUMhAdwcornvIF7REq7eUm80RlfXpW
         AhKcrfslw3ddVn9P5lsvsvgLT7s6RaxyTBbZ1DYWW7HYmLZJrMMYUcjltQDonTGOHthl
         nvlvJIVMbkNFhN6E9Umf0dF9HUZ8MqkIVkvQJmPIoC7YmpZ1rA4mnY/+CF/SW52I+HGw
         E0pfzAVFoCnPEJt9NpXGNmCIKcXzJyory5RcS9ypeM26ciUkPuJYU52/L6OT7tcEiJNs
         BDtWDswg6NsOvS6t/ruABHIkpbud6P+sCSkAoqhAoKlQSEc5QikLPf1mLGSpFhvj0zit
         JJpg==
X-Gm-Message-State: ANhLgQ1MFKK1SSaQT1QWW+7avWeqXK8cD/2sGWglUiDIZYRW6p/W9ytP
        CoDU5gvusanzV87yyiHJru26Yim4SajY1/zq2pE=
X-Google-Smtp-Source: ADFU+vsUdxL8KHJ1QgHWxhfoqPUE1f1HWD1267J/n4NTG29cGwbVqnBce65P9Y2YzDoQ9uH613GVP5nXPCHWunkOm7g=
X-Received: by 2002:a92:d20a:: with SMTP id y10mr3907806ily.1.1584633380036;
 Thu, 19 Mar 2020 08:56:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAGWqDJ7AccvoxjKfQJ3GytJ-+u56Bk3rEn0sSYv-zCuBe1brAg@mail.gmail.com>
 <CAL_JsqLz-0myc-PSSaCQWDFXQx+=X9nBSXWsJaGCVqTFn0d5kw@mail.gmail.com>
In-Reply-To: <CAL_JsqLz-0myc-PSSaCQWDFXQx+=X9nBSXWsJaGCVqTFn0d5kw@mail.gmail.com>
From:   Vinay Simha B N <simhavcs@gmail.com>
Date:   Thu, 19 Mar 2020 21:26:08 +0530
Message-ID: <CAGWqDJ4yA4ikz5MwQQwW8CAvE_dt16iuvN6cKRL2DdAuw8QWww@mail.gmail.com>
Subject: Re: graph connection to node is not bidirectional kernel-5.6.0-rc6
To:     Rob Herring <robh@kernel.org>
Cc:     "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <freedreno@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 19, 2020 at 9:16 PM Rob Herring <robh@kernel.org> wrote:
>
> On Thu, Mar 19, 2020 at 1:31 AM Vinay Simha B N <simhavcs@gmail.com> wrote:
> >
> > hi,
> >
> > I am getting the endpoint' is not bidirectional(d2l_in, dsi0_out)
> > warning in compilation, built boot image works on qcom apq8016-ifc6309
> > board with the dsi->bridge->lvds panel.
> > Because of this warning i cannot create a .yaml documentation examples.
> > Please suggest.
> >
> > tc_bridge: bridge@f {
>
>              ^^^^^^^^
>
> > arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi:253.28-255.9: Warning
> > (graph_endpoint): /soc/i2c@78b8000/bridge@39/ports/port@0/endpoint:
>
>                                      ^^^^^^^^^
>
> Looks like you have 2 different bridges.
>
i had two bridges, if we disable one bridge also we get the warning

arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi:333.53-335.35: Warning
(graph_endpoint): /soc/auo,b101xtn01/port/endpoint: graph connection
to node '/soc/i2c@78b8000/bridge@f/ports/port@1/endpoint' is not
bidirectional

> Rob



-- 
regards,
vinaysimha
