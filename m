Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 775BAC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 21:17:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45D092086A
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 21:17:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PWwhGBch"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbgHGVRT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 17:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgHGVRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 17:17:18 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ABE8C061756
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 14:17:18 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id 128so1605223pgd.5
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 14:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=mTi25uKDeno+kjIGWxKtG9bnSzwH+0hK7ejqxU/R1EA=;
        b=PWwhGBchg2tJbjQiYkAtlcJdXTvewWyYBMHTHHrKFz2Px+GJ5NXCZfJ7x5pG3p5K8c
         6FhQTKgwg48cZFRfGsdGe6mYPYH2dLTU+qCzpRfJXDHU5jT/bH8VyQUZ0ngvIIGG13my
         ZUjFuSEKUTRIoUtwlx+fekBRDEZLzvdAKhTPtX25rUOj36ZEdkgbf4Q4wCEDvVJFIaNr
         dlUloyzVjagzcCYchfILiAavp7KC7EMg7VwsKSCC1mQxULEK8ELFy6kIyyAi3DvhwDw7
         PS8cGJVHwjXzWUpcVHd2RLZK19nTPA/gSYq50xrZM2aQAAWBDiWFrgxiWaq2F/OXVfoV
         uYEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=mTi25uKDeno+kjIGWxKtG9bnSzwH+0hK7ejqxU/R1EA=;
        b=dqfh1Qv/gPkafZYHM9dIiIWFS35eP3pJR68FqCDy4qK4WbA6cjvjQfs3JEnf90vyTn
         kvYm4xZWMgucRpmSXcpee2JM7Bpco2U8JjBw0T/vjYHgHkVFe/ItVC6CYvX09b+wo0RI
         2m8G6HCpkhREZs3ELisOi3vcvyr58A/1oFv9LK8p/b2pQI6IIm1HZd0+P06mL0MbgbGv
         QLOA3fDJDV/n6xYzPA6fijbkrLV+sMJUl77OW7KWl8Vi6MJhpRWeeO/XSaKHMX2ouF/D
         y027BJUjEfM8RhzxNu6LqFzyJUbP+aLJESyH08zmyIGdxegeRy1TAJzs5h7vH08gq/10
         9Ugw==
X-Gm-Message-State: AOAM533VuE46sssAlNUZtB31JxapFC8GEbW0hBhauqUnujzz4P6+Cn8b
        49eYHZVMsFAhLFmpDEYAK24=
X-Google-Smtp-Source: ABdhPJyX8dokEBECvrJtr/HspUEzUCXoXJ2w+iu74hAdocV4J9yYNtCOIKOnx/uQYxfab10QHJTsWw==
X-Received: by 2002:a62:62c5:: with SMTP id w188mr15527675pfb.133.1596835037973;
        Fri, 07 Aug 2020 14:17:17 -0700 (PDT)
Received: from realwakka ([61.83.141.80])
        by smtp.gmail.com with ESMTPSA id i185sm4358478pgd.28.2020.08.07.14.17.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Aug 2020 14:17:17 -0700 (PDT)
Date:   Fri, 7 Aug 2020 21:17:00 +0000
From:   Sidong Yang <realwakka@gmail.com>
To:     Melissa Wen <melissa.srw@gmail.com>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH] drm/vkms: modify sequence disable/plane/enable in
 commit_tail
Message-ID: <20200807211700.GA30117@realwakka>
References: <20200729152231.13249-1-realwakka@gmail.com>
 <CAJeY4oEAHmY5icF_EPpojW5U+ryt3-guuvGQfj_S=XskO_xyRA@mail.gmail.com>
 <20200804093351.GI6419@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200804093351.GI6419@phenom.ffwll.local>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 04, 2020 at 11:33:51AM +0200, daniel@ffwll.ch wrote:
> On Sat, Aug 01, 2020 at 04:30:23PM -0300, Melissa Wen wrote:
> > On Wed, Jul 29, 2020 at 12:22 PM Sidong Yang <realwakka@gmail.com> wrote:
> > >
> > > This patch modifies function call sequence in commit tail. This is for
> > > the problem that raised when kms_cursor_crc test is tested repeatedly.
> > > In second test, there is an bug that crtc commit doesn't start vblank events.
> > > Because there is some error about vblank's refcount. in commit_flush() that
> > > called from commit_plane, drm_vblank_get() is called and vblank is enabled
> > > in normal case. But in second test, vblank isn't enable for vblank->refcount
> > > is already increased in previous test. Increased refcount will be decreased
> > > in drm_atomic_helper_commit_modeset_enables() after commit_plane.
> > > Therefore, commit_plane should be called after commit_modeset_enable.
> > >
> > > In this situation, there is a warning raised in get_vblank_timestamp().
> > > hrtimer.node.expires and vblank->time are zero for no vblank events before.
> > > This patch returns current time when vblank is not enabled.
> > >
> > Hi Sidong,
> > 
> > I think this patch tries to solve two different issues.
> > 
> > I am not a maintainer, but I believe you can split it.
> > 
> > Everything indicates that changing the commit tail sequence does not
> > ideally solve the problem of subtests getting stuck (as we have dicussed);
> > however, for me, the treatment of the warning is valid and it is also related
> > to other IGT tests using VKMS.
> 
> Yeah I think (but haven't tested, definitely need to confirm that) that
> the vblank get/put fix from Melissa is the correct fix for all these
> issues.
> 
> > One option is to send a patch that only treats the warning. I believe that
> > in the body of the commit message, it would be nice to have the warning
> > that this patch addresses, and when it appears by running an IGT test.
> > Also, say why it should be done this way in vkms.
> > This info could help future debugging.
> 
> Yeah I think splitting out the warning fix is the right thing to do here.

Okay, I'll write another patch about the warning.
Thanks.

-Sidong

> -Daniel
> 
> > 
> > Off-topic: I removed the group's mailing list of the University of São
> > Paulo (kernel-usp) from the cc, since I believe you had no intention of
> > sending the patch to them.
> > 
> > Best regards,
> > 
> > Melissa
> > 
> > > Cc: Daniel Vetter <daniel@ffwll.ch>
> > > Cc: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> > > Cc: Haneen Mohammed <hamohammed.sa@gmail.com>
> > >
> > > Signed-off-by: Sidong Yang <realwakka@gmail.com>
> > > ---
> > >  drivers/gpu/drm/vkms/vkms_crtc.c | 5 +++++
> > >  drivers/gpu/drm/vkms/vkms_drv.c  | 4 ++--
> > >  2 files changed, 7 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms_crtc.c
> > > index ac85e17428f8..09c012d54d58 100644
> > > --- a/drivers/gpu/drm/vkms/vkms_crtc.c
> > > +++ b/drivers/gpu/drm/vkms/vkms_crtc.c
> > > @@ -86,6 +86,11 @@ static bool vkms_get_vblank_timestamp(struct drm_crtc *crtc,
> > >         struct vkms_output *output = &vkmsdev->output;
> > >         struct drm_vblank_crtc *vblank = &dev->vblank[pipe];
> > >
> > > +       if (!READ_ONCE(vblank->enabled)) {
> > > +               *vblank_time = ktime_get();
> > > +               return true;
> > > +       }
> > > +
> > >         *vblank_time = READ_ONCE(output->vblank_hrtimer.node.expires);
> > >
> > >         if (WARN_ON(*vblank_time == vblank->time))
> > > diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
> > > index 1e8b2169d834..c2c83a01d4a7 100644
> > > --- a/drivers/gpu/drm/vkms/vkms_drv.c
> > > +++ b/drivers/gpu/drm/vkms/vkms_drv.c
> > > @@ -76,10 +76,10 @@ static void vkms_atomic_commit_tail(struct drm_atomic_state *old_state)
> > >
> > >         drm_atomic_helper_commit_modeset_disables(dev, old_state);
> > >
> > > -       drm_atomic_helper_commit_planes(dev, old_state, 0);
> > > -
> > >         drm_atomic_helper_commit_modeset_enables(dev, old_state);
> > >
> > > +       drm_atomic_helper_commit_planes(dev, old_state, 0);
> > > +
> > >         drm_atomic_helper_fake_vblank(old_state);
> > >
> > >         drm_atomic_helper_commit_hw_done(old_state);
> > > --
> > > 2.17.1
> > >
> > > --
> > > You received this message because you are subscribed to the Google Groups "Kernel USP" group.
> > > To unsubscribe from this group and stop receiving emails from it, send an email to kernel-usp+unsubscribe@googlegroups.com.
> > > To view this discussion on the web visit https://groups.google.com/d/msgid/kernel-usp/20200729152231.13249-1-realwakka%40gmail.com.
> 
> -- 
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch
