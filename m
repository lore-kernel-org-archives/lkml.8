Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABEF5C352BE
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 12:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8023521D94
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 12:25:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y0FX8+rx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728718AbgDQMZL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 08:25:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35954 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727877AbgDQMZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 08:25:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587126309;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6SYQc5vlhk7XbIz6vBeT6lWe63ZtgKx7c9HrEfLpD3c=;
        b=Y0FX8+rxNBDfOTW28czAyRkFFSZXdemRWyDZzdATfQdk7aooakAe9zQdRSxp/89H9DyU9f
        vbaIPHwpr0OJSbeoUSqicnYdGwJbXCPYv1k9UvdVtiPW4dbN9M35l1Gl+sH8EvribjbLhv
        xI1hucvAORareMfuuF5TLS+wdNMPcos=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-325-Gt_P8W8uPQ6ZMchoKq0_bQ-1; Fri, 17 Apr 2020 08:25:08 -0400
X-MC-Unique: Gt_P8W8uPQ6ZMchoKq0_bQ-1
Received: by mail-qv1-f69.google.com with SMTP id u5so2024969qvt.12
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 05:25:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6SYQc5vlhk7XbIz6vBeT6lWe63ZtgKx7c9HrEfLpD3c=;
        b=T33a59It2KTOTInN6gV6XZ5yqvv3VJWdeZvBw4QGxsFpuU6qzzXFL887D3J8LGAi7X
         2tVqMgYe7lxThX2MHwPYcQtfLqhDHXsA+a9HVXGOlQb1uTcYmL/uvLjAe1Lcagshbqjw
         dLD1wwoSlpioOTXu1oXzB+GsUyd/3yt95lPSTiHOvLMFUfff8kjB405LNfh83cCutn8q
         sdQZqt754KutrMePiGr0XW1jGxipmWWJXv/3Z6gqV0dMvnEP791x0hOniBodFey5P+RS
         H8u3Fs01Pmj1TYSE8biHLhLJJthx9tLZLYX7zubNK2hhNy7e5K9p2okgi7J8CYt4t52V
         rVSA==
X-Gm-Message-State: AGi0PuauZbNkrgVYXXCko6xRkr347udTZlwJfRjux81r+veBXSzHV+6c
        LLuOOoUy0XFaOmvmLCAwTagHoIv/+CpMFh8WS8lFC+IWvBO/ughYWpLEG7KqGlxfH5cnyUF0hf6
        gDnf7UquuJJo9V4eVyJX8FWov6YDNbKAK3VHV6i7h
X-Received: by 2002:a37:7786:: with SMTP id s128mr2986057qkc.497.1587126307608;
        Fri, 17 Apr 2020 05:25:07 -0700 (PDT)
X-Google-Smtp-Source: APiQypKBfWZGJeymkb2lYpO2MfszDQFTMR0yiJ30RKxU2YF4NbhBMAq5PZqSKtDRB05J3D3z30Fv7G/YFuiyJNOVrTM=
X-Received: by 2002:a37:7786:: with SMTP id s128mr2986028qkc.497.1587126307322;
 Fri, 17 Apr 2020 05:25:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200416075643.27330-1-eperezma@redhat.com> <20200416075643.27330-6-eperezma@redhat.com>
 <20200416183244-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200416183244-mutt-send-email-mst@kernel.org>
From:   Eugenio Perez Martin <eperezma@redhat.com>
Date:   Fri, 17 Apr 2020 14:24:31 +0200
Message-ID: <CAJaqyWcuxG03+J+BW=fPb=JFKLPi0h5sRGv9cjWv63eyspS4Qg@mail.gmail.com>
Subject: Re: [PATCH v2 5/8] tools/virtio: Use __vring_new_virtqueue in virtio_test.c
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        Cornelia Huck <cohuck@redhat.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 17, 2020 at 12:33 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Thu, Apr 16, 2020 at 09:56:40AM +0200, Eugenio P=C3=A9rez wrote:
> > As updated in ("2a2d1382fe9d virtio: Add improved queue allocation API"=
)
> >
> > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
>
> Pls add motivation for these changes.
>

The original motivation was to make code as close as possible to
virtio_net. Also, it skips a (probably not expensive) initialization
in vring_new_virtqueue.

With the recent events, I think that this could be useful to test when
userspace and kernel use different struct layout, maybe with some
sanitizer. I can drop it if you don't see it the same way (or if I
didn't understand the problem and this does not help).

Thanks!

> > ---
> >  tools/virtio/virtio_test.c | 7 +++----
> >  1 file changed, 3 insertions(+), 4 deletions(-)
> >
> > diff --git a/tools/virtio/virtio_test.c b/tools/virtio/virtio_test.c
> > index 1d5144590df6..d9827b640c21 100644
> > --- a/tools/virtio/virtio_test.c
> > +++ b/tools/virtio/virtio_test.c
> > @@ -106,10 +106,9 @@ static void vq_info_add(struct vdev_info *dev, int=
 num)
> >       assert(r >=3D 0);
> >       memset(info->ring, 0, vring_legacy_size(num, 4096));
> >       vring_legacy_init(&info->vring, num, info->ring, 4096);
> > -     info->vq =3D vring_new_virtqueue(info->idx,
> > -                                    info->vring.num, 4096, &dev->vdev,
> > -                                    true, false, info->ring,
> > -                                    vq_notify, vq_callback, "test");
> > +     info->vq =3D
> > +             __vring_new_virtqueue(info->idx, info->vring, &dev->vdev,=
 true,
> > +                                   false, vq_notify, vq_callback, "tes=
t");
> >       assert(info->vq);
> >       info->vq->priv =3D info;
> >       vhost_vq_setup(dev, info);
> > --
> > 2.18.1
>

