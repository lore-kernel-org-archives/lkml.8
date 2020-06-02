Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AF8BC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 09:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B4B3207FB
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 09:14:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I3BHBMRt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbgFBJO2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 05:14:28 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:54122 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726217AbgFBJO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 05:14:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591089264;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4RDDGu/p3yDXdb7tcQQ0NXx81PbLpa+m/UKBUd+JAOM=;
        b=I3BHBMRtTPoc2aGAf13q+0bp+LLLgKStCnKQzAOID9l3izUQk4X7Xq48GtJiNLF8Cz/Epe
        3mMINeOvc9sXQ2L6S+k01nwWNuWOxuBjB3SlifPxx6E16f0J/ZE+sXkYwjZx9wiaVa1GW7
        duWbobe3NNOiN0q6dvpo21xucBgsS6I=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-160-4TGcpgD-NpiMKixDzkrzvg-1; Tue, 02 Jun 2020 05:14:21 -0400
X-MC-Unique: 4TGcpgD-NpiMKixDzkrzvg-1
Received: by mail-qv1-f69.google.com with SMTP id w6so2904390qvj.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 02:14:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4RDDGu/p3yDXdb7tcQQ0NXx81PbLpa+m/UKBUd+JAOM=;
        b=U0EdNoNGFC6MguI9gzete/Gezfdf0qTc4mz3dVxtGyXxRU9dYRASvk70jqG0hFR3DH
         bP5JPIwt/c01jcz0IV20ICtNEjnTRMh9tKVoB5AW82JwJSa+mFJLQP9D5KQRV3e/4HS/
         yD/+iXmy52RtWQV2/iJIE2X2UzBkrFjLiCeU1xR1NsfiOE0HR2snytgWkYPR8wBGHmcx
         cbEWr6W1hnDTK7fsxbMNRVSu0BMwEUFgEzBZaNaExuTR+0LtwrBNCL/xN8ONcBPHwXwX
         YtEV948YutJo2pmtCK3SJp8TtgcP9k30s8mkmiEWanq8OSHtEmoa0gR0loyLHXztJNF5
         7SeA==
X-Gm-Message-State: AOAM530Ylbk2Dw3VOaCPsK4AufUyV8FwfJjosTwCkkVcUK/BUB4gfPfB
        XVSheV8M7XlwmP1ed27oQ9kpOXxRsqn7iwlXRqIBDsxxbTQjqWxrxXQahSh60RMVgWciTH8+VGn
        TyIGBdrrkGYF/V9fMzNXb5e0yu+Cr+bV0y2pe+mOr
X-Received: by 2002:ac8:2a3a:: with SMTP id k55mr25902498qtk.294.1591089260954;
        Tue, 02 Jun 2020 02:14:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx1WsROjUW769DDxgpU4rag4njM1zCpRsTRcIP45qynEm0hFX3w+3IiwkjfSW1L8qjbkw7t1oMXMfjCmYljgak=
X-Received: by 2002:ac8:2a3a:: with SMTP id k55mr25902481qtk.294.1591089260695;
 Tue, 02 Jun 2020 02:14:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200529195951.GA3767@dtor-ws> <CANMq1KDDa8jGwo9BNneJ=8y1HunM9hiRS2c0i5ASJ6+X4qvodw@mail.gmail.com>
 <CABXOdTeTHUtWyutfQ3oO7c_g=q5GrDsdKZbSe1dwLWSeNFi-sQ@mail.gmail.com>
 <20200530010926.GM89269@dtor-ws> <CABXOdTexbFqvHNALBeXrU5djbrLaK93fBTd6_rTCOhbEadYRgg@mail.gmail.com>
 <20200530013419.GN89269@dtor-ws> <nycvar.YFH.7.76.2006011912150.13242@cbobk.fhfr.pm>
In-Reply-To: <nycvar.YFH.7.76.2006011912150.13242@cbobk.fhfr.pm>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Tue, 2 Jun 2020 11:14:09 +0200
Message-ID: <CAO-hwJLTrGs39OsxtY_r0He02Au64vg1x1_tzGjCQzyNzBCARw@mail.gmail.com>
Subject: Re: [PATCH] HID: usbhid: do not sleep when opening device
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Guenter Roeck <groeck@google.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Linux USB Mailing List <linux-usb@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 1, 2020 at 7:13 PM Jiri Kosina <jikos@kernel.org> wrote:
>
> On Fri, 29 May 2020, Dmitry Torokhov wrote:
>
> > > > > > > usbhid tries to give the device 50 milliseconds to drain its queues
> > > > > > > when opening the device, but does it naively by simply sleeping in open
> > > > > > > handler, which slows down device probing (and thus may affect overall
> > > > > > > boot time).
> > > > > > >
> > > > > > > However we do not need to sleep as we can instead mark a point of time
> > > > > > > in the future when we should start processing the events.
> > > > > > >
> > > > > > > Reported-by: Nicolas Boichat <drinkcat@chromium.org>
> > > > > > > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > > > > > > ---
> > > > > > >  drivers/hid/usbhid/hid-core.c | 27 +++++++++++++++------------
> > > > > > >  drivers/hid/usbhid/usbhid.h   |  1 +
> > > > > > >  2 files changed, 16 insertions(+), 12 deletions(-)
> > > > > > >
> > > > > > > diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
> > > > > > > index c7bc9db5b192..e69992e945b2 100644
> > > > > > > --- a/drivers/hid/usbhid/hid-core.c
> > > > > > > +++ b/drivers/hid/usbhid/hid-core.c
> > > > > > > @@ -95,6 +95,19 @@ static int hid_start_in(struct hid_device *hid)
> > > > > > >                                 set_bit(HID_NO_BANDWIDTH, &usbhid->iofl);
> > > > > > >                 } else {
> > > > > > >                         clear_bit(HID_NO_BANDWIDTH, &usbhid->iofl);
> > > > > > > +
> > > > > > > +                       if (test_and_clear_bit(HID_RESUME_RUNNING,
> > > > > > > +                                              &usbhid->iofl)) {
> > > > > > > +                               /*
> > > > > > > +                                * In case events are generated while nobody was
> > > > > > > +                                * listening, some are released when the device
> > > > > > > +                                * is re-opened. Wait 50 msec for the queue to
> > > > > > > +                                * empty before allowing events to go through
> > > > > > > +                                * hid.
> > > > > > > +                                */
> > > > > > > +                               usbhid->input_start_time = jiffies +
> > > > > > > +                                                          msecs_to_jiffies(50);
> > > > > > > +                       }
> > > > > > >                 }
> > > > > > >         }
> > > > > > >         spin_unlock_irqrestore(&usbhid->lock, flags);
> > > > > > > @@ -280,7 +293,8 @@ static void hid_irq_in(struct urb *urb)
> > > > > > >                 if (!test_bit(HID_OPENED, &usbhid->iofl))
> > > > > > >                         break;
> > > > > > >                 usbhid_mark_busy(usbhid);
> > > > > > > -               if (!test_bit(HID_RESUME_RUNNING, &usbhid->iofl)) {
> > > > > > > +               if (!test_bit(HID_RESUME_RUNNING, &usbhid->iofl) &&
> > > > > > > +                   time_after(jiffies, usbhid->input_start_time)) {
> > > > > >
> > > > > > Are we worried about jiffies overflowing (32-bit@1000Hz is "only" 49.7 days...)
> > > > > >
> > > > >
> > > > > time_after() is overflow-safe. That is why it is used and jiffies is
> > > > > not compared directly.
> > > >
> > > > Well, it is overflow safe, but still can not measure more than 50 days,
> > > > so if you have a device open for 50+ days there will be a 50msec gap
> > > > where it may lose events.
> > > >
> > >
> > > Or you could explicitly use 64-bit jiffies.
> >
> > Indeed.
> >
> > Jiri, Benjamin, do you have preference between jiffies64 and ktime_t? I
> > guess jiffies64 is a tiny bit less expensive.
>
> If I would be writing the code, I'd use ktime_t, because I personally like
> that abstraction more :) But either variant works for me.

I don't have a strong opinion on either variant. Feel free to use
whatever you like the most.

Cheers,
Benjamin

>
> Thanks!
>
> --
> Jiri Kosina
> SUSE Labs
>

