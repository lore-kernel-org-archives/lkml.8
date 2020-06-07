Return-Path: <SRS0=HPGY=7U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E2CBC433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 13:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E372A20663
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 13:57:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aTNdTtFt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbgFGN5T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jun 2020 09:57:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36710 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726522AbgFGN5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 09:57:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591538236;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vfoj+F+YdFYc+88chRAUvS2eMr2A8z0PiugZ6+kTuqY=;
        b=aTNdTtFtlI41bsnvuOuN8Nnyxq+su1pqF7+UVg5BHpyuEq5RipDkxzmWmGolOg2RfxV3RF
        HcgzbQI8pKU23macPwQHAH3CWJKXREytYA1snNXvsgRWWxawUjkPq/vokmyUCC6HuWmrra
        HDwoIdOHeIZqDvMz4/Tya5Er+ae+r2s=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-100-VRrE7V0UPhK-2Zy_16pStQ-1; Sun, 07 Jun 2020 09:57:14 -0400
X-MC-Unique: VRrE7V0UPhK-2Zy_16pStQ-1
Received: by mail-wr1-f71.google.com with SMTP id p9so6057246wrx.10
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jun 2020 06:57:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Vfoj+F+YdFYc+88chRAUvS2eMr2A8z0PiugZ6+kTuqY=;
        b=gcCsbAD7GfL40lV+IPzD8G9WZ7UWJQ9ItX33upQvOwsT6V2zE+JheOYPCYn/lk+vKJ
         qGOOxRrRBrH5PbUwtG/VA1mRi16djz1uIJYlcXtiPLt/vOR1S0xmM2LbRyT1O70xPhUe
         RvtMFQXDjBTVk438cY6WKwoUpiKb5JEkgiarO/BwWyp6PfugrrRLupQi5Xl9Y0QNzu0E
         cKSdCGFZnDnlX9rF6H/Fd9eENFiC0yGCt4wGAiCQmc0UDenihmRyowZlyEfmFfZMaLcb
         eSyky+L3aQ+95IQbkddtCXmXrgp1+6dEFkvMNziuEpQEv3IVN6HPi1e1aVv1zwAgf/SY
         BQUQ==
X-Gm-Message-State: AOAM532lE7BViBiMqV2FeV+cPQJg+tE8rStnboC/QgA6hxcUgjvo4kqB
        9E1q1bRnSLOmAv0fAh1McWOfOC5Q8obJgPzse/hPgKTACWCo0RADK/Nfj4h6hixNXf4yruJ7/O1
        xx45ANVr0mKpzeXYIC5gTitCI
X-Received: by 2002:adf:e692:: with SMTP id r18mr18040348wrm.192.1591538233486;
        Sun, 07 Jun 2020 06:57:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzdpLNXIJ5j1LCUCT+yl4S8d3+2bKw0KjrOrbk8tNVbTrugKBbeL7cu5E4wnBuzOcL/qjm20w==
X-Received: by 2002:adf:e692:: with SMTP id r18mr18040336wrm.192.1591538233326;
        Sun, 07 Jun 2020 06:57:13 -0700 (PDT)
Received: from redhat.com (bzq-82-81-31-23.red.bezeqint.net. [82.81.31.23])
        by smtp.gmail.com with ESMTPSA id o10sm20468647wrj.37.2020.06.07.06.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2020 06:57:12 -0700 (PDT)
Date:   Sun, 7 Jun 2020 09:57:10 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH RFC 03/13] vhost: batching fetches
Message-ID: <20200607095219-mutt-send-email-mst@kernel.org>
References: <20200602130543.578420-1-mst@redhat.com>
 <20200602130543.578420-4-mst@redhat.com>
 <3323daa2-19ed-02de-0ff7-ab150f949fff@redhat.com>
 <20200604045830-mutt-send-email-mst@kernel.org>
 <6c2e6cc7-27c5-445b-f252-0356ff8a83f3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6c2e6cc7-27c5-445b-f252-0356ff8a83f3@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 05, 2020 at 11:40:17AM +0800, Jason Wang wrote:
> 
> On 2020/6/4 下午4:59, Michael S. Tsirkin wrote:
> > On Wed, Jun 03, 2020 at 03:27:39PM +0800, Jason Wang wrote:
> > > On 2020/6/2 下午9:06, Michael S. Tsirkin wrote:
> > > > With this patch applied, new and old code perform identically.
> > > > 
> > > > Lots of extra optimizations are now possible, e.g.
> > > > we can fetch multiple heads with copy_from/to_user now.
> > > > We can get rid of maintaining the log array.  Etc etc.
> > > > 
> > > > Signed-off-by: Michael S. Tsirkin<mst@redhat.com>
> > > > Signed-off-by: Eugenio Pérez<eperezma@redhat.com>
> > > > Link:https://lore.kernel.org/r/20200401183118.8334-4-eperezma@redhat.com
> > > > Signed-off-by: Michael S. Tsirkin<mst@redhat.com>
> > > > ---
> > > >    drivers/vhost/test.c  |  2 +-
> > > >    drivers/vhost/vhost.c | 47 ++++++++++++++++++++++++++++++++++++++-----
> > > >    drivers/vhost/vhost.h |  5 ++++-
> > > >    3 files changed, 47 insertions(+), 7 deletions(-)
> > > > 
> > > > diff --git a/drivers/vhost/test.c b/drivers/vhost/test.c
> > > > index 9a3a09005e03..02806d6f84ef 100644
> > > > --- a/drivers/vhost/test.c
> > > > +++ b/drivers/vhost/test.c
> > > > @@ -119,7 +119,7 @@ static int vhost_test_open(struct inode *inode, struct file *f)
> > > >    	dev = &n->dev;
> > > >    	vqs[VHOST_TEST_VQ] = &n->vqs[VHOST_TEST_VQ];
> > > >    	n->vqs[VHOST_TEST_VQ].handle_kick = handle_vq_kick;
> > > > -	vhost_dev_init(dev, vqs, VHOST_TEST_VQ_MAX, UIO_MAXIOV,
> > > > +	vhost_dev_init(dev, vqs, VHOST_TEST_VQ_MAX, UIO_MAXIOV + 64,
> > > >    		       VHOST_TEST_PKT_WEIGHT, VHOST_TEST_WEIGHT, NULL);
> > > >    	f->private_data = n;
> > > > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > > > index 8f9a07282625..aca2a5b0d078 100644
> > > > --- a/drivers/vhost/vhost.c
> > > > +++ b/drivers/vhost/vhost.c
> > > > @@ -299,6 +299,7 @@ static void vhost_vq_reset(struct vhost_dev *dev,
> > > >    {
> > > >    	vq->num = 1;
> > > >    	vq->ndescs = 0;
> > > > +	vq->first_desc = 0;
> > > >    	vq->desc = NULL;
> > > >    	vq->avail = NULL;
> > > >    	vq->used = NULL;
> > > > @@ -367,6 +368,11 @@ static int vhost_worker(void *data)
> > > >    	return 0;
> > > >    }
> > > > +static int vhost_vq_num_batch_descs(struct vhost_virtqueue *vq)
> > > > +{
> > > > +	return vq->max_descs - UIO_MAXIOV;
> > > > +}
> > > 1 descriptor does not mean 1 iov, e.g userspace may pass several 1 byte
> > > length memory regions for us to translate.
> > > 
> > Yes but I don't see the relevance. This tells us how many descriptors to
> > batch, not how many IOVs.
> 
> 
> Yes, but questions are:
> 
> - this introduce another obstacle to support more than 1K queue size
> - if we support 1K queue size, does it mean we need to cache 1K descriptors,
> which seems a large stress on the cache
> 
> Thanks
> 
> 
> > 

Still don't understand the relevance. We support up to 1K descriptors
per buffer just for IOV since we always did. This adds 64 more
descriptors - is that a big deal?

