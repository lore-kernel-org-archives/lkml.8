Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77FF5C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 18:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5719220DD4
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 18:08:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cl1+652e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403967AbgFSSIo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 14:08:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50122 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388336AbgFSSIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 14:08:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592590119;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M1kqnSC0TnwwjU9pqdl+Jl6MnsvVIxbg1NKgAjCQLQk=;
        b=cl1+652e+fWCtGoesj6yht07XsNuGao/aRLVpVL6aYALBdFfI2CtzuMyey99gio5cwLa4A
        sj984r2RhF0u20QEphNqsM7xwo6pKjNhqxxrRdHqfj6/ilQswT2hXx1aycFGVmIx0Gdn4m
        eevFSxmtm36zvY0BFfoaqZqCvbgP8kc=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-376-P2k-mjZgNmOkJ-8It2sQyA-1; Fri, 19 Jun 2020 14:08:34 -0400
X-MC-Unique: P2k-mjZgNmOkJ-8It2sQyA-1
Received: by mail-qv1-f70.google.com with SMTP id h4so7401105qvr.21
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 11:08:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M1kqnSC0TnwwjU9pqdl+Jl6MnsvVIxbg1NKgAjCQLQk=;
        b=EkSPCrvAph3eu8OAnZG3sxGWFe6Ue2ei5Ki0COQxfgXg0Zlt9XZ0v4MkntpEWnuVtD
         F/OvsiR6YlzmFHvjQLFF1w0JvtINLZnOMP2fhIoR0nSRkQBLz3tBo5hP+LnIKO+20cKM
         QMLr5cAtNfnZhneFMdO+92rV47QKJAIUvS/4dlV4cidXuLNWobckcOsrZzxgZpG/dDfD
         2wYY9NSPGD2SY1ovUetXqOyvpXjM4tJ5IWNhS9rSJQcrX2y0CoJjVG+98Z8+mfSUrKmP
         far6jGZ//s6KFHDej9La0MMJewfX4bAaHVnYooD2RmvdmYveIrHBuTTFqZgGh9ijc8oW
         He1A==
X-Gm-Message-State: AOAM530cClGqD6dNz4kcBXaPGtuTTAZa4Eei7gLGbbqeqTD4gVp6CSWU
        1bCOfa8rSafd3sZoUmaPiZECJmjDqQC+TAWsGnu82DFXW8wEAx4rCJG/xc/V+xgNXYd21vBMs4o
        PyMllMTeDa1bYEXiVc52JYw+B+osHggBCvLJfjVxB
X-Received: by 2002:aed:2171:: with SMTP id 104mr2269424qtc.22.1592590114086;
        Fri, 19 Jun 2020 11:08:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxb3LLfD5Gk7BoQBiwyBzy1qquwOQYCpCWEpfsWGm3cQ1kfZddE50/+gf0EU9STwwFtmiZcEeywa03jj7Vwsy0=
X-Received: by 2002:aed:2171:: with SMTP id 104mr2269401qtc.22.1592590113830;
 Fri, 19 Jun 2020 11:08:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200611113404.17810-1-mst@redhat.com> <20200611113404.17810-3-mst@redhat.com>
 <20200611152257.GA1798@char.us.oracle.com> <CAJaqyWdwXMX0JGhmz6soH2ZLNdaH6HEdpBM8ozZzX9WUu8jGoQ@mail.gmail.com>
In-Reply-To: <CAJaqyWdwXMX0JGhmz6soH2ZLNdaH6HEdpBM8ozZzX9WUu8jGoQ@mail.gmail.com>
From:   Eugenio Perez Martin <eperezma@redhat.com>
Date:   Fri, 19 Jun 2020 20:07:57 +0200
Message-ID: <CAJaqyWdwgy0fmReOgLfL4dAv-E+5k_7z3d9M+vHqt0aO2SmOFg@mail.gmail.com>
Subject: Re: [PATCH RFC v8 02/11] vhost: use batched get_vq_desc version
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        linux-kernel@vger.kernel.org, kvm list <kvm@vger.kernel.org>,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 2:28 PM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Thu, Jun 11, 2020 at 5:22 PM Konrad Rzeszutek Wilk
> <konrad.wilk@oracle.com> wrote:
> >
> > On Thu, Jun 11, 2020 at 07:34:19AM -0400, Michael S. Tsirkin wrote:
> > > As testing shows no performance change, switch to that now.
> >
> > What kind of testing? 100GiB? Low latency?
> >
>
> Hi Konrad.
>
> I tested this version of the patch:
> https://lkml.org/lkml/2019/10/13/42
>
> It was tested for throughput with DPDK's testpmd (as described in
> http://doc.dpdk.org/guides/howto/virtio_user_as_exceptional_path.html)
> and kernel pktgen. No latency tests were performed by me. Maybe it is
> interesting to perform a latency test or just a different set of tests
> over a recent version.
>
> Thanks!

I have repeated the tests with v9, and results are a little bit different:
* If I test opening it with testpmd, I see no change between versions
* If I forward packets between two vhost-net interfaces in the guest
using a linux bridge in the host:
  - netperf UDP_STREAM shows a performance increase of 1.8, almost
doubling performance. This gets lower as frame size increase.
  - rests of the test goes noticeably worse: UDP_RR goes from ~6347
transactions/sec to 5830
  - TCP_STREAM goes from ~10.7 gbps to ~7Gbps
  - TCP_RR from 6223.64 transactions/sec to 5739.44

