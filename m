Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23560C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 17:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE71120657
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 17:05:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SGZ+JtJl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728478AbgGJRFl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 13:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbgGJRFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 13:05:41 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3136CC08C5DC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 10:05:41 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id j4so6675428wrp.10
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 10:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=93AVI2QoBAEmAqBGfFTWCA/a6MgEBTx5yqqj7c1xOd0=;
        b=SGZ+JtJlaFBv11yuKiq6semZUeibR6h4e8fA7pdOBGjb3+J8yqRTJFURAMksjcK6+n
         urnCtDBpZiZynCbSW1OcKUoM6jK13muadzTTFvzTbPdsQ6B8K2HdnHEj6hrSHXQ0HpjG
         mQt1ZepaXEMarLUXc2AHGSobIMLA8g1rWJPFwJ+P2Ewfz4T4nOne8l0ELVg1d/dYDxJt
         jyA/2a7q/rDSyiMayTWHMnxli1uUqXdmhiU69K9D1o3+pxkRRw0DJYhfF2XU7UrEqfhu
         naiLeqa8fkDsXD4Of9roNMA7a7i/wj5h71jyDCLK+s8uEXafKl4ZrdgF3jpykmyXQtlu
         PiFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=93AVI2QoBAEmAqBGfFTWCA/a6MgEBTx5yqqj7c1xOd0=;
        b=cVXu7jRHQTqmCtM1xAx4mDc5p2n0IKDlvwJ8ueI2gqHMOJfjZ0mHv2NbbufjdwXa0c
         TfbfuEoBWoX5pYDWXM/WlXRNBBlna+0acl8p9yGaov9IL1TTFei9E09MNUs7uw4cvWTv
         5y4uuvKO4FY5qMOiusKdZNaLKuoMMD8JjQdNJU4dLN/5TxyW8kzG/Fw+slcfunEOdSZj
         rcy3HA6VgpMdhn3tY0RqsRPf1bk+euVCfXJmd72+rzSctq93j4iE371L5riXVOHXlEy2
         G1KkqMa8YUQVAhnETOTUdILAu6ievU2igkDNxYusraGtEjav49gJ4/R/yi9ta3GqWRkY
         +oXA==
X-Gm-Message-State: AOAM533GtjlReGVF6BX1pyK5nDXFopokb6Si1vY9nuZmi8LEzYu5nHb3
        Y1FvPXPU50Pk6mGwTRxslC5tLp1OpEw=
X-Google-Smtp-Source: ABdhPJx1UxxkLEdprdW3mDWVo+KqPIchfniOsIMY3EYh0jN3bRqGm0+KSSjajUGLHSDx1ePvHdanQQ==
X-Received: by 2002:adf:f608:: with SMTP id t8mr70444597wrp.308.1594400739927;
        Fri, 10 Jul 2020 10:05:39 -0700 (PDT)
Received: from smtp.gmail.com (a95-92-181-29.cpe.netcabo.pt. [95.92.181.29])
        by smtp.gmail.com with ESMTPSA id o29sm11825132wra.5.2020.07.10.10.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 10:05:39 -0700 (PDT)
Date:   Fri, 10 Jul 2020 14:05:33 -0300
From:   Melissa Wen <melissa.srw@gmail.com>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Sidong Yang <realwakka@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/vkms: add wait_for_vblanks in atomic_commit_tail
Message-ID: <20200710170533.xn2ar2cpekom6i2n@smtp.gmail.com>
References: <20200701153134.4187-1-realwakka@gmail.com>
 <20200702131355.GX3278063@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702131355.GX3278063@phenom.ffwll.local>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02, Daniel Vetter wrote:
> On Wed, Jul 01, 2020 at 03:31:34PM +0000, Sidong Yang wrote:
> > there is an error when igt test is run continuously. vkms_atomic_commit_tail()
> > need to call drm_atomic_helper_wait_for_vblanks() for give up ownership of
> > vblank events. without this code, next atomic commit will not enable vblank
> > and raise timeout error.
> > 
> > Signed-off-by: Sidong Yang <realwakka@gmail.com>
> > ---
> >  drivers/gpu/drm/vkms/vkms_drv.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
> > index 1e8b2169d834..10b9be67a068 100644
> > --- a/drivers/gpu/drm/vkms/vkms_drv.c
> > +++ b/drivers/gpu/drm/vkms/vkms_drv.c
> > @@ -93,6 +93,8 @@ static void vkms_atomic_commit_tail(struct drm_atomic_state *old_state)
> >  		flush_work(&vkms_state->composer_work);
> >  	}
> >  
> > +	drm_atomic_helper_wait_for_vblanks(dev, old_state);
> 
> Uh, we have a wait_for_flip_done right above, which should be doing
> exactly the same, but more precisely: Instead of just waiting for any
> vblank to happen, we wait for exactly the vblank corresponding to this
> atomic commit. So no races possible. If this is papering over some issue,
> then I think more debugging is needed.
> 
> What exactly is going wrong here for you?

Hi Daniel and Sidong,

I noticed a similar issue when running the IGT test kms_cursor_crc. For
example, a subtest that passes on the first run (alpha-opaque) fails on
the second due to a kind of busy waiting in subtest preparation (the
subtest fails before actually running).

In addition, in the same test, the dpms subtest started to fail since
the commit that change from wait_for_vblanks to wait_for_flip_done. By
reverting this commit, the dpms subtest passes again and the sequential
subtests return to normal.

I am trying to figure out what's missing from using flip_done op on
vkms, since I am also interested in solving this problem and I
understand that the change for flip_done has been discussed in the past.

Do you have any idea?

Melissa

> -Daniel
> 
> > +
> >  	drm_atomic_helper_cleanup_planes(dev, old_state);
> >  }
> >  
> > -- 
> > 2.17.1
> > 
> 
> -- 
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
