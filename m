Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA1AC2BA19
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 08:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77249206F8
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 08:06:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ng3w+qRe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbgDFIGW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 04:06:22 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:28869 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726491AbgDFIGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 04:06:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586160380;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ylWquo2AGzDmVpZOhmgLdkn6LoBRG8fV5dTAEgjmlbU=;
        b=Ng3w+qReOcloNLQQ0JPixuxXMMKOae1akRXoEb2J01muWWI1pZigQkmQdobhDAyjIQaY+6
        uUsZhC5i6116oLiiPJLKkzBHm1MSGmkSamSleusL9x0jUwAMTv7meZEn0OXmbzF5nG3VGZ
        pYjkZO23FUzhzr9uuBgFFoCJK8WLZpc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363-G1bArSXsOne7i05MQ5n15w-1; Mon, 06 Apr 2020 04:06:15 -0400
X-MC-Unique: G1bArSXsOne7i05MQ5n15w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0650D14E3;
        Mon,  6 Apr 2020 08:06:14 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-60.ams2.redhat.com [10.36.113.60])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7BA4E5DA81;
        Mon,  6 Apr 2020 08:06:13 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 69F1816E2C; Mon,  6 Apr 2020 10:06:12 +0200 (CEST)
Date:   Mon, 6 Apr 2020 10:06:12 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+d3a7951ed361037407db@syzkaller.appspotmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        DRI <dri-devel@lists.freedesktop.org>,
        virtualization@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: upstream boot error: KASAN: slab-out-of-bounds Write in
 virtio_gpu_object_create
Message-ID: <20200406080612.v5ubxvyliuso6v5h@sirius.home.kraxel.org>
References: <00000000000091056b05a2999f1e@google.com>
 <CACT4Y+b4RcgG_GrcpaghmqhX47zUVsAcGGd6vb6MYJT=6gf89g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+b4RcgG_GrcpaghmqhX47zUVsAcGGd6vb6MYJT=6gf89g@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 06, 2020 at 09:07:44AM +0200, Dmitry Vyukov wrote:
> On Mon, Apr 6, 2020 at 8:46 AM syzbot
> <syzbot+d3a7951ed361037407db@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following crash on:
> >
> > HEAD commit:    ffc1c20c Merge tag 'for-5.7/dm-changes' of git://git.kerne..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=1690471fe00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=d6a1e2f9a9986236
> > dashboard link: https://syzkaller.appspot.com/bug?extid=d3a7951ed361037407db
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> >
> > Unfortunately, I don't have any reproducer for this crash yet.
> >
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+d3a7951ed361037407db@syzkaller.appspotmail.com
> 
> 
> +drivers/gpu/drm/virtio/virtgpu_object.c maintainers
> Now we have both mainline and linux-next boot broken (linux-next is
> broken for the past 40 days).
> No testing of new code happens.
> 
> >  virtio_gpu_object_shmem_init drivers/gpu/drm/virtio/virtgpu_object.c:151 [inline]
> >  virtio_gpu_object_create+0x9f3/0xaa0 drivers/gpu/drm/virtio/virtgpu_object.c:230

Ah, that one.

broken patch: f651c8b05542 ("drm/virtio: factor out the sg_table from virtio_gpu_object")
fixed by: 0666a8d7f6a4 ("drm/virtio: fix OOB in virtio_gpu_object_create")

Both are in drm-misc-next.  I suspect the fix was added after
drm-misc-next was closed for the 5.7 merge window and thus should
have been submitted to drm-misc-next-fixes instead.

So, what to do now?  Should I cherry-pick 0666a8d7f6a4 into
drm-misc-next-fixes?  Or should it go into drm-misc-fixes instead?

thanks,
  Gerd

