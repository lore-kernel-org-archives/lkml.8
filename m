Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB285C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 19:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A226E20714
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 19:41:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rPFIK4uz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbgGYT3u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 15:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbgGYT3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 15:29:49 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B9BBC08C5C0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 12:29:48 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id q4so13288467lji.2
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 12:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QRn/o7p7Dr6ct7GVq8d3H/58B25NpUh0o8HDRDgbelU=;
        b=rPFIK4uzBFnqaegkZ+ahCYgrdrkZNiv3wYqRuQzpEKS3OiuC5VNfZMggQTw7ZE6ITP
         zJK6sTJfQD9XiBbsvXpCHALUrBKqPEP3n7UQVwTqnAajLsH7kt56nylrgTBQEx7EKG+U
         O7SZ5oR4GHNUj+mEwpYPD6k5y3deSn868L4pXgBsrb4bIXK5uAT/WRTfGjHrlGYUytdL
         sgQa+8AeGJU633TIgtzEjONDWz+ho+glG3ug/FvX7xowRGKrfjg1/l1HHkyU3N7RS/Zu
         /e1p/NdzwV3hYL2PwRn3HDYlZA/fTrW3lWcLxGHiWr9PgKzHgHj2ED/R5BrqH00ovfuF
         8yqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QRn/o7p7Dr6ct7GVq8d3H/58B25NpUh0o8HDRDgbelU=;
        b=LXSmkHf8JayQKFOyEEJA2ls8YgHJCvT1co4y0h4sRLSRJU+lQpMjhUVL3J+PKDiEal
         1F4EAyok5ObugqsYzYtGPbQSMKICbvHf28BtEu2G00LlJn/hmL+cQMEtH0+9l8sVYqtx
         0dEPlpnxwV7g6XAsqF4K29uRP8OCbCahqXsFqWqwfssSoYaayjFnYUgVowCoL0IhDMef
         BDpDWO+qCGmErAm/a0j3lvpTZHHyi02wEw8ZQq/tTmdRvXJoKePm20IlDlgUZMSEl/W8
         pu/8WNYOil45o+NKHk1qGgG7ISsL66FhB06x91NkoJKktvS2lzQ3bchxnjBvW/CsIYDu
         OLhg==
X-Gm-Message-State: AOAM531+YQ8Q8+o1tmAaLHKt7QrMAsm0xZAkM/TRWh23CfQGUS+wBpFP
        hrRzd+RxZZGZL2uZ8i1okdix3WKJrksI0Bp3mwk=
X-Google-Smtp-Source: ABdhPJy4nIkdNHCtvK1N9MfD51qsqqFMMgFVTsb9MPToJUX4nGtOLa7aZokCkKC+sUqPYXpTnCK4esEz99fi8gSqe0M=
X-Received: by 2002:a2e:8858:: with SMTP id z24mr6885159ljj.425.1595705386442;
 Sat, 25 Jul 2020 12:29:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200722110411.ebkv6knvc6mzw5uf@smtp.gmail.com>
 <20200722120502.GK6419@phenom.ffwll.local> <20200722140604.27dfzfnzug5vb75r@smtp.gmail.com>
 <CAKMK7uHWCnJ+3YnP2FwVGH6cEDkmPnH9ALjY_1R51QVs0HPG0Q@mail.gmail.com>
 <20200725011737.GA2851@realwakka> <CAKMK7uEWPCzx+K=+nJsLT5HRBVJ+s8tqx30Ljkr4BCBDComyWQ@mail.gmail.com>
 <20200725174514.esh4gqek6oddizvh@smtp.gmail.com> <CAKMK7uEi0UFSwYTO7h6_YKN+UykOuVcmhMSG_ySy9uyo_7Pz-g@mail.gmail.com>
 <20200725184918.togb54bxuifrq77c@smtp.gmail.com> <CAJeY4oEr1mDASzdjfyeXqfqUmM6n1ULgnedM7dif6db6Qk-r2g@mail.gmail.com>
In-Reply-To: <CAJeY4oEr1mDASzdjfyeXqfqUmM6n1ULgnedM7dif6db6Qk-r2g@mail.gmail.com>
From:   Melissa Wen <melissa.srw@gmail.com>
Date:   Sat, 25 Jul 2020 16:29:35 -0300
Message-ID: <CAJeY4oHzL2q1yRDQweSK5CM5WdHrWqqPVhkNc5DPzP1ayJLw+A@mail.gmail.com>
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

On Sat, Jul 25, 2020 at 4:19 PM Melissa Wen <melissa.srw@gmail.com> wrote:
>
> > No, this very first warning continues (only once) :(
> > From here (drm_crtc_vblank_on):
> >         if (atomic_read(&vblank->refcount) != 0 || drm_vblank_offdelay == 0)
> >                 drm_WARN_ON(dev, drm_vblank_enable(dev, pipe));
>
> Sorry, not sure when this warning is triggered.

Again, I just had to look at the trace:
[   52.299388]  drm_get_last_vbltimestamp+0xaa/0xc0 [drm]
[   52.299389]  drm_reset_vblank_timestamp+0x5b/0xd0 [drm]
[   52.299389]  drm_crtc_vblank_on.cold+0x37/0x103 [drm]
[   52.299390]  drm_atomic_helper_commit_modeset_enable

>
> >
> > > But I'm still wondering why after step 3 we don't get -EINVAL from
> > > vblank_get() - after vblank_off() vblank->enabled should be false
> > > again, getting us back to the same state as after 1. Is that not
> > > happening?
> >
> > Yes (sorry if it got confused), we got -EINVAL after setp 3:
> >
> > In step 3, at the end of the 2nd running, we have:
> > atomic_disable
> > --> vblank_off [!vblank->inmodeset + refcount going 0->1 + inmodeset=1]
> > and then in next vblank_get: -EINVAL (!vblank->enabled + refcount ends 1)
> > as in the first step.
> >
> > Melissa
> >
> > > -Daniel
> > >
> > > >
> > > > > >
> > > > > > Thanks
> > > > > > -Sidong
> > > > > >
> > > > > > > > >
> > > > > > > > > >             crtc->state->event = NULL;
> > > > > > > > > >     }
> > > > > > > > > >
> > > > > > > > > > --
> > > > > > > > > > 2.27.0
> > > > > > > > > >
> > > > > > > > >
> > > > > > > > > --
> > > > > > > > > Daniel Vetter
> > > > > > > > > Software Engineer, Intel Corporation
> > > > > > > > > http://blog.ffwll.ch
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > > --
> > > > > > > Daniel Vetter
> > > > > > > Software Engineer, Intel Corporation
> > > > > > > http://blog.ffwll.ch
> > > > > > > _______________________________________________
> > > > > > > dri-devel mailing list
> > > > > > > dri-devel@lists.freedesktop.org
> > > > > > > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> > > > >
> > > > >
> > > > >
> > > > > --
> > > > > Daniel Vetter
> > > > > Software Engineer, Intel Corporation
> > > > > http://blog.ffwll.ch
> > >
> > >
> > >
> > > --
> > > Daniel Vetter
> > > Software Engineer, Intel Corporation
> > > http://blog.ffwll.ch
