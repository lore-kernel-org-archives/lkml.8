Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 927FBC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 17:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E40520842
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 17:47:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="IFMbREdn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730151AbgHDRr4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 13:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729197AbgHDRrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 13:47:55 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D0AAC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 10:47:55 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id 6so31618365qtt.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 10:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vJQZtv+ow+YbDJRfhWQ9Vcz7jUjTYioprT+26YJF36A=;
        b=IFMbREdnSywh01d/8n0vqGeCkKX0UfmKFrN1Tvu3eFG34JVWSRXLe8u1ZN7BHiCoe4
         1KZ+oMGQMvJPPTVOiNiGtdXG4NRgwihXeI0NTMkKiPoO3Gh1VbYGxgJxDfQHTlJJtyRQ
         CpYXD2sK6kSR9soFySDloPfnakYOwvAFKrTFhNasuJ8GCobev408Qd545YoRtUvS2r2t
         5p6YIn9iZiPITNf2LD/SPtyBx7n8ouN53crP3bOmD9ANaDFC9+lDf4q7pBm+Opf6c0SZ
         rWSG7+rne0nxrJc1itsSLNzuT0wsKSiCesA81pBzsp/Mm8S5Ec951eddaD+LjQVBTY8m
         YKkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vJQZtv+ow+YbDJRfhWQ9Vcz7jUjTYioprT+26YJF36A=;
        b=rmtK3qIXreIihgLKCDCt7UXjk4eR9+l5xqX+0dBvLslbE7EmCyIVHdP1ZpT9z+FZmU
         Y3/lop3tx4coXliZKvyYPIoYH2JE3YHonQF7IBd1pqsClIQKZcAjwNi5sv0M+8B+3acJ
         gOzsNMdqLqdxoDyY6xB/lLxIkyNQbOOTaIoBH4tyDtrEBcDbkI03GlS2oiVXRiyHM2rZ
         7ijK89M03DC5eRFCdvFdwBHeJR4kBsazK0QvtYEBJPa2tzux0qCewYaLp9cQidbm67Ae
         6ALwsxfd0AP061Y/HH4Y+55j2xaE3QCWoeHLmdzSBwjlWmgArgBtDnr8BYn7ZDT2G85j
         stww==
X-Gm-Message-State: AOAM531NIf1VPWAjIyxzyk5PbW1Ayu8INxqh307s/cM8E2U3mLLfPvIa
        gipIxD8RFoRIXXQJvTcUMWX63ub4Y1BRVCGm2mNdjw==
X-Google-Smtp-Source: ABdhPJzpOHWlFfvVFo46MDG/sgF7jrDmA+scF9yTbLmHzdbU4zPxh1a/cmOzD0OutsW0j7GYKsAUIrUN/lWPozKabnU=
X-Received: by 2002:ac8:1488:: with SMTP id l8mr23068578qtj.131.1596563274360;
 Tue, 04 Aug 2020 10:47:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200725041955.9985-1-warthog618@gmail.com> <20200725041955.9985-6-warthog618@gmail.com>
 <CAHp75VcKtATPDKGAViWqjOJDqukDrgZ13aTU6rTJ1jEeB3vmVw@mail.gmail.com>
 <20200726011244.GA6587@sol> <CAMpxmJWaEVwjXSFHTYmwdfA+88upVkJ4ePSQf_ziSOa1YdOUKQ@mail.gmail.com>
 <20200802033158.GA13174@sol> <CAMpxmJWZpMFbrMBkLiR9q7chdamVnjw0geDf-pgKrz=AWD8mNg@mail.gmail.com>
 <20200803230118.GA3650@sol>
In-Reply-To: <20200803230118.GA3650@sol>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Tue, 4 Aug 2020 19:47:43 +0200
Message-ID: <CAMpxmJXv2Ruo-yJTm9bjyj90jWMA_BWHuNyVwyXkzxqmzoHoHA@mail.gmail.com>
Subject: Re: [PATCH v2 05/18] gpiolib: cdev: support GPIO_GET_LINE_IOCTL and GPIOLINE_GET_VALUES_IOCTL
To:     Kent Gibson <warthog618@gmail.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 4, 2020 at 1:01 AM Kent Gibson <warthog618@gmail.com> wrote:
>

[snip]

>
> > Also: I just started going through the patches - nice idea with the
> > GPIO attributes, I really like it. Although I need to give it a longer
> > thought tomorrow - I'm wondering if we can maybe unify them and the
> > flags.
> >
>
> I had an earlier draft that did just that - and that is partially why
> the loop is last in wins - I was using slot 0 as the default flags.
> But the default flags cover a lot of use cases, including all of v1, and
> it was simple and cheap to provide a default - and it simplified the
> initial port of libgpiod to v2...
>

If porting libgpiod to v2 is the only concern then I wouldn't stress
about it. At the same time I'm wondering - is there any use-case where
we wouldn't need the flags attribute for at least some lines? Because
if it's always required than maybe having a default isn't that bad.

Bartosz
