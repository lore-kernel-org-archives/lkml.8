Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40621C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 13:02:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11F442073B
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 13:02:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="XPTAekBX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730336AbgIDNCk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 09:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730010AbgIDNCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 09:02:39 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E44CC061245
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 06:02:38 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id q21so6039527edv.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 06:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=py331tU/dS8B+p+QL/GfpvBAThxgQcvBqHpIco6OZf4=;
        b=XPTAekBXdjp1zg6XcrQsSDBhv6Td+yjs6TQWmt2e6ABqt6Ces7wnkkjU3DyWIAxlg5
         lLBbFAE7DfQBzEcwyBIKUKTNN+PVRtgyuZonLh5E9k/N7OW14qhI0wzljO6Dx4Gzi7DL
         zTbx45tIpaCydCDj8jvjwd6bT+julciQyTgPuU+Ov21SE1fnFu5Y8/qgzoDNAATmg1EG
         lkHJpWUHGwmUCdOel8ILmqCgXI17fzK/GPOrGEP4BNBHaaSJEaxD3+gKeZZuDCJqaaJX
         /QPknR2xkDKg/orAul0g2pWtPRlrBy8fFV4yXko3JI5BbAjWMA8gA+GKuP+UZsfikazY
         w4Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=py331tU/dS8B+p+QL/GfpvBAThxgQcvBqHpIco6OZf4=;
        b=KBSA9U0GJJv60d3sTLkvNVv7HJfj8Cux/a0yLd4PxWYdqcXw933fltIVyeEPs/8i0L
         2d+aKr9rqaBgvoHmx9g6MNSpvnl6uUUg2UgXEOgh+HxZehvY/gRZl3UjTsrJ9KVvhgO7
         usNVx77SXKbxYjQA9UGLKFAOhGgxNrdhZeq1zcSCME/SGN6bXhPS+vtI3EJqypZlnQm9
         SmOL+hZUlPY93S3UdcMln/Ebq5K8KOZzBegoTwDZArSf+G24smu1Uo4QfoTWLY9py9cb
         16HWMG/TsrtPWFNdIsnRVfVZ4mw+ii085Rj5K7217gmRKhWr+pla/ioSE3SS1zSzXBcx
         VyCQ==
X-Gm-Message-State: AOAM532uQIoDEFqXEgjYuparl6FH9BBmgAbjkwffn45WbON2tCjhms35
        fD2WWBRpiwUqo5068ZmskPoXAWZk89FsnZo5IVmD7g==
X-Google-Smtp-Source: ABdhPJxENorReiMcFJ1ELBNazOkBgXgqx3iK4DDfOdoXejxOa5mDrshUwTYC4EVFHSsuoljPmK+RzhLQAe85psy+ReM=
X-Received: by 2002:a50:e79c:: with SMTP id b28mr8612901edn.371.1599224556598;
 Fri, 04 Sep 2020 06:02:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200831032006.1019978-1-warthog618@gmail.com>
 <CAMpxmJUETJgmxzWzHumOVr+vWFQ27P71MtcdSdf_=jvtrSfRPg@mail.gmail.com>
 <20200903083750.GA17445@sol> <20200904125250.GA323947@sol>
In-Reply-To: <20200904125250.GA323947@sol>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Fri, 4 Sep 2020 15:02:25 +0200
Message-ID: <CAMpxmJWVZ8Bf1gPibvbk=E5XNvQ_i76E430MMhUWwE1ACoPTQg@mail.gmail.com>
Subject: Re: [PATCH v6 00/20] gpio: cdev: add uAPI v2
To:     Bamvor Jian Zhang <bamv2005@gmail.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Kent Gibson <warthog618@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 4, 2020 at 2:52 PM Kent Gibson <warthog618@gmail.com> wrote:
>
> On Thu, Sep 03, 2020 at 04:37:50PM +0800, Kent Gibson wrote:
> > On Thu, Sep 03, 2020 at 10:02:04AM +0200, Bartosz Golaszewski wrote:
> > > On Mon, Aug 31, 2020 at 5:21 AM Kent Gibson <warthog618@gmail.com> wrote:
> > > >
> [snip]
> > >
> > > To me it looks good, just a couple nits here and there and some questions.
> > >
> > > I think it's worth deciding whether we want to keep the selftests in
> > > tools/testing/selftests/gpio/ and then maybe consider porting
> > > gpio-mockup-chardev.c to V2 or simply outsource it entirely to
> > > libgpiod.
> > >
> >
> > Ooops - I wasn't even aware they existed - though it had crossed my mind
> > that the kernel should have some selftests somewhere - I use the libgpiod
> > tests, from my libgpiod port, and my own Go based test suite for my testing,
> > as well as some smoke tests with the tools/gpio.
> >
> > The libgpiod tests only cover v1 equivalent functionality, while my Go
> > tests cover the complete uAPI, and both v1 and v2.
> >
> > It would be good for the kernel to at least have some smoke tests to
> > confirm basic functionality, even thorough testing is left to a
> > userspace library.  So the existing tests should be ported to v2, though
> > should also retain the v1 tests if v1 is still compiled in.
> >
>
> I've got a v7 ready to submit that includes a couple of patches for the
> gpio-mockup selftests (their primary purpose appears to be testing the
> mockup module, rather than the GPIO ABI), but I now notice that the
> selftests/gpio section of the tree has a different maintainer:
>
> scripts/get_maintainer.pl 0021-selftests-gpio-port-to-GPIO-uAPI-v2.patch
> Bamvor Jian Zhang <bamv2005@gmail.com> (maintainer:GPIO MOCKUP DRIVER)
> Shuah Khan <shuah@kernel.org> (maintainer:KERNEL SELFTEST FRAMEWORK)
> linux-gpio@vger.kernel.org (open list:GPIO MOCKUP DRIVER)
> linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK)
> linux-kernel@vger.kernel.org (open list)

Bamvor, Shuah: do you still have interest in maintaining these, or can
we update MAINTAINERS?

Bart

>
> The v7 patch up to that point restores the functions that the selftests
> are using so that they build and run again.
> So I should hold off on the selftest patches and submit them separately
> after the GPIO changes are in?
>
> Cheers,
> Kent.
