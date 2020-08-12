Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BADCEC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 14:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99FFB207DA
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 14:10:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="MYObIKtE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbgHLOKY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 10:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726468AbgHLOKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 10:10:20 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3948C061383
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 07:10:19 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id u24so782394oic.7
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 07:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fQpYDgkPY9yLnBp0UJp8jvJUvHu94wXm2Rvd4KAL1+8=;
        b=MYObIKtEhualdDLE4KCuFf0k1rLOTRrmO/XY5GYjlct7s5zBj12CSi+TCHJKcq43Em
         iA2ub8UeRKVY23cHauGk+Fq1eqbGYFEELgT0rbSVhgvH4eSGBNDiY7z5P3QzrhhhpH1a
         f4Z0XIXeu2yLjoFhKHpwiKFUkNopB75wb/ZHA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fQpYDgkPY9yLnBp0UJp8jvJUvHu94wXm2Rvd4KAL1+8=;
        b=N7saLJRMvedKeSkHYm15ySpINDA5LlKo3BYXqdF5iROvUYV5owXnW2MyNzpJOrCEgv
         nRav+7rSH8nnJYJjKIAJqF8SiniU6uIQ405vN6snNh3U0SKEWRPmkgo9f8yJrL4Kc62n
         VlcEVXj6aja667JDPtZxTIwCOJmtgu9H502PX4lZIhQPJV3iOn36MMH/TydI7TgAI5dg
         2RbquGJLGaCEtWY+3T1kO8yAT7KeqtSwEcIjjLeJFJWWtUbwyFv8HIPTVBD0hFNy7Fe/
         0bLdFE/yju/Yviz18cDqBx2v4HkLoqogXFBi6gwXV6wCL8+YqybiBNQoWqhTuzBTqJ/Q
         5w5w==
X-Gm-Message-State: AOAM533pQl3+a67lNk1c/JOtnXKiOqIOdWTiHWgYKPnTso0HHO4w8spI
        Qq+sPrDSri44ZxiIxUo13PR6vDIDGStdJvN2ATH6/w==
X-Google-Smtp-Source: ABdhPJynZpsDvSna0C6RcraPgGewhfAurY7C4qKG2dom85yF0RCs4jaNttjcC9KqInWQ5ZVcRPwP5rJXJxhnPIlnF88=
X-Received: by 2002:aca:88a:: with SMTP id 132mr6823888oii.101.1597241419407;
 Wed, 12 Aug 2020 07:10:19 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.21.2008101004110.27032@montezuma.home>
 <20200811085830.GZ2352366@phenom.ffwll.local> <alpine.DEB.2.21.2008111514210.35094@montezuma.home>
In-Reply-To: <alpine.DEB.2.21.2008111514210.35094@montezuma.home>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Wed, 12 Aug 2020 16:10:08 +0200
Message-ID: <CAKMK7uHxikojLQNbsnnfDfGZ3tFP9CRUTzvr+DsZghzQupaBGg@mail.gmail.com>
Subject: Re: [PATCH] drm: assure aux_dev is nonzero before using it
To:     Zwane Mwaikambo <zwanem@gmail.com>, Lyude <lyude@redhat.com>
Cc:     tcamuso@redhat.com, dkwon@redhat.com,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 12, 2020 at 12:16 AM Zwane Mwaikambo <zwanem@gmail.com> wrote:
>
> On Tue, 11 Aug 2020, Daniel Vetter wrote:
>
> > On Mon, Aug 10, 2020 at 10:11:50AM -0700, Zwane Mwaikambo wrote:
> > > Hi Folks,
> > >     I know this thread eventually dropped off due to not identifying
> > > the underlying issue. It's still occuring on 5.8 and in my case it
> > > happened because the udev device nodes for the DP aux devices were not
> > > cleaned up whereas the kernel had no association with them. I can
> > > reproduce the bug just by creating a device node for a non-existent minor
> > > device and calling open().
> >
> > Hm I don't have that thread anymore, but generally these bugs are solved
> > by not registering the device before it's ready for use. We do have
> > drm_connector->late_register for that stuff. Just a guess since I'm not
> > seeing full details here.
>
> In this particular case, the physical device disappeared before the nodes
> were cleaned up. It involves putting a computer to sleep with a monitor
> plugged in and then waking it up with the monitor unplugged.

We also have early_unregister for the reverse, but yes this sounds
more tricky ... Adding Lyude who's been working on way too much
lifetime fun around dp recently.
-Daniel

>
>
> > >
> > > To me it still makes sense to just check aux_dev because the chardev has
> > > no way to check before calling.
> > >
> > > (gdb) list *drm_dp_aux_dev_get_by_minor+0x29
> > > 0x17b39 is in drm_dp_aux_dev_get_by_minor (drivers/gpu/drm/drm_dp_aux_dev.c:65).
> > > 60      static struct drm_dp_aux_dev *drm_dp_aux_dev_get_by_minor(unsigned index)
> > > 61      {
> > > 62              struct drm_dp_aux_dev *aux_dev = NULL;
> > > 63
> > > 64              mutex_lock(&aux_idr_mutex);
> > > 65              aux_dev = idr_find(&aux_idr, index);
> > > 66              if (!kref_get_unless_zero(&aux_dev->refcount))
> > > 67                      aux_dev = NULL;
> > > 68              mutex_unlock(&aux_idr_mutex);
> > > 69
> > > (gdb) p/x &((struct drm_dp_aux_dev *)(0x0))->refcount
> > > $8 = 0x18
> > >
> > > static int auxdev_open(struct inode *inode, struct file *file)
> > > {
> > >     unsigned int minor = iminor(inode);
> > >     struct drm_dp_aux_dev *aux_dev;
> > >
> > >     aux_dev = drm_dp_aux_dev_get_by_minor(minor);
> > >     if (!aux_dev)
> > >         return -ENODEV;
> > >
> > >     file->private_data = aux_dev;
> > >     return 0;
> > > }
> > >
> > >
> > > _______________________________________________
> > > dri-devel mailing list
> > > dri-devel@lists.freedesktop.org
> > > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> >
> >



-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
