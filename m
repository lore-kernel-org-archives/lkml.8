Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF52FC433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 16:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DD102080C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 16:02:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Pb2La35w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbgH0QCS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 12:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbgH0QCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 12:02:15 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC6FC061264
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 09:02:15 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id bo3so8344651ejb.11
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 09:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d2EanueJM2XSw5YRZCjtUeiiCZijMpX8hJxxqxioM78=;
        b=Pb2La35wDygarqxiCkXeSo05iWU4CW7Rgv0VQojfZ1ZDhV2LgeE+yijO9R3VDvNmi7
         YZFVfEsMdVL8jArUxkiFjtnaIE+A7DKI6xQwekCT2tnJDKY0QKitgGNshY00aS9wVKuz
         yB0+R37A2THVuzBjXk3FFwonX9CfPdYkFfTmF/4wMc5TCLosP5W5HlzDKMWMjykW/8R8
         z4pSqrvpqewBqh1e1pHnXoW/f8RA5woqfsnZ+7pMieyyYXsNUKYxNn74frZ1tfM4C4ec
         CSL5hmhHEFZ89ou00bK63ldjQ7+l1hgj+ZGPcGuXdLM0agw8cN3kaXK4p3UG6OocYPkI
         k2GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d2EanueJM2XSw5YRZCjtUeiiCZijMpX8hJxxqxioM78=;
        b=mX3/8wg9iCG0XyNn9tHth0o3x7LN9SpjKdyLtUW6eZCOCbtSGXgl6DL47cnyXEs14n
         Wn92lFEIVkruldq1kdHOubZAuJCBE601f9Hg8tt27rgWKC07T3+mpKlBz6xmInHm/yDS
         CBlF77Wp5fXMuBhMDcLSMBEzuhuflpealTZ0BzvCF5mswJa9Q3T8pf/eES9RFPI2mNC1
         P1dCy5ZOcvMSAnkkMecNKUhPCPSPIH/qnJymzJCODX0j5uDJ4jvigc8CJgfMjAAa0KML
         Z2QZJtBipG0l/YyBSaM0ZSOBUbiZq2YRWQ3Pv7xOk7qRyw0tYV/5HmS1qqAb9LmsVRYx
         7qeg==
X-Gm-Message-State: AOAM531Sp7G62se6a7lYTMROd1t50DE2zmpQx6UJAM0jaZWWDp/kSK9V
        c+Esr1vgdxJrLJq8yA0PkVcbkgVHBhNXYRLCLj8O4Q==
X-Google-Smtp-Source: ABdhPJx0X1aK9V7O+lCHW4GVRc2yDb5PZkBCNGlXM3YXbRvH8p6kVD4z5l2kcfxOYFfVsy+6wEC1OjQYpcEPEnCc3Bg=
X-Received: by 2002:a17:906:19db:: with SMTP id h27mr19177114ejd.154.1598544133876;
 Thu, 27 Aug 2020 09:02:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200827140020.159627-1-warthog618@gmail.com> <CACRpkdZZMbfpKy4gcfAzNq53LkYLcL9wm3Qtzyj_K8vkUW9RfQ@mail.gmail.com>
In-Reply-To: <CACRpkdZZMbfpKy4gcfAzNq53LkYLcL9wm3Qtzyj_K8vkUW9RfQ@mail.gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Thu, 27 Aug 2020 18:02:03 +0200
Message-ID: <CAMpxmJXRY2wqqN3SzfJN+QTWAHYSYz4vEjLKWU82Y=PAmcm=5w@mail.gmail.com>
Subject: Re: [PATCH v5 00/20] gpio: cdev: add uAPI v2
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Kent Gibson <warthog618@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 5:53 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Thu, Aug 27, 2020 at 4:00 PM Kent Gibson <warthog618@gmail.com> wrote:
>
> > This patchset defines and implements a new version of the
> > GPIO CDEV uAPI to address existing 32/64-bit alignment issues, add
> > support for debounce, event sequence numbers, and allow for requested
> > lines with different configurations.
> > It provides some future proofing by adding optional configuration fields
> > and padding reserved for future use.
> >
> > The series can be partitioned into three blocks; the first two patches
> > are minor fixes that impact later patches, the next eleven contain the
> > v2 uAPI definition and implementation, and the final seven port the GPIO
> > tools to the v2 uAPI and extend them to use new uAPI features.
> >
> > The more complicated patches include their own commentary where
> > appropriate.
>
> I'm ready to queue this now. Certainly any remaining snags can be
> fixed in-tree.
>
> It kind of keeps in tradition with proper software projects "plan to
> throw one away" which is what we have traditionally done several
> times: the first Bluetooh framework was tossed, JFFS was tossed
> for JFFS2, Video4Linux was tossed for V4L2. So let's do this.
>
> Anyone against? I will put it on an immutable branch and then merge
> that in for devel.
>

Hi Linus,

please hold it maybe for one more week - I'd love to have some more
people take a look at the user facing header at least. Andy is usually
very thorough in his reviews so I'm Ccing him here.

I'll too skim through the series one more time.

Bart
