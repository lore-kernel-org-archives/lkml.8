Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C06AC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 17:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C25421532
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 17:57:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dHok0T2B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436499AbgFSR5B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 13:57:01 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:23650 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2404675AbgFSR4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 13:56:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592589403;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WcqrPcvDJb0ExZL7Rd/avo/FZMjKRYWp5ZMPjnD5nIw=;
        b=dHok0T2BJBE6itHP/T5lIWFHKakOeDJOceKEMKKF1YXxffTR0j0i3oBTLbrbzwgbAiJCxt
        Aj+M8V8Un/vBCtHZvdv7aLsIGgPAxf5bCT0VCqEJvR45L/5DeOd4M5XYKQSQp58u4EfpyE
        3pl6OUpVJOOKKuhwGYJYi5quupz8dBI=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-448-p8JdQDTQOGuVwQhNsM36kQ-1; Fri, 19 Jun 2020 13:56:41 -0400
X-MC-Unique: p8JdQDTQOGuVwQhNsM36kQ-1
Received: by mail-qt1-f200.google.com with SMTP id y5so7755465qto.10
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 10:56:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WcqrPcvDJb0ExZL7Rd/avo/FZMjKRYWp5ZMPjnD5nIw=;
        b=fFvnfxybgNXC5Qf9NyOSHvbug0/ke9YouJT7Vf/DeVC1CbSqv7iheW8ObwA67mpU24
         kDlhjVDFX9Fobev0smlQyVHijKGWjd2GzkkSjucMkSBXv3og41YGaKBnqKE1Lem9FY3t
         rihTfpAIO0qtiqt000lFuF7pnR4g+bGcK/3kXNUPtrp0O8eGp979PB5IGhfx1HqSNmdW
         1yLT7cufS/St7O/gZ491M0+aKLTzjjC/yjA0DNNAq5ilJ932XjemCaZxbDAU4lWFVJNR
         dCp05WrmFr+YYRlGes5h77RUdb5etgxY2UAvWh+QDiFcNbgVlD9ALROtButUJCHJnuYu
         IwkQ==
X-Gm-Message-State: AOAM532YyIMeOaSAl85+jUcSGfVb1XFx64AZ4824bqziSOdKAjiPnC6R
        /U9ZS5UlUR9NY8tIv7egH+WUiLqSgLZIpCaH5/6adkGGL+yULbSFeL9gGvxtUhXfTLIY3lf0iLb
        qDmJdYO1/eAAt4GlQigbbC7U1ZT6LU4yCl2Ch6R+V
X-Received: by 2002:a37:64c6:: with SMTP id y189mr4793910qkb.353.1592589400890;
        Fri, 19 Jun 2020 10:56:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxts4JUG/DUZlXwHieuKsAsn4bVIZKK4d+Lvr6aZFXHNaYrdVkmy8Kqr7GNRfSCb53+bLew1eRqhZdN3cQW/5s=
X-Received: by 2002:a37:64c6:: with SMTP id y189mr4793881qkb.353.1592589400629;
 Fri, 19 Jun 2020 10:56:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200611113404.17810-1-mst@redhat.com> <20200611113404.17810-3-mst@redhat.com>
 <0332b0cf-cf00-9216-042c-e870efa33626@redhat.com>
In-Reply-To: <0332b0cf-cf00-9216-042c-e870efa33626@redhat.com>
From:   Eugenio Perez Martin <eperezma@redhat.com>
Date:   Fri, 19 Jun 2020 19:56:04 +0200
Message-ID: <CAJaqyWcDb5GefbiBkcaMADFzWup7yvmvOekRmRQ40pqxdgB0eg@mail.gmail.com>
Subject: Re: [PATCH RFC v8 02/11] vhost: use batched get_vq_desc version
To:     Jason Wang <jasowang@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        linux-kernel@vger.kernel.org, kvm list <kvm@vger.kernel.org>,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 17, 2020 at 5:19 AM Jason Wang <jasowang@redhat.com> wrote:
>
>
> On 2020/6/11 =E4=B8=8B=E5=8D=887:34, Michael S. Tsirkin wrote:
> >   static void vhost_vq_free_iovecs(struct vhost_virtqueue *vq)
> >   {
> >       kfree(vq->descs);
> > @@ -394,6 +400,9 @@ static long vhost_dev_alloc_iovecs(struct vhost_dev=
 *dev)
> >       for (i =3D 0; i < dev->nvqs; ++i) {
> >               vq =3D dev->vqs[i];
> >               vq->max_descs =3D dev->iov_limit;
> > +             if (vhost_vq_num_batch_descs(vq) < 0) {
> > +                     return -EINVAL;
> > +             }
>
>
> This check breaks vdpa which set iov_limit to zero. Consider iov_limit
> is meaningless to vDPA, I wonder we can skip the test when device
> doesn't use worker.

I tested as

if (dev->use_worker && vhost_vq_num_batch_descs(vq) < 0)

In v9. Please let me know if that is ok for you.

Thanks!

>
> Thanks
>

