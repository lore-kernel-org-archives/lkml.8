Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D0CC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 20:58:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BB7422C9F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 20:58:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N/FM95nk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728753AbgHCU6m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 16:58:42 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:45635 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727003AbgHCU6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 16:58:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596488320;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=T01zlXdVAdfOQiZawGmFzoRF7DScTQR3FGD2nDiB9KQ=;
        b=N/FM95nkk3DJdnNZWc0KJfGqAQCFVu5EHFW99jX7Ua7BwRANiJ01qXO9mRhV/h0Ovqq+ud
        p9w+7dWxhLMT8a7vhH4/79dggf4it5j7XxWbSj8QxLBlNn3YzhnrwLIRdvEoKbzxOSNq+x
        dTK5NCnGNgSlpE1tl1HatJp5xzWuKY0=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-hLOep-ZNN6SJnvKVeqA9aw-1; Mon, 03 Aug 2020 16:58:38 -0400
X-MC-Unique: hLOep-ZNN6SJnvKVeqA9aw-1
Received: by mail-qv1-f70.google.com with SMTP id v18so21747620qvi.8
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 13:58:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=T01zlXdVAdfOQiZawGmFzoRF7DScTQR3FGD2nDiB9KQ=;
        b=B70NgZ6bhKwpYkypRk/oJoc/FesDTzgiJh/wHboXpb7YekTfgZ2zJPNX1ZbZ75sIb+
         G1rNs9lbkzFGs0G96g2zla9kflP2kQM/uciR2Nn1RYmGe7Gl1TYZdB5URqFZPsLgRQjA
         x8pnlzor7gSPVtelDLMsNFWfLWILgJVGg4NYKbIlXxZ3ocM8pUYTPDmaptoMmEoPQ4Do
         0WPfoF21AyOrJaJBzKom0EiHEM3whaDluF3UwPduUVdh1niI8FFGqFH/8GdoBhKsDp9/
         3TXkUEfmULbVhoPvHnr7pqEncBXdpCbCc57bNm1AF8c1331/YaH6E2DiA2Q42S+rgFx0
         35OQ==
X-Gm-Message-State: AOAM532f3IRmm6UMyVZRk/5/89Qhp6G62Wx0wVO7n1P3tSA16B9XjHex
        CfuZI9YdIkQCi3x9wbhJC7q1Q92s+1a8VCBh2y/18BBsdMXEKs4NL3ElKTeCZSNL2eBahRXFe5f
        Y5Fo2f01rTN04poYLpZWciseT
X-Received: by 2002:ac8:7c97:: with SMTP id y23mr18342396qtv.273.1596488317551;
        Mon, 03 Aug 2020 13:58:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyvO+j2uYhARxvEky6htFfOz+rIDCcYIBBFGBoTihj8mAdmwv6DmYgMv6QBYcyxVH2Z+pUung==
X-Received: by 2002:ac8:7c97:: with SMTP id y23mr18342383qtv.273.1596488317312;
        Mon, 03 Aug 2020 13:58:37 -0700 (PDT)
Received: from redhat.com (bzq-79-177-102-128.red.bezeqint.net. [79.177.102.128])
        by smtp.gmail.com with ESMTPSA id g4sm21056476qtp.89.2020.08.03.13.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 13:58:36 -0700 (PDT)
Date:   Mon, 3 Aug 2020 16:58:33 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org,
        Jason Wang <jasowang@redhat.com>
Subject: [PATCH v2 00/24] virtio: config space endian-ness cleanup
Message-ID: <20200803205814.540410-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Config space endian-ness is currently a mess: fields are
not tagged with the correct endian-ness so it's easy
to make mistakes like instanciating config space in
native endian-ness.

The following patches adding sparse tagging are currently in my tree.
Lightly tested.

As a follow-up, I plan to add new APIs that handle modern config space
in a more efficient way (bypassing the version check).

That is still TBD.

I also start with a version using gcc extensions, then switch
to _Generic. This is helpful for backports to older kernels/older
distros: _Generic patch can just be skipped.

Michael S. Tsirkin (24):
  virtio_balloon: fix sparse warning
  virtio_ring: sparse warning fixup
  virtio: allow __virtioXX, __leXX in config space
  virtio_9p: correct tags for config space fields
  virtio_balloon: correct tags for config space fields
  virtio_blk: correct tags for config space fields
  virtio_console: correct tags for config space fields
  virtio_crypto: correct tags for config space fields
  virtio_fs: correct tags for config space fields
  virtio_gpu: correct tags for config space fields
  virtio_input: correct tags for config space fields
  virtio_iommu: correct tags for config space fields
  virtio_mem: correct tags for config space fields
  virtio_net: correct tags for config space fields
  virtio_pmem: correct tags for config space fields
  virtio_scsi: correct tags for config space fields
  virtio_config: disallow native type fields
  mlxbf-tmfifo: sparse tags for config access
  vdpa: make sure set_features in invoked for legacy
  vhost/vdpa: switch to new helpers
  virtio_vdpa: legacy features handling
  vdpa_sim: fix endian-ness of config space
  virtio_config: cread/write cleanup
  virtio_config: rewrite using _Generic

 drivers/platform/mellanox/mlxbf-tmfifo.c |  13 +-
 drivers/scsi/virtio_scsi.c               |   4 +-
 drivers/vdpa/vdpa.c                      |   1 +
 drivers/vdpa/vdpa_sim/vdpa_sim.c         |  31 ++++-
 drivers/vhost/vdpa.c                     |   8 +-
 drivers/virtio/virtio_balloon.c          |   2 +-
 drivers/virtio/virtio_vdpa.c             |   9 +-
 include/linux/vdpa.h                     |  34 +++++
 include/linux/virtio_config.h            | 159 ++++++++++++++---------
 include/linux/virtio_ring.h              |  19 ++-
 include/uapi/linux/virtio_9p.h           |   4 +-
 include/uapi/linux/virtio_balloon.h      |  10 +-
 include/uapi/linux/virtio_blk.h          |  26 ++--
 include/uapi/linux/virtio_console.h      |   8 +-
 include/uapi/linux/virtio_crypto.h       |  26 ++--
 include/uapi/linux/virtio_fs.h           |   2 +-
 include/uapi/linux/virtio_gpu.h          |   8 +-
 include/uapi/linux/virtio_input.h        |  18 +--
 include/uapi/linux/virtio_iommu.h        |  12 +-
 include/uapi/linux/virtio_mem.h          |  14 +-
 include/uapi/linux/virtio_net.h          |   8 +-
 include/uapi/linux/virtio_pmem.h         |   4 +-
 include/uapi/linux/virtio_scsi.h         |  20 +--
 23 files changed, 270 insertions(+), 170 deletions(-)

-- 
MST

