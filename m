Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A5BC433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 09:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B26982075A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 09:35:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="M3VlSuGC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbgIGJfN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 05:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727122AbgIGJfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 05:35:12 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2532C061573
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 02:35:11 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id r7so4005214ejs.11
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 02:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zWiBkyNR4NmqF6Xi+QYxcrwWHaTtKTEGdcAvhHWhr24=;
        b=M3VlSuGCT37L6/cEDxf/7m3TmmdEvvMXM4a1lpqs0rwejcga965t8vdzNH14IDItqh
         Ir7QEpJVci43ovtMBpX3ZXM6m7UVmyZd/v80fFkFTbgAIrn/YagNY+pEtY+PWC2rZNfo
         2kqc8y5qSRjdmcKl0aP1NU4rBTNy7ls3n+oqwuiSbjx1i8KLyRnwo4GesrFoQfwJCGad
         1XN2MSLE7ETYfqeHGyJFHbSrKlJho9ay+kMalDSPl2qdFM6kDhl9Ja4+tw37SiZyMA0Y
         OxTuOKLkz5DNaCsk36KqoxqONHJ8ebHSd3ii1c130bTueA03IJ4VXtUkR7saklfQFa/G
         n/Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zWiBkyNR4NmqF6Xi+QYxcrwWHaTtKTEGdcAvhHWhr24=;
        b=VSddNVhOdpIcXIPlY2d88pU5MCJTlcwK45CBhkkb33uzfUSMGhQMpmJKXactuGLl6j
         WZ0t/riyEUDbogYvnjno8ecq082hyzUC/EWNf2A1uwfKrF9uhoNSQDZKhLccfc2O+ik5
         mh28JzuVs+VRDBEa86I8hgVtfUUa2yRfzgd+igtSjer34jeXU/S3N9FOvNkk8mrzGeNz
         2jNfEYyhUr96BlXmq9ygl9k4Fh9Nn+5otdugsA0X3CwjAomltZUHRM4v5sfZ4o30Q+wx
         TPeOzbL6TrUAVUvEygEpZHOiszeOzhTszP7QxC7R420KoLra/O1vB1z84NwhkMfgBvAD
         O/2Q==
X-Gm-Message-State: AOAM530kYGADnqfqK4W4oF4nLCZ57uV9YYFObbKi3QVgKKxl9TlxyQSQ
        RYQqsf5rxssC2H9GZkJITIvfJZoK68ug95GkBXmQ6BA7yOc=
X-Google-Smtp-Source: ABdhPJxC+wnC4RcIh0+9NGS3tVoJg77zPEi+RwFplg2OzDxLBNbLBDbGW/xRDfjZzqMO3gnCI2ZQzzPWhHuWCNVU0K0=
X-Received: by 2002:a17:907:20d9:: with SMTP id qq25mr15641325ejb.382.1599471309917;
 Mon, 07 Sep 2020 02:35:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200904152116.2157-1-brgl@bgdev.pl> <20200904152116.2157-8-brgl@bgdev.pl>
 <20200904154144.GL230586@piout.net>
In-Reply-To: <20200904154144.GL230586@piout.net>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Mon, 7 Sep 2020 11:34:59 +0200
Message-ID: <CAMpxmJWwNfLvpuB_1ba037UzVX9UEz7SzDEJuft0jv3txGRJQg@mail.gmail.com>
Subject: Re: [PATCH 7/8] rtc: rx8010: fix indentation in probe()
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 4, 2020 at 5:41 PM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
>
> On 04/09/2020 17:21:15+0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > Align the arguments passed to devm_rtc_device_register() with the upper
> > line.
> >
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > ---
> >  drivers/rtc/rtc-rx8010.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/rtc/rtc-rx8010.c b/drivers/rtc/rtc-rx8010.c
> > index 181fc21cefa8..ed8ba38b4991 100644
> > --- a/drivers/rtc/rtc-rx8010.c
> > +++ b/drivers/rtc/rtc-rx8010.c
> > @@ -450,7 +450,7 @@ static int rx8010_probe(struct i2c_client *client,
> >       }
> >
> >       rx8010->rtc = devm_rtc_device_register(&client->dev, client->name,
> > -             &rx8010_rtc_ops, THIS_MODULE);
> > +                                            &rx8010_rtc_ops, THIS_MODULE);
> >
>
> You have bonus points if you replace that patch by switching from
> devm_rtc_device_register to devm_rtc_allocate_device and
> rtc_register_device.
>
> More bonus points if you also set range_min and range_max and then get
> rid of the range checking in set_time.
>

Hi Alexandre!

I've just looked at the code and wondered why there's no devm
counterpart for rtc_register_device(). Then I noticed that the release
callback for devm_rtc_allocate_device() takes care of unregistering
the device. This looks like serious devres abuse to me. In general the
idea is for the release callback to only undo whatever the devres
function did and this should be opaque to the concerned resources.

In this case I believe there's no need for the 'registered' field in
struct rtc_device - this structure should *not* care about this - and
there should be devm_rtc_register_device() whose release callback
would take care of the unregistering. Since this function would be
called after devm_rtc_allocate_device(), it would be released before
so the ordering should be fine.

Let me know your thoughts.

Best regards,
Bartosz Golaszewski
