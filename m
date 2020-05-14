Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28B03C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 06:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00B7C206D8
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 06:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589436836;
	bh=bhNOJnYDfB8gOvaKKGeOvSoCEvPi1a1FTJvAij5KE+A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FqwSYo6PbN5SdOZ9QXzt1TPTSm88jXaZU+PA3XDQ37tc8He+WRkh2RgsQ0hpfVNHX
	 3ziSjwk+f7a3RSvf+1WIPkdWb4BB0Q015CI4qYgp282MrBuoq2gLSOuH3DGbMDpcMH
	 4XVoMEiIEdCxr6VmpZ2wyvmrumQbn39TjV9zKNgc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725952AbgENGNz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 02:13:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:43376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725794AbgENGNy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 02:13:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C184206D4;
        Thu, 14 May 2020 06:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589436834;
        bh=bhNOJnYDfB8gOvaKKGeOvSoCEvPi1a1FTJvAij5KE+A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h9QCj7kC4KQdvPhcxy3ChcGQPglBeen/Fit9MrSK368fmbHn+87CbrQJ4pbhT7SZY
         eW01BmaPLAG48LIlTBjkKvPsBxmF2TpEaTM4VzQoDzhSEzUbvX2tLHcFlscsmRpjKd
         X+1OxGRRgLo6yruzXP1QewxOTKyLmDtuUwsUG1Fo=
Date:   Thu, 14 May 2020 08:13:51 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] driver core: Add state_synced sysfs file for devices
 that support it
Message-ID: <20200514061351.GB1457703@kroah.com>
References: <20200513013415.148858-1-saravanak@google.com>
 <20200513082209.GB770255@kroah.com>
 <CAGETcx9TJxOre+vmdeeioAt5toyo1qYz=fq2S3aZSiroH1TsAQ@mail.gmail.com>
 <CAGETcx8pATaNMrwHQtF2_Yds1D6JOLTDgyD7Tda6cku+dz3wJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGETcx8pATaNMrwHQtF2_Yds1D6JOLTDgyD7Tda6cku+dz3wJw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 11:49:57AM -0700, Saravana Kannan wrote:
> On Wed, May 13, 2020 at 1:34 AM Saravana Kannan <saravanak@google.com> wrote:
> >
> > On Wed, May 13, 2020 at 1:22 AM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Tue, May 12, 2020 at 06:34:15PM -0700, Saravana Kannan wrote:
> > > > This can be used to check if a device supports sync_state() callbacks
> > > > and therefore keeps resources left on by the bootloader enabled till all
> > > > its consumers have probed.
> > > >
> > > > This can also be used to check if sync_state() has been called for a
> > > > device or whether it is still trying to keep resources enabled because
> > > > they were left enabled by the bootloader and all its consumers haven't
> > > > probed yet.
> > > >
> > > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > > > ---
> > > >  .../ABI/testing/sysfs-devices-state_synced    | 24 +++++++++++++++++++
> > > >  drivers/base/dd.c                             | 16 +++++++++++++
> > > >  2 files changed, 40 insertions(+)
> > > >  create mode 100644 Documentation/ABI/testing/sysfs-devices-state_synced
> > > >
> > > > diff --git a/Documentation/ABI/testing/sysfs-devices-state_synced b/Documentation/ABI/testing/sysfs-devices-state_synced
> > > > new file mode 100644
> > > > index 000000000000..0c922d7d02fc
> > > > --- /dev/null
> > > > +++ b/Documentation/ABI/testing/sysfs-devices-state_synced
> > > > @@ -0,0 +1,24 @@
> > > > +What:                /sys/devices/.../state_synced
> > > > +Date:                May 2020
> > > > +Contact:     Saravana Kannan <saravanak@google.com>
> > > > +Description:
> > > > +             The /sys/devices/.../state_synced attribute is only present for
> > > > +             devices whose bus types or driver provides the .sync_state()
> > > > +             callback. The number read from it (0 or 1) reflects the value
> > > > +             of the device's 'state_synced' field. A value of 0 means the
> > > > +             .sync_state() callback hasn't been called yet. A value of 1
> > > > +             means the .sync_state() callback has been called.
> > > > +
> > > > +             Generally, if a device has sync_state() support and has some of
> > > > +             the resources it provides enabled at the time the kernel starts
> > > > +             (Eg: enabled by hardware reset or bootloader or anything that
> > > > +             run before the kernel starts), then it'll keep those resources
> > > > +             enabled and in a state that's compatible with the state they
> > > > +             were in at the start of the kernel. The device will stop doing
> > > > +             this only when the sync_state() callback has been called --
> > > > +             which happens only when all its consumer devices are registered
> > > > +             and have probed successfully. Resources that were left disabled
> > > > +             at the time the kernel starts are not affected or limited in
> > > > +             any way by sync_state() callbacks.
> > > > +
> > > > +
> > > > diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> > > > index 48ca81cb8ebc..72599436ae84 100644
> > > > --- a/drivers/base/dd.c
> > > > +++ b/drivers/base/dd.c
> > > > @@ -458,6 +458,13 @@ static void driver_deferred_probe_add_trigger(struct device *dev,
> > > >               driver_deferred_probe_trigger();
> > > >  }
> > > >
> > > > +static ssize_t state_synced_show(struct device *dev,
> > > > +                              struct device_attribute *attr, char *buf)
> > > > +{
> > > > +     return sprintf(buf, "%u\n", dev->state_synced);
> > > > +}
> > > > +static DEVICE_ATTR_RO(state_synced);
> > > > +
> > > >  static int really_probe(struct device *dev, struct device_driver *drv)
> > > >  {
> > > >       int ret = -EPROBE_DEFER;
> > > > @@ -531,9 +538,16 @@ static int really_probe(struct device *dev, struct device_driver *drv)
> > > >               goto dev_groups_failed;
> > > >       }
> > > >
> > > > +     if (dev_has_sync_state(dev) &&
> > > > +         device_create_file(dev, &dev_attr_state_synced)) {
> > > > +             dev_err(dev, "state_synced sysfs add failed\n");
> > > > +             goto dev_sysfs_state_synced_failed;
> > > > +     }
> > >
> > > Why not add this to the groups above this and only enable it if needed
> > > at runtime?
> >
> > Those groups above seem to be driver specific groups. Looking at the
> > code, some drivers seem to be setting them. Also, this attribute can
> > only be decided after a driver has successfully bound to the device
> > because dev_has_sync_state() has to check the bus and the driver for
> > sync_state() support.
> >
> > > The is_visible() callback should be what you need to use here.
> >
> > If this is an attribute specific property, it might work. I'll take a look.
> 
> I took a look at is_visible(). It only makes sense for a group of
> attributes that are exposed in a sub directory. But state_synced is a
> top level property IMO. What I'm doing is similar to the "online"
> attribute that's exposed for a device.

No, no need for a subdirectory for an attribute group.  If you don't
have a name for the group, the files will be placed in the device's
directory.

> And even if I create a group with one lone attribute, I'll still have
> to add it after the device has probed or have to call
> sysfs_update_groups() after the device is probed to update the
> visibility. Seems quite messy and unnecessarily complicated.

Ah, ok, that is messier.

> I'd like to keep this an attribute and not create a group for that
> reason. Does that sound okay to you? I'll obviously still do the clean
> up correctly.

Ok, that's fine, we can change it later if we figure it out.

thanks,

greg k-h
