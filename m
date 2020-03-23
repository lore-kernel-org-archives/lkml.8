Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36C02C54FCE
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 15:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BEC620714
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 15:38:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="dEun6e07"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbgCWPh7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 11:37:59 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34669 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727124AbgCWPh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 11:37:59 -0400
Received: by mail-wm1-f65.google.com with SMTP id 26so313689wmk.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 08:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=N3Q+qAIc552rJD7ZSPM4p2mnFuNM9e12XzMy9h14WCY=;
        b=dEun6e07weqIPfvGZLW2lxQWBnRjAcTPfpJcwnj6VLcaSCQ8E/PNj4jIiO18ld/bFx
         fp/HLKk5uUVLbdTUICIzqevbrLkIs69s93OpFV+2cB7tICCsHRp4sKldvYa+2v7L++O3
         g0PxvKzquB+EPBCoSM3kjpryRp4UairYjg5Qs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=N3Q+qAIc552rJD7ZSPM4p2mnFuNM9e12XzMy9h14WCY=;
        b=TExBG+BzGhCaGdsMZLMIOr8XpfdNO2xolEcM6l+CRAJc0EuRKnTl+6lukTsG0RPqwU
         7S3EmDqKxaugBDROwj5Rs9K7KWJslgvN3hXALmlrAaLgBk3N8yZwEyHa//i39jb5D1gG
         xYi6AnGfd5uniIWngNN5OqdmrruUqCjGBVAEbheNGC5joQpujmx9/B5hdDO+8GTgQ8Mk
         cG7/oQ2JopDSizntnAsbPkbIJgP6mAWWuTV7De7d7ffLhAe+hdNxrvaxZdf1j+z6OWt8
         jPwnz1zcE+CIXMbh2tOi79cb9lm/idh6IPgP9KDw2AorCNttkMNaN6Qz6xar6a2E607O
         15GQ==
X-Gm-Message-State: ANhLgQ3fnHpxaDZ6Xi/N57n4rFg6dPhmtuP9YN/pQkquNKRP9MR01AK8
        Ho6DlrL5dIHJ2cDTqOBgI5cNuQ==
X-Google-Smtp-Source: ADFU+vvGd1MKe/OvLt2X47KYngeTnpKSj43dHgfDxQAUMDIBGIJ3JQimSSVq6szxlHUK+ouaNN/xLQ==
X-Received: by 2002:a7b:c194:: with SMTP id y20mr11877864wmi.163.1584977877362;
        Mon, 23 Mar 2020 08:37:57 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id k3sm3322699wro.39.2020.03.23.08.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 08:37:55 -0700 (PDT)
Date:   Mon, 23 Mar 2020 16:37:52 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Wambui Karuga <wambui.karugax@gmail.com>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/vram-helper: remove unneeded #if defined/endif
 guards.
Message-ID: <20200323153752.GK2363188@phenom.ffwll.local>
Mail-Followup-To: Greg KH <gregkh@linuxfoundation.org>,
        Wambui Karuga <wambui.karugax@gmail.com>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20200323112802.228214-1-wambui.karugax@gmail.com>
 <20200323113726.GA663867@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200323113726.GA663867@kroah.com>
X-Operating-System: Linux phenom 5.3.0-3-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 23, 2020 at 12:37:26PM +0100, Greg KH wrote:
> On Mon, Mar 23, 2020 at 02:28:02PM +0300, Wambui Karuga wrote:
> > Remove unneeded #if/#endif guards for checking whether the
> > CONFIG_DEBUG_FS option is set or not. If the option is not set, the
> > compiler optimizes the functions making the guards
> > unnecessary.
> > 
> > Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>

Applied, thanks a lot.
-Daniel

> > ---
> >  drivers/gpu/drm/drm_gem_vram_helper.c | 4 ----
> >  1 file changed, 4 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/drm_gem_vram_helper.c b/drivers/gpu/drm/drm_gem_vram_helper.c
> > index 76506bedac11..b3201a70cbfc 100644
> > --- a/drivers/gpu/drm/drm_gem_vram_helper.c
> > +++ b/drivers/gpu/drm/drm_gem_vram_helper.c
> > @@ -1018,7 +1018,6 @@ static struct ttm_bo_driver bo_driver = {
> >   * struct drm_vram_mm
> >   */
> >  
> > -#if defined(CONFIG_DEBUG_FS)
> >  static int drm_vram_mm_debugfs(struct seq_file *m, void *data)
> >  {
> >  	struct drm_info_node *node = (struct drm_info_node *) m->private;
> > @@ -1035,7 +1034,6 @@ static int drm_vram_mm_debugfs(struct seq_file *m, void *data)
> >  static const struct drm_info_list drm_vram_mm_debugfs_list[] = {
> >  	{ "vram-mm", drm_vram_mm_debugfs, 0, NULL },
> >  };
> > -#endif
> >  
> >  /**
> >   * drm_vram_mm_debugfs_init() - Register VRAM MM debugfs file.
> > @@ -1045,11 +1043,9 @@ static const struct drm_info_list drm_vram_mm_debugfs_list[] = {
> >   */
> >  void drm_vram_mm_debugfs_init(struct drm_minor *minor)
> >  {
> > -#if defined(CONFIG_DEBUG_FS)
> >  	drm_debugfs_create_files(drm_vram_mm_debugfs_list,
> >  				 ARRAY_SIZE(drm_vram_mm_debugfs_list),
> >  				 minor->debugfs_root, minor);
> > -#endif
> >  }
> >  EXPORT_SYMBOL(drm_vram_mm_debugfs_init);
> >  
> > -- 
> > 2.25.1
> 
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
