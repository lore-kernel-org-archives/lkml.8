Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA392C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 14:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C17EE20757
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 14:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bthwUPub"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727931AbgH1OjC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 10:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbgH1Oi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 10:38:57 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 220FEC06121B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 07:38:57 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id w14so1577114ljj.4
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 07:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z+TaixqXEGVGQ2T/QrWllmigc9Bn2yBozBpoORD/TJw=;
        b=bthwUPubnbhn6YaESsUooZlnlA4AAH2u5bkxHyDnFmhCm7Kh8U+RM/LdfdzTy1rYap
         u44U0H4icDS300YJtLrAeN/7futTwYEW9VcOBuA4MuLVEaALI8PfhMowA05SL1w4Aht9
         EJ2c2krhGZEMNpmqLnZCHr6FP5hI4iwU/AKWJelCBMzkKU5f+mZY9UODyo7eprjDDebs
         O9ZHQCcn+Y4eCdnY+/38i5UVPDt5HBdr12ZRgh8q2eFBE/mFaM9AMXRKlxfxAn0quOPM
         bjoy/WikU5yTdZRSThu37hA3MaGWPoh5PN6jQeqLm+WZnnKTMUmXjqT3ChLDKmm4LnUk
         xFAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z+TaixqXEGVGQ2T/QrWllmigc9Bn2yBozBpoORD/TJw=;
        b=kxP5sc6/kordyhxvZ7WEsMmENhhUIk4gh5GsGyEuZ3fnEJySIjVRWwBHFMgY8X2vaS
         t/XfzKaNejpocONOLEVy+hFM5YZop7tpvi3xZDMw9JJ2WTAgNsuRkFy7jCB/gw92VJEY
         yyqcRaa3GoUK3ZdCALdI1qQAiODazEQ/xlDLLl4SAC+AZs2ogb4v2cNkSnVsW2ayTu6Z
         1uv2/5d8vz6X1bNP730AfVIG/LyvPHCuCVygW51sdaUcc7xJa6qEw4GUxHgZXdH/35ZW
         b20X7Vkh8EEAAuzKSr3vP1ED90LM/SBtDmULPJWnVQs6vw7/IX0sQACoRN8G4WHYRdMc
         8L+Q==
X-Gm-Message-State: AOAM5317CpLsbBPEEFxCv7IJ9yr792fJJ0oh8oiiOnG2mAJAwadClNGb
        VDusbSrjoh3koEsGYld2F9mMC8pmpyoJ73ca99wFng==
X-Google-Smtp-Source: ABdhPJwaDJ3Gr/qcSUh/+gWWdKq8kAihgP6kukxSpzeXwrAWcBQEZ3gQKkku9u7kwQPG+FNQX7jTEbu12MB2QtmIP4I=
X-Received: by 2002:a2e:81d9:: with SMTP id s25mr1013703ljg.104.1598625535585;
 Fri, 28 Aug 2020 07:38:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200817001702.1646-1-zhiyong.tao@mediatek.com>
 <CACRpkdYedyDcnL5DUD33Z2iT1jEJ_W1gvB_a8VaFnNAH1mKgzQ@mail.gmail.com> <1598581434.5835.2.camel@mtksdaap41>
In-Reply-To: <1598581434.5835.2.camel@mtksdaap41>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 28 Aug 2020 16:38:44 +0200
Message-ID: <CACRpkdY9hbLOTjzQm34xL32PU01tRMkcB4_qTeFqwQM9Yam75A@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] Mediatek pinctrl patch on mt8192
To:     CK Hu <ck.hu@mediatek.com>
Cc:     Zhiyong Tao <zhiyong.tao@mediatek.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Sean Wang <sean.wang@kernel.org>,
        srv_heupstream@mediatek.com,
        Chuanjia Liu <chuanjia.liu@mediatek.com>,
        Biao Huang <biao.huang@mediatek.com>,
        Erin Lo <erin.lo@mediatek.com>, hui.liu@mediatek.com,
        seiya.wang@mediatek.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        sin_jieyang@mediatek.com,
        Hongzhou Yang <hongzhou.yang@mediatek.com>,
        sj.huang@mediatek.com, Rob Herring <robh+dt@kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Sean Wang <sean.wang@mediatek.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        huang eddie <eddie.huang@mediatek.com>, jg_poxu@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 28, 2020 at 4:24 AM CK Hu <ck.hu@mediatek.com> wrote:
> On Thu, 2020-08-27 at 10:52 +0200, Linus Walleij wrote:
> > On Mon, Aug 17, 2020 at 2:18 AM Zhiyong Tao <zhiyong.tao@mediatek.com> wrote:
> >
> > > This series includes 3 patches:
> > > 1.add pinctrl file on mt8192.
> > > 2.add pinctrl binding document on mt8192.
> > > 3.add pinctrl driver on MT8192.
> >
> > Patches applied for v5.10!
>
> I does not see these patches in your tree [1], have you applied them? I
> would like to pick these patches from your tree.

They are on my harddrive while testing, then they do onto the
server for testing, then they go to linux-next for testing.

Give it some days and some patience.

Yours,
Linus Walleij
