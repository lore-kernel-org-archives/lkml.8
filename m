Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65763C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 16:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F48A206FA
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 16:19:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jkj2lJ/w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727905AbgHZQTZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 12:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbgHZQTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 12:19:20 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80DB8C061574;
        Wed, 26 Aug 2020 09:19:20 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id d22so1234382pfn.5;
        Wed, 26 Aug 2020 09:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ilq96LncB63Fy/CIWeCW+LtnzaRpV/8JBgOE+6AYhNY=;
        b=jkj2lJ/wIshXTsGOEM64SsGQiF7RQEp7AAMTx/xiXkBBHv2KNeujd9MOPiD5kyQY8K
         hf6yqxBesJFomueFy75MOk012wz7xpqJ0MwXVnD5pgU3v+SuGh9PQoHMTlzllEWlNso2
         c2jmgT7yi0ZERQqXEdy4W3JE3P3vqVcJsoSp0jYSzSZoaxhBYV8ujdHHKWFn8BSpF9ya
         mDIP+nyshLpiaJo8ZWYtQ58DI3chffKPgs6EUoLzrkDi0/ei3lYuVqKQ67l63bUgPAEA
         9L/IrVAGvC03lLBPyY9u2Lj3waTfRLL82ppuYy0hqNnVehBouQnPIJkCoKDYDMIc/WkZ
         kifQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ilq96LncB63Fy/CIWeCW+LtnzaRpV/8JBgOE+6AYhNY=;
        b=r4YsJIIdD8f65cfsvkamlYuy5vLjM4vI1P3391jhbSrSEbJNbeXFCVpHZ8CND7tgfr
         1ej4Symqf93qz1BLWX1ecUnGrSwAyO1Eq74ww8VlippxDqrdRLOuXPpHqjThBoi9P5a2
         /sa75+914hWpPjDayo6aJrS8DTYYY5/9Yflca3vp+UokQkUTNCYpflhZ2ssJbvv4TDKw
         gnALAZObpaxArPChwfiVurgB+JTVHjjEpyjfbJYofgUlFlipOTM7JheW0wUUEb/hHXuy
         ReWFKZb6UtMazl6JtC2oKJ3NoOwUJXtA03dDRCLpLGEPy5KDLfAeDlewYVnKRYiVMaHp
         bNag==
X-Gm-Message-State: AOAM5322X2KxYR7ObvgQqYJCD1ZxX8YpVcf1FxjJNWn9/5V67T5B4e7t
        47yqe/dxP0l1CHU7zo2rgi9DKctdDoHSGa+ZsiU=
X-Google-Smtp-Source: ABdhPJza63eLcR7I3PDHKJp/Uyg9y5yJyruqodtcmJ8VwI4Uaxaj+0hTzcGzEO/9K2txWYSgQ2JOVl14QF3S4xXzvnA=
X-Received: by 2002:a63:f24a:: with SMTP id d10mr11083692pgk.4.1598458760092;
 Wed, 26 Aug 2020 09:19:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200826134315.GA3882506@kroah.com> <CGME20200826150239eucas1p24c59716cc31edfeb2eece84d97936b93@eucas1p2.samsung.com>
 <1425ab4f-ef7e-97d9-238f-0328ab51eb35@samsung.com> <20200826153347.GB4187816@kroah.com>
 <CAHp75VepkugjZ4pvdNgxzT4T83ewL1AFtSZZtVq6aL+7=sqskA@mail.gmail.com> <de6aea2f-5f31-4391-0c36-8fd5fd63ab05@samsung.com>
In-Reply-To: <de6aea2f-5f31-4391-0c36-8fd5fd63ab05@samsung.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 26 Aug 2020 19:19:03 +0300
Message-ID: <CAHp75Vc=Z3y6eq0M174w314Lje=cujEk70qjbu+mVdobZsYt=Q@mail.gmail.com>
Subject: Re: [GIT PULL] USB fixes for 5.9-rc3
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Brooke Basile <brookebasile@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        USB <linux-usb@vger.kernel.org>,
        Ilja Van Sprundel <ivansprundel@ioactive.com>,
        Kees Cook <keescook@chromium.org>,
        Felipe Balbi <balbi@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 26, 2020 at 7:17 PM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
> On 26.08.2020 17:53, Andy Shevchenko wrote:
> > On Wed, Aug 26, 2020 at 6:36 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >> On Wed, Aug 26, 2020 at 05:02:38PM +0200, Marek Szyprowski wrote:
> >>> On 26.08.2020 15:43, Greg KH wrote:
> >>>
> >>>> Brooke Basile (2):
> >>>>         USB: gadget: u_f: add overflow checks to VLA macros
> >>> Sorry, but the above patch breaks USB Ethernet Gadget operation. It also
> >>> didn't get the proper testing in linux-next (next-20200826 is the first
> >>> one with this patch).
> >>>
> >>> This is how it explodes on Samsung Exynos (ARM 32bit) based board with
> >>> g_ether module loaded:
> >> Odd, for a "normal" descriptor, the logic should have remained the same
> >> as without this patch.
> >> Brooke, any ideas?
> > I have an idea.
> >
> > Does below fix this?
>
> Yep, that's it. I've also moved offset assignment in the first part
> after size_t size = array_size(n, sizeof(type));
>
> Feel free to add:
>
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

Will send a formal patch soon. Thanks for reporting and testing!

-- 
With Best Regards,
Andy Shevchenko
