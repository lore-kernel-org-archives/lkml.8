Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF1AC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 18:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61C8C20794
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 18:50:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mALEYYK8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390280AbgEMSue (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 14:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732990AbgEMSue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 14:50:34 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 355C9C061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 11:50:34 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id r25so22358464oij.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 11:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gF7ry1mbM7fH2mfZhBrN61I9RHF3g4e2U2mjzd7WWlA=;
        b=mALEYYK8D61rp5d/79HI5C1oDy43P5TyDU/PAK87eW4hEBy7jtaOQnK+MsH7jrethN
         OTqsRTznNo1DvpJP6StHtuW73GUgjWTnhbMksMvtVXWi2MXvLs34vxrY3A6TniEzk24J
         47xWY+ge0hNTywcWmHgJB70gqqZXcpbFEYgKzKE1TFlRRKTzmgIak3U9w2VXAXfBF5/6
         bMBChginNrtBowCRLfGLiOt86OGFlcAPOSVUcGbmJGhxra+JJNePPXTpjOoHt21bfKiu
         turObOFLi0sssPNoDQntfjBnPm+KtY7QflI50GQLVNYuViTyRE6EnguswdybH1RqWUtu
         wp9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gF7ry1mbM7fH2mfZhBrN61I9RHF3g4e2U2mjzd7WWlA=;
        b=ubBb/GlzUaETQrnelDcaOu8GxET+gfz4OKCJ3pZ1UkMvnjhGkl5X8p/+yTim+4Yejr
         IwzBihnH1Z7cCpxP7AIZM0B0/m6h2IW2VOay7eKG+gZXVPAmctjSgFNKalIQ9JDrc8hg
         aGJw/jl3M+Y8iI0vo7CJGui36dX00zFekmSPKjlSjQR7IYvUGJfwBGafOkHnIfWI+H07
         ghE3bwR+SNmktx+PbJQFevAD3mGWAVOqidqrqQ0hXcBONZ5j7adJ5cQsuZOGkQpLc9Un
         CDbm7c9i3a4QKRpQkiL7gkpIhIGwBTfp+qkNPJPH9nyk+XYFmrszyYgYBur0XOhZmfZm
         MhtQ==
X-Gm-Message-State: AGi0PuaFpg3DAVgarn9zcMJFHLvHWPoyfG6wJw6ErYSDY/rsnwSiRQjQ
        p1gudVgls7f1DAzCv4i2ShQFX7BPmsy9ziySgBBcYQ==
X-Google-Smtp-Source: APiQypIEKJFeF+lgnkz8Tq993Iilrj94Ej+GwieEWvE7aDT8mqqgcpkiC+GNGixkDgX8+HWp8iNGDrRnx4Auj2EyKBI=
X-Received: by 2002:aca:3254:: with SMTP id y81mr8101691oiy.172.1589395833327;
 Wed, 13 May 2020 11:50:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200513013415.148858-1-saravanak@google.com> <20200513082209.GB770255@kroah.com>
 <CAGETcx9TJxOre+vmdeeioAt5toyo1qYz=fq2S3aZSiroH1TsAQ@mail.gmail.com>
In-Reply-To: <CAGETcx9TJxOre+vmdeeioAt5toyo1qYz=fq2S3aZSiroH1TsAQ@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 13 May 2020 11:49:57 -0700
Message-ID: <CAGETcx8pATaNMrwHQtF2_Yds1D6JOLTDgyD7Tda6cku+dz3wJw@mail.gmail.com>
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

On Wed, May 13, 2020 at 1:34 AM Saravana Kannan <saravanak@google.com> wrote:
>
> On Wed, May 13, 2020 at 1:22 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Tue, May 12, 2020 at 06:34:15PM -0700, Saravana Kannan wrote:
> > > This can be used to check if a device supports sync_state() callbacks
> > > and therefore keeps resources left on by the bootloader enabled till all
> > > its consumers have probed.
> > >
> > > This can also be used to check if sync_state() has been called for a
> > > device or whether it is still trying to keep resources enabled because
> > > they were left enabled by the bootloader and all its consumers haven't
> > > probed yet.
> > >
> > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > > ---
> > >  .../ABI/testing/sysfs-devices-state_synced    | 24 +++++++++++++++++++
> > >  drivers/base/dd.c                             | 16 +++++++++++++
> > >  2 files changed, 40 insertions(+)
> > >  create mode 100644 Documentation/ABI/testing/sysfs-devices-state_synced
> > >
> > > diff --git a/Documentation/ABI/testing/sysfs-devices-state_synced b/Documentation/ABI/testing/sysfs-devices-state_synced
> > > new file mode 100644
> > > index 000000000000..0c922d7d02fc
> > > --- /dev/null
> > > +++ b/Documentation/ABI/testing/sysfs-devices-state_synced
> > > @@ -0,0 +1,24 @@
> > > +What:                /sys/devices/.../state_synced
> > > +Date:                May 2020
> > > +Contact:     Saravana Kannan <saravanak@google.com>
> > > +Description:
> > > +             The /sys/devices/.../state_synced attribute is only present for
> > > +             devices whose bus types or driver provides the .sync_state()
> > > +             callback. The number read from it (0 or 1) reflects the value
> > > +             of the device's 'state_synced' field. A value of 0 means the
> > > +             .sync_state() callback hasn't been called yet. A value of 1
> > > +             means the .sync_state() callback has been called.
> > > +
> > > +             Generally, if a device has sync_state() support and has some of
> > > +             the resources it provides enabled at the time the kernel starts
> > > +             (Eg: enabled by hardware reset or bootloader or anything that
> > > +             run before the kernel starts), then it'll keep those resources
> > > +             enabled and in a state that's compatible with the state they
> > > +             were in at the start of the kernel. The device will stop doing
> > > +             this only when the sync_state() callback has been called --
> > > +             which happens only when all its consumer devices are registered
> > > +             and have probed successfully. Resources that were left disabled
> > > +             at the time the kernel starts are not affected or limited in
> > > +             any way by sync_state() callbacks.
> > > +
> > > +
> > > diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> > > index 48ca81cb8ebc..72599436ae84 100644
> > > --- a/drivers/base/dd.c
> > > +++ b/drivers/base/dd.c
> > > @@ -458,6 +458,13 @@ static void driver_deferred_probe_add_trigger(struct device *dev,
> > >               driver_deferred_probe_trigger();
> > >  }
> > >
> > > +static ssize_t state_synced_show(struct device *dev,
> > > +                              struct device_attribute *attr, char *buf)
> > > +{
> > > +     return sprintf(buf, "%u\n", dev->state_synced);
> > > +}
> > > +static DEVICE_ATTR_RO(state_synced);
> > > +
> > >  static int really_probe(struct device *dev, struct device_driver *drv)
> > >  {
> > >       int ret = -EPROBE_DEFER;
> > > @@ -531,9 +538,16 @@ static int really_probe(struct device *dev, struct device_driver *drv)
> > >               goto dev_groups_failed;
> > >       }
> > >
> > > +     if (dev_has_sync_state(dev) &&
> > > +         device_create_file(dev, &dev_attr_state_synced)) {
> > > +             dev_err(dev, "state_synced sysfs add failed\n");
> > > +             goto dev_sysfs_state_synced_failed;
> > > +     }
> >
> > Why not add this to the groups above this and only enable it if needed
> > at runtime?
>
> Those groups above seem to be driver specific groups. Looking at the
> code, some drivers seem to be setting them. Also, this attribute can
> only be decided after a driver has successfully bound to the device
> because dev_has_sync_state() has to check the bus and the driver for
> sync_state() support.
>
> > The is_visible() callback should be what you need to use here.
>
> If this is an attribute specific property, it might work. I'll take a look.

I took a look at is_visible(). It only makes sense for a group of
attributes that are exposed in a sub directory. But state_synced is a
top level property IMO. What I'm doing is similar to the "online"
attribute that's exposed for a device.

And even if I create a group with one lone attribute, I'll still have
to add it after the device has probed or have to call
sysfs_update_groups() after the device is probed to update the
visibility. Seems quite messy and unnecessarily complicated.

I'd like to keep this an attribute and not create a group for that
reason. Does that sound okay to you? I'll obviously still do the clean
up correctly.

-Saravana
