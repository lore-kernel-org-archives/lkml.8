Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB8FC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 15:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94E382073E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 15:54:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y6jIt2KF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733057AbgFWPyl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 11:54:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60364 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1733013AbgFWPyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 11:54:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592927678;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hkLiUukuiXYIVGoeVwJVWCpKIqIZbdauaKoo+m3/3nA=;
        b=Y6jIt2KFpBShAPPnXvLS4SWze1RLVA3IEajWhpLZ3yz7QK5oRo3go2Pp5ZWJgesy6saotd
        XD7CAhXecBCyy91Ra+CniEH1OEXcZ/TzjvPk3r5XOQJIQ7ndxOlne8Gy1EMvEkZ5IfTqAC
        giOsSEd4Vsqg8mfXiEX5FPV8HLgI6wY=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-206-BGpIunpIOiyA9fO4kLAebg-1; Tue, 23 Jun 2020 11:54:37 -0400
X-MC-Unique: BGpIunpIOiyA9fO4kLAebg-1
Received: by mail-qv1-f70.google.com with SMTP id v20so2146358qvt.15
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 08:54:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hkLiUukuiXYIVGoeVwJVWCpKIqIZbdauaKoo+m3/3nA=;
        b=EWJQHAzMg3ti/6YWHGSdsBK745dKTWBHM8BPs/PjQdyrtN9IyksiAjZ69xGsqeG/xG
         xuxwnKy/1NEA2qd2bqIxPxu/aqkHwZ6Xc9kZxonkj1BUb1y5R+sWTXoTFRRK8YFoYqhV
         Hs528V0c5RfILRG3Y3NR3SFqtHglZZBU2HUe6wEUXjE8qxpD2lXXPycpxG2LSMyKH9xP
         OntESVcemJLXUTyE5T+2wwA/wQERLIt4nMnl1qhCUP0Up5jcXlC4869wSrx+uerJBUVX
         lxphIBwQt4a2XuiPSb+EczYQyFIlTF803RPdQefo0Mpp5/nleP5qsLIJWk9KsHnSkJ1+
         Ru/Q==
X-Gm-Message-State: AOAM532lpQoN7Jo6BalzGJMcDnUXng5gWNh1DmFihPs2BA+BGXs6ySbP
        baKxCVHga1prc3iZrBPbbGKjAtE1vWLcWro7/BCdRWNII5O5vh7gBnQ2tNG8+XIdCvdwZFuC211
        jdX5rQQ6cboAS3P+B+tc0k9O5TfgeIupAntKbYDhm
X-Received: by 2002:ad4:4732:: with SMTP id l18mr3784728qvz.208.1592927676567;
        Tue, 23 Jun 2020 08:54:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxaMrF3dl8inlInwgi9ZvOstGos06ueqsrxUIfXtsW401PD1wsBXR5y4aT0AAuSJXkN6jcwtfzXMTpt1KtoBl0=
X-Received: by 2002:ad4:4732:: with SMTP id l18mr3784714qvz.208.1592927676350;
 Tue, 23 Jun 2020 08:54:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200611113404.17810-1-mst@redhat.com> <20200611113404.17810-3-mst@redhat.com>
 <0332b0cf-cf00-9216-042c-e870efa33626@redhat.com> <20200622115946-mutt-send-email-mst@kernel.org>
 <c56cc86d-a420-79ca-8420-e99db91980fa@redhat.com> <CAJaqyWc3C_Td_SpV97CuemkQH9vH+EL3sGgeWGE82E5gYxZNCA@mail.gmail.com>
 <20200623042456-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200623042456-mutt-send-email-mst@kernel.org>
From:   Eugenio Perez Martin <eperezma@redhat.com>
Date:   Tue, 23 Jun 2020 17:54:00 +0200
Message-ID: <CAJaqyWfKdOUwnG50a1ni=MBEwfM5qp-h+zj1xbT4xUbvKGP5iw@mail.gmail.com>
Subject: Re: [PATCH RFC v8 02/11] vhost: use batched get_vq_desc version
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org,
        kvm list <kvm@vger.kernel.org>,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 10:25 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Tue, Jun 23, 2020 at 09:00:57AM +0200, Eugenio Perez Martin wrote:
> > On Tue, Jun 23, 2020 at 4:51 AM Jason Wang <jasowang@redhat.com> wrote:
> > >
> > >
> > > On 2020/6/23 =E4=B8=8A=E5=8D=8812:00, Michael S. Tsirkin wrote:
> > > > On Wed, Jun 17, 2020 at 11:19:26AM +0800, Jason Wang wrote:
> > > >> On 2020/6/11 =E4=B8=8B=E5=8D=887:34, Michael S. Tsirkin wrote:
> > > >>>    static void vhost_vq_free_iovecs(struct vhost_virtqueue *vq)
> > > >>>    {
> > > >>>     kfree(vq->descs);
> > > >>> @@ -394,6 +400,9 @@ static long vhost_dev_alloc_iovecs(struct vho=
st_dev *dev)
> > > >>>     for (i =3D 0; i < dev->nvqs; ++i) {
> > > >>>             vq =3D dev->vqs[i];
> > > >>>             vq->max_descs =3D dev->iov_limit;
> > > >>> +           if (vhost_vq_num_batch_descs(vq) < 0) {
> > > >>> +                   return -EINVAL;
> > > >>> +           }
> > > >> This check breaks vdpa which set iov_limit to zero. Consider iov_l=
imit is
> > > >> meaningless to vDPA, I wonder we can skip the test when device doe=
sn't use
> > > >> worker.
> > > >>
> > > >> Thanks
> > > > It doesn't need iovecs at all, right?
> > > >
> > > > -- MST
> > >
> > >
> > > Yes, so we may choose to bypass the iovecs as well.
> > >
> > > Thanks
> > >
> >
> > I think that the kmalloc_array returns ZERO_SIZE_PTR for all of them
> > in that case, so I didn't bother to skip the kmalloc_array parts.
> > Would you prefer to skip them all and let them NULL? Or have I
> > misunderstood what you mean?
> >
> > Thanks!
>
> Sorry about being unclear. I just meant that it seems cleaner
> to check for iov_limit being 0 not for worker thread.

Actually yes, I also think that iov_limit =3D=3D 0 is a better check.
Changing for the next revision if everyone agrees.

Thanks!

>
> --
> MST
>

