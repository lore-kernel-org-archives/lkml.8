Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3724DC433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 16:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 116122065C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 16:16:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M1yeDf7B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731341AbgG1QQp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 12:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730556AbgG1QQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 12:16:44 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C238C061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 09:16:44 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id e8so12134194pgc.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 09:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5hAHQVdK1eMNUgeTGoP5P2N6Dh+EChlHcZOZmgXqG/Q=;
        b=M1yeDf7BTYx/Jxik0hy/9QfnJMYJS/Nh2k/SXflonvJZRmbAtSK3BFYAjfbHsxXp5n
         yX5MN3dW5QcrAtv/pibUOyQ2571GiPa9rPkbzQ3vIEPGdQcNORg/FN2ouhGWl70h5z0M
         jmdeBUcLoZklFI2rdC6+aKvAK7w8uYR0YuKARzJV37dsBy4RK3uSio/8Cq/Y8li8BFmj
         HCCzULjMnWnmpevXFi6zFt1ZQOCfNbCY+ZDGcXFvVnYhXZSj1+cV2PtXzpFkkDYKa1mS
         VNXQn0wPsnVVuYQKOtz+s633rjd/DCTMw2zItBkkM23sAvGvoAYeSUVNkdIr7914/0e2
         mQ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5hAHQVdK1eMNUgeTGoP5P2N6Dh+EChlHcZOZmgXqG/Q=;
        b=hpa7lNKOOCcwyPDXj2/+0H/MAxindQvMMmZEhd+wiBo0Dyhx5yXNDl4d1/UXm8kAdA
         xCEsJl03fH5szt8vz7wlpwF4EZxUI6z1cYDPyGvKcvotaahMk6LQUQDln6xIDl8lCfIt
         /U6Oh6IolVrdHBCMQBypv/+Lyaa7u/7Mm951P/mzBlnxMO78J8gQ1Df/ZC0LJZf0VRhg
         Ltr3dFH9mDr9N3f6uTiolK21Vrlli/L3dDeoD42FKJb/i5dOFHPiVQ0SjFmA15c4FBsj
         gcp1wqhJYf8kuYdDX3OK58rw1a0kLlWEeacmbh/+P++dhV/oE2a9OAXfnTMcjosGWW8o
         pgCw==
X-Gm-Message-State: AOAM530krQNVQKR+xZnnDP0GED4yp1/DqwhHwpUJ6HjvR3ZZx+0a+T/j
        fhOTYatfttI//qjVsFMrS5g=
X-Google-Smtp-Source: ABdhPJxhejyu5AbxgF3YkqfRK4QH2QX7YB9cC0GlaQ2jo23a48FzF5AQzVrjvciwFVW37AklN9eT3g==
X-Received: by 2002:a63:8ec8:: with SMTP id k191mr25085677pge.154.1595953003584;
        Tue, 28 Jul 2020 09:16:43 -0700 (PDT)
Received: from realwakka ([61.83.141.80])
        by smtp.gmail.com with ESMTPSA id m6sm8654592pfk.36.2020.07.28.09.16.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Jul 2020 09:16:43 -0700 (PDT)
Date:   Tue, 28 Jul 2020 16:16:34 +0000
From:   Sidong Yang <realwakka@gmail.com>
To:     Daniel Vetter <daniel@ffwll.ch>,
        Melissa Wen <melissa.srw@gmail.com>
Cc:     Melissa Wen <melissa.srw@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        kernel-usp@googlegroups.com
Subject: Re: [PATCH] drm/vkms: add missing drm_crtc_vblank_put to the get/put
 pair on flush
Message-ID: <20200728161634.GA6555@realwakka>
References: <20200722140604.27dfzfnzug5vb75r@smtp.gmail.com>
 <CAKMK7uHWCnJ+3YnP2FwVGH6cEDkmPnH9ALjY_1R51QVs0HPG0Q@mail.gmail.com>
 <20200725011737.GA2851@realwakka>
 <CAKMK7uEWPCzx+K=+nJsLT5HRBVJ+s8tqx30Ljkr4BCBDComyWQ@mail.gmail.com>
 <20200725174514.esh4gqek6oddizvh@smtp.gmail.com>
 <CAKMK7uEi0UFSwYTO7h6_YKN+UykOuVcmhMSG_ySy9uyo_7Pz-g@mail.gmail.com>
 <20200725184918.togb54bxuifrq77c@smtp.gmail.com>
 <CAJeY4oEr1mDASzdjfyeXqfqUmM6n1ULgnedM7dif6db6Qk-r2g@mail.gmail.com>
 <CAJeY4oHzL2q1yRDQweSK5CM5WdHrWqqPVhkNc5DPzP1ayJLw+A@mail.gmail.com>
 <CAKMK7uGQXXDhYGOwYdorKECgNW2Ydq=Mxu_Tm-GrOY8SHftB+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKMK7uGQXXDhYGOwYdorKECgNW2Ydq=Mxu_Tm-GrOY8SHftB+g@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 26, 2020 at 12:26:08PM +0200, Daniel Vetter wrote:
> On Sat, Jul 25, 2020 at 9:29 PM Melissa Wen <melissa.srw@gmail.com> wrote:
> >
> > On Sat, Jul 25, 2020 at 4:19 PM Melissa Wen <melissa.srw@gmail.com> wrote:
> > >
> > > > No, this very first warning continues (only once) :(
> > > > From here (drm_crtc_vblank_on):
> > > >         if (atomic_read(&vblank->refcount) != 0 || drm_vblank_offdelay == 0)
> > > >                 drm_WARN_ON(dev, drm_vblank_enable(dev, pipe));
> > >
> > > Sorry, not sure when this warning is triggered.
> >
> > Again, I just had to look at the trace:
> > [   52.299388]  drm_get_last_vbltimestamp+0xaa/0xc0 [drm]
> > [   52.299389]  drm_reset_vblank_timestamp+0x5b/0xd0 [drm]
> > [   52.299389]  drm_crtc_vblank_on.cold+0x37/0x103 [drm]
> > [   52.299390]  drm_atomic_helper_commit_modeset_enable
> 
> Yeah I think vkms can't generate a reasonable timestamp when the
> hrtimer is off. I thought the warning comes from a different
> callchain, but seems to be a general problem.
> 
> I guess in the vkms timestamp function we should check whether the
> timer is running, and if it's not running, then we just grab the
> current time and done.

I tried some test about this scenario that commit_tail calls in sequence disable 
- enable - commit.
In a first test. there was a warning and found out that it raised from 
vkms_get_vblank_timestamp() the code checking vblank_hrtimer's expire time and 
vblank_time. In first run, vblank_time and hrtimer's expire time was both zero.  
because vblank wasn't happened yet. this warning wasn't happend since second run 
that vblank time was set from first run. 

I don't know it's good way to solve the problem. Is there no problem in other 
drm modules?

-Sidong

> -Daniel
> 
> > >
> > > >
> > > > > But I'm still wondering why after step 3 we don't get -EINVAL from
> > > > > vblank_get() - after vblank_off() vblank->enabled should be false
> > > > > again, getting us back to the same state as after 1. Is that not
> > > > > happening?
> > > >
> > > > Yes (sorry if it got confused), we got -EINVAL after setp 3:
> > > >
> > > > In step 3, at the end of the 2nd running, we have:
> > > > atomic_disable
> > > > --> vblank_off [!vblank->inmodeset + refcount going 0->1 + inmodeset=1]
> > > > and then in next vblank_get: -EINVAL (!vblank->enabled + refcount ends 1)
> > > > as in the first step.
> > > >
> > > > Melissa
> > > >
> > > > > -Daniel
> > > > >
> > > > > >
> > > > > > > >
> > > > > > > > Thanks
> > > > > > > > -Sidong
> > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > >             crtc->state->event = NULL;
> > > > > > > > > > > >     }
> > > > > > > > > > > >
> > > > > > > > > > > > --
> > > > > > > > > > > > 2.27.0
> > > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > --
> > > > > > > > > > > Daniel Vetter
> > > > > > > > > > > Software Engineer, Intel Corporation
> > > > > > > > > > > http://blog.ffwll.ch
> > > > > > > > >
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > --
> > > > > > > > > Daniel Vetter
> > > > > > > > > Software Engineer, Intel Corporation
> > > > > > > > > http://blog.ffwll.ch
> > > > > > > > > _______________________________________________
> > > > > > > > > dri-devel mailing list
> > > > > > > > > dri-devel@lists.freedesktop.org
> > > > > > > > > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > > --
> > > > > > > Daniel Vetter
> > > > > > > Software Engineer, Intel Corporation
> > > > > > > http://blog.ffwll.ch
> > > > >
> > > > >
> > > > >
> > > > > --
> > > > > Daniel Vetter
> > > > > Software Engineer, Intel Corporation
> > > > > http://blog.ffwll.ch
> 
> 
> 
> -- 
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch
