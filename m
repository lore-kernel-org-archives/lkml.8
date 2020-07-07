Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C966C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 11:41:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC280206F6
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 11:41:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IL9/OsUN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbgGGLlh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 07:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbgGGLlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 07:41:37 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84540C061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 04:41:36 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id t74so24547520lff.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 04:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7L/0My4Hmw0nxk/zAz7LX4pkKR6TGLRcA6CE4xPJOLM=;
        b=IL9/OsUNTSOVSExzddt4AK4CWUR/v5bZ9OfUUimh18UkjLZ40MllYFJGIB/aCN//Gi
         IO7U8JbSaPzAxcDPh7KvBZnYAiNqrhrEryPI0oYInOPF/UXH7cP1G5VbNvhqOQVFT1z1
         hadPDW9jXnUvIJJI+Pe2zao9mf6oozWnZFM/7sAYurmlmIUTC4in8iTwSGWI35ATdGpK
         dYN74HhHxd8jlOvRdiEhJ2tEiH+q8w2yXuCSDell5I+ugHXJBADKnxsluAdw4VLoju1/
         scwZVogOdt1X0Eg+J00XhrCeJl18hSU4Gyv2EUSYfrov2Aeap01RjCJ5HK0FWqDzGZld
         EYzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7L/0My4Hmw0nxk/zAz7LX4pkKR6TGLRcA6CE4xPJOLM=;
        b=YAfh4O65+FR9V78aoIwHg9FFZt5PNAIVKvmJl6de5MxWYfIbneyIIxJGJw+HVXLNe6
         UYTBK6+DHhLX3BXDiL5iJL+uqujc24gU6Lt57P/4qkDzwiiJQrb0nx0ei1W/fIX4vpAy
         z+TZtvNfyATXcu9SFb9bztSKIWmVyd1UG9ASjgCypERgFLwQ6EaAjmAKrcmqZTcIZk/b
         UiCwNAfLQnPa9KflNM7dbE5FRoeRyX+M46y86us+CaBke/eig6oDRXGS2yoFWgPblkyz
         q2nbGnsKSY7oHohrJw33sCU8WqegX5HXDOp+kP6cuKynEb3c3fvzCDOZeW95ZmYA2lPk
         6ivg==
X-Gm-Message-State: AOAM532fGaevbhvmgwxk+ccG9GTNl3M18771PB1bz0FdYOpa3TuvibEE
        aeV+ZDJNB6NfpjrsZZffeS0IMmeB0cZNcG4orgsQaA==
X-Google-Smtp-Source: ABdhPJz9qB6nG0uUcXiIt2zX4d51YOVLcslM/A8TsXvw47TLHd5sVFUK1DB4TwmcZWAd//+7rEtuzWJ593Cnx/sNKOs=
X-Received: by 2002:a19:ccd0:: with SMTP id c199mr32729218lfg.194.1594122095031;
 Tue, 07 Jul 2020 04:41:35 -0700 (PDT)
MIME-Version: 1.0
References: <1593694630-26604-1-git-send-email-hanks.chen@mediatek.com>
In-Reply-To: <1593694630-26604-1-git-send-email-hanks.chen@mediatek.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 7 Jul 2020 13:41:24 +0200
Message-ID: <CACRpkdY+N17VNdzidBdo-Z8rgvRGMh=576-WPULgCmmuSJyN7g@mail.gmail.com>
Subject: Re: [PATCH v7] Add basic SoC Support for Mediatek MT6779 SoC
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

On Thu, Jul 2, 2020 at 2:57 PM Hanks Chen <hanks.chen@mediatek.com> wrote:

> Change since v7:
> Commit "dt-bindings: pinctrl: add bindings for MediaTek"
> -- fix typo and change order of patch
> Commit "clk: mediatek: add UART0 clock support"
> -- add fixes tag and real name
> Commit "arm64: dts: add dts nodes for MT6779"
> -- expose all three UARTs in the dtsi

Oh I see there are still development on this patch set so I took out
the patches I applied again.

Waiting for the final reviewed version.

Yours,
Linus Walleij
