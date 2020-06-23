Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E9DC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 16:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47FDD204EA
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 16:46:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P0SssR4d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733277AbgFWQqe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 12:46:34 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:35599 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1733227AbgFWQqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 12:46:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592930775;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xtESeAIlwwuuldGj0MjFCKFwVmKIYZPcQoRS/U4Z2AU=;
        b=P0SssR4dQ6DX12Wo9TpPDS4mlr4SmZgyRmkA5L1oIFH1jolgx9657VZFiTnWBl9R1nkV/t
        S1ez5lnj9ENG3wgSG3X60po2G2XNpiwg2Lixf7bT7Rdq60oPEFOozuEXzieZ7zrwnhHmNS
        2dOpxXExxG5AHeLin20AhkkjDBsXZVg=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-113-R3GQxw-4N5aIin6YfxPFvw-1; Tue, 23 Jun 2020 12:46:13 -0400
X-MC-Unique: R3GQxw-4N5aIin6YfxPFvw-1
Received: by mail-qk1-f198.google.com with SMTP id 16so15684450qka.15
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 09:46:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xtESeAIlwwuuldGj0MjFCKFwVmKIYZPcQoRS/U4Z2AU=;
        b=gnMoqaTnUWR5H/7EQ38FuzquhzrWCDlx/jL0pAuaZQ14qgkUORYK42nPFKiJL2qyy1
         NPCkEIsDM0bMvyAJlAc2Fc1LRBQy6FiVPaMGmgNO0CPZ3pte0vfMCxZNDOnrIhBsTLTo
         tmIh2D7Zd7kOUHOG7/p8A7BPI2aFlPgo/639yj+vFae287JXessw4SHJZYSvac99TVKy
         x4aAHwKDHK33carsk/jq0hGlijBmEvmlPjudN5oD7zu+r1RR5bbSyn29j/r4ZvlBUGtc
         Z4/UCLXIgo+gnUi/om/ac9NfEtLgstND8iBA3WUsx9LGGQT0poR5/VftMUO4I7POmjBR
         HzhA==
X-Gm-Message-State: AOAM532R40a4zEa9bMF8kSqaSAn1P/6Z5afzwPsnt249PNOU4SL+9xEl
        vOCk/Vv9/0JzO0ZXQ5pCrX0YjC0+IDkyeu12DbKHk8PPD0lFLVQH477JLuLUnjDONyfU83q43k+
        Qr7HYsdWAlBUiJBBRSfFfvIoZLNTky3xS5+VdLrH0
X-Received: by 2002:a05:620a:348:: with SMTP id t8mr20976642qkm.203.1592930772839;
        Tue, 23 Jun 2020 09:46:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzz/YK3q1LyztX9Y0BARpa7qb402eLsAUxVHw0c9TOmsYRIZiRnSKgf8Mmu2w5ZzLLOzR1QEUReYrD+dUL31gU=
X-Received: by 2002:a05:620a:348:: with SMTP id t8mr20976616qkm.203.1592930772589;
 Tue, 23 Jun 2020 09:46:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200619182302.850-1-eperezma@redhat.com> <20200619182302.850-3-eperezma@redhat.com>
 <20200623103746-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200623103746-mutt-send-email-mst@kernel.org>
From:   Eugenio Perez Martin <eperezma@redhat.com>
Date:   Tue, 23 Jun 2020 18:45:36 +0200
Message-ID: <CAJaqyWefmaENcnr+qaY3ezE2LoPp3+S_rLby_h1dRn2-N_nWfQ@mail.gmail.com>
Subject: Re: [RFC v9 02/11] vhost: use batched get_vq_desc version
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     kvm list <kvm@vger.kernel.org>,
        Stefano Garzarella <sgarzare@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 4:42 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Fri, Jun 19, 2020 at 08:22:53PM +0200, Eugenio P=C3=83=C2=A9rez wrote:
> > From: "Michael S. Tsirkin" <mst@redhat.com>
> >
> > As testing shows no performance change, switch to that now.
> >
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > Signed-off-by: Eugenio P=C3=83=C2=A9rez <eperezma@redhat.com>
> > Link: https://lore.kernel.org/r/20200401183118.8334-3-eperezma@redhat.c=
om
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > Signed-off-by: Eugenio P=C3=83=C2=A9rez <eperezma@redhat.com>
> > ---
> >  drivers/vhost/test.c  |   2 +-
> >  drivers/vhost/vhost.c | 314 ++++++++----------------------------------
> >  drivers/vhost/vhost.h |   7 +-
> >  3 files changed, 61 insertions(+), 262 deletions(-)
> >
> > diff --git a/drivers/vhost/test.c b/drivers/vhost/test.c
> > index a09dedc79f68..650e69261557 100644
> > --- a/drivers/vhost/test.c
> > +++ b/drivers/vhost/test.c
> > @@ -119,7 +119,7 @@ static int vhost_test_open(struct inode *inode, str=
uct file *f)
> >       dev =3D &n->dev;
> >       vqs[VHOST_TEST_VQ] =3D &n->vqs[VHOST_TEST_VQ];
> >       n->vqs[VHOST_TEST_VQ].handle_kick =3D handle_vq_kick;
> > -     vhost_dev_init(dev, vqs, VHOST_TEST_VQ_MAX, UIO_MAXIOV,
> > +     vhost_dev_init(dev, vqs, VHOST_TEST_VQ_MAX, UIO_MAXIOV + 64,
> >                      VHOST_TEST_PKT_WEIGHT, VHOST_TEST_WEIGHT, true, NU=
LL);
> >
> >       f->private_data =3D n;
> > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > index 2d784681b0fa..13021d6986eb 100644
> > --- a/drivers/vhost/vhost.c
> > +++ b/drivers/vhost/vhost.c
> > @@ -304,6 +304,7 @@ static void vhost_vq_reset(struct vhost_dev *dev,
> >  {
> >       vq->num =3D 1;
> >       vq->ndescs =3D 0;
> > +     vq->first_desc =3D 0;
> >       vq->desc =3D NULL;
> >       vq->avail =3D NULL;
> >       vq->used =3D NULL;
> > @@ -372,6 +373,11 @@ static int vhost_worker(void *data)
> >       return 0;
> >  }
> >
> > +static int vhost_vq_num_batch_descs(struct vhost_virtqueue *vq)
> > +{
> > +     return vq->max_descs - UIO_MAXIOV;
> > +}
> > +
> >  static void vhost_vq_free_iovecs(struct vhost_virtqueue *vq)
> >  {
> >       kfree(vq->descs);
>
>
> Batching is enabled if max_descs > UIO_MAXIOV.
>
> So this uses batching for test.
>
> But net is unchanged, so it is still not using the batched version.
> Is that right?
>

vhost_net already called vhost_dev_init with +VHOST_NET_BATCH (64):
vhost_dev_init(dev, vqs, VHOST_NET_VQ_MAX,
               UIO_MAXIOV + VHOST_NET_BATCH,
...

So it should be using batching in the same terms as vhost/test.
However I will double check it.

> I think a better subject would be "vhost/test: use batched get_vq_desc ve=
rsion".
>
> And that explains which testing it refers to: the one executed by vhost t=
est.
>
> I think there was a separate patch to enable that for net separately,
> but it got lost - or did I miss it?
>

Kind of. In V5 there were two separate commits: One adding the batch
version and another one making them the default.

Both of them were squashed in V6 but the result got the wrong commit
message. I will fix this in the next revisions.

But I don't find any specific commit to enable explicitly in net.

Thanks!




> --
> MST
>

