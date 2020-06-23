Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5BF3C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 07:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6B5520724
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 07:01:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a/BcGEsJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731335AbgFWHBm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 03:01:42 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:29021 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731285AbgFWHBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 03:01:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592895696;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zy58zDIczPqYbbCU2I0rBDICf2p/vJOkTqkK2TZ8PAQ=;
        b=a/BcGEsJWnDpN1L/CQe/esfPC5/4bR7k18k//Ent0/sbaJDZbznMdGNBfmwfyzBkcDXFzy
        hAC8r2x60nKqPUAqI+NpVvSmCztawiShnkCUoHqvQkq3SXvGiNXHh6PWvAosDzZ79xGswF
        AnhjAuWOOTYyawEeKQNiE5zY/s947aA=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-5-m2WsfJ1lNIO4rCZPA7IJMw-1; Tue, 23 Jun 2020 03:01:35 -0400
X-MC-Unique: m2WsfJ1lNIO4rCZPA7IJMw-1
Received: by mail-qk1-f198.google.com with SMTP id x22so14630711qkj.6
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 00:01:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zy58zDIczPqYbbCU2I0rBDICf2p/vJOkTqkK2TZ8PAQ=;
        b=ss7kuKpjFNC6pU8gGFO9OXbLOnA3vhlIvAFWyPAZhO08Wx4ALhHvjSfrghAlXsMTEM
         F6cKE8TNmhO1UJQA1TKTIHqR5fp+HJSKc1mAotCWvf7Fa1fpErH4AjRlQkIwld4mNiN7
         WqtWMJ7pLqMCUAvLUpQDdUput4zgfK+9ICjko8DDPGkDAom186S2/gVI892AxmZkKGBx
         mrGL/Gjucwh8IHCbDIvsF/6tUNzbdYdNcE6KM94VJKQ8zlv+amjysqmXWwzGq4zAo40N
         K1dx+mlC+R8Ein9OKVVBjfr9d5AhUKOTO2JO0Tmp34ZEJ+Oj738Cc6UH95VnB6QhsKfT
         IsFQ==
X-Gm-Message-State: AOAM532jbTlo36i+5tZw6F6DwBOBthYsqg69EfJ67zgF46vZ9it1zR6g
        NRaHr56i9CD4anxA3nQAxg7cgRkt82/6AE/621ilw76yY0HSZYSKqwI8uJnpL0war/5n8vNlXca
        87KVS2ZUlYIPNg5REDmbHoFBYmIUdu3iqBl85pPnT
X-Received: by 2002:ae9:e841:: with SMTP id a62mr19452231qkg.497.1592895694369;
        Tue, 23 Jun 2020 00:01:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyOZBN3nbHPtHiWYdDSxBqd0YcCYWHIzJTjzaFifnLqnQv36MEZ0ptTmo2xbqy/ajLlIIBFDzPj3siE/rmhtiE=
X-Received: by 2002:ae9:e841:: with SMTP id a62mr19452207qkg.497.1592895693904;
 Tue, 23 Jun 2020 00:01:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200611113404.17810-1-mst@redhat.com> <20200611113404.17810-3-mst@redhat.com>
 <0332b0cf-cf00-9216-042c-e870efa33626@redhat.com> <20200622115946-mutt-send-email-mst@kernel.org>
 <c56cc86d-a420-79ca-8420-e99db91980fa@redhat.com>
In-Reply-To: <c56cc86d-a420-79ca-8420-e99db91980fa@redhat.com>
From:   Eugenio Perez Martin <eperezma@redhat.com>
Date:   Tue, 23 Jun 2020 09:00:57 +0200
Message-ID: <CAJaqyWc3C_Td_SpV97CuemkQH9vH+EL3sGgeWGE82E5gYxZNCA@mail.gmail.com>
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

On Tue, Jun 23, 2020 at 4:51 AM Jason Wang <jasowang@redhat.com> wrote:
>
>
> On 2020/6/23 =E4=B8=8A=E5=8D=8812:00, Michael S. Tsirkin wrote:
> > On Wed, Jun 17, 2020 at 11:19:26AM +0800, Jason Wang wrote:
> >> On 2020/6/11 =E4=B8=8B=E5=8D=887:34, Michael S. Tsirkin wrote:
> >>>    static void vhost_vq_free_iovecs(struct vhost_virtqueue *vq)
> >>>    {
> >>>     kfree(vq->descs);
> >>> @@ -394,6 +400,9 @@ static long vhost_dev_alloc_iovecs(struct vhost_d=
ev *dev)
> >>>     for (i =3D 0; i < dev->nvqs; ++i) {
> >>>             vq =3D dev->vqs[i];
> >>>             vq->max_descs =3D dev->iov_limit;
> >>> +           if (vhost_vq_num_batch_descs(vq) < 0) {
> >>> +                   return -EINVAL;
> >>> +           }
> >> This check breaks vdpa which set iov_limit to zero. Consider iov_limit=
 is
> >> meaningless to vDPA, I wonder we can skip the test when device doesn't=
 use
> >> worker.
> >>
> >> Thanks
> > It doesn't need iovecs at all, right?
> >
> > -- MST
>
>
> Yes, so we may choose to bypass the iovecs as well.
>
> Thanks
>

I think that the kmalloc_array returns ZERO_SIZE_PTR for all of them
in that case, so I didn't bother to skip the kmalloc_array parts.
Would you prefer to skip them all and let them NULL? Or have I
misunderstood what you mean?

Thanks!

