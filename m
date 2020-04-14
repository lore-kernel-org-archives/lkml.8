Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2149EC2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 16:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E899F20678
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 16:36:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dOWLE8Wq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391837AbgDNQgt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 12:36:49 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:59501 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2391809AbgDNQg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 12:36:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586882187;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Bma9lzqspxl+HaX8bOFBirR9lSGp5CwUCJdb2i/e18Q=;
        b=dOWLE8WqA4A5HAxi0P3RPoJcrIXAXMmTkLygoAf3Yr4XpYwq+9GylDMk7kPD2Ehcahs316
        2O/OmkgH/FDc/Nq6cj9wV9egccg5EToRhqymPv7sU4WiKr5pt+9wt0CoheGtdJO2yjJtHY
        rOg8yf3kCeB1qnzDlbqbBgTFVISQDSY=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-326-W7CESxTQOkyu0_laDKU0BQ-1; Tue, 14 Apr 2020 12:36:12 -0400
X-MC-Unique: W7CESxTQOkyu0_laDKU0BQ-1
Received: by mail-qv1-f72.google.com with SMTP id v11so330036qvw.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 09:36:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=Bma9lzqspxl+HaX8bOFBirR9lSGp5CwUCJdb2i/e18Q=;
        b=kCIElkZ0R7DkNvbt2/zwHqIBEci4cpdNT3OP136QM5euUoTGsjBmPL7q1Y7CUYwp1p
         X9uajgrTp85lc3Au57MxzeJVgcu6wxWTdk5KdcOKVIB6sSsUHqomG+xUNBvg6elmbN/j
         tV9bGuckiK2PkecFJ7XglwSMVAgCM6I0wQSp/h0+ckOWFX29TLdyswlcF685zAy1s6O0
         n+DugQvdEYNXsGX27tYUqFxCoX8VjNgp8K8n7OHZunq5Sh6m+Tc2juiWzVNH07caqxpc
         xUmBKGc6ZmpYYQAjKtKhFPfLNpDmgHFdH2Di4yRyI6GnQSKQaWoUl6mS4o1FMJNXO/By
         LN8w==
X-Gm-Message-State: AGi0PuZmHavBVbV+ooXnXvTlakZ9B/069nZiJxITPyhSrH1h3c9xy83E
        3zdtRMCfUIDYsM6Ye4Cf66ZJaNUzhnHTPIzJVVItHzINEj/nyoJmxRkHFBhtiMLRn2jCNIDY+9I
        SvhGnpd+ZUqcHXVw8ujafsD56
X-Received: by 2002:aed:3968:: with SMTP id l95mr17285865qte.268.1586882172287;
        Tue, 14 Apr 2020 09:36:12 -0700 (PDT)
X-Google-Smtp-Source: APiQypJmGmy3GlXUch/z8/x+Ns406G7xQ35JzF4VsBJ4waQC3oBq6dZNWOjBqM2wZ8BVLIAkuD0c8Q==
X-Received: by 2002:aed:3968:: with SMTP id l95mr17285823qte.268.1586882171965;
        Tue, 14 Apr 2020 09:36:11 -0700 (PDT)
Received: from redhat.com (bzq-79-183-51-3.red.bezeqint.net. [79.183.51.3])
        by smtp.gmail.com with ESMTPSA id u126sm10933237qkh.66.2020.04.14.09.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 09:36:11 -0700 (PDT)
Date:   Tue, 14 Apr 2020 12:36:06 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        andy.shevchenko@gmail.com, arnd@arndb.de, ashutosh.dixit@intel.com,
        bjorn.andersson@linaro.org, elfring@users.sourceforge.net,
        eli@mellanox.com, eperezma@redhat.com, gustavo@embeddedor.com,
        hulkci@huawei.com, jasowang@redhat.com, matej.genci@nutanix.com,
        mst@redhat.com, sfr@canb.auug.org.au, yanaijie@huawei.com,
        yuehaibing@huawei.com
Subject: [GIT PULL] vhost: cleanups and fixes
Message-ID: <20200414123606-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 835a6a649d0dd1b1f46759eb60fff2f63ed253a7:

  virtio-balloon: Revert "virtio-balloon: Switch back to OOM handler for VIRTIO_BALLOON_F_DEFLATE_ON_OOM" (2020-04-07 05:44:57 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to d4a85c2ace895a58dcab687ff49c76719011f58d:

  vdpa: fix comment of vdpa_register_device() (2020-04-13 07:16:41 -0400)

----------------------------------------------------------------
virtio: fixes, cleanups

Some bug fixes.
Cleanup a couple of issues that surfaced meanwhile.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Eugenio Pérez (4):
      vhost: Create accessors for virtqueues private_data
      tools/virtio: Add --batch option
      tools/virtio: Add --batch=random option
      tools/virtio: Add --reset=random

Gustavo A. R. Silva (1):
      vhost: vdpa: remove unnecessary null check

Jason Wang (1):
      vdpa: fix comment of vdpa_register_device()

Jason Yan (1):
      vhost: remove set but not used variable 'status'

Markus Elfring (1):
      virtio-mmio: Delete an error message in vm_find_vqs()

Matej Genci (1):
      virtio: add VIRTIO_RING_NO_LEGACY

Michael S. Tsirkin (22):
      vdpa-sim: depend on HAS_DMA
      virtio/test: fix up after IOTLB changes
      vhost: drop vring dependency on iotlb
      tools/virtio: define aligned attribute
      tools/virtio: make asm/barrier.h self contained
      tools/virtio: define __KERNEL__
      virtgpu: pull in uaccess.h
      virtio-rng: pull in slab.h
      remoteproc: pull in slab.h
      virtio_input: pull in slab.h
      rpmsg: pull in slab.h
      remoteproc: pull in slab.h
      virtio: stop using legacy struct vring in kernel
      vhost: force spec specified alignment on types
      virtio: add legacy init/size APIs
      virtio_ring: switch to virtio_legacy_init/size
      tools/virtio: switch to virtio_legacy_init/size
      vop: switch to virtio_legacy_init/size
      remoteproc: switch to virtio_legacy_init/size
      mellanox: switch to virtio_legacy_init/size
      vdpa: allow a 32 bit vq alignment
      vdpa: make vhost, virtio depend on menu

Stephen Rothwell (1):
      drm/virtio: fix up for include file changes

YueHaibing (2):
      vdpa: remove unused variables 'ifcvf' and 'ifcvf_lm'
      vdpasim: Return status in vdpasim_get_status

 drivers/block/virtio_blk.c               |   1 +
 drivers/char/hw_random/virtio-rng.c      |   1 +
 drivers/gpu/drm/virtio/virtgpu_ioctl.c   |   1 +
 drivers/gpu/drm/virtio/virtgpu_kms.c     |   1 +
 drivers/misc/mic/vop/vop_main.c          |   5 +-
 drivers/misc/mic/vop/vop_vringh.c        |   8 ++-
 drivers/platform/mellanox/mlxbf-tmfifo.c |   6 +-
 drivers/remoteproc/remoteproc_core.c     |   2 +-
 drivers/remoteproc/remoteproc_sysfs.c    |   1 +
 drivers/remoteproc/remoteproc_virtio.c   |   2 +-
 drivers/remoteproc/stm32_rproc.c         |   1 +
 drivers/rpmsg/mtk_rpmsg.c                |   1 +
 drivers/vdpa/Kconfig                     |  19 +++---
 drivers/vdpa/ifcvf/ifcvf_base.c          |   2 -
 drivers/vdpa/ifcvf/ifcvf_main.c          |   4 +-
 drivers/vdpa/vdpa.c                      |   2 +-
 drivers/vdpa/vdpa_sim/vdpa_sim.c         |   4 +-
 drivers/vhost/Kconfig                    |   5 +-
 drivers/vhost/net.c                      |  28 +++++----
 drivers/vhost/scsi.c                     |  14 ++---
 drivers/vhost/test.c                     |  71 +++++++++++++++++++---
 drivers/vhost/test.h                     |   1 +
 drivers/vhost/vdpa.c                     |   5 --
 drivers/vhost/vhost.h                    |  33 +++++++++-
 drivers/vhost/vringh.c                   |   5 ++
 drivers/vhost/vsock.c                    |  14 ++---
 drivers/virtio/Kconfig                   |   2 +-
 drivers/virtio/virtio_input.c            |   1 +
 drivers/virtio/virtio_mmio.c             |   4 +-
 drivers/virtio/virtio_pci_modern.c       |   1 +
 drivers/virtio/virtio_ring.c             |  15 +++--
 include/linux/vdpa.h                     |   2 +-
 include/linux/virtio.h                   |   1 -
 include/linux/virtio_ring.h              |  46 ++++++++++++++
 include/linux/vringh.h                   |   7 +++
 include/uapi/linux/virtio_ring.h         |  30 ++++++---
 tools/virtio/Makefile                    |   5 +-
 tools/virtio/asm/barrier.h               |   1 +
 tools/virtio/generated/autoconf.h        |   0
 tools/virtio/linux/compiler.h            |   1 +
 tools/virtio/ringtest/virtio_ring_0_9.c  |   6 +-
 tools/virtio/virtio_test.c               | 101 ++++++++++++++++++++++++++-----
 tools/virtio/vringh_test.c               |  18 +++---
 43 files changed, 354 insertions(+), 124 deletions(-)
 create mode 100644 tools/virtio/generated/autoconf.h

