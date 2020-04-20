Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A1CC54FCB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 23:19:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81EC820B1F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 23:19:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ej6B8RV6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbgDTXTw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 19:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726055AbgDTXTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 19:19:52 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E498C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 16:19:52 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id n2so6362181ybg.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 16:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ya7uPvz33k/Th0rFLYZRsOz9/2PUgpVSR6JbNYzn6GM=;
        b=ej6B8RV6ya2ZJBQQJntXMJUFXJE8+aV+G1o5ioTh/RHRkcfhHTwsaW+D4xfUqHodYk
         /auAau/cK5vj3MnL2O2LBcq6AfpOIhimpAJjXIMm/qeR20gFcmHKJ9hZqQ8Dz3lFr2b4
         Hjl4fThhii55qtQuEVj15ofas/xStHKxjXImBXkpZpmszWhI2H4of/0fwLXosY4mw7RR
         Ro6HXYradnxMnuDMfAoobzenOcHA5JrZSsxvchk5tgXFFymCbtHuq5Nqyw2LNRZIO1mL
         pSDYATkJLdXZ5zi2mT4H0tRIya6CTgg9Ao7Ym55+TGWrT8b2gt9cAsytpM/WEroXsRBO
         Mosw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ya7uPvz33k/Th0rFLYZRsOz9/2PUgpVSR6JbNYzn6GM=;
        b=Ktxy/oWoJ7SBeBv2hcpyrx1k7OoKgXp0AIfxJ+EV2RtjvXf4JdG1LigTVCcZDBz2bJ
         TJvvjn5qZVTFqXl+lEYK0sRXWLEQWf8fmJpFugseaabESdcB+3vGTPLZhoz6WhkAR4Yy
         VzBcaic3NTaSBIDdYgz3QTZH0AECzMFx9Egd2T/sEJDHUlfEDcmm9GnV9aCGaUym4pXb
         4xs4Cqe1jjUzqD112obHRpKzdGlnginM75aTivpCxM1hJHoanQYOw28I/Rbb3prYGYYX
         IhE2JbRWcQdwEnE6Fmm6gZ7mQ49Hb+1lJocu66P/SuopbZeGjAg6PTnHxmswYSUXvBmt
         kEgg==
X-Gm-Message-State: AGi0PuZBH+x9MKz8oYzWmLKH57jUDhHKC3rN8Q2GMYSM/l+9xC3JxcEE
        9J/zMPINpGxaFcsTeFp4CuRIG2k4MKIJCcicWf4=
X-Google-Smtp-Source: APiQypKza0fwVPVxFR5MdqPuNVTaaebdpuiZ+G8iyVCfL23ES5mQHCTrrzb0ymiDhrHAq6J+sngc7XaB/esudjqPt9M=
X-Received: by 2002:a25:12c1:: with SMTP id 184mr13309861ybs.162.1587424791265;
 Mon, 20 Apr 2020 16:19:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200417194145.36350-1-lyude@redhat.com>
In-Reply-To: <20200417194145.36350-1-lyude@redhat.com>
From:   Ben Skeggs <skeggsb@gmail.com>
Date:   Tue, 21 Apr 2020 09:19:40 +1000
Message-ID: <CACAvsv7i+f1EnOB6HngisnexVc2jVVyJqfQk4kRk63uxuTG18w@mail.gmail.com>
Subject: Re: [RFC v3 00/11] drm/nouveau: Introduce CRC support for gf119+
To:     Lyude Paul <lyude@redhat.com>
Cc:     ML dri-devel <dri-devel@lists.freedesktop.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>,
        David Airlie <airlied@linux.ie>,
        ML nouveau <nouveau@lists.freedesktop.org>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        Ben Skeggs <bskeggs@redhat.com>,
        Petr Mladek <pmladek@suse.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jani Nikula <jani.nikula@intel.com>,
        Peteris Rudzusiks <peteris.rudzusiks@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sean Paul <seanpaul@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Suren Baghdasaryan <surenb@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Liang Chen <cl@rock-chips.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Apr 2020 at 05:42, Lyude Paul <lyude@redhat.com> wrote:
>
> Nvidia released some documentation on how CRC support works on their
> GPUs, hooray!
>
> So: this patch series implements said CRC support in nouveau, along with
> adding some special debugfs interfaces for some relevant igt-gpu-tools
> tests that we'll be sending in just a short bit.
>
> This additionally adds a feature that Ville Syrj=C3=A4l=C3=A4 came up wit=
h: vblank
> works. Basically, this is just a generic DRM interface that allows for
> scheduling high-priority workers that start on a given vblank interrupt.
> Note that while we're currently only using this in nouveau, Intel has
> plans to use this for i915 as well (hence why they came up with it!).
>
> And finally: in order to implement the last feature, we expose some new
> functions in the kernel's kthread_worker infrastructure so that we can
> de-complicate our implementation of this.
>
> Anyway-welcome to the future! :)
The Nouveau bits look alright to me, I'll take them once the patches
it depends on have been acked.

Ben.

>
> Major changes since v2:
> * Use kthread_worker instead of kthreadd for vblank workers
> * Don't check debugfs return values
>
> Lyude Paul (11):
>   drm/vblank: Register drmm cleanup action once per drm_vblank_crtc
>   kthread: Introduce __kthread_queue_work()
>   drm/vblank: Add vblank works
>   drm/nouveau/kms/nv50-: Unroll error cleanup in nv50_head_create()
>   drm/nouveau/kms/nv140-: Don't modify depth in state during atomic
>     commit
>   drm/nouveau/kms/nv50-: Fix disabling dithering
>   drm/nouveau/kms/nv50-: s/harm/armh/g
>   drm/nouveau/kms/nv140-: Track wndw mappings in nv50_head_atom
>   drm/nouveau/kms/nv50-: Expose nv50_outp_atom in disp.h
>   drm/nouveau/kms/nv50-: Move hard-coded object handles into header
>   drm/nouveau/kms/nvd9-: Add CRC support
>
>  drivers/gpu/drm/drm_vblank.c                | 314 ++++++++-
>  drivers/gpu/drm/nouveau/dispnv04/crtc.c     |  25 +-
>  drivers/gpu/drm/nouveau/dispnv50/Kbuild     |   4 +
>  drivers/gpu/drm/nouveau/dispnv50/atom.h     |  21 +
>  drivers/gpu/drm/nouveau/dispnv50/core.h     |   4 +
>  drivers/gpu/drm/nouveau/dispnv50/core907d.c |   3 +
>  drivers/gpu/drm/nouveau/dispnv50/core917d.c |   3 +
>  drivers/gpu/drm/nouveau/dispnv50/corec37d.c |   3 +
>  drivers/gpu/drm/nouveau/dispnv50/corec57d.c |   3 +
>  drivers/gpu/drm/nouveau/dispnv50/crc.c      | 715 ++++++++++++++++++++
>  drivers/gpu/drm/nouveau/dispnv50/crc.h      | 125 ++++
>  drivers/gpu/drm/nouveau/dispnv50/crc907d.c  | 139 ++++
>  drivers/gpu/drm/nouveau/dispnv50/crcc37d.c  | 153 +++++
>  drivers/gpu/drm/nouveau/dispnv50/disp.c     |  65 +-
>  drivers/gpu/drm/nouveau/dispnv50/disp.h     |  24 +
>  drivers/gpu/drm/nouveau/dispnv50/handles.h  |  16 +
>  drivers/gpu/drm/nouveau/dispnv50/head.c     | 142 +++-
>  drivers/gpu/drm/nouveau/dispnv50/head.h     |  13 +-
>  drivers/gpu/drm/nouveau/dispnv50/head907d.c |  14 +-
>  drivers/gpu/drm/nouveau/dispnv50/headc37d.c |  27 +-
>  drivers/gpu/drm/nouveau/dispnv50/headc57d.c |  20 +-
>  drivers/gpu/drm/nouveau/dispnv50/wndw.c     |  15 +-
>  drivers/gpu/drm/nouveau/nouveau_display.c   |  60 +-
>  include/drm/drm_vblank.h                    |  31 +
>  include/linux/kthread.h                     |   3 +
>  kernel/kthread.c                            |  34 +-
>  26 files changed, 1831 insertions(+), 145 deletions(-)
>  create mode 100644 drivers/gpu/drm/nouveau/dispnv50/crc.c
>  create mode 100644 drivers/gpu/drm/nouveau/dispnv50/crc.h
>  create mode 100644 drivers/gpu/drm/nouveau/dispnv50/crc907d.c
>  create mode 100644 drivers/gpu/drm/nouveau/dispnv50/crcc37d.c
>  create mode 100644 drivers/gpu/drm/nouveau/dispnv50/handles.h
>
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
