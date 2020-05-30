Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06AE6C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 00:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF0042076B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 00:48:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d/wcQy8e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728632AbgE3Asl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 20:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728449AbgE3Asj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 20:48:39 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC75CC08C5CA
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 17:48:39 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id n24so3826591ejd.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 17:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SnGa+sp06YGgurCULp59Dm5yJ72F3Q121M3j0Zokm2c=;
        b=d/wcQy8elcjGFNAUc1MXBBI2fcayOPmE9V8XLfJsTJOqDasbkiEtu7xxWmrYwcBvXi
         oGfybuS74o+QWL/KgFLhwviOMp6+xWBLNWfAQoLE10/bbsgA6S2eVuMrdXUSijKdCp83
         T5ckrCWcEaST8oZHFwjxIkK0tOW3XYgvfzdgChJOBkjjlUa58r3VNREsyNUA28TUA+hJ
         lrVOExkoWYhgTVW6l9LM0O8KizleAnyYv72I1mGIIvWQQ4Ki5ZdtieSpmhyOmfDZTIey
         2NRgQpjjf58c5lwnLwPrkLMCbLSus1pm7PW6AAH/2PW1kq+NKcaAYZnl6R2TXFusg0+U
         1chA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SnGa+sp06YGgurCULp59Dm5yJ72F3Q121M3j0Zokm2c=;
        b=Tizk6ZzFosd5nCQfbAv0JBisYVfH/nD0usD8CDZFiBTTo5Fnzdxd1NfqwzuLcJ6t/j
         SKJlemVuQgXtLfqGcQVuyjDkXhcw3sEg+SlfxrySm3ME5lDMRzQjBEzfA0r7M34AKTYZ
         EHRKMv4BoZe05VmuARhXe/pow4jXUKcLFQ1vecEsuMsQEpP+SS22Pm3ZM5jERo6Xjcn4
         cKT0+BJAbz8ZsmPCjh4bvNPX/zePEELQzpcQuc/oniK7yQSfHL3GTi47uNu+vL+GM0IT
         QY5AQhtAAoQaqkfh1a0pv2ifIrVU8cghAeMT/3GLcBLiGLmzeDaQ1gsLG9NStePnqVcP
         7wAQ==
X-Gm-Message-State: AOAM532IWMzeNfGbo2La/dF22Sn0oTK+9gB5m/SFyauWFpoQ+WgBn4fI
        JzNL2xqnzbGGlD3UxTCz3HwxEv6vt286xGdZhvv+sQ==
X-Google-Smtp-Source: ABdhPJypD7frdxZN6b2D5S9ea/dW3yRBa9cd74/PY/29S9QEb0yzpgWJOBIooKyalj7pZk/Wxf6V2xzf6BqFCE7LQ3A=
X-Received: by 2002:a17:906:dc2:: with SMTP id p2mr10002030eji.212.1590799717876;
 Fri, 29 May 2020 17:48:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200529195951.GA3767@dtor-ws> <CANMq1KDDa8jGwo9BNneJ=8y1HunM9hiRS2c0i5ASJ6+X4qvodw@mail.gmail.com>
In-Reply-To: <CANMq1KDDa8jGwo9BNneJ=8y1HunM9hiRS2c0i5ASJ6+X4qvodw@mail.gmail.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Fri, 29 May 2020 17:48:26 -0700
Message-ID: <CABXOdTeTHUtWyutfQ3oO7c_g=q5GrDsdKZbSe1dwLWSeNFi-sQ@mail.gmail.com>
Subject: Re: [PATCH] HID: usbhid: do not sleep when opening device
To:     Nicolas Boichat <drinkcat@chromium.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
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

On Fri, May 29, 2020 at 4:50 PM Nicolas Boichat <drinkcat@chromium.org> wrote:
>
> On Sat, May 30, 2020 at 3:59 AM Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> >
> > usbhid tries to give the device 50 milliseconds to drain its queues
> > when opening the device, but does it naively by simply sleeping in open
> > handler, which slows down device probing (and thus may affect overall
> > boot time).
> >
> > However we do not need to sleep as we can instead mark a point of time
> > in the future when we should start processing the events.
> >
> > Reported-by: Nicolas Boichat <drinkcat@chromium.org>
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > ---
> >  drivers/hid/usbhid/hid-core.c | 27 +++++++++++++++------------
> >  drivers/hid/usbhid/usbhid.h   |  1 +
> >  2 files changed, 16 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
> > index c7bc9db5b192..e69992e945b2 100644
> > --- a/drivers/hid/usbhid/hid-core.c
> > +++ b/drivers/hid/usbhid/hid-core.c
> > @@ -95,6 +95,19 @@ static int hid_start_in(struct hid_device *hid)
> >                                 set_bit(HID_NO_BANDWIDTH, &usbhid->iofl);
> >                 } else {
> >                         clear_bit(HID_NO_BANDWIDTH, &usbhid->iofl);
> > +
> > +                       if (test_and_clear_bit(HID_RESUME_RUNNING,
> > +                                              &usbhid->iofl)) {
> > +                               /*
> > +                                * In case events are generated while nobody was
> > +                                * listening, some are released when the device
> > +                                * is re-opened. Wait 50 msec for the queue to
> > +                                * empty before allowing events to go through
> > +                                * hid.
> > +                                */
> > +                               usbhid->input_start_time = jiffies +
> > +                                                          msecs_to_jiffies(50);
> > +                       }
> >                 }
> >         }
> >         spin_unlock_irqrestore(&usbhid->lock, flags);
> > @@ -280,7 +293,8 @@ static void hid_irq_in(struct urb *urb)
> >                 if (!test_bit(HID_OPENED, &usbhid->iofl))
> >                         break;
> >                 usbhid_mark_busy(usbhid);
> > -               if (!test_bit(HID_RESUME_RUNNING, &usbhid->iofl)) {
> > +               if (!test_bit(HID_RESUME_RUNNING, &usbhid->iofl) &&
> > +                   time_after(jiffies, usbhid->input_start_time)) {
>
> Are we worried about jiffies overflowing (32-bit@1000Hz is "only" 49.7 days...)
>

time_after() is overflow-safe. That is why it is used and jiffies is
not compared directly.

Guenter

> >                         hid_input_report(urb->context, HID_INPUT_REPORT,
> >                                          urb->transfer_buffer,
> >                                          urb->actual_length, 1);
> > @@ -714,17 +728,6 @@ static int usbhid_open(struct hid_device *hid)
> >         }
> >
> >         usb_autopm_put_interface(usbhid->intf);
> > -
> > -       /*
> > -        * In case events are generated while nobody was listening,
> > -        * some are released when the device is re-opened.
> > -        * Wait 50 msec for the queue to empty before allowing events
> > -        * to go through hid.
> > -        */
> > -       if (res == 0)
> > -               msleep(50);
> > -
> > -       clear_bit(HID_RESUME_RUNNING, &usbhid->iofl);
> >         return res;
> >  }
> >
> > diff --git a/drivers/hid/usbhid/usbhid.h b/drivers/hid/usbhid/usbhid.h
> > index 8620408bd7af..805949671b96 100644
> > --- a/drivers/hid/usbhid/usbhid.h
> > +++ b/drivers/hid/usbhid/usbhid.h
> > @@ -82,6 +82,7 @@ struct usbhid_device {
> >
> >         spinlock_t lock;                                                /* fifo spinlock */
> >         unsigned long iofl;                                             /* I/O flags (CTRL_RUNNING, OUT_RUNNING) */
> > +       unsigned long input_start_time;                                 /* When to start handling input, in jiffies */
> >         struct timer_list io_retry;                                     /* Retry timer */
> >         unsigned long stop_retry;                                       /* Time to give up, in jiffies */
> >         unsigned int retry_delay;                                       /* Delay length in ms */
> > --
> > 2.27.0.rc0.183.gde8f92d652-goog
> >
> >
> > --
> > Dmitry
