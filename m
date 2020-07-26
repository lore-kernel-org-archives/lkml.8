Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E56C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 10:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF757206D8
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 10:26:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="PHf0VFLD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbgGZK0U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 06:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725960AbgGZK0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 06:26:20 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47974C0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 03:26:20 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id n24so10208979otr.13
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 03:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k2Fq4D+MVaPvOwyYejkASFNE/Fbxf9pO3/22f+1eVLs=;
        b=PHf0VFLDhl6XKmXhQHgwoYrMD2qxUGTx/e7U1VrDSzvUSNGyFfFVxoNihxoInyIPuw
         Su6+h1XQunxpBb9kezEWJX+oB5gKajxzh71pifMnMo7PgJ13V276+jHKCiZvJ4nbe3DC
         WhxaaPD2cSTrMa0YukAZhZl3//fYQPKxx9X+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k2Fq4D+MVaPvOwyYejkASFNE/Fbxf9pO3/22f+1eVLs=;
        b=oLOon7cuL4WcmdXH8Nb92xAstOAHeqdgNW59Z9egu6ay4cfd52Y6I2GLiNqnbs2hKZ
         Lhaw1hKHgNsIonessxtYeKS29F5IhZjWvqHtnkODU3SUjammQNIQOpOIDXDa5m7JI5LV
         3ar5oZR/Mvn8GJETlHrja4Qb95qVenmskPBlawmWDCJ02ebje13NyQWAqnqqRH/3LmUA
         lfYjTXVuwDRV5X2kwgod+frkx9Of2pnKz3C6I9qOUq06gw+aIh2goCSJPT6QjWN0RiCB
         zBLikR8qtU9jHCe59vu/VxT5NeM7WN9brhO7wYEUamMThYkq2vGEhrWOmGJ08Qe6S0Py
         mAkA==
X-Gm-Message-State: AOAM533L+4brzEcpDRpzp2xd2O4JhaGRZC4S0GqxOlLLkKTCFjzr4xk1
        y8CAx/lsXMm8cTSVUUQShC9oR8DOLmYPwdTd1DDQ9Q==
X-Google-Smtp-Source: ABdhPJyZhUQ4Fh4nXvfvrvS+6faPmS0iTsYPW5EqoFSiJT1LIF7mkGiZ0BnwJrnHpkOv/j9qN/tXoeCLJ3hT0Evvxos=
X-Received: by 2002:a05:6830:1613:: with SMTP id g19mr15498856otr.303.1595759179525;
 Sun, 26 Jul 2020 03:26:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200722110411.ebkv6knvc6mzw5uf@smtp.gmail.com>
 <20200722120502.GK6419@phenom.ffwll.local> <20200722140604.27dfzfnzug5vb75r@smtp.gmail.com>
 <CAKMK7uHWCnJ+3YnP2FwVGH6cEDkmPnH9ALjY_1R51QVs0HPG0Q@mail.gmail.com>
 <20200725011737.GA2851@realwakka> <CAKMK7uEWPCzx+K=+nJsLT5HRBVJ+s8tqx30Ljkr4BCBDComyWQ@mail.gmail.com>
 <20200725174514.esh4gqek6oddizvh@smtp.gmail.com> <CAKMK7uEi0UFSwYTO7h6_YKN+UykOuVcmhMSG_ySy9uyo_7Pz-g@mail.gmail.com>
 <20200725184918.togb54bxuifrq77c@smtp.gmail.com> <CAJeY4oEr1mDASzdjfyeXqfqUmM6n1ULgnedM7dif6db6Qk-r2g@mail.gmail.com>
 <CAJeY4oHzL2q1yRDQweSK5CM5WdHrWqqPVhkNc5DPzP1ayJLw+A@mail.gmail.com>
In-Reply-To: <CAJeY4oHzL2q1yRDQweSK5CM5WdHrWqqPVhkNc5DPzP1ayJLw+A@mail.gmail.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Sun, 26 Jul 2020 12:26:08 +0200
Message-ID: <CAKMK7uGQXXDhYGOwYdorKECgNW2Ydq=Mxu_Tm-GrOY8SHftB+g@mail.gmail.com>
Subject: Re: [PATCH] drm/vkms: add missing drm_crtc_vblank_put to the get/put
 pair on flush
To:     Melissa Wen <melissa.srw@gmail.com>
Cc:     Sidong Yang <realwakka@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        kernel-usp@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 25, 2020 at 9:29 PM Melissa Wen <melissa.srw@gmail.com> wrote:
>
> On Sat, Jul 25, 2020 at 4:19 PM Melissa Wen <melissa.srw@gmail.com> wrote:
> >
> > > No, this very first warning continues (only once) :(
> > > From here (drm_crtc_vblank_on):
> > >         if (atomic_read(&vblank->refcount) != 0 || drm_vblank_offdelay == 0)
> > >                 drm_WARN_ON(dev, drm_vblank_enable(dev, pipe));
> >
> > Sorry, not sure when this warning is triggered.
>
> Again, I just had to look at the trace:
> [   52.299388]  drm_get_last_vbltimestamp+0xaa/0xc0 [drm]
> [   52.299389]  drm_reset_vblank_timestamp+0x5b/0xd0 [drm]
> [   52.299389]  drm_crtc_vblank_on.cold+0x37/0x103 [drm]
> [   52.299390]  drm_atomic_helper_commit_modeset_enable

Yeah I think vkms can't generate a reasonable timestamp when the
hrtimer is off. I thought the warning comes from a different
callchain, but seems to be a general problem.

I guess in the vkms timestamp function we should check whether the
timer is running, and if it's not running, then we just grab the
current time and done.
-Daniel

> >
> > >
> > > > But I'm still wondering why after step 3 we don't get -EINVAL from
> > > > vblank_get() - after vblank_off() vblank->enabled should be false
> > > > again, getting us back to the same state as after 1. Is that not
> > > > happening?
> > >
> > > Yes (sorry if it got confused), we got -EINVAL after setp 3:
> > >
> > > In step 3, at the end of the 2nd running, we have:
> > > atomic_disable
> > > --> vblank_off [!vblank->inmodeset + refcount going 0->1 + inmodeset=1]
> > > and then in next vblank_get: -EINVAL (!vblank->enabled + refcount ends 1)
> > > as in the first step.
> > >
> > > Melissa
> > >
> > > > -Daniel
> > > >
> > > > >
> > > > > > >
> > > > > > > Thanks
> > > > > > > -Sidong
> > > > > > >
> > > > > > > > > >
> > > > > > > > > > >             crtc->state->event = NULL;
> > > > > > > > > > >     }
> > > > > > > > > > >
> > > > > > > > > > > --
> > > > > > > > > > > 2.27.0
> > > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > --
> > > > > > > > > > Daniel Vetter
> > > > > > > > > > Software Engineer, Intel Corporation
> > > > > > > > > > http://blog.ffwll.ch
> > > > > > > >
> > > > > > > >
> > > > > > > >
> > > > > > > > --
> > > > > > > > Daniel Vetter
> > > > > > > > Software Engineer, Intel Corporation
> > > > > > > > http://blog.ffwll.ch
> > > > > > > > _______________________________________________
> > > > > > > > dri-devel mailing list
> > > > > > > > dri-devel@lists.freedesktop.org
> > > > > > > > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> > > > > >
> > > > > >
> > > > > >
> > > > > > --
> > > > > > Daniel Vetter
> > > > > > Software Engineer, Intel Corporation
> > > > > > http://blog.ffwll.ch
> > > >
> > > >
> > > >
> > > > --
> > > > Daniel Vetter
> > > > Software Engineer, Intel Corporation
> > > > http://blog.ffwll.ch



-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
