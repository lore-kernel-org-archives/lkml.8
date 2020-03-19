Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65595C4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 10:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34B71206D7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 10:18:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="EYB0H32K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbgCSKSg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 06:18:36 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51554 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726825AbgCSKSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 06:18:35 -0400
Received: by mail-wm1-f66.google.com with SMTP id c187so1444390wme.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Mar 2020 03:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=9orDqus34XDuXi5i1KvF+t2rP3oN+I1lofE3FxXqw5k=;
        b=EYB0H32KYUNpFmHyD2o5deHe2/46kUttKOvnFsphFEu9WTmAXYn15ERROmCC1kQU97
         B3kN01ywJLlqlOQ5cw4sM1AiJgV4MNgUA5G1WD2OheCrVtTEMUUe0YertrKzWZT4kbsJ
         /zekAZHkZmYXhNP+hgoo0zBgl2x79eOtQ9IKM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=9orDqus34XDuXi5i1KvF+t2rP3oN+I1lofE3FxXqw5k=;
        b=K5vnBaDQuAWvRphNrp2Gu6J0cVlCOf59yjYN+5DGBXQh9+OpOxYkyBniWvWdSqgLED
         6V+d5jUZ7kWijNHxX4j+1pwm9xbDd/gPi41yKUWv6JQcntCutADl7hOfBK0qFEjA3Y9I
         X6M3l68qowOQ/m6CT85O+lp19NhydjLhM5JvyiX5Mo3Z+ZCCfm6tfyP0ZFP0r67Ymftm
         6j2EB7h46YQhgSigMWsdyBZ0eL/4Riz3Gyai+Xhr6vqSUZaHtxHBXlwxr2u+dAxqO1Hd
         zWqGbMLxtxZXrSAtuWhEOUhOsvjGGP9T1kF6k3VW0s0HgvzgkJZidAjrZ4jaTRqR/djU
         EI9Q==
X-Gm-Message-State: ANhLgQ0spFWNsjPJDbVbrkGIHsl93nbCvseQB8OA2lq+cOR5zFMaicoj
        YKeNUnTh2kdX6mQd8YQRrI1HxA==
X-Google-Smtp-Source: ADFU+vs1cY0h+g/ybHd7aq9aAE2q7J9qQbOvmeUgc6gSXldSzXKDqGGuNEQYYStflkny8WIXLgRMYQ==
X-Received: by 2002:a1c:7711:: with SMTP id t17mr2772854wmi.108.1584613113335;
        Thu, 19 Mar 2020 03:18:33 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id n1sm2723582wrj.77.2020.03.19.03.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 03:18:32 -0700 (PDT)
Date:   Thu, 19 Mar 2020 11:18:30 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Wambui Karuga <wambui.karugax@gmail.com>,
        Dave Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 10/17] drm/vram-helper: make
 drm_vram_mm_debugfs_init() return 0
Message-ID: <20200319101830.GB2363188@phenom.ffwll.local>
Mail-Followup-To: Greg KH <gregkh@linuxfoundation.org>,
        Wambui Karuga <wambui.karugax@gmail.com>,
        Dave Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20200310133121.27913-1-wambui.karugax@gmail.com>
 <20200310133121.27913-11-wambui.karugax@gmail.com>
 <20200318152627.GY2363188@phenom.ffwll.local>
 <alpine.LNX.2.21.99999.375.2003181857010.54051@wambui>
 <CAKMK7uGwJ6nzLPzwtfUY79e1fSFxkrSgTfJuDeM4px6c0v13qg@mail.gmail.com>
 <20200318165846.GC3090655@kroah.com>
 <CAKMK7uGbg5Lax+eXJda4k9LNd7JBb+LRtRw4S+bZ4GbNGT--ZA@mail.gmail.com>
 <20200319075524.GB3445010@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200319075524.GB3445010@kroah.com>
X-Operating-System: Linux phenom 5.3.0-3-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 19, 2020 at 08:55:24AM +0100, Greg KH wrote:
> On Wed, Mar 18, 2020 at 08:10:43PM +0100, Daniel Vetter wrote:
> > On Wed, Mar 18, 2020 at 5:58 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Wed, Mar 18, 2020 at 05:31:47PM +0100, Daniel Vetter wrote:
> > > > On Wed, Mar 18, 2020 at 5:03 PM Wambui Karuga <wambui.karugax@gmail.com> wrote:
> > > > >
> > > > >
> > > > >
> > > > > On Wed, 18 Mar 2020, Daniel Vetter wrote:
> > > > >
> > > > > > On Tue, Mar 10, 2020 at 04:31:14PM +0300, Wambui Karuga wrote:
> > > > > >> Since 987d65d01356 (drm: debugfs: make
> > > > > >> drm_debugfs_create_files() never fail), drm_debugfs_create_files() never
> > > > > >> fails and should return void. Therefore, remove its use as the
> > > > > >> return value of drm_vram_mm_debugfs_init(), and have the function
> > > > > >> return 0 directly.
> > > > > >>
> > > > > >> v2: have drm_vram_mm_debugfs_init() return 0 instead of void to avoid
> > > > > >> introducing build issues and build breakage.
> > > > > >>
> > > > > >> References: https://lists.freedesktop.org/archives/dri-devel/2020-February/257183.html
> > > > > >> Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
> > > > > >> Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
> > > > > >> ---
> > > > > >>  drivers/gpu/drm/drm_gem_vram_helper.c | 10 ++++------
> > > > > >>  1 file changed, 4 insertions(+), 6 deletions(-)
> > > > > >>
> > > > > >> diff --git a/drivers/gpu/drm/drm_gem_vram_helper.c b/drivers/gpu/drm/drm_gem_vram_helper.c
> > > > > >> index 92a11bb42365..c8bcc8609650 100644
> > > > > >> --- a/drivers/gpu/drm/drm_gem_vram_helper.c
> > > > > >> +++ b/drivers/gpu/drm/drm_gem_vram_helper.c
> > > > > >> @@ -1048,14 +1048,12 @@ static const struct drm_info_list drm_vram_mm_debugfs_list[] = {
> > > > > >>   */
> > > > > >>  int drm_vram_mm_debugfs_init(struct drm_minor *minor)
> > > > > >>  {
> > > > > >> -    int ret = 0;
> > > > > >> -
> > > > > >>  #if defined(CONFIG_DEBUG_FS)
> > > > > >
> > > > > > Just noticed that this #if here is not needed, we already have a dummy
> > > > > > function for that case. Care to write a quick patch to remove it? On top
> > > > > > of this patch series here ofc, I'm in the processing of merging the entire
> > > > > > pile.
> > > > > >
> > > > > > Thanks, Daniel
> > > > > Hi Daniel,
> > > > > Without this check here, and compiling without CONFIG_DEBUG_FS, this
> > > > > function is run and the drm_debugfs_create_files() does not have access to
> > > > > the parameters also protected by an #if above this function. So the change
> > > > > throws an error for me. Is that correct?
> > > >
> > > > Hm right. Other drivers don't #ifdef out their debugfs file functions
> > > > ... kinda a bit disappointing that we can't do this in the neatest way
> > > > possible.
> > > >
> > > > Greg, has anyone ever suggested to convert the debugfs_create_file
> > > > function (and similar things) to macros that don't use any of the
> > > > arguments, and then also annotating all the static functions/tables as
> > > > __maybe_unused and let the compiler garbage collect everything?
> > > > Instead of explicit #ifdef in all the drivers ...
> > >
> > > No, no one has suggested that, having the functions be static inline
> > > should make it all "just work" properly if debugfs is not enabled.  The
> > > variables will not be used, so the compiler should just optimize them
> > > away properly.
> > >
> > > No checks for CONFIG_DEBUG_FS should be needed anywhere in .c code.
> > 
> > So the trouble with this one is that the static inline functions for
> > the debugfs file are wrapped in a #if too, and hence if we drop the
> > #if around the function call stuff won't compile. Should we drop all
> > the #if in the .c file and assume the compiler will remove all the
> > dead code and dead functions?
> 
> Yes you should :)
> 
> there should not be any need for #if in a .c file for debugfs stuff.

Wambui, can you pls try that out? I.e. removing all the #if for
CONFIG_DEBUG_FS from that file.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
