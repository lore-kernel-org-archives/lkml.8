Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 980CBC43463
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAD7022D05
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:15:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="RCqGu7tx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729376AbgHFKNh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 06:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729336AbgHFKMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 06:12:35 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B5EC061756
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 03:12:35 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id f18so6236340wmc.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 03:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sVXbFojH/0R1sh5NGJY6hM5Fv6yHchdFYqFYRJiPcsk=;
        b=RCqGu7txZxmTvjk8hFf9VCO6P0oOQtU9w1qLjI9bgEqPurJEc5ppShIfh23PTPqZOF
         Rx4V3jSS2vqgcGVkhDFvZIr71G3bon5/yAvpGu8v4V3+H8kAyNOvxjumBbk9gU8dCboq
         XiuD6bY5nCpwm0ePducl8RnH1HsiCdyzM5SwY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sVXbFojH/0R1sh5NGJY6hM5Fv6yHchdFYqFYRJiPcsk=;
        b=O42bnZ/ys/g7g5RABEhr5Jir14C3F8v4TadPWTFx4GKzoUcfHQDUbp0wX1qMDb9tII
         Hj+bxN0d7L7PqSDaXsxclf8apnPwYbntvWl1+XMjfjy5FRR9Va2Be+t3300KVAC5D6hb
         BJqrXAuVJ5wqalAN8RCY1rUkKm6UClsHn8+aL1EzFb8TYFce0Ia2PRcyduuu5D244dAd
         t8iWkz9kgZ1afhrtAvnpGFeggpTokooueG3AOKXWYyCax7Vm3a2RuUROd7vu58HVtknn
         zNUOum+iQBpuvvKcQIhCaag3W6mJnhhfWwdxFCPONvj+kAgc6fPtJ1p5h/6D/ven2nQr
         1t5g==
X-Gm-Message-State: AOAM532AteQY1YE63T5lGqfhk4mgEuAneohb469QHxWc8aJ6o5n+RDj/
        V/rA2jHOHy9coWSgeM2QQMMYlegrUIYBj7sqE9Rg1w==
X-Google-Smtp-Source: ABdhPJzlXXZln0onZBt7l5va/GB6ImScyHaiS3RfhGoDY/VOeSuREACSW8Vh6oIT4OB38N29lX47wSMOiyyn3mPjIOY=
X-Received: by 2002:a1c:2646:: with SMTP id m67mr7719681wmm.137.1596708752740;
 Thu, 06 Aug 2020 03:12:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200803062214.24076-1-mark-pk.tsai@mediatek.com>
In-Reply-To: <20200803062214.24076-1-mark-pk.tsai@mediatek.com>
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Thu, 6 Aug 2020 19:12:21 +0900
Message-ID: <CAFr9PX=Gk9h6ASi6saBLhoZ45g-WqCzDQo2XWT033fJykFSY_g@mail.gmail.com>
Subject: Re: [PATCH 0/2] irqchip: irq-mt58xx: Add mt58xx series interrupt
To:     Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Cc:     yj.chiang@mediatek.com, alix.wu@mediatek.com, tglx@linutronix.de,
        jason@lakedaemon.net, Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org, DTML <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark-PK,

Your driver seems to be for the same interrupt controller IP that is
present in MStar's TV and camera SoCs and now SigmaStar's SoCs.
I sent a series[0] for a driver very similar to yours but for the
MStar SoCs. Do you know if it would be possible to confirm if they are
the
same thing? MediaTek bought MStar a few years ago so it seems likely
but I have no hard information.

If they are the same thing could we work on making one series that
supports both use cases?
It's also possible that if the interrupt controller is the same some
other things like the SPI NOR controller etc are also common and
working
on a single driver for those would save us both time.

[0] - https://lore.kernel.org/linux-arm-kernel/20200805110052.2655487-1-daniel@0x0f.com/
