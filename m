Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D995AC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 12:28:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B10012067B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 12:28:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LVL8PUHC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729927AbgFOM2q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 08:28:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21787 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728510AbgFOM2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 08:28:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592224123;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sBg2fZ9D+qAlMaoxpCp/kIBmDKmXPzYejbkMJfk/U3o=;
        b=LVL8PUHC4lo1QapW6QIkq6KkLsLth5BOXxda97PHOvh0y4UkKzGWmD7+a2RenZS21z7i3V
        AGW2EiS7kp/zDcb8n83i5tmMyLBDaVAx4rtv6yToiosYD+dnKbU5GZBVHILMu4reKNUq4p
        6gedND1PpECjZPWeRywfXi5NuFXefTU=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-244-6OTlOoD4Mi25s-ZnYLpg2g-1; Mon, 15 Jun 2020 08:28:39 -0400
X-MC-Unique: 6OTlOoD4Mi25s-ZnYLpg2g-1
Received: by mail-qt1-f198.google.com with SMTP id o11so13791048qti.23
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 05:28:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sBg2fZ9D+qAlMaoxpCp/kIBmDKmXPzYejbkMJfk/U3o=;
        b=uaMXp3O2uT+7Jkn3JcfLx6qHTDcYihyZ+OPE+irkJJKz/NfCOm7gTgnxZzMZ8iEyOK
         wkQnnhZPrcjQ3JrmyAR5p4IXUWRzS/7t1owKn/svoQPhtPpNlUmp9cE8lGFafth1eXHu
         OzwWPWqTrbTaLfq/0YJA/EVAMeoy37z4u650A1ebfsAA6dVrviin+Xeu9Q0v8+mrGYO+
         hUHc87EaCEbTGXdNTbKnRdreSGWexrx8P7AEhDrQt/c7QwYyOxgcDPRgVxIGJHYOZMph
         6hF8HyThc0wm2QRWFYib4JqTdfj1xRosBqayiRP60h//qUKRTflzxKm5RzIM9nT+36tk
         +BPg==
X-Gm-Message-State: AOAM533HrSKHOR6g6KEC2LRGJTUAzbKoqGzHcYPG1cCg0lGaA6433UUx
        7WOaj3JLj5S9qxyJjl6f7oteikJmw8674WrikrphWWYKCfB/7D0ukiDoddDoEZ8ZJKQeOsnRHcu
        HCHr3azToOjYO6AQJXYU4Y8s8+4jC2gGYNs0z9RuB
X-Received: by 2002:a05:620a:1407:: with SMTP id d7mr14076423qkj.89.1592224119510;
        Mon, 15 Jun 2020 05:28:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyMGtIFdrgid15Y38ee12F5MvFgWU29hVuUe2nr/sf233yxjKvAmpE8PkTLK0uLOi4+pmRt8SvQU4mlzAKXbyY=
X-Received: by 2002:a05:620a:1407:: with SMTP id d7mr14076410qkj.89.1592224119276;
 Mon, 15 Jun 2020 05:28:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200611113404.17810-1-mst@redhat.com> <20200611113404.17810-3-mst@redhat.com>
 <20200611152257.GA1798@char.us.oracle.com>
In-Reply-To: <20200611152257.GA1798@char.us.oracle.com>
From:   Eugenio Perez Martin <eperezma@redhat.com>
Date:   Mon, 15 Jun 2020 14:28:03 +0200
Message-ID: <CAJaqyWdwXMX0JGhmz6soH2ZLNdaH6HEdpBM8ozZzX9WUu8jGoQ@mail.gmail.com>
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

On Thu, Jun 11, 2020 at 5:22 PM Konrad Rzeszutek Wilk
<konrad.wilk@oracle.com> wrote:
>
> On Thu, Jun 11, 2020 at 07:34:19AM -0400, Michael S. Tsirkin wrote:
> > As testing shows no performance change, switch to that now.
>
> What kind of testing? 100GiB? Low latency?
>

Hi Konrad.

I tested this version of the patch:
https://lkml.org/lkml/2019/10/13/42

It was tested for throughput with DPDK's testpmd (as described in
http://doc.dpdk.org/guides/howto/virtio_user_as_exceptional_path.html)
and kernel pktgen. No latency tests were performed by me. Maybe it is
interesting to perform a latency test or just a different set of tests
over a recent version.

Thanks!

