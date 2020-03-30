Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2407BC2D0E9
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 07:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDE4520733
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 07:19:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XWCsIlO5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729479AbgC3HTG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 03:19:06 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:45527 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729373AbgC3HTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 03:19:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585552743;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5ndOQsprsy0rDZ1akOpvUvMPB3GOXP8NxcpZODWJ/64=;
        b=XWCsIlO5Bok4cU4ZOHIqRXuLejgYFtWhZMTt7Db/ZP3gYcB4+4Jm4XJGCaUz1ZTQYBWQTn
        D2OYSxfm6TZ2icskWpew2K553pvCx0GB1YOGieNVpMOvd3gOAeXudMr3gmDAa9OjjpjJSR
        Lr7cjyLemll+8g3ik6OzgxfWkRQfSns=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-mCCvKRwiNNW3hyg1s5mbgg-1; Mon, 30 Mar 2020 03:18:59 -0400
X-MC-Unique: mCCvKRwiNNW3hyg1s5mbgg-1
Received: by mail-qk1-f197.google.com with SMTP id w195so14265640qkb.10
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 00:18:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5ndOQsprsy0rDZ1akOpvUvMPB3GOXP8NxcpZODWJ/64=;
        b=EVFq73TlnxjyxE5YP5UdJmt2J6qMAdh1Hc5LyCb5Xj1+stMK0W371BdrdZ4UjFnzbC
         fdI+7U2yZlGYD1BpmvMwweMtRbpxuJUOyz57k6iiMK/0dvOJBZjM9g/Q3tye4UFGG5Sl
         SEQnP1/Cve+pcPVhG06G4CVxPvAZz5q3FrGUqxo1EKUd3I4VOE+/cydqOKaxZy0MWYrm
         a33+yJoE9Vo4EzI5Lc1ZW5Tgx7idItO92DsHLqo8ZrXHxc3iiW7DN8wkz6wylN/42fC7
         D+oA3YRhjhtyLM5OZU/qtQ0gC3T17cGYvOnt3Jsd6oedUWeVh2wUIZXqm92A2evgMhjS
         1/bA==
X-Gm-Message-State: ANhLgQ2LrQ4me/E/8VaY6LuBbSXXENGb5GMnGRsvenBClmGjZghLDJ7C
        bDy5V/eNjA3dlQcj97n+HwpUy+W9WNsFPycXH9kU3tdaFKnDHoC7AdBN74ddC2LWltiqj6F48L9
        N4bX7lVSU0lVv0pWlDYLAyuENzo5Lb4nu0+9WPhYt
X-Received: by 2002:ac8:740b:: with SMTP id p11mr4272137qtq.379.1585552739244;
        Mon, 30 Mar 2020 00:18:59 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vthgONhLcNuIaHQCwo4a9iIoIcpLwlFSG4sBnK8dC+inDlYKb1GHGPlwu8yPOeO0Fm0D3Ijy5om00tWQk8V4TE=
X-Received: by 2002:ac8:740b:: with SMTP id p11mr4272127qtq.379.1585552738977;
 Mon, 30 Mar 2020 00:18:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200329113359.30960-1-eperezma@redhat.com> <bb95e827-f219-32fd-0046-41046eec058b@de.ibm.com>
In-Reply-To: <bb95e827-f219-32fd-0046-41046eec058b@de.ibm.com>
From:   Eugenio Perez Martin <eperezma@redhat.com>
Date:   Mon, 30 Mar 2020 09:18:22 +0200
Message-ID: <CAJaqyWePfMcXhYEPxKYV22J3cYtO=DUXCj1Yf=7XH+khXHop9A@mail.gmail.com>
Subject: Re: [PATCH 0/6] vhost: Reset batched descriptors on SET_VRING_BASE call
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        Halil Pasic <pasic@linux.ibm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        Cornelia Huck <cohuck@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 30, 2020 at 9:14 AM Christian Borntraeger
<borntraeger@de.ibm.com> wrote:
>
>
> On 29.03.20 13:33, Eugenio P=C3=A9rez wrote:
> > Vhost did not reset properly the batched descriptors on SET_VRING_BASE =
event. Because of that, is possible to return an invalid descriptor to the =
guest.
>
> I guess this could explain my problems that I have seen during reset?
>

Yes, I think so. The series has a test that should reproduce more or
less what you are seeing. However, it would be useful to reproduce on
your system and to know what causes qemu to send the reset :).

Thanks!

> >
> > This series ammend this, and creates a test to assert correct behavior.=
 To do that, they need to expose a new function in virtio_ring, virtqueue_r=
eset_free_head. Not sure if this can be avoided.
> >
> > Also, change from https://lkml.org/lkml/2020/3/27/108 is not included, =
that avoids to update a variable in a loop where it can be updated once.
> >
> > This is meant to be applied on top of eccb852f1fe6bede630e2e4f1a121a81e=
34354ab in git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git, and some =
commits should be squashed with that series.
> >
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
>

