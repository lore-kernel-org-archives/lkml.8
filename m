Return-Path: <SRS0=zXkI=7F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 845B9C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 06:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 521112071C
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 06:54:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387652AbgEWGyU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 May 2020 02:54:20 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:46308 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387457AbgEWGyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 02:54:20 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id A356C20027;
        Sat, 23 May 2020 08:54:14 +0200 (CEST)
Date:   Sat, 23 May 2020 08:54:12 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Lyude Paul <lyude@redhat.com>
Cc:     dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        Dave Airlie <airlied@redhat.com>
Subject: Re: [PATCH] drm/vblank: Fix -Wformat compile warnings on some arches
Message-ID: <20200523065412.GA1591726@ravnborg.org>
References: <20200521204647.2578479-1-lyude@redhat.com>
 <20200521210924.GA1056842@ravnborg.org>
 <7db8ff3ee32bddfb6f82760468caa86388bee9bd.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7db8ff3ee32bddfb6f82760468caa86388bee9bd.camel@redhat.com>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=ULXz4hXy c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=kj9zAlcOel0A:10 a=SkMT5Nvf8EpqA8CG8aMA:9 a=CjuIK1q_8ugA:10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lyude.

> > > *dev, unsigned int pipe,
> > >  
> > >  	DRM_DEBUG_VBL("updating vblank count on crtc %u:"
> > >  		      " current=%llu, diff=%u, hw=%u hw_last=%u\n",
> > > -		      pipe, atomic64_read(&vblank->count), diff,
> > > +		      pipe, (unsigned long long)atomic64_read(&vblank->count),
> > > diff,
> > >  		      cur_vblank, vblank->last);
> > 
> > While touching this you could consider introducing drm_dbg_vbl().
> > An maybe as a follow-up patch replace all logging in this file with the drm_*
> > variants.
> 
> ok - no promises when I can actually get to this though, I've got a lot on my
> plate ATM

I wnet ahead and applied this patch (after fixing a too long line),
and then I updated the logging functions as suggested above.
I applied the patch to drm-misc-next.

Patches with updated logging coming.

	Sam
