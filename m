Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D242C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 09:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DB972074D
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 09:51:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="DVhNg6Kj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbgHMJvL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 05:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbgHMJvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 05:51:10 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B307C061757
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 02:51:10 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id k8so4491807wma.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 02:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=zg93XxO4l+jcR8PfpAZh0n8+oaLX+Q4lgRFm3zGssrc=;
        b=DVhNg6KjuaCUFHNyZn3fii/TgH9lle+4x/mX1ByaV25FzltReZ+eVhVlAFfxQ0o9Cs
         BHZf8neUfriA+xuI3HFmlV1P91lUGIGAxoPO8cUIZwTOwse3gLkuyLdaGIZS3d1/pHDo
         nbyzVt8rKGwFYDxNNBq7//TAbTd/Q+eWflGMc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=zg93XxO4l+jcR8PfpAZh0n8+oaLX+Q4lgRFm3zGssrc=;
        b=RY0FwCBxekUdmYX6X5oNpCrtkwwkl2A4moUctsKhExfPNSeDl/oUu/ZOatOd7bL4OT
         FaStGM9bGppnaLVE1E7v0M7apeZ/gHCTjseIQ03IM7bv68SKdkXOIQ3IYrTcRxYlqVQV
         E4opIGCXnLE2Jk0bq5AsyoHDMAM6JvDnLWfXz5ND0yARFsjQpR8d7RGEv9PYkHjDsG6i
         ui9OTn0cKh2JD9dWE+gOyMXxlUclE3OvISSy2tw1gw7CfXVeIJAkecU/IR/xFrkqR5Sy
         DQkl0xIBel96/gvgFd6GxoN0/yftxIXDqmKFztLAyPXAtcMgQ7KiAl/fS7z5gbxuZ7mw
         aE3w==
X-Gm-Message-State: AOAM531nOVA19FqtvdKExRNr6W6ZMgcOKNiHF7h+vwCa0szGGnyE7ZTy
        3ECQ2ZJ99YJDS+YQmA7hBRgPUA==
X-Google-Smtp-Source: ABdhPJzcoJ5rRTPQL/cGJK9cs5jwZn25rutC7+9OZPz6v1i5Qk0+wLJa418Yrv09qyu0BV9p+dgqdA==
X-Received: by 2002:a1c:1d2:: with SMTP id 201mr3368914wmb.132.1597312268880;
        Thu, 13 Aug 2020 02:51:08 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id 124sm8705928wmd.31.2020.08.13.02.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 02:51:08 -0700 (PDT)
Date:   Thu, 13 Aug 2020 11:51:06 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Tian Tao <tiantao6@hisilicon.com>, airlied@linux.ie,
        daniel@ffwll.ch, kraxel@redhat.com, alexander.deucher@amd.com,
        tglx@linutronix.de, dri-devel@lists.freedesktop.org,
        xinliang.liu@linaro.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH] drm/hisilicon: Fix build error of no type of module_init
Message-ID: <20200813095106.GK2352366@phenom.ffwll.local>
Mail-Followup-To: Thomas Zimmermann <tzimmermann@suse.de>,
        Tian Tao <tiantao6@hisilicon.com>, airlied@linux.ie,
        kraxel@redhat.com, alexander.deucher@amd.com, tglx@linutronix.de,
        dri-devel@lists.freedesktop.org, xinliang.liu@linaro.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com
References: <1597289955-27381-1-git-send-email-tiantao6@hisilicon.com>
 <5e7ed4d6-8961-bdd0-6698-47571066357a@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5e7ed4d6-8961-bdd0-6698-47571066357a@suse.de>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 13, 2020 at 10:03:18AM +0200, Thomas Zimmermann wrote:
> Hi
> 
> Am 13.08.20 um 05:39 schrieb Tian Tao:
> > Add missing include to fix build error:
> > hibmc_drm_drv.c:385:1: warning: data definition has no type or storage
> > class [enabled by default]
> > hibmc_drm_drv.c:385:1: error: type defaults to ‘int’ in declaration
> > of ‘module_init’ [-Werror=implicit-int]
> > hibmc_drm_drv.c:385:1: warning: parameter names (without types) in function
> > of ‘module_exit’ [-Werror=implicit-int]
> > hibmc_drm_drv.c:385:292:1: warning: parameter names (without types) in
> > function declaration [enabled by default]
> > 
> > Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
> > Reported-by: kernel test robot <lkp@intel.com>
> 
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
> 
> I pushed the patch to drm-misc-next, but forgot to add my R-b tag. If
> anyone complains, it's my fault.

sob implies r-b generally, most maintainers do it like that and don't add
both their sob and r-b tag. That's also why dim doesn't enforce an r-b tag
in this case.
-Daniel
> 
> Best regards
> Thomas
> 
> > ---
> >  drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> > index 1ae360d..2b4f821 100644
> > --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> > +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> > @@ -11,6 +11,7 @@
> >   *	Jianhua Li <lijianhua@huawei.com>
> >   */
> >  
> > +#include <linux/module.h>
> >  #include <linux/pci.h>
> >  
> >  #include <drm/drm_atomic_helper.h>
> > 
> 
> -- 
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Maxfeldstr. 5, 90409 Nürnberg, Germany
> (HRB 36809, AG Nürnberg)
> Geschäftsführer: Felix Imendörffer
> 




-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
