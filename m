Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06E0FC433EA
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 06:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1B16206F5
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 06:38:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ad1Tzu64"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728178AbgGPGiW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 02:38:22 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:26898 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726069AbgGPGiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 02:38:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594881499;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mgsbCofvuyqXz4CiSAjrSGg+j5I3SP1iCQXPN1fyRB0=;
        b=Ad1Tzu64duExagm01DiFHyHqR9Q4OZahI9GBiWq8DM/5ak1J2iNQxE/bQJjlbGrZnVjvPD
        cF9gjjATcYeiYRHppAM/HlUf6AbXCiMAN/N3RY8IdZ78VlnUHhTaiXka3m+5LL6pJi0iEu
        08o8MXuoaDBZDysOvnGBhjfJCen6GjI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-172-fGtZHe1kPjGQfMNdmIBBdg-1; Thu, 16 Jul 2020 02:38:13 -0400
X-MC-Unique: fGtZHe1kPjGQfMNdmIBBdg-1
Received: by mail-wm1-f71.google.com with SMTP id g6so4425663wmk.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 23:38:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mgsbCofvuyqXz4CiSAjrSGg+j5I3SP1iCQXPN1fyRB0=;
        b=BSk0hNg3Qad8/COw+cYPZdMJUo75/mAsHxOT1H9Ow+aq1G2G6AjHjaN1kv3tesqGo9
         JqVVwoEEiqEkUbBOyvdCc2msqujPqXPSwtOuxiCHYgm9R7pJ9Eo5qK6kxJIQcr0+r1dr
         BFmB7OMc2LEtZr4l5H3P7D0DsMRqJslmHAdRPoOu0EpwaS9ZYKwuTSg1RJO5mi35ZD1l
         aBlwcgqdMRZyEfp9QUYr/XNjWKV+2It+WynrybUhYuyO10cJ1QQLEE7hnmo3IWUfVZME
         xtR+NXNuMvq46ZVg6E+gnAsRMYaYklatV12sYFF5Sio8Zd0ux9QoIHbq8ym42OJQzCBz
         qtKg==
X-Gm-Message-State: AOAM530wAK1bVH2HxYF3l9/HNv+ALwhoQ9VjLAyer1KyGMsqvboBgcoJ
        QoANvidEdR5VFlG0ZYDqv7Uqw8ym5nb3AyKDS/RjDzi/Qq0E0UJ1igNJI+ljn9WFpWeog7EkPCI
        IdvH4UUkLsIW7xntpdW5ofXp5
X-Received: by 2002:a1c:bb89:: with SMTP id l131mr2738041wmf.125.1594881492234;
        Wed, 15 Jul 2020 23:38:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzzaPeWg1JnBNar2FAbNPZoF5EQR8AmndjmfZn9b+/T6UDyq076UKRxNe2r8PFt/+RlfkD65g==
X-Received: by 2002:a1c:bb89:: with SMTP id l131mr2738003wmf.125.1594881491787;
        Wed, 15 Jul 2020 23:38:11 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
        by smtp.gmail.com with ESMTPSA id p14sm8342659wrj.14.2020.07.15.23.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 23:38:11 -0700 (PDT)
Date:   Thu, 16 Jul 2020 02:38:07 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Hui Zhu <teawater@gmail.com>
Cc:     david@redhat.com, jasowang@redhat.com, akpm@linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [RFC for Linux v4 0/2] virtio_balloon: Add
 VIRTIO_BALLOON_F_CONT_PAGES to report continuous pages
Message-ID: <20200716021929-mutt-send-email-mst@kernel.org>
References: <1594867315-8626-1-git-send-email-teawater@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1594867315-8626-1-git-send-email-teawater@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 16, 2020 at 10:41:50AM +0800, Hui Zhu wrote:
> The first, second and third version are in [1], [2] and [3].
> Code of current version for Linux and qemu is available in [4] and [5].
> Update of this version:
> 1. Report continuous pages will increase the speed.  So added deflate
>    continuous pages.
> 2. According to the comments from David in [6], added 2 new vqs inflate_cont_vq
>    and deflate_cont_vq to report continuous pages with format 32 bits pfn and 32
>    bits size.
> Following is the introduction of the function.
> These patches add VIRTIO_BALLOON_F_CONT_PAGES to virtio_balloon. With this
> flag, balloon tries to use continuous pages to inflate and deflate.
> Opening this flag can bring two benefits:
> 1. Report continuous pages will increase memory report size of each time
>    call tell_host.  Then it will increase the speed of balloon inflate and
>    deflate.
> 2. Host THPs will be splitted when qemu release the page of balloon inflate.
>    Inflate balloon with continuous pages will let QEMU release the pages
>    of same THPs.  That will help decrease the splitted THPs number in
>    the host.
>    Following is an example in a VM with 1G memory 1CPU.  This test setups an
>    environment that has a lot of fragmentation pages.  Then inflate balloon will
>    split the THPs.
> // This is the THP number before VM execution in the host.
> // None use THP.
> cat /proc/meminfo | grep AnonHugePages:
> AnonHugePages:         0 kB
> // After VM start, use usemem
> // (https://git.kernel.org/pub/scm/linux/kernel/git/wfg/vm-scalability.git)
> // punch-holes function generates 400m fragmentation pages in the guest
> // kernel.
> usemem --punch-holes -s -1 800m &
> // This is the THP number after this command in the host.
> // Some THP is used by VM because usemem will access 800M memory
> // in the guest.
> cat /proc/meminfo | grep AnonHugePages:
> AnonHugePages:    911360 kB
> // Connect to the QEMU monitor, setup balloon, and set it size to 600M.
> (qemu) device_add virtio-balloon-pci,id=balloon1
> (qemu) info balloon
> balloon: actual=1024
> (qemu) balloon 600
> (qemu) info balloon
> balloon: actual=600
> // This is the THP number after inflate the balloon in the host.
> cat /proc/meminfo | grep AnonHugePages:
> AnonHugePages:     88064 kB
> // Set the size back to 1024M in the QEMU monitor.
> (qemu) balloon 1024
> (qemu) info balloon
> balloon: actual=1024
> // Use usemem to increase the memory usage of QEMU.
> killall usemem
> usemem 800m
> // This is the THP number after this operation.
> cat /proc/meminfo | grep AnonHugePages:
> AnonHugePages:     65536 kB
> 
> Following example change to use continuous pages balloon.  The number of
> splitted THPs is decreased.
> // This is the THP number before VM execution in the host.
> // None use THP.
> cat /proc/meminfo | grep AnonHugePages:
> AnonHugePages:         0 kB
> // After VM start, use usemem punch-holes function generates 400M
> // fragmentation pages in the guest kernel.
> usemem --punch-holes -s -1 800m &
> // This is the THP number after this command in the host.
> // Some THP is used by VM because usemem will access 800M memory
> // in the guest.
> cat /proc/meminfo | grep AnonHugePages:
> AnonHugePages:    911360 kB
> // Connect to the QEMU monitor, setup balloon, and set it size to 600M.
> (qemu) device_add virtio-balloon-pci,id=balloon1,cont-pages=on
> (qemu) info balloon
> balloon: actual=1024
> (qemu) balloon 600
> (qemu) info balloon
> balloon: actual=600
> // This is the THP number after inflate the balloon in the host.
> cat /proc/meminfo | grep AnonHugePages:
> AnonHugePages:    616448 kB
> // Set the size back to 1024M in the QEMU monitor.
> (qemu) balloon 1024
> (qemu) info balloon
> balloon: actual=1024
> // Use usemem to increase the memory usage of QEMU.
> killall usemem
> usemem 800m
> // This is the THP number after this operation.
> cat /proc/meminfo | grep AnonHugePages:
> AnonHugePages:    907264 kB

I'm a bit confused about which of the above run within guest,
and which run within host. Could you explain pls?



> [1] https://lkml.org/lkml/2020/3/12/144
> [2] https://lore.kernel.org/linux-mm/1584893097-12317-1-git-send-email-teawater@gmail.com/
> [3] https://lkml.org/lkml/2020/5/12/324
> [4] https://github.com/teawater/linux/tree/balloon_conts
> [5] https://github.com/teawater/qemu/tree/balloon_conts
> [6] https://lkml.org/lkml/2020/5/13/1211
> 
> Hui Zhu (2):
>   virtio_balloon: Add VIRTIO_BALLOON_F_CONT_PAGES and inflate_cont_vq
>   virtio_balloon: Add deflate_cont_vq to deflate continuous pages
> 
>  drivers/virtio/virtio_balloon.c     |  180 +++++++++++++++++++++++++++++++-----
>  include/linux/balloon_compaction.h  |   12 ++
>  include/uapi/linux/virtio_balloon.h |    1
>  mm/balloon_compaction.c             |  117 +++++++++++++++++++++--
>  4 files changed, 280 insertions(+), 30 deletions(-)

