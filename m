Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F28C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 18:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7C66214D8
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 18:26:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cNuAub2E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732895AbgFSS0h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 14:26:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51345 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731628AbgFSS0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 14:26:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592591189;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o7jACTPMklupBCcyQ4Eej+eEvNAjD27aYrs6PEc/vLM=;
        b=cNuAub2E09tv6iPNe9MCdV0FZ1wquSqwzkqx53ocSarilStnSmp5uQt+QGFiOmOqMXt6y4
        Ykv+Nm+6Ikz0R32qpKVG6yz8avjBCRkGprz7i39QRuUAq5McliIabQ0pshtuXaMGbS2Okb
        YmN1egl3FlKX0IMUqPRRoRuTxTUFYOQ=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-173-NT4vW2bxO1uHUlUnJboEoA-1; Fri, 19 Jun 2020 14:26:25 -0400
X-MC-Unique: NT4vW2bxO1uHUlUnJboEoA-1
Received: by mail-qv1-f71.google.com with SMTP id r4so7457406qvh.10
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 11:26:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o7jACTPMklupBCcyQ4Eej+eEvNAjD27aYrs6PEc/vLM=;
        b=UZpluoUadAjV8mM8oaKQ5MIMNzK/zk1NAWmkb6geHg+QSr/Nlv9jHHdhyOsVp0TNEp
         vp6Nzhm7ECd6htioF5rvEP9UDk08JFu4TYo9Ody7fXVV9aLbEXQqQgQqJ7fFTvfEWi9K
         cm0GQD7MK7n9XrL1+TuBRA3Zz7zTcdiJ3nJ6Q30r5uxnrC2gd/Mfl0RmzTjXeft1N+qA
         llWCE1x17CNWjdr5BbumTWi8lWMei9srPtaMkFmHWmBgm1XO+XhBwdE7rdAymzn31tbm
         ev3Nq7yi5gw3cQqFYG88be1CKlE/rQtPnsTL+AX2bZtK37cW4tWHj/kfClSjU/nZSHwF
         bTlQ==
X-Gm-Message-State: AOAM533/0yhROZE7Uisa3A8Mni8WUfZJPC/P2Gg4V1QnwQ+Ns17oWir0
        e/yaBp8LLOHfurlqjLAPvEr7LVF/EObLL/RLl+0gkVP/NTvz+oB9ORxZj/aoRz7foeFKzY8MCAq
        V3faRX3/wBr6RKsSx8Lwe/0t3ad+fKzL1/jMbK82k
X-Received: by 2002:aed:2171:: with SMTP id 104mr2351983qtc.22.1592591184848;
        Fri, 19 Jun 2020 11:26:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzmu89J2VMwmehul4uuct4yakQaH6gNxgS333NyHo7rSAKDL/C3Yad8XzwEayBTHv1AAc0+ox+DOJ6fz/Cp2Vk=
X-Received: by 2002:aed:2171:: with SMTP id 104mr2351958qtc.22.1592591184592;
 Fri, 19 Jun 2020 11:26:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200611113404.17810-1-mst@redhat.com> <20200611113404.17810-3-mst@redhat.com>
 <20200611152257.GA1798@char.us.oracle.com> <CAJaqyWdwXMX0JGhmz6soH2ZLNdaH6HEdpBM8ozZzX9WUu8jGoQ@mail.gmail.com>
 <CAJaqyWdwgy0fmReOgLfL4dAv-E+5k_7z3d9M+vHqt0aO2SmOFg@mail.gmail.com>
In-Reply-To: <CAJaqyWdwgy0fmReOgLfL4dAv-E+5k_7z3d9M+vHqt0aO2SmOFg@mail.gmail.com>
From:   Eugenio Perez Martin <eperezma@redhat.com>
Date:   Fri, 19 Jun 2020 20:25:48 +0200
Message-ID: <CAJaqyWe1+FmPC9L_+8oGfYUT63BaWuGrOnkRnUcGapvwtzqmPw@mail.gmail.com>
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

On Fri, Jun 19, 2020 at 8:07 PM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Mon, Jun 15, 2020 at 2:28 PM Eugenio Perez Martin
> <eperezma@redhat.com> wrote:
> >
> > On Thu, Jun 11, 2020 at 5:22 PM Konrad Rzeszutek Wilk
> > <konrad.wilk@oracle.com> wrote:
> > >
> > > On Thu, Jun 11, 2020 at 07:34:19AM -0400, Michael S. Tsirkin wrote:
> > > > As testing shows no performance change, switch to that now.
> > >
> > > What kind of testing? 100GiB? Low latency?
> > >
> >
> > Hi Konrad.
> >
> > I tested this version of the patch:
> > https://lkml.org/lkml/2019/10/13/42
> >
> > It was tested for throughput with DPDK's testpmd (as described in
> > http://doc.dpdk.org/guides/howto/virtio_user_as_exceptional_path.html)
> > and kernel pktgen. No latency tests were performed by me. Maybe it is
> > interesting to perform a latency test or just a different set of tests
> > over a recent version.
> >
> > Thanks!
>
> I have repeated the tests with v9, and results are a little bit different:
> * If I test opening it with testpmd, I see no change between versions
> * If I forward packets between two vhost-net interfaces in the guest
> using a linux bridge in the host:
>   - netperf UDP_STREAM shows a performance increase of 1.8, almost
> doubling performance. This gets lower as frame size increase.
>   - rests of the test goes noticeably worse: UDP_RR goes from ~6347
> transactions/sec to 5830
>   - TCP_STREAM goes from ~10.7 gbps to ~7Gbps
>   - TCP_RR from 6223.64 transactions/sec to 5739.44

And I forgot to add: It seems that avoiding IOV length math helps,
since performance increases in all tests from patch 02/11 ("vhost: use
batched get_vq_desc version") to 11/11 ("vhost: drop head based
APIs").

