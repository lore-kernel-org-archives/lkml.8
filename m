Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A72A8C2D0F2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 15:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C01C2078B
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 15:15:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="KbvvbCuW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731085AbgCaPPU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 11:15:20 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52223 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731048AbgCaPPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 11:15:19 -0400
Received: by mail-wm1-f66.google.com with SMTP id z7so241949wmk.1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 08:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=ipYWlIFq3tHRPQUnqZtBdxsK4/UyR731/H9eH9PnfT4=;
        b=KbvvbCuWTnx3deVUNXfh6ZH7/iir2HKLToXknDwo7In/7NB8wHWU62m7SbNHlQK15w
         NYMV8jhWujQQ7f0S6Ej7AT5Bn2gH8fg/ntDxAxG/2Ml3w1WIM8Eh5GxUxAw2z0TfpFML
         V4jsubaGezs2z+6lJKnB1kN6/No3ukTNiELuU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=ipYWlIFq3tHRPQUnqZtBdxsK4/UyR731/H9eH9PnfT4=;
        b=fbEsuy8Pa+9dh2UKO9v6WdQMbItqqjgcaqVDD88gmX1N67iFkVir9HNC5BK9y4cRVP
         YEjv/QOXhnLP5789B9+R2qHZhGWLdZQUKc0mEp4hk6cdKQWmryJN0S6fPF4SycGBJFHH
         5nYNVmqlwpted7SUwXeiyH4MhKUhcuL2KNU/tg4xjC78qCDRlE29785dVy4MlvVKn0wR
         a/VumyAeY329EDArPiQunfjCRUBwQ1ADeUF95gXORJOt37uy5H0od/RYsU5xHwiOwEUp
         i+xBfKnLAUuxEtgtxgewZIO5XYqMmIC63XEMr0KDwU221aGguK5fn0IUq5yqQFOdsIwq
         TRiQ==
X-Gm-Message-State: ANhLgQ1ifoeqTLnKDIHDc9Tgq8icfXb/+briOot+KKrrk4fezF9fmHO1
        cYc72dZHY8OcsZS4dsmbelG1Mg==
X-Google-Smtp-Source: ADFU+vtAGfwopaPt/m4X2IibkfKMGh7X4KlgcFgCC08sXSkC7SEmBbQwoH17zK8HUyK6RhKgz0hjCQ==
X-Received: by 2002:a1c:63c4:: with SMTP id x187mr3935335wmb.124.1585667717161;
        Tue, 31 Mar 2020 08:15:17 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id v21sm4140105wmj.8.2020.03.31.08.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 08:15:16 -0700 (PDT)
Date:   Tue, 31 Mar 2020 17:15:14 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Oleksandr Andrushchenko <andr2000@gmail.com>
Cc:     Ding Xiang <dingxiang@cmss.chinamobile.com>,
        oleksandr_andrushchenko@epam.com, airlied@linux.ie,
        daniel@ffwll.ch, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [Xen-devel] [PATCH] drm/xen: fix passing zero to 'PTR_ERR'
 warning
Message-ID: <20200331151514.GO2363188@phenom.ffwll.local>
Mail-Followup-To: Oleksandr Andrushchenko <andr2000@gmail.com>,
        Ding Xiang <dingxiang@cmss.chinamobile.com>,
        oleksandr_andrushchenko@epam.com, airlied@linux.ie,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
References: <1585562347-30214-1-git-send-email-dingxiang@cmss.chinamobile.com>
 <b4d43b05-8b30-749c-0b60-87b4cdd7b1dd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4d43b05-8b30-749c-0b60-87b4cdd7b1dd@gmail.com>
X-Operating-System: Linux phenom 5.3.0-3-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 31, 2020 at 05:50:10PM +0300, Oleksandr Andrushchenko wrote:
> On 3/30/20 12:59, Ding Xiang wrote:
> > Fix a static code checker warning:
> >      drivers/gpu/drm/xen/xen_drm_front.c:404 xen_drm_drv_dumb_create()
> >      warn: passing zero to 'PTR_ERR'
> > 
> > Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
> Reviewed-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>

merged to drm-misc-next-fixese.
-Daniel

> > ---
> >   drivers/gpu/drm/xen/xen_drm_front.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/xen/xen_drm_front.c b/drivers/gpu/drm/xen/xen_drm_front.c
> > index 4be49c1..3741420 100644
> > --- a/drivers/gpu/drm/xen/xen_drm_front.c
> > +++ b/drivers/gpu/drm/xen/xen_drm_front.c
> > @@ -401,7 +401,7 @@ static int xen_drm_drv_dumb_create(struct drm_file *filp,
> >   	obj = xen_drm_front_gem_create(dev, args->size);
> >   	if (IS_ERR_OR_NULL(obj)) {
> > -		ret = PTR_ERR(obj);
> > +		ret = PTR_ERR_OR_ZERO(obj);
> >   		goto fail;
> >   	}

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
