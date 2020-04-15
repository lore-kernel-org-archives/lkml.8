Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F07BC2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 10:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA17E20768
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 10:11:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=engebretsen.ch header.i=@engebretsen.ch header.b="BrQH8ZGb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896301AbgDOKLi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 06:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2896250AbgDOKKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 06:10:45 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C173C061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 03:10:45 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id k133so12285637oih.12
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 03:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=engebretsen.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ATXlOnGVgtW2lB4qANABFg41JlrWhiWA+2ZrpFtV2PE=;
        b=BrQH8ZGb7X2Pn9lyLecy3NLNj8/CHJ3WJ3iSM7IPhfpuE8L1PjXj39sR0PSbr3J+tw
         V6vfOSM/D/MvPCIEwlfp85oGHaW/lp5FT95sFe+UJK7jTzibSmj3ye8wrau5RwzEnEj3
         /4d9YzeRyWmhuMQD/Q8C9YwFZ9DoNRU0JsMNA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ATXlOnGVgtW2lB4qANABFg41JlrWhiWA+2ZrpFtV2PE=;
        b=lnBjfDTn8GJFTqCNAElbf6O8cfuREnGGRs4ANWoieldh+/8ay+huTikmrgo9hC0Xlz
         C8AOWfhRRoOy6OccvVkmM1wGBGCzII63s16suX1Sdcj/jYhHS5AWmUv/xtc83cnxSFnW
         HNgTJNhSLA0zGROxBhTED8ivaZGJjoFXlO9nYgHHNUd8sRC/RtXZnRbFPsUtF+hiKI6L
         epAQ6Wj1EP44RS/cKPwoZKXqbD1jcddKDX3drAq0bU1cQbhvyrWCiCmuPpogP3G+GH8F
         aY4LIt20aas4Khv8JdEz/m0YE2bR4RRarP66goUYiyGHpohB0jpxypaA3KmqnwXD/mIu
         nXzg==
X-Gm-Message-State: AGi0Puaqnx75uOkSpjrIMiyuMTyVwgJwosjrC81opjaaQpENlENzZ3YF
        RbRkdg9OkMF8+6BlMGCd9cn8p5MJuR6E7c9ZXhTW6w==
X-Google-Smtp-Source: APiQypI9MMDrdEz+x7wGoSq3Cjg1UnGQmPrpj3cpbpqzNpHOQtCE5VzAKCMkAxySLm3bq9hHvJoiLisHHZWz7C/237Y=
X-Received: by 2002:aca:fc57:: with SMTP id a84mr10223427oii.37.1586945444653;
 Wed, 15 Apr 2020 03:10:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200414184237.23018-1-lars@engebretsen.ch> <d11920433cd3c6476c1c0da18846b7d41cd1fde3.camel@analog.com>
In-Reply-To: <d11920433cd3c6476c1c0da18846b7d41cd1fde3.camel@analog.com>
From:   Lars Engebretsen <lars@engebretsen.ch>
Date:   Wed, 15 Apr 2020 12:10:33 +0200
Message-ID: <CA+XPV5O-PeDnfRDiZyDtSe+16PW5Qvmh3+eg1hMWR-+MWsvFoA@mail.gmail.com>
Subject: Re: [PATCH] iio: core: remove extra semi-colon from
 devm_iio_device_register() macro
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Alexandru! I'm sending the second version of the patch now.

Den ons 15 apr. 2020 kl 07:43 skrev Ardelean, Alexandru
<alexandru.Ardelean@analog.com>:
>
> On Tue, 2020-04-14 at 20:42 +0200, Lars Engebretsen wrote:
>
> A description of the change is required to describe the change.
> I think I mentioned this in my email, but I was lazy to provide an example.
>
> Description of changes are required even for the smallest of changes; I think
> it's mostly so that people always keep their brains trained to describe all
> changes.
>
> So here, you could say something like:
> ---------------------------------------------------------------------------
> This change removes the semi-colon from the devm_iio_device_register() macro
> which seems to have been added by accident via commit 63b19547cc3d9 ("iio: Use
> macro magic to avoid manual assign of driver_module").
> ---------------------------------------------------------------------------
>
> Make sure commit comments stay within a 75 column width limit.
> And make sure you add a version tag for the next patch/re-send.
> i.e. do  git format-patch -v2  [or v3 for 3rd version,]
>
> And it's a good idea to add a changelog after the line with '---' in the patch
> file. Text after that line gets ignored for the commit description.
> Something like:
>
> Changelog v1 -> v2:
> * added commit change description
>
>
> > Signed-off-by: Lars Engebretsen <lars@engebretsen.ch>
> > ---
> >  include/linux/iio/iio.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> > index d63884a54939..76ba7c9fd3e0 100644
> > --- a/include/linux/iio/iio.h
> > +++ b/include/linux/iio/iio.h
> > @@ -597,7 +597,7 @@ void iio_device_unregister(struct iio_dev *indio_dev);
> >   * 0 on success, negative error number on failure.
> >   */
> >  #define devm_iio_device_register(dev, indio_dev) \
> > -     __devm_iio_device_register((dev), (indio_dev), THIS_MODULE);
> > +     __devm_iio_device_register((dev), (indio_dev), THIS_MODULE)
> >  int __devm_iio_device_register(struct device *dev, struct iio_dev *indio_dev,
> >                              struct module *this_mod);
> >  int iio_push_event(struct iio_dev *indio_dev, u64 ev_code, s64 timestamp);
