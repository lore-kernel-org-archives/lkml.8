Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65BA5C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 09:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65DDC22B40
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 09:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="UoPVoVRz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbgHDJd6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 05:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbgHDJd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 05:33:57 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66FA2C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 02:33:55 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id c80so2049615wme.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 02:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=NFwnBuUV6bVAwnm6zIwLZz6xFgzPWKISMQC0BJF3oys=;
        b=UoPVoVRzcsw6cieJIVlsnj/wuU9LmN3VfVRrZ+MKwKQQxr+9xLbRnacDmgsrLkpFk8
         OLqylsQVWdcyLNjSoixDW1lfZwEglNY276klOaFmuPYng2Iu/NInbg46Xd78hATFLAYi
         8Mx23cu3tS+0KXJx89zbDDgmGsZE2Hm/gm9LA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=NFwnBuUV6bVAwnm6zIwLZz6xFgzPWKISMQC0BJF3oys=;
        b=h8JNxkDtQa+6Ap31SpgWGWrr4UlUQfipMY4OiypaU79aOAiVE1ux6AEACrXBoploWW
         aysqNbTD1lOi5e+MF1RPWC7x2UApwfbRVRBU9xcD8gkW3ygz1k55R0z8St4AsOILCffW
         GQ1za9m4dwt01e+8xNlGhxJ9PqQWwVOlYT1NeTnD97JO9jgOiRGaqTUNBm5aVOR4s8Lb
         MlgKKwmi3psQRUXFxcbJnQ0P4nKqwvg6/TDNE3XFap3UhQM3i6D8EpAdaIebv9uh9tyx
         iTJI9YvhW8NJzEBAdrApHPeyuSfrXS9gc4wzoLm4xgffCIZPvfzPDMxcF06B+aaTxjSf
         G/rA==
X-Gm-Message-State: AOAM531evhL4Hvkm4y4V+clGsqUm6BNdzkRHz3d6E6ZsFoBoQNu1idqR
        BsNOBVEWejjTrkE0o7igAkOWCA==
X-Google-Smtp-Source: ABdhPJxrrGidzQhwfTb1jWqCDcxs0YR82vstHBGZpvbp2FYaqscg6VnidhLropJSAgj/04fpqf7IWg==
X-Received: by 2002:a1c:ba83:: with SMTP id k125mr3240823wmf.160.1596533634127;
        Tue, 04 Aug 2020 02:33:54 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id q5sm28336286wrp.60.2020.08.04.02.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2020 02:33:53 -0700 (PDT)
Date:   Tue, 4 Aug 2020 11:33:51 +0200
From:   daniel@ffwll.ch
Cc:     Sidong Yang <realwakka@gmail.com>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH] drm/vkms: modify sequence disable/plane/enable in
 commit_tail
Message-ID: <20200804093351.GI6419@phenom.ffwll.local>
Mail-Followup-To: Melissa Wen <melissa.srw@gmail.com>,
        Sidong Yang <realwakka@gmail.com>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>
References: <20200729152231.13249-1-realwakka@gmail.com>
 <CAJeY4oEAHmY5icF_EPpojW5U+ryt3-guuvGQfj_S=XskO_xyRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJeY4oEAHmY5icF_EPpojW5U+ryt3-guuvGQfj_S=XskO_xyRA@mail.gmail.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 01, 2020 at 04:30:23PM -0300, Melissa Wen wrote:
> On Wed, Jul 29, 2020 at 12:22 PM Sidong Yang <realwakka@gmail.com> wrote:
> >
> > This patch modifies function call sequence in commit tail. This is for
> > the problem that raised when kms_cursor_crc test is tested repeatedly.
> > In second test, there is an bug that crtc commit doesn't start vblank events.
> > Because there is some error about vblank's refcount. in commit_flush() that
> > called from commit_plane, drm_vblank_get() is called and vblank is enabled
> > in normal case. But in second test, vblank isn't enable for vblank->refcount
> > is already increased in previous test. Increased refcount will be decreased
> > in drm_atomic_helper_commit_modeset_enables() after commit_plane.
> > Therefore, commit_plane should be called after commit_modeset_enable.
> >
> > In this situation, there is a warning raised in get_vblank_timestamp().
> > hrtimer.node.expires and vblank->time are zero for no vblank events before.
> > This patch returns current time when vblank is not enabled.
> >
> Hi Sidong,
> 
> I think this patch tries to solve two different issues.
> 
> I am not a maintainer, but I believe you can split it.
> 
> Everything indicates that changing the commit tail sequence does not
> ideally solve the problem of subtests getting stuck (as we have dicussed);
> however, for me, the treatment of the warning is valid and it is also related
> to other IGT tests using VKMS.

Yeah I think (but haven't tested, definitely need to confirm that) that
the vblank get/put fix from Melissa is the correct fix for all these
issues.

> One option is to send a patch that only treats the warning. I believe that
> in the body of the commit message, it would be nice to have the warning
> that this patch addresses, and when it appears by running an IGT test.
> Also, say why it should be done this way in vkms.
> This info could help future debugging.

Yeah I think splitting out the warning fix is the right thing to do here.
-Daniel

> 
> Off-topic: I removed the group's mailing list of the University of São
> Paulo (kernel-usp) from the cc, since I believe you had no intention of
> sending the patch to them.
> 
> Best regards,
> 
> Melissa
> 
> > Cc: Daniel Vetter <daniel@ffwll.ch>
> > Cc: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> > Cc: Haneen Mohammed <hamohammed.sa@gmail.com>
> >
> > Signed-off-by: Sidong Yang <realwakka@gmail.com>
> > ---
> >  drivers/gpu/drm/vkms/vkms_crtc.c | 5 +++++
> >  drivers/gpu/drm/vkms/vkms_drv.c  | 4 ++--
> >  2 files changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms_crtc.c
> > index ac85e17428f8..09c012d54d58 100644
> > --- a/drivers/gpu/drm/vkms/vkms_crtc.c
> > +++ b/drivers/gpu/drm/vkms/vkms_crtc.c
> > @@ -86,6 +86,11 @@ static bool vkms_get_vblank_timestamp(struct drm_crtc *crtc,
> >         struct vkms_output *output = &vkmsdev->output;
> >         struct drm_vblank_crtc *vblank = &dev->vblank[pipe];
> >
> > +       if (!READ_ONCE(vblank->enabled)) {
> > +               *vblank_time = ktime_get();
> > +               return true;
> > +       }
> > +
> >         *vblank_time = READ_ONCE(output->vblank_hrtimer.node.expires);
> >
> >         if (WARN_ON(*vblank_time == vblank->time))
> > diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
> > index 1e8b2169d834..c2c83a01d4a7 100644
> > --- a/drivers/gpu/drm/vkms/vkms_drv.c
> > +++ b/drivers/gpu/drm/vkms/vkms_drv.c
> > @@ -76,10 +76,10 @@ static void vkms_atomic_commit_tail(struct drm_atomic_state *old_state)
> >
> >         drm_atomic_helper_commit_modeset_disables(dev, old_state);
> >
> > -       drm_atomic_helper_commit_planes(dev, old_state, 0);
> > -
> >         drm_atomic_helper_commit_modeset_enables(dev, old_state);
> >
> > +       drm_atomic_helper_commit_planes(dev, old_state, 0);
> > +
> >         drm_atomic_helper_fake_vblank(old_state);
> >
> >         drm_atomic_helper_commit_hw_done(old_state);
> > --
> > 2.17.1
> >
> > --
> > You received this message because you are subscribed to the Google Groups "Kernel USP" group.
> > To unsubscribe from this group and stop receiving emails from it, send an email to kernel-usp+unsubscribe@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/msgid/kernel-usp/20200729152231.13249-1-realwakka%40gmail.com.

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
