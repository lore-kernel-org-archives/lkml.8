Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 934FFC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 07:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CB65206CD
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 07:34:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="WvVYlLyu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbgIAHek (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 03:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbgIAHeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 03:34:37 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C748C061244
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 00:34:37 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id f7so334348wrw.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 00:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=uBet/qOZ4arKPd9HG45s6/yizvDfyghb5+cpF1ynNlk=;
        b=WvVYlLyur5enfsW0jQmGhW/33TGWeA+s81WiSCZtZGnTGInRKT4lauH7Tv1Ncl35e2
         MBX5Tgg7qp8H8HcEG0u+P7InO1kW6IesVw7yOSV3w6hoG7v7YNwh+0elQjnUhzR8dPSM
         ehQdEWDPud2Aj7A0/V0iRfznqpu4qvj7PURgg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=uBet/qOZ4arKPd9HG45s6/yizvDfyghb5+cpF1ynNlk=;
        b=c2wPLtQYQ266q35e8umQOtjhrKrTL54Ax2Zesq3e/xG+mi+wxdVkv3P2Zc+rNp/eap
         3mM42UCN8qM6AU7stfOhmnd1CPIQMuFKmp9ZdUGoX6cbjCATFYrcDowWndMjeCqeQ1bS
         k8hb57JZVfPnildlofIkza05xg6YcF/2WkMbYTORJxy/h1WQFFbbTZl0Y3shwKAzQphp
         /Fwz7uirJMII14YtLnt/WcqUm9mIUR4YUrGC9pVgkBAdnjagzBGtTljH/s5tkvc/c/O5
         ewEadu/KXlQK4IDAla52kye+gh6LKOVbPTlK1aNDND8+NX/32nb9l4ckYs3biWG+3i0x
         i9CQ==
X-Gm-Message-State: AOAM5328mIsWgZRSv4QjogAjXkKUYVZH+WyKhRe/7+a/hqe0Nsh1PDbp
        Qpywoi9j5ozHGaPGwnIxZeX4sk0ygvqxwRQf
X-Google-Smtp-Source: ABdhPJyt8crlnEcBML2lk0r4FJiVx9broYmBFybtfg7pUBuXao0ZikQLrPS8dTTtHkn7WHCj3P0hHw==
X-Received: by 2002:adf:e2c7:: with SMTP id d7mr408449wrj.110.1598945675900;
        Tue, 01 Sep 2020 00:34:35 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id 2sm831925wrs.64.2020.09.01.00.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 00:34:35 -0700 (PDT)
Date:   Tue, 1 Sep 2020 09:34:33 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>, David Airlie <airlied@linux.ie>,
        1882851@bugs.launchpad.net,
        open list <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH 1/2] drm/virtio: fix unblank
Message-ID: <20200901073433.GS2352366@phenom.ffwll.local>
Mail-Followup-To: Gerd Hoffmann <kraxel@redhat.com>,
        Jiri Slaby <jirislaby@kernel.org>, David Airlie <airlied@linux.ie>,
        1882851@bugs.launchpad.net,
        open list <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org,
        "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>
References: <20200818072511.6745-1-kraxel@redhat.com>
 <20200818072511.6745-2-kraxel@redhat.com>
 <88ae71c2-c3ed-e0e4-e62c-bdf9d6534f2a@kernel.org>
 <20200828112759.rmeeh5bonrewiqte@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200828112759.rmeeh5bonrewiqte@sirius.home.kraxel.org>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 28, 2020 at 01:27:59PM +0200, Gerd Hoffmann wrote:
> On Mon, Aug 24, 2020 at 09:24:40AM +0200, Jiri Slaby wrote:
> > On 18. 08. 20, 9:25, Gerd Hoffmann wrote:
> > > When going through a disable/enable cycle without changing the
> > > framebuffer the optimization added by commit 3954ff10e06e ("drm/virtio:
> > > skip set_scanout if framebuffer didn't change") causes the screen stay
> > > blank.  Add a bool to force an update to fix that.
> > > 
> > > v2: use drm_atomic_crtc_needs_modeset() (Daniel).
> > > 
> > > Cc: 1882851@bugs.launchpad.net
> > > Fixes: 3954ff10e06e ("drm/virtio: skip set_scanout if framebuffer didn't change")
> > > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > 
> > Tested-by: Jiri Slaby <jirislaby@kernel.org>
> 
> Ping.  Need an ack or an review to merge this.

In case you still need that, on both patches:

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> 
> thanks,
>   Gerd
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
