Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2787C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 09:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DB10206FA
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 09:08:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="af1ATywo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388864AbgFXJIK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 05:08:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52927 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387704AbgFXJIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 05:08:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592989688;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=VQoY+UTRP06W0gqpd2Juj7Hxof1/RYyQfXylaOH8G2E=;
        b=af1ATywohFlpjwjpvBh9u8Q77FO2AwFSUME1iaPhAQrXUWXkWHP5unMRvtzJBWVprv/WY7
        iPDcuAWFYs0lyq+lOsccHZFNvsRJOtwTzgNqv/9+fuiptuI5dk5g+ViNTw29OQIFu8PyzD
        30cYUywIf+5Rkuaz7Xbd8mL1LD0hYZI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-220-e_3tmfZnMtaV6cT97A4Ctg-1; Wed, 24 Jun 2020 05:08:06 -0400
X-MC-Unique: e_3tmfZnMtaV6cT97A4Ctg-1
Received: by mail-wr1-f72.google.com with SMTP id n4so303421wrj.15
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 02:08:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=VQoY+UTRP06W0gqpd2Juj7Hxof1/RYyQfXylaOH8G2E=;
        b=p0DoXeOzLi4zOnE/uSBPb/X5wU0YHrJLGzmAB7YdxFo+HyaClJT6m5Zn9xmWYb8EDt
         tkgpLzRz3XGGhcQOzNdNbtdAWYig4TuWcgkcrjmHcFg67kMsEEBcu6KNmem2160i8gbw
         shy3Iqng2OzTmYWoBe3HdLisygXN/7dmeWCOlgfyboGovZk+ngz40tF/wkhEtq3OZnDQ
         PhUXkOHfIZjHseRMBu/yukxaLOM5yqhdU5Q/XFMZW+iCfgu7iYMYp7NpyAL3+kv333wO
         WnZo9XYs4r1QYFuYx7WBILdoOxo9vtBb0DQGx80PsAJQDUklCW+KlGvPRNs3F45SX33w
         9fyg==
X-Gm-Message-State: AOAM532FwQiDLmX9s7/tgn/2jWgWXKDSAIu30v6RlUMAqyBB+R374RA8
        lEFRTM5eXK02dMJQjfkZxwNCgWgbwM3v1ytHFdiQsXz9Qb+cHLfaNDA3SrJyAOZcDNatBBUDvtV
        YDfuae9zQBFm2uxKXJGpYZEBt
X-Received: by 2002:a7b:cb4c:: with SMTP id v12mr28392162wmj.43.1592989684869;
        Wed, 24 Jun 2020 02:08:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzbEhEN966Il4umYMTMjRrrueqoGcM5lQiV/3BTRS9Bm+7+N7X0YZSdV011xkOJs+ZR2fNnFw==
X-Received: by 2002:a7b:cb4c:: with SMTP id v12mr28392130wmj.43.1592989684670;
        Wed, 24 Jun 2020 02:08:04 -0700 (PDT)
Received: from redhat.com ([82.166.20.53])
        by smtp.gmail.com with ESMTPSA id e5sm26714788wrw.19.2020.06.24.02.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 02:08:03 -0700 (PDT)
Date:   Wed, 24 Jun 2020 05:08:01 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        dan.carpenter@oracle.com, david@redhat.com, eperezma@redhat.com,
        jasowang@redhat.com, mst@redhat.com, pankaj.gupta.linux@gmail.com,
        teawaterz@linux.alibaba.com
Subject: [GIT PULL] virtio: fixes, tests
Message-ID: <20200624050801-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 48778464bb7d346b47157d21ffde2af6b2d39110:

  Linux 5.8-rc2 (2020-06-21 15:45:29 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to cb91909e48a4809261ef4e967464e2009b214f06:

  tools/virtio: Use tools/include/list.h instead of stubs (2020-06-22 12:34:22 -0400)

----------------------------------------------------------------
virtio: fixes, tests

Fixes all over the place.

This includes a couple of tests that I would normally defer,
but since they have already been helpful in catching some bugs,
don't build for any users at all, and having them
upstream makes life easier for everyone, I think it's
ok even at this late stage.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Dan Carpenter (2):
      vhost_vdpa: Fix potential underflow in vhost_vdpa_mmap()
      virtio-mem: silence a static checker warning

David Hildenbrand (1):
      virtio-mem: add memory via add_memory_driver_managed()

Eugenio Pérez (7):
      tools/virtio: Add --batch option
      tools/virtio: Add --batch=random option
      tools/virtio: Add --reset
      tools/virtio: Use __vring_new_virtqueue in virtio_test.c
      tools/virtio: Extract virtqueue initialization in vq_reset
      tools/virtio: Reset index in virtio_test --reset.
      tools/virtio: Use tools/include/list.h instead of stubs

Jason Wang (1):
      vdpa: fix typos in the comments for __vdpa_alloc_device()

 drivers/vdpa/vdpa.c         |   2 +-
 drivers/vhost/test.c        |  57 ++++++++++++++++++
 drivers/vhost/test.h        |   1 +
 drivers/vhost/vdpa.c        |   2 +-
 drivers/virtio/virtio_mem.c |  27 +++++++--
 tools/virtio/linux/kernel.h |   7 +--
 tools/virtio/linux/virtio.h |   5 +-
 tools/virtio/virtio_test.c  | 139 +++++++++++++++++++++++++++++++++++++-------
 tools/virtio/vringh_test.c  |   2 +
 9 files changed, 207 insertions(+), 35 deletions(-)

