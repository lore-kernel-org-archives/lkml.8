Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F98C47247
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 16:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EDD1208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 16:25:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hFSnA7+d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbgD3QZe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 12:25:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22195 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726472AbgD3QZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 12:25:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588263931;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d7EAntEKWCxipEsZHA3JwdCBrte3X/EzEzWCEi3iTqU=;
        b=hFSnA7+dVVHisruCYa2T6yMhX32scU91C5PMmT+S3RfA+OqS99sPN6bXcz6EpRJb8fe+5c
        5HZgqUFwDNzpvuZXgfaby+u6LrstGTG786aLvoO3qxSRuALw7WRCa4kczDEitgTy5fHvGn
        CSRI2WDYbhagrMNyBkhEPgVRNglhY2I=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-311-Ea7PDllaNzKXxvScSK_AIw-1; Thu, 30 Apr 2020 12:25:27 -0400
X-MC-Unique: Ea7PDllaNzKXxvScSK_AIw-1
Received: by mail-wr1-f70.google.com with SMTP id q10so4134612wrv.10
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 09:25:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=d7EAntEKWCxipEsZHA3JwdCBrte3X/EzEzWCEi3iTqU=;
        b=FRpD3UJf68z9NbCTG/jwexPJyDQPGQH9S8ShuBjOWx/bF8qJqLhZeOAXKF2xAYTiJJ
         qwrZsmWK2iEg22WtqYBstgHURP3eE4+I9u0b3Ll2n/8LoTeARGdD3Pooegbh1r6LL8aL
         dioTeLmLyfd3Ft/5AUHw1QAA4thRIyv4ojlbtTQAAacEQ7KbxZ6FMNs472KB+FdXcdv1
         Awm8CcBEbTFgWwo4+5eiMdnk6bdkqQ7gGqWTcBA2PAqj1XWDWJd9HSHL06BPhAYRxfgH
         8FcFrmT3FdE6+1gmalwHuqi6mx5/vhFMAHQvn4lUo+IOY7myvEP5zLZ38s0vsDFqENMC
         pyZw==
X-Gm-Message-State: AGi0Puah9X3GtYZIDM48CPcH0E1g4E92fo5XRIy5pEov7IELWjM8payz
        5Rn+p45pRGrF6FB6+KyEgQTZzR+7xb4LekZQe+gkzLRO9pAwqDXqqSbJgrtUJbceAWS76HmKp92
        lLIQNeMxSoiixVdARkftLNUFD
X-Received: by 2002:adf:a309:: with SMTP id c9mr4517823wrb.97.1588263925971;
        Thu, 30 Apr 2020 09:25:25 -0700 (PDT)
X-Google-Smtp-Source: APiQypJxesyQ6DenL8g0PuIkRunaGDhr2hm8E0YBRtppq+/ppdUI56ZVeSiHPILMSpR5MD6bxfp4uQ==
X-Received: by 2002:adf:a309:: with SMTP id c9mr4517792wrb.97.1588263925657;
        Thu, 30 Apr 2020 09:25:25 -0700 (PDT)
Received: from steredhat (host108-207-dynamic.49-79-r.retail.telecomitalia.it. [79.49.207.108])
        by smtp.gmail.com with ESMTPSA id x18sm351018wrv.12.2020.04.30.09.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 09:25:24 -0700 (PDT)
Date:   Thu, 30 Apr 2020 18:25:21 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Justin He <Justin.He@arm.com>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kaly Xin <Kaly.Xin@arm.com>
Subject: Re: [PATCH] vhost: vsock: don't send pkt when vq is not started
Message-ID: <20200430162521.k4b4t3vttfabgqal@steredhat>
References: <20200430021314.6425-1-justin.he@arm.com>
 <20200430082608.wbtqgglmtnd7e5ci@steredhat>
 <AM6PR08MB4069D4AB611B8C8180DC4B9CF7AA0@AM6PR08MB4069.eurprd08.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AM6PR08MB4069D4AB611B8C8180DC4B9CF7AA0@AM6PR08MB4069.eurprd08.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 30, 2020 at 10:06:26AM +0000, Justin He wrote:
> Hi Stefano
> 
> > -----Original Message-----
> > From: Stefano Garzarella <sgarzare@redhat.com>
> > Sent: Thursday, April 30, 2020 4:26 PM
> > To: Justin He <Justin.He@arm.com>
> > Cc: Stefan Hajnoczi <stefanha@redhat.com>; Michael S. Tsirkin
> > <mst@redhat.com>; Jason Wang <jasowang@redhat.com>;
> > kvm@vger.kernel.org; virtualization@lists.linux-foundation.org;
> > netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Kaly Xin
> > <Kaly.Xin@arm.com>
> > Subject: Re: [PATCH] vhost: vsock: don't send pkt when vq is not started
> >
> > Hi Jia,
> > thanks for the patch, some comments below:
> >
> > On Thu, Apr 30, 2020 at 10:13:14AM +0800, Jia He wrote:
> > > Ning Bo reported an abnormal 2-second gap when booting Kata container
> > [1].
> > > The unconditional timeout is caused by
> > VSOCK_DEFAULT_CONNECT_TIMEOUT of
> > > connect at client side. The vhost vsock client tries to connect an
> > > initlizing virtio vsock server.
> > >
> > > The abnormal flow looks like:
> > > host-userspace           vhost vsock                       guest vsock
> > > ==============           ===========                       ============
> > > connect()     -------->  vhost_transport_send_pkt_work()   initializing
> > >    |                     vq->private_data==NULL
> > >    |                     will not be queued
> > >    V
> > > schedule_timeout(2s)
> > >                          vhost_vsock_start()  <---------   device ready
> > >                          set vq->private_data
> > >
> > > wait for 2s and failed
> > >
> > > connect() again          vq->private_data!=NULL          recv connecting pkt
> > >
> > > 1. host userspace sends a connect pkt, at that time, guest vsock is under
> > > initializing, hence the vhost_vsock_start has not been called. So
> > > vq->private_data==NULL, and the pkt is not been queued to send to guest.
> > > 2. then it sleeps for 2s
> > > 3. after guest vsock finishes initializing, vq->private_data is set.
> > > 4. When host userspace wakes up after 2s, send connecting pkt again,
> > > everything is fine.
> > >
> > > This fixes it by checking vq->private_data in vhost_transport_send_pkt,
> > > and return at once if !vq->private_data. This makes user connect()
> > > be returned with ECONNREFUSED.
> > >
> > > After this patch, kata-runtime (with vsock enabled) boottime reduces from
> > > 3s to 1s on ThunderX2 arm64 server.
> > >
> > > [1] https://github.com/kata-containers/runtime/issues/1917
> > >
> > > Reported-by: Ning Bo <n.b@live.com>
> > > Signed-off-by: Jia He <justin.he@arm.com>
> > > ---
> > >  drivers/vhost/vsock.c | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > >
> > > diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> > > index e36aaf9ba7bd..67474334dd88 100644
> > > --- a/drivers/vhost/vsock.c
> > > +++ b/drivers/vhost/vsock.c
> > > @@ -241,6 +241,7 @@ vhost_transport_send_pkt(struct virtio_vsock_pkt
> > *pkt)
> > >  {
> > >  struct vhost_vsock *vsock;
> > >  int len = pkt->len;
> > > +struct vhost_virtqueue *vq;
> > >
> > >  rcu_read_lock();
> > >
> > > @@ -252,6 +253,13 @@ vhost_transport_send_pkt(struct virtio_vsock_pkt
> > *pkt)
> > >  return -ENODEV;
> > >  }
> > >
> > > +vq = &vsock->vqs[VSOCK_VQ_RX];
> > > +if (!vq->private_data) {
> >
> > I think is better to use vhost_vq_get_backend():
> >
> > if (!vhost_vq_get_backend(&vsock->vqs[VSOCK_VQ_RX])) {
> > ...
> >
> > This function should be called with 'vq->mutex' acquired as explained in
> > the comment, but here we can avoid that, because we are not using the vq,
> > so it is safe, because in vhost_transport_do_send_pkt() we check it again.
> >
> > Please add a comment explaining that.
> >
> 
> Thanks, vhost_vq_get_backend is better. I chose a 5.3 kernel to develop
> and missed this helper.

:-)

> >
> > As an alternative to this patch, should we kick the send worker when the
> > device is ready?
> >
> > IIUC we reach the timeout because the send worker (that runs
> > vhost_transport_do_send_pkt()) exits immediately since 'vq->private_data'
> > is NULL, and no one will requeue it.
> >
> > Let's do it when we know the device is ready:
> >
> > diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> > index e36aaf9ba7bd..295b5867944f 100644
> > --- a/drivers/vhost/vsock.c
> > +++ b/drivers/vhost/vsock.c
> > @@ -543,6 +543,11 @@ static int vhost_vsock_start(struct vhost_vsock
> > *vsock)
> >                 mutex_unlock(&vq->mutex);
> >         }
> >
> > +       /* Some packets may have been queued before the device was started,
> > +        * let's kick the send worker to send them.
> > +        */
> > +       vhost_work_queue(&vsock->dev, &vsock->send_pkt_work);
> > +
> Yes, it works.
> But do you think a threshold should be set here to prevent the queue
> from being too long? E.g. the client user sends too many connect pkts
> in a short time before the server is completely ready.

When the user call the connect() the socket status is moved to
SS_CONNECTING (see net/vmw_vsock/af_vsock.c), so another connect() on
the same socket will receive EALREADY error.

If the user uses multiple sockets, the socket layer already check for
any limits, so I don't think we should put a threshold here.

> 
> >         mutex_unlock(&vsock->dev.mutex);
> >         return 0;
> >
> > I didn't test it, can you try if it fixes the issue?
> >
> > I'm not sure which is better...
> I don't know, either. Wait for more comments 😊

I prefer the second option, because the device is in a transitional
state and a connect can block (for at most two seconds) until the device is
started.

For the first option, I'm also not sure if ECONNREFUSED is the right error
to return, maybe is better ENETUNREACH.

Cheers,
Stefano

