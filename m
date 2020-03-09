Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26BA6C10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 08:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7FAB20728
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 08:08:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I7sjVMFr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbgCIIIg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 04:08:36 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:21009 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725956AbgCIIIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 04:08:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583741315;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=T8KT/+n14Cn5HelmWM4TG6Zo6L21o7FLn2E43AQONUI=;
        b=I7sjVMFrQyszBieK7l81PBbXu3hkzHcGu1wuxeWxaxy9mt8RSC0xHZHxIpqw6fCdX+kdjD
        LJZeHKJOz3OCKFK+WvKMsJJkcgBYPptT+LM8wEl1p8plGMF4Dxb8a7S9QVfzUbhds9JWPM
        eFNtJt5Hel2J2my9omQ3Hwovm7F6RS4=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-261-8tCvUCihOjyldnt_vtd-aw-1; Mon, 09 Mar 2020 04:08:33 -0400
X-MC-Unique: 8tCvUCihOjyldnt_vtd-aw-1
Received: by mail-qk1-f197.google.com with SMTP id n6so6727306qkk.11
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 01:08:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=T8KT/+n14Cn5HelmWM4TG6Zo6L21o7FLn2E43AQONUI=;
        b=PdEa0ct7kXnzi2LjI+QWocskLV+DWZRJCsVI6FU4k/7Qbo4aE7EfBhyrBxmLZ0lCot
         IwouOiPkQd1avvVCF7jjHyvLnV9uavo7/UbbLmYjYg9Bq0t+kJyzNKo69Q/71hCfV1CB
         90/K6jHGX7qQ9W12J6XQfGK0OUn5b8ZGL7VvR0wD9iXmRg7cxbA81TmAIid/T9lmHatj
         9FeiJC28v6/ompSPMdASGcKivmp1+DYdgtXQEvdkAa6NZx7fMpwnq7F9lv16pbeURX+h
         GPhGhyoBQgboCWkZ1EtetFeG5m3EU6s1Lt4XHSraZPNPoTr0r2Gdcb9bbmspPfJzf6dj
         O6PQ==
X-Gm-Message-State: ANhLgQ2Y5O7xWwC5qnjiFE0t+A3KFeG6zMPil24BPq9KBJj06JkQXLHi
        6ptAy+AUsi884ecUwDy35BDHtaUM7bzK5/mlGFrk88N6Ny2ivvn3y82hZma5rqML7aZg17NP8vO
        QymmONWmPFTNTMvTQ2XiVIcYj
X-Received: by 2002:a0c:c244:: with SMTP id w4mr13815579qvh.104.1583741311603;
        Mon, 09 Mar 2020 01:08:31 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsDCYFx3tgEt/18zqy2Hj0onYaUrEMtYoBKu3yJ+l1tw+IzBr80xlV0fKvKv/QcwEaRhnxGPw==
X-Received: by 2002:a0c:c244:: with SMTP id w4mr13815565qvh.104.1583741311386;
        Mon, 09 Mar 2020 01:08:31 -0700 (PDT)
Received: from redhat.com (bzq-79-178-2-19.red.bezeqint.net. [79.178.2.19])
        by smtp.gmail.com with ESMTPSA id k11sm21885175qti.68.2020.03.09.01.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 01:08:30 -0700 (PDT)
Date:   Mon, 9 Mar 2020 04:08:25 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        axboe@kernel.dk, jasowang@redhat.com, mst@redhat.com,
        natechancellor@gmail.com, pasic@linux.ibm.com, s-anna@ti.com
Subject: [GIT PULL] virtio: fixes
Message-ID: <20200309040825-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 98d54f81e36ba3bf92172791eba5ca5bd813989b:

  Linux 5.6-rc4 (2020-03-01 16:38:46 -0600)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to 6ae4edab2fbf86ec92fbf0a8f0c60b857d90d50f:

  virtio_balloon: Adjust label in virtballoon_probe (2020-03-08 05:35:24 -0400)

----------------------------------------------------------------
virtio: fixes

Some bug fixes all over the place.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Halil Pasic (2):
      virtio-blk: fix hw_queue stopped on arbitrary error
      virtio-blk: improve virtqueue error to BLK_STS

Nathan Chancellor (1):
      virtio_balloon: Adjust label in virtballoon_probe

Suman Anna (1):
      virtio_ring: Fix mem leak with vring_new_virtqueue()

 drivers/block/virtio_blk.c      | 17 ++++++++++++-----
 drivers/virtio/virtio_balloon.c |  2 +-
 drivers/virtio/virtio_ring.c    |  4 ++--
 3 files changed, 15 insertions(+), 8 deletions(-)

