Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B92C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 13:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79098229C5
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 13:16:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="go3et0M9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728343AbgDFNQL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 09:16:11 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:38783 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728193AbgDFNQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 09:16:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586178970;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i9EytxK/zu+9ecojVcCWTRmH9NFAwPvCvkkFp6J4c3I=;
        b=go3et0M9L893TTMRXqTjUaNZE+8N6yoCU/ETN3Fy0TRqWY6a7O4sSYeJZWKxwO8/BlIAE6
        C/t5HFj7dJRSMnd8BX+5TIMOKW1z8C2thqQ57lQ97no93E+/OGsS9QxoWO1rGS2R7/I49b
        o8XTK+KUWyrH1BoJzOOHPc3JkPF2hQM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-79-zKRNp85SOqSB19QETQFpVg-1; Mon, 06 Apr 2020 09:16:06 -0400
X-MC-Unique: zKRNp85SOqSB19QETQFpVg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E05768017F4;
        Mon,  6 Apr 2020 13:16:03 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-60.ams2.redhat.com [10.36.113.60])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 77BB79D352;
        Mon,  6 Apr 2020 13:16:03 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 653C716E2C; Mon,  6 Apr 2020 15:16:02 +0200 (CEST)
Date:   Mon, 6 Apr 2020 15:16:02 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+d3a7951ed361037407db@syzkaller.appspotmail.com>,
        David Airlie <airlied@linux.ie>,
        DRI <dri-devel@lists.freedesktop.org>,
        "open list:VIRTIO CORE, NET..." 
        <virtualization@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: upstream boot error: KASAN: slab-out-of-bounds Write in
 virtio_gpu_object_create
Message-ID: <20200406131602.ggugjwkm36r4zvkr@sirius.home.kraxel.org>
References: <00000000000091056b05a2999f1e@google.com>
 <CACT4Y+b4RcgG_GrcpaghmqhX47zUVsAcGGd6vb6MYJT=6gf89g@mail.gmail.com>
 <20200406080612.v5ubxvyliuso6v5h@sirius.home.kraxel.org>
 <CAKMK7uE9uQ_YCXfDOH9zQBu_ffoz546hqRd1R_r1+L-T072Lew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKMK7uE9uQ_YCXfDOH9zQBu_ffoz546hqRd1R_r1+L-T072Lew@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

> > > +drivers/gpu/drm/virtio/virtgpu_object.c maintainers
> > > Now we have both mainline and linux-next boot broken (linux-next is
> > > broken for the past 40 days).
> > > No testing of new code happens.
> > >
> > > >  virtio_gpu_object_shmem_init drivers/gpu/drm/virtio/virtgpu_object.c:151 [inline]
> > > >  virtio_gpu_object_create+0x9f3/0xaa0 drivers/gpu/drm/virtio/virtgpu_object.c:230
> >
> > Ah, that one.
> >
> > broken patch: f651c8b05542 ("drm/virtio: factor out the sg_table from virtio_gpu_object")
> > fixed by: 0666a8d7f6a4 ("drm/virtio: fix OOB in virtio_gpu_object_create")
> >
> > Both are in drm-misc-next.  I suspect the fix was added after
> > drm-misc-next was closed for the 5.7 merge window and thus should
> > have been submitted to drm-misc-next-fixes instead.
> >
> > So, what to do now?  Should I cherry-pick 0666a8d7f6a4 into
> > drm-misc-next-fixes?  Or should it go into drm-misc-fixes instead?
> 
> Yup cherry-pick it over, with -x, to drm-misc-next-fixes.
> -Daniel

Done.  So the next linux-next build should be green again.  mainline
should get the fix with the next drm pull (may take a few days).

take care,
  Gerd

