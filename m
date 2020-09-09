Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F775C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 10:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B28B521D7A
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 10:59:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="mZGcdKZt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728611AbgIIK66 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 06:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727055AbgIIK6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 06:58:21 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96DB6C061573
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 03:58:19 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id gr14so2919499ejb.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 03:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hu65HGw7lD3rRilEx9VGlqvryu5AO8PpY3vy5bDHdp4=;
        b=mZGcdKZt8qCyIVy8y24txARqimWW+2gYMnqdXTiD5UAlSCAt+BHUHixKl4PFE1zgTU
         eLMeDFiCHpKz/ZIqAZPTuO4ZRz8fbu43K+AXAnUbzFJ4LbXuCK4fhWuZw0iQD+SDxweH
         upyX2G3PA6KMABVK2FRR3xD3kxhfS7B7ZHxPHea5+k6+5gHF3VFqvanO7IBNqtxdJTiJ
         zvXImRz1GeSPhtp+lrUW5Cp6mLBaFv2gMU9sGUl59W7JcmYMx33240ioJl26+8VHfQ60
         mFmmI9CD0GGDcTNaNGR5+VvfbW6YbRBZEL4D2uEWQyPmgtC2tl0cDk06I9MWvExXeMiq
         La0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hu65HGw7lD3rRilEx9VGlqvryu5AO8PpY3vy5bDHdp4=;
        b=S5Qv6YgkiQIum2/KYfethUCidtGReIFWM8VEZKyw6zRRFRsmcNhk/UZYYbFYNRzUdH
         oPe+Znu8XlfnzDEVwOfnCxIRKaM57AJRvCzO6608MQKYmYl5/aFB91vqaLpgzM5C1xM1
         pchmjFFxTvyKeJBt5447+sWye3afDb3oUqTs5Wm8cfvbEVZP5CYRdYOlNAH2M/pYMj3h
         8U+J1U0MZHGCnAWK5RcT4V3W1VEkLknBI4mVGah7otRAi1z5shxPfp+4tEf2q6hjMlpe
         AMhOPbL5yhgh5I90Uu/TaxuEdSHBJMXtz1LzbvGDbnO9XkmN3CcpWDzyPxlxOcPpJed1
         JS5A==
X-Gm-Message-State: AOAM532z8NevC1PasA4OO792Fb8Mx9fHMQouzEwdO2CNZKHMLaQTEONf
        5ze7q/3XVKZPz4uj+aahYYnr9jD5Ck/+XDp3a2esaQ==
X-Google-Smtp-Source: ABdhPJzVrHGzQqV0LHArkKovVyu9MjaO3CeazQ+IrJy6Yj2B0/g6jByCwi3w6+KE/Fs6Ph4rtOC6BBunPbai0tsoNE0=
X-Received: by 2002:a17:906:e4f:: with SMTP id q15mr3170587eji.155.1599649098390;
 Wed, 09 Sep 2020 03:58:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200909085426.19862-1-brgl@bgdev.pl> <20200909103440.GM1891694@smile.fi.intel.com>
In-Reply-To: <20200909103440.GM1891694@smile.fi.intel.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 9 Sep 2020 12:58:07 +0200
Message-ID: <CAMpxmJXsxqG1aJWp7Jwj9k1wiWJoPgWug2hUqCc+rZPoRwgojw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] gpiolib: generalize GPIO line names property
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 9, 2020 at 12:34 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Sep 09, 2020 at 10:54:23AM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > I initially sent this as part of the gpio-mockup overhaul but since
> > these patches are indepentent and the work on gpio-mockup may become
> > more complicated - I'm sending these separately.
> >
> > The only change is adding additional property helpers to count strings
> > in array.
>
> Seems it lost my tag for patch 1/3, but in any case now I'm good with it
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>

I removed your tag from patch 1 because I changed the name of the helpers.

Bartosz
