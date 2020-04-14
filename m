Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 675E1C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 08:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 468A8206D5
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 08:38:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="y8PtE+gT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436963AbgDNIiK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 04:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2436951AbgDNIiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 04:38:08 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABD8EC0A3BDC
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 01:38:07 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id f82so7804638ilh.8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 01:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Jo/o9ww/4cJSnmnkD3CjyH8WMNoX0+k4o9KsdfhD1SU=;
        b=y8PtE+gTsDZZwWFwSeHHeCFQ33Ojb2y6ulbiOVndaSWifuuU1qY5CJhInz8wkvASVH
         yVPA5Cg4kidytaGezrBCLdW4Ot8vgNCUOjK1xXp0gMXNgy8sAT71WrdTTw6cF9Lg/9aR
         0j5+CLbOZOKInlCz7qORieFxv7d/WB/5Ft+UWYOoOcqt45CjWh0vGWn+jiDIsbJub6Zx
         6RTgxEu9otv8/DDGf2UCmwNYUDW1jtxjvh3oN5hh+yh8eGHq0OO3mKBpvqGx7mJBFtFt
         FPlMkosertwNnlsQqcXiYpSZpteWM6yEM5v1cMAMZi4xQ9cYoOikip2laVHl5Mv5niBy
         b5bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Jo/o9ww/4cJSnmnkD3CjyH8WMNoX0+k4o9KsdfhD1SU=;
        b=QcAZnF8SKCEZPhMI3BefK3FKKow/HBmW48qa66UrD5GZ9+K3e1eYhp8dGOgaYu2utv
         /zl5vUlO8LsP9xoOP7pJwOyodKuyD45RNEuywiWI23EtCOGWN1otg9McdppBBeD7o+Rc
         aRBxZ7OTCzk7e8ekD9OFimVOwCMNrCnVmR35vAbJz+bCEUCZgw/OywXiGSrUNJR4Bdve
         mTmtOzl61RsZj6Bu4XaweCisXz6EpLCjfbt31HEmBD+OUwMbq/8hJUgW+l4GEXUyAFvk
         vB9TB8bEc1XQas6kWtZXhkeaTxQisW2cKWg2CG58V7E+mbuABlAPA59Ysrs9koWgLiDl
         7pMA==
X-Gm-Message-State: AGi0Pubdwg4KOXnTIbPDtQRasS8/L5aXIFI17ft2FHGEpBP5TZQibfF2
        /vEJdqFp6krRElqNx0HraBQ2khpYvuYQmE16Ti8WoA==
X-Google-Smtp-Source: APiQypJLEx+4wdr30LFxsnO4FePdVk1/hUYO2QfJBCM4GEMyVVTdfS1Zgqb6bqkEsd+A63s85UfcT0IaUyDRqecuwjY=
X-Received: by 2002:a92:dac8:: with SMTP id o8mr12258552ilq.189.1586853487047;
 Tue, 14 Apr 2020 01:38:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200211131240.15853-1-brgl@bgdev.pl> <CAMRc=Mc=gTrpQsMdOTBJaYT6JLg=o17Mm78ijAGUJYE2pXcCQQ@mail.gmail.com>
 <20200413180728.0714da3d@archlinux>
In-Reply-To: <20200413180728.0714da3d@archlinux>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 14 Apr 2020 10:37:55 +0200
Message-ID: <CAMRc=MenWERT6VegvdRkwJ5xKwa01QRK+BbE2GhEk-+Jw36GvA@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] irq/irq_sim: try to improve the API
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pon., 13 kwi 2020 o 19:07 Jonathan Cameron <jic23@kernel.org> napisa=C5=82(=
a):
>
> > Hi,
> >
> > it's been three weeks, so gentle ping on that.
> >
> > Or should I resend the entire series with a more elaborate commit
> > message for patch 1/6?
>
> I'd resend it now if nothing has happened that I missed.  Merge window
> having just closed, it's the perfect time for a rebase on rc1.
>

Yeah, I'll resend the first two patches which are less controversial
and then see with the rest of them.

Bart
