Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14E50C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B19A2076E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:59:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="CoAN2cMV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729433AbgHET71 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 15:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727912AbgHEQmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 12:42:12 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A86C061A26
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 04:27:00 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id f18so4190474wmc.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 04:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=KugqoLJzQdyt3zmwjJMiEIC+i2tGmRLU22ZaYueyJpA=;
        b=CoAN2cMV9Mezc4o+Zf4ohK6Y7/7mPE2t7h/mpIRlpS325019IpsFwHyPmJ0wK1S/Iv
         9dgdo/amrdxmaZ4R4HIlromCMiKvRPxwzTlKISMHdsLB+fTpRNZokce+4dm/toWgm7gI
         WG1xbbJUO/TYBb+hT9qhFdH6lD/owL+QLSdyE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=KugqoLJzQdyt3zmwjJMiEIC+i2tGmRLU22ZaYueyJpA=;
        b=cCKtAv1NxutWMTo3ivJG+PiKdrFETzaQCssbN5Ztad1B2/plDppBzULUGpMx9G/xJA
         5rCXp24E7HLY4BUgJD6UqvdoacqWhF8gIg5f1KnSY/6fqWqS5wOukCNg4SdEadSElHoT
         SIshMByplVuAa/bqhF/cYBDQmNTP4nnLGMARUPQozyNQenZmdOVptHSXSPPnMvmGBlFn
         5Bj/IBV6luEbh68TXtkOutleyTce1gAminhnVnC9DgbLKcNMPy8pXoZnofV549f2fquR
         PoC7Id3KIoJ1gIvs8F+CACT9w56tf7niMvw73wRpjgpDjcg63YxctDzHBSiJ70Fhb5Sx
         PnLQ==
X-Gm-Message-State: AOAM532efQdcNTCaZLKzAXjWvuK4BSMEM+jPtnls/W1SbDKPec5HC6dd
        93WnCJJ8OmxlCtfNphW7sx+glQ==
X-Google-Smtp-Source: ABdhPJwnF7KyPv1oaxnSYZ/S0cZMvDnGvur+ycQrH+6V/86KImifUzSQs518q3Bhu0RqapwN5ZnlNA==
X-Received: by 2002:a7b:ca5a:: with SMTP id m26mr2833383wml.27.1596626818763;
        Wed, 05 Aug 2020 04:26:58 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id p6sm2212467wru.33.2020.08.05.04.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 04:26:57 -0700 (PDT)
Date:   Wed, 5 Aug 2020 13:26:55 +0200
From:   daniel@ffwll.ch
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Tao Huang <huangtao@rock-chips.com>,
        Andy Yan <andy.yan@rock-chips.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Kever Yang <kever.yang@rock-chips.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm: sysfs: Add to get current mode
Message-ID: <20200805112655.GF6419@phenom.ffwll.local>
Mail-Followup-To: Huang Jiachai <hjc@rock-chips.com>,
        Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Tao Huang <huangtao@rock-chips.com>,
        Andy Yan <andy.yan@rock-chips.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Kever Yang <kever.yang@rock-chips.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20200805083646.4123-1-hjc@rock-chips.com>
 <CAKMK7uGmKJqZJ0ONQjjquZn6mksKbkScmcUSEA43eg1jFskmTg@mail.gmail.com>
 <693f6555-d9d2-f255-1198-e3798c8f4fe8@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <693f6555-d9d2-f255-1198-e3798c8f4fe8@rock-chips.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 05, 2020 at 06:03:15PM +0800, Huang Jiachai wrote:
> Hi Daniel
> 
> 在 2020/8/5 17:36, Daniel Vetter 写道:
> > On Wed, Aug 5, 2020 at 10:37 AM Sandy Huang <hjc@rock-chips.com> wrote:
> > > add this node to get the current true mode.
> > > 
> > > Signed-off-by: Sandy Huang <hjc@rock-chips.com>
> > Uh what's this for? Since it's sysfs, I guess there's something
> > parsing this, which means we'd kinda need to have that piece too.
> > 
> > If it's just for debugging purposes, then we already have this
> > information in debugfs, together with everything else that's in the
> > atomic modeset state.
> > -Daniel
> 
> yes, this is just for debug;
> 
> and i get the information what i need from cat
> /sys/kernel/debug/dri/0/state, thanks.

Cool, sounds like this is resolved. And if you need any additional debug
information about display state, then best to extend that file. It comes
with driver hooks, so that you can include any additional driver stuff, or
outright read out registers and everything.

Cheers, Daniel

> 
> > > ---
> > >   drivers/gpu/drm/drm_sysfs.c | 30 ++++++++++++++++++++++++++++++
> > >   1 file changed, 30 insertions(+)
> > > 
> > > diff --git a/drivers/gpu/drm/drm_sysfs.c b/drivers/gpu/drm/drm_sysfs.c
> > > index 939f0032aab1..f39bcd34853b 100644
> > > --- a/drivers/gpu/drm/drm_sysfs.c
> > > +++ b/drivers/gpu/drm/drm_sysfs.c
> > > @@ -19,6 +19,7 @@
> > >   #include <linux/slab.h>
> > > 
> > >   #include <drm/drm_connector.h>
> > > +#include <drm/drm_crtc.h>
> > >   #include <drm/drm_device.h>
> > >   #include <drm/drm_file.h>
> > >   #include <drm/drm_modes.h>
> > > @@ -236,16 +237,45 @@ static ssize_t modes_show(struct device *device,
> > >          return written;
> > >   }
> > > 
> > > +static ssize_t current_mode_show(struct device *device,
> > > +                     struct device_attribute *attr,
> > > +                     char *buf)
> > > +{
> > > +       struct drm_connector *connector = to_drm_connector(device);
> > > +       struct drm_display_mode *mode;
> > > +       struct drm_crtc_state *crtc_state;
> > > +       bool interlaced;
> > > +       int written = 0;
> > > +
> > > +       if (!connector->state || !connector->state->crtc)
> > > +               return written;
> > > +
> > > +       crtc_state = connector->state->crtc->state;
> > > +       if (!crtc_state)
> > > +               return written;
> > > +
> > > +       mode = &crtc_state->mode;
> > > +
> > > +       interlaced = !!(mode->flags & DRM_MODE_FLAG_INTERLACE);
> > > +       written += snprintf(buf + written, PAGE_SIZE - written, "%dx%d%s%d\n",
> > > +                           mode->hdisplay, mode->vdisplay,
> > > +                           interlaced ? "i" : "p", drm_mode_vrefresh(mode));
> > > +
> > > +       return written;
> > > +}
> > > +
> > >   static DEVICE_ATTR_RW(status);
> > >   static DEVICE_ATTR_RO(enabled);
> > >   static DEVICE_ATTR_RO(dpms);
> > >   static DEVICE_ATTR_RO(modes);
> > > +static DEVICE_ATTR_RO(current_mode);
> > > 
> > >   static struct attribute *connector_dev_attrs[] = {
> > >          &dev_attr_status.attr,
> > >          &dev_attr_enabled.attr,
> > >          &dev_attr_dpms.attr,
> > >          &dev_attr_modes.attr,
> > > +       &dev_attr_current_mode.attr,
> > >          NULL
> > >   };
> > > 
> > > --
> > > 2.17.1
> > > 
> > > 
> > > 
> > 
> -- 
> Best Regard
> 
> 黄家钗
> Sandy Huang
> Addr: 福州市鼓楼区铜盘路软件大道89号福州软件园A区21号楼(350003)
>       No. 21 Building, A District, No.89,software Boulevard Fuzhou,Fujian,PRC
> Tel：+86 0591-87884919  8690
> E-mail：hjc@rock-chips.com
> 
> 
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
