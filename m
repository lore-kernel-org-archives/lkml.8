Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 882FBC2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 11:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 603A82072C
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 11:13:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hgHaYEtU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728918AbgDMLNf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 07:13:35 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:42583 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728096AbgDMLNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 07:13:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586776411;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RyXK4jTSyCrBgQI/g3NhhWf4Cadu8DGaHr+KG4J9oBY=;
        b=hgHaYEtUl9ptOKad4D14mcsmxP7Oz4omdWPBR1ieb/dc+kyhnwlgEpGJRRat+sFtblposo
        6btaospBujDDTFk5BIGfYjN8o+PWvr/7eau2eKv4yLqvXKq+8slOEcD0X5JT4/Dyrs1hP8
        LVuuw+SONqNp7aj5J+vEK0ikggFb5Ks=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-437-q5jNJxtnOZiHRZbbxHKNAA-1; Mon, 13 Apr 2020 07:13:28 -0400
X-MC-Unique: q5jNJxtnOZiHRZbbxHKNAA-1
Received: by mail-wr1-f72.google.com with SMTP id m15so6581958wrb.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 04:13:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=RyXK4jTSyCrBgQI/g3NhhWf4Cadu8DGaHr+KG4J9oBY=;
        b=f0I5SxxD7dcYk7P9qTjH1cw/ZvHZTuSvrvZp4NkaSPl8zIRUuv3YG1N1Ilun7rBx7V
         XTl96veI2Ub7A5f/ncIsS35/XXF44b3UDcY1zsVrHhxWbq+jwnXKJfKb5OlzRrqAKCMl
         vwAmK3f3T56Va02btjBqlzejtZVYzmR/i80iLAh32Y1T8uBGmjIhd6YDw2bOjofSz+hO
         ZNHUce+Y1tjtrIc41k7Gkt07aIWbxVFyyGfk13ehx5hm13gtdyjjIRW3/mXIGMaa4UbK
         1jM55afF++CFOi49JeZQM8SBa3e52TUFPzyx301lokahVg5Pgw/Ee1ie6QpukctpB8W5
         qefA==
X-Gm-Message-State: AGi0PuYvJOAHFdud5lOkix5rpRsv2DRqsE6cofhVeOiE3mldv8XXsGhM
        GPJ21UY7JcKL/TSrsYR7RKpHiigjKJvAGFuuVsXkGzFg6e5s2GH4HEkyerwKbopTBlllZLKxzRe
        3jwEJQrYAICyF4J+ESHRXI6aU
X-Received: by 2002:a5d:4442:: with SMTP id x2mr181629wrr.101.1586776407154;
        Mon, 13 Apr 2020 04:13:27 -0700 (PDT)
X-Google-Smtp-Source: APiQypJm7VAiU/q6lVzMdgLKKb2HWEjxDtZshQBgoe1KapbTIJWgwwS+QMx+dIDjpKr+0KXFEhxl+g==
X-Received: by 2002:a5d:4442:: with SMTP id x2mr181605wrr.101.1586776406923;
        Mon, 13 Apr 2020 04:13:26 -0700 (PDT)
Received: from redhat.com ([185.107.45.41])
        by smtp.gmail.com with ESMTPSA id b82sm15257603wme.25.2020.04.13.04.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 04:13:26 -0700 (PDT)
Date:   Mon, 13 Apr 2020 07:13:23 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Cc:     kvm list <kvm@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Cornelia Huck <cohuck@redhat.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH 0/8] tools/vhost: Reset virtqueue on tests
Message-ID: <20200413071044-mutt-send-email-mst@kernel.org>
References: <20200403165119.5030-1-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200403165119.5030-1-eperezma@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 03, 2020 at 06:51:11PM +0200, Eugenio Pérez wrote:
> This series add the tests used to validate the "vhost: Reset batched
> descriptors on SET_VRING_BASE call" series, with a small change on the
> reset code (delete an extra unneded reset on VHOST_SET_VRING_BASE).
> 
> They are based on the tests sent back them, the ones that were not
> included (reasons in that thread). This series changes:
> 
> * Delete need to export the ugly function in virtio_ring, now all the
> code is added in tools/virtio (except the one line fix).
> * Add forgotten uses of vhost_vq_set_backend. Fix bad usage order in
> vhost_test_set_backend.
> * Drop random reset, not really needed.
> * Minor changes updating tests code.
> 
> This serie is meant to be applied on top of
> 5de4e0b7068337cf0d4ca48a4011746410115aae in
> git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git.

Is this still needed? The patches lack Signed-off-by and
commit log descriptions, reference commit Ids without subject.
See Documentation/process/submitting-patches.rst

> Eugenio Pérez (8):
>   tools/virtio: fix virtio_test.c indentation
>   vhost: Not cleaning batched descs in VHOST_SET_VRING_BASE ioctl
>   vhost: Replace vq->private_data access by backend accesors
>   vhost: Fix bad order in vhost_test_set_backend at enable
>   tools/virtio: Use __vring_new_virtqueue in virtio_test.c
>   tools/virtio: Extract virtqueue initialization in vq_reset
>   tools/virtio: Reset index in virtio_test --reset.
>   tools/virtio: Use tools/include/list.h instead of stubs
> 
>  drivers/vhost/test.c        |  8 ++---
>  drivers/vhost/vhost.c       |  1 -
>  tools/virtio/linux/kernel.h |  7 +----
>  tools/virtio/linux/virtio.h |  5 ++--
>  tools/virtio/virtio_test.c  | 58 +++++++++++++++++++++++++++----------
>  tools/virtio/vringh_test.c  |  2 ++
>  6 files changed, 51 insertions(+), 30 deletions(-)
> 
> -- 
> 2.18.1

