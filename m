Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 890A1C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 08:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6123720738
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 08:25:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fVb3U84p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731815AbgFWIZz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 04:25:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24456 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731783AbgFWIZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 04:25:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592900752;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uatLoTht3LpxtV8y54s42CvqtAcAPf7U2lYUBgXuz/c=;
        b=fVb3U84p2K2Yg+P/gazZWZawGmI4PlUwIxqiyU/xOwJ46x7o8PuY/6PZmCGXjFeVPFbL2d
        kh5IEEmuSLpgzhBhboXsUUB2cXqXyU75nE1M69H3ROW2WVU22x0tocnY2gpH/Vga3wR6s6
        DhFC3VDudS6Uh4nNWD4lM1AdnW8Hc/E=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-323-ytcp8kokMtmwT0Z6HcJ-Qg-1; Tue, 23 Jun 2020 04:25:50 -0400
X-MC-Unique: ytcp8kokMtmwT0Z6HcJ-Qg-1
Received: by mail-wr1-f70.google.com with SMTP id l3so5264191wrw.4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 01:25:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=uatLoTht3LpxtV8y54s42CvqtAcAPf7U2lYUBgXuz/c=;
        b=g1aB5aZNjzn9j4oIDZbrj9CrmcxJvRtr7dwOPnX/Gcfi/KR/u29b+fsTVuA9WNdZVq
         sFVjrbrGrI6XqFWRmlLVle1MO8gOnDKQoOQl+r8TE5MsYgd1ydOr1V6ogyxD26fYlXg+
         lMHypBEVQ8Q/HuUKidH9HpJ6PcyXMlrFHe+kBIdT/FI1m6FzLmK4mjKUmuK1zXDwzewI
         YNRGnV66s8q5wNYY/mbfA14ZZKaNne8jMgo46SV6ppF2tXTtTWonidZsZrID2dRh8qFQ
         t8cGA4vSvpvzIG64aEQwrYiRvsEPPPgOzr+qwKy1+obidipnFXzHVjLZIZ8yJrcmF+LO
         5ddQ==
X-Gm-Message-State: AOAM533odQrE+8AWG0iKskpUXazU3hlkD6Vk6Vwvvopnbl8B50W3oEb0
        cbA5rL1xwreWX9SQCHVlFFDRF1Y/dFUUlt5jQMPIcZbC1k3wzvnBTqsMh3Dm/ArGdb8uPZ5q5gv
        uxDoA6XNGurvzXBqlA7FRe82U
X-Received: by 2002:adf:e482:: with SMTP id i2mr36534wrm.75.1592900749388;
        Tue, 23 Jun 2020 01:25:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwc3XogzeNwsdZ7v2sDlZRwXqKbrYs2e6doW+SBbFx4Sho/d0OEnV4LbHlJbrymQKkvurtxAg==
X-Received: by 2002:adf:e482:: with SMTP id i2mr36515wrm.75.1592900749185;
        Tue, 23 Jun 2020 01:25:49 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
        by smtp.gmail.com with ESMTPSA id e5sm19713184wrs.33.2020.06.23.01.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 01:25:48 -0700 (PDT)
Date:   Tue, 23 Jun 2020 04:25:46 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Eugenio Perez Martin <eperezma@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org,
        kvm list <kvm@vger.kernel.org>,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [PATCH RFC v8 02/11] vhost: use batched get_vq_desc version
Message-ID: <20200623042456-mutt-send-email-mst@kernel.org>
References: <20200611113404.17810-1-mst@redhat.com>
 <20200611113404.17810-3-mst@redhat.com>
 <0332b0cf-cf00-9216-042c-e870efa33626@redhat.com>
 <20200622115946-mutt-send-email-mst@kernel.org>
 <c56cc86d-a420-79ca-8420-e99db91980fa@redhat.com>
 <CAJaqyWc3C_Td_SpV97CuemkQH9vH+EL3sGgeWGE82E5gYxZNCA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJaqyWc3C_Td_SpV97CuemkQH9vH+EL3sGgeWGE82E5gYxZNCA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 09:00:57AM +0200, Eugenio Perez Martin wrote:
> On Tue, Jun 23, 2020 at 4:51 AM Jason Wang <jasowang@redhat.com> wrote:
> >
> >
> > On 2020/6/23 上午12:00, Michael S. Tsirkin wrote:
> > > On Wed, Jun 17, 2020 at 11:19:26AM +0800, Jason Wang wrote:
> > >> On 2020/6/11 下午7:34, Michael S. Tsirkin wrote:
> > >>>    static void vhost_vq_free_iovecs(struct vhost_virtqueue *vq)
> > >>>    {
> > >>>     kfree(vq->descs);
> > >>> @@ -394,6 +400,9 @@ static long vhost_dev_alloc_iovecs(struct vhost_dev *dev)
> > >>>     for (i = 0; i < dev->nvqs; ++i) {
> > >>>             vq = dev->vqs[i];
> > >>>             vq->max_descs = dev->iov_limit;
> > >>> +           if (vhost_vq_num_batch_descs(vq) < 0) {
> > >>> +                   return -EINVAL;
> > >>> +           }
> > >> This check breaks vdpa which set iov_limit to zero. Consider iov_limit is
> > >> meaningless to vDPA, I wonder we can skip the test when device doesn't use
> > >> worker.
> > >>
> > >> Thanks
> > > It doesn't need iovecs at all, right?
> > >
> > > -- MST
> >
> >
> > Yes, so we may choose to bypass the iovecs as well.
> >
> > Thanks
> >
> 
> I think that the kmalloc_array returns ZERO_SIZE_PTR for all of them
> in that case, so I didn't bother to skip the kmalloc_array parts.
> Would you prefer to skip them all and let them NULL? Or have I
> misunderstood what you mean?
> 
> Thanks!

Sorry about being unclear. I just meant that it seems cleaner
to check for iov_limit being 0 not for worker thread.

-- 
MST

