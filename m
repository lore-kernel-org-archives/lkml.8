Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85903C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 16:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62E4B20842
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 16:19:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PqwsPm3+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730616AbgFJQTP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 12:19:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21587 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728491AbgFJQTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 12:19:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591805951;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=anaWHR8ODh6bT+XuFE0Xz0+EuRSEm+J1BoLhgrw84d0=;
        b=PqwsPm3+wCtoi/v/uszAfAEjXalzKuvEu4AWipiAtWKzz1GnfaNnGLnOPmjOyIWdhWxO2b
        DFL3m6P4s0A3ucDHFEe8Y2nMEoEOvu6tdBe1jKqVclnpj7P9WUtWn6AyXF6LrPBjjfaBQI
        imBTP9sJb3LhvSUArEFFpRYYzpE+2As=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-34-E_bzrkwnMMOz0T16rcULLw-1; Wed, 10 Jun 2020 12:19:09 -0400
X-MC-Unique: E_bzrkwnMMOz0T16rcULLw-1
Received: by mail-qk1-f197.google.com with SMTP id l184so2568091qkb.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 09:19:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=anaWHR8ODh6bT+XuFE0Xz0+EuRSEm+J1BoLhgrw84d0=;
        b=HCy/zcF4xjAiTX6JZG/Wh8p6KQ272m+aJAXSqIsJkESYGXB7tWpDWsewKHB5yz9SeC
         9YgVc8EA1TRNu8bOTzKboGVCqcFNaXg9b+NuyylSdX9UAg1pAh4JUTrt9H/W4rpdY57Z
         vlQunvgGq5v/6G6IC5bgzs6O6o758OWdoB/p0JdJIrjFtyK10ix4ux5laRN1EJz3tPDU
         mWGN9UfUHVdsqIZMLr13bEVNgboe19Q4njaCWR36IRPPPjTdkbi5WimJdYNzkJZqSmR9
         6cTSEKfgEKBXEtY7mQgfSuH/ZC/HFmsI2LuO1A+ynAsC3motPvetmKR24I6+d6YKaiSZ
         YOVg==
X-Gm-Message-State: AOAM533BIqUdrmTaDiu+S8ppiK2zy57FzPXJXAO1JmhtIAQZyIvBtlhW
        wH3cqfngVyBV69cQWlgcKfN3S8pfoXb251ul7THA0FYsa0a58OMnQAkIaCcjcxsf8is66OYyAB6
        PgNtsnJYy/82sECSqVzemgUfrfLPsPNYj0W73Scqw
X-Received: by 2002:a37:2702:: with SMTP id n2mr3862398qkn.497.1591805949116;
        Wed, 10 Jun 2020 09:19:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw4zn0n1VsDB2zRrhX3o2J87XhGBACiQ4fWr35+ECNuZ32gZdIovwS6Er7XIT1803b34VxsP/mWRIhTQj1OyYA=
X-Received: by 2002:a37:2702:: with SMTP id n2mr3862363qkn.497.1591805948686;
 Wed, 10 Jun 2020 09:19:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200610113515.1497099-1-mst@redhat.com> <20200610113515.1497099-4-mst@redhat.com>
 <CAJaqyWdGKh5gSTndGuVPyJSgt3jfjfW4xNCrJ2tQ9f+mD8=sMQ@mail.gmail.com> <20200610111147-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200610111147-mutt-send-email-mst@kernel.org>
From:   Eugenio Perez Martin <eperezma@redhat.com>
Date:   Wed, 10 Jun 2020 18:18:32 +0200
Message-ID: <CAJaqyWe6d19hFAbpqaQqOPuQQmBQyevyF4sTVkaXKhD729XDkw@mail.gmail.com>
Subject: Re: [PATCH RFC v7 03/14] vhost: use batched get_vq_desc version
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm list <kvm@vger.kernel.org>,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 5:13 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Wed, Jun 10, 2020 at 02:37:50PM +0200, Eugenio Perez Martin wrote:
> > > +/* This function returns a value > 0 if a descriptor was found, or 0 if none were found.
> > > + * A negative code is returned on error. */
> > > +static int fetch_descs(struct vhost_virtqueue *vq)
> > > +{
> > > +       int ret;
> > > +
> > > +       if (unlikely(vq->first_desc >= vq->ndescs)) {
> > > +               vq->first_desc = 0;
> > > +               vq->ndescs = 0;
> > > +       }
> > > +
> > > +       if (vq->ndescs)
> > > +               return 1;
> > > +
> > > +       for (ret = 1;
> > > +            ret > 0 && vq->ndescs <= vhost_vq_num_batch_descs(vq);
> > > +            ret = fetch_buf(vq))
> > > +               ;
> >
> > (Expanding comment in V6):
> >
> > We get an infinite loop this way:
> > * vq->ndescs == 0, so we call fetch_buf() here
> > * fetch_buf gets less than vhost_vq_num_batch_descs(vq); descriptors. ret = 1
> > * This loop calls again fetch_buf, but vq->ndescs > 0 (and avail_vq ==
> > last_avail_vq), so it just return 1
>
> That's what
>          [PATCH RFC v7 08/14] fixup! vhost: use batched get_vq_desc version
> is supposed to fix.
>

Sorry, I forgot to include that fixup.

With it I don't see CPU stalls, but with that version latency has
increased a lot and I see packet lost:
+ ping -c 5 10.200.0.1
PING 10.200.0.1 (10.200.0.1) 56(84) bytes of data.
From 10.200.0.2 icmp_seq=1 Destination Host Unreachable
From 10.200.0.2 icmp_seq=2 Destination Host Unreachable
From 10.200.0.2 icmp_seq=3 Destination Host Unreachable
64 bytes from 10.200.0.1: icmp_seq=5 ttl=64 time=6848 ms

--- 10.200.0.1 ping statistics ---
5 packets transmitted, 1 received, +3 errors, 80% packet loss, time 76ms
rtt min/avg/max/mdev = 6848.316/6848.316/6848.316/0.000 ms, pipe 4
--

I cannot even use netperf.

If I modify with my proposed version:
+ ping -c 5 10.200.0.1
PING 10.200.0.1 (10.200.0.1) 56(84) bytes of data.
64 bytes from 10.200.0.1: icmp_seq=1 ttl=64 time=7.07 ms
64 bytes from 10.200.0.1: icmp_seq=2 ttl=64 time=0.358 ms
64 bytes from 10.200.0.1: icmp_seq=3 ttl=64 time=5.35 ms
64 bytes from 10.200.0.1: icmp_seq=4 ttl=64 time=2.27 ms
64 bytes from 10.200.0.1: icmp_seq=5 ttl=64 time=0.426 ms

[root@localhost ~]# netperf -H 10.200.0.1 -p 12865 -l 10 -t TCP_STREAM
MIGRATED TCP STREAM TEST from 0.0.0.0 (0.0.0.0) port 0 AF_INET to
10.200.0.1 () port 0 AF_INET
Recv   Send    Send
Socket Socket  Message  Elapsed
Size   Size    Size     Time     Throughput
bytes  bytes   bytes    secs.    10^6bits/sec

131072  16384  16384    10.01    4742.36
[root@localhost ~]# netperf -H 10.200.0.1 -p 12865 -l 10 -t UDP_STREAM
MIGRATED UDP STREAM TEST from 0.0.0.0 (0.0.0.0) port 0 AF_INET to
10.200.0.1 () port 0 AF_INET
Socket  Message  Elapsed      Messages
Size    Size     Time         Okay Errors   Throughput
bytes   bytes    secs            #      #   10^6bits/sec

212992   65507   10.00        9214      0     482.83
212992           10.00        9214            482.83

I will compare with the non-batch version for reference, but the
difference between the two is noticeable. Maybe it's worth finding a
good value for the if() inside fetch_buf?

Thanks!


> --
> MST
>

