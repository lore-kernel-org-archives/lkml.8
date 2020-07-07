Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F6DC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 12:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9F63206E2
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 12:46:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wAg8HuHi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbgGGMqR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 08:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbgGGMqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 08:46:17 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDFEAC061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 05:46:16 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id e4so49746428ljn.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 05:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dQ+3RsGzhCNwrslyc6RXspsKZI4esSmWbE6IYOWbwWc=;
        b=wAg8HuHiQ59Jc8dyotfSO5plbCLeLWinGVFBX2toyJN+QuZGi2idpWjYgiLElk06ak
         GwgGiPvc41h2/KIuSC0p/iKtDwzlJLNiBwzaq189x3tp4+0VChTmVV2sG06KWqSN/u/2
         20gunuH0+gQj5E4g9hiCn/NlXWU5nA7r7Y6wImSQDcT+ECRGYTihNOuR4QmNJjHWzInP
         h5vEkNWqVWZGilNprKoxm33eZV0X34CdojmG0y6H9S/d5fXSttwUU5gH9OJ/LXEiZdyE
         RCwCGJ+R46Ys4ikuHseKaW+RyQR4p+vYvqblDtdRE76Frb0CRPIJ/YX3ejWzkF55O5Sc
         BT8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dQ+3RsGzhCNwrslyc6RXspsKZI4esSmWbE6IYOWbwWc=;
        b=hoQgo/+uttztHBSqt0dGnWEHArcR5p5q3BbS/JDQ9oBMFo/2AvevD4keAeaDfnoUpz
         /zVF3s/tk+7D3jjA5/lz4ePp672NXClBajhsv4XU2XpVc7yQDAh5Foj9yIJT5UOTKr45
         z5Xvq4y76zNWsyYwMEr1veWg1Z2xLB8EXa+poMpIftK6ghWR1ARPaah6ZtcJ/p7D1kIy
         NtsGPyrXbzE7t6zQkSf/yEX2lQCLn9fSXcuSKPwOzBCumbH+YqftpUQ6O51d0QvFxlDi
         PK3bZtxhtShgzaXGXHkd4lvsU2q4MuldJ+/VOCAktmQeewPs6NWYTeseq4BWcV69OnwR
         ZwbQ==
X-Gm-Message-State: AOAM531mCWrfleBLS1JPaDaCXnLoyoc6PJp6x/jpx6oZSm2rSg3nn6E3
        YggKBzmPOUFaKuKFJA5zmYWxepIdv+NZ3NSjIKvDdA==
X-Google-Smtp-Source: ABdhPJywPbVc5soagEQMO6cSwlBfJciKudpeJBAfqrYC2B4Mo6sZYbtZUviZkPCsMXl8bKvF4HmNiB60STcV1A7ZuBM=
X-Received: by 2002:a2e:9a4d:: with SMTP id k13mr8726523ljj.283.1594125975425;
 Tue, 07 Jul 2020 05:46:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200626080552.3627-1-krzk@kernel.org>
In-Reply-To: <20200626080552.3627-1-krzk@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 7 Jul 2020 14:46:04 +0200
Message-ID: <CACRpkdYjzUnXmn9WXpywkBRUfUm_qPTLTRTOy1oagPsL-Pmxfg@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: ste: Align L2 cache-controller nodename with dtschema
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 10:05 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:

> Fix dtschema validator warnings like:
>     l2-cache: $nodename:0: 'l2-cache' does not match '^(cache-controller|cpu)(@[0-9a-f,]+)*$'
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Patch applied.

Yours,
Linus Walleij
