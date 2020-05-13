Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0390C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 19:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D26D206A5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 19:33:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="g120dPF2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390680AbgEMTdL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 15:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389808AbgEMTdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 15:33:10 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DCFDC061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 12:33:10 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id j145so646801oib.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 12:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=otXn7LersPgzIHI8cE7ZG+3L14O0eRmhgr2LFA57fHo=;
        b=g120dPF25WK/Xgfg3CfUd/yhFNPVZtBN18rNtZuiuv9z0ANGcbojbHdrDGIu1s8Wcr
         J8Jaf/9u4w9dwb5odTlC55Xaw+0klqYTokujtJGRXKeGi0XAugCJ8FjVzaxARCYOgB0F
         373yW3rkEF1MSg61eaGougrD+qQCuq+1YunUU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=otXn7LersPgzIHI8cE7ZG+3L14O0eRmhgr2LFA57fHo=;
        b=joMH/TgLdcuTacFwUw+4t6hCm55ADv3aYXHNT6U8PCmYBjWTpk8h6uV81XV2ne24RW
         CH5yJrLCaLBVXZvN09pRj6vVigyBxlRuGgYFkZe5gQc0h/H++MjNKnhpo/fsY1DX6TrJ
         ybvcYDVzrpR0i5CRXrLXKJNuDHkeJQd6iIO6LF5QVr4slqRYgEvx7VAfVPWiyLap4NIe
         l9BJmcWzO4C0syMv9/q3a6oGERzXecWVYgF/Slq40YUSDRNlx4t2xiA4/uINVviGdIA6
         7wQ4kns61qp6nFqfwvU/cbelehW5m7i4V7U+Picr8Xko7aB2u8bElx6Ot2Beq23E3B4g
         4MWA==
X-Gm-Message-State: AOAM531n/Z60l+PpOIoSfdBq8du7wEl03pJy6HtdjlrSUVUnZGYX7GYT
        LdOFjhAYXmmXQcnb7HVQ/XwzkEQVzP9KHJ9r303VTw==
X-Google-Smtp-Source: ABdhPJxgXhDAIqKBPUxe20uIEycL/zvBggdp53MMPs/53w6SKv8jA4HdFXEazXoztR3T+rGUxFKr2L+d4tEeQzC9SQM=
X-Received: by 2002:aca:fd14:: with SMTP id b20mr3627430oii.14.1589398389482;
 Wed, 13 May 2020 12:33:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200513114130.28641-1-wambui.karugax@gmail.com>
 <20200513114130.28641-2-wambui.karugax@gmail.com> <47bbbb51-7e53-7c87-6058-5848f9ccecfe@suse.de>
 <alpine.LNX.2.21.99999.375.2005132110540.35866@wambui>
In-Reply-To: <alpine.LNX.2.21.99999.375.2005132110540.35866@wambui>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Wed, 13 May 2020 21:32:57 +0200
Message-ID: <CAKMK7uGT_OMCQzJ18q7U8QOG6td0gdsBEFbs-BYmXewv5nc_mg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] drm/debugfs: create debugfs files during drm_dev_register().
To:     Wambui Karuga <wambui.karugax@gmail.com>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Dave Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 8:12 PM Wambui Karuga <wambui.karugax@gmail.com> wr=
ote:
>
>
>
> On Wed, 13 May 2020, Thomas Zimmermann wrote:
>
> > Hi
> >
> > Am 13.05.20 um 13:41 schrieb Wambui Karuga:
> >> Introduce the ability to track requests for the addition of drm debugf=
s
> >> files at any time and have them added all at once during
> >> drm_dev_register().
> >>
> >> Drivers can add drm debugfs file requests to a new list tied to drm_de=
vice.
> >> During drm_dev_register(), the new function drm_debugfs_create_file()
> >> will iterate over the list of added files on a given minor to create
> >> them.
> >>
> >> Two new structs are introduced in this change: struct drm_simple_info
> >> which represents a drm debugfs file entry and struct
> >> drm_simple_info_entry which is used to track file requests and is the
> >> main parameter of choice passed by functions. Each drm_simple_info_ent=
ry is
> >> added to the new struct drm_device->debugfs_list for file requests.
> >>
> >> Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
> >> ---
> >>  drivers/gpu/drm/drm_debugfs.c | 59 ++++++++++++++++++++++++++++++++--=
-
> >>  drivers/gpu/drm/drm_drv.c     |  2 ++
> >>  include/drm/drm_debugfs.h     | 38 ++++++++++++++++++++++
> >>  include/drm/drm_device.h      | 12 +++++++
> >>  4 files changed, 107 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/drm_debugfs.c b/drivers/gpu/drm/drm_debug=
fs.c
> >> index 2bea22130703..03b0588ede68 100644
> >> --- a/drivers/gpu/drm/drm_debugfs.c
> >> +++ b/drivers/gpu/drm/drm_debugfs.c
> >> @@ -145,9 +145,10 @@ static const struct drm_info_list drm_debugfs_lis=
t[] =3D {
> >>
> >>  static int drm_debugfs_open(struct inode *inode, struct file *file)
> >>  {
> >> -    struct drm_info_node *node =3D inode->i_private;
> >> +    struct drm_simple_info_entry *entry =3D inode->i_private;
> >> +    struct drm_simple_info *node =3D &entry->file;
> >>
> >> -    return single_open(file, node->info_ent->show, node);
> >> +    return single_open(file, node->show_fn, entry);
> >>  }
> >>
> >>
> >> @@ -159,6 +160,25 @@ static const struct file_operations drm_debugfs_f=
ops =3D {
> >>      .release =3D single_release,
> >>  };
> >>
> >> +/**
> >> + * drm_debugfs_create_file - create DRM debugfs file.
> >> + * @dev: drm_device that the file belongs to
> >> + *
> >> + * Create a DRM debugfs file from the list of files to be created
> >> + * from dev->debugfs_list.
> >> + */
> >> +static void drm_debugfs_create_file(struct drm_minor *minor)
> >
> > This function creates several files. I'd rather call it
> > drm_debugfs_create_added_files().
> >
> Okay, that makes sense. I can change that.
>
> >> +{
> >> +    struct drm_device *dev =3D minor->dev;
> >> +    struct drm_simple_info_entry *entry;
> >> +
> >> +    list_for_each_entry(entry, &dev->debugfs_list, list) {
> >> +            debugfs_create_file(entry->file.name,
> >> +                                S_IFREG | S_IRUGO, minor->debugfs_roo=
t,
> >> +                                entry,
> >> +                                &drm_debugfs_fops);
> >> +    }
> >
> > I think the created items should be removed from the list. That way,
> > drivers can call the function multiple times without recreating the sam=
e
> > files again.
> >
> Hadn't thought of that - I can try add that.

The function here is static, called once by the core. So no need for
complicated logic, it's guaranteed to only be called once.

I guess what confused Thomas is the kerneldoc. We generally only do
that for functions exported to drivers, that drivers should call. Not
the case here. The function name itself is descriptive enough I think
(with Thomas' suggestion even better). So I'd just remove the
kerneldoc here.
-Daniel

> >> +}
> >>
> >>  /**
> >>   * drm_debugfs_create_files - Initialize a given set of debugfs files=
 for DRM
> >> @@ -213,8 +233,7 @@ int drm_debugfs_init(struct drm_minor *minor, int =
minor_id,
> >>      sprintf(name, "%d", minor_id);
> >>      minor->debugfs_root =3D debugfs_create_dir(name, root);
> >>
> >> -    drm_debugfs_create_files(drm_debugfs_list, DRM_DEBUGFS_ENTRIES,
> >> -                             minor->debugfs_root, minor);
> >
> > By removing these two lines, aren't you losing the files listed in
> > DRM_DEBUGFS_ENTRIES?
> >
> Yes.
> When using the new functions, drm_debugfs_create_files() should not
> be called at this point, but for compatibility these two lines should
> be put back, I think.
>
> >> +    drm_debugfs_create_file(minor);
> >>
> >>      if (drm_drv_uses_atomic_modeset(dev)) {
> >>              drm_atomic_debugfs_init(minor);
> >> @@ -449,4 +468,36 @@ void drm_debugfs_crtc_remove(struct drm_crtc *crt=
c)
> >>      crtc->debugfs_entry =3D NULL;
> >>  }
> >>
> >> +void drm_debugfs_add_file(struct drm_device *dev, const char *name,
> >> +                      drm_simple_show_t show_fn, void *data)
> >> +{
> >> +    struct drm_simple_info_entry *entry =3D
> >> +            kzalloc(sizeof(*entry), GFP_KERNEL);
> >> +
> >> +    if (!entry)
> >> +            return;
> >> +
> >> +    entry->file.name =3D name;
> >> +    entry->file.show_fn =3D show_fn;
> >> +    entry->file.data =3D data;
> >> +    entry->dev =3D dev;
> >> +
> >> +    mutex_lock(&dev->debugfs_mutex);
> >> +    list_add(&entry->list, &dev->debugfs_list);
> >> +    mutex_unlock(&dev->debugfs_mutex);
> >> +}
> >> +EXPORT_SYMBOL(drm_debugfs_add_file);
> >> +
> >> +void drm_debugfs_add_files(struct drm_device *dev,
> >> +                       const struct drm_simple_info *files, int count=
)
> >> +{
> >> +    int i;
> >> +
> >> +    for (i =3D 0; i < count; i++) {
> >> +            drm_debugfs_add_file(dev, files[i].name, files[i].show_fn=
,
> >> +                                 files[i].data);
> >> +    }
> >> +}
> >> +EXPORT_SYMBOL(drm_debugfs_add_files);
> >> +
> >>  #endif /* CONFIG_DEBUG_FS */
> >> diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
> >> index bc38322f306e..c68df4e31aa0 100644
> >> --- a/drivers/gpu/drm/drm_drv.c
> >> +++ b/drivers/gpu/drm/drm_drv.c
> >> @@ -646,12 +646,14 @@ int drm_dev_init(struct drm_device *dev,
> >>      INIT_LIST_HEAD(&dev->filelist_internal);
> >>      INIT_LIST_HEAD(&dev->clientlist);
> >>      INIT_LIST_HEAD(&dev->vblank_event_list);
> >> +    INIT_LIST_HEAD(&dev->debugfs_list);
> >>
> >>      spin_lock_init(&dev->event_lock);
> >>      mutex_init(&dev->struct_mutex);
> >>      mutex_init(&dev->filelist_mutex);
> >>      mutex_init(&dev->clientlist_mutex);
> >>      mutex_init(&dev->master_mutex);
> >> +    mutex_init(&dev->debugfs_mutex);
> >>
> >>      ret =3D drmm_add_action(dev, drm_dev_init_release, NULL);
> >>      if (ret)
> >> diff --git a/include/drm/drm_debugfs.h b/include/drm/drm_debugfs.h
> >> index 2188dc83957f..bbce580c3b38 100644
> >> --- a/include/drm/drm_debugfs.h
> >> +++ b/include/drm/drm_debugfs.h
> >> @@ -34,6 +34,44 @@
> >>
> >>  #include <linux/types.h>
> >>  #include <linux/seq_file.h>
> >> +
> >> +struct drm_device;
> >> +
> >> +typedef int (*drm_simple_show_t)(struct seq_file *, void *);
> >> +
> >> +/**
> >> + * struct drm_simple_info - debugfs file entry
> >> + *
> >> + * This struct represents a debugfs file to be created.
> >> + */
> >> +struct drm_simple_info {
> >
> > drm_simple_info and drm_simple_info_entry seem to be misnomers. They
> > should probably have some reference to debugfs in their name.
> >
> I'll change the names.
>
> Thanks,
> wambui karuga
> > Best regards
> > Thomas
> >
> >
> >> +    const char *name;
> >> +    drm_simple_show_t show_fn;
> >> +    u32 driver_features;
> >> +    void *data;
> >> +};
> >> +
> >> +/**
> >> + * struct drm_simple_info_entry - debugfs list entry
> >> + *
> >> + * This struct is used in tracking requests for new debugfs files
> >> + * to be created.
> >> + */
> >> +struct drm_simple_info_entry {
> >> +    struct drm_device *dev;
> >> +    struct drm_simple_info file;
> >> +    struct list_head list;
> >> +};
> >> +
> >> +void drm_debugfs_add_file(struct drm_device *dev,
> >> +                      const char *name,
> >> +                      drm_simple_show_t show_fn,
> >> +                      void *data);
> >> +
> >> +void drm_debugfs_add_files(struct drm_device *dev,
> >> +                       const struct drm_simple_info *files,
> >> +                       int count);
> >> +
> >>  /**
> >>   * struct drm_info_list - debugfs info list entry
> >>   *
> >> diff --git a/include/drm/drm_device.h b/include/drm/drm_device.h
> >> index a55874db9dd4..b84dfdac27b7 100644
> >> --- a/include/drm/drm_device.h
> >> +++ b/include/drm/drm_device.h
> >> @@ -326,6 +326,18 @@ struct drm_device {
> >>       */
> >>      struct drm_fb_helper *fb_helper;
> >>
> >> +    /**
> >> +     * @debugfs_mutex:
> >> +     * Protects debugfs_list access.
> >> +     */
> >> +    struct mutex debugfs_mutex;
> >> +
> >> +    /** @debugfs_list:
> >> +     * List of debugfs files to add.
> >> +     * Files are added during drm_dev_register().
> >> +     */
> >> +    struct list_head debugfs_list;
> >> +
> >>      /* Everything below here is for legacy driver, never use! */
> >>      /* private: */
> >>  #if IS_ENABLED(CONFIG_DRM_LEGACY)
> >>
> >
> > --
> > Thomas Zimmermann
> > Graphics Driver Developer
> > SUSE Software Solutions Germany GmbH
> > Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
> > (HRB 36809, AG N=C3=BCrnberg)
> > Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer
> >
> >



--=20
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
