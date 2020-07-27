Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE49CC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 13:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99E342075A
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 13:00:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lczIY6ut"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728594AbgG0NAl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 09:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728141AbgG0NAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 09:00:40 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF78C061794
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 06:00:39 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id j19so9461156pgm.11
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 06:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zDCRkmlrPzZtJGE53wEFNYm0NkhB9Lgp0Cpk5WdLiRg=;
        b=lczIY6uts6V8QBf767/dsO3hCaENXmqOrFa42ohxayqesfvAAgijiNZv1re9tWnTY6
         d0s9U5s+apCDK4FgghlLVqUtHLI+pe00AdVcfFsF85NH7PRh7MrsCRAfji913WmqPkWA
         l8w669dWxo9uIWSjE2IzZ1CC8ljloucRpA7J+1FxBigRe4f7b7e88tLEw2OG1xK5y0T2
         KaBwYo0NBnDCRBP85FOOvGiIWjB9mGBFSYXOZmhuA7qZLTWoTLT24XcjaYEoBcOXvZWt
         mvW4c0jYC17dqBtyBCTPlU0Bp23vrGv+uUuw5U5C/aTmXQ0CshIXYNzuGPxIHBMDcQXN
         aDyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zDCRkmlrPzZtJGE53wEFNYm0NkhB9Lgp0Cpk5WdLiRg=;
        b=leQzB9zSpGaVbNR/7A9k1nQT3bAAS6CcXrJpe/75npdFCVI4lb5WqiBAwsXgqA14mR
         YcjloXZOtzSmBIoFNAR2eLswVb1U97JqYiRFehKR2GzgxuwZbkVr4dbfx7uwObWuqsJ5
         2C1vqp6T55ySAmRs+BBxvvAZT5OqgqnNtX6aAkdWa7LwJCgG3pSjZKZwMQgil0DNUj1R
         KNRKcF2LQrhyQs11Y6EadtEvE372f+NtLg8/Tt+Q4ZhWyaOYCPx6PV26OB59gnK7UMdR
         pQJiOgZ/UFyx0hGlP0EdSd2D1U7pTkIuy8uwpISS85xxqnrs7L8yhPwesVXs3ZdZGwbX
         kT/w==
X-Gm-Message-State: AOAM533llJWejsdK2yylGNfCw0oZWYL6bFP0qiAyioqYlplqv0s7Slma
        2AJgGFxqNPg5PKJyYRqIQfmgH9F3f661QShwOgU=
X-Google-Smtp-Source: ABdhPJyt4o+pCAxKjnl8Al8CXcPXkM7H1zrz8mloKsV3qCi/uhWDDw2JoXGZ0TDbgZxoHrlQpdBG4ckXRjJbsrUt+fI=
X-Received: by 2002:a63:ce41:: with SMTP id r1mr20163590pgi.203.1595854839033;
 Mon, 27 Jul 2020 06:00:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200727030407.8820-1-vulab@iscas.ac.cn> <20200727120908.GR3703480@smile.fi.intel.com>
 <20200727125335.GQ1850026@dell>
In-Reply-To: <20200727125335.GQ1850026@dell>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 27 Jul 2020 16:00:24 +0300
Message-ID: <CAHp75Vfi4pC0rQHVmi6nuQ12tL7shtKPbbSuFgBhD-jDs_Z=+A@mail.gmail.com>
Subject: Re: [PATCH] intel_soc_pmic_mrfld: simplify the return expression of intel_scu_ipc_dev_iowrite8()
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Xu Wang <vulab@iscas.ac.cn>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 27, 2020 at 3:57 PM Lee Jones <lee.jones@linaro.org> wrote:
> On Mon, 27 Jul 2020, Andy Shevchenko wrote:
> > On Mon, Jul 27, 2020 at 03:04:07AM +0000, Xu Wang wrote:

...

> > It's a bit more helpful in the original form in case to add some debugging.
>
> If you wish to add debugging, you'll have to add the extra line of
> code yourself. :)

True, that's why I'm not objecting the change.

> > It also keep it symmetrical with read() counterpart.
>
> Can this be fixed-up too?

How? Can you elaborate?

> > That said, I'm not objecting the change if Lee finds it good enough.

-- 
With Best Regards,
Andy Shevchenko
