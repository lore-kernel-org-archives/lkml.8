Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 739E7C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 09:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D20A20781
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 09:42:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=melexis.com header.i=@melexis.com header.b="OjMGGmCA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbgHNJmp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 05:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726699AbgHNJmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 05:42:44 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A0EEC061384
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 02:42:44 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id g14so10266675iom.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 02:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AspIN0mKod2D4fw11QEsKNtq92S2lAnwdSlAe9wE40U=;
        b=OjMGGmCAnlktilu79lmfTPRv171f69fT08t+qaQHMbxST6z2QcobCk+RVa/GghD+yU
         DAyHdImgAJzstNveAnXYZOBN7x1H/qNSzO0EFR+arDrYvNNKXc/SYbQAeDmDqIRmpoAk
         lvWHRDoTAMiSLkYznS8jqsVqafYK93TAAnVbKFXJHyXOoX7YTPCI+1SX/v7r1uACPxdO
         UVmSxllGDoXzSVNfOUo2bPx7xzG7OjSjziJIg/IUhkqPBtDoE88XG/9ip+WphUeIK5hJ
         hdC6dirSin7v/WnXEUl1RFT/H/l4+xc+8KVIYJLjoPI6zSuZz3mqsmsItqiHWFkoe07g
         Yq1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AspIN0mKod2D4fw11QEsKNtq92S2lAnwdSlAe9wE40U=;
        b=qdHXuBDASXopAHhW8NO/OuU9ow3Fke5z4JpK165haEk/dhphF1HlJkBmI1mup7PLJp
         8ktPlPL4WRNbRw+l/9D8W9nJpRCtPqgG9TPXy6ItZpJuyvaHJLf1qkXf+AdFgqqtnAVz
         vt72VWMmdC8q9HyQVKmnJ4H5V0Apb7D5N93GDqf07wLszeOVvmU9vzD1CLIO3gn7eg6E
         00dy/ctAbwf5kQIwej3lkM3RqjLYJwTlgSNrMe6U8W0Cz8c+JSDrZ/nnSPMGQAOxMxD/
         SqMedETF/BkVDkCt8ezarNoVo7I9o/4eCQvUFgEX976UvP55Nzsr7ToDKygU8EQlTSdg
         63vQ==
X-Gm-Message-State: AOAM5313KHTSs/1iz3bH3kFicmXmgxQ1PSyU4YIDPa0EUp1WOXdnVPmb
        8EohaUpWixsCs7lA9dLwqQV2IlKlIOr4ZeiL1QOGHHLW9/ONJA==
X-Google-Smtp-Source: ABdhPJyYHB4rlqQ6DIvZ/ZMd0V4MEKTcbHltccZZWTakaQmZcA7txa+DPHXLYXpSb3gVaHKSG5qHFkmgdAqh2fjAfUo=
X-Received: by 2002:a6b:ba89:: with SMTP id k131mr1443918iof.133.1597398163441;
 Fri, 14 Aug 2020 02:42:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200813075125.4949-1-cmo@melexis.com> <20200813075125.4949-4-cmo@melexis.com>
 <CAHp75VfNwb5uBp=H0295LEJjXy1+=V5yvSN1PHbtMYzgg=_EAA@mail.gmail.com>
 <CAKv63uv=b60B9RXBJF4HEhMOowu-qbGrv7LsmJVvkkERSida-A@mail.gmail.com>
 <CAHp75Vd+3SopKog6uhSKoOLn+tECsQfs7kRbJsrMZEbNRpk8bQ@mail.gmail.com>
 <CAKv63usrjEHTmYtahedqULnqu-fM3TFC8HJ=S4h+w=UTv5sd-Q@mail.gmail.com>
 <CAHp75VeH5SA2KeiTSN__8ndj1v_SEb7mEWPG1p2Lz-tATDWi8A@mail.gmail.com>
 <CAKv63uvQBoD=a2ADG7XBoQd2JRt6ggK0UB-g6cSuWLE7EV+qww@mail.gmail.com> <CAHp75VfAbufX+jYcxnp8AyAzZ0M42jRCkP5X1sRqXm0jpoyvrQ@mail.gmail.com>
In-Reply-To: <CAHp75VfAbufX+jYcxnp8AyAzZ0M42jRCkP5X1sRqXm0jpoyvrQ@mail.gmail.com>
From:   Crt Mori <cmo@melexis.com>
Date:   Fri, 14 Aug 2020 11:42:07 +0200
Message-ID: <CAKv63utpidP12iQXWU59=F+cVCq6oShSAitmKhoC4W4aaPtnRA@mail.gmail.com>
Subject: Re: [PATCH v5 3/5] iio:temperature:mlx90632: Convert polling while
 loop to do-while
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Aug 2020 at 11:32, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>
> On Fri, Aug 14, 2020 at 10:33 AM Crt Mori <cmo@melexis.com> wrote:
> > On Thu, 13 Aug 2020 at 21:41, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > > On Thu, Aug 13, 2020 at 4:04 PM Crt Mori <cmo@melexis.com> wrote:
> > > > On Thu, 13 Aug 2020 at 13:24, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > > > > On Thu, Aug 13, 2020 at 2:14 PM Crt Mori <cmo@melexis.com> wrote:
> > > > > > On Thu, 13 Aug 2020 at 13:03, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > > > > > > On Thu, Aug 13, 2020 at 10:53 AM Crt Mori <cmo@melexis.com> wrote:
> > >
> > > ...
> > >
> > > > > > > I don't see how it prevents using iopoll.h. It uses usleep_range()
> > > > > > > under the hood in the same way you did here, but open coded.
> > > > > > >
> > > > > >
> > > > > > One loop is indeed 10ms and that is not the problem, the problem is
> > > > > > that timeout is at least 3 calls of this data ready (3 channels), so
> > > > > > that is at minimum 30ms of timeout, or it could even be 4 in worse
> > > > > > case scenario and that is outside of the range for usleep to measure.
> > > > > > So in case of the other loop, where we wait 200ms for channel refresh
> > > > > > it is also out of scope. Timeout should be in number of tries or in
> > > > > > msleep range if you ask me.
> > > > >
> > > > > I still didn't buy it. You have in both cases usleep_range(). Why in
> > > > > your case it's okay and in regmap_read_poll_timeout() is not?
> > > > >
> > > >
> > > > I tried and it did not work, so then I read the manual. Looking into
> > > >
> > > > * regmap_read_poll_timeout_atomic - Poll until a condition is met or a
> > > > timeout occurs
> > >
> > > Why _atomic?!
> >
> > I just pasted something, it is the same as for non _atomic
>
> OK.
>
> ...
>
> > > >  * @delay_us: Time to udelay between reads in us (0 tight-loops).
> > > >  *            Should be less than ~10us since udelay is used
> > > >  *            (see Documentation/timers/timers-howto.rst).
> > > >  * @timeout_us: Timeout in us, 0 means never timeout
>
> ...
>
> > > > > > > >                 usleep_range(10000, 11000);
> > >
> > > You use here usleep_range(). The same is used for
> > > regmap_read_poll_timeout(). What's the difference?
> > >
> > > Since it uses 1/4 of the range you probably need to update tries and
> > > timeout_us to make it work.
> > >
> >
> > Timeout_us here needs to be in one case 100 * 10ms (maybe not
> > realistic as we could live with number of around 40 * 10ms), but this
> > is a lot more than proposed range of usleep which Is up to 20ms. Even
> > in best case this timeout should be 40 ms to give enough time to
> > measure 2 channels for sure. So with the current timeout_us
> > requirement we are outside of the range of the udelay timer and that
> > is why I would need a macro with number of tries, not with the timeout
> > value (or timeout value of ms).
>
> I do not understand. The regmap_read_poll_timeout() is a macro which
> unrolls in the very similar loop you have now in the code.
> What prevents it from using it?
>
> I think there is a big misunderstanding about the parameters of that macro.
> delay_us (must be small enough), timeout_us can be any long.
>
I tested on Beaglebone with the 100 * 10000 as timeout_us and I always
got the -ETIMEDOUT error. I also tested in the other case where
delay_us is 250000 and then timeout_us would be 4*250000 and I have
also received -ETIMEDOUT as a response.

I can prepare a patch with the iopoll.h API and maybe you will spot
the mistake, as after rechecking timeout_us is indeed 64bit and is
only used in the time comparison operations and not with timers.

> --
> With Best Regards,
> Andy Shevchenko
