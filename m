Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D048DC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 16:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A30EF2076E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 16:16:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DmJFQfwz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732483AbgFWQQL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 12:16:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34704 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732137AbgFWQQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 12:16:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592928969;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tQbe5rqyYjvehV1zKMS5pdkClT9pyr1+42ShsT+YZus=;
        b=DmJFQfwzRtEngtqKFZqGzvVnvQLHiPxR1TKRKSVzeIKDIprxlwQsMFG63rHD2YwosrunS5
        t4E5ksxJh49kIJkL/kNb+uHe9zwwanbrcZRAtb3MGh4bxehXg5zVSkqXGFQOgD5rT4mPrF
        ruJMYmZJN52Okpq+ZTNUQ2Zuzj+DC6U=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-cryNFz_uPFKmKosCZV361A-1; Tue, 23 Jun 2020 12:16:03 -0400
X-MC-Unique: cryNFz_uPFKmKosCZV361A-1
Received: by mail-qv1-f69.google.com with SMTP id q5so15214937qvp.23
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 09:16:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tQbe5rqyYjvehV1zKMS5pdkClT9pyr1+42ShsT+YZus=;
        b=OOVyJ2tI57UwwzdEI/uvo4RNhgIJ6B+Vzep0dK1f2HUxnY6b0QuM2Bgu/uGzDC9Xod
         7pcl79UwrwKxh4I0iExxgNBQeK/yWjsobIkHOMBcCMLJzo0qPRdp5V4BkeJ8hO/oA/9Y
         v+KGf8mK5bH5/nWsPD7/BzEK7PYRhN+r8p5BAGTN5OYkjU/ghHFrcmHLZmKasaQDpniz
         2nb461J7EhKcoDGVso0eF2zVDuFQEiFViRhRA9SiLyKItXtHx5OL9SWbh3jhFV5Zxuok
         ZXZDYf6CpPnIUfB/h8adoRIo/+ViaiDHIh2hTjj+8a9Riol1N+zj7ZGQKjBth5KXZoxv
         JSSA==
X-Gm-Message-State: AOAM532/VVDHrfr62Xp54PSn4WapWwnx02o2Jv4P4V062wo6Z8Ijt6lU
        F8FHYYy3cxU8rZ+PS4MdU3TNm8jtmTx0mR3JrAxeXTjNj9pWMAtFS96+Vtix927kfNZ64kPm5Nx
        7KIOOt8C5OIa/fslX/g5/sV84ppovqViHRo9c2s+Y
X-Received: by 2002:ad4:4732:: with SMTP id l18mr3881513qvz.208.1592928963231;
        Tue, 23 Jun 2020 09:16:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy7yTqnj7uaB03wNLu96uz9OlO0RH8CN880kbmRfNOi6PGV8nVOyNP6bAd1kbfBqw7cKF6f/d17HlC1XDYmWqU=
X-Received: by 2002:ad4:4732:: with SMTP id l18mr3881493qvz.208.1592928962969;
 Tue, 23 Jun 2020 09:16:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200611113404.17810-1-mst@redhat.com> <20200611113404.17810-3-mst@redhat.com>
 <20200611152257.GA1798@char.us.oracle.com> <CAJaqyWdwXMX0JGhmz6soH2ZLNdaH6HEdpBM8ozZzX9WUu8jGoQ@mail.gmail.com>
 <CAJaqyWdwgy0fmReOgLfL4dAv-E+5k_7z3d9M+vHqt0aO2SmOFg@mail.gmail.com>
 <20200622114622-mutt-send-email-mst@kernel.org> <CAJaqyWfrf94Gc-DMaXO+f=xC8eD3DVCD9i+x1dOm5W2vUwOcGQ@mail.gmail.com>
 <20200622122546-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200622122546-mutt-send-email-mst@kernel.org>
From:   Eugenio Perez Martin <eperezma@redhat.com>
Date:   Tue, 23 Jun 2020 18:15:26 +0200
Message-ID: <CAJaqyWfbouY4kEXkc6sYsbdCAEk0UNsS5xjqEdHTD7bcTn40Ow@mail.gmail.com>
Subject: Re: [PATCH RFC v8 02/11] vhost: use batched get_vq_desc version
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        linux-kernel@vger.kernel.org, kvm list <kvm@vger.kernel.org>,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 6:29 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, Jun 22, 2020 at 06:11:21PM +0200, Eugenio Perez Martin wrote:
> > On Mon, Jun 22, 2020 at 5:55 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Fri, Jun 19, 2020 at 08:07:57PM +0200, Eugenio Perez Martin wrote:
> > > > On Mon, Jun 15, 2020 at 2:28 PM Eugenio Perez Martin
> > > > <eperezma@redhat.com> wrote:
> > > > >
> > > > > On Thu, Jun 11, 2020 at 5:22 PM Konrad Rzeszutek Wilk
> > > > > <konrad.wilk@oracle.com> wrote:
> > > > > >
> > > > > > On Thu, Jun 11, 2020 at 07:34:19AM -0400, Michael S. Tsirkin wrote:
> > > > > > > As testing shows no performance change, switch to that now.
> > > > > >
> > > > > > What kind of testing? 100GiB? Low latency?
> > > > > >
> > > > >
> > > > > Hi Konrad.
> > > > >
> > > > > I tested this version of the patch:
> > > > > https://lkml.org/lkml/2019/10/13/42
> > > > >
> > > > > It was tested for throughput with DPDK's testpmd (as described in
> > > > > http://doc.dpdk.org/guides/howto/virtio_user_as_exceptional_path.html)
> > > > > and kernel pktgen. No latency tests were performed by me. Maybe it is
> > > > > interesting to perform a latency test or just a different set of tests
> > > > > over a recent version.
> > > > >
> > > > > Thanks!
> > > >
> > > > I have repeated the tests with v9, and results are a little bit different:
> > > > * If I test opening it with testpmd, I see no change between versions
> > >
> > >
> > > OK that is testpmd on guest, right? And vhost-net on the host?
> > >
> >
> > Hi Michael.
> >
> > No, sorry, as described in
> > http://doc.dpdk.org/guides/howto/virtio_user_as_exceptional_path.html.
> > But I could add to test it in the guest too.
> >
> > These kinds of raw packets "bursts" do not show performance
> > differences, but I could test deeper if you think it would be worth
> > it.
>
> Oh ok, so this is without guest, with virtio-user.
> It might be worth checking dpdk within guest too just
> as another data point.
>

Ok, I will do it!

> > > > * If I forward packets between two vhost-net interfaces in the guest
> > > > using a linux bridge in the host:
> > >
> > > And here I guess you mean virtio-net in the guest kernel?
> >
> > Yes, sorry: Two virtio-net interfaces connected with a linux bridge in
> > the host. More precisely:
> > * Adding one of the interfaces to another namespace, assigning it an
> > IP, and starting netserver there.
> > * Assign another IP in the range manually to the other virtual net
> > interface, and start the desired test there.
> >
> > If you think it would be better to perform then differently please let me know.
>
>
> Not sure why you bother with namespaces since you said you are
> using L2 bridging. I guess it's unimportant.
>

Sorry, I think I should have provided more context about that.

The only reason to use namespaces is to force the traffic of these
netperf tests to go through the external bridge. To test netperf
different possibilities than the testpmd (or pktgen or others "blast
of frames unconditionally" tests).

This way, I make sure that is the same version of everything in the
guest, and is a little bit easier to manage cpu affinity, start and
stop testing...

I could use a different VM for sending and receiving, but I find this
way a faster one and it should not introduce a lot of noise. I can
test with two VM if you think that this use of network namespace
introduces too much noise.

Thanks!

> > >
> > > >   - netperf UDP_STREAM shows a performance increase of 1.8, almost
> > > > doubling performance. This gets lower as frame size increase.
> > > >   - rests of the test goes noticeably worse: UDP_RR goes from ~6347
> > > > transactions/sec to 5830
> > >
> > > OK so it seems plausible that we still have a bug where an interrupt
> > > is delayed. That is the main difference between pmd and virtio.
> > > Let's try disabling event index, and see what happens - that's
> > > the trickiest part of interrupts.
> > >
> >
> > Got it, will get back with the results.
> >
> > Thank you very much!
> >
> > >
> > >
> > > >   - TCP_STREAM goes from ~10.7 gbps to ~7Gbps
> > > >   - TCP_RR from 6223.64 transactions/sec to 5739.44
> > >
>

