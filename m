Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BBC6C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 14:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 045512086A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 14:06:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wnRuOp88"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbgH1OGD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 10:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbgH1OFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 10:05:34 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89DC7C061264
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 07:05:33 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id w25so1421384ljo.12
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 07:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=peoAMhin340g8hfujS0m2ecCBCi8hVoacuqHhCFz4m8=;
        b=wnRuOp88vxN4lXK4sfBVZy9DYmyxBdGcOPdLP35yzgUkT9VXxZetgT5ohQXAnunZkt
         SoEe8EdsMihiNH44I3YIFiBLpyEGQ1Cm6fXh5tbK9SaIDuuKnQItWv+2abAZkytC3VNa
         G3SLv7kCUiM3zgv/CbSlY9DMB5N6Nig6xc4EGouM+Hyz9HOwA5P1S2c5cXGUSolaGT46
         ealsDnAifQV3i/bpYOac3L0nP9U8+PexkVEw66IpXAf9TbsqqBZ3jdfSNXpu3k5paoXs
         GC6jCNGMPuSQEceIIK2+Gj8e4iuyrieyHdN4Tr24FDzHoxH35Ogc7yl8zrugGsOCtGk8
         Twuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=peoAMhin340g8hfujS0m2ecCBCi8hVoacuqHhCFz4m8=;
        b=WNNq8lkYwFWLEtwbxyax2aiaol56XFmH2FvlfgtM0v4uuzaYSFppDpV2FXSpxVacKL
         gj0/IfP5K8hTyx9uTJojxx7I3MTvXadUBAGE78Z4P/j8e5zkR2MnrrqqYUrA+9ZPyHi3
         p7ffa1xai7rQ4B7og65/Q8sVOy5mqetp5yKkq3go7/qIhx7jcrgoh6HJ8xiouMVmHbfp
         EZ9o667cDaJ01Dk4uN1NF7URv92+1SqNDc1JF9P4piDpdbaEXDmxZshvQ//Lx1pc8RBH
         B2V5qfVCHxkcbw6SdoP9El+ABUn6wVzHCnEFbcRqGPWdlN9oWi17v6ddW12IXyu9lmXO
         mWlw==
X-Gm-Message-State: AOAM532Q+zrAgL+dqvtZ09DOVWwihjQKufJMpK629TZgLjiCX6GeZxNl
        ejIqlh1j0cncp+k96ZMHkaFwkBIOOdyeNlF1+9g4SQy0/FI=
X-Google-Smtp-Source: ABdhPJyZK+nyo5nTYz3NzSKuoc28bBQ5aH56BgFuYIxHsyIWvpg2GG1PynT6PAdWZQLdLlwBIDygqkN4EcQix8MSwgI=
X-Received: by 2002:a2e:4e09:: with SMTP id c9mr1005540ljb.283.1598623531997;
 Fri, 28 Aug 2020 07:05:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200827071107.27429-1-krzk@kernel.org> <20200827071107.27429-2-krzk@kernel.org>
In-Reply-To: <20200827071107.27429-2-krzk@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 28 Aug 2020 16:05:21 +0200
Message-ID: <CACRpkdbFJxfF6wGPAw_jEA0bYzT7JBYZOWEb1PbVc1iT8uJJrw@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/tve200: Fix handling of platform_get_irq() error
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Eric Anholt <eric@anholt.net>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 9:11 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:

> platform_get_irq() returns -ERRNO on error.  In such case comparison
> to 0 would pass the check.
>
> Fixes: 179c02fe90a4 ("drm/tve200: Add new driver for TVE200")
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
