Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD70AC433F8
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 10:02:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAF30208CA
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 10:02:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="QXqXKWHD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728084AbgGPKC0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 06:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbgGPKCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 06:02:25 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ABA4C061755
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 03:02:23 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id f139so10994586wmf.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 03:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=HmJaP7NVFikmcFK4iQg7dTx43rAgLK9eCD2nR0ykggk=;
        b=QXqXKWHD595aOxvBvIH0/gxFgCKeBmrudeJvMWbRzyIjiUcd8RY3hApeSAnEV1kvE3
         QpgeeNZA2EfDthgH3ykQZgPNBvm2P3awtwuaXp2nmwOFPFwcQ0DOVXbvhgDB53c/Ae0I
         XIkCuf6zc8kz51rbtP8PDxSLTOyINc3kqx25w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=HmJaP7NVFikmcFK4iQg7dTx43rAgLK9eCD2nR0ykggk=;
        b=eDGhCmJAJUCXBfnhfA09aM0bp/nJYvBixOsVyGUKO5WYztxvIYbF8H5f3K/33s4G+U
         /DBeSBuqCUSm0qV0oLqYmAfb/nOwkDpcZtw+3SGnUvCR5uv2r5/qRVQkxDJgmfDBkcZu
         HJY/Np5X5JGZs/pko3AC3hZrQ7hB5eQ0n+GChmY2DeSm93jlX7XdJuol7PCwgrrGYX+F
         pLUpY0rUORLw8N5uafnPW+sECi7bX/Hf03WhreFRtOlh8iC2ll5mLlxtvvaRysduQBzs
         ewNddoRqiF8eedYijKia/iKURB350osuWi35BQMkVqPe7ZfrdMzOkGrz8oiq8lPDitNC
         Nlug==
X-Gm-Message-State: AOAM532Lpn8X1+bv4CBjTSyBLNt5UHmVIEWFEFaJ/s10kOAZhRBU3fWM
        Bux3ylCoi11ek6XmUrzuuduIHA==
X-Google-Smtp-Source: ABdhPJy/fuyzYF8bhQ0P7Z9zswy1xZik8dtBkFxL5eo+aszv5YPTqw8TmSmFdKQ6/aArjI3D5ObphA==
X-Received: by 2002:a1c:5418:: with SMTP id i24mr3521598wmb.47.1594893742062;
        Thu, 16 Jul 2020 03:02:22 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id x9sm8030657wmk.45.2020.07.16.03.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 03:02:21 -0700 (PDT)
Date:   Thu, 16 Jul 2020 12:02:19 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Jing Xiangfeng <jingxiangfeng@huawei.com>
Cc:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, ajax@redhat.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: remove redundant assignment to variable 'ret'
Message-ID: <20200716100202.GO3278063@phenom.ffwll.local>
Mail-Followup-To: Jing Xiangfeng <jingxiangfeng@huawei.com>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, ajax@redhat.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20200715070559.180986-1-jingxiangfeng@huawei.com>
 <20200715120503.GJ3278063@phenom.ffwll.local>
 <5F0FB48A.6080407@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5F0FB48A.6080407@huawei.com>
X-Operating-System: Linux phenom 5.6.0-1-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 16, 2020 at 09:59:38AM +0800, Jing Xiangfeng wrote:
> 
> 
> On 2020/7/15 20:05, Daniel Vetter wrote:
> > On Wed, Jul 15, 2020 at 03:05:59PM +0800, Jing Xiangfeng wrote:
> > > The variable ret has been assigned the value '-EINVAL'. The assignment
> > > in the if() is redundant. We can remove it.
> > 
> > Nope, that's not correct. Before this assignement ret is guaranteed to be
> > 0.
> 
> Before this assignment ret is '-EINVAL'(see commit 45bc3d26c95a: "drm:
> rework SET_MASTER and DROP_MASTER perm handling"). It is set to 0 above
> around the drm_drop_master() calls.

Ah indeed, but it got fixed already in 

commit 264ddd077c72092178153fc32d510dcecff32eeb
Author: Emil Velikov <emil.l.velikov@gmail.com>
Date:   Sat May 30 13:46:40 2020 +0100

    drm/auth: make drm_{set,drop}master_ioctl symmetrical

That's why your patch didn't make any sense to me.
-Daniel

> 
> Thanks
> > -Daniel
> > 
> > > 
> > > Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
> > > ---
> > >   drivers/gpu/drm/drm_auth.c | 1 -
> > >   1 file changed, 1 deletion(-)
> > > 
> > > diff --git a/drivers/gpu/drm/drm_auth.c b/drivers/gpu/drm/drm_auth.c
> > > index 800ac39f3213..6e1b502f2797 100644
> > > --- a/drivers/gpu/drm/drm_auth.c
> > > +++ b/drivers/gpu/drm/drm_auth.c
> > > @@ -299,7 +299,6 @@ int drm_dropmaster_ioctl(struct drm_device *dev, void *data,
> > > 
> > >   	if (file_priv->master->lessor != NULL) {
> > >   		DRM_DEBUG_LEASE("Attempt to drop lessee %d as master\n", file_priv->master->lessee_id);
> > > -		ret = -EINVAL;
> > >   		goto out_unlock;
> > >   	}
> > > 
> > > --
> > > 2.17.1
> > > 
> > 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
