Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B711BC43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:28:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F12F2098B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:28:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ZnrFESfj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731659AbgIHT15 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731041AbgIHQAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:00:04 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8713C06179E
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 08:54:45 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id nw23so23269883ejb.4
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 08:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=17XSh9T9gNq415bfysrvgCiRW+EHfAHcluquDHGHNnU=;
        b=ZnrFESfj2n78+Vm/aeBARRjr0Cl6BRKSKMzxUenn2YsqHz8Pl5VtWf2kgaAcBY42tG
         B6CWuSSZlDpqHRQb6BvAO8Qj0aSubGzT2OhkHzSatWgHZuhO2NLDDWNtkzr4B3imS/ar
         vl/89rmyhmxmIqD0cMqudwdc04Tupg9qwaODQQgwyE2ZseTX3Oi4XRaKk99z2tCwuCfj
         xF3ioMRogkeEctXIZNPqqZoa8qg7SATyuUHcJvqPp0NZvi3TzX7TxnBmmb77PTiAyqqS
         DDuXcYW5+1LtcAKBO7gHRXJ7JKmKD3P/Xjy6nG/2KEc5U2+vRVO9A35znCSC6HNByGzJ
         3lgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=17XSh9T9gNq415bfysrvgCiRW+EHfAHcluquDHGHNnU=;
        b=rnT3s1sWX8zFG0wDSkuuKNXYASPujgqr3vI9bvMMHXXG4WH9nY+OfK1Htm/2AyXi5t
         HbeQOXHXJxZA2qt1VnY1tCXm4fcjsCXBEa/xotGiTX5osk6zM1pvAGLn8alsh80FaIGa
         A5rfB8Ba+eNzOIdbTavOu81tPbUAwXnN4w58fyh9eZJin1fwV6SwZpUpwKlkEAvRnjLX
         iNEf8yXC7v2LWfYx6aOcokB6vm82cOYDSruH80oSxMxMes436j2NTUO1P5j7ByrUx0oJ
         jJ0znwhdLcLMHVl//ShGW4MkKFnsbm0KHaWW08rQfookblBLohQGVInT7s7y5z4sLiXZ
         w0Qg==
X-Gm-Message-State: AOAM533Y3ZUNyZHDKapGW2Sz85jDF+puDnvN0Z3yu3sFBnT6JxBwVjzM
        zZ70u5U8SfSUyuAEe/6Xjr0eQEkzD/9Ft+0qUTanLA==
X-Google-Smtp-Source: ABdhPJxOnl/Db9+LhMKu/mSd4ErqUeNGdtKZz7PhLmJ8sKtuj9avhfTUo76ZISBf0rvnNW6uboUfYq0v27quH+bjBW0=
X-Received: by 2002:a17:906:3e90:: with SMTP id a16mr17063280ejj.363.1599580484242;
 Tue, 08 Sep 2020 08:54:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200831032006.1019978-1-warthog618@gmail.com>
 <CAMpxmJUETJgmxzWzHumOVr+vWFQ27P71MtcdSdf_=jvtrSfRPg@mail.gmail.com>
 <20200903083750.GA17445@sol> <20200904125250.GA323947@sol>
 <CAMpxmJWVZ8Bf1gPibvbk=E5XNvQ_i76E430MMhUWwE1ACoPTQg@mail.gmail.com> <9db62b42-9a1e-0264-e88c-e636004cb629@linuxfoundation.org>
In-Reply-To: <9db62b42-9a1e-0264-e88c-e636004cb629@linuxfoundation.org>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Tue, 8 Sep 2020 17:54:33 +0200
Message-ID: <CAMpxmJVbujnp+Z0b3utDsGmhUgCbhydorOo-9e-=gVctT55NAg@mail.gmail.com>
Subject: Re: [PATCH v6 00/20] gpio: cdev: add uAPI v2
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Bamvor Jian Zhang <bamv2005@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Kent Gibson <warthog618@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 8, 2020 at 5:24 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> On 9/4/20 7:02 AM, Bartosz Golaszewski wrote:
> > On Fri, Sep 4, 2020 at 2:52 PM Kent Gibson <warthog618@gmail.com> wrote:
> >>
> >> On Thu, Sep 03, 2020 at 04:37:50PM +0800, Kent Gibson wrote:
> >>> On Thu, Sep 03, 2020 at 10:02:04AM +0200, Bartosz Golaszewski wrote:
> >>>> On Mon, Aug 31, 2020 at 5:21 AM Kent Gibson <warthog618@gmail.com> wrote:
> >>>>>
> >> [snip]
> >>>>
> >>>> To me it looks good, just a couple nits here and there and some questions.
> >>>>
> >>>> I think it's worth deciding whether we want to keep the selftests in
> >>>> tools/testing/selftests/gpio/ and then maybe consider porting
> >>>> gpio-mockup-chardev.c to V2 or simply outsource it entirely to
> >>>> libgpiod.
> >>>>
> >>>
> >>> Ooops - I wasn't even aware they existed - though it had crossed my mind
> >>> that the kernel should have some selftests somewhere - I use the libgpiod
> >>> tests, from my libgpiod port, and my own Go based test suite for my testing,
> >>> as well as some smoke tests with the tools/gpio.
> >>>
> >>> The libgpiod tests only cover v1 equivalent functionality, while my Go
> >>> tests cover the complete uAPI, and both v1 and v2.
> >>>
> >>> It would be good for the kernel to at least have some smoke tests to
> >>> confirm basic functionality, even thorough testing is left to a
> >>> userspace library.  So the existing tests should be ported to v2, though
> >>> should also retain the v1 tests if v1 is still compiled in.
> >>>
> >>
> >> I've got a v7 ready to submit that includes a couple of patches for the
> >> gpio-mockup selftests (their primary purpose appears to be testing the
> >> mockup module, rather than the GPIO ABI), but I now notice that the
> >> selftests/gpio section of the tree has a different maintainer:
> >>
> >> scripts/get_maintainer.pl 0021-selftests-gpio-port-to-GPIO-uAPI-v2.patch
> >> Bamvor Jian Zhang <bamv2005@gmail.com> (maintainer:GPIO MOCKUP DRIVER)
> >> Shuah Khan <shuah@kernel.org> (maintainer:KERNEL SELFTEST FRAMEWORK)
> >> linux-gpio@vger.kernel.org (open list:GPIO MOCKUP DRIVER)
> >> linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK)
> >> linux-kernel@vger.kernel.org (open list)
> >
> > Bamvor, Shuah: do you still have interest in maintaining these, or can
> > we update MAINTAINERS?
> >
>
> I maintain kselftests and gpio selftest falls under that. Please send
> selftest patches to me so I can review them.
>
> As for the gpio mock driver and test itself, you will have to wait for
> Bamvor to respond.
>

Hi Shuah,

I've been de facto maintaining gpio-mockup for a couple years now.
Bamvor has been quite inactive as far as gpio testing goes. I think
it's fine if you ack the selftests changes.

In fact: I don't want selftests to block getting V2 uAPI upstream so
if that'll look like it's going to take more time then I'm for merging
V2 without any changes to selftests - in the end we have tests in
user-space already.

Bart

> >>
> >> The v7 patch up to that point restores the functions that the selftests
> >> are using so that they build and run again.
>
> This test has been problematic because of its dependency on tools/gpio.
>
> >> So I should hold off on the selftest patches and submit them separately
> >> after the GPIO changes are in?
> >>
>
> Please send me the selftest patches. Also see the comments in
> selftests/Makefile about excluding the gpio test from default run.
>
> thanks,
> -- Shuah
>
>
