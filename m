Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE7ABC433E5
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 08:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1F8420760
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 08:32:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a8eMFsFU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbgGPIcm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 04:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726742AbgGPIck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 04:32:40 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 978E9C08C5C0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 01:32:40 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id q7so6234923ljm.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 01:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lNLNfVPPAHXyv+eb8ftyyjegAwGWrhOLC//iWWVh0IU=;
        b=a8eMFsFUt5xNqeJpZ3u2ZRxxpxDwrwFJVD0nDwMFeJ15CvJdGCmCpcAsEd5yY57HJw
         7F9jOmQE4A8ktqHSk6mk6o5iHDxqXwAZenN3sXTjvCYACKU4VLls6zvfWBijK6+kq/sT
         tdA/GkXqAP3rMNLJAXISr1n/GwwfEx6RwTHBtLA0Ad47OlnvEB92xYwf+n6HbhhIynQ8
         nWvwhUsgNk0gW3PNpaPHpiwsMnJhdFrvYpR5VayiO3JCzN5I3JQ1xLmpD8eLUszf/ged
         AVdu4lh2dQOJyyvLUk7bonTsV0Id/v7h+05lFMqtmJu/I+F6cpIPemAqOVhSodAwOcem
         cjpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lNLNfVPPAHXyv+eb8ftyyjegAwGWrhOLC//iWWVh0IU=;
        b=StcQYriZdB8BV5theRzJKDI4k01P1Hin4wowpfC+avmpPQstEwnxXPneJYdF69NhGb
         rcjP1LY+7D2DHHk2RjYxo1CU8UTtidCRWlUTBfBfjXnY2CLocXHcuwh/DKOrr63z5ScQ
         RzH6Bo5EKotZEcaPFyU5QLKUNjTBvLMZgfS+CaTTTWKqWW93pSWqY9+mLHGoKCSueGQh
         mHO4fd18sCE8dszwKXdajhDqyhjqnWfMYB/FeCYdjXw5/fo38h4gNe7LFkjk5eM2xVf4
         97tfIAsQHLdkIAwFlmqJloVmhLiPiJmuwpUd1ccl5ZxGOoZIpsnPlzkoyKyf51jZm6hJ
         CEsA==
X-Gm-Message-State: AOAM533cdViya32xSPEY13mKdA7N4SJJJXxgoHfM/wP21pPtwCdMZWgw
        k/oPSfLh9KfK1lZ1USUrvzUK5ku331yFzfoe6iOpLw==
X-Google-Smtp-Source: ABdhPJzgi2w25laszd9DgCZI4r2GaJsH2ivcxS3M0FLKQIG/i0s/VnFMZFUEdmKrZyboxEE1oxCCYQzJJx327kyUqjI=
X-Received: by 2002:a2e:9a4d:: with SMTP id k13mr1530220ljj.283.1594888359139;
 Thu, 16 Jul 2020 01:32:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200701030756.2834657-1-joel@jms.id.au>
In-Reply-To: <20200701030756.2834657-1-joel@jms.id.au>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 16 Jul 2020 10:32:28 +0200
Message-ID: <CACRpkdbeFP_8R6Q1n7S7g+BS58P7bKx8EhLu73g6PsqfKCjcew@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: aspeed: Describe the heartbeat function on ball Y23
To:     Joel Stanley <joel@jms.id.au>
Cc:     Andrew Jeffery <andrew@aj.id.au>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 1, 2020 at 5:08 AM Joel Stanley <joel@jms.id.au> wrote:

> From: Andrew Jeffery <andrew@aj.id.au>
>
> The default pinmux configuration for Y23 is to route a heartbeat to
> drive a LED. Previous revisions of the AST2600 datasheet did not include
> a description of this function.
>
> Fixes: 2eda1cdec49f ("pinctrl: aspeed: Add AST2600 pinmux support")
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> Signed-off-by: Joel Stanley <joel@jms.id.au>

Patch applied, thanks!

Yours,
Linus Walleij
