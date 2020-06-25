Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27099C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 07:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0B3020720
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 07:53:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="dbum92Ha"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390452AbgFYHxn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 03:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390360AbgFYHxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 03:53:42 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC4AC061573
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 00:53:41 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id 17so4917563wmo.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 00:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=QhFF+JhtH5OrbA2XVfa4DEMoq1rPmq5A541noBohoEI=;
        b=dbum92HacgzVfcv5HyBVk4jTj4zjsMSRuPnugG4qBlK9zxfz+PiLRjLwKR6lr2PW+0
         E8QWSPaMgLpkHkyRw5PCAzc4dC2wDWRk37C+K0E2B7QdTiRDa73eLJG7aZG706RoTmKe
         4AlhpK9mFuUPoMxycv+1Km95Zufyc/4TO2i0E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=QhFF+JhtH5OrbA2XVfa4DEMoq1rPmq5A541noBohoEI=;
        b=fyP3Ui73Ro8R8gcoDPOVAibl7Gi93Ss/TwNmgZOnAxtU799FBFQwqSa+YdTBBGos/s
         5xVniQvAIjhH20aoWTsl8GDyXx6ohOmh2ShJeppbC7tHNrsClPiBCi7PWfCTR6a3T9Pd
         Z1VIMXx+fQuTbZ3fCkzFxTWc8Gv5WmfxHq/vqrgx1JHXuRSERs+J2sseqiyAZxWmYrWN
         s2IfZRRZFQiuHWBKr/Z9Og4qGRyK9SFFNODjaYGe7nni97Amwc1eqmkDS2gHTmlugdhT
         Qh6kz6Q8dKHwSTw0QMQ+M+ssKj0mZVUxhpz1l1NxqJ+aE+6GKYgrqAi3Xwbxk0nT1OWl
         k7ow==
X-Gm-Message-State: AOAM5304zccJUhN/myfXAcJ30UL4f+GRwV71Qg00ZZ5KhVlE3s6TgSjh
        0daGosc96/pi2bS1gumSY+qLUQ==
X-Google-Smtp-Source: ABdhPJwk5m6H2Tp1NSk8W7Q7efXaGQpX9fClYnMmVqGc/bGphvNrVx6oIBY7RwQwAd9rZkulo8fFvg==
X-Received: by 2002:a1c:e355:: with SMTP id a82mr1996753wmh.165.1593071620044;
        Thu, 25 Jun 2020 00:53:40 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id k126sm5848415wme.17.2020.06.25.00.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 00:53:39 -0700 (PDT)
Date:   Thu, 25 Jun 2020 09:53:36 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Yannick FERTRE <yannick.fertre@st.com>
Cc:     Angelo Ribeiro <Angelo.Ribeiro@synopsys.com>,
        Philippe CORNU <philippe.cornu@st.com>,
        Benjamin GAIGNARD <benjamin.gaignard@st.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Jose Abreu <Jose.Abreu@synopsys.com>
Subject: Re: [PATCH] drm/bridge: dw-mipi-dsi.c: remove unused header file
Message-ID: <20200625075336.GB3278063@phenom.ffwll.local>
Mail-Followup-To: Yannick FERTRE <yannick.fertre@st.com>,
        Angelo Ribeiro <Angelo.Ribeiro@synopsys.com>,
        Philippe CORNU <philippe.cornu@st.com>,
        Benjamin GAIGNARD <benjamin.gaignard@st.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-stm32@st-md-mailman.stormreply.com" <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Jose Abreu <Jose.Abreu@synopsys.com>
References: <171ff1fb3918664a570dc8f2f34b446612505f76.1585832665.git.angelo.ribeiro@synopsys.com>
 <669d5484-b1e5-dd5c-b4e5-f3b5a8b436b4@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <669d5484-b1e5-dd5c-b4e5-f3b5a8b436b4@st.com>
X-Operating-System: Linux phenom 5.6.0-1-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 03:08:22PM +0000, Yannick FERTRE wrote:
> Hello Angelo,
> thank for patch.
> 
> Reviewed-by: Yannick Fertre <yannick.fertre@st.com>

Patch applied, thanks.
-Daniel

> 
> 
> 
> On 4/3/20 3:30 PM, Angelo Ribeiro wrote:
> > dw-mipi-dsi does not use any definition from drm_probe_helper.
> > 
> > Coverity output:
> > Event unnecessary_header:
> > Including .../include/drm/drm_probe_helper.h does not provide any
> > needed symbols.
> > 
> > Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> > Cc: Joao Pinto <jpinto@synopsys.com>
> > Cc: Jose Abreu <jose.abreu@synopsys.com>
> > Signed-off-by: Angelo Ribeiro <angelo.ribeiro@synopsys.com>
> > ---
> >   drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c | 1 -
> >   1 file changed, 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
> > index 024acad..582635d 100644
> > --- a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
> > +++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
> > @@ -27,7 +27,6 @@
> >   #include <drm/drm_modes.h>
> >   #include <drm/drm_of.h>
> >   #include <drm/drm_print.h>
> > -#include <drm/drm_probe_helper.h>
> >   
> >   #define HWVER_131			0x31333100	/* IP version 1.31 */
> >   
> > 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
