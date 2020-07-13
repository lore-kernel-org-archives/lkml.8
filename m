Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D596AC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 16:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1871206F0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 16:06:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="KKAGfH6p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730033AbgGMQG1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 12:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729027AbgGMQG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 12:06:26 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7A2C061755
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 09:06:25 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id j4so17124942wrp.10
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 09:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=5Rz3k8xfkL0FMNwHmJJTUxCZdJf58RRiYrG6rM5Yiek=;
        b=KKAGfH6p/LWgpuJCAIOkZHA1vspGCZMrnWxjJJTuab88ZnDyZ7m/uIL23A+/Nt00Gx
         +hb5xlS1YNrLtW+xyjepv+tuG7AWfEWDgCXbnfwFxtEicywKoJZVO5m5gT3niJMoRLmC
         p01iK/cfScpMyBckAqE8UovUlvP+6hTLXVrNk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=5Rz3k8xfkL0FMNwHmJJTUxCZdJf58RRiYrG6rM5Yiek=;
        b=RGaLTLIgUop0nbS8jcTnyJznGRe2TW0R6nsphgd/W81ZT0dYTZDIHGt3B2A45OruS3
         0Gk+BVkHH2qqvUMPkGzlOfKxgjm9Xk3NZjCz7yySk0ems8p58QFQl5wvz0YZVUVFcGx5
         DjKy6nqJG/SVLHsvysRSQJFvgQREMFiD8vYYSJrHsXbhZ5l2kYIl86tVpFHeltA3mDbs
         YqNFrXE65u2GEuFm7Yp0KIhTBrNmSZ9EcAcrIifkF3retmne7Abc+3KQszXYVj4hQyFY
         E1usHZLZRxK8vS7x2K3edwv+Jb29kx+VVTF1GddYU9HqjPH81MRNfBxoo39liDKVTWoG
         laOw==
X-Gm-Message-State: AOAM5338+FH+kTSp0+q+EE2DNW2xmnsuC6TxiEMoG9NJ7C7/NfjXyowe
        4lR6vYES2Od0aGHdbf9bJPAJVQ==
X-Google-Smtp-Source: ABdhPJzUPIXjT4HRFL9Ye+YC11COAKOTD5o0UW7SkSLGgcRUoA8itDDxp9cysn17q2KFM2dgvtZ2lQ==
X-Received: by 2002:adf:ed4f:: with SMTP id u15mr55226wro.318.1594656384637;
        Mon, 13 Jul 2020 09:06:24 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id x1sm23724641wrp.10.2020.07.13.09.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 09:06:23 -0700 (PDT)
Date:   Mon, 13 Jul 2020 18:06:21 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Melissa Wen <melissa.srw@gmail.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, Sidong Yang <realwakka@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/vkms: add wait_for_vblanks in atomic_commit_tail
Message-ID: <20200713160621.GQ3278063@phenom.ffwll.local>
Mail-Followup-To: Melissa Wen <melissa.srw@gmail.com>,
        Sidong Yang <realwakka@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20200701153134.4187-1-realwakka@gmail.com>
 <20200702131355.GX3278063@phenom.ffwll.local>
 <20200710170533.xn2ar2cpekom6i2n@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710170533.xn2ar2cpekom6i2n@smtp.gmail.com>
X-Operating-System: Linux phenom 5.6.0-1-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 02:05:33PM -0300, Melissa Wen wrote:
> On 07/02, Daniel Vetter wrote:
> > On Wed, Jul 01, 2020 at 03:31:34PM +0000, Sidong Yang wrote:
> > > there is an error when igt test is run continuously. vkms_atomic_commit_tail()
> > > need to call drm_atomic_helper_wait_for_vblanks() for give up ownership of
> > > vblank events. without this code, next atomic commit will not enable vblank
> > > and raise timeout error.
> > > 
> > > Signed-off-by: Sidong Yang <realwakka@gmail.com>
> > > ---
> > >  drivers/gpu/drm/vkms/vkms_drv.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
> > > index 1e8b2169d834..10b9be67a068 100644
> > > --- a/drivers/gpu/drm/vkms/vkms_drv.c
> > > +++ b/drivers/gpu/drm/vkms/vkms_drv.c
> > > @@ -93,6 +93,8 @@ static void vkms_atomic_commit_tail(struct drm_atomic_state *old_state)
> > >  		flush_work(&vkms_state->composer_work);
> > >  	}
> > >  
> > > +	drm_atomic_helper_wait_for_vblanks(dev, old_state);
> > 
> > Uh, we have a wait_for_flip_done right above, which should be doing
> > exactly the same, but more precisely: Instead of just waiting for any
> > vblank to happen, we wait for exactly the vblank corresponding to this
> > atomic commit. So no races possible. If this is papering over some issue,
> > then I think more debugging is needed.
> > 
> > What exactly is going wrong here for you?
> 
> Hi Daniel and Sidong,
> 
> I noticed a similar issue when running the IGT test kms_cursor_crc. For
> example, a subtest that passes on the first run (alpha-opaque) fails on
> the second due to a kind of busy waiting in subtest preparation (the
> subtest fails before actually running).
> 
> In addition, in the same test, the dpms subtest started to fail since
> the commit that change from wait_for_vblanks to wait_for_flip_done. By
> reverting this commit, the dpms subtest passes again and the sequential
> subtests return to normal.
> 
> I am trying to figure out what's missing from using flip_done op on
> vkms, since I am also interested in solving this problem and I
> understand that the change for flip_done has been discussed in the past.
> 
> Do you have any idea?

Uh, not at all. This is indeed rather surprising ...

What exactly is the failure mode when running a test the 2nd time? Full
igt logs might give me an idea. But yeah this is kinda surprising.

Also happy to chat on irc for debugging ideas, that might be faster (I'm
danvet on #dri-devel on freenode).
-Daniel

> 
> Melissa
> 
> > -Daniel
> > 
> > > +
> > >  	drm_atomic_helper_cleanup_planes(dev, old_state);
> > >  }
> > >  
> > > -- 
> > > 2.17.1
> > > 
> > 
> > -- 
> > Daniel Vetter
> > Software Engineer, Intel Corporation
> > http://blog.ffwll.ch
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
