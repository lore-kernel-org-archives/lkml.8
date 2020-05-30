Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86EE2C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 01:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56C46207F9
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 01:23:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TNc28tJD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728666AbgE3BXD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 21:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728293AbgE3BXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 21:23:02 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E484C08C5C9
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 18:23:02 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id g1so2233717edv.6
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 18:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zjszT2JE6xMGIXm75nxby+Q8WfWVB5aq51B6VNJEz/M=;
        b=TNc28tJDwppaFCuyJp1+ty2uKeDrRPpf8C6ZqyG9itPq2QOwDnsXc+OfMFxW+JZCj3
         xE7HSv22wI3UD4ZvtUs+CWyPr4PBEnN8Yd4VIyFVsDT8fcJeEYzRkHT/m2qs9/UGNYUL
         9pGhZwE8B18KsdOaOni52XIoO7EMOpGQdlaSAXDDNOp8JJDsDYfKKMX7vx/18FkiRvdI
         43peBEDngxdpG4b9cByUtiZT6XM1tmsN9XrYfvct0sKSBNl7waHDx/F1Rmq/cFWLEZJ/
         uHQUFccP5gNwq2YUfkA3pjZVnW8lZSSYWgT6JJCtJ66cpLPYvH7Bb8FI/Ady5clHIVYK
         +RXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zjszT2JE6xMGIXm75nxby+Q8WfWVB5aq51B6VNJEz/M=;
        b=gJZ98hhwq6Pu3RYls82QPzADqHcLHTvclNNOHpx7DTd7J5Zp+m3ytkbVWdbEXXxlni
         ViLbIDhcuKd3ZqO2ft9Eu/mnVZ0mGMy6brogsF2TfPNLP12xIb9HAg+u50MKMlv/a072
         FpL5scUAh/nwoy0VE49zVjieTRtfJjK+HgrLFk/h/uhxyqViZxJY9XZPpTKkZ6+MNNam
         UaJaKM8AU7VImE5ah0k/JAObG+G6d4ibtKl74j9z537xz6OVGtRP0J0ZHvfIidvcubrk
         AnFQJAYmpby2L7eHwgVgh15gSlJ8FA+L+mgYVYWgdIDMwogIdMbeaRooFAchy9GsyEZ4
         8gIw==
X-Gm-Message-State: AOAM531Zb/F/DfEhxtM7Nko5bmPl1s/9SGLvXUFUUeCuBZoByX9tzdKv
        GwgZDyxF19K5BW+vtwZUQBd1xNMFfOAJhOu1Fpksyw==
X-Google-Smtp-Source: ABdhPJzP1HlJIj2RUeIOTEHyYDQpbUUV85l3JuWPg83HE74RfhFht73sFTEF53WG+P8ac8s27jdSoae8Cmvo9ahhjP8=
X-Received: by 2002:a50:ed0e:: with SMTP id j14mr11400971eds.52.1590801780783;
 Fri, 29 May 2020 18:23:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200529195951.GA3767@dtor-ws> <CANMq1KDDa8jGwo9BNneJ=8y1HunM9hiRS2c0i5ASJ6+X4qvodw@mail.gmail.com>
 <CABXOdTeTHUtWyutfQ3oO7c_g=q5GrDsdKZbSe1dwLWSeNFi-sQ@mail.gmail.com> <20200530010926.GM89269@dtor-ws>
In-Reply-To: <20200530010926.GM89269@dtor-ws>
From:   Guenter Roeck <groeck@google.com>
Date:   Fri, 29 May 2020 18:22:49 -0700
Message-ID: <CABXOdTexbFqvHNALBeXrU5djbrLaK93fBTd6_rTCOhbEadYRgg@mail.gmail.com>
Subject: Re: [PATCH] HID: usbhid: do not sleep when opening device
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Nicolas Boichat <drinkcat@chromium.org>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Guenter Roeck <groeck@chromium.org>, linux-usb@vger.kernel.org,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 6:09 PM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> On Fri, May 29, 2020 at 05:48:26PM -0700, Guenter Roeck wrote:
> > On Fri, May 29, 2020 at 4:50 PM Nicolas Boichat <drinkcat@chromium.org> wrote:
> > >
> > > On Sat, May 30, 2020 at 3:59 AM Dmitry Torokhov
> > > <dmitry.torokhov@gmail.com> wrote:
> > > >
> > > > usbhid tries to give the device 50 milliseconds to drain its queues
> > > > when opening the device, but does it naively by simply sleeping in open
> > > > handler, which slows down device probing (and thus may affect overall
> > > > boot time).
> > > >
> > > > However we do not need to sleep as we can instead mark a point of time
> > > > in the future when we should start processing the events.
> > > >
> > > > Reported-by: Nicolas Boichat <drinkcat@chromium.org>
> > > > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > > > ---
> > > >  drivers/hid/usbhid/hid-core.c | 27 +++++++++++++++------------
> > > >  drivers/hid/usbhid/usbhid.h   |  1 +
> > > >  2 files changed, 16 insertions(+), 12 deletions(-)
> > > >
> > > > diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
> > > > index c7bc9db5b192..e69992e945b2 100644
> > > > --- a/drivers/hid/usbhid/hid-core.c
> > > > +++ b/drivers/hid/usbhid/hid-core.c
> > > > @@ -95,6 +95,19 @@ static int hid_start_in(struct hid_device *hid)
> > > >                                 set_bit(HID_NO_BANDWIDTH, &usbhid->iofl);
> > > >                 } else {
> > > >                         clear_bit(HID_NO_BANDWIDTH, &usbhid->iofl);
> > > > +
> > > > +                       if (test_and_clear_bit(HID_RESUME_RUNNING,
> > > > +                                              &usbhid->iofl)) {
> > > > +                               /*
> > > > +                                * In case events are generated while nobody was
> > > > +                                * listening, some are released when the device
> > > > +                                * is re-opened. Wait 50 msec for the queue to
> > > > +                                * empty before allowing events to go through
> > > > +                                * hid.
> > > > +                                */
> > > > +                               usbhid->input_start_time = jiffies +
> > > > +                                                          msecs_to_jiffies(50);
> > > > +                       }
> > > >                 }
> > > >         }
> > > >         spin_unlock_irqrestore(&usbhid->lock, flags);
> > > > @@ -280,7 +293,8 @@ static void hid_irq_in(struct urb *urb)
> > > >                 if (!test_bit(HID_OPENED, &usbhid->iofl))
> > > >                         break;
> > > >                 usbhid_mark_busy(usbhid);
> > > > -               if (!test_bit(HID_RESUME_RUNNING, &usbhid->iofl)) {
> > > > +               if (!test_bit(HID_RESUME_RUNNING, &usbhid->iofl) &&
> > > > +                   time_after(jiffies, usbhid->input_start_time)) {
> > >
> > > Are we worried about jiffies overflowing (32-bit@1000Hz is "only" 49.7 days...)
> > >
> >
> > time_after() is overflow-safe. That is why it is used and jiffies is
> > not compared directly.
>
> Well, it is overflow safe, but still can not measure more than 50 days,
> so if you have a device open for 50+ days there will be a 50msec gap
> where it may lose events.
>

Or you could explicitly use 64-bit jiffies.

Guenter

> I guess we can switch to ktime(). A bit more expensive on 32 bits, but
> in reality I do not think anyone would care.
>
> Thanks.
>
> --
> Dmitry
