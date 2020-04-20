Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8112C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 20:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0BE120736
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 20:00:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="frFIeFvB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbgDTUAL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 16:00:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43102 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726147AbgDTUAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 16:00:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587412809;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=+20lqtsdLoetbi1VKrLQV/f/K/xwxYS/9ftQPVBgJ9o=;
        b=frFIeFvB88aMDcJ6igS/aDBKi3T1xldX3PIzPhYcljPwdZlnLG7mC/DfVFy4pRtHsXNkqh
        oT4AlUgq+BVSudR4M+OUyS7cBGglqO+mzXMFlOl3kwa1ZSGjfYDQnGPSwsoV7Zx8CzNx1R
        nPSK9MeDxRJ9QWn7vTP01Scvgb0NE2g=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-209-9pQ3b7BzOnKjNPqt1QxwRw-1; Mon, 20 Apr 2020 16:00:06 -0400
X-MC-Unique: 9pQ3b7BzOnKjNPqt1QxwRw-1
Received: by mail-wr1-f69.google.com with SMTP id x15so4253487wrn.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 13:00:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=+20lqtsdLoetbi1VKrLQV/f/K/xwxYS/9ftQPVBgJ9o=;
        b=I5K7g8cvUuo4BS1qCP17BWgpZreMSC+oaLtCvXp/nqN3YRsL9Bq4dZEYlGdJQEjWaM
         6qYfnG4SEKHtt9eSr4GQWwB9clnIr+YJtTvnKhaKxjcFUiYREniC5K0tVYQHyWzZ4y0t
         i/8D8bh/60KY1uYKVJHUMQ1BI5dgfEFlvjVD7dDW7/OQcwMrmaohfFwmXVt23gNltItW
         qSjj21hZcCfxlB+fgdGjzh68+BdKPGc/WqHNVHfyBjtfeRjwfimxRcPMsLJdV6AgyH/f
         TEC/3mqjTy8xOelrGvyJyaXCYVMWVJRPDp/kDto2+T54XNcd5PhhkWPnzhDyZlEAHBMK
         mtoA==
X-Gm-Message-State: AGi0PuY3FlaKP2L+IsU5Z7PVOkJWqu/qjV2zCThfIurslVqe5/m9DIhZ
        8wYXXhAXZlAp7gtXw6H3DpnCnEaXdz7xTE/duAt+O8Hu4e+r6KQ0DMq65jfwrLcXJaopm6w5shY
        0CZGSKKuUPIsxXKGNlLp2IKfM
X-Received: by 2002:adf:f881:: with SMTP id u1mr20010584wrp.348.1587412804959;
        Mon, 20 Apr 2020 13:00:04 -0700 (PDT)
X-Google-Smtp-Source: APiQypJIVhqetK7aUCHYEkuU804XOceo66/cE0Dx1Q5aW14bSOsutRUOmxAsjw6JtGgBkBYwz6DrLg==
X-Received: by 2002:adf:f881:: with SMTP id u1mr20010546wrp.348.1587412804645;
        Mon, 20 Apr 2020 13:00:04 -0700 (PDT)
Received: from redhat.com (bzq-79-183-51-3.red.bezeqint.net. [79.183.51.3])
        by smtp.gmail.com with ESMTPSA id m1sm677467wro.64.2020.04.20.13.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 13:00:03 -0700 (PDT)
Date:   Mon, 20 Apr 2020 16:00:01 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        alexander.h.duyck@linux.intel.com, arnd@arndb.de,
        bjorn.andersson@linaro.org, eli@mellanox.com, eperezma@redhat.com,
        gustavo@embeddedor.com, hulkci@huawei.com, jasowang@redhat.com,
        mst@redhat.com, sfr@canb.auug.org.au, yanaijie@huawei.com,
        yuehaibing@huawei.com
Subject: [GIT PULL v2] vhost: cleanups and fixes
Message-ID: <20200420160001-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 8f3d9f354286745c751374f5f1fcafee6b3f3136:

  Linux 5.7-rc1 (2020-04-12 12:35:55 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to d085eb8ce727e581abf8145244eaa3339021be2f:

  vhost: disable for OABI (2020-04-20 10:19:22 -0400)

Changes from v1:
	Dropped a bunch of cleanups which turned out to be controversial

This has been in next for a while, though I tweaked some commit
logs so the hashes differ.

----------------------------------------------------------------
virtio: fixes, cleanups

Some bug fixes.
Cleanup a couple of issues that surfaced meanwhile.
Disable vhost on ARM with OABI for now - to be fixed
fully later in the cycle or in the next release.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Alexander Duyck (1):
      virtio-balloon: Avoid using the word 'report' when referring to free page hinting

Eugenio Pérez (1):
      vhost: Create accessors for virtqueues private_data

Gustavo A. R. Silva (1):
      vhost: vdpa: remove unnecessary null check

Jason Wang (1):
      vdpa: fix comment of vdpa_register_device()

Jason Yan (2):
      vhost: remove set but not used variable 'status'
      virtio-balloon: make virtballoon_free_page_report() static

Michael S. Tsirkin (15):
      vdpa-sim: depend on HAS_DMA
      virtio/test: fix up after IOTLB changes
      tools/virtio: define aligned attribute
      tools/virtio: make asm/barrier.h self contained
      virtgpu: pull in uaccess.h
      virtio-rng: pull in slab.h
      remoteproc: pull in slab.h
      virtio_input: pull in slab.h
      rpmsg: pull in slab.h
      remoteproc: pull in slab.h
      vdpa: allow a 32 bit vq alignment
      vdpa: make vhost, virtio depend on menu
      virtio_blk: add a missing include
      virtio: drop vringh.h dependency
      vhost: disable for OABI

Stephen Rothwell (1):
      drm/virtio: fix up for include file changes

YueHaibing (2):
      vdpa: remove unused variables 'ifcvf' and 'ifcvf_lm'
      vdpasim: Return status in vdpasim_get_status

 drivers/block/virtio_blk.c             |  1 +
 drivers/char/hw_random/virtio-rng.c    |  1 +
 drivers/gpu/drm/virtio/virtgpu_ioctl.c |  1 +
 drivers/gpu/drm/virtio/virtgpu_kms.c   |  1 +
 drivers/misc/mic/Kconfig               |  2 +-
 drivers/net/caif/Kconfig               |  2 +-
 drivers/remoteproc/remoteproc_sysfs.c  |  1 +
 drivers/remoteproc/stm32_rproc.c       |  1 +
 drivers/rpmsg/mtk_rpmsg.c              |  1 +
 drivers/vdpa/Kconfig                   | 18 ++++++------------
 drivers/vdpa/ifcvf/ifcvf_base.c        |  2 --
 drivers/vdpa/ifcvf/ifcvf_main.c        |  4 +---
 drivers/vdpa/vdpa.c                    |  2 +-
 drivers/vdpa/vdpa_sim/vdpa_sim.c       |  4 ++--
 drivers/vhost/Kconfig                  | 21 ++++++++++++++++-----
 drivers/vhost/net.c                    | 28 +++++++++++++++-------------
 drivers/vhost/scsi.c                   | 14 +++++++-------
 drivers/vhost/test.c                   | 14 +++++++-------
 drivers/vhost/vdpa.c                   |  5 -----
 drivers/vhost/vhost.h                  | 27 +++++++++++++++++++++++++++
 drivers/vhost/vringh.c                 |  5 +++++
 drivers/vhost/vsock.c                  | 14 +++++++-------
 drivers/virtio/Kconfig                 |  2 +-
 drivers/virtio/virtio_balloon.c        |  4 ++--
 drivers/virtio/virtio_input.c          |  1 +
 include/linux/vdpa.h                   |  2 +-
 include/linux/virtio.h                 |  1 -
 include/linux/vringh.h                 |  6 ++++++
 include/uapi/linux/virtio_balloon.h    | 11 +++++++++--
 tools/virtio/Makefile                  |  5 +++--
 tools/virtio/asm/barrier.h             |  1 +
 tools/virtio/generated/autoconf.h      |  0
 tools/virtio/linux/compiler.h          |  1 +
 33 files changed, 128 insertions(+), 75 deletions(-)
 create mode 100644 tools/virtio/generated/autoconf.h

