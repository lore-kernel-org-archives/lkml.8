Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B71C34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 19:18:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BA1A22B48
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 19:18:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="gPYG7Up2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbgBRTSz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 14:18:55 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34570 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbgBRTSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 14:18:55 -0500
Received: by mail-wr1-f68.google.com with SMTP id n10so23407132wrm.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 11:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=EDv1Nfe5wsXfzyx8EHU5Go2CXWqnRUT+kGZGsxidLAE=;
        b=gPYG7Up24HLKpZ2gCcBHga9Kdn41TjeEpUn3sEfyxxZOeb7n5ZX/xuScf9tRJaAVx6
         MoH32/VpmVP1Jt3EglGtbe0koWcMmkTEE2/5ECdhSTZ60aSdd0RR2DnfByRsKFU595Os
         uoRd7KoMm5qj6sBTo1P+E6zboAFd3PnBLqEno=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=EDv1Nfe5wsXfzyx8EHU5Go2CXWqnRUT+kGZGsxidLAE=;
        b=B+TEgWeOoR5gD+LInmgN6s8LPnPjgWCr8wKiP7Igp08X7xW3JJIm8FqsH9FFerLI6h
         3q44BwYQT/LfzvumY+Bgw4Zcaw7Kw5R3hZAGHY3MmdT/Iid26vdw71VlMp1ynAqNNci0
         VJ0Kr87gEc+YkONLIPH6GQks9x6Dwhl+11YkaQQ8PWfRHBoX7Q3tyebmeS9Fmvy7yj6r
         CylMLl8Fu8+vfxGRzE7P3z3ZJ/Qftuez8MeOcoHjgsMgkEpHgSmqGdFF+V+PV36QHiIG
         509kp6/jixNHQaB8QRQgIP3ARsAv6F9SQjOa1oYHqr8h50ukxLDY+LWudEvlaKmGdBQm
         4g4A==
X-Gm-Message-State: APjAAAUEUCEtU1Mf6fIp5jCQAgh0IjzELixFNppXFvqemA5X5gI1S3iW
        yJIwKhpSFXq7yxT7y3ea6B++LpYLGxA=
X-Google-Smtp-Source: APXvYqx+/IkcOWLmZ/nIlILF5xmAM7d4Bh9kKuTs/+e2gy8RKNfntjbzdg7t7O97vuabW9+kI7TpgA==
X-Received: by 2002:a5d:5148:: with SMTP id u8mr32125166wrt.132.1582053533137;
        Tue, 18 Feb 2020 11:18:53 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id x11sm4433598wmg.46.2020.02.18.11.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 11:18:52 -0800 (PST)
Date:   Tue, 18 Feb 2020 20:18:50 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Wambui Karuga <wambui.karugax@gmail.com>
Cc:     Alexey Brodkin <abrodkin@synopsys.com>,
        Dave Airlie <airlied@linux.ie>,
        Greg KH <gregkh@linuxfoundation.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/arc: make arcpgu_debugfs_init return 0
Message-ID: <20200218191850.GP2363188@phenom.ffwll.local>
Mail-Followup-To: Wambui Karuga <wambui.karugax@gmail.com>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Dave Airlie <airlied@linux.ie>,
        Greg KH <gregkh@linuxfoundation.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20200218172821.18378-1-wambui.karugax@gmail.com>
 <CAKMK7uHeSW-sFCZK09n89mJ66J3sb0EtxYU9Ojfi-adM7czTug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKMK7uHeSW-sFCZK09n89mJ66J3sb0EtxYU9Ojfi-adM7czTug@mail.gmail.com>
X-Operating-System: Linux phenom 5.3.0-3-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2020 at 08:00:30PM +0100, Daniel Vetter wrote:
> On Tue, Feb 18, 2020 at 6:28 PM Wambui Karuga <wambui.karugax@gmail.com> wrote:
> >
> > As drm_debugfs_create_files should return void, remove its use as the
> > return value of arcpgu_debugfs_init and have the latter function
> > return 0 directly.
> >
> > Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
> > ---
> >  drivers/gpu/drm/arc/arcpgu_drv.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/arc/arcpgu_drv.c b/drivers/gpu/drm/arc/arcpgu_drv.c
> > index d6a6692db0ac..660b25f9588e 100644
> > --- a/drivers/gpu/drm/arc/arcpgu_drv.c
> > +++ b/drivers/gpu/drm/arc/arcpgu_drv.c
> > @@ -139,8 +139,10 @@ static struct drm_info_list arcpgu_debugfs_list[] = {
> >
> >  static int arcpgu_debugfs_init(struct drm_minor *minor)
> >  {
> > -       return drm_debugfs_create_files(arcpgu_debugfs_list,
> > -               ARRAY_SIZE(arcpgu_debugfs_list), minor->debugfs_root, minor);
> > +       drm_debugfs_create_files(arcpgu_debugfs_list,
> > +                                ARRAY_SIZE(arcpgu_debugfs_list),
> > +                                minor->debugfs_root, minor);
> > +       return 0;
> 
> For cases like these I think we should go a step further and also
> remove the return value from the driver wrapper. And that all the way
> up until there's something that actually needs to return a value for
> some other reason than debugfs.

This ofc applies to almost all the driver patches for this series, most
can be cleaned up quite a bit more.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
