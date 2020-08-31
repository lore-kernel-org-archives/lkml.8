Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35828C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 13:39:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D71220866
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 13:39:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ulyPKe7h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbgHaNjR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 09:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbgHaNjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 09:39:09 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F83C061573
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 06:39:08 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id h12so605067pgm.7
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 06:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kBIx7FcbMM1t3uG1zvrmHZlG3XrQ9BDEQ6YDhG9R5jo=;
        b=ulyPKe7hsfCv7vGuf4GZjBv3JdbiSnDFtZRhoE1JCXhD51IM3GnUEUOviZnSGujp0U
         cetpSeeRNMzLcfWAXN7q/Zq918qpPuXWnaDTfoVC+UFnNPjGj9+aO4CxlYM/rylStv3v
         OEaLWBoXFuxqAcz5qorfbTj5a9z8eFiKaDvZLxLn1EX3hzpWC1LPtbKI3OjvcHrKsD6j
         eGNrKgi46Y+Hs/6HYCCiytsahM60uHkan05SbLnNLq/rh4ByFGrmGQsN48l1TStaYiLh
         zZ3HRYnvio+EHyaRVOOLXIv0MBquM67C9kKCzUFSMkloRT7o/eymsZwMNSubz8SmKuW+
         YwNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kBIx7FcbMM1t3uG1zvrmHZlG3XrQ9BDEQ6YDhG9R5jo=;
        b=QjCJh0AouOJlgvhANbch2BAXqUDgM8ytxcje0Zju+0toFDF5l2tZJZjPq6GHhNIZpv
         RWInN8F65gBwbmVWhRtOZBt89vLgFHBNwRkoBGeP6MTiPCBwk5yfZ0Pks778M9gfrK/G
         X/M74yYwbike7SyGaYY2zcA1AHPYR1QFcFfj1d9swxh2JlHCBYVe8UtFHOtxtHCirlxf
         1guSF5FWW4Wre7bAvw3ewYsOa+97y378spBYgJrMmZhV4EtnKXqy8+5IyaYTuxfkD/os
         kOyMERtbdUdaNLZ3sZvH+Y9HbVM2B6LLPqe8UBi1sxHhe7IEWXIFBF2EFi7O5lnIUn82
         OAzQ==
X-Gm-Message-State: AOAM5331uIFcBbIktQ66Y9+KSOHI0IB8A5dCnrL1TNd1gmJpqwEUrCDs
        wbXVZ2zuyC6ubuKeVzfupC0JSMQv/+f9NQ==
X-Google-Smtp-Source: ABdhPJzIAQxzBjxsLTwl35Dy79erM0keXcL3kWzXwYd+S4wNrrBm+BEMLAtjX8K7mWRL5Jt98yApww==
X-Received: by 2002:a63:c551:: with SMTP id g17mr1219918pgd.399.1598881148355;
        Mon, 31 Aug 2020 06:39:08 -0700 (PDT)
Received: from realwakka ([61.83.141.80])
        by smtp.gmail.com with ESMTPSA id w3sm8307421pff.56.2020.08.31.06.39.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 31 Aug 2020 06:39:07 -0700 (PDT)
Date:   Mon, 31 Aug 2020 13:38:58 +0000
From:   Sidong Yang <realwakka@gmail.com>
To:     Simon Ser <contact@emersion.fr>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Melissa Wen <melissa.srw@gmail.com>
Subject: Re: [PATCH] drm/vkms: add support for gamma_set interface
Message-ID: <20200831133858.GA9280@realwakka>
References: <20200829140647.7626-1-realwakka@gmail.com>
 <UeJwFKvmNgKdZY_icN0-nrFly9R1vbzaMZ-TiyxIIPBcdl278uZsK6YdTTdRl6rFukBAmN-eyCFpnfsIB-El9QpyYiutdcpgJg64n4tsRRc=@emersion.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <UeJwFKvmNgKdZY_icN0-nrFly9R1vbzaMZ-TiyxIIPBcdl278uZsK6YdTTdRl6rFukBAmN-eyCFpnfsIB-El9QpyYiutdcpgJg64n4tsRRc=@emersion.fr>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 31, 2020 at 11:39:10AM +0000, Simon Ser wrote:
> On Saturday, August 29, 2020 4:06 PM, Sidong Yang <realwakka@gmail.com> wrote:
> 
> > Currently vkms module doesn't support gamma function for userspace. so igt
> > subtests in kms_plane(pixel-format-pipe-A-plan) failed for calling
> > drmModeCrtcSetGamma().
> 

Hi, Simon.
Thanks for review.

> It doesn't seem like this IGT test's goal is to exercise support for
> gamma LUTs. Does the test just tries to reset the gamma LUT to linear?
> If so, I think the IGT test should be fixed to ignore "I don't support
> gamma" errors.

It seems like that IGT test pixel-format is to make gamma lut like below.

for (i = 0; i < lut_size; i++)
	lut[i] = (i * 0xffff / (lut_size - 1)) & mask;

And set this table to drm driver. and test begins. It's the test about pixel 
format. I think you're right. It's not about gamma lut.
> 
> > This patch set gamma_set interface in vkms_crtc_funcs for
> > support gamma function. With initializing crtc, added calls for setting gamma
> > size. it pass the test after this patch.
> >
> > Cc: Daniel Vetter<daniel@ffwll.ch>
> > Cc: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> > Cc: Haneen Mohammed <hamohammed.sa@gmail.com>
> >
> > Signed-off-by: Sidong Yang <realwakka@gmail.com>
> > ---
> >  drivers/gpu/drm/vkms/vkms_crtc.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms_crtc.c
> > index ac85e17428f8..643435fb2ee6 100644
> > --- a/drivers/gpu/drm/vkms/vkms_crtc.c
> > +++ b/drivers/gpu/drm/vkms/vkms_crtc.c
> > @@ -160,6 +160,7 @@ static const struct drm_crtc_funcs vkms_crtc_funcs = {
> >  	.get_crc_sources	= vkms_get_crc_sources,
> >  	.set_crc_source		= vkms_set_crc_source,
> >  	.verify_crc_source	= vkms_verify_crc_source,
> > +	.gamma_set		= drm_atomic_helper_legacy_gamma_set,
> 
> Why does VKMS need to use a legacy helper?

drm_crtc_enable_color_mgmt() enables properties about gamma/degamma lut. And 
legacy helper just saves lut data from userspace to drm property blob. It seems 
that it's convenient way to implement .gamma_set.

> It seems like this patch just advertises support for gamma LUTs, but
> ignores any value set by user-space. If VKMS advertises support for
> gamma LUTs, it needs to take the LUT into account when blending planes.

Yes, This patch doesn't use gamma lut passed by user. lut should be used for 
calculating pixel value. For vkms, Maybe lut will be used in making crc value?
If so, I'll try to write next patch for it.

Thanks,
-Sidong

> 
> >  };
> >
> >  static int vkms_crtc_atomic_check(struct drm_crtc *crtc,
> > @@ -275,6 +276,13 @@ int vkms_crtc_init(struct drm_device *dev, struct drm_crtc *crtc,
> >  		return ret;
> >  	}
> >
> > +	ret = drm_mode_crtc_set_gamma_size(crtc, 256);
> > +	if (ret) {
> > +		DRM_ERROR("Failed to set gamma size\n");
> > +		return ret;
> > +	}
> > +	drm_crtc_enable_color_mgmt(crtc, 0, false, 256);
> > +
> >  	drm_crtc_helper_add(crtc, &vkms_crtc_helper_funcs);
> >
> >  	spin_lock_init(&vkms_out->lock);
> > --
> > 2.17.1
> 
