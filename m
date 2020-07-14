Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A1D0C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 10:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CFD6208FE
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 10:20:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M/TjwCPg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbgGNKUY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 06:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbgGNKUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 06:20:23 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C645C061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 03:20:23 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id o8so4294464wmh.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 03:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=y0CNQ3bqIuBxaoxawaLZ1YMRPo5nby/OJxVr7m0q4bI=;
        b=M/TjwCPgMdKeqqRBt1Xu6V80CnP/cnPyreP8vxfWusRrg6eYWRRam1VotYANOkL1ze
         UhScpEkP2SZtgKwUYg1v7hb9nEHEnwuUJ/oMNU+4Wp2jwQ1Jbe59UvIIwKtoONtRKh4z
         GFCk6dmC3fChNr5MofMoSb9zuDvrM79QdANTW0gLLBC6/dmwKkaHZVQ9JfIy9Jo2awzK
         jOHnEnG2m6+yYzmITZfw5qQo1wSHXZS92hhQY1I3rSuF7CneQAJx9y9bZH9BNICZCsWH
         vuyJJlsvPaEZphvg2s5j6XNzy8g9ekck2q+FS8Qh5ByfgFeU4cpV7s5sLAcCA4uVhsK7
         a/1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=y0CNQ3bqIuBxaoxawaLZ1YMRPo5nby/OJxVr7m0q4bI=;
        b=QszDEIIBkqnLeSaW77b6FRuT3zmewzIpVPGyw43UENyzpjiw13WrLZVHDhNFpG44xI
         c7r8gCkOfpkvVn3gq4jnbEzy1bnLyGfC+XMMO8MBIJ7e/vVhe6C9t+V2o7KL70y7nCUI
         oY6d7PBSCFBnzKN6z5g6M14Drv/O/sVaq+XyF5r4L955d+Pl0yc7MhepaJWene7ODMeL
         6Y/IhM837GA7Ccf5IVkGtetrqDxdOEa0vI5Eo5eLn2NLsyBKmRQWqFkT/FHMIWpaReym
         WIi96wUMNyIHZCSbdpEQH2Ue2cXnLnFyVCy+ofnOFWdCZCIKDDfSvcoqPUZcKdHptB1b
         y29w==
X-Gm-Message-State: AOAM530RQnYi6Bylm6FItSjzz3kDx0jJW2NahtaIfCnyY7lgz0w/zxA4
        wRL8v7h5w+eGgQa9gshHlLY=
X-Google-Smtp-Source: ABdhPJwmKlHdj7gf8L+/6LzXH4k/pmDkL+V5h/uK0wx2J/tSKATiyhHRA+jlUv3OIgF794UocHwNzw==
X-Received: by 2002:a1c:9a02:: with SMTP id c2mr3860722wme.16.1594722022136;
        Tue, 14 Jul 2020 03:20:22 -0700 (PDT)
Received: from smtp.gmail.com (a95-92-181-29.cpe.netcabo.pt. [95.92.181.29])
        by smtp.gmail.com with ESMTPSA id 14sm3539549wmk.19.2020.07.14.03.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 03:20:21 -0700 (PDT)
Date:   Tue, 14 Jul 2020 07:20:09 -0300
From:   Melissa Wen <melissa.srw@gmail.com>
To:     Sidong Yang <realwakka@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/vkms: add wait_for_vblanks in atomic_commit_tail
Message-ID: <20200714102009.4qxgdq5bkpwhhhio@smtp.gmail.com>
References: <20200701153134.4187-1-realwakka@gmail.com>
 <20200702131355.GX3278063@phenom.ffwll.local>
 <20200710170533.xn2ar2cpekom6i2n@smtp.gmail.com>
 <20200713160621.GQ3278063@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200713160621.GQ3278063@phenom.ffwll.local>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/13, Daniel Vetter wrote:
> On Fri, Jul 10, 2020 at 02:05:33PM -0300, Melissa Wen wrote:
> > On 07/02, Daniel Vetter wrote:
> > > On Wed, Jul 01, 2020 at 03:31:34PM +0000, Sidong Yang wrote:
> > > > there is an error when igt test is run continuously. vkms_atomic_commit_tail()
> > > > need to call drm_atomic_helper_wait_for_vblanks() for give up ownership of
> > > > vblank events. without this code, next atomic commit will not enable vblank
> > > > and raise timeout error.
> > > > 
> > > > Signed-off-by: Sidong Yang <realwakka@gmail.com>
> > > > ---
> > > >  drivers/gpu/drm/vkms/vkms_drv.c | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > > > 
> > > > diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
> > > > index 1e8b2169d834..10b9be67a068 100644
> > > > --- a/drivers/gpu/drm/vkms/vkms_drv.c
> > > > +++ b/drivers/gpu/drm/vkms/vkms_drv.c
> > > > @@ -93,6 +93,8 @@ static void vkms_atomic_commit_tail(struct drm_atomic_state *old_state)
> > > >  		flush_work(&vkms_state->composer_work);
> > > >  	}
> > > >  
> > > > +	drm_atomic_helper_wait_for_vblanks(dev, old_state);
> > > 
> > > Uh, we have a wait_for_flip_done right above, which should be doing
> > > exactly the same, but more precisely: Instead of just waiting for any
> > > vblank to happen, we wait for exactly the vblank corresponding to this
> > > atomic commit. So no races possible. If this is papering over some issue,
> > > then I think more debugging is needed.
> > > 
> > > What exactly is going wrong here for you?
> > 
> > Hi Daniel and Sidong,
> > 
> > I noticed a similar issue when running the IGT test kms_cursor_crc. For
> > example, a subtest that passes on the first run (alpha-opaque) fails on
> > the second due to a kind of busy waiting in subtest preparation (the
> > subtest fails before actually running).
> > 
> > In addition, in the same test, the dpms subtest started to fail since
> > the commit that change from wait_for_vblanks to wait_for_flip_done. By
> > reverting this commit, the dpms subtest passes again and the sequential
> > subtests return to normal.
> > 
> > I am trying to figure out what's missing from using flip_done op on
> > vkms, since I am also interested in solving this problem and I
> > understand that the change for flip_done has been discussed in the past.
> > 
> > Do you have any idea?
> 
> Uh, not at all. This is indeed rather surprising ...
> 
> What exactly is the failure mode when running a test the 2nd time? Full
> igt logs might give me an idea. But yeah this is kinda surprising.

Hi Daniel,

This is the IGT log of the 2nd run of kms_cursor_crc/alpha-opaque:

IGT-Version: 1.25-NO-GIT (x86_64) (Linux: 5.8.0-rc2-DRM+ x86_64)
Force option used: Using driver vkms
Starting subtest: pipe-A-cursor-alpha-opaque
Timed out: Opening crc fd, and poll for first CRC.
Subtest pipe-A-cursor-alpha-opaque failed.
**** DEBUG ****
(kms_cursor_crc:2317) igt_kms-DEBUG: display: Virtual-1: set_pipe(A)
(kms_cursor_crc:2317) igt_kms-DEBUG: display: Virtual-1: Selecting pipe A
(kms_cursor_crc:2317) igt_fb-DEBUG: igt_create_fb_with_bo_size(width=1024, height=768, format=XR24(0x34325258), modifier=0x0, size=0)
(kms_cursor_crc:2317) igt_fb-DEBUG: igt_create_fb_with_bo_size(handle=1, pitch=4096)
(kms_cursor_crc:2317) igt_fb-DEBUG: Test requirement passed: cairo_surface_status(fb->cairo_surface) == CAIRO_STATUS_SUCCESS
(kms_cursor_crc:2317) igt_fb-DEBUG: igt_create_fb_with_bo_size(width=1024, height=768, format=XR24(0x34325258), modifier=0x0, size=0)
(kms_cursor_crc:2317) igt_fb-DEBUG: igt_create_fb_with_bo_size(handle=2, pitch=4096)
(kms_cursor_crc:2317) igt_fb-DEBUG: Test requirement passed: cairo_surface_status(fb->cairo_surface) == CAIRO_STATUS_SUCCESS
(kms_cursor_crc:2317) igt_kms-DEBUG: Test requirement passed: plane_idx >= 0 && plane_idx < pipe->n_planes
(kms_cursor_crc:2317) igt_kms-DEBUG: Test requirement passed: plane_idx >= 0 && plane_idx < pipe->n_planes
(kms_cursor_crc:2317) igt_kms-DEBUG: display: A.0: plane_set_fb(37)
(kms_cursor_crc:2317) igt_kms-DEBUG: display: A.0: plane_set_size (1024x768)
(kms_cursor_crc:2317) igt_kms-DEBUG: display: A.0: fb_set_position(0,0)
(kms_cursor_crc:2317) igt_kms-DEBUG: display: A.0: fb_set_size(1024x768)
(kms_cursor_crc:2317) igt_kms-DEBUG: display: commit {
(kms_cursor_crc:2317) igt_kms-DEBUG: display:     Virtual-1: SetCrtc pipe A, fb 37, src (0, 0), mode 1024x768
(kms_cursor_crc:2317) igt_kms-DEBUG: display:     SetCursor pipe A, disabling
(kms_cursor_crc:2317) igt_kms-DEBUG: display:     MoveCursor pipe A, (0, 0)
(kms_cursor_crc:2317) igt_kms-DEBUG: display: }
(kms_cursor_crc:2317) igt_debugfs-DEBUG: Opening debugfs directory '/sys/kernel/debug/dri/0'
(kms_cursor_crc:2317) igt_debugfs-DEBUG: Opening debugfs directory '/sys/kernel/debug/dri/0'
(kms_cursor_crc:2317) igt_debugfs-DEBUG: Opening debugfs directory '/sys/kernel/debug/dri/0'
(kms_cursor_crc:2317) igt_core-INFO: Timed out: Opening crc fd, and poll for first CRC.
****  END  ****
Subtest pipe-A-cursor-alpha-opaque: FAIL (10.017s)

---

What I found was a timeout in the poll of
igt_debugfs/igt_pipe_crc_start() that in turn is called in the
prepare_crc() of kms_cursor_crc.

Initially, I thought it was just a matter of timing for vblank and sent
a patch to IGT that solved the problem by calling igt_wait_for_vblank()
before the "start" op. But then I saw that the timeout also happens in a
similar way in the dpms subtest, which before the change to flip_done
was succeded.

I still have doubts if it is or not a matter of timing...

Thanks,

Melissa
> 
> Also happy to chat on irc for debugging ideas, that might be faster (I'm
> danvet on #dri-devel on freenode).
> -Daniel
> 
> > 
> > Melissa
> > 
> > > -Daniel
> > > 
> > > > +
> > > >  	drm_atomic_helper_cleanup_planes(dev, old_state);
> > > >  }
> > > >  
> > > > -- 
> > > > 2.17.1
> > > > 
> > > 
> > > -- 
> > > Daniel Vetter
> > > Software Engineer, Intel Corporation
> > > http://blog.ffwll.ch
> > > _______________________________________________
> > > dri-devel mailing list
> > > dri-devel@lists.freedesktop.org
> > > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 
> -- 
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch
