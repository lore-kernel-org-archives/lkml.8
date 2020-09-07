Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FBF4C433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 10:03:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1A4A20C09
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 10:03:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ugGVMJW5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728486AbgIGKDI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 06:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728395AbgIGKDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 06:03:05 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DEF7C061573
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 03:03:04 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id q21so12214939edv.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 03:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eu0tVdC2SapQmxPGnrOiQAZ5HG6pSAsS9H4UlH7DET8=;
        b=ugGVMJW5RJbLvOkkPTzMtesjDjGP+0VKjWNbvyeyw2RAMXE6OInFtbSWjFRmI2mEZS
         Qsd8ZTpoPGy21huaFxq7lp3WRwdQ2JfnmeqB9iOMeg5qjFXrc5D3naTXSyS3YuGEFwBm
         oRbHf7veaLO0JOYUz/DRU9qgAEXENey2/qrOyy7qen1h8LeM1btTG83H6yE/8QPWql7s
         PzxcpQ97iEe6gy1nn1Kp/keE93njE+5j0WNLrCc2AomoVHBqeHFuwlm8+z6haucaxF0Z
         72HZWjDalObdCuk9FIuI/j7BVINn0EVKCXAj8MCKTFXVU4ebqr3a2n1HRESpqbxbLXcv
         oUoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eu0tVdC2SapQmxPGnrOiQAZ5HG6pSAsS9H4UlH7DET8=;
        b=lYmR9dDiS7Zg/VgGG5jIhyW1FXaQ1BPOpadH0IjRLudjMoRVtSkk+vz3SbOCOsNFXS
         94EdndLFqLZkpaJPQ15x2j+4uw8mpo+xriD4yD16zofbH13IHmYS+aZsEXaNQK0c0Ukp
         /cU6xaXEHo1EhUw2n5WjIjbxn3/+Qs4p9bx+L48vzBla1eSVWbjRDwnccCWopbsYDstj
         fv0wUxmCj8Gc+DpsQ1BgSD055DrRoM5tvDDvio4BHO52Bc8bCl5WQ1oz7F2wfEhFy3yf
         DU4ReAeJSs1iIDOpIs8g5wxK6kPNvCIajOf3dcf+GXrxG9JvuK6JeRp+pqGJlPdZMOlj
         DuHg==
X-Gm-Message-State: AOAM532WW8ePaASRRmKDPJrVY08AoK4ahkc8o357BDYjb85Qt+ulPSQ7
        OX0zmYYvbskC99Dzxr9p31l99KTWNHfK8zQ1jOFVow==
X-Google-Smtp-Source: ABdhPJyHe8iRM84KrK6dTuGNdpxVVoq6lwssCgqCJnFgT/lL4ex/fl0tLxkqjF/9CuLd6Vxm+bMEsR7nsnt/D2ZfdeU=
X-Received: by 2002:a50:d809:: with SMTP id o9mr20387639edj.12.1599472983149;
 Mon, 07 Sep 2020 03:03:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200904154547.3836-1-brgl@bgdev.pl> <20200904154547.3836-4-brgl@bgdev.pl>
 <20200904163517.GW1891694@smile.fi.intel.com>
In-Reply-To: <20200904163517.GW1891694@smile.fi.intel.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Mon, 7 Sep 2020 12:02:52 +0200
Message-ID: <CAMpxmJWQsgV5WZrdPW3UUOVTEy1L6Y_rb7ThQK1QTRinmHSqWA@mail.gmail.com>
Subject: Re: [PATCH 03/23] lib: uaccess: provide getline_from_user()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        linux-doc <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 4, 2020 at 6:35 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Sep 04, 2020 at 05:45:27PM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > Provide a uaccess helper that allows callers to copy a single line from
> > user memory. This is useful for debugfs write callbacks.
>
> Doesn't mm/util.c provides us something like this?
> strndup_user()?
>

Yes, there's both strndup_user() as well as strncpy_from_user(). The
problem is that they rely on the strings being NULL-terminated. This
is not guaranteed for debugfs file_operations write callbacks. We need
some helper that takes the minimum of bytes provided by userspace and
the buffer size and figure out how many bytes to actually copy IMO.

Bart
