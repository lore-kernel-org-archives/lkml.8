Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5630C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 14:50:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2E2520732
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 14:50:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ie3xJGh2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730883AbgDMOuu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 10:50:50 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:56605 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729311AbgDMOus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 10:50:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586789446;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kr9KTKBU+/+uofMSqlPA49Feo8xCOB4FV94CTTUBStM=;
        b=Ie3xJGh2HXXs48PTp4+nVDP+w5Ls9wNGKrWOfDDBrItha44fdOidDK1IVJ9BV015QE8U5b
        Z9Lb+SRh8BbAyvNakFh9XdZrmaauPq2oU9Fa0MPb2NXp45piF8JSDNDGqxzKAEaY0IL9Ne
        jCFX4IF2wsyKLoj/YJGZnozDRGicmBQ=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-441-V9VchQAgPjOpLTsvryhp7w-1; Mon, 13 Apr 2020 10:50:43 -0400
X-MC-Unique: V9VchQAgPjOpLTsvryhp7w-1
Received: by mail-qt1-f199.google.com with SMTP id n89so9157966qte.15
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 07:50:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kr9KTKBU+/+uofMSqlPA49Feo8xCOB4FV94CTTUBStM=;
        b=IwWXYqL7TY9rxjXjYcdZsDlMtBOcz4La5/eO4h23+VdrJ9RkQxs0+26w5ww3gTkVIs
         Rq+mqG3q9Qz6aA0UNZnG24ShB+kelhZok6SnsV7Awy2GasaxBV/xAwWvZ0HwRXNZQ2O0
         1TGJOEsT1hnPPCH7k9JXkCOmAzO8ztotoIZuHswn5HCREmOmX1RPHJnvbgFar0Uav+sF
         3g7WkEXl2efgTAkvD0OhrKRAU6U/N2nxm2j/8a+6Vyy+SY1KqfiF8r53tpF7ieuke9Dz
         XcbwlJvDaWW53CHD+0bYQjmjalEtnGnm2v/vmRVoW5bZIVf725UaT1hDofusqhfkwUb2
         nzMA==
X-Gm-Message-State: AGi0PuY00QSgNS85NVPhJomuNGMSYYIR+2Oi1tPBQFLhbHk57ECUQEnK
        xQYngAhggLaA7AnrejLEJ7Ym/Eowcjrr4LFH/+kYONHwZobEumPyxOMG9jVFdspl6hgmsZGT+u/
        rUp6qcEd5d9CmcbDiWTP1qxF5cSAPQdLN6blS8/LA
X-Received: by 2002:a37:a090:: with SMTP id j138mr17159945qke.168.1586789443340;
        Mon, 13 Apr 2020 07:50:43 -0700 (PDT)
X-Google-Smtp-Source: APiQypIS1bM7/cnw0/cmr0zxcGu/p79bSOTSNpyLGH30P81IUc3vIXTO+mjh49kiiytoU5bQ/OGlrY1RcCqeUjyOqso=
X-Received: by 2002:a37:a090:: with SMTP id j138mr17159916qke.168.1586789443027;
 Mon, 13 Apr 2020 07:50:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200403165119.5030-1-eperezma@redhat.com> <20200413071044-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200413071044-mutt-send-email-mst@kernel.org>
From:   Eugenio Perez Martin <eperezma@redhat.com>
Date:   Mon, 13 Apr 2020 16:50:06 +0200
Message-ID: <CAJaqyWcOmzxfOodudSjrZa1SeYDZKiO3MFMy_w44cL_eaBhYDA@mail.gmail.com>
Subject: Re: [PATCH 0/8] tools/vhost: Reset virtqueue on tests
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     kvm list <kvm@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Cornelia Huck <cohuck@redhat.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 13, 2020 at 1:13 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Fri, Apr 03, 2020 at 06:51:11PM +0200, Eugenio P=C3=A9rez wrote:
> > This series add the tests used to validate the "vhost: Reset batched
> > descriptors on SET_VRING_BASE call" series, with a small change on the
> > reset code (delete an extra unneded reset on VHOST_SET_VRING_BASE).
> >
> > They are based on the tests sent back them, the ones that were not
> > included (reasons in that thread). This series changes:
> >
> > * Delete need to export the ugly function in virtio_ring, now all the
> > code is added in tools/virtio (except the one line fix).
> > * Add forgotten uses of vhost_vq_set_backend. Fix bad usage order in
> > vhost_test_set_backend.
> > * Drop random reset, not really needed.
> > * Minor changes updating tests code.
> >
> > This serie is meant to be applied on top of
> > 5de4e0b7068337cf0d4ca48a4011746410115aae in
> > git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git.
>
> Is this still needed?

("tools/virtio: fix virtio_test.c") indentation is actually cosmetic.
("vhost: Not cleaning batched descs in VHOST_SET_VRING_BASE ioctl")
just avoid to clean batches descriptors for a third time (they are
cleaned on backend removal and addition).

("vhost: Fix bad order in vhost_test_set_backend at enable") is
actually a fix, the test does not work properly without it. And
("tools/virtio: Reset index in virtio_test --reset.") Makes the test
work more similar than the actual VM does in a reset.

("tools/virtio: Use __vring_new_virtqueue in virtio_test.c") and
("tools/virtio: Extract virtqueue initialization in vq_reset") are
convenience commits to reach the previous two.

Lastly, ("tools/virtio: Use tools/include/list.h instead of stubs")
just removes stub code, I did it when I try to test vdpa code and it
seems to me a nice to have, but we can drop it from the patchset if
you don't see that way.

> The patches lack Signed-off-by and
> commit log descriptions, reference commit Ids without subject.
> See Documentation/process/submitting-patches.rst
>

Sorry, I will try to keep an eye on that from now on. I will send a v2
with Signed-off-by and extended descriptions if you see it ok.

Thanks!

> > Eugenio P=C3=A9rez (8):
> >   tools/virtio: fix virtio_test.c indentation
> >   vhost: Not cleaning batched descs in VHOST_SET_VRING_BASE ioctl
> >   vhost: Replace vq->private_data access by backend accesors
> >   vhost: Fix bad order in vhost_test_set_backend at enable
> >   tools/virtio: Use __vring_new_virtqueue in virtio_test.c
> >   tools/virtio: Extract virtqueue initialization in vq_reset
> >   tools/virtio: Reset index in virtio_test --reset.
> >   tools/virtio: Use tools/include/list.h instead of stubs
> >
> >  drivers/vhost/test.c        |  8 ++---
> >  drivers/vhost/vhost.c       |  1 -
> >  tools/virtio/linux/kernel.h |  7 +----
> >  tools/virtio/linux/virtio.h |  5 ++--
> >  tools/virtio/virtio_test.c  | 58 +++++++++++++++++++++++++++----------
> >  tools/virtio/vringh_test.c  |  2 ++
> >  6 files changed, 51 insertions(+), 30 deletions(-)
> >
> > --
> > 2.18.1
>

