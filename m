Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB54C2BA1A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 22:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D90C6206C3
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 22:26:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ABcnJlFi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgDFW0e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 18:26:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46050 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726130AbgDFW0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 18:26:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586211992;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=iZFgKkz0QCkMCePst5Xuy/AmzY50YNGDctVrJzdrtEA=;
        b=ABcnJlFi6he8TVY1RXkAyjIZL73cKdJdTBx5qcpEFjFPXRQyER9K3Wg0LkP9RuhXLICipF
        wtxBP+SoLDH4vmn+/iXc+51JrOxQ9kLmXFBJjOEhq7yjeYO35oV1/1ywHiHIdMbRZs0Ryg
        WJnsRs2x1gIJygtbTGStB1NLGQY4b5Y=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-163-GFrvpWp6MZSvx06IWld6eQ-1; Mon, 06 Apr 2020 18:26:30 -0400
X-MC-Unique: GFrvpWp6MZSvx06IWld6eQ-1
Received: by mail-wr1-f72.google.com with SMTP id y1so653276wrp.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 15:26:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=iZFgKkz0QCkMCePst5Xuy/AmzY50YNGDctVrJzdrtEA=;
        b=QRDbxW8Ltxh9x5JIghP3Ll4Ls1z0WjeJEYoPY8meQzlZn3WFNziZAOU73C9/AU3PY2
         JaeSjYl7v76mJPeBS1pOeAFdN6qpgqAbMRAk76wY7Quy63nLBENalnG4e/N0qnrgs6r3
         Gzovcr3hYxvcf60FUrLO0N3bel7srnQFjhtvPQiSs3lPAibkqhAVGSwZxNoeFZN/EZWv
         AmxCpyc2dyOE4cKhIabGp04Lz8GLHL36iAK+fXnG3uINuKFTZr9vPIUdVRqUJUnNO1Q7
         nLfdfpezSjRaeLu7SayFvAz9tqC3v70YDO8Jbc18JLjd5VzcFKWTsGHhqh343m0+Rjk4
         +iQg==
X-Gm-Message-State: AGi0PubqenT6I+ygild2WafHLx/QXx3R02xJIy118hHOzt4UrvDuQLfV
        Wz81yEZbmKupuXhMt7oiPU6uxF96MZo3BeBuwqTPpk/74+JAMLt8QVHyOG9CuRldD5CLMuH2KO1
        L2fCvX1v1MO0YMxgO6mAvoSuh
X-Received: by 2002:adf:bc12:: with SMTP id s18mr1617093wrg.220.1586211989687;
        Mon, 06 Apr 2020 15:26:29 -0700 (PDT)
X-Google-Smtp-Source: APiQypJX2C7Rw+ThjHeodQvuD1Mogzb4F56ms0JFCnvh5DLAbPjOfFM4wzY7V2MjZtVUV7UPlMzQLA==
X-Received: by 2002:adf:bc12:: with SMTP id s18mr1617086wrg.220.1586211989511;
        Mon, 06 Apr 2020 15:26:29 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
        by smtp.gmail.com with ESMTPSA id j31sm21556719wre.36.2020.04.06.15.26.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 15:26:28 -0700 (PDT)
Date:   Mon, 6 Apr 2020 18:26:27 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH v6 00/12] virtio: alignment issues
Message-ID: <20200406222507.281867-1-mst@redhat.com>
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

Michael S. Tsirkin (11):
  tools/virtio: define aligned attribute
  tools/virtio: make asm/barrier.h self contained
  tools/virtio: define __KERNEL__
  virtio: stop using legacy struct vring in kernel
  vhost: force spec specified alignment on types
  virtio: add legacy init/size APIs
  virtio_ring: switch to virtio_legacy_init/size
  tools/virtio: switch to virtio_legacy_init/size
  vop: switch to virtio_legacy_init/size
  remoteproc: switch to virtio_legacy_init/size
  mellanox: switch to virtio_legacy_init/size

 drivers/block/virtio_blk.c               |  1 +
 drivers/misc/mic/vop/vop_main.c          |  5 +--
 drivers/misc/mic/vop/vop_vringh.c        |  8 +++--
 drivers/platform/mellanox/mlxbf-tmfifo.c |  6 ++--
 drivers/remoteproc/remoteproc_core.c     |  2 +-
 drivers/remoteproc/remoteproc_virtio.c   |  2 +-
 drivers/vhost/vhost.h                    |  6 ++--
 drivers/virtio/virtio_pci_modern.c       |  1 +
 drivers/virtio/virtio_ring.c             | 15 ++++----
 include/linux/virtio.h                   |  1 -
 include/linux/virtio_ring.h              | 46 ++++++++++++++++++++++++
 include/linux/vringh.h                   |  1 +
 include/uapi/linux/virtio_ring.h         | 30 ++++++++++------
 tools/virtio/Makefile                    |  2 +-
 tools/virtio/asm/barrier.h               |  1 +
 tools/virtio/linux/compiler.h            |  1 +
 tools/virtio/ringtest/virtio_ring_0_9.c  |  6 ++--
 tools/virtio/virtio_test.c               |  6 ++--
 tools/virtio/vringh_test.c               | 18 +++++-----
 19 files changed, 112 insertions(+), 46 deletions(-)

-- 
MST

