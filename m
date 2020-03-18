Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 612A3C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 16:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31CD3205ED
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 16:32:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Ws724cGh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbgCRQcB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 12:32:01 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:35684 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726940AbgCRQcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 12:32:00 -0400
Received: by mail-oi1-f196.google.com with SMTP id k8so24978499oik.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 09:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ez9hpvifTc2STDnZtWKDhLfk74UGNnWXuwCGbU6A4rw=;
        b=Ws724cGhkpDJrESIGX/4T3R9+qJJbPVIP3NXUhB8BNrmbiBj21FBy60UbqlLjSLNz7
         xKFVpYYR88qi+iqmDYupAoTTc+twjo1LdLcZAmkHp9o8z2VCL/7KdhcQw87kxU01V4aD
         1lRoWT482c+50v7UlLEtXLyPtI2Zkax61bzGU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ez9hpvifTc2STDnZtWKDhLfk74UGNnWXuwCGbU6A4rw=;
        b=ajkI4Yy9WAsAQU5OkBhVro/DHaGyy8o3+iZMBx5VYJC+nXrzpOQRPc8tjgxH0JpCGy
         obIW/Ox3ZuSaFYXXvmoVHr5DWTY9PmdVvuOTHfYsKraAD0GtPsTfMZl12oVEQIzXhBS1
         FCaLZQe54TTeYCOLqimsADK8dCGv4e/MiCvi6uVQYIV1AWq/u2wS0OpOnAZAXJoEMOVC
         8zjzgTOrVdVlmU6qNd+wK4+WAjSwVNbZs8EVKvKYG5S/W4e2FW33W0kznuVxmW9AU3J0
         VNLlWl0hSNG5fsbElLRpJk5PL75qHMhwxqkKl+rkXkpmJyMKFtSEDN5xurOw7MeWAOlN
         ZtXg==
X-Gm-Message-State: ANhLgQ13pM8r6+SabEWBn2VyWBpFZFZR2BXmJOyw8yjyWpbLPjrdZ/Dg
        l+YhLnxbVRG/mVadex7kB8e/gEU2xe3nn/TF78gMuA==
X-Google-Smtp-Source: ADFU+vuoiOaP8HEDosLzk/qwSJgLByHWnhyt7zF/h7nFcLuR+AupnswWjQNZ/+htP3HpMXmztbG+XG7/OOKNLAEPmjQ=
X-Received: by 2002:aca:5345:: with SMTP id h66mr3974889oib.110.1584549119226;
 Wed, 18 Mar 2020 09:31:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200310133121.27913-1-wambui.karugax@gmail.com>
 <20200310133121.27913-11-wambui.karugax@gmail.com> <20200318152627.GY2363188@phenom.ffwll.local>
 <alpine.LNX.2.21.99999.375.2003181857010.54051@wambui>
In-Reply-To: <alpine.LNX.2.21.99999.375.2003181857010.54051@wambui>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Wed, 18 Mar 2020 17:31:47 +0100
Message-ID: <CAKMK7uGwJ6nzLPzwtfUY79e1fSFxkrSgTfJuDeM4px6c0v13qg@mail.gmail.com>
Subject: Re: [PATCH v2 10/17] drm/vram-helper: make drm_vram_mm_debugfs_init()
 return 0
To:     Wambui Karuga <wambui.karugax@gmail.com>
Cc:     Dave Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 18, 2020 at 5:03 PM Wambui Karuga <wambui.karugax@gmail.com> wrote:
>
>
>
> On Wed, 18 Mar 2020, Daniel Vetter wrote:
>
> > On Tue, Mar 10, 2020 at 04:31:14PM +0300, Wambui Karuga wrote:
> >> Since 987d65d01356 (drm: debugfs: make
> >> drm_debugfs_create_files() never fail), drm_debugfs_create_files() never
> >> fails and should return void. Therefore, remove its use as the
> >> return value of drm_vram_mm_debugfs_init(), and have the function
> >> return 0 directly.
> >>
> >> v2: have drm_vram_mm_debugfs_init() return 0 instead of void to avoid
> >> introducing build issues and build breakage.
> >>
> >> References: https://lists.freedesktop.org/archives/dri-devel/2020-February/257183.html
> >> Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
> >> Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
> >> ---
> >>  drivers/gpu/drm/drm_gem_vram_helper.c | 10 ++++------
> >>  1 file changed, 4 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/drm_gem_vram_helper.c b/drivers/gpu/drm/drm_gem_vram_helper.c
> >> index 92a11bb42365..c8bcc8609650 100644
> >> --- a/drivers/gpu/drm/drm_gem_vram_helper.c
> >> +++ b/drivers/gpu/drm/drm_gem_vram_helper.c
> >> @@ -1048,14 +1048,12 @@ static const struct drm_info_list drm_vram_mm_debugfs_list[] = {
> >>   */
> >>  int drm_vram_mm_debugfs_init(struct drm_minor *minor)
> >>  {
> >> -    int ret = 0;
> >> -
> >>  #if defined(CONFIG_DEBUG_FS)
> >
> > Just noticed that this #if here is not needed, we already have a dummy
> > function for that case. Care to write a quick patch to remove it? On top
> > of this patch series here ofc, I'm in the processing of merging the entire
> > pile.
> >
> > Thanks, Daniel
> Hi Daniel,
> Without this check here, and compiling without CONFIG_DEBUG_FS, this
> function is run and the drm_debugfs_create_files() does not have access to
> the parameters also protected by an #if above this function. So the change
> throws an error for me. Is that correct?

Hm right. Other drivers don't #ifdef out their debugfs file functions
... kinda a bit disappointing that we can't do this in the neatest way
possible.

Greg, has anyone ever suggested to convert the debugfs_create_file
function (and similar things) to macros that don't use any of the
arguments, and then also annotating all the static functions/tables as
__maybe_unused and let the compiler garbage collect everything?
Instead of explicit #ifdef in all the drivers ...
-Daniel

>
> Thanks,
> wambui karuga
>
> >> -    ret = drm_debugfs_create_files(drm_vram_mm_debugfs_list,
> >> -                                   ARRAY_SIZE(drm_vram_mm_debugfs_list),
> >> -                                   minor->debugfs_root, minor);
> >> +    drm_debugfs_create_files(drm_vram_mm_debugfs_list,
> >> +                             ARRAY_SIZE(drm_vram_mm_debugfs_list),
> >> +                             minor->debugfs_root, minor);
> >>  #endif
> >> -    return ret;
> >> +    return 0;
> >>  }
> >>  EXPORT_SYMBOL(drm_vram_mm_debugfs_init);
> >>
> >> --
> >> 2.25.1
> >>
> >
> > --
> > Daniel Vetter
> > Software Engineer, Intel Corporation
> > http://blog.ffwll.ch
> >



-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
