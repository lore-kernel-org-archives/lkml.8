Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9916C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 13:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4C0620760
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 13:27:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iczHf7Tb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728743AbgGPN1B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 09:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbgGPN1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 09:27:01 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC424C08C5C0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 06:27:00 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id b25so7123763ljp.6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 06:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g/vDuN1L2KCEbNuFEXJItw+g/c3pd50/6Ev+anSTygo=;
        b=iczHf7TbyYkMy0BWfgpzsOiVABUoxFhLHlLkbkGc1mGYacGVfxuaNeXRmfY8Tnau+z
         V6Ys4UJQjGsi5JXc/kEe3DFQJDzbxwH550fJ8UxQrLyQO49GGfXKxxwy4obQfa8wWEa6
         g+OpiQcbhTwx0zOLwtOJblk7pD5ppy9+2lXf+PYzptH3GxfZwFiqoIdYiJ1uJXR1ATc+
         NM7xGdxfXPP89AVXgXY7OGXTHN/PUEyibCJ/OdcLUauSg/BUIERlxnxfj61KO2pyt6eG
         ed+RGobQ6iFu0SSN/psr6T78MeBntG+xbb6VaWqOoejleDe3SliONb1B7Xa+fo6XC6o0
         TZQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g/vDuN1L2KCEbNuFEXJItw+g/c3pd50/6Ev+anSTygo=;
        b=fixPhQKmu7ESyTum6WmaiJiZWtDX67r/PX/nTKv43gPtKO7bwAv20dKKvsnoGpA/jN
         loREcc98dM0BsQvUbloDIpq7V2wmBpP4Fq6ofidOVgavBgkl3OH94KSc0wxgl+3wwlw7
         s7z8PAM7JDfeEFxqq9SuAROqugVSR7gApEW1tDiH6J+7XZhk12Q31F4W0MIYqDk8fsLN
         5j8t75VWnT+NfGsIpHD6FWu7C9pXC6WqKjCZBYV+QXiSgA5J1B4WbBU33QMcXmejNLFi
         4XedS8c2g1wmY7SEuX6f9iowcBTWmByHgAvg8EAQDIPy1NXXdXc/81Fwvr/HabEINm/0
         yEOQ==
X-Gm-Message-State: AOAM531tDc3CRrn1CYPtnc25aX473mIaorMA7cuoX4DURnJuvr+PSzL2
        i9aLNZZKNYTjCE06RxygQwWaIZIG9r9gUYYSGHKtBXW8AWYBDA==
X-Google-Smtp-Source: ABdhPJzTvWzWY7xde2a3Mu6BMB59vLxHOlDAtL09MGxblo1BkRQCPu5O6Gx0M9FWfCAG68RIFcQ0zgAGPIhWb3rjt30=
X-Received: by 2002:a2e:8597:: with SMTP id b23mr1876406lji.338.1594906019044;
 Thu, 16 Jul 2020 06:26:59 -0700 (PDT)
MIME-Version: 1.0
References: <1594717479-8160-1-git-send-email-hanks.chen@mediatek.com> <1594717479-8160-3-git-send-email-hanks.chen@mediatek.com>
In-Reply-To: <1594717479-8160-3-git-send-email-hanks.chen@mediatek.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 16 Jul 2020 15:26:48 +0200
Message-ID: <CACRpkdZNL=mnF0dx63bQPpHVLcAHA=oSEiiHzH8vi3+X58y5Jw@mail.gmail.com>
Subject: Re: [PATCH 2/7] dt-bindings: pinctrl: add bindings for MediaTek
 MT6779 SoC
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
        Loda Chou <loda.chou@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 11:04 AM Hanks Chen <hanks.chen@mediatek.com> wrote:

> From: Andy Teng <andy.teng@mediatek.com>
>
> Add devicetree bindings for MediaTek MT6779 pinctrl driver.
>
> Signed-off-by: Andy Teng <andy.teng@mediatek.com>
(...)

Please make an attempt to reuse the generic schemas in
Documentation/devicetree/bindings/pinctrl/pincfg-node.yaml
Documentation/devicetree/bindings/pinctrl/pinmux-node.yaml

See how other bindings reuse them, e.g.:
qcom,ipq6018-pinctrl.yaml

Yours,
Linus Walleij
