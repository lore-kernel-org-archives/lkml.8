Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07242C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 17:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A398921D80
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 17:12:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E5m0Beqt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730463AbgIIRMU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 13:12:20 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:23443 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730271AbgIIPck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 11:32:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599665554;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AyBwbPv8eeKvlLBjOakfjoLGMVOfW6zd9C67uN/maIo=;
        b=E5m0Beqt0fdcIfLbyMWLvoLDtofs39fBFX6A+ZiA6JkAAyotuZjoXUlFYGfOjaANNRl/qt
        1mZEOGRMMQNUVZI7L6i0sI8eVLXfqij7dYmWZHXENNY+X7cJ1XHNkD6i/fE2tOGHH2PGhq
        MhOVFRaa5b3Z5jzxIHVzfhBLU7veJD0=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-472-vC-6M-nDO5COXNvFyPWkAA-1; Wed, 09 Sep 2020 10:07:10 -0400
X-MC-Unique: vC-6M-nDO5COXNvFyPWkAA-1
Received: by mail-qt1-f198.google.com with SMTP id j19so1835050qtp.19
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 07:07:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AyBwbPv8eeKvlLBjOakfjoLGMVOfW6zd9C67uN/maIo=;
        b=EnYioK6QxImtDMU/vAulEqjxq7neD2JYklt57V9papbIIeh/gScgvewRHx/sjae3ya
         3Yk1ecv7327XVhwpci2cgJtbWqC8AYwfEfbohpOIAEhBgdYcXL6h8sN4pT2v6Hwzd3rh
         q1VLsDxwXSCDKvkF3pJfN0lnXth+6FP/gQzjr1rbcLl3Go1Y2ybsPqr6QvyfDaGL/6uv
         SYEFwZRMwa1LbIHS1daganQbdho+CYNCwWZGryO2zSkuhtW7eAd0c0kiXQ+GjayzR+Uu
         gSCjyn28F/4MSRDh7msdOWi36+bS6rjuX9G6VR/xB/JgD7Yju9clnXtM+qTtaC0TGayZ
         /t3Q==
X-Gm-Message-State: AOAM531UEC1P+zNauPGpVr56B4noXFR4tYjo9NPzYeuJWqKB5LGPRQn2
        +Wlk8cbGoKPNe5GlOw3xjrxy9MGh2wYyUjB3r0xDrBzZUQSva+nTRcuuVO3hIT9n/Xi0lJ4R3tP
        SGLEQzpZYOOp6lDbCmarFEdBp
X-Received: by 2002:ad4:45a6:: with SMTP id y6mr4343661qvu.8.1599660429910;
        Wed, 09 Sep 2020 07:07:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyR62IGHKCUdInJpA3KR7u+Fm1jkeugqEcJXQiLZYHdCq9aP3hWO+P2sN+mj2H1K846ayPcXg==
X-Received: by 2002:ad4:45a6:: with SMTP id y6mr4343635qvu.8.1599660429620;
        Wed, 09 Sep 2020 07:07:09 -0700 (PDT)
Received: from dev.jcline.org ([136.56.20.95])
        by smtp.gmail.com with ESMTPSA id d76sm2649240qkc.81.2020.09.09.07.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 07:07:08 -0700 (PDT)
Date:   Wed, 9 Sep 2020 10:07:06 -0400
From:   Jeremy Cline <jcline@redhat.com>
To:     Karol Herbst <kherbst@redhat.com>
Cc:     Ben Skeggs <skeggsb@gmail.com>, David Airlie <airlied@linux.ie>,
        ML nouveau <nouveau@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [Nouveau] [PATCH] drm/nouveau: Add fine-grain temperature
 reporting
Message-ID: <20200909140706.GA27322@dev.jcline.org>
References: <20200812204952.1921587-1-jcline@redhat.com>
 <CACAvsv71oxCYB1+LCAUHD5v_NGAP-DpxPY_dPz53iw2=91KAJg@mail.gmail.com>
 <CACO55tvv6REmNzZZyyRSJyRT5z-xEf38+tk9cDnft63DX5JQUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACO55tvv6REmNzZZyyRSJyRT5z-xEf38+tk9cDnft63DX5JQUw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 09, 2020 at 10:22:14AM +0200, Karol Herbst wrote:
> On Wed, Sep 9, 2020 at 6:06 AM Ben Skeggs <skeggsb@gmail.com> wrote:
> >
> > On Thu, 13 Aug 2020 at 06:50, Jeremy Cline <jcline@redhat.com> wrote:
> > >
> > > Commit d32656373857 ("drm/nouveau/therm/gp100: initial implementation of
> > > new gp1xx temperature sensor") added support for reading finer-grain
> > > temperatures, but continued to report temperatures in 1 degree Celsius
> > > increments via nvkm_therm_temp_get().
> > >
> > > Rather than altering nvkm_therm_temp_get() to report finer-grain
> > > temperatures, which would be inconvenient for other users of the
> > > function, a second interface has been added to line up with hwmon's
> > > native unit of temperature.
> > Hey Jeremy,
> >
> > Sorry this slipped past me until now.  I'm OK with adding support for
> > millidegree temperature reporting, but don't think we need to keep
> > both interfaces around and would rather see the existing code
> > converted to return millidegrees (even on GPUs that don't support it)
> > instead of degrees.
> >
> > Thanks!
> > Ben.
> >
> 
> just a note as I was trying something like that in the past: we have a
> lot of code which fetches the temperature and there are a lot of
> places where we would then do a divide by 1000, so having a wrapper
> function at least makes sense. If we want to keep the func pointers?
> well.. I guess the increased CPU overhead wouldn't be as bad if all
> sub classes do this static * 1000 as well either. I just think we
> should have both interfaces in subdev/therm.h so we can just keep most
> of the current code as is.
> 

Indeed. My initial plan was to change the meaning of temp_get() and
adjust all the users, but there's around a dozen of them and based on my
understanding of the users none of them cared much about such accuracy.

However, I do find having one way to do things appealing, so if there's
a strong preference for it, I'm happy to produce a somewhat more
invasive patch where all users expect millidegrees.

- Jeremy

