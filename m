Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 031B8C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 16:29:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D14C12076E
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 16:29:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SES/20h2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729545AbgFVQ3o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 12:29:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26935 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729461AbgFVQ3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 12:29:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592843380;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FzLtoFQh/vN8wW8Srx1684Gpm2Q4p3etHyJcn3zpZ2o=;
        b=SES/20h2yInAsrMv7r4Ya1RbXif0kBWzMBJdlucvZ+Crp83Xw4Z5adKHfeHFFM01gjkzGB
        DS2HlEhEOJ6gp+OXK2Mvay16FytNSpFUGjOuz8GysRdZO3XEBwSOmNVfsb8nl8UITjGrOY
        JwURziTAgY5Ld2Iea0r7JeMFNf4Gnyo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-238-gGmXMi4nMOuLe1-Cqpwnwg-1; Mon, 22 Jun 2020 12:29:32 -0400
X-MC-Unique: gGmXMi4nMOuLe1-Cqpwnwg-1
Received: by mail-wm1-f70.google.com with SMTP id p24so61919wma.4
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 09:29:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FzLtoFQh/vN8wW8Srx1684Gpm2Q4p3etHyJcn3zpZ2o=;
        b=FheoP7HoW+i6fIlH1cQJYqFc+2WGy+qkTcL/+Ux4lNmq40bYgsLT/ucajfftHQdZPK
         atxueRBE00qdagoCGb1o281cJcA8GmMrC6O4KhicZZ2653D0lnlqr1PpusGLiQSlnzcH
         DQo9/OTCEZGqbyoI69HqmridrhiO9/th/ZAwUeioena8A6h4QNAfYs4pXy3LLnSw/clp
         oLs2JgGeQB/cPUEzPETGk5LNzTHYEB259S0vmX2B3lB7v1zj6MG5yPF8kv1zeF8ywJwh
         e3AoqqvGavW2T3e1HBE817LB87MWoOrFXI897T+pXcyZtzl9On4YWuUGJmBrQgO4Mihg
         JhbA==
X-Gm-Message-State: AOAM531jJqzD3vaetMAB8kboU0nPaApM12MXypfxw7JCxKdmytbzSkdm
        g4REoA56OUtbvQUvdQwc7WzX14NwmahSJF/06tJZzBIxamT4szc9FABa+bgM3wdHRZqW9FNs/sw
        Xp8B2Uo+IQ4eZbvp4PS29jVPC
X-Received: by 2002:a5d:470a:: with SMTP id y10mr7567520wrq.405.1592843371378;
        Mon, 22 Jun 2020 09:29:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzTk56uu9uLED/XFyQTjpJIlBSf9Yjq+4mD8Dsvqij6CkK9q6rGvTmvotw6Je15SfiT50Mhig==
X-Received: by 2002:a5d:470a:: with SMTP id y10mr7567504wrq.405.1592843371111;
        Mon, 22 Jun 2020 09:29:31 -0700 (PDT)
Received: from redhat.com (bzq-79-178-18-124.red.bezeqint.net. [79.178.18.124])
        by smtp.gmail.com with ESMTPSA id x205sm98811wmx.21.2020.06.22.09.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 09:29:30 -0700 (PDT)
Date:   Mon, 22 Jun 2020 12:29:28 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Eugenio Perez Martin <eperezma@redhat.com>
Cc:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        linux-kernel@vger.kernel.org, kvm list <kvm@vger.kernel.org>,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH RFC v8 02/11] vhost: use batched get_vq_desc version
Message-ID: <20200622122546-mutt-send-email-mst@kernel.org>
References: <20200611113404.17810-1-mst@redhat.com>
 <20200611113404.17810-3-mst@redhat.com>
 <20200611152257.GA1798@char.us.oracle.com>
 <CAJaqyWdwXMX0JGhmz6soH2ZLNdaH6HEdpBM8ozZzX9WUu8jGoQ@mail.gmail.com>
 <CAJaqyWdwgy0fmReOgLfL4dAv-E+5k_7z3d9M+vHqt0aO2SmOFg@mail.gmail.com>
 <20200622114622-mutt-send-email-mst@kernel.org>
 <CAJaqyWfrf94Gc-DMaXO+f=xC8eD3DVCD9i+x1dOm5W2vUwOcGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJaqyWfrf94Gc-DMaXO+f=xC8eD3DVCD9i+x1dOm5W2vUwOcGQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 06:11:21PM +0200, Eugenio Perez Martin wrote:
> On Mon, Jun 22, 2020 at 5:55 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Fri, Jun 19, 2020 at 08:07:57PM +0200, Eugenio Perez Martin wrote:
> > > On Mon, Jun 15, 2020 at 2:28 PM Eugenio Perez Martin
> > > <eperezma@redhat.com> wrote:
> > > >
> > > > On Thu, Jun 11, 2020 at 5:22 PM Konrad Rzeszutek Wilk
> > > > <konrad.wilk@oracle.com> wrote:
> > > > >
> > > > > On Thu, Jun 11, 2020 at 07:34:19AM -0400, Michael S. Tsirkin wrote:
> > > > > > As testing shows no performance change, switch to that now.
> > > > >
> > > > > What kind of testing? 100GiB? Low latency?
> > > > >
> > > >
> > > > Hi Konrad.
> > > >
> > > > I tested this version of the patch:
> > > > https://lkml.org/lkml/2019/10/13/42
> > > >
> > > > It was tested for throughput with DPDK's testpmd (as described in
> > > > http://doc.dpdk.org/guides/howto/virtio_user_as_exceptional_path.html)
> > > > and kernel pktgen. No latency tests were performed by me. Maybe it is
> > > > interesting to perform a latency test or just a different set of tests
> > > > over a recent version.
> > > >
> > > > Thanks!
> > >
> > > I have repeated the tests with v9, and results are a little bit different:
> > > * If I test opening it with testpmd, I see no change between versions
> >
> >
> > OK that is testpmd on guest, right? And vhost-net on the host?
> >
> 
> Hi Michael.
> 
> No, sorry, as described in
> http://doc.dpdk.org/guides/howto/virtio_user_as_exceptional_path.html.
> But I could add to test it in the guest too.
> 
> These kinds of raw packets "bursts" do not show performance
> differences, but I could test deeper if you think it would be worth
> it.

Oh ok, so this is without guest, with virtio-user.
It might be worth checking dpdk within guest too just
as another data point.

> > > * If I forward packets between two vhost-net interfaces in the guest
> > > using a linux bridge in the host:
> >
> > And here I guess you mean virtio-net in the guest kernel?
> 
> Yes, sorry: Two virtio-net interfaces connected with a linux bridge in
> the host. More precisely:
> * Adding one of the interfaces to another namespace, assigning it an
> IP, and starting netserver there.
> * Assign another IP in the range manually to the other virtual net
> interface, and start the desired test there.
> 
> If you think it would be better to perform then differently please let me know.


Not sure why you bother with namespaces since you said you are
using L2 bridging. I guess it's unimportant.

> >
> > >   - netperf UDP_STREAM shows a performance increase of 1.8, almost
> > > doubling performance. This gets lower as frame size increase.
> > >   - rests of the test goes noticeably worse: UDP_RR goes from ~6347
> > > transactions/sec to 5830
> >
> > OK so it seems plausible that we still have a bug where an interrupt
> > is delayed. That is the main difference between pmd and virtio.
> > Let's try disabling event index, and see what happens - that's
> > the trickiest part of interrupts.
> >
> 
> Got it, will get back with the results.
> 
> Thank you very much!
> 
> >
> >
> > >   - TCP_STREAM goes from ~10.7 gbps to ~7Gbps
> > >   - TCP_RR from 6223.64 transactions/sec to 5739.44
> >

