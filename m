Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C0B5C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 08:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F48C21919
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 08:46:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aZmuo4hr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730172AbgIIIqr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 04:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730128AbgIIIqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 04:46:39 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F12FFC061573
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 01:46:38 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id gf14so1000427pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 01:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LI1eT1wVUUbEcJhIlIYcasKfk7EA1KHs1hVsDnExyOI=;
        b=aZmuo4hrrmyxV15MZvTpjPdhO69+xbBqijiZ719cFJe9E+irJ9yvuzUTLIf3BHXE7s
         O9RYz5mWXZJwB/Jx5VwbLmxzGmc4i4Ki80IjhtbqJH9D5kZmOHlwaGzu4wBqNcfixgTk
         14TrMfxg9DkXDZizrKNFpbHoJdfJKAP5S92vqp7YW2Uik39jpZAQoUeYYLaMt4Obbrck
         GwPmNLdQDGvcaIEftHU1mNNYbGDzX1qjlsH2eZHMJciIWhUzFkLewBj1/HjWXFzxOBGZ
         OCRlucCI5/oOZLMFlQk0EPzdtkenBkRpp8QHVI55sDsj0VPVdYy4989Linda/NC5JmXZ
         xiBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LI1eT1wVUUbEcJhIlIYcasKfk7EA1KHs1hVsDnExyOI=;
        b=RzW7JXUFGCAHE8kKiKi1Hgzh3QEjanGzCIbRhOqokhBZuzjxv+fW1KTTmE8z2CIZ9d
         /rsT8QZcGMCM+edoNXlpiXyeZlbCNo514gJFM4IusGeQufjGm4BlgDuQq/QwmhFmLKG+
         PlQdyht6Inp6M88OdlBD5gF1eZbI6NodgmX2gE4JC0IIMJoJk8g3nkXjNSNxgEHXvmEz
         LLUVCejVJ3y438c1fJyUQTowWINXtxv+rVNVjiePBEXJgwjE4+9/MW96Xnp28Q7aiwu/
         eCkLkh2I09C9MqVcVK3V/IUGO2Mz5VPcNKmQENhGvYK2WOIzLjOC1AP9VZVwsVIEgqM9
         V2fw==
X-Gm-Message-State: AOAM530TwiuwPKlJFOUSNkaCPhfLfO2NALSJAcZtK83Yze5O8M5JYnQd
        cHcAbTKM8zwT3/M+dJqEsePiGPv8HY878eHZhUU=
X-Google-Smtp-Source: ABdhPJwG4NUZMl7Oq+tys9v7UEH4acrxs7ggLj+InMb9GpBSK7XWkGwnX3fl5EMKvqmUd3xMp4JrOlQ7fa7X1adAHCU=
X-Received: by 2002:a17:90a:fd98:: with SMTP id cx24mr2552470pjb.181.1599641198404;
 Wed, 09 Sep 2020 01:46:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200826104459.81979-1-andriy.shevchenko@linux.intel.com>
 <9635eaa4ccc1141fb0dd8c3687f46da7149206ad.camel@perches.com>
 <20200826155507.GV1891694@smile.fi.intel.com> <973f4d54da796db4fcc9b643b10889cbc8839989.camel@perches.com>
 <CAJKOXPcCAPy-v38dyY_74H_6vrgj0mmEf6KaupVKJb4E2Ha_Ug@mail.gmail.com>
 <20200909070244.GC311356@kroah.com> <CAJKOXPd=TfCNfHPdsQZ42VEcUZOFZroXg7xmA82zSA=AbADxKw@mail.gmail.com>
 <20200909073716.GA560912@kroah.com>
In-Reply-To: <20200909073716.GA560912@kroah.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 9 Sep 2020 11:46:21 +0300
Message-ID: <CAHp75VfePEHzuSqfhChFNPsh+Jq+-_VqdDULxtFbzKR5DsT7WA@mail.gmail.com>
Subject: Re: [PATCH v1] driver core: Annotate dev_err_probe() with __must_check
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Joe Perches <joe@perches.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 9, 2020 at 10:40 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Wed, Sep 09, 2020 at 09:08:14AM +0200, Krzysztof Kozlowski wrote:
> > On Wed, 9 Sep 2020 at 09:02, Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > > On Wed, Sep 09, 2020 at 08:29:25AM +0200, Krzysztof Kozlowski wrote:
> > > > On Wed, 26 Aug 2020 at 18:18, Joe Perches <joe@perches.com> wrote:
> > > > > On Wed, 2020-08-26 at 18:55 +0300, Andy Shevchenko wrote:
> > > > > > On Wed, Aug 26, 2020 at 08:44:30AM -0700, Joe Perches wrote:
> > > > > > > On Wed, 2020-08-26 at 13:44 +0300, Andy Shevchenko wrote:
> > > > > >
> > > > > > ...
> > > > > >
> > > > > > > > -int dev_err_probe(const struct device *dev, int err, const char *fmt, ...);
> > > > > > > > +int __must_check dev_err_probe(const struct device *dev, int err, const char *fmt, ...);
> > > >
> > > > +Cc Stephen and Greg,
> > > >
> > > > Hi Andy,
> > > >
> > > > Did this patch ended up in next somehow? I am surprised because now I
> > > > got warnings for perfectly fine code:
> > > > https://lore.kernel.org/linux-next/20200909155654.76fe3bd6@canb.auug.org.au/T/#u
> > > >
> > > > This creates simply false warnings instead of hints for "optimization".
> > >
> > > Yes, it got merged into m y driver core tree.
> > >
> > > I'll fix up the tty build warning, should be easy enough, the patch is
> > > below.
> >
> > Yes, this fix suppresses the warning but the question is whether we
> > really want the warning?
> > Such fixes mean additional code which the compiler might not optimize
> > (unless it inlines the dev_err_probe()). This additional code is
> > purely for suppressing the warning, without any meaning on its own.
> > Actually it might be even confusing for someone to see:
> > if (ret)
> >   ret = dev_err_probe(ret);

The problem here is that the dev_err_probe() returns int on purpose.
In your patch what I can see it seems another issue is that the driver
is semi converted to devm API and thus uses goto:s here and there.

> Yeah, that is dumb, as the patch I made shows :(

I agree.

> > warn_unused_result should point errors, not "optimization
> > opportunities". If you want to have opportunity, add a coccinelle
> > rule. Or a checkpatch rule. Not a compiler warning.
>
> Ok, I now agree, I'll go revert this patch and trust that driver authors
> will "do the right thing" here...

I'm fine (as I stated during a review of that patch) to go either way,
but I see it would be nice to have drivers be better thought about
using devm APIs.

-- 
With Best Regards,
Andy Shevchenko
