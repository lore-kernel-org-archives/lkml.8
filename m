Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 813CACA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 08:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DDAF20740
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 08:35:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LGlk4Sox"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732308AbgEMIfg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 04:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbgEMIfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 04:35:36 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBDA6C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 01:35:34 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id d26so1526436otc.7
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 01:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KA7iaRwKyQU/DbW+v3q/rxbvNUjeMSpAhHPzsxnLI+Q=;
        b=LGlk4SoxCLCmjsHIETakzjhKgymWpgXG0APfAIM+adiGsaVmA2JqFrwoNdNDJ9IsUm
         vB4oxu6Pzqj2RBazLWSbX9T/Xeli8hHlxESL8IMz2Jzlm9Q6HYiDrwzdFQBGBgJFBTZi
         j+xed0+XZWTAlHhcRB/ANdUQ/1l7tTGF1a3ME/vE5JFnzi0HUZUxzVap/yWJLrAwHwJY
         Zcbf+I3vF/ZRjgULoK7RjRdPAj8K4kZVD+bW25oSU/q9nWGDxvDhiGqQq8nLBLlUxhTB
         InaOO05XJdWTRbkgCglneldx8GLO7kiHwF4MZ+1bBWcDGZ6Sub8fZSe9U1WACqd52Q/e
         jDfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KA7iaRwKyQU/DbW+v3q/rxbvNUjeMSpAhHPzsxnLI+Q=;
        b=IW7x4NhCwroMFeOOg3VROyGgvQahwbeBXt+T8AP4U/U5u3KQ/9xSyrJZqSZu1yHh+I
         uEuUUxESszpcu/6hishKz083GPorZQVPQ3wmNtjxIjA0uUPprAdt1Ryv4qqGzx9tBrJa
         YKGEoQ+bjcZyNi31M7xwzOTPA4fPksigxZ1cFOb4Ufb086mzcFanKmijOpj7bOny0ydI
         zcITAfh3uR+tB6WqfaVpXlvktpSMGXagPxI21Agyqaw5zXdGd+DwIsMtOL2H451DWj+k
         A3aQSd3pb43lyYpaeQmEiMJ98mlGnTnJFYRSnnNGYG0r/F9kUZtUO6TEvCXFCX3htC/t
         8QYQ==
X-Gm-Message-State: AGi0Pub9Cl4e78MC2n76/gdR/zCVDN/Mxn0ws/wNBYDwhkVjQ/PrKvHI
        TUzaPvCXqXVyD46Ea0VDLBJV+lLcP2lP3u2uh86PJA==
X-Google-Smtp-Source: APiQypKG1jpeHPtIYqXqqPvvUODnp63p3EfI9HPjXEK2KnG8KGDQSeKVof0Ng6JuVkmQaNFUyFiIGFFVd5ezUZq5Ldo=
X-Received: by 2002:a05:6830:1e45:: with SMTP id e5mr19594675otj.236.1589358933497;
 Wed, 13 May 2020 01:35:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200513013415.148858-1-saravanak@google.com> <20200513082209.GB770255@kroah.com>
In-Reply-To: <20200513082209.GB770255@kroah.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 13 May 2020 01:34:57 -0700
Message-ID: <CAGETcx9TJxOre+vmdeeioAt5toyo1qYz=fq2S3aZSiroH1TsAQ@mail.gmail.com>
Subject: Re: [PATCH v1] driver core: Add state_synced sysfs file for devices
 that support it
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 1:22 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, May 12, 2020 at 06:34:15PM -0700, Saravana Kannan wrote:
> > This can be used to check if a device supports sync_state() callbacks
> > and therefore keeps resources left on by the bootloader enabled till all
> > its consumers have probed.
> >
> > This can also be used to check if sync_state() has been called for a
> > device or whether it is still trying to keep resources enabled because
> > they were left enabled by the bootloader and all its consumers haven't
> > probed yet.
> >
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > ---
> >  .../ABI/testing/sysfs-devices-state_synced    | 24 +++++++++++++++++++
> >  drivers/base/dd.c                             | 16 +++++++++++++
> >  2 files changed, 40 insertions(+)
> >  create mode 100644 Documentation/ABI/testing/sysfs-devices-state_synced
> >
> > diff --git a/Documentation/ABI/testing/sysfs-devices-state_synced b/Documentation/ABI/testing/sysfs-devices-state_synced
> > new file mode 100644
> > index 000000000000..0c922d7d02fc
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-devices-state_synced
> > @@ -0,0 +1,24 @@
> > +What:                /sys/devices/.../state_synced
> > +Date:                May 2020
> > +Contact:     Saravana Kannan <saravanak@google.com>
> > +Description:
> > +             The /sys/devices/.../state_synced attribute is only present for
> > +             devices whose bus types or driver provides the .sync_state()
> > +             callback. The number read from it (0 or 1) reflects the value
> > +             of the device's 'state_synced' field. A value of 0 means the
> > +             .sync_state() callback hasn't been called yet. A value of 1
> > +             means the .sync_state() callback has been called.
> > +
> > +             Generally, if a device has sync_state() support and has some of
> > +             the resources it provides enabled at the time the kernel starts
> > +             (Eg: enabled by hardware reset or bootloader or anything that
> > +             run before the kernel starts), then it'll keep those resources
> > +             enabled and in a state that's compatible with the state they
> > +             were in at the start of the kernel. The device will stop doing
> > +             this only when the sync_state() callback has been called --
> > +             which happens only when all its consumer devices are registered
> > +             and have probed successfully. Resources that were left disabled
> > +             at the time the kernel starts are not affected or limited in
> > +             any way by sync_state() callbacks.
> > +
> > +
> > diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> > index 48ca81cb8ebc..72599436ae84 100644
> > --- a/drivers/base/dd.c
> > +++ b/drivers/base/dd.c
> > @@ -458,6 +458,13 @@ static void driver_deferred_probe_add_trigger(struct device *dev,
> >               driver_deferred_probe_trigger();
> >  }
> >
> > +static ssize_t state_synced_show(struct device *dev,
> > +                              struct device_attribute *attr, char *buf)
> > +{
> > +     return sprintf(buf, "%u\n", dev->state_synced);
> > +}
> > +static DEVICE_ATTR_RO(state_synced);
> > +
> >  static int really_probe(struct device *dev, struct device_driver *drv)
> >  {
> >       int ret = -EPROBE_DEFER;
> > @@ -531,9 +538,16 @@ static int really_probe(struct device *dev, struct device_driver *drv)
> >               goto dev_groups_failed;
> >       }
> >
> > +     if (dev_has_sync_state(dev) &&
> > +         device_create_file(dev, &dev_attr_state_synced)) {
> > +             dev_err(dev, "state_synced sysfs add failed\n");
> > +             goto dev_sysfs_state_synced_failed;
> > +     }
>
> Why not add this to the groups above this and only enable it if needed
> at runtime?

Those groups above seem to be driver specific groups. Looking at the
code, some drivers seem to be setting them. Also, this attribute can
only be decided after a driver has successfully bound to the device
because dev_has_sync_state() has to check the bus and the driver for
sync_state() support.

> The is_visible() callback should be what you need to use here.

If this is an attribute specific property, it might work. I'll take a look.

>  That
> will save you lots of housekeeping as well as properly remove the
> attribute when the device is removed from the system (which you didn't
> explicitly do in this patch...)

I had a nagging feeling I was missing something. Duh! I'll make sure I
do proper clean up in v2.

Thanks for the review.

-Saravana
