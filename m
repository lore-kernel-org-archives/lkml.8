Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ADACC35247
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 20:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF24F20674
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 20:41:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oDz9EmeV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbgBDUlG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 15:41:06 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:36930 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727444AbgBDUlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 15:41:05 -0500
Received: by mail-io1-f66.google.com with SMTP id k24so22532613ioc.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 12:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wOEFiVFO7z0I5vVtCBqbR+q7KXZ5cgDDuFWgR6+ESQI=;
        b=oDz9EmeV2dNsaRXLclripWbOSUDtCFkMSbQgv2fEEVGhr68Z1aR47cMAXFv5OG9B+H
         /LAQ3AOnKe5E4sKxl/zZb4ffxZgiU0tVGXZOeaW442tynUC/PCeUXn/0kcVLgip1S+07
         Ot12iNUtuq6cfx2vf18LaplgsGx9ziub4gOks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wOEFiVFO7z0I5vVtCBqbR+q7KXZ5cgDDuFWgR6+ESQI=;
        b=dJX1bTMj67c+8csPQJFvqFPaQhz3bowQjsauztx4nw5LuqN/L8KN6fOoUEU7MYLBfU
         Pp8ffPxUQK3cQpSQvVsIr32iw8N4YXsgcsiXmnWWHNAdhrPrcYyeqenUggsFqijzL5dm
         qtGCVbHfh22UbvjVgWzziOkijg8AtHpe3rpPyI1ED2k3/bmZ0NSOEKhUW7bXtlHzqQ9h
         rfo/kjljyXLFW1mborwHxfmO4yOvVu0A4EhZb/jryYGl5rKpG6z7UtSS5F8ghfm+0pof
         +TUrqDSEZHmKgXIHgjNuLbTrXcOoBd1GrUMQ9mCAxVGePLfmC3tGa+vkkjTGxiSHNG4g
         AG1w==
X-Gm-Message-State: APjAAAWCoBrhGoFFN5lBhn8hk2QjvbESaGPCD+2gIxi0CRe2itG5IdMx
        vfxEEooQbt2YMa+TmBGmuIMxbBLGjDB3pQsDcvd8JA==
X-Google-Smtp-Source: APXvYqyWs6qpExTQt//uPVVYWCPZ31eudUJW7D6SC26QzVPCxXKpz3W7CUi1Xoz7T61PkrX+M8wwI4okQsOWIbOn49w=
X-Received: by 2002:a6b:ec0f:: with SMTP id c15mr23939350ioh.149.1580848864881;
 Tue, 04 Feb 2020 12:41:04 -0800 (PST)
MIME-Version: 1.0
References: <CGME20200204073034eucas1p1592fa2436b5567c2d15cf2935c3a8804@eucas1p1.samsung.com>
 <20200203225356.203946-1-yichengli@chromium.org> <54cbade6-c552-4877-a8d7-d2be9930cefd@samsung.com>
In-Reply-To: <54cbade6-c552-4877-a8d7-d2be9930cefd@samsung.com>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Tue, 4 Feb 2020 12:40:51 -0800
Message-ID: <CAPUE2uvYc2MMW+QMNCqaMT897-_OSf=Ho4g42jKdKBT++6i+KA@mail.gmail.com>
Subject: Re: [PATCH v6] platform/chrome: cros_ec: Query EC protocol version if
 EC transitions between RO/RW
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Yicheng Li <yichengli@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Evan Green <evgreen@chromium.org>,
        Rushikesh S Kadam <rushikesh.s.kadam@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Gwendal Grignou <gwendal@chromium.org>

On Mon, Feb 3, 2020 at 11:30 PM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
>
> Hi
>
> On 03.02.2020 23:53, Yicheng Li wrote:
> > RO and RW of EC may have different EC protocol version. If EC transitions
> > between RO and RW, but AP does not reboot (this is true for fingerprint
> > microcontroller / cros_fp, but not true for main ec / cros_ec), the AP
> > still uses the protocol version queried before transition, which can
> > cause problems. In the case of fingerprint microcontroller, this causes
> > AP to send the wrong version of EC_CMD_GET_NEXT_EVENT to RO in the
> > interrupt handler, which in turn prevents RO to clear the interrupt
> > line to AP, in an infinite loop.
> >
> > Once an EC_HOST_EVENT_INTERFACE_READY is received, we know that there
> > might have been a transition between RO and RW, so re-query the protocol.
> >
> > Signed-off-by: Yicheng Li <yichengli@chromium.org>
>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
>
> Works fine on Samsung Exynos-based Chromebooks: Snow, Peach-Pit and
> Peach-Pi.
>
> > ---
> > Hi Enric and Marek,
> >
> >> This patch landed recently in linux-next as commit
> >> 241a69ae8ea8e2defec751fe55dac1287aa044b8. Sadly, it causes following
> >> kernel oops on any key press on Samsung Exynos-based Chromebooks (Snow,
> >> Peach-Pit and Peach-Pi):
> >
> >> Many thanks for report the issue, we will take a look ASAP and revert
> >> this commit meanwhile.
> >
> >> Simply removing the BUG_ON() from cros_ec_get_host_event() function
> >> fixes the issue, but I don't know the protocol details to judge if this
> >> is the correct way of fixing it.
> > The issue was those Samsung Chromebooks (Snow, Peach-Pit and Peach-Pi)
> > do not support mkbp events, yet we applied the same thing to them, which
> > we shouldn't. This v6 should fix it: I Just added a check
> >
> >       if (ec_dev->mkbp_event_supported)
> >
> > in cros_ec_register().
> >
> >
> >
> > drivers/platform/chrome/cros_ec.c           | 29 +++++++++++++++++++++
> >   include/linux/platform_data/cros_ec_proto.h |  3 +++
> >   2 files changed, 32 insertions(+)
> >
> > diff --git a/drivers/platform/chrome/cros_ec.c b/drivers/platform/chrome/cros_ec.c
> > index 9b2d07422e17..f16804db805b 100644
> > --- a/drivers/platform/chrome/cros_ec.c
> > +++ b/drivers/platform/chrome/cros_ec.c
> > @@ -104,6 +104,23 @@ static int cros_ec_sleep_event(struct cros_ec_device *ec_dev, u8 sleep_event)
> >       return ret;
> >   }
> >
> > +static int cros_ec_ready_event(struct notifier_block *nb,
> > +     unsigned long queued_during_suspend, void *_notify)
> > +{
> > +     struct cros_ec_device *ec_dev = container_of(nb, struct cros_ec_device,
> > +                                                  notifier_ready);
> > +     u32 host_event = cros_ec_get_host_event(ec_dev);
> > +
> > +     if (host_event & EC_HOST_EVENT_MASK(EC_HOST_EVENT_INTERFACE_READY)) {
> > +             mutex_lock(&ec_dev->lock);
> > +             cros_ec_query_all(ec_dev);
> > +             mutex_unlock(&ec_dev->lock);
> > +             return NOTIFY_OK;
> > +     }
> > +
> > +     return NOTIFY_DONE;
> > +}
> > +
> >   /**
> >    * cros_ec_register() - Register a new ChromeOS EC, using the provided info.
> >    * @ec_dev: Device to register.
> > @@ -201,6 +218,18 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
> >               dev_dbg(ec_dev->dev, "Error %d clearing sleep event to ec",
> >                       err);
> >
> > +     if (ec_dev->mkbp_event_supported) {
> > +             /*
> > +              * Register the notifier for EC_HOST_EVENT_INTERFACE_READY
> > +              * event.
> > +              */
> > +             ec_dev->notifier_ready.notifier_call = cros_ec_ready_event;
> > +             err = blocking_notifier_chain_register(
> > +                     &ec_dev->event_notifier, &ec_dev->notifier_ready);
> > +             if (err)
> > +                     return err;
> > +     }
> > +
> >       dev_info(dev, "Chrome EC device registered\n");
> >
> >       return 0;
> > diff --git a/include/linux/platform_data/cros_ec_proto.h b/include/linux/platform_data/cros_ec_proto.h
> > index 0d4e4aaed37a..a1c545c464e7 100644
> > --- a/include/linux/platform_data/cros_ec_proto.h
> > +++ b/include/linux/platform_data/cros_ec_proto.h
> > @@ -121,6 +121,8 @@ struct cros_ec_command {
> >    * @event_data: Raw payload transferred with the MKBP event.
> >    * @event_size: Size in bytes of the event data.
> >    * @host_event_wake_mask: Mask of host events that cause wake from suspend.
> > + * @notifier_ready: The notifier_block to let the kernel re-query EC
> > + *      communication protocol when the EC sends EC_HOST_EVENT_INTERFACE_READY.
> >    * @ec: The platform_device used by the mfd driver to interface with the
> >    *      main EC.
> >    * @pd: The platform_device used by the mfd driver to interface with the
> > @@ -161,6 +163,7 @@ struct cros_ec_device {
> >       int event_size;
> >       u32 host_event_wake_mask;
> >       u32 last_resume_result;
> > +     struct notifier_block notifier_ready;
> >
> >       /* The platform devices used by the mfd driver */
> >       struct platform_device *ec;
>
> Best regards
> --
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
>
