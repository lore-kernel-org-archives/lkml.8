Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78E4AC433E5
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 16:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5624E206F4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 16:25:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="hobbJLEq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728232AbgGJQZC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 12:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726965AbgGJQZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 12:25:01 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1DF7C08C5CE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 09:25:01 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id q3so5543914ilt.8
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 09:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H7XPdCmgMImqZF5JZngrO4+1byShoBQA2GaG6Zy8eaQ=;
        b=hobbJLEqmM+wICRtCGxo8FSciKrE87YjCY5bfIUhTss0vkvgGWa+D+W96pQg9tNjrk
         JuNjLXEhmjktE4CmN/yuM7qa2QoMD6HKRBB4viJeUCZxI9GJtZs/QuPlw+XZ2Ng8/XKu
         8yiHkY90GhRsU/J1avCZ6B6ly27LYnl/fVFG8A404lZ2uB5K5oREfCmsZaXnOMVED+an
         O6/GiT0Vyxn4ja3ox5HA8S5l24/2WmtnB/9zIcM7kvN+tT5bS8RVQfKxXeugk6V3l6zx
         lkH+zAhVf3W7YdCv0MeR6Ia7W7wuYJ9jjiBVDNDm7KJSBcxL1ieYnKSpJm/vd1p7U858
         /+0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H7XPdCmgMImqZF5JZngrO4+1byShoBQA2GaG6Zy8eaQ=;
        b=bb7zIIUsFTEPosJg2RtvHY/2dt7hxosodHRtTqlIw/WYmh0QCLHgkbv2L7+Tq+0Rl4
         8uGeO7towWmNXCc3pjUNmU9VGjwRb3GSEt6tBhIe+I5oizPTk7POHLa29JVvBXAajEef
         8znFg2hKrxjzjbBxPSN33+0zG8EaYDhXTKeOtjRTnJw011EoPDvRCWCSqX9/rahekB+C
         NnvmXijNtwZirryE2oSqUxnx6A7diC4Bm0BHVwzmy4k1UeWG7QDx88jR7kQI4+HsAHOx
         I8g9pbgCOho4ZWH9lDtJ2wu0gZN4y2mN2XmQPvRRi4E6ietlCm54Lu4en4Ats0av0Kab
         gIdQ==
X-Gm-Message-State: AOAM531u7jDDQsECLJnWTslfNnLaSlTm/hZBH1TvyVSFFFKM3r/z4tiz
        Z+EQBRgKrxqHAIW6qXx3Z86U6Ko1LXfG8ODTCcscBQ==
X-Google-Smtp-Source: ABdhPJzmLRXRa132tJNdcpdJ4Dy0Mb5/hs/BvJA3zvV0lcrgQHupJU92RI4frdEdYqeKnxmpOFkBkaI7MpLUlGHuja0=
X-Received: by 2002:a92:c00a:: with SMTP id q10mr29286029ild.220.1594398301007;
 Fri, 10 Jul 2020 09:25:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200629065008.27620-1-brgl@bgdev.pl> <20200629065008.27620-5-brgl@bgdev.pl>
 <5c2e7514-b6d0-1331-37b0-d17a0cdb9693@nvidia.com> <CAMRc=Mf1Laqa65hEOG3iLSQu6J-u5yHmrMNh8NMJmt3amw2A6Q@mail.gmail.com>
 <9cd4521b-aba0-616b-8957-8f21b9ba3068@nvidia.com>
In-Reply-To: <9cd4521b-aba0-616b-8957-8f21b9ba3068@nvidia.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 10 Jul 2020 18:24:50 +0200
Message-ID: <CAMRc=Md+iHTeaYi1F-ykb3HaDTBoiGuNr7s224ay9Jgfhy1TcA@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] devres: handle zero size in devm_kmalloc()
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        linux-doc <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hwmon@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 6:11 PM Jon Hunter <jonathanh@nvidia.com> wrote:
>
>
> On 10/07/2020 17:03, Bartosz Golaszewski wrote:
> > On Fri, Jul 10, 2020 at 3:46 PM Jon Hunter <jonathanh@nvidia.com> wrote:
> >>
> >> Hi Bartosz,
> >>
> >> On 29/06/2020 07:50, Bartosz Golaszewski wrote:
> >>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >>>
> >>> Make devm_kmalloc() behave similarly to non-managed kmalloc(): return
> >>> ZERO_SIZE_PTR when requested size is 0. Update devm_kfree() to handle
> >>> this case.
> >>>
> >>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >>> ---
> >>>  drivers/base/devres.c | 9 ++++++---
> >>>  1 file changed, 6 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/drivers/base/devres.c b/drivers/base/devres.c
> >>> index 1df1fb10b2d9..ed615d3b9cf1 100644
> >>> --- a/drivers/base/devres.c
> >>> +++ b/drivers/base/devres.c
> >>> @@ -819,6 +819,9 @@ void *devm_kmalloc(struct device *dev, size_t size, gfp_t gfp)
> >>>  {
> >>>       struct devres *dr;
> >>>
> >>> +     if (unlikely(!size))
> >>> +             return ZERO_SIZE_PTR;
> >>> +
> >>>       /* use raw alloc_dr for kmalloc caller tracing */
> >>>       dr = alloc_dr(devm_kmalloc_release, size, gfp, dev_to_node(dev));
> >>>       if (unlikely(!dr))
> >>> @@ -950,10 +953,10 @@ void devm_kfree(struct device *dev, const void *p)
> >>>       int rc;
> >>>
> >>>       /*
> >>> -      * Special case: pointer to a string in .rodata returned by
> >>> -      * devm_kstrdup_const().
> >>> +      * Special cases: pointer to a string in .rodata returned by
> >>> +      * devm_kstrdup_const() or NULL/ZERO ptr.
> >>>        */
> >>> -     if (unlikely(is_kernel_rodata((unsigned long)p)))
> >>> +     if (unlikely(is_kernel_rodata((unsigned long)p) || ZERO_OR_NULL_PTR(p)))
> >>>               return;
> >>>
> >>>       rc = devres_destroy(dev, devm_kmalloc_release,
> >>
> >>
> >> This change caught a bug in one of our Tegra drivers, which I am in the
> >> process of fixing. Once I bisected to this commit it was easy to track
> >> down, but I am wondering if there is any reason why we don't add a
> >> WARN_ON() if size is 0 in devm_kmalloc? It was essentially what I ended
> >> up doing to find the bug.
> >>
> >> Jon
> >>
> >> --
> >> nvpublic
> >
> > Hi Jon,
> >
> > this is in line with what the regular kmalloc() does. If size is zero,
> > it returns ZERO_SIZE_PTR. It's not an error condition. Actually in
> > user-space malloc() does a similar thing: for size == 0 it allocates
> > one-byte and returns a pointer to it (at least in glibc).
>
>
> Yes that's fine, I was just wondering if there is any reason not to WARN
> as well?
>
> Cheers
> Jon
>

Why? Nothing bad happens. Regular kmalloc() doesn't warn, why should
devm_kmalloc() do?

Bartosz
