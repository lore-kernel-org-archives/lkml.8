Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBFE4C5ACD6
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 16:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91CAF20724
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 16:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584550731;
	bh=50sIpwbTYylG3uOeXddKEerXCNu0A2f54RlDXQlgRCY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jOG66AGC1PiIFo7Bv170TsDxbaJXnjGbFZoq4cVoXzUSEkc0ENpRk1i3S0A7cMYrg
	 LRtZz2akdAkEVFb5J9nPGacOnNDGDwoh0xMP7ry2oxnZCKNhF7QdkPshtS/L2i62K6
	 UaGm5EtZfjuUlX3NvNT+n2hHKn8AqJ+JFMYsFEzE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbgCRQ6u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 12:58:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:33448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726680AbgCRQ6t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 12:58:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E9D820724;
        Wed, 18 Mar 2020 16:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584550729;
        bh=50sIpwbTYylG3uOeXddKEerXCNu0A2f54RlDXQlgRCY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I1pTko21+eEy3TFE/HCcnefGq5yIi0x+IohXiwaDCSA9CrlauuC40vheU5h3Cp7s4
         uEiYvJoq0SGZTxXd5QNgGt1s4k3kXwiqkYH1zYdJr3NIKqfEWmFrbvXcK/Fswxr/IK
         eUKAnxYn6eMILCn40d4TT2DXztIL4wjfjAdEaSCo=
Date:   Wed, 18 Mar 2020 17:58:46 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Wambui Karuga <wambui.karugax@gmail.com>,
        Dave Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 10/17] drm/vram-helper: make
 drm_vram_mm_debugfs_init() return 0
Message-ID: <20200318165846.GC3090655@kroah.com>
References: <20200310133121.27913-1-wambui.karugax@gmail.com>
 <20200310133121.27913-11-wambui.karugax@gmail.com>
 <20200318152627.GY2363188@phenom.ffwll.local>
 <alpine.LNX.2.21.99999.375.2003181857010.54051@wambui>
 <CAKMK7uGwJ6nzLPzwtfUY79e1fSFxkrSgTfJuDeM4px6c0v13qg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKMK7uGwJ6nzLPzwtfUY79e1fSFxkrSgTfJuDeM4px6c0v13qg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 18, 2020 at 05:31:47PM +0100, Daniel Vetter wrote:
> On Wed, Mar 18, 2020 at 5:03 PM Wambui Karuga <wambui.karugax@gmail.com> wrote:
> >
> >
> >
> > On Wed, 18 Mar 2020, Daniel Vetter wrote:
> >
> > > On Tue, Mar 10, 2020 at 04:31:14PM +0300, Wambui Karuga wrote:
> > >> Since 987d65d01356 (drm: debugfs: make
> > >> drm_debugfs_create_files() never fail), drm_debugfs_create_files() never
> > >> fails and should return void. Therefore, remove its use as the
> > >> return value of drm_vram_mm_debugfs_init(), and have the function
> > >> return 0 directly.
> > >>
> > >> v2: have drm_vram_mm_debugfs_init() return 0 instead of void to avoid
> > >> introducing build issues and build breakage.
> > >>
> > >> References: https://lists.freedesktop.org/archives/dri-devel/2020-February/257183.html
> > >> Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
> > >> Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
> > >> ---
> > >>  drivers/gpu/drm/drm_gem_vram_helper.c | 10 ++++------
> > >>  1 file changed, 4 insertions(+), 6 deletions(-)
> > >>
> > >> diff --git a/drivers/gpu/drm/drm_gem_vram_helper.c b/drivers/gpu/drm/drm_gem_vram_helper.c
> > >> index 92a11bb42365..c8bcc8609650 100644
> > >> --- a/drivers/gpu/drm/drm_gem_vram_helper.c
> > >> +++ b/drivers/gpu/drm/drm_gem_vram_helper.c
> > >> @@ -1048,14 +1048,12 @@ static const struct drm_info_list drm_vram_mm_debugfs_list[] = {
> > >>   */
> > >>  int drm_vram_mm_debugfs_init(struct drm_minor *minor)
> > >>  {
> > >> -    int ret = 0;
> > >> -
> > >>  #if defined(CONFIG_DEBUG_FS)
> > >
> > > Just noticed that this #if here is not needed, we already have a dummy
> > > function for that case. Care to write a quick patch to remove it? On top
> > > of this patch series here ofc, I'm in the processing of merging the entire
> > > pile.
> > >
> > > Thanks, Daniel
> > Hi Daniel,
> > Without this check here, and compiling without CONFIG_DEBUG_FS, this
> > function is run and the drm_debugfs_create_files() does not have access to
> > the parameters also protected by an #if above this function. So the change
> > throws an error for me. Is that correct?
> 
> Hm right. Other drivers don't #ifdef out their debugfs file functions
> ... kinda a bit disappointing that we can't do this in the neatest way
> possible.
> 
> Greg, has anyone ever suggested to convert the debugfs_create_file
> function (and similar things) to macros that don't use any of the
> arguments, and then also annotating all the static functions/tables as
> __maybe_unused and let the compiler garbage collect everything?
> Instead of explicit #ifdef in all the drivers ...

No, no one has suggested that, having the functions be static inline
should make it all "just work" properly if debugfs is not enabled.  The
variables will not be used, so the compiler should just optimize them
away properly.

No checks for CONFIG_DEBUG_FS should be needed anywhere in .c code.

thanks,

greg k-h
