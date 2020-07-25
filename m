Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A4ACC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 19:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74A30206D7
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 19:20:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mvXHuh6j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbgGYTUA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 15:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbgGYTT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 15:19:59 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40FBEC08C5C0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 12:19:59 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id d17so13245172ljl.3
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 12:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g4J6dkRqHFKiKhjcRC8q/JmeC/kbD2LNmS8StOCmtOU=;
        b=mvXHuh6jpM3ry5QoR34JW1d8FG1E/6i19D+6eHevdB/BJD97IyC8wD2xC+bM8l5Ujc
         48KF5bxobuUlIlCULXPavhfxF3h1KYr8QgsIyILVedJSXIv54uInP6GcUT1iXSG+ayYu
         EUD7recqFSD++W9kn404rRgoXuFpxT5nBnjmX6YS6TX57Bn99MxgL9v8Ty2mxycVSlz9
         lFPJy/ecKwv3YkQic14JYKpV3fDDMlwGCrzbXwY0ocmBn8/Wkw7sQcmAuR6xMs5JLrnE
         TvooKIp0/sJ+Z9iwMaWOvHuMMjRAhrsvnR6k1debndHhInU3NvFu9JxZ3LxaPSPWVaS3
         e1Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g4J6dkRqHFKiKhjcRC8q/JmeC/kbD2LNmS8StOCmtOU=;
        b=jWKF1yuH9FO3Rxl/YYOsrv3FCF9C9dsI8Qw9PZpOegJN8EKjSSwcbZK5GeoLPiK7ZA
         WI7YyRhIJEcy1Q25jnto777/+B7VC6CSVDQGVbzPKgsH+y9uWixfUoLvC4qo4DjUteIF
         N6CrjnJ3mHHvfd0uob0BlGli1SmL3Y8HzU6pqISisetqqgGki7D5kxAIuWbYUH1v4+4F
         YlkhI8FLeOYmmpBRQrv8SJWEJ+X0UZHa+60yUaXBFeh78DDQpI+anoMov4IDIjVtGPJ4
         Umeru5My6EERtZtuaTQckKryOOSCGw0GtylPtoHAghF356YreND39CN4WiM5/M9sVM4N
         k5VQ==
X-Gm-Message-State: AOAM531dDVTdVunRZMa6WY/u1WZmL7OeXzjkm4026Hn/t4cFyfKbnI/v
        i3Tfec1OHJvRLvDZCX9PYmukqqlrjTKObMDJW25TtQ==
X-Google-Smtp-Source: ABdhPJwX2YWaS3FX13+Q0LtCtGPNZAsAPnsJBOyVicKVnyzv1PltkImBXj4c5goex61U5pVCv5ilQrP7FYqxDuxoALY=
X-Received: by 2002:a2e:9d0b:: with SMTP id t11mr589477lji.365.1595704797729;
 Sat, 25 Jul 2020 12:19:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200722110411.ebkv6knvc6mzw5uf@smtp.gmail.com>
 <20200722120502.GK6419@phenom.ffwll.local> <20200722140604.27dfzfnzug5vb75r@smtp.gmail.com>
 <CAKMK7uHWCnJ+3YnP2FwVGH6cEDkmPnH9ALjY_1R51QVs0HPG0Q@mail.gmail.com>
 <20200725011737.GA2851@realwakka> <CAKMK7uEWPCzx+K=+nJsLT5HRBVJ+s8tqx30Ljkr4BCBDComyWQ@mail.gmail.com>
 <20200725174514.esh4gqek6oddizvh@smtp.gmail.com> <CAKMK7uEi0UFSwYTO7h6_YKN+UykOuVcmhMSG_ySy9uyo_7Pz-g@mail.gmail.com>
 <20200725184918.togb54bxuifrq77c@smtp.gmail.com>
In-Reply-To: <20200725184918.togb54bxuifrq77c@smtp.gmail.com>
From:   Melissa Wen <melissa.srw@gmail.com>
Date:   Sat, 25 Jul 2020 16:19:46 -0300
Message-ID: <CAJeY4oEr1mDASzdjfyeXqfqUmM6n1ULgnedM7dif6db6Qk-r2g@mail.gmail.com>
Subject: Re: [PATCH] drm/vkms: add missing drm_crtc_vblank_put to the get/put
 pair on flush
To:     Daniel Vetter <daniel@ffwll.ch>
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

> No, this very first warning continues (only once) :(
> From here (drm_crtc_vblank_on):
>         if (atomic_read(&vblank->refcount) != 0 || drm_vblank_offdelay == 0)
>                 drm_WARN_ON(dev, drm_vblank_enable(dev, pipe));

Sorry, not sure when this warning is triggered.

>
> > But I'm still wondering why after step 3 we don't get -EINVAL from
> > vblank_get() - after vblank_off() vblank->enabled should be false
> > again, getting us back to the same state as after 1. Is that not
> > happening?
>
> Yes (sorry if it got confused), we got -EINVAL after setp 3:
>
> In step 3, at the end of the 2nd running, we have:
> atomic_disable
> --> vblank_off [!vblank->inmodeset + refcount going 0->1 + inmodeset=1]
> and then in next vblank_get: -EINVAL (!vblank->enabled + refcount ends 1)
> as in the first step.
>
> Melissa
>
> > -Daniel
> >
> > >
> > > > >
> > > > > Thanks
> > > > > -Sidong
> > > > >
> > > > > > > >
> > > > > > > > >             crtc->state->event = NULL;
> > > > > > > > >     }
> > > > > > > > >
> > > > > > > > > --
> > > > > > > > > 2.27.0
> > > > > > > > >
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
> > > > > > _______________________________________________
> > > > > > dri-devel mailing list
> > > > > > dri-devel@lists.freedesktop.org
> > > > > > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> > > >
> > > >
> > > >
> > > > --
> > > > Daniel Vetter
> > > > Software Engineer, Intel Corporation
> > > > http://blog.ffwll.ch
> >
> >
> >
> > --
> > Daniel Vetter
> > Software Engineer, Intel Corporation
> > http://blog.ffwll.ch
