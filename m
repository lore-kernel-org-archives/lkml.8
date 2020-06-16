Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F8DC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 22:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73DC02065F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 22:08:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="icgj9474"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbgFPWIS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 18:08:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22591 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725901AbgFPWIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 18:08:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592345292;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7CP01C0W+UxRSj8yLj//dWMR0NvRbCdUzzXI0Pchkjc=;
        b=icgj9474u2wrWilpLRJan9gAMaYVW0Xanj4gTet7DS/B6U2lL58Mnnl0LodEDW4unC2GMe
        H0FtanvExIWYg2TzhQ444wDGfPCt3iIsQVjL/Kzr+ENXiPNuxqfEy9SP+UHH4KmncyeWkh
        nsw+nw1gSyDYej/CuiqUwH9nwQeINqE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-mfQ3lCVcPBC_o3iFK-fHVg-1; Tue, 16 Jun 2020 18:08:10 -0400
X-MC-Unique: mfQ3lCVcPBC_o3iFK-fHVg-1
Received: by mail-wr1-f71.google.com with SMTP id z10so67926wrs.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 15:08:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=7CP01C0W+UxRSj8yLj//dWMR0NvRbCdUzzXI0Pchkjc=;
        b=ahD9czhszIoUrq4t7zVGsK7x69ChmRk8AlOuAXZZyZbudQUL8m7Pjmex1jpnwS5+5o
         0gkNoudwvuZvXeL/JVsIy+AN0M/fO21NchJoSoDPULcBV+h6ajYdl33oJY8sgaz6g0dH
         2ENRB8qFWbZ9pTuAgKFtj+Do17l/rRfFzdsnwBBKSMA+4s7VS90zEHLdhomJ4B2ofAH1
         NWMv8Dg5Bod4qDB7+Dmg3XSZyWjMGRDArZZH5UUWZSIEKw07rLZRaJ7m5gR1Ir9kTZpo
         Ht3vFIbwvWcsLD7BsDTfOFMc1HDrv8a6itpqY1VBUhVFdbC7K685uYEPtZxJDCxL2pB3
         cLyw==
X-Gm-Message-State: AOAM5314uIPa6nhnCB1Oq2kG4uUtFiI92+ziYDJhTzLU0iNBy2bDB7jf
        yZjvUoMVbdVRuFTFsZzmm5SZiPQlPoZNaXHVRVWQr/m4g4Ca3HHibeWzRZeUUsT9DJZnRTtWfzM
        ge3cz9Q4qzVQr9CROf1iwP41q
X-Received: by 2002:a5d:4488:: with SMTP id j8mr4964196wrq.242.1592345288629;
        Tue, 16 Jun 2020 15:08:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw+YwKGiCPOYkO3s9mtutwnCfxVpYD54lMU6VgHDv3qQP0i01djJPcPzyqmByuEL0gGp486jg==
X-Received: by 2002:a5d:4488:: with SMTP id j8mr4964176wrq.242.1592345288283;
        Tue, 16 Jun 2020 15:08:08 -0700 (PDT)
Received: from redhat.com (bzq-79-178-18-124.red.bezeqint.net. [79.178.18.124])
        by smtp.gmail.com with ESMTPSA id n204sm6055762wma.5.2020.06.16.15.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 15:08:07 -0700 (PDT)
Date:   Tue, 16 Jun 2020 18:08:04 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Eugenio Perez Martin <eperezma@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm list <kvm@vger.kernel.org>,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH RFC v7 03/14] vhost: use batched get_vq_desc version
Message-ID: <20200616180136-mutt-send-email-mst@kernel.org>
References: <20200610113515.1497099-1-mst@redhat.com>
 <20200610113515.1497099-4-mst@redhat.com>
 <CAJaqyWdGKh5gSTndGuVPyJSgt3jfjfW4xNCrJ2tQ9f+mD8=sMQ@mail.gmail.com>
 <20200610111147-mutt-send-email-mst@kernel.org>
 <CAJaqyWe6d19hFAbpqaQqOPuQQmBQyevyF4sTVkaXKhD729XDkw@mail.gmail.com>
 <20200611072702-mutt-send-email-mst@kernel.org>
 <26bef3f07277b028034c019e456b4f236078c5fb.camel@redhat.com>
 <CAJaqyWeX7knekVPcsZ2+AAf8zvZhPvt46fZncAsLhwYJ3eUa1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJaqyWeX7knekVPcsZ2+AAf8zvZhPvt46fZncAsLhwYJ3eUa1g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 16, 2020 at 05:23:43PM +0200, Eugenio Perez Martin wrote:
> On Mon, Jun 15, 2020 at 6:05 PM Eugenio Pérez <eperezma@redhat.com> wrote:
> >
> > On Thu, 2020-06-11 at 07:30 -0400, Michael S. Tsirkin wrote:
> > > On Wed, Jun 10, 2020 at 06:18:32PM +0200, Eugenio Perez Martin wrote:
> > > > On Wed, Jun 10, 2020 at 5:13 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > On Wed, Jun 10, 2020 at 02:37:50PM +0200, Eugenio Perez Martin wrote:
> > > > > > > +/* This function returns a value > 0 if a descriptor was found, or 0 if none were found.
> > > > > > > + * A negative code is returned on error. */
> > > > > > > +static int fetch_descs(struct vhost_virtqueue *vq)
> > > > > > > +{
> > > > > > > +       int ret;
> > > > > > > +
> > > > > > > +       if (unlikely(vq->first_desc >= vq->ndescs)) {
> > > > > > > +               vq->first_desc = 0;
> > > > > > > +               vq->ndescs = 0;
> > > > > > > +       }
> > > > > > > +
> > > > > > > +       if (vq->ndescs)
> > > > > > > +               return 1;
> > > > > > > +
> > > > > > > +       for (ret = 1;
> > > > > > > +            ret > 0 && vq->ndescs <= vhost_vq_num_batch_descs(vq);
> > > > > > > +            ret = fetch_buf(vq))
> > > > > > > +               ;
> > > > > >
> > > > > > (Expanding comment in V6):
> > > > > >
> > > > > > We get an infinite loop this way:
> > > > > > * vq->ndescs == 0, so we call fetch_buf() here
> > > > > > * fetch_buf gets less than vhost_vq_num_batch_descs(vq); descriptors. ret = 1
> > > > > > * This loop calls again fetch_buf, but vq->ndescs > 0 (and avail_vq ==
> > > > > > last_avail_vq), so it just return 1
> > > > >
> > > > > That's what
> > > > >          [PATCH RFC v7 08/14] fixup! vhost: use batched get_vq_desc version
> > > > > is supposed to fix.
> > > > >
> > > >
> > > > Sorry, I forgot to include that fixup.
> > > >
> > > > With it I don't see CPU stalls, but with that version latency has
> > > > increased a lot and I see packet lost:
> > > > + ping -c 5 10.200.0.1
> > > > PING 10.200.0.1 (10.200.0.1) 56(84) bytes of data.
> > > > > From 10.200.0.2 icmp_seq=1 Destination Host Unreachable
> > > > > From 10.200.0.2 icmp_seq=2 Destination Host Unreachable
> > > > > From 10.200.0.2 icmp_seq=3 Destination Host Unreachable
> > > > 64 bytes from 10.200.0.1: icmp_seq=5 ttl=64 time=6848 ms
> > > >
> > > > --- 10.200.0.1 ping statistics ---
> > > > 5 packets transmitted, 1 received, +3 errors, 80% packet loss, time 76ms
> > > > rtt min/avg/max/mdev = 6848.316/6848.316/6848.316/0.000 ms, pipe 4
> > > > --
> > > >
> > > > I cannot even use netperf.
> > >
> > > OK so that's the bug to try to find and fix I think.
> > >
> > >
> > > > If I modify with my proposed version:
> > > > + ping -c 5 10.200.0.1
> > > > PING 10.200.0.1 (10.200.0.1) 56(84) bytes of data.
> > > > 64 bytes from 10.200.0.1: icmp_seq=1 ttl=64 time=7.07 ms
> > > > 64 bytes from 10.200.0.1: icmp_seq=2 ttl=64 time=0.358 ms
> > > > 64 bytes from 10.200.0.1: icmp_seq=3 ttl=64 time=5.35 ms
> > > > 64 bytes from 10.200.0.1: icmp_seq=4 ttl=64 time=2.27 ms
> > > > 64 bytes from 10.200.0.1: icmp_seq=5 ttl=64 time=0.426 ms
> > >
> > > Not sure which version this is.
> > >
> > > > [root@localhost ~]# netperf -H 10.200.0.1 -p 12865 -l 10 -t TCP_STREAM
> > > > MIGRATED TCP STREAM TEST from 0.0.0.0 (0.0.0.0) port 0 AF_INET to
> > > > 10.200.0.1 () port 0 AF_INET
> > > > Recv   Send    Send
> > > > Socket Socket  Message  Elapsed
> > > > Size   Size    Size     Time     Throughput
> > > > bytes  bytes   bytes    secs.    10^6bits/sec
> > > >
> > > > 131072  16384  16384    10.01    4742.36
> > > > [root@localhost ~]# netperf -H 10.200.0.1 -p 12865 -l 10 -t UDP_STREAM
> > > > MIGRATED UDP STREAM TEST from 0.0.0.0 (0.0.0.0) port 0 AF_INET to
> > > > 10.200.0.1 () port 0 AF_INET
> > > > Socket  Message  Elapsed      Messages
> > > > Size    Size     Time         Okay Errors   Throughput
> > > > bytes   bytes    secs            #      #   10^6bits/sec
> > > >
> > > > 212992   65507   10.00        9214      0     482.83
> > > > 212992           10.00        9214            482.83
> > > >
> > > > I will compare with the non-batch version for reference, but the
> > > > difference between the two is noticeable. Maybe it's worth finding a
> > > > good value for the if() inside fetch_buf?
> > > >
> > > > Thanks!
> > > >
> > >
> > > I don't think it's performance, I think it's a bug somewhere,
> > > e.g. maybe we corrupt a packet, or stall the queue, or
> > > something like this.
> > >
> > > Let's do this, I will squash the fixups and post v8 so you can bisect
> > > and then debug cleanly.
> >
> > Ok, so if we apply the patch proposed in v7 08/14 (Or the version 8 of the patchset sent), this is what happens:
> >
> > 1. Userland (virtio_test in my case) introduces just one buffer in vq, and it kicks
> > 2. vhost module reaches fetch_descs, called from vhost_get_vq_desc. From there we call fetch_buf in a for loop.
> > 3. The first time we call fetch_buf, it returns properly one buffer. However, the second time we call it, it returns 0
> > because vq->avail_idx == vq->last_avail_idx and vq->avail_idx == last_avail_idx code path.
> > 4. fetch_descs assign ret = 0, so it returns 0. vhost_get_vq_desc will goto err, and it will signal no new buffer
> > (returning vq->num).
> >
> > So to fix it and maintain the batching maybe we could return vq->ndescs in case ret == 0:
> >
> > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > index c0dfb5e3d2af..5993d4f34ca9 100644
> > --- a/drivers/vhost/vhost.c
> > +++ b/drivers/vhost/vhost.c
> > @@ -2315,7 +2327,8 @@ static int fetch_descs(struct vhost_virtqueue *vq)
> >
> >         /* On success we expect some descs */
> >         BUG_ON(ret > 0 && !vq->ndescs);
> > -       return ret;
> > +       return ret ?: vq->ndescs;


I'd rather we used standard C. Also ret < 0 needs
to be handled. Also - what if fetch of some descs fails
but some succeeds?
What do we want to do?
Maybe:

return vq->ndescs ? vq->ndescs : ret;


> >  }
> >
> >  /* Reverse the effects of fetch_descs */
> > --
> >
> > Another possibility could be to return different codes from fetch_buf, but I find the suggested modification easier.
> >
> > What do you think?
> >
> > Thanks!
> >
> 
> Hi!
> 
> I can send a proposed RFC v9 in case it is more convenient for you.
> 
> Thanks!

Excellent, pls go ahead!
And can you include the performance numbers?
It's enough to test the final version.

-- 
MST

