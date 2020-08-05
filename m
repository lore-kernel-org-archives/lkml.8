Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2771CC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 17:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDA942177B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 17:16:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VJMJJfSH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728461AbgHERP4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 13:15:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32880 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728593AbgHERLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 13:11:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596647464;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=aKIWpeHa/RLGXCmmUH8pks8+iWsKwpmH1MNDmcSULo0=;
        b=VJMJJfSHaZYD+ggZVLL6E9laXK16jA8d+ElLqJnO5gTZn8BthBtKBhnjaoms/HgzfKUmnq
        f8izvuCVDDqsmv+obLD5vh/ls6jEdGOywKWvGBgaX0uaFNNjE8bl5txjoGzOxsEw/nXIv0
        pGQmAvnTMh9aB9S1LD6aOQ8gDkpsuIc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-311-tpzE5OfnPZW2a8k_cvJUPg-1; Wed, 05 Aug 2020 09:43:18 -0400
X-MC-Unique: tpzE5OfnPZW2a8k_cvJUPg-1
Received: by mail-wr1-f71.google.com with SMTP id t3so12558743wrr.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 06:43:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=aKIWpeHa/RLGXCmmUH8pks8+iWsKwpmH1MNDmcSULo0=;
        b=nPdoGasVimeLUNJ5Zf8cdN3CgYBx6tn+xGlYKezqb/C337DQWif8sWtFmiHUhzf2OV
         H0pS2ke19Fhkx7SHVOCXKRhnRqkoKZyZAUVpUli0V6c5SUKUTW98fY0Gtpmp06Ejws2W
         V34GkoOQTEnyTevP+3sShBxyePeSGJ1CljFYSD8yGMyVMFzx44dZYgmNxyQ6ScFswiHE
         xbC1BCdRDyf3YFvA/Jjqj1JE6SYK1tckdHTGN5s9gxBt98p7CahLVQpkHk5atiB71/55
         KaygolN9hHF+6ZuJleE3hqNsuUd5c2i5GHkhapr2F+qHCuLjqqTlxlJySLwUE41EtUXT
         ETeg==
X-Gm-Message-State: AOAM533QeTv1pdlCpIg8pkvHXvH9zBDgp/GDfAT8npec7uWQN0C20/qU
        DI6ygUTXJdAqIGdLznldeuDFqiNVpzB1HIad/+ElTfyQpITr+hhQsMuGA0ZpEWuYhX5OQDvAzTL
        x+yp+quXmXtiCiXzKRe3+3tv6
X-Received: by 2002:a7b:c0cb:: with SMTP id s11mr3324400wmh.89.1596634996846;
        Wed, 05 Aug 2020 06:43:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyCK99fQ5n5aXVlfLroRWKUif4azFqZTwF3G4NgOhHlsHfvsOV74tZlVVZA3VZg8bz8gR1Ong==
X-Received: by 2002:a7b:c0cb:: with SMTP id s11mr3324384wmh.89.1596634996652;
        Wed, 05 Aug 2020 06:43:16 -0700 (PDT)
Received: from redhat.com (bzq-79-180-0-181.red.bezeqint.net. [79.180.0.181])
        by smtp.gmail.com with ESMTPSA id d23sm2908603wmd.27.2020.08.05.06.43.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 06:43:16 -0700 (PDT)
Date:   Wed, 5 Aug 2020 09:43:14 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH v3 00/38] virtio: config space endian-ness cleanup
Message-ID: <20200805134226.1106164-1-mst@redhat.com>
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

Further, LE-only devices (e.g. modern-style) add unnecessary overhead
by using generic transitional-style config space accesses.

The following patches adding sparse tagging and then using that
to correctly access config space as either transitional or LE
are my tree.
Lightly tested.

I also start with a version using gcc extensions, then switch
to _Generic. This is helpful for backports to older kernels/older
distros: _Generic patch can just be skipped there.

changes from v2:
	- convert a couple of missing devices
	- add APIs for accessing config space as LE, use that
	  in modern devices and in balloon.
	- code comments in vdpa_sim explaining use of transitional APIs


Michael S. Tsirkin (38):
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
  vdpa: make sure set_features is invoked for legacy
  vhost/vdpa: switch to new helpers
  virtio_vdpa: legacy features handling
  vdpa_sim: fix endian-ness of config space
  virtio_config: cread/write cleanup
  virtio_config: rewrite using _Generic
  virtio_config: disallow native type fields (again)
  virtio_config: LE config space accessors
  virtio_caif: correct tags for config space fields
  virtio_config: add virtio_cread_le_feature
  virtio_balloon: use LE config space accesses
  virtio_input: convert to LE accessors
  virtio_fs: convert to LE accessors
  virtio_crypto: convert to LE accessors
  virtio_pmem: convert to LE accessors
  drm/virtio: convert to LE accessors
  virtio_mem: convert to LE accessors
  virtio-iommu: convert to LE accessors
  virtio_config: drop LE option from config space
  virtio_net: use LE accessors for speed/duplex

 drivers/crypto/virtio/virtio_crypto_core.c |  46 ++---
 drivers/gpu/drm/virtio/virtgpu_kms.c       |  16 +-
 drivers/iommu/virtio-iommu.c               |  34 ++--
 drivers/net/virtio_net.c                   |   9 +-
 drivers/nvdimm/virtio_pmem.c               |   4 +-
 drivers/platform/mellanox/mlxbf-tmfifo.c   |  13 +-
 drivers/scsi/virtio_scsi.c                 |   4 +-
 drivers/vdpa/vdpa.c                        |   1 +
 drivers/vdpa/vdpa_sim/vdpa_sim.c           |  33 +++-
 drivers/vhost/vdpa.c                       |   8 +-
 drivers/virtio/virtio_balloon.c            |  28 ++--
 drivers/virtio/virtio_input.c              |  32 ++--
 drivers/virtio/virtio_mem.c                |  30 ++--
 drivers/virtio/virtio_vdpa.c               |   9 +-
 fs/fuse/virtio_fs.c                        |   4 +-
 include/linux/vdpa.h                       |  34 ++++
 include/linux/virtio_caif.h                |   6 +-
 include/linux/virtio_config.h              | 186 +++++++++++++++------
 include/linux/virtio_ring.h                |  19 +--
 include/uapi/linux/virtio_9p.h             |   4 +-
 include/uapi/linux/virtio_balloon.h        |  10 +-
 include/uapi/linux/virtio_blk.h            |  26 +--
 include/uapi/linux/virtio_console.h        |   8 +-
 include/uapi/linux/virtio_crypto.h         |  26 +--
 include/uapi/linux/virtio_fs.h             |   2 +-
 include/uapi/linux/virtio_gpu.h            |   8 +-
 include/uapi/linux/virtio_input.h          |  18 +-
 include/uapi/linux/virtio_iommu.h          |  12 +-
 include/uapi/linux/virtio_mem.h            |  14 +-
 include/uapi/linux/virtio_net.h            |   8 +-
 include/uapi/linux/virtio_pmem.h           |   4 +-
 include/uapi/linux/virtio_scsi.h           |  20 +--
 32 files changed, 405 insertions(+), 271 deletions(-)

-- 
MST

