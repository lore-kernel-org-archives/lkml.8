Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDB64C2D0E5
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 11:49:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5B3120675
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 11:49:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="boOnn0D/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbgC2Ltb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 07:49:31 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:34563 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728071AbgC2Ltb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 07:49:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585482570;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z3uSqDxAG/8s/s7cz44Y2/i4LCDpCHA9j5Si4puA7U0=;
        b=boOnn0D/JfyJ1aF6HMIKAdXnrcNKV0egy0IY95A2jxP/Y3gWQ0uRYSiGFYp5K0pdKaoBKG
        v33M0EQsycGaXf1zqJvvMDwUdkS/u4R9U9q68JLHne7QfxPrAp+9GR753EZeQzlq8Joy/T
        xNdee+AyC4ExGlSc9j1hsMJ49ZhRonE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-476-nScPeJ1_M7e5LCrej9pc6Q-1; Sun, 29 Mar 2020 07:49:28 -0400
X-MC-Unique: nScPeJ1_M7e5LCrej9pc6Q-1
Received: by mail-wr1-f72.google.com with SMTP id e10so8350570wru.6
        for <linux-kernel@vger.kernel.org>; Sun, 29 Mar 2020 04:49:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Z3uSqDxAG/8s/s7cz44Y2/i4LCDpCHA9j5Si4puA7U0=;
        b=fowlc7+wWMTB33mPpGU4sU5tmGGJ9UTdqN2dUvWcob0CzoEkgK+UEsB/nzckK2Xh+y
         2HIS5Q/nvhePGSeJFYVAr+5gEKoJ692CEtd36/14bh4d9FKsCi6PIv9syZcSTLJIRX5R
         QlHmvE0oSYpwahCBBGF9Mqy3C60ZC2LMN0QMego8u0kKbGY0jTkTI6W1j5R0RYkIC3co
         m5aJgvs9HaV5/y09imXCK2yBnlyOtKZObrtqVx7AeyCcnD68X4V3tu1jqwdMKiQM8a4V
         CWyMSvHYGl1cSG8MHmdls3iEKgPMPZNdLqu3dzKy/1gy39yI/FwZEhzZNmqsG7ktq1Uz
         I6Ew==
X-Gm-Message-State: ANhLgQ22RqqqSs9iUI0DNJwZRHY6PgxIyCaTezW5X/QrDhw/P0/KCZps
        1R7eQdEAJYg3z6G+LeM9+qUGkLxtTav+rG4TxYhTE25oS5GmNb/sOUohMSaBSP3ckKLpHlLCqCu
        aRsag51UD4kAFJ2xaD5rCPjYs
X-Received: by 2002:a1c:3241:: with SMTP id y62mr8524814wmy.66.1585482567003;
        Sun, 29 Mar 2020 04:49:27 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vv7BukqLWASNd56mdBXcWIrZDO3DRdR8zJ4m6ol8Bj23sHTGubRNiILOzZ0ywfXFDGVJH4UAA==
X-Received: by 2002:a1c:3241:: with SMTP id y62mr8524804wmy.66.1585482566822;
        Sun, 29 Mar 2020 04:49:26 -0700 (PDT)
Received: from redhat.com (bzq-79-183-139-129.red.bezeqint.net. [79.183.139.129])
        by smtp.gmail.com with ESMTPSA id 19sm3668516wmi.32.2020.03.29.04.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2020 04:49:26 -0700 (PDT)
Date:   Sun, 29 Mar 2020 07:49:23 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Cc:     "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        Halil Pasic <pasic@linux.ibm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        Cornelia Huck <cohuck@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/6] vhost: Reset batched descriptors on SET_VRING_BASE
 call
Message-ID: <20200329074023-mutt-send-email-mst@kernel.org>
References: <20200329113359.30960-1-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200329113359.30960-1-eperezma@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 29, 2020 at 01:33:53PM +0200, Eugenio Pérez wrote:
> Vhost did not reset properly the batched descriptors on SET_VRING_BASE event. Because of that, is possible to return an invalid descriptor to the guest.
> This series ammend this, and creates a test to assert correct behavior. To do that, they need to expose a new function in virtio_ring, virtqueue_reset_free_head. Not sure if this can be avoided.

Question: why not reset the batch when private_data changes?
At the moment both net and scsi poke at private data directly,
if they do this through a wrapper we can use that to
1. check that vq mutex is taken properly
2. reset batching

This seems like a slightly better API

> 
> Also, change from https://lkml.org/lkml/2020/3/27/108 is not included, that avoids to update a variable in a loop where it can be updated once.
> 
> This is meant to be applied on top of eccb852f1fe6bede630e2e4f1a121a81e34354ab in git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git, and some commits should be squashed with that series.

Thanks a lot! I'll apply this for now so Christian can start testing,
but I'd like the comment above addressed before I push this to Linus.

> Eugenio Pérez (6):
>   tools/virtio: Add --batch option
>   tools/virtio: Add --batch=random option
>   tools/virtio: Add --reset=random
>   tools/virtio: Make --reset reset ring idx
>   vhost: Delete virtqueue batch_descs member
>   fixup! vhost: batching fetches
> 
>  drivers/vhost/test.c         |  57 ++++++++++++++++
>  drivers/vhost/test.h         |   1 +
>  drivers/vhost/vhost.c        |  12 +++-
>  drivers/vhost/vhost.h        |   1 -
>  drivers/virtio/virtio_ring.c |  18 +++++
>  include/linux/virtio.h       |   2 +
>  tools/virtio/linux/virtio.h  |   2 +
>  tools/virtio/virtio_test.c   | 123 +++++++++++++++++++++++++++++++----
>  8 files changed, 201 insertions(+), 15 deletions(-)
> 
> -- 
> 2.18.1

