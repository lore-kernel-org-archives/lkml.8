Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF207C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 21:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF76A207FC
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 21:55:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="fDFvzQad"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729541AbgG1VzU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 17:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728149AbgG1VzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 17:55:19 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D86BBC061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 14:55:18 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id r2so14612718wrs.8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 14:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=1Z4LFmpGBH8VoUSg5h3v4QFcVv1VouJZ9d4ywj1fyZI=;
        b=fDFvzQadt8Ho81/WiYwbZc7yUdpmNj1rSdcAmvWu+bOpiytHDhX7SQqTWLOn0SbAS/
         A1GyODcoJ5zXMF67xseTb/sHkSq1jLRPAj1ZkdNAnaeibZmjMVsdLxZ8w86QH1IvkMZI
         H8d0lwY9yZUnGgL7JN56aM/ob/+6lMgi7Pczk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=1Z4LFmpGBH8VoUSg5h3v4QFcVv1VouJZ9d4ywj1fyZI=;
        b=I0zApA+36361I5/KizsM9Q/MqnxMxwgxSR5a9T1qzEzRWdcUKBr8u4eS7YMVpKN/pP
         HiScFv4OjXmPam5uYx8+1ujvYOzIZZ1h02db2QTkS8TnK0RE/s5TaFmd4C7ER22/vEll
         hgj0e+s3TOsYq3kUr7OExFS5+L3hW4gQDgGzjEgOPkhRG+VQl9U8C8K4xTZP290d5EAb
         LuLRlrsM8GMOnc8nJYnE5kbk6Diqh/9ftbd4be2Zy89Hnie+s/G1bHxJZIRGVR9wbBHg
         ViLH5cBZIufnZQVrmczBWL/x7LO6rFOES3IuXrmOWlQzuNJy/GcuLF9plVx0+hoz+Xl/
         v+Ig==
X-Gm-Message-State: AOAM533H4dNuI5zvnTh/GCevYxlMalBk+PKx0eia2S2/rbn8agf1PzzI
        CBYZmSWHwZE3SfCs29SscVrDxQ==
X-Google-Smtp-Source: ABdhPJyXKCmmcKvyoF3AKxTFUYpWNFk2HjYm2Sf0mcvxSXQQG+hT4Lp7B61wON5bD6C0AitS/XG39g==
X-Received: by 2002:a5d:548f:: with SMTP id h15mr26977647wrv.331.1595973317554;
        Tue, 28 Jul 2020 14:55:17 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id 128sm303063wmz.43.2020.07.28.14.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 14:55:16 -0700 (PDT)
Date:   Tue, 28 Jul 2020 23:55:15 +0200
From:   daniel@ffwll.ch
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Melissa Wen <melissa.srw@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        kernel-usp@googlegroups.com
Subject: Re: [PATCH] drm/vkms: add missing drm_crtc_vblank_put to the get/put
 pair on flush
Message-ID: <20200728215515.GG6419@phenom.ffwll.local>
Mail-Followup-To: Sidong Yang <realwakka@gmail.com>,
        Melissa Wen <melissa.srw@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        kernel-usp@googlegroups.com
References: <CAKMK7uHWCnJ+3YnP2FwVGH6cEDkmPnH9ALjY_1R51QVs0HPG0Q@mail.gmail.com>
 <20200725011737.GA2851@realwakka>
 <CAKMK7uEWPCzx+K=+nJsLT5HRBVJ+s8tqx30Ljkr4BCBDComyWQ@mail.gmail.com>
 <20200725174514.esh4gqek6oddizvh@smtp.gmail.com>
 <CAKMK7uEi0UFSwYTO7h6_YKN+UykOuVcmhMSG_ySy9uyo_7Pz-g@mail.gmail.com>
 <20200725184918.togb54bxuifrq77c@smtp.gmail.com>
 <CAJeY4oEr1mDASzdjfyeXqfqUmM6n1ULgnedM7dif6db6Qk-r2g@mail.gmail.com>
 <CAJeY4oHzL2q1yRDQweSK5CM5WdHrWqqPVhkNc5DPzP1ayJLw+A@mail.gmail.com>
 <CAKMK7uGQXXDhYGOwYdorKECgNW2Ydq=Mxu_Tm-GrOY8SHftB+g@mail.gmail.com>
 <20200728161634.GA6555@realwakka>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200728161634.GA6555@realwakka>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 28, 2020 at 04:16:34PM +0000, Sidong Yang wrote:
> On Sun, Jul 26, 2020 at 12:26:08PM +0200, Daniel Vetter wrote:
> > On Sat, Jul 25, 2020 at 9:29 PM Melissa Wen <melissa.srw@gmail.com> wrote:
> > >
> > > On Sat, Jul 25, 2020 at 4:19 PM Melissa Wen <melissa.srw@gmail.com> wrote:
> > > >
> > > > > No, this very first warning continues (only once) :(
> > > > > From here (drm_crtc_vblank_on):
> > > > >         if (atomic_read(&vblank->refcount) != 0 || drm_vblank_offdelay == 0)
> > > > >                 drm_WARN_ON(dev, drm_vblank_enable(dev, pipe));
> > > >
> > > > Sorry, not sure when this warning is triggered.
> > >
> > > Again, I just had to look at the trace:
> > > [   52.299388]  drm_get_last_vbltimestamp+0xaa/0xc0 [drm]
> > > [   52.299389]  drm_reset_vblank_timestamp+0x5b/0xd0 [drm]
> > > [   52.299389]  drm_crtc_vblank_on.cold+0x37/0x103 [drm]
> > > [   52.299390]  drm_atomic_helper_commit_modeset_enable
> > 
> > Yeah I think vkms can't generate a reasonable timestamp when the
> > hrtimer is off. I thought the warning comes from a different
> > callchain, but seems to be a general problem.
> > 
> > I guess in the vkms timestamp function we should check whether the
> > timer is running, and if it's not running, then we just grab the
> > current time and done.
> 
> I tried some test about this scenario that commit_tail calls in sequence disable 
> - enable - commit.
> In a first test. there was a warning and found out that it raised from 
> vkms_get_vblank_timestamp() the code checking vblank_hrtimer's expire time and 
> vblank_time. In first run, vblank_time and hrtimer's expire time was both zero.  
> because vblank wasn't happened yet. this warning wasn't happend since second run 
> that vblank time was set from first run. 
> 
> I don't know it's good way to solve the problem. Is there no problem in other 
> drm modules?

Generally real hw drivers always have working clocks, not like the fake
ones we have here :-) The idea behind the timestamp callback is that when
vblank interrupts aren't enabled, the timestamp will help us keep track of
how many vblanks have happened.

So I think (but might be wrong) correct fix for this issue would be to
check whether vblanks are enabled, and if not, simply pass back the
current system time. That's a lie, but much better than whatever value was
set last time around the hrtimer fired- e.g. similar problem can happen
later on when the vblank interrupt was off for a very long time.
-Daniel

> 
> -Sidong
> 
> > -Daniel
> > 
> > > >
> > > > >
> > > > > > But I'm still wondering why after step 3 we don't get -EINVAL from
> > > > > > vblank_get() - after vblank_off() vblank->enabled should be false
> > > > > > again, getting us back to the same state as after 1. Is that not
> > > > > > happening?
> > > > >
> > > > > Yes (sorry if it got confused), we got -EINVAL after setp 3:
> > > > >
> > > > > In step 3, at the end of the 2nd running, we have:
> > > > > atomic_disable
> > > > > --> vblank_off [!vblank->inmodeset + refcount going 0->1 + inmodeset=1]
> > > > > and then in next vblank_get: -EINVAL (!vblank->enabled + refcount ends 1)
> > > > > as in the first step.
> > > > >
> > > > > Melissa
> > > > >
> > > > > > -Daniel
> > > > > >
> > > > > > >
> > > > > > > > >
> > > > > > > > > Thanks
> > > > > > > > > -Sidong
> > > > > > > > >
> > > > > > > > > > > >
> > > > > > > > > > > > >             crtc->state->event = NULL;
> > > > > > > > > > > > >     }
> > > > > > > > > > > > >
> > > > > > > > > > > > > --
> > > > > > > > > > > > > 2.27.0
> > > > > > > > > > > > >
> > > > > > > > > > > >
> > > > > > > > > > > > --
> > > > > > > > > > > > Daniel Vetter
> > > > > > > > > > > > Software Engineer, Intel Corporation
> > > > > > > > > > > > http://blog.ffwll.ch
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > --
> > > > > > > > > > Daniel Vetter
> > > > > > > > > > Software Engineer, Intel Corporation
> > > > > > > > > > http://blog.ffwll.ch
> > > > > > > > > > _______________________________________________
> > > > > > > > > > dri-devel mailing list
> > > > > > > > > > dri-devel@lists.freedesktop.org
> > > > > > > > > > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> > > > > > > >
> > > > > > > >
> > > > > > > >
> > > > > > > > --
> > > > > > > > Daniel Vetter
> > > > > > > > Software Engineer, Intel Corporation
> > > > > > > > http://blog.ffwll.ch
> > > > > >
> > > > > >
> > > > > >
> > > > > > --
> > > > > > Daniel Vetter
> > > > > > Software Engineer, Intel Corporation
> > > > > > http://blog.ffwll.ch
> > 
> > 
> > 
> > -- 
> > Daniel Vetter
> > Software Engineer, Intel Corporation
> > http://blog.ffwll.ch

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
