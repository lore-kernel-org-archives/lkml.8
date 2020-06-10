Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9627C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 11:39:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 896AD2074B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 11:39:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fs4o/drN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728716AbgFJLjI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 07:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728510AbgFJLjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 07:39:07 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD039C03E96B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 04:39:06 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id q19so2058677lji.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 04:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5IPZkixoble9/9wQuqUteSrJ1tRLpLsO87Bji6xJpJI=;
        b=Fs4o/drNCDx7tniQoQBWSActEQRqOUz2dcAPdTL8ZNB6WWRh5Vb0oWSZcFHgC2Ro1L
         l77l0k2o8qfaW0JtpfOS+13PHSX1m3+UmY2KzMHsA7vlQcKHtx2ivdOnO2r4QawtevaI
         7j9NkC9ArUFEuSZxtez1t766wQsYTsLWA6yTAR6HnvLINv576bZ1AUUwzlP0EMGPimvz
         vlETonQ4KcrWVftuNARhPQaa3Uf064dugjt7lulF4Tq1FQGBmVOmARQFnox41Xak5zrq
         vLgIYfsDXwZEpWYxWZe/hRyNgGTPN8KW6/vS4a6tg4+K0Y5llkYI3WfdJMFwkE0Oiky6
         +g9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5IPZkixoble9/9wQuqUteSrJ1tRLpLsO87Bji6xJpJI=;
        b=bTBiyqgGaGRh0i7FowAowkorkbD2r6ENBemSlJOC3ilqm9sBbEW+6oNWDUNOiOIROk
         LJGGCXkmoiHOSJWa3vk0yOG2OUr8zzDoh6FDPuCb7ju0hTfkK/TzKBBvKojBqmXFKdNX
         DVwx8E06E4MGO0gzemdvw2XmGPWCiLUVTW8Rw08+zraIroEloJukshlc9zOTdpw9sbSG
         gtjx8nm+aSCzGAoUkv7vGlAExZvKq9NwbutzTqICvvhAyrh8Z5JBYbTqC3EZzwHF6OiL
         Or/N0Yy6SZJV48ihJDW82RAQt5ujTMK1vmzaJYngmaSfkPEiV09jBIyqcIWfiqf/dzIK
         zgUQ==
X-Gm-Message-State: AOAM5308Y+dGjjClvEqfbUIAQ8VSQdc6dUJRHn9qkgWrSxr+2acZ2zJT
        ClOymvi41vUfSASDy5mmW7gOMoNhtnEjrUdo9LK4TQ==
X-Google-Smtp-Source: ABdhPJyDxkVv5uj9TIQspAqLtGtK38kMojGoLpSgmJlWwiTCmhxbrSgDmp2/28EuUAD5oLtrm4fiDl9lAtxNPZSgHKM=
X-Received: by 2002:a2e:a40f:: with SMTP id p15mr1674609ljn.286.1591789145161;
 Wed, 10 Jun 2020 04:39:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200608134300.76091-1-andriy.shevchenko@linux.intel.com> <20200608134300.76091-5-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20200608134300.76091-5-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 10 Jun 2020 13:38:54 +0200
Message-ID: <CACRpkdZer1bUSXoK4wZpQu60mA5pEST8FEFuTrvvoaZ2+1S=hw@mail.gmail.com>
Subject: Re: [PATCH v1 4/6] mfd: intel_quark_i2c_gpio: Convert to use software nodes
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Mon, Jun 8, 2020 at 3:43 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> -/* The base GPIO number under GPIOLIB framework */
> -#define INTEL_QUARK_MFD_GPIO_BASE      8

OK I see this was around before, sigh.
So it's not your fault. It was introduced in commit
60ae5b9f5cdd8 which I was not involved in reviewing,
for the record I would have said "no".

It is exploiting commit 3d2613c4289ff where I allowed
pdata to set the base so it is anyway my fault for not
noticing :(

But me complaining about this doesn't make things better.

Can we simply DELETE this assignment and just set base to
-1 in a separate patch before this patch and see what happens? It's
really unsafe to hardcode base like this.

+       PROPERTY_ENTRY_U32("snps,nr-gpios", 8),

This is however fine in principle but just use the existing generic
property "ngpios" and save this custom property.

Yours,
Linus Walleij
