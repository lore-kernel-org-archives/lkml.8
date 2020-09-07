Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB1EAC433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 12:05:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6198215A4
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 12:05:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="sdlgVprv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729139AbgIGMFA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 08:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729190AbgIGL7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 07:59:48 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2994C061574
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 04:59:47 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id c10so12525384edk.6
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 04:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bR2mzR5z4Fp1s//vb7R8PemzbT1nIPea5CxsPeQGbCo=;
        b=sdlgVprv5Ml6FcGFfq4SFwKLBdhqpgt1/tD2prJUf3yezMMf+zk3OqmlSCmjl90GHA
         9J+0bfsuL2zGyEMQv67lgp7Uh5bekpJZkJHE6RCa3MxRx2asJEH0Rqd9mlGTMD/4z6Ur
         rlj+DdN2WEqADLINNVdSYBEhSR/vahUY1tKDlmtHNxKtIAaiKOIlwVeS9MfAxEMbdzNI
         veqHk6YVwBCiYL+JFMHTSCZgP67iVXGNuh01a9SlxoSynu7DM83hrYh4tzt5UwLCwkk9
         giM2ryBZgwbxSSOdWZIXQxuIHht3JyKr6Uv/HaVrENAUpyjSEsHY1RcTVtVySWPD86y2
         ro2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bR2mzR5z4Fp1s//vb7R8PemzbT1nIPea5CxsPeQGbCo=;
        b=O6x6LeFBICqtwfQk6jNduTJj+qKzTSEm+RqgHccsy/+UpNYZyKnLcvdu4N5WI+rMOU
         Z919d2YoXBBGkbpV6Se+oevVWPmHYmtRRySfcKiaFQPSzFCCmZSJSmvAYekOOXW5hSsP
         Jchc2nkRzLSSPQmhFH/lv0pmhkY6YYLWqhP6XB+CSp6gBNmPkIAkcWr5HSP59kLJBeNd
         9+L4c0S95A+Mu9PY2JLGdadIFNL1U+nULLuvgrpcRIbH4SOllIgPlYUZY896fnnrZqlv
         pDZpjJ3bVLMuaSD70MS8v963ftZ1womAV+1kIDAM700F0Oa8c5J+ivKhrfBpPNz8NHMO
         0sWQ==
X-Gm-Message-State: AOAM532RFHOLsiIj0vvDQIuL6srd5P6dm9vVR9CYAiqkNSwckqbOVtuk
        twqwKaN2ubfV/NJl+7NE/ghVOdT0ozVGH23fXjhUU/T6vcU=
X-Google-Smtp-Source: ABdhPJyvgUJP0ylxO5qehk4m0jdhpk8hsO0Sw1TL7vejIAJ+s0I1Q151uttBgmbE3hq97WmzbCF8SLXZr4mDtGwGZag=
X-Received: by 2002:a50:f687:: with SMTP id d7mr22155378edn.353.1599479986024;
 Mon, 07 Sep 2020 04:59:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200904154547.3836-1-brgl@bgdev.pl> <20200904154547.3836-16-brgl@bgdev.pl>
 <20200904164917.GC1891694@smile.fi.intel.com> <CAMRc=MeG8xuB0GNbMLi6+QZTphSN==77Hsw1fjVNU_+Z=Ky2qQ@mail.gmail.com>
 <20200907115051.GY1891694@smile.fi.intel.com>
In-Reply-To: <20200907115051.GY1891694@smile.fi.intel.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Mon, 7 Sep 2020 13:59:35 +0200
Message-ID: <CAMpxmJWM265uk39mddEwVUYJdnM+1Stx3Ds8O9-ucYvMnV7hRw@mail.gmail.com>
Subject: Re: [PATCH 15/23] gpio: mockup: use dynamic device IDs
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-doc <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 7, 2020 at 1:50 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Sep 07, 2020 at 01:04:29PM +0200, Bartosz Golaszewski wrote:
> > On Fri, Sep 4, 2020 at 6:49 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Fri, Sep 04, 2020 at 05:45:39PM +0200, Bartosz Golaszewski wrote:
> > > > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > > >
> > > > We're currently creating chips at module init time only so using a
> > > > static index for dummy devices is fine. We want to support dynamically
> > > > created chips however so we need to switch to dynamic device IDs.
> > >
> > > It misses ida_destroy().
> >
> > No, we always call ida_free() for separate IDs when removing devices
> > and we remove all devices at module exit so no need to call
> > ida_destroy().
>
> Perhaps couple of words about this in the commit message?
>

But ida_destroy() and ida_free() are already well documented. It's
clear that we remove all devices at exit and that every device removes
its ID, there's really no point in mentioning it again.

Bart
