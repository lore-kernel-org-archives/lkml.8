Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25918C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 06:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F29D92076A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 06:02:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WKmlCZeY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728951AbgFHGCC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 02:02:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24055 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728343AbgFHGCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 02:02:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591596118;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h1jA/2yspI1Kg+Xtq3l1EAGzt+HBYj3BxWgseMub36o=;
        b=WKmlCZeYuo1TB6gMMzWd0DunV6KT3UKtnTBPqkkZUGutooBjHRNaJ0LYiTNC+y4u+kWMOX
        NhPrMoC1Ms2v8+IL0XvLq2hbIdU7XaajcJZIsZDBtqJDk4IC/fkeAD6S025OlpRau0gkKQ
        ad/b9vTBnOKCXKYAFmh8+k2xHpmFvIU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-479-4Yc8CZAjMaiDMzTjIzIryQ-1; Mon, 08 Jun 2020 02:01:56 -0400
X-MC-Unique: 4Yc8CZAjMaiDMzTjIzIryQ-1
Received: by mail-wm1-f72.google.com with SMTP id t145so4841334wmt.2
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jun 2020 23:01:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=h1jA/2yspI1Kg+Xtq3l1EAGzt+HBYj3BxWgseMub36o=;
        b=tOhdPVH18L/GYEiCqC+MZpeCMVxfv2+pID8FrgT8P5SjI4PB0V5HgdEGlFJezgDV5k
         GdrdtqFhc8s1NzYIwqRqETFb7BkKwY2hvZH9hLwznCdkiKrwyc/a8M7vXnnJRVnYpZg4
         RmjlfJp2y1Fc1lJdKy7UPWu/m3MswPHyhPboXuIFEZHQ0KBA+ntcAAVpU4EmSQS+OsP1
         H+VBdr7Mli0TWZQntlzyAR0fnrMkdrtphHAbFa0OBA7p6EM6I00qTGfVydwRIhv/FrC3
         9Pvt2ElQxNN1TGJE6vWztOKe9taAJrnD8gfFXF3+d0D5CFyIMbT1Mk7sZm25+LYALymy
         Hy4A==
X-Gm-Message-State: AOAM533cSUnbQ3eDDi0bfMPSQCSyk+3AEYGeJHw2laRYOWFqywjEovJZ
        ZdUJzZJkr9n8Jn7HPb1dbORJAL0oUszz9+5W7Cq+XEbW+etSEehJreofI6QAa0/S2JljdBVDvzp
        udDGU0A451ap0e6vBXFnuxuvi
X-Received: by 2002:a5d:468d:: with SMTP id u13mr23298768wrq.73.1591596115427;
        Sun, 07 Jun 2020 23:01:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyMtROZekUWaS9qn3KFC7xkMhTFpOrxDGPEfYMCPM7y6HFTjboC8wnw+oAxOEoXkXu0WIagpQ==
X-Received: by 2002:a5d:468d:: with SMTP id u13mr23298753wrq.73.1591596115216;
        Sun, 07 Jun 2020 23:01:55 -0700 (PDT)
Received: from redhat.com (bzq-109-64-41-91.red.bezeqint.net. [109.64.41.91])
        by smtp.gmail.com with ESMTPSA id g82sm21407426wmf.1.2020.06.07.23.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2020 23:01:54 -0700 (PDT)
Date:   Mon, 8 Jun 2020 02:01:52 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH RFC 03/13] vhost: batching fetches
Message-ID: <20200608020112-mutt-send-email-mst@kernel.org>
References: <20200602130543.578420-1-mst@redhat.com>
 <20200602130543.578420-4-mst@redhat.com>
 <3323daa2-19ed-02de-0ff7-ab150f949fff@redhat.com>
 <20200604045830-mutt-send-email-mst@kernel.org>
 <6c2e6cc7-27c5-445b-f252-0356ff8a83f3@redhat.com>
 <20200607095219-mutt-send-email-mst@kernel.org>
 <0d791fe6-8fbe-ddcc-07fa-efbd4fac5ea4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0d791fe6-8fbe-ddcc-07fa-efbd4fac5ea4@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 08, 2020 at 11:35:40AM +0800, Jason Wang wrote:
> 
> On 2020/6/7 下午9:57, Michael S. Tsirkin wrote:
> > On Fri, Jun 05, 2020 at 11:40:17AM +0800, Jason Wang wrote:
> > > On 2020/6/4 下午4:59, Michael S. Tsirkin wrote:
> > > > On Wed, Jun 03, 2020 at 03:27:39PM +0800, Jason Wang wrote:
> > > > > On 2020/6/2 下午9:06, Michael S. Tsirkin wrote:
> > > > > > With this patch applied, new and old code perform identically.
> > > > > > 
> > > > > > Lots of extra optimizations are now possible, e.g.
> > > > > > we can fetch multiple heads with copy_from/to_user now.
> > > > > > We can get rid of maintaining the log array.  Etc etc.
> > > > > > 
> > > > > > Signed-off-by: Michael S. Tsirkin<mst@redhat.com>
> > > > > > Signed-off-by: Eugenio Pérez<eperezma@redhat.com>
> > > > > > Link:https://lore.kernel.org/r/20200401183118.8334-4-eperezma@redhat.com
> > > > > > Signed-off-by: Michael S. Tsirkin<mst@redhat.com>
> > > > > > ---
> > > > > >     drivers/vhost/test.c  |  2 +-
> > > > > >     drivers/vhost/vhost.c | 47 ++++++++++++++++++++++++++++++++++++++-----
> > > > > >     drivers/vhost/vhost.h |  5 ++++-
> > > > > >     3 files changed, 47 insertions(+), 7 deletions(-)
> > > > > > 
> > > > > > diff --git a/drivers/vhost/test.c b/drivers/vhost/test.c
> > > > > > index 9a3a09005e03..02806d6f84ef 100644
> > > > > > --- a/drivers/vhost/test.c
> > > > > > +++ b/drivers/vhost/test.c
> > > > > > @@ -119,7 +119,7 @@ static int vhost_test_open(struct inode *inode, struct file *f)
> > > > > >     	dev = &n->dev;
> > > > > >     	vqs[VHOST_TEST_VQ] = &n->vqs[VHOST_TEST_VQ];
> > > > > >     	n->vqs[VHOST_TEST_VQ].handle_kick = handle_vq_kick;
> > > > > > -	vhost_dev_init(dev, vqs, VHOST_TEST_VQ_MAX, UIO_MAXIOV,
> > > > > > +	vhost_dev_init(dev, vqs, VHOST_TEST_VQ_MAX, UIO_MAXIOV + 64,
> > > > > >     		       VHOST_TEST_PKT_WEIGHT, VHOST_TEST_WEIGHT, NULL);
> > > > > >     	f->private_data = n;
> > > > > > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > > > > > index 8f9a07282625..aca2a5b0d078 100644
> > > > > > --- a/drivers/vhost/vhost.c
> > > > > > +++ b/drivers/vhost/vhost.c
> > > > > > @@ -299,6 +299,7 @@ static void vhost_vq_reset(struct vhost_dev *dev,
> > > > > >     {
> > > > > >     	vq->num = 1;
> > > > > >     	vq->ndescs = 0;
> > > > > > +	vq->first_desc = 0;
> > > > > >     	vq->desc = NULL;
> > > > > >     	vq->avail = NULL;
> > > > > >     	vq->used = NULL;
> > > > > > @@ -367,6 +368,11 @@ static int vhost_worker(void *data)
> > > > > >     	return 0;
> > > > > >     }
> > > > > > +static int vhost_vq_num_batch_descs(struct vhost_virtqueue *vq)
> > > > > > +{
> > > > > > +	return vq->max_descs - UIO_MAXIOV;
> > > > > > +}
> > > > > 1 descriptor does not mean 1 iov, e.g userspace may pass several 1 byte
> > > > > length memory regions for us to translate.
> > > > > 
> > > > Yes but I don't see the relevance. This tells us how many descriptors to
> > > > batch, not how many IOVs.
> > > Yes, but questions are:
> > > 
> > > - this introduce another obstacle to support more than 1K queue size
> > > - if we support 1K queue size, does it mean we need to cache 1K descriptors,
> > > which seems a large stress on the cache
> > > 
> > > Thanks
> > > 
> > > 
> > Still don't understand the relevance. We support up to 1K descriptors
> > per buffer just for IOV since we always did. This adds 64 more
> > descriptors - is that a big deal?
> 
> 
> If I understanding correctly, for net, the code tries to batch descriptors
> for at last one packet.
> 
> If we allow 1K queue size then we allow a packet that consists of 1K
> descriptors. Then we need to cache 1K descriptors.
> 
> Thanks

That case is already so pathological, I am not at all worried about
it performing well.

-- 
MST

