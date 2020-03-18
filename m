Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2352AC5ACD6
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 19:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDA9320754
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 19:10:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="j9cqkV9W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbgCRTK5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 15:10:57 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:45756 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbgCRTK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 15:10:56 -0400
Received: by mail-oi1-f195.google.com with SMTP id 9so8925018oiq.12
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 12:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mF3uqR0dI65g7bnW0IoscUYfl1Pu8OWv3Jeasc6I3BA=;
        b=j9cqkV9WTwaRvdcnzXTDaIt+vzNztv/R+bD2UgJMLQtJeMU12eT/rGdhjyO/W0T/xM
         1HVP7sesYmegIVG5wXh4mssL83KThrLmHOVhVNTxAqe/PN0hJokGjjKlQIDb3gZfTQU1
         joonWCXOEMZStzU2POcK99QCo7KXD+wLcj/5M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mF3uqR0dI65g7bnW0IoscUYfl1Pu8OWv3Jeasc6I3BA=;
        b=bgllQcn1UWqrGE8z3sPSpDxs3fihtAYldnh/30kc2qZ42F49g1hOwfqQ+qYvGhMAqi
         CTX/B4dGgli1YogYNjidLG5Cs4KqlIIpRivrcqm90LVK2Kl8KMCUWIZp7XwkkIMwaoHk
         ONOGXUb78tcGiuQZtKQ2VOIl+4ZoNTl9YY7Fhi5Pcr6WAn7rYq0M+ciKcsmmNYqJjjAD
         05Wt0cwoX09NOgFFBKL2JigsYd1x/gafbCYnrgQ+CTiLtC3uZwC0/lXEX9YMQ72FV5sK
         jnmRbU5ZQY686OE0xpTegepmvLriZz9yopY1uVyQ+Q0djJsYxSHiRNdl+8IsnbMtraqo
         9ALA==
X-Gm-Message-State: ANhLgQ2xmN7htLMpVP5Q6BTtz6rM3hcZXDAZWboG4/1TSw4FojDrnCEA
        FXf5VIlvlxjfvebSFxxAgmeixEmXdufCXu8nWb+2Rg==
X-Google-Smtp-Source: ADFU+vtvzb3ld5iCKPCDgez2fALttjMFd7OTN00Q0ZMjrPaTHDJx/5l+Ix8tro1kM1/JytRME65AEbqBNk+Hg/Bb3XU=
X-Received: by 2002:aca:be08:: with SMTP id o8mr4150691oif.101.1584558654804;
 Wed, 18 Mar 2020 12:10:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200310133121.27913-1-wambui.karugax@gmail.com>
 <20200310133121.27913-11-wambui.karugax@gmail.com> <20200318152627.GY2363188@phenom.ffwll.local>
 <alpine.LNX.2.21.99999.375.2003181857010.54051@wambui> <CAKMK7uGwJ6nzLPzwtfUY79e1fSFxkrSgTfJuDeM4px6c0v13qg@mail.gmail.com>
 <20200318165846.GC3090655@kroah.com>
In-Reply-To: <20200318165846.GC3090655@kroah.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Wed, 18 Mar 2020 20:10:43 +0100
Message-ID: <CAKMK7uGbg5Lax+eXJda4k9LNd7JBb+LRtRw4S+bZ4GbNGT--ZA@mail.gmail.com>
Subject: Re: [PATCH v2 10/17] drm/vram-helper: make drm_vram_mm_debugfs_init()
 return 0
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Wambui Karuga <wambui.karugax@gmail.com>,
        Dave Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 18, 2020 at 5:58 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Wed, Mar 18, 2020 at 05:31:47PM +0100, Daniel Vetter wrote:
> > On Wed, Mar 18, 2020 at 5:03 PM Wambui Karuga <wambui.karugax@gmail.com> wrote:
> > >
> > >
> > >
> > > On Wed, 18 Mar 2020, Daniel Vetter wrote:
> > >
> > > > On Tue, Mar 10, 2020 at 04:31:14PM +0300, Wambui Karuga wrote:
> > > >> Since 987d65d01356 (drm: debugfs: make
> > > >> drm_debugfs_create_files() never fail), drm_debugfs_create_files() never
> > > >> fails and should return void. Therefore, remove its use as the
> > > >> return value of drm_vram_mm_debugfs_init(), and have the function
> > > >> return 0 directly.
> > > >>
> > > >> v2: have drm_vram_mm_debugfs_init() return 0 instead of void to avoid
> > > >> introducing build issues and build breakage.
> > > >>
> > > >> References: https://lists.freedesktop.org/archives/dri-devel/2020-February/257183.html
> > > >> Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
> > > >> Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
> > > >> ---
> > > >>  drivers/gpu/drm/drm_gem_vram_helper.c | 10 ++++------
> > > >>  1 file changed, 4 insertions(+), 6 deletions(-)
> > > >>
> > > >> diff --git a/drivers/gpu/drm/drm_gem_vram_helper.c b/drivers/gpu/drm/drm_gem_vram_helper.c
> > > >> index 92a11bb42365..c8bcc8609650 100644
> > > >> --- a/drivers/gpu/drm/drm_gem_vram_helper.c
> > > >> +++ b/drivers/gpu/drm/drm_gem_vram_helper.c
> > > >> @@ -1048,14 +1048,12 @@ static const struct drm_info_list drm_vram_mm_debugfs_list[] = {
> > > >>   */
> > > >>  int drm_vram_mm_debugfs_init(struct drm_minor *minor)
> > > >>  {
> > > >> -    int ret = 0;
> > > >> -
> > > >>  #if defined(CONFIG_DEBUG_FS)
> > > >
> > > > Just noticed that this #if here is not needed, we already have a dummy
> > > > function for that case. Care to write a quick patch to remove it? On top
> > > > of this patch series here ofc, I'm in the processing of merging the entire
> > > > pile.
> > > >
> > > > Thanks, Daniel
> > > Hi Daniel,
> > > Without this check here, and compiling without CONFIG_DEBUG_FS, this
> > > function is run and the drm_debugfs_create_files() does not have access to
> > > the parameters also protected by an #if above this function. So the change
> > > throws an error for me. Is that correct?
> >
> > Hm right. Other drivers don't #ifdef out their debugfs file functions
> > ... kinda a bit disappointing that we can't do this in the neatest way
> > possible.
> >
> > Greg, has anyone ever suggested to convert the debugfs_create_file
> > function (and similar things) to macros that don't use any of the
> > arguments, and then also annotating all the static functions/tables as
> > __maybe_unused and let the compiler garbage collect everything?
> > Instead of explicit #ifdef in all the drivers ...
>
> No, no one has suggested that, having the functions be static inline
> should make it all "just work" properly if debugfs is not enabled.  The
> variables will not be used, so the compiler should just optimize them
> away properly.
>
> No checks for CONFIG_DEBUG_FS should be needed anywhere in .c code.

So the trouble with this one is that the static inline functions for
the debugfs file are wrapped in a #if too, and hence if we drop the
#if around the function call stuff won't compile. Should we drop all
the #if in the .c file and assume the compiler will remove all the
dead code and dead functions?
-Daniel (who has no idea how this all works really)
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
