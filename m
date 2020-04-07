Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD0FEC2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 09:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81547206F7
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 09:58:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wA6RVWrG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbgDGJ6I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 05:58:08 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42835 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728236AbgDGJ6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 05:58:07 -0400
Received: by mail-qt1-f194.google.com with SMTP id b10so2166263qtt.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 02:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XlRrtk04Drccp1IaTlKa1DPuRVn27tHDYLsET4EpF9I=;
        b=wA6RVWrGZsTvyQtipGlQPkx/zUrMle6j/PotPS/Ubl+1rUlzDuQJHGGTaWn9pBGS94
         16eiWdiG0Uj54QLqStMqvzt0Vrq+V/aGzVTBBEKpa6GoDtAtJ3Nwfa2MD4il9MQsiZu0
         +0YaAJkHWlROCy7YvKoMm3EGWcRaXOX3FgiFrZJ99qtqsJEnvq7c99tBL02yA0kMadQJ
         3gMAPBRwaQi4ggynes7NGTM0NIeFUdLAuw0OMg+zsQaJgY/v9/KSEqpLpWFaBdYbDldX
         JLo5MsaJ9O2qScwUxYoer4R5IylAMN5UZ5C0/vp0fPMln72xoMrG/HMyoY/yznxhyxS6
         iz/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XlRrtk04Drccp1IaTlKa1DPuRVn27tHDYLsET4EpF9I=;
        b=dWVuXUCgXMIxloZMXQwDJoVDhdUWFmZcw8WVmZ5anXtSeSQVs3vP56K6fQAywo+YJC
         Cj72ijofD+ijJx+S3AOrwFC7EmREUjuueEUU8Kwt8Ca86mYMZ6kOLGW/G1Fh4c+gXTqU
         uUvOXf4nnvRIha0B+aHjAN+78J7MQqJveW8LlBvo8xC1P4D86M+KLP7/NYJ6f/qp40u9
         MLqJRxuPRbB0Tng1rqtC7+8xW9ft8pKPALvjdBobh4DFm2lGfY/uqbImoeHQmQtd1vk6
         20lAZ1InAJVCq7n4m/WGNevNCQIjb+vohphOf65En2mh0dXuzONRoEXU3Bk/TKoza8oL
         Ne/w==
X-Gm-Message-State: AGi0PubyyaUqwMplULUoH74nKhxW6Ada16OrXEFVte7Q1gfnsh3bT1UG
        FqcKQvgkyzie4+Iz3M/qCNgTCIa4+sCjjsTJhuKb+Ej+eY4=
X-Google-Smtp-Source: APiQypIVkup6lPiinv10OxautZSlD/0H+G8ygJP+Y1zlmhVZq44N0hs/Atb3q7hlgMorG94PI0Jdbec7sG00UJjWQWk=
X-Received: by 2002:ac8:370c:: with SMTP id o12mr1366857qtb.380.1586253485793;
 Tue, 07 Apr 2020 02:58:05 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000091056b05a2999f1e@google.com> <CACT4Y+b4RcgG_GrcpaghmqhX47zUVsAcGGd6vb6MYJT=6gf89g@mail.gmail.com>
 <20200406080612.v5ubxvyliuso6v5h@sirius.home.kraxel.org> <CAKMK7uE9uQ_YCXfDOH9zQBu_ffoz546hqRd1R_r1+L-T072Lew@mail.gmail.com>
 <20200406131602.ggugjwkm36r4zvkr@sirius.home.kraxel.org>
In-Reply-To: <20200406131602.ggugjwkm36r4zvkr@sirius.home.kraxel.org>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 7 Apr 2020 11:57:54 +0200
Message-ID: <CACT4Y+aF1fNRgq_1a2NnVdy9epQvy5TzRF8VQ8OUSSkh6HAc0g@mail.gmail.com>
Subject: Re: upstream boot error: KASAN: slab-out-of-bounds Write in virtio_gpu_object_create
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        syzbot <syzbot+d3a7951ed361037407db@syzkaller.appspotmail.com>,
        David Airlie <airlied@linux.ie>,
        DRI <dri-devel@lists.freedesktop.org>,
        "open list:VIRTIO CORE, NET..." 
        <virtualization@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 6, 2020 at 3:16 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
>   Hi,
>
> > > > +drivers/gpu/drm/virtio/virtgpu_object.c maintainers
> > > > Now we have both mainline and linux-next boot broken (linux-next is
> > > > broken for the past 40 days).
> > > > No testing of new code happens.
> > > >
> > > > >  virtio_gpu_object_shmem_init drivers/gpu/drm/virtio/virtgpu_object.c:151 [inline]
> > > > >  virtio_gpu_object_create+0x9f3/0xaa0 drivers/gpu/drm/virtio/virtgpu_object.c:230
> > >
> > > Ah, that one.
> > >
> > > broken patch: f651c8b05542 ("drm/virtio: factor out the sg_table from virtio_gpu_object")
> > > fixed by: 0666a8d7f6a4 ("drm/virtio: fix OOB in virtio_gpu_object_create")
> > >
> > > Both are in drm-misc-next.  I suspect the fix was added after
> > > drm-misc-next was closed for the 5.7 merge window and thus should
> > > have been submitted to drm-misc-next-fixes instead.
> > >
> > > So, what to do now?  Should I cherry-pick 0666a8d7f6a4 into
> > > drm-misc-next-fixes?  Or should it go into drm-misc-fixes instead?
> >
> > Yup cherry-pick it over, with -x, to drm-misc-next-fixes.
> > -Daniel
>
> Done.  So the next linux-next build should be green again.

Linux-next is boot broken with 2 or 3 other bugs for a month. This
won't fix linux-next.
