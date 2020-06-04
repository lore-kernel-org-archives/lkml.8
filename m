Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DCE1C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 12:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5972A206E6
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 12:06:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="JDruNPPk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728574AbgFDMGs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 08:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728554AbgFDMGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 08:06:42 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE99C03E96E
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 05:06:42 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id w3so5658068qkb.6
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 05:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jSQHC1o3f5m5emzxu9YBcPNRqKngKwzMlx+TKTi0XtU=;
        b=JDruNPPkDTGBxJQk+jI2G9ZRH1SJmQtyus/t8H9KtBs8Rb9bGj1e1/ClynWK9gEbBt
         HNqs7c/AEdpw4zCNLIOrzC5Ucd6TqJ/WwrO92NFNQ7GuGw4DK8IcjKP4jYtD7snAe5TV
         EbAhGhVO9jTc/GFjwupNGZYe+owFtDNwy+IiVXJwWWYCw/LvGGu3mvWmnTLKootUzVYp
         wBUdWNuAD+BbmlCaVCq8otnoeyQhpefh5XQbTMZbDph6YeNPhYhZ0mSQgHl0VzmNxUi2
         7bp0NDj74Krnv/WHb1hoA6WXqF+9hYvtvmnAD5KROSA5bDkPaAHjX3DiaAuzTy5BhyzC
         M70A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jSQHC1o3f5m5emzxu9YBcPNRqKngKwzMlx+TKTi0XtU=;
        b=A5/azaVOWTYU6Dm4Np5lt95Z5vdeJegZtSU5UdbXtciZecJMw0rUkNP+UgCq+DL2f5
         1coSGLkHh27KibtbSGwfR21lAxn0Jtn1yandMFq4DBW6Luq/HIoiWRCfkhb5+sN0X/0p
         z//3OvxMXijPJldNDojPi8zjIWJJwSf4G+GtXtropDBdA8IgM+rFlxouRmK19pGcNQMo
         nN5DMWR9W9fkVa6xSbhfs7sqMbhuyqMgAMPJG/aIWas6A/i77Kw6hrbFHcr1idYt05Vv
         3YguLgwyDfGoE9oN/swc4xNTFdnHS/lfPWDYF/jpkJeA2lVWiYtsH6h9sKJC2Uup8zP4
         J5PA==
X-Gm-Message-State: AOAM533HYToDLFq9VaB45UXsroMYHYguO8SujG9VfymylLHaN+nb1pLo
        WJTeH6PK78iIIMUsVlm2FSZ5/A2hXvkVWORTK+Ktvw==
X-Google-Smtp-Source: ABdhPJyD7+lCfVAQJ1oyaF8Br8FLt6SIzAwugbG4sH7U8+avpScU5Ikt1971Gx8kBKqzvlH6XR8X0LSQxEeSj6gFrB4=
X-Received: by 2002:a37:aac4:: with SMTP id t187mr3933753qke.263.1591272401774;
 Thu, 04 Jun 2020 05:06:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200516064507.19058-1-warthog618@gmail.com> <CACRpkdbputuoHFWL_FhUNR-ZywvJt=qYdaa+i2cLt-Odmgxe2w@mail.gmail.com>
 <20200525141902.GA27938@sol> <CACRpkda4PEYd5UGbLkq9w1RBbtOdZxuMQ75k-nu5YfoKTZ_azA@mail.gmail.com>
In-Reply-To: <CACRpkda4PEYd5UGbLkq9w1RBbtOdZxuMQ75k-nu5YfoKTZ_azA@mail.gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Thu, 4 Jun 2020 14:06:31 +0200
Message-ID: <CAMpxmJVzMJkPSrL4uhfCgjXb7CkLSOH3kW=aeb68LRNJenKRiQ@mail.gmail.com>
Subject: Re: [RFC PATCH] gpio: uapi: v2 proposal
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Kent Gibson <warthog618@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C5=9Br., 27 maj 2020 o 07:58 Linus Walleij <linus.walleij@linaro.org> napi=
sa=C5=82(a):
>
> On Mon, May 25, 2020 at 4:19 PM Kent Gibson <warthog618@gmail.com> wrote:
>
> > > > +struct gpioline_config {
> > > > +       __u8 default_values[GPIOLINES_MAX];
> > >
> > > So 32 bytes
> > >
> >
> > Actually that one is 64 bytes, which is the same as v1, i.e. GPIOLINES_=
MAX
> > is the same as GPIOHANDLES_MAX - just renamed.
> >
> > On the subject of values, is there any reason to use a byte for each li=
ne
> > rather value than a bit?
>
> Not really, other than making things simple for userspace.
>

I'm in favor of using bits here. I think we can rely on libgpiod to
make things simple for user-space, the kernel interface can be as
brief as possible.

Bart
