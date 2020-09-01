Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E4F3C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 07:46:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34FCB2068E
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 07:46:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="NZBA6I4v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbgIAHqr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 03:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgIAHqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 03:46:43 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B4C6C061244
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 00:46:42 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id c18so342204wrm.9
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 00:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=PwQyVWZl+pjxYNMWlO8oMdi7CeKbQA1YxnOGda70p8o=;
        b=NZBA6I4vsaC4evG0xqeywNYAPVsFAA8nLITRO9maS80cuyhhhQ7vEPrnEHsZt1J9Q9
         Sd9EfZ+RaTWDZQEXDd7QTz3tqQm+F9rWLI5Cux5hj/YF6jUiBb/NI8hUfSbKl94N60hA
         R8NaFaIff/RdhvsRy7bQ3QRUO7UPcKehcQ0hk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=PwQyVWZl+pjxYNMWlO8oMdi7CeKbQA1YxnOGda70p8o=;
        b=E3SiWRcn5Z6KL67Dwx+dkGdTp/ALTHprdZq0d4BuH3nMlcrUAmrHy7tdbnS2aG9mSg
         EwONdINUx8cET1QEg24zdrzrSB2FPOBxFSCa4vslZcUgfhVVVKM7iHpekDZpDyPOHHL/
         HHXDGXekBVL7Ra/WoIyATFfCqi4d1rftom769fvCw6sxZtE5I6FRx4dTgdpY/DGxuNDR
         zHt5coBblysjbT7+p5UQyT83RwtZNvoaYEt5vyZTjWhVJTyiZPukA/9e+zUPrjYCC8Qu
         EzqIZtFOdtZCe4GZAVdoCesvmFbR7INFd8rFvVaHUKRFUrdiF3ol1FAq8uYm3bbJNnBQ
         Nltw==
X-Gm-Message-State: AOAM530HR0mZ9Zef2rTZw+4OmDZqnp0Yo87UEkWyruf2bBzuqX8b5xNU
        /CsxVA0OQHUdKmklZacgnzQDaqN+vARFfXOg
X-Google-Smtp-Source: ABdhPJwXcZYKUmnn0gz7E6TMaWDu4PAiWtFSM5sFr11pDA242xsELwRqTqSLHqCs1QGWqYCF5oDXRw==
X-Received: by 2002:a5d:56c1:: with SMTP id m1mr405147wrw.87.1598946401270;
        Tue, 01 Sep 2020 00:46:41 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id u126sm817933wmu.9.2020.09.01.00.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 00:46:40 -0700 (PDT)
Date:   Tue, 1 Sep 2020 09:46:38 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Dinghao Liu <dinghao.liu@zju.edu.cn>, kjlu@umn.edu,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Leo Li <sunpeng.li@amd.com>,
        Mahesh Kumar <mahesh1.kumar@intel.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/crc-debugfs: Fix memleak in crc_control_write
Message-ID: <20200901074638.GV2352366@phenom.ffwll.local>
Mail-Followup-To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Dinghao Liu <dinghao.liu@zju.edu.cn>, kjlu@umn.edu,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>, Leo Li <sunpeng.li@amd.com>,
        Mahesh Kumar <mahesh1.kumar@intel.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20200819082228.26847-1-dinghao.liu@zju.edu.cn>
 <20200819115515.GC6049@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200819115515.GC6049@pendragon.ideasonboard.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 19, 2020 at 02:55:15PM +0300, Laurent Pinchart wrote:
> Hi Dinghao,
> 
> Thank you for the patch.
> 
> On Wed, Aug 19, 2020 at 04:22:28PM +0800, Dinghao Liu wrote:
> > When verify_crc_source() fails, source needs to be freed.
> > However, current code is returning directly and ends up
> > leaking memory.
> > 
> > Fixes: c0811a7d5befe ("drm/crc: Cleanup crtc_crc_open function")
> 
> I think the issue was introduced in d5cc15a0c66e ("drm: crc: Introduce
> verify_crc_source callback"). Apart from that,
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Pushed to drm-misc-next.
-Daniel

> 
> > Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> > ---
> >  drivers/gpu/drm/drm_debugfs_crc.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/drm_debugfs_crc.c b/drivers/gpu/drm/drm_debugfs_crc.c
> > index 5d67a41f7c3a..3dd70d813f69 100644
> > --- a/drivers/gpu/drm/drm_debugfs_crc.c
> > +++ b/drivers/gpu/drm/drm_debugfs_crc.c
> > @@ -144,8 +144,10 @@ static ssize_t crc_control_write(struct file *file, const char __user *ubuf,
> >  		source[len - 1] = '\0';
> >  
> >  	ret = crtc->funcs->verify_crc_source(crtc, source, &values_cnt);
> > -	if (ret)
> > +	if (ret) {
> > +		kfree(source);
> >  		return ret;
> > +	}
> >  
> >  	spin_lock_irq(&crc->lock);
> >  
> 
> -- 
> Regards,
> 
> Laurent Pinchart

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
