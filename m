Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60CF8C433E5
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 08:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E8182080D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 08:58:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SW+OJHzm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbgGTI6T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 04:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727849AbgGTI6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 04:58:18 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F49C061794;
        Mon, 20 Jul 2020 01:58:18 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id p15so12534831ilh.13;
        Mon, 20 Jul 2020 01:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zh7Xd1q8w0eJ5dwux3SY0QwhMWb2Bu15xNtGs3cUDAU=;
        b=SW+OJHzmVfozyQ74x1ednL/Ut9LiWwVAEc4zlcHzV7svVjqWd8H/kzYw3oMoto1wEV
         87CgVUsrOeP0ORh51ZSzctS251uIWEIOeqmuso2uI6ozBo8FyppbdBz7M8hZIlLO6TeY
         Mn1Y9NygIvW/yuis5631se98PPYqwd7wqguXtjK8zFpPyjPGkvpDTO4uoz1+1/CMb7oE
         0qfB/KJsBthxDgOg+vqfqET1yhveGjHZucht9ouenewLaj97pRuSgNK1TjLsrih67io/
         JKm15dt7DN69oBBhssgWaEa2+bDzRB8ah0MaT2C4N/sysxHcfbZDLRZKdan0SnjPRKLA
         L+ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zh7Xd1q8w0eJ5dwux3SY0QwhMWb2Bu15xNtGs3cUDAU=;
        b=d1oVWE5vYfg79APWpS1aW+pyod76OAx+D2L8y2kofeVFq8xVGbDJpAlzcDYQVpwH2+
         Y++7SHkvNLDsKSbjeegdBuLsKttEAYv41arzy4TgtRivU+cbwD5k6bQhfKVg9me5f9b0
         r5hud2rqaRcn50/LpVs/LU9xAiATFHJ7VHKufQAdvG1t/zY0WKqUK/sWl+8/Mv8GjjfO
         mF5ylIDZ/bzQwSXSL9W+Q6m7cazm2Y5QmF4yG7Qt5fvJ8WlQH2PrhqEdbhwgpMFQjWrO
         JZNweUQT5qmcBLATr6HPzLYiacPMmGmTa+wVzar/3/oOXNJ/KnYe8ifgsUda5eZSOo3M
         cz0w==
X-Gm-Message-State: AOAM532Pw1VmR/Bb8Fithmhy46X2c+j+OQgEaf3IGBgca+n0KQ+0L2LH
        l7YBTPAnN56RJs5H+h1zIO/vvFmwAHPqsXHW5/sOhg==
X-Google-Smtp-Source: ABdhPJwnIOuE/UoqUivSxKYwzVt0/RwqJ/memOEoi+PorBJfIKLe2TRZprgWIVxKly3HuVMuRjLH7ryKMmwn7Z46fXQ=
X-Received: by 2002:a92:4810:: with SMTP id v16mr22260069ila.75.1595235497640;
 Mon, 20 Jul 2020 01:58:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200713074243.530-1-linux.amoon@gmail.com> <20200720075013.GA6711@kozik-lap>
In-Reply-To: <20200720075013.GA6711@kozik-lap>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Mon, 20 Jul 2020 14:28:07 +0530
Message-ID: <CANAwSgSpnrX_sSNSB9i=0Awnu+ErfMAo49pnK9aHtdc+_h7-pA@mail.gmail.com>
Subject: Re: [PATCH v4] phy: samsung: Use readl_poll_timeout function
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux USB Mailing List <linux-usb@vger.kernel.org>,
        linux-samsung-soc@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Mon, 20 Jul 2020 at 13:20, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Mon, Jul 13, 2020 at 07:42:43AM +0000, Anand Moon wrote:
> > Instead of a busy waiting while loop using udelay
> > use readl_poll_timeout function to check the condition
> > is met or timeout occurs in crport_handshake function.
> > readl_poll_timeout is called in non atomic context so
> > it safe to sleep until the condition is met.
> >
> > Fixes: d8c80bb3b55b ("phy: exynos5-usbdrd: Calibrate LOS levels for exynos5420/5800")
>
> There is no bug in original code so Fixes tag is not appropriate. Remove
> it please.
>
Thanks for your review. Ok I will do that.

> Best regards,
> Krzysztof
>
-Anand

> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> > Changes v4:
> > Rebased on to of patch [0] https://patchwork.kernel.org/patch/11651673/
> > --Fix the commit message.
> > --Fix the error timeout condition for -ETIMEDOUT
> > ---
> > Changes v3:
> > --Fix the commit message.
> > --Drop the variable, used the value directly.
> > Changes v2:
> > --used the default timeout values.
> > --Added missing Fixed tags.
> > ---
> >  drivers/phy/samsung/phy-exynos5-usbdrd.c | 39 ++++++++----------------
> >  1 file changed, 12 insertions(+), 27 deletions(-)
> >
