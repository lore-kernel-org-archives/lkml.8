Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30EFFC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 19:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 099FC20842
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 19:52:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CDDWt6RW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730059AbgCaTwH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 15:52:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53580 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726548AbgCaTwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 15:52:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585684325;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b2UFMAgHLjerJ9NMZry/HpffFH2cpApwyp5N9quNxNg=;
        b=CDDWt6RWzfSB4DIBsO6ACKKbFLW1vpjC8BdQF0LCkAqXCVm5j+MxsHFLdXKsxWxGGMwaqD
        erqlL7wCLJs9/7rVpIZJ2B7i74i8r44SxqaoINpsh8hsMdhV/TTVLozTRNDlj66PX6uPQ9
        Bw02i9q+Zd/imMurinvZv310W/LYLCg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-277-HYaL1xoYNwq77W_4oMSZkQ-1; Tue, 31 Mar 2020 15:51:16 -0400
X-MC-Unique: HYaL1xoYNwq77W_4oMSZkQ-1
Received: by mail-wr1-f70.google.com with SMTP id k11so445846wrm.19
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 12:51:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=b2UFMAgHLjerJ9NMZry/HpffFH2cpApwyp5N9quNxNg=;
        b=IL4gY+CSBCIVwLIGfTNi4dUeg1jIjVzI5vynuoB4MtFgh5n1sWNNPuWt4x1kkRwGIy
         uDSoMj1jYbq2k8MyucNCIIlHgOCYpmJcpijcOJqU5pHW6oi7LSKAMSA148ro2HchjfID
         lcj0UG9FNyWMSN0eMa+Wk3XUCI+KyLz3ioHKXarhu2bkmIgI6VUzVwSrHgc8N0rr7vso
         YvD2VKzW1cSguIcZ+WiELkoF000VoPOHYIBzV+7E2xeOx9j2vX4OfOGvXqoTlFd3WN8O
         oK5no+NKQn8Oa4J2VnnUoCrbp8mQt2FAS/10NeQ5B8VDE7FcN8KYsYaeTEY8BsHDN3BR
         Y1Jg==
X-Gm-Message-State: ANhLgQ1n/CKBwmJ6Kz3AHP8rE5IK1elc410blfLTR62WyXy2JIUDzBqQ
        HMaVWBHrqlEok18OPbgd69tZnrZFWty9S6nxHOBefeGy3yfSjp9h2Z2wgf4CDVuh781B3CyDkIk
        baa2foCRjnxHbVskSlUCe63NC
X-Received: by 2002:adf:90c6:: with SMTP id i64mr21178493wri.88.1585684273178;
        Tue, 31 Mar 2020 12:51:13 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsBF9cECw6xLYUjwBS31gILdZtjJFvdt8FOUuQyT0OA1wSrJbotTajrFFZAFpWOR4/ADVtrdQ==
X-Received: by 2002:adf:90c6:: with SMTP id i64mr21178477wri.88.1585684272926;
        Tue, 31 Mar 2020 12:51:12 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
        by smtp.gmail.com with ESMTPSA id y15sm1290983wrh.50.2020.03.31.12.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 12:51:12 -0700 (PDT)
Date:   Tue, 31 Mar 2020 15:51:09 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        kvm list <kvm@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v3 0/8] vhost: Reset batched descriptors on
 SET_VRING_BASE call
Message-ID: <20200331155049-mutt-send-email-mst@kernel.org>
References: <20200331192804.6019-1-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200331192804.6019-1-eperezma@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 31, 2020 at 09:27:56PM +0200, Eugenio Pérez wrote:
> Vhost did not reset properly the batched descriptors on SET_VRING_BASE
> event. Because of that, is possible to return an invalid descriptor to
> the guest.
> 
> This series ammend this, resetting them every time backend changes, and
> creates a test to assert correct behavior. To do that, they need to
> expose a new function in virtio_ring, virtqueue_reset_free_head, only
> on test code.
> 
> Another useful thing would be to check if mutex is properly get in
> vq private_data accessors. Not sure if mutex debug code allow that,
> similar to C++ unique lock::owns_lock. Not acquiring in the function
> because caller code holds the mutex in order to perform more actions.

I pushed vhost branch with patch 1, pls send patches on top of that!

> v3:
> * Rename accesors functions.
> * Make scsi and test use the accesors too.
> 
> v2:
> * Squashed commits.
> * Create vq private_data accesors (mst).
> 
> This is meant to be applied on top of
> c4f1c41a6094582903c75c0dcfacb453c959d457 in
> git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git.
> 
> Eugenio Pérez (5):
>   vhost: Create accessors for virtqueues private_data
>   tools/virtio: Add --batch option
>   tools/virtio: Add --batch=random option
>   tools/virtio: Add --reset=random
>   tools/virtio: Make --reset reset ring idx
> 
> Michael S. Tsirkin (3):
>   vhost: option to fetch descriptors through an independent struct
>   vhost: use batched version by default
>   vhost: batching fetches
> 
>  drivers/vhost/net.c          |  28 ++--
>  drivers/vhost/scsi.c         |  14 +-
>  drivers/vhost/test.c         |  69 ++++++++-
>  drivers/vhost/test.h         |   1 +
>  drivers/vhost/vhost.c        | 271 +++++++++++++++++++++++------------
>  drivers/vhost/vhost.h        |  44 +++++-
>  drivers/vhost/vsock.c        |  14 +-
>  drivers/virtio/virtio_ring.c |  29 ++++
>  tools/virtio/linux/virtio.h  |   2 +
>  tools/virtio/virtio_test.c   | 123 ++++++++++++++--
>  10 files changed, 456 insertions(+), 139 deletions(-)
> 
> -- 
> 2.18.1

