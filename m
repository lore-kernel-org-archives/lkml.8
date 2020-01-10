Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83461C282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 14:36:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56D8C2082E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 14:36:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="oMKyFTUn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728201AbgAJOf7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 09:35:59 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39194 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727581AbgAJOf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 09:35:58 -0500
Received: by mail-wr1-f67.google.com with SMTP id y11so2026771wrt.6
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 06:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fR6lP1zgvDKu/Vk7f95tLyKjHNECmLy4ZODwU6XXvRk=;
        b=oMKyFTUnPn8RNJpLhn1q02KOjxZJlZZ9VPykA25mq7Qu2JP+ihwHk0gSWGLtpxMDz2
         /AQfwwbC0TD/nXTTKi57chkFmPcoxO7vB8UkXx8YLSu1qkSDKVXKAIQHE4L4mtNkUK6B
         EEQjSgImvLDw8OhHqbgHe4K+SgwLMVLzgxRjolX/wSuQyynOf587dS5kGTkkrmHUIHlM
         /B/MDdLk0zENjZMUh1aBEDzP1Bbb2VgndUwbPqka0QYTdhNNZNEaKohUSiUYK8Bwh1uh
         hZTG7FonKTzkOi85mDmfoak7tBoRe7uxQ/W+MYnSKt+ABcPjCvy048Uy1gZbt/SUVS7z
         OCZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fR6lP1zgvDKu/Vk7f95tLyKjHNECmLy4ZODwU6XXvRk=;
        b=XmSzAGdB/s9T/wyOxrsgnTjZJhr0PoUD9AKNRRz4BuvjAgmwQqDEI2YIexb80Ibbgm
         Wr+RqDOI9+VVvTkSFzcPL1sArclEotekKjxIqunCZado8PDFYfOl8ymINcfBSMcqbl7x
         DrWANHKEcumBL2Mp26YXoqlceWg5vnnOtiqYcjz/Na6Ns7YRiFQuykYdlSqxRlTvkxtN
         HP24hJ8Ngva12rom4i2YcwRIdio8Oqr5EFQpDzoXVALwnHT3nhqEQ4xXO+R5mXs3B4ee
         vjxQEfVvf0aJFJ38HkyUzqtumaL7URckg62I5tBsen6olT6meCpB9KadSKfsFh4KVa+e
         vn3w==
X-Gm-Message-State: APjAAAUQtJ6KX0I5qO6tstOyluDwgGPeIUa6cYrrzbZjcOSy8fStIipN
        H6KvKBDRYjSUVVkui9FiDw4L2JUT3wdUmMcXMCYi3LFJKLSAtg==
X-Google-Smtp-Source: APXvYqxEFT4t6ci312y+/g7e9vAaR90TUgHTNowFXe9gfh6DUIG6dMP98qv1vvSieZtNtI/KYxW53dyyPKyUy7ah+Nk=
X-Received: by 2002:adf:fc4b:: with SMTP id e11mr3904527wrs.326.1578666956616;
 Fri, 10 Jan 2020 06:35:56 -0800 (PST)
MIME-Version: 1.0
References: <20191206085432.19962-1-michael.kupfer@fau.de> <3db2350b-0a6d-0693-258c-9d47f71c0627@xs4all.nl>
In-Reply-To: <3db2350b-0a6d-0693-258c-9d47f71c0627@xs4all.nl>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Fri, 10 Jan 2020 14:35:38 +0000
Message-ID: <CAPY8ntALS7Em42457fsHmUuQLD5vokKLc0RHn3a-T7amgS1Kvg@mail.gmail.com>
Subject: Re: [PATCH] staging/vc04_services/bcm2835-camera: distinct numeration
 and names for devices
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Michael Kupfer <michael.kupfer@fau.de>, eric@anholt.net,
        wahrenst@gmx.net, bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, mchehab+samsung@kernel.org,
        linux-media@vger.kernel.org, gregkh@linuxfoundation.org,
        f.fainelli@gmail.com, rjui@broadcom.com, sbranden@broadcom.com,
        Dave Stevenson <dave.stevenson@raspberrypi.org>,
        daniela.mormocea@gmail.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, linux-kernel@i4.cs.fau.de,
        Kay Friedrich <kay.friedrich@fau.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans

On Fri, 10 Jan 2020 at 13:25, Hans Verkuil <hverkuil-cisco@xs4all.nl> wrote:
>
> Hi Michael, Kay,
>
> On 12/6/19 9:54 AM, Michael Kupfer wrote:
> > Create a static atomic counter for numerating cameras.
> > Use the Media Subsystem Kernel Internal API to create distinct
> > device-names, so that the camera-number (given by the counter)
> > matches the camera-name.
> >
> > Co-developed-by: Kay Friedrich <kay.friedrich@fau.de>
> > Signed-off-by: Kay Friedrich <kay.friedrich@fau.de>
> > Signed-off-by: Michael Kupfer <michael.kupfer@fau.de>
> > ---
> >  .../vc04_services/bcm2835-camera/bcm2835-camera.c        | 9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
> > index beb6a0063bb8..be5f90a8b49d 100644
> > --- a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
> > +++ b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
> > @@ -60,6 +60,9 @@ MODULE_PARM_DESC(max_video_width, "Threshold for video mode");
> >  module_param(max_video_height, int, 0644);
> >  MODULE_PARM_DESC(max_video_height, "Threshold for video mode");
> >
> > +/* camera instance counter */
> > +static atomic_t camera_instance = ATOMIC_INIT(0);
> > +
> >  /* global device data array */
> >  static struct bm2835_mmal_dev *gdev[MAX_BCM2835_CAMERAS];
> >
> > @@ -1870,7 +1873,6 @@ static int bcm2835_mmal_probe(struct platform_device *pdev)
> >
> >               /* v4l2 core mutex used to protect all fops and v4l2 ioctls. */
> >               mutex_init(&dev->mutex);
> > -             dev->camera_num = camera;
> >               dev->max_width = resolutions[camera][0];
> >               dev->max_height = resolutions[camera][1];
> >
> > @@ -1886,8 +1888,9 @@ static int bcm2835_mmal_probe(struct platform_device *pdev)
> >               dev->capture.fmt = &formats[3]; /* JPEG */
> >
> >               /* v4l device registration */
> > -             snprintf(dev->v4l2_dev.name, sizeof(dev->v4l2_dev.name),
> > -                      "%s", BM2835_MMAL_MODULE_NAME);
> > +             dev->camera_num = v4l2_device_set_name(&dev->v4l2_dev,
> > +                                                    BM2835_MMAL_MODULE_NAME,
> > +                                                    &camera_instance);
> >               ret = v4l2_device_register(NULL, &dev->v4l2_dev);
> >               if (ret) {
> >                       dev_err(&pdev->dev, "%s: could not register V4L2 device: %d\n",
> >
>
> Actually, in this specific case I would not use v4l2_device_set_name().
>
> Instead just use:
>
>                 snprintf(dev->v4l2_dev.name, sizeof(dev->v4l2_dev.name),
>                          "%s-%u", BM2835_MMAL_MODULE_NAME, camera);
>
> It would be even better if there would be just one top-level v4l2_device used
> for all the camera instances. After all, there really is just one platform
> device for all of the cameras, and I would expect to see just a single
> v4l2_device as well.
>
> It doesn't hurt to have multiple v4l2_device structs, but it introduces a
> slight memory overhead since one would have been sufficient.

Doesn't that make all controls for all cameras common? The struct
v4l2_ctrl_handler is part of struct v4l2_device.

Or do we:
- ditch the use of ctrl_handler in struct v4l2_device
- create and initialise a ctrl_handler per camera on an internal
structure so we retain the control state
- assign ctrl_handler in struct v4l2_fh to it every time a file handle
on the device is opened?

And if we only have one struct v4l2_device then is there the
possibility of the unique names that Michael and Kay are trying to
introduce?

I'm a little confused as to whether there really is a gain in having a
single v4l2_device. In this case the two cameras are independent
devices, even if they are loaded by a single platform driver.

  Dave

> v4l2_device_set_name() is meant for pci-like devices. And it really
> is a bit overkill to have it as a helper function.
>
> Regards,
>
>         Hans
