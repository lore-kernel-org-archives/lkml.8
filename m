Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F811C2BA1A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 01:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 009C520692
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 01:16:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hvTuNuPT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbgDGBQe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 21:16:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36824 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726277AbgDGBQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 21:16:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586222191;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=Hl/4u9vSJZc+CysW0Hgn56YT9ySEd//6AVmGizL78TA=;
        b=hvTuNuPTGK3Y2QVs9w/ItSZpJ5780XYv0xJmML+2B9sALYwyuZsWFK5gHs1/qJC+JjPFXe
        p9LuYAcOVwpX66PYxrjj1n0pjHDtVnMhqsKO8gZiE2OuPcIrJZ9hiApTMALGoZDPtT1X/0
        U4vGlaWsEnosiVGCjU/I5I2NuzQCEog=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-237-AzQuqv-iNlyW74VEzdXQ-g-1; Mon, 06 Apr 2020 21:16:30 -0400
X-MC-Unique: AzQuqv-iNlyW74VEzdXQ-g-1
Received: by mail-wr1-f71.google.com with SMTP id v14so860861wrq.13
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 18:16:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=Hl/4u9vSJZc+CysW0Hgn56YT9ySEd//6AVmGizL78TA=;
        b=uVfMfZkQI/t+m8nCOqOgr15lNAKNUMUqDs1gvd07pc7zOErEUo0Cn5SG49Q0MhhBqS
         wD+HXh78AdhDyu7Eeu9QKd59UXtkAjR7Ip86/iaKbTw+gteMiqv4T6GFuf07Ne51WCYA
         wTAw5mHcy8OWFmJ4uiirNl3xXGPbBoP9oOFVxOxBTcwCRbtOSKV1Yidw2eyagfYAeyjp
         J6YhXtyttOPsBG3VuGgy1fsTjmEB3s/fhz/OndBm9QO7CPOjzxAh1eHIMqhfneJv3w4b
         rf8m5Enzar9VnoN/EEhSg+r2M4qssyspNgj2C2D3zn8LYcrxdASyH+Xbwbm+Y4IUgg9p
         y0gA==
X-Gm-Message-State: AGi0PuZ1MosHzegEJ65PanmgBH49U/t6PWpZ1Aawx7+7mSd4cW8Q64Ef
        aB5Jxwp6V8WSA5grfaKJNQFj7epRb04wb0EuxmzekJkQvLvhGRSsHyON/0lJsAp6fyYZHEm06DW
        OHJ0UEN5sN7yKRlgmShQt7oQM
X-Received: by 2002:adf:82a6:: with SMTP id 35mr2066252wrc.307.1586222188851;
        Mon, 06 Apr 2020 18:16:28 -0700 (PDT)
X-Google-Smtp-Source: APiQypLir8ak+FEKxx6nX6IWQbAd8ctofWczO7PodS6FKlDODkz8Fu/H7k8sFjO4H7aGhsCxS3SSXQ==
X-Received: by 2002:adf:82a6:: with SMTP id 35mr2066236wrc.307.1586222188647;
        Mon, 06 Apr 2020 18:16:28 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
        by smtp.gmail.com with ESMTPSA id f12sm138567wmh.4.2020.04.06.18.16.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 18:16:28 -0700 (PDT)
Date:   Mon, 6 Apr 2020 21:16:26 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH v8 00/19] virtio: alignment issues
Message-ID: <20200407011612.478226-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



This is an alternative to
	vhost: force spec specified alignment on types
which is a bit safer as it does not change UAPI.
I still think it's best to change the UAPI header as well,
we can do that as a follow-up cleanup.

changes from v7:
	typo fix
changes from v6:
	add missing header includes all over the place
changes from v5:
	ack for mellanox patch
	fixup to remoteproc
changes from v4:
	fixup to issues reported by kbuild
changes from v3:
	tools/virtio fixes
	a bunch more cleanups that now become possible

Changes from v2:
	don't change struct name, instead add ifndef
	so kernel does not see the legacy UAPI version.

Jason, can you pls ack one of the approaches?


Matej Genci (1):
  virtio: add VIRTIO_RING_NO_LEGACY

Michael S. Tsirkin (18):
  tools/virtio: define aligned attribute
  tools/virtio: make asm/barrier.h self contained
  tools/virtio: define __KERNEL__
  virtgpu: pull in uaccess.h
  virtio-rng: pull in slab.h
  remoteproc: pull in slab.h
  virtio_input: pull in slab.h
  virtio: stop using legacy struct vring in kernel
  vhost: force spec specified alignment on types
  virtio: add legacy init/size APIs
  virtio_ring: switch to virtio_legacy_init/size
  tools/virtio: switch to virtio_legacy_init/size
  vop: switch to virtio_legacy_init/size
  remoteproc: switch to virtio_legacy_init/size
  mellanox: switch to virtio_legacy_init/size
  vhost: option to fetch descriptors through an independent struct
  vhost: use batched version by default
  vhost: batching fetches

 drivers/block/virtio_blk.c               |   1 +
 drivers/char/hw_random/virtio-rng.c      |   1 +
 drivers/gpu/drm/virtio/virtgpu_ioctl.c   |   1 +
 drivers/misc/mic/vop/vop_main.c          |   5 +-
 drivers/misc/mic/vop/vop_vringh.c        |   8 +-
 drivers/platform/mellanox/mlxbf-tmfifo.c |   6 +-
 drivers/remoteproc/remoteproc_core.c     |   2 +-
 drivers/remoteproc/remoteproc_sysfs.c    |   1 +
 drivers/remoteproc/remoteproc_virtio.c   |   2 +-
 drivers/vhost/test.c                     |   2 +-
 drivers/vhost/vhost.c                    | 271 +++++++++++++++--------
 drivers/vhost/vhost.h                    |  23 +-
 drivers/virtio/virtio_input.c            |   1 +
 drivers/virtio/virtio_pci_modern.c       |   1 +
 drivers/virtio/virtio_ring.c             |  15 +-
 include/linux/virtio.h                   |   1 -
 include/linux/virtio_ring.h              |  46 ++++
 include/linux/vringh.h                   |   1 +
 include/uapi/linux/virtio_ring.h         |  30 ++-
 tools/virtio/Makefile                    |   2 +-
 tools/virtio/asm/barrier.h               |   1 +
 tools/virtio/linux/compiler.h            |   1 +
 tools/virtio/ringtest/virtio_ring_0_9.c  |   6 +-
 tools/virtio/virtio_test.c               |   6 +-
 tools/virtio/vringh_test.c               |  18 +-
 25 files changed, 311 insertions(+), 141 deletions(-)

-- 
MST

