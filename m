Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4333EC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 18:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18F3B206F6
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 18:18:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y/T4KpRY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730869AbgEVSSc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 14:18:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52029 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726373AbgEVSSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 14:18:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590171509;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m/geKcYtEm6APQ5LEp/KOQcykz/wDN18PTkCVCHlSm8=;
        b=Y/T4KpRYUlP7KuBDjm5nVEG6x8I/I4EOZObbN0dEw4l9/Q62a2Y+M8jKTX/kx4zfLe+qZo
        O/Ecn7QYuY54qePkcf6vTAPVz5a2JA1yFxoDdW9sJGBAMtePjLBfPVy5DFF4vR+YkR6XwG
        /FJKeUdMALyM/6LI3lNu0Th2OTjb8ps=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-158-ICFmdUvZOSWzvJxQDKLV9w-1; Fri, 22 May 2020 14:18:24 -0400
X-MC-Unique: ICFmdUvZOSWzvJxQDKLV9w-1
Received: by mail-qk1-f197.google.com with SMTP id j83so11914736qke.10
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 11:18:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:cc:date
         :in-reply-to:references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=m/geKcYtEm6APQ5LEp/KOQcykz/wDN18PTkCVCHlSm8=;
        b=dpt9SEHCE3DDjjfkUFpgWCeM7ImoqlAAZhrOG+33ZSujmdiHgysKCyNxL4cR6etV7Y
         vr+biQFCVFX1AYIOf7AbPexcI4cEa6l+4rkFXHHKy3HdYrAHZOx/WBE4DHObouEGLtkG
         4FNt1aEdzdyexBTEYd3oTOrQBSGKeMPMAyWiraT6JyY8qvR8hSeLCP4mOgaasDLCs31X
         jIYNaTR4AYvc7f3q+NmcfimjE5fAZx3jEXRdYuCTlYgI+IgnI8fBEDhzub43S334KYLc
         AhCAXlGmUtyOX+qzrBedz0pkJL9XX4l354HwPZ9VfWoe6EnCTwXqjJH2tEPoqMEqqNke
         AeIg==
X-Gm-Message-State: AOAM532pYgTd4OUyvYBoZpDqJ5GDkdtnxPLVim8U3cPvqmtEsYEcSbRE
        E3FXapoUIxOzUiye82ywzJdqmNqh9f1OhR4+sUqpr+JqaE7bsHDJqvpe03KH1e5AxaIgRDDARwk
        48iA/Nquf9b6OFwJsPpKuKvht
X-Received: by 2002:a37:8705:: with SMTP id j5mr14768893qkd.233.1590171503878;
        Fri, 22 May 2020 11:18:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzHR3ERTZmvM/CSJPNLHMaIrwwjp4k68hXtLxCPVvFuYCfjYWDQPH4SgEGssR0Gdrz1RwJcHQ==
X-Received: by 2002:a37:8705:: with SMTP id j5mr14768875qkd.233.1590171503633;
        Fri, 22 May 2020 11:18:23 -0700 (PDT)
Received: from Whitewolf.lyude.net (static-173-76-190-23.bstnma.ftas.verizon.net. [173.76.190.23])
        by smtp.gmail.com with ESMTPSA id x144sm8508643qka.53.2020.05.22.11.18.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 11:18:22 -0700 (PDT)
Message-ID: <7db8ff3ee32bddfb6f82760468caa86388bee9bd.camel@redhat.com>
Subject: Re: [PATCH] drm/vblank: Fix -Wformat compile warnings on some arches
From:   Lyude Paul <lyude@redhat.com>
Reply-To: lyude@redhat.com
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        Dave Airlie <airlied@redhat.com>
Date:   Fri, 22 May 2020 14:18:21 -0400
In-Reply-To: <20200521210924.GA1056842@ravnborg.org>
References: <20200521204647.2578479-1-lyude@redhat.com>
         <20200521210924.GA1056842@ravnborg.org>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2 (3.36.2-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-05-21 at 23:09 +0200, Sam Ravnborg wrote:
> On Thu, May 21, 2020 at 04:46:47PM -0400, Lyude Paul wrote:
> > On some architectures like ppc64le and aarch64, compiling with
> > -Wformat=1 will throw the following warnings:
> > 
> >   In file included from drivers/gpu/drm/drm_vblank.c:33:
> >   drivers/gpu/drm/drm_vblank.c: In function 'drm_update_vblank_count':
> >   drivers/gpu/drm/drm_vblank.c:273:16: warning: format '%llu' expects
> >   argument of type 'long long unsigned int', but argument 4 has type
> >   'long int' [-Wformat=]
> >     DRM_DEBUG_VBL("updating vblank count on crtc %u:"
> >                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >   ./include/drm/drm_print.h:407:22: note: in definition of macro
> >   'DRM_DEBUG_VBL'
> >     drm_dbg(DRM_UT_VBL, fmt, ##__VA_ARGS__)
> >                         ^~~
> >   drivers/gpu/drm/drm_vblank.c:274:22: note: format string is defined here
> >            " current=%llu, diff=%u, hw=%u hw_last=%u\n",
> >                      ~~~^
> >                      %lu
> > 
> > So, fix that with a typecast.
> > 
> > Signed-off-by: Lyude Paul <lyude@redhat.com>
> > Co-developed-by: Dave Airlie <airlied@redhat.com>
> > ---
> >  drivers/gpu/drm/drm_vblank.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
> > index acb3c3f65b579..1a96db2dd16fa 100644
> > --- a/drivers/gpu/drm/drm_vblank.c
> > +++ b/drivers/gpu/drm/drm_vblank.c
> > @@ -342,7 +342,7 @@ static void drm_update_vblank_count(struct drm_device
> > *dev, unsigned int pipe,
> >  
> >  	DRM_DEBUG_VBL("updating vblank count on crtc %u:"
> >  		      " current=%llu, diff=%u, hw=%u hw_last=%u\n",
> > -		      pipe, atomic64_read(&vblank->count), diff,
> > +		      pipe, (unsigned long long)atomic64_read(&vblank->count),
> > diff,
> >  		      cur_vblank, vblank->last);
> 
> While touching this you could consider introducing drm_dbg_vbl().
> An maybe as a follow-up patch replace all logging in this file with the drm_*
> variants.

ok - no promises when I can actually get to this though, I've got a lot on my
plate ATM
> 
> 	Sam
> 
> >  
> >  	if (diff == 0) {
> > -- 
> > 2.26.2
> > 
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel

