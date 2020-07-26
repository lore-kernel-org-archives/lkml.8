Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91FB3C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 22:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66E3D20715
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 22:26:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BfsIjy2z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbgGZW0G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 18:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbgGZW0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 18:26:06 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17418C0619D4
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 15:26:06 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id d2so2322264lfj.1
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 15:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qMFMrM2UwSVWXy6CzJpp3io1MmpiGTCiXGuEse1Q9zo=;
        b=BfsIjy2zGgd6JnwqvTKSwHZBBtZ+lhWEsYSPZ4mGodMqU6Ea5iZQnEZsjJkxO7VNsT
         3Lrqq13lymcjKcT95LEBq14pZymVhPOnNLGOF77kfsAZzqNkeQdcQyxoN16mBCOrIAYB
         tbfZQIA0d1cy123E9dY00rGnQlGrX61jJsuv7fHa905DBhyqvbQya3xQ7e7N9eANFnwg
         7dKVxYXoOwlkFRarrC3Zdh37wX/09fsJR7vtRd65kFaBVwzJvA75gLgrnvqaNX4ycldA
         0Kc9H8WziL7+SQU6GJNApsN3YjKsgREEjIfE1ciLzYTd2s+Q7ZfHk4Wy70vfSjgYjJiG
         5vQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qMFMrM2UwSVWXy6CzJpp3io1MmpiGTCiXGuEse1Q9zo=;
        b=LQtRyY0QzRfJ240/vEJTpuK5DCp7xFxzgkw4xJHEVG5eGyxiWvATq1gy3Qu3mbFt7L
         xYCVX4gMu/GTisCNixmHVrwtYvkjDagD87AG4PFy9pJlom6XGVQHuWC+sgdNMGZBDfOJ
         dBWyRzxer2Mno/tvieBRAXZTDj6IBMoWGIy5BZnZSHuyj0UR/8uP6bRJxJhDw1Wr30vo
         QdI2zeZ84qIdnQXMhbmNP9XG8UvCjcqHQKx8PwdyXz3xawi2Uju6cmr8WRy8Aqf3bBe2
         mhcPPbloluksWEhE1VGupcddeDXaVOJXV96D1UthMABLk1M0Yae4PtCfesy8scUlhvy4
         LUjQ==
X-Gm-Message-State: AOAM533/IstbVCtd0m6zpor0zUNo+QowJ995BOlSW0P5gDRsRT2F4eLj
        GVz85H3+UTPytdDnsXzgRgwPvp84KX14Aym1dfKDNQ==
X-Google-Smtp-Source: ABdhPJwW5NbSc6KuKvHaWtPma+94F1kxGGQAtBYJKM8GoaQ7ghPK5SJlPMpC6VPSg2BlMNOZ6SLAqFrNFYtNzsmLZfU=
X-Received: by 2002:ac2:5e26:: with SMTP id o6mr3044416lfg.194.1595802364522;
 Sun, 26 Jul 2020 15:26:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200725041955.9985-1-warthog618@gmail.com> <20200725041955.9985-4-warthog618@gmail.com>
In-Reply-To: <20200725041955.9985-4-warthog618@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 27 Jul 2020 00:25:53 +0200
Message-ID: <CACRpkdZymmO9ku5OmCO74eiX3Y3jq_1g5De9Tx4hg3Lyrdt6bQ@mail.gmail.com>
Subject: Re: [PATCH v2 03/18] gpiolib: make cdev a build option
To:     Kent Gibson <warthog618@gmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 25, 2020 at 6:21 AM Kent Gibson <warthog618@gmail.com> wrote:

> +config GPIO_CDEV
> +       bool "/dev/gpiochipN (character device interface)"
> +       default y

I don't want to make it too easy to do this, as I see it as a standard
kernel feature.

Can we add:

depends on EXPERT

as with other standard kernel features?

Yours,
Linus Walleij
