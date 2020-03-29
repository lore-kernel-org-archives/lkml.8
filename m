Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 156F9C2D0E5
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 12:20:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E19612073B
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 12:20:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a2lGXucn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728128AbgC2MUi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 08:20:38 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:35722 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727875AbgC2MUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 08:20:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585484436;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JV+swSpDvLiRyfF8zduIYF+N/77uMAWPzm2YG1hsv6E=;
        b=a2lGXucnr0oYXe/l1KoX6tzXbtnoB/ZFJnr4tTK1ALU2MJ7JwsCTDFk8AjMLYuXgseW+rl
        PygIBWN7fUwuaLIY+3eelsoB2lt/JOzBRFYv/Wif5nK8M79YX9b2KFZ7ctHV0jchl7GcxY
        rmvlQKp8RXB0GlqsKE/EDRRDwaVpFw4=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190-kIzB4iU6PN2FThZxbqnCvA-1; Sun, 29 Mar 2020 08:20:32 -0400
X-MC-Unique: kIzB4iU6PN2FThZxbqnCvA-1
Received: by mail-qt1-f200.google.com with SMTP id d26so5094467qtb.18
        for <linux-kernel@vger.kernel.org>; Sun, 29 Mar 2020 05:20:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JV+swSpDvLiRyfF8zduIYF+N/77uMAWPzm2YG1hsv6E=;
        b=mvnDlws0yuKJzDgs3zGddX0u824AihObaXX2WTYNA6uyI1qs8sORPLzwbSMpSpENWF
         hRBimYqLZTkxriETLxrAUEhJqyKD/fplUa7ME27bmXrMlEBKV9BBIorp02PLDR8cKToo
         wJjU/WQGoItP+D0oSs3AUhdnv+I8FNkiDiP0WRk9e2EQZvwj6BGWjSV59CEfjdl0Sv9D
         7of5sjuHHgjaV8JwS+bby+pTAJsgflJTdTorxon3WiHsy6WP6GJctwdEbp+7ouSSDBq8
         WBEYo07nhmiK9tx3FtwoKL0a8X/H9+zF1sKEYhgIhPMVi3iBABozYeZY1GWzpRkgE/r7
         vvPw==
X-Gm-Message-State: ANhLgQ1+vTNEpmr6xjhyfppQdhgeUjluJ74eIvmnsX0fmO37E2RhO9kf
        bBzHu53HeOls4+6yt/3dTp8EbO6x8K9/8glGnFDzZWSiL4HdLeIX2FP5SJQy5ZcYHZDeJHerAz3
        w/2YTDEw4lUD98t3eVent69ABJJqxb+8JuoiFZE4P
X-Received: by 2002:a37:648:: with SMTP id 69mr7654539qkg.353.1585484432325;
        Sun, 29 Mar 2020 05:20:32 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtuKBV3ksCZe4Rr2ouEcNs/zf3hutRMu9QCFjAIZrqsuNifj5DJq+Vsezn48JCHiYyh/9SYn2/cqGNyipdDUvA=
X-Received: by 2002:a37:648:: with SMTP id 69mr7654519qkg.353.1585484432049;
 Sun, 29 Mar 2020 05:20:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200329113359.30960-1-eperezma@redhat.com> <20200329074023-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200329074023-mutt-send-email-mst@kernel.org>
From:   Eugenio Perez Martin <eperezma@redhat.com>
Date:   Sun, 29 Mar 2020 14:19:55 +0200
Message-ID: <CAJaqyWdO8CHuWFJv+TRgYJ7a3Cb06Ln3prnQZs69L1PPw4Rj1Q@mail.gmail.com>
Subject: Re: [PATCH 0/6] vhost: Reset batched descriptors on SET_VRING_BASE call
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        Halil Pasic <pasic@linux.ibm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        Cornelia Huck <cohuck@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 29, 2020 at 1:49 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Sun, Mar 29, 2020 at 01:33:53PM +0200, Eugenio P=C3=A9rez wrote:
> > Vhost did not reset properly the batched descriptors on SET_VRING_BASE =
event. Because of that, is possible to return an invalid descriptor to the =
guest.
> > This series ammend this, and creates a test to assert correct behavior.=
 To do that, they need to expose a new function in virtio_ring, virtqueue_r=
eset_free_head. Not sure if this can be avoided.
>
> Question: why not reset the batch when private_data changes?
> At the moment both net and scsi poke at private data directly,
> if they do this through a wrapper we can use that to
> 1. check that vq mutex is taken properly
> 2. reset batching
>
> This seems like a slightly better API
>

I didn't do that way because qemu could just SET_BACKEND to -1 and
SET_BACKEND to the same one, with no call to SET_VRING. In this case,
I think that qemu should not change the descriptors already pushed. I
do agree with the interface to modify private_data properly (regarding
the mutex).

However, I can see how your proposal is safer, so we don't even need
to check if private_data is !=3D NULL when we have descriptors in the
batch_descs array. Also, this ioctls should not be in the hot path, so
we can change to that mode anyway.

> >
> > Also, change from https://lkml.org/lkml/2020/3/27/108 is not included, =
that avoids to update a variable in a loop where it can be updated once.
> >
> > This is meant to be applied on top of eccb852f1fe6bede630e2e4f1a121a81e=
34354ab in git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git, and some =
commits should be squashed with that series.
>
> Thanks a lot! I'll apply this for now so Christian can start testing,
> but I'd like the comment above addressed before I push this to Linus.
>
> > Eugenio P=C3=A9rez (6):
> >   tools/virtio: Add --batch option
> >   tools/virtio: Add --batch=3Drandom option
> >   tools/virtio: Add --reset=3Drandom
> >   tools/virtio: Make --reset reset ring idx
> >   vhost: Delete virtqueue batch_descs member
> >   fixup! vhost: batching fetches
> >
> >  drivers/vhost/test.c         |  57 ++++++++++++++++
> >  drivers/vhost/test.h         |   1 +
> >  drivers/vhost/vhost.c        |  12 +++-
> >  drivers/vhost/vhost.h        |   1 -
> >  drivers/virtio/virtio_ring.c |  18 +++++
> >  include/linux/virtio.h       |   2 +
> >  tools/virtio/linux/virtio.h  |   2 +
> >  tools/virtio/virtio_test.c   | 123 +++++++++++++++++++++++++++++++----
> >  8 files changed, 201 insertions(+), 15 deletions(-)
> >
> > --
> > 2.18.1
>

