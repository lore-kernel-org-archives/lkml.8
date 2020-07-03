Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B983C433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 06:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4946D204EA
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 06:30:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RgKdKXB1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbgGCGai (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 02:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725764AbgGCGah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 02:30:37 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B4BC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 23:30:37 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id p25so8782795vsg.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 23:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K4CTOkloIJSngYKP9mYdXYRzGngQiHdh+SB3XRrQL7w=;
        b=RgKdKXB1RGn9Zl3WeaqKIP/k/A+DXNglNKPOVbE9c6+WpA1mM46zKKrY32uDDnrQoA
         YNGiJMVO2zbHDdneDG2dmEYbBAI5TNUrvQ5B6vGd1AYv1VGPANZH510/A/esAHxq/mP6
         CUB5r4WEBRdC8OGLXe+OKs8NWnBnSxfPSrD2ln+8cuzO/5pOrYCBk+u2g6EtB76IBpdF
         K32Wvv58Hm7AsnRiaPd6abKMZNiVaH3O9Yy4KxgMoKoDscu3qimIlf5X9MKPsz/e+xNp
         wKBxrEN9MOQDfEPicfypVgrPfjfUpcwuxSBh3VT69Brq8UEMLHW+g9Ny/jphlwKDlxYP
         LGhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K4CTOkloIJSngYKP9mYdXYRzGngQiHdh+SB3XRrQL7w=;
        b=IyAF/T79alKwrxJA1mJf+a89S0eZv1GDwoOm1XqU3J5M2zaPTWXmlLZ5Kl7+ETRrb4
         x0tnotocNeQlpzBa4Q8yiiMTpH17JEFyoGu7ugZ8TrgZ5orHPV1O01mTE+2xaqVn47r1
         HhPZ8BkX62M57k/T1yTlCsEIE3EQlywWYCv0nhyudzFu/qWIKb9XhWFwGR/HSQyssl9C
         TTXF8cf3sT6WGMlsCxatqHb9gNAOLSnP334+F8ERL5t++grShMIjXzyxXUo+bSQ6iYO4
         uyVJg6gYwVqRVt0L66i7CfeNrtWg5TgxD5ICD9ntuTa0WFU6A/AFumFmfgiIvNRZe/Tj
         Bu2g==
X-Gm-Message-State: AOAM531GHNEi9FuE9GwlCaiBssenxQkp94yMTYz+qcrM3Aw66iX9KpTF
        ALqH4RDpl+SopXAZHOa5Dm4IColz6iuTK/Bzq1w=
X-Google-Smtp-Source: ABdhPJyFlr0qEIYFkZ5F4P9NqPrjy6PHLc2lkC9tuBddmoGutZTuHxrOvaPN/Mn4860Mx5DPCVFTT9IqZGI4YyfycKU=
X-Received: by 2002:a67:8cc7:: with SMTP id o190mr25922203vsd.168.1593757836584;
 Thu, 02 Jul 2020 23:30:36 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1592537217.git.vaibhav.sr@gmail.com> <e9aaa09c6688aa5ed8bddf51f5cd402bb8cf39b3.1592537217.git.vaibhav.sr@gmail.com>
 <20200701133655.GA2373798@kroah.com>
In-Reply-To: <20200701133655.GA2373798@kroah.com>
From:   Vaibhav Agarwal <vaibhav.sr@gmail.com>
Date:   Fri, 3 Jul 2020 12:00:00 +0530
Message-ID: <CAAs3648mdWoeByMP_4s3Rcu4fbbChTW9C8s=DeyQQ=g_=W_EbA@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] staging: greybus: audio: Enable GB codec, audio
 module compilation.
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alex Elder <elder@kernel.org>, Johan Hovold <johan@kernel.org>,
        Mark Greer <mgreer@animalcreek.com>,
        devel@driverdev.osuosl.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org, greybus-dev@lists.linaro.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 01, 2020 at 03:36:55PM +0200, Greg Kroah-Hartman wrote:
> On Fri, Jun 19, 2020 at 04:50:26PM +0530, Vaibhav Agarwal wrote:
> > Currently you can't enable the Gey Bus Audio Codec because there is no
> > entry for it in the Kconfig file. Originally the config name was going
> > to be AUDIO_MSM8994 but that's not correct because other types of
> > hardware are supported now. I have chosen the name AUDIO_APB_CODEC
> > instead.  Also I had to update the dependencies for GREYBUS_AUDIO to
> > make the compile work.
> >
> > Signed-off-by: Vaibhav Agarwal <vaibhav.sr@gmail.com>
> > Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
> > ---
> >  drivers/staging/greybus/Kconfig  | 14 +++++++++++++-
> >  drivers/staging/greybus/Makefile |  4 ++--
> >  2 files changed, 15 insertions(+), 3 deletions(-)
>
> Can you fix the build issues found by the bot and resend?

Sure Greg, I'll share the updated patch set with fixes for the issues
reported.

--
thanks,
vaibhav

>
> thanks,
>
> greg k-h
