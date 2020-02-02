Return-Path: <SRS0=NZ9A=3W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CD9FC3524D
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 13:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D80C42067C
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 13:17:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="IE+nMVkX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgBBNRO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Feb 2020 08:17:14 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37142 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726669AbgBBNRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Feb 2020 08:17:14 -0500
Received: by mail-ot1-f65.google.com with SMTP id d3so11081099otp.4
        for <linux-kernel@vger.kernel.org>; Sun, 02 Feb 2020 05:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+JexwpZ7uOUAzO/bZPt69XOsxgXW5ev8PRFd02TcEk8=;
        b=IE+nMVkXga9fWUwZKPOjqNIk95sq5yO14vZeu1ludYC7s0JaU1fr2jelppwPGlACgG
         83h28kTdOijU1EWLsvch7JEqnA+Ea0m9DfYb62/uQy108/7UV+m83daOiNSPwAckbp8F
         DpBcwguqXp7EEyyRRPBYZizpZiRhl1W8LshjY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+JexwpZ7uOUAzO/bZPt69XOsxgXW5ev8PRFd02TcEk8=;
        b=VieXIfIO+rZbppqPClqBT2+a9aYit2ghG2pVKIfTwl+N8ovyicmoYnQftDaSjFRuIR
         cJLEAffIzqHd3ico9tW+aAdYuiEUdZY1XM76WGop6GCyBy/5fUVq9sf1lc/mA4pCtc4f
         EaK+cBU/ThLMl7S1azg3h24jM6e9gPsdRkSi7XJIrX2L/9DnXtB7+VBE253N3cIxdSYW
         zq1dTIasn9E/QZ0WIwAVrUdQRWFRZap8PgNtcYspTC7fW/ZC3GpnwXqEbwj3ZBw+fIGG
         ljKECZWxLRMIuBFBLvaGWrad0xVrApTBMLuvenhO8a7IjngxG7LC2QRogfwFUEYeB13d
         XcmQ==
X-Gm-Message-State: APjAAAWYudjEd4kxMVN8ZJBA2xsnECQDrBgjXWuUJWruttTsOuCN8krr
        yH30ZQdssm40kX5s6xkwD/giB7uClfUeNHo5a5WH3g==
X-Google-Smtp-Source: APXvYqyhJpSqQ8at/IdzLDOBcr/4/JYswhhc71+cJLzlo49FIW6k84QX0OWoAy1QjBLh4SW+3pmM+ASFc5nUW+iAsSg=
X-Received: by 2002:a9d:7696:: with SMTP id j22mr14988663otl.188.1580649432010;
 Sun, 02 Feb 2020 05:17:12 -0800 (PST)
MIME-Version: 1.0
References: <20200201043209.13412-1-hdanton@sina.com> <20200201090247.10928-1-hdanton@sina.com>
 <20200201162537.GK1778@kadam>
In-Reply-To: <20200201162537.GK1778@kadam>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Sun, 2 Feb 2020 14:17:00 +0100
Message-ID: <CAKMK7uGHuvyrn=WghhHBk2miW__ctVHeDTDKz+XVJ9yLjpS97Q@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in vgem_gem_dumb_create
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+0dc4444774d419e916c8@syzkaller.appspotmail.com>,
        Dave Airlie <airlied@linux.ie>,
        Alex Deucher <alexander.deucher@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        "Wilson, Chris" <chris@chris-wilson.co.uk>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Miller <davem@davemloft.net>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Emil Velikov <emil.velikov@collabora.com>,
        "Anholt, Eric" <eric@anholt.net>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>, netdev <netdev@vger.kernel.org>,
        Rob Clark <robdclark@chromium.org>,
        Sean Paul <seanpaul@chromium.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 1, 2020 at 5:26 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Sat, Feb 01, 2020 at 05:02:47PM +0800, Hillf Danton wrote:
> >
> > On Sat, 1 Feb 2020 09:17:57 +0300 Dan Carpenter wrote:
> > > On Sat, Feb 01, 2020 at 12:32:09PM +0800, Hillf Danton wrote:
> > > >
> > > > Release obj in error path.
> > > >
> > > > --- a/drivers/gpu/drm/vgem/vgem_drv.c
> > > > +++ b/drivers/gpu/drm/vgem/vgem_drv.c
> > > > @@ -196,10 +196,10 @@ static struct drm_gem_object *vgem_gem_c
> > > >           return ERR_CAST(obj);
> > > >
> > > >   ret = drm_gem_handle_create(file, &obj->base, handle);
> > > > - drm_gem_object_put_unlocked(&obj->base);
> > > > - if (ret)
> > > > + if (ret) {
> > > > +         drm_gem_object_put_unlocked(&obj->base);
> > > >           return ERR_PTR(ret);
> > > > -
> > > > + }
> > > >   return &obj->base;
> > >
> > > Oh yeah.  It's weird that we never noticed the success path was broken.
> > > It's been that way for three years and no one noticed at all.  Very
> > > strange.
> > >
> > > Anyway, it already gets freed on error in drm_gem_handle_create() so
> > > we should just delete the drm_gem_object_put_unlocked() here it looks
> > > like.

There's two refcounts here, one is the handle_count, and the other is
the underlying object refcount. I think the code is correct, except if
you race with a 2nd thread which destroys the object (through the
handle) while we still try to read gem_object->size in the caller of
this. So correct fix (I think at least) is to shuffle that temporary
reference on the object (not the handle) we hold while constructing it
around a bit, so there's no use-after free anymore in the case of a
race. I'm typing a patch for this.

Cheers, Daniel

> > Good catch, Dan :P
> > Would you please post a patch sometime convenient next week?
>
> Sure.  Will do.
>
> regards,
> dan carpenter
>


-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
