Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A94E9C433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 10:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7290621531
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 10:29:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="YKpxYuJt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728799AbgIGK31 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 06:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728951AbgIGK2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 06:28:19 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48B0CC061757
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 03:28:17 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id lo4so17551726ejb.8
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 03:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E+6kvSO+kGtFqzwSOsHYLQdHmE8ihK39UIVQKLTGAlE=;
        b=YKpxYuJtNjDEcMyhlLGRj0HX0hQkUXEqPjKuUoBXv/e3UDUS4Hln7rKvyvdJTkScwl
         k1rXYkIZAbO2UsMaPTxTaUrbbBWUu4R8sdHC0L1BG0mGaX4xk380OjSevy0ECUxykK/F
         W0r2qxkPzqjPoDdZ8gzABSBUnDIUQFXvKxYS4mab97WFlQCFfhbvkd4IVjnPhoWyKel2
         XD9I7vu5rWTXsRIKY4qpSRmj1lEfs+bqL5eIbLSlZkr5OCsU1EbDHMwj00krDCJyqj4O
         gmJBrn/Lyg7t/40d/iHFqrkkALM3z3AbVL2yVDPRt/STFncNY1w/mvM9VKLyly28uSNr
         Y8vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E+6kvSO+kGtFqzwSOsHYLQdHmE8ihK39UIVQKLTGAlE=;
        b=UkO9KUqjtW2HKhJhXA/KuZwuBlObVgwZXgjCQOvf9o6141YhKdLosiF1olu40uc907
         QCGmNPNjezJODKFAoB2470I1RAcwXYQWIOx7gz5UEtaEQ9vwCcxAW3eGSPqAB42swp8O
         cSCY6BH5owtRehmzMTE4PHhYZ1jKcfWabKdgaES/3M/HTYq+0ZkVt3VXcH34RarKyMWr
         mYAoUAfyjuvYb2GbExD6pFvrwb/fTt+iNUj4lSZEOLZf845NVa1T559BFQDiszi/XruE
         Qt2YJuKeG0K/zrgN1uwqqtBXv1RlRXwkQytRAVZcr2fotN0fh6rRw3qoBHxyChhKGyol
         G14g==
X-Gm-Message-State: AOAM531oV1lGCIUusQAvrTFErhQ5Htt8KHGTkerk6JeA35iA6XiPnzsR
        DxuiyiwoKrM6wEzLCZuBbVJsZG+u/zlrz7s5K6snRYjMrF8=
X-Google-Smtp-Source: ABdhPJwP4J3kM7zvzHGchdWRMUs1XHCPsNoozGebnZDrc/LmkHpUC8eNrTX90FFgDqlq6JBHy5dgtK4984ghibSDrvg=
X-Received: by 2002:a17:906:941a:: with SMTP id q26mr20103973ejx.496.1599474496010;
 Mon, 07 Sep 2020 03:28:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200904154547.3836-1-brgl@bgdev.pl> <20200904154547.3836-4-brgl@bgdev.pl>
 <20200904163517.GW1891694@smile.fi.intel.com> <CAMpxmJWQsgV5WZrdPW3UUOVTEy1L6Y_rb7ThQK1QTRinmHSqWA@mail.gmail.com>
 <CAHp75VdOWdwT-e5ufsZ8MEH=YtdBgm1=TDKn3f8fJxXY4YKh9A@mail.gmail.com>
In-Reply-To: <CAHp75VdOWdwT-e5ufsZ8MEH=YtdBgm1=TDKn3f8fJxXY4YKh9A@mail.gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Mon, 7 Sep 2020 12:28:05 +0200
Message-ID: <CAMpxmJXmY8oBpPue5v0wBvmjHkFGaUmzHScHoV-1pNEQ59am4w@mail.gmail.com>
Subject: Re: [PATCH 03/23] lib: uaccess: provide getline_from_user()
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        linux-doc <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 7, 2020 at 12:19 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Mon, Sep 7, 2020 at 1:05 PM Bartosz Golaszewski
> <bgolaszewski@baylibre.com> wrote:
> > On Fri, Sep 4, 2020 at 6:35 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Fri, Sep 04, 2020 at 05:45:27PM +0200, Bartosz Golaszewski wrote:
> > > > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> > > Doesn't mm/util.c provides us something like this?
> > > strndup_user()?
> > >
> >
> > Yes, there's both strndup_user() as well as strncpy_from_user(). The
> > problem is that they rely on the strings being NULL-terminated. This
> > is not guaranteed for debugfs file_operations write callbacks. We need
> > some helper that takes the minimum of bytes provided by userspace and
> > the buffer size and figure out how many bytes to actually copy IMO.
>
> Wouldn't this [1] approach work?
>
> [1]: https://elixir.bootlin.com/linux/v5.9-rc3/source/arch/x86/kernel/cpu/mtrr/if.c#L93
>

Sure, but this is pretty much what I do in getline_from_user(). If
anything we should port mtrr_write() to using getline_from_user() once
it's available upstream, no?

Bart
