Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D029FC43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 977802080A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:54:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="W4qYrlMq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729285AbgIGRyk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 13:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728872AbgIGLWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 07:22:31 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 875C5C06179A
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 04:04:40 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id q6so12118047ild.12
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 04:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1B/HAY7CQ2kgdOMuMSUPk6pREpiLHnIcgbAxblH2K1Y=;
        b=W4qYrlMqsiKUO1IXIqKFB92tdgLj8OvcoC6QiZjOrJumIILg6kwYVZQVhMcjZZme8+
         uTxaZ4A44RW2FvoscbbPCukSKqOxq4PhOFmeSKlRJA51HjdobE7qutUP6wAhawWJEOaY
         NPRFM8tEqU1F7a1gwDoCcd+HxlFuRvxhsguq2aBVeoSm8Cz62KuDe09VU44giiaq+mQz
         217j2HZ87eJjd2a5Cjyq6IOjXBJjAfmfyIao982fWhcLfXj4u7ouDub5WWTQrUPkNmZQ
         sMkVEIqJp66qcey3Uy6vD5BmwWa2mQpn6BpQaryGEIBdxF2680B8qvfL8SPXXQfj9Ka3
         r/Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1B/HAY7CQ2kgdOMuMSUPk6pREpiLHnIcgbAxblH2K1Y=;
        b=GQ2qxbrRaduYFuE2IMF7UXnzdsd50/wofmgG3NgajE9I/9WmrGkzd5xhvnsXu4PZ+e
         7CCthyAIMwSvjWYllo/mI7SkJ6l9oOdaun69FKpazdGGgdZmn8qaELTLaA5Tn25bb1UN
         lA80mH0Kuyb9OkajTkr+bIXp/hDKVE4OpLCsxpV9xqIPz6gafRsWYrI5gwgaiabBnkdl
         q1tpstfPt9bjhTrtpyZSPbLqej6QXZ8e2uQnRX09mEdbuWhNjJ0jeKIiUSNdsKpXyyZH
         V8Oc8VC/WOkS2OWjTuLIJ+LwSQUkf93T7gzzSffshwm5egUE+l6U/4H2k6CVcrWU9xSK
         qzxg==
X-Gm-Message-State: AOAM532WpkDf4yV8VXD52dT4UArAHlemo6Xt54OigedwOoxqPOJbZVkx
        KjhaQbcSY5MJrRTEBIs98JA4VBhGVhlYrMxxrvTtAw==
X-Google-Smtp-Source: ABdhPJxCu1C6pdXbMZCPQ4I9idYD52QAe4Fl37C5i5Jt6npBXcV7EAl+4xXCL5VdCSbk4I7Fs4CQRXJ907+af8oRRr4=
X-Received: by 2002:a92:cb4d:: with SMTP id f13mr15703244ilq.189.1599476679896;
 Mon, 07 Sep 2020 04:04:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200904154547.3836-1-brgl@bgdev.pl> <20200904154547.3836-16-brgl@bgdev.pl>
 <20200904164917.GC1891694@smile.fi.intel.com>
In-Reply-To: <20200904164917.GC1891694@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 7 Sep 2020 13:04:29 +0200
Message-ID: <CAMRc=MeG8xuB0GNbMLi6+QZTphSN==77Hsw1fjVNU_+Z=Ky2qQ@mail.gmail.com>
Subject: Re: [PATCH 15/23] gpio: mockup: use dynamic device IDs
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-doc <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-acpi@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 4, 2020 at 6:49 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Sep 04, 2020 at 05:45:39PM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > We're currently creating chips at module init time only so using a
> > static index for dummy devices is fine. We want to support dynamically
> > created chips however so we need to switch to dynamic device IDs.
>
> It misses ida_destroy().
>

No, we always call ida_free() for separate IDs when removing devices
and we remove all devices at module exit so no need to call
ida_destroy().

> What about XArray API?
>

Answered that somewhere - xarray is already used internally by IDA.

Bart
