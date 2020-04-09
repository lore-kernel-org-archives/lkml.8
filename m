Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C4CC2D0EA
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 07:07:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2936120757
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 07:07:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="SFCS+REr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726082AbgDIHHi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 03:07:38 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39973 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgDIHHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 03:07:37 -0400
Received: by mail-wm1-f67.google.com with SMTP id a81so3010936wmf.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 00:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=3fzlk+1a2b3q0EKRRkBiDFhrc/J/PvVywQ93uFwgEgk=;
        b=SFCS+RErUyseIyzdWmRg7SzDZMib4Xfg2GXUyA+nAt+SYSGs/E1Ed5M78k0qjfj4uG
         1h0es5fAaghIusxx0DGZw84ApN8oVuD8UmwsSjZvtRNYy6+JCL5FSe9W9tsQi+gKmBIs
         4g97B8u6ragxgWcFUotn0rOizq64hf2vkgLsA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=3fzlk+1a2b3q0EKRRkBiDFhrc/J/PvVywQ93uFwgEgk=;
        b=S4+sUsgj+Ie6dIu/vVLfmH9xDeYNa4aCRInDjvsjU4d6hy3Y6OQhTokcusdBVOujFB
         dsutcc0lQ2CWckplxMBEetmsSqITVJAtSOuI8lD7/AZPuembG3L2teImLTu1vnLcRH9U
         d8UENJmt9hB4JVP21WdswqT8vqd6vEMBgvR6lX+CFBNmVwCz7Qrxl7ILDpvIR0Enu69x
         VsGYsMPWzhyaF8PqX93jXw7WDyFk2gpP2ERUGLEJQowFfPW9AAsvJ9gmLQbjt3uv1oqy
         gMyKOkvhRw6iiDOA5LURo4vCZKhrsbuSlPCH6PuJqZHfAvbOAn/l9xRRkW1DYBlBg23y
         d2Rg==
X-Gm-Message-State: AGi0PuY84+/JIuMtaJwzSvKsYr8HcDpPwv/pBWRUFi/gARmyCEm1eVVa
        V0+f/m1Nx+NlnKff+/jnbeszRQ==
X-Google-Smtp-Source: APiQypJejUoX6TC2lyEVkPMafhE+khuYPp3is5HDsmNy2y6qcIUU0KFigHolaP5n7n03Cz1IWsvzbg==
X-Received: by 2002:a1c:dc8b:: with SMTP id t133mr8610965wmg.117.1586416056950;
        Thu, 09 Apr 2020 00:07:36 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id h6sm2627936wmf.31.2020.04.09.00.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 00:07:36 -0700 (PDT)
Date:   Thu, 9 Apr 2020 09:07:34 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH] drm/legacy: Fix type for drm_local_map.offset
Message-ID: <20200409070734.GP3456981@phenom.ffwll.local>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
References: <20200402203317.GA34560@ubuntu-m2-xlarge-x86>
 <20200402215926.30714-1-chris@chris-wilson.co.uk>
 <20200403013420.GA11516@ubuntu-m2-xlarge-x86>
 <CAKMK7uE9pv23edViQBC=Jy5fQV=-NQTNdk1qi91Z8shpeuL7FA@mail.gmail.com>
 <CAHk-=whMhCTdx0fDRnNT4doKGYw1BBBei0KcXDZcmtVpk_GvEw@mail.gmail.com>
 <CAKMK7uE2t=z71dtJitmoKwrrZxgciEDRrNPMQ1FyiLO7s-VKag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKMK7uE2t=z71dtJitmoKwrrZxgciEDRrNPMQ1FyiLO7s-VKag@mail.gmail.com>
X-Operating-System: Linux phenom 5.3.0-3-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 03, 2020 at 07:16:28PM +0200, Daniel Vetter wrote:
> On Fri, Apr 3, 2020 at 7:14 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Fri, Apr 3, 2020 at 1:29 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> > >
> > > > Tested-by: Nathan Chancellor <natechancellor@gmail.com> # build
> > >
> > > This works too, missed it when replying to Linus
> > >
> > > Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> > >
> > > Linus I guess this one is better, but like I explained it really
> > > doesn't matter what we do with drm legacy code, it's a horror show
> > > that should be disabled on all modern distros anyway. We just keep it
> > > because of "never break old uapi".
> >
> > Ok, That patch from Chris looks fine to me too.
> >
> > dma_addr_t and resource_size_t aren't the same, but at least
> > dma_addr_t should always be the bigger one.
> >
> > And it does look like nothing else ever takes the address of this
> > field, so the ones that might want just the resource_size_t part will
> > at least have enough bits.
> >
> > So I think Chris' patch is the way to go. I'm assuming I'll get it
> > through the normal drm tree channels, this doesn't sound _so_ urgent
> > that I'd need to expedite that patch into my tree and apply it
> > directly.
> 
> Ok, sounds good.
> 
> Chris can you pls push this to drm-misc-next-fixes? That should be
> enough for the pull request train next week.

Ok I applied this now, seems to have fallen through a few cracks. Might
only make it after easter :-/
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
