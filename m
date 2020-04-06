Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51249C2BA80
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 21:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2909D20787
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 21:35:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ShzdWgPn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbgDFVfC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 17:35:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42202 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726636AbgDFVe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 17:34:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586208897;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=J2Be15duY9KpnTQHFwFOEXZe0/tIjp9ZiSA/Vi9AXgk=;
        b=ShzdWgPna7ob9WlfbSRDaGQKW9Nk5aYEXI8VLtLso5OsUT+MuLopLkO8/PROecexop0Z6w
        +MIN0aOrgr9wc1XeJodtT8k9M/UpYYq9fpmnAmBRGNKo/w7k9wnDqyqQ+h+H+hakdOqzKq
        R6Hr4e6Mw4EkCb3HIcPIK3kUzyAeufE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-485-In7mhNAcMW-pZEazlMwwFw-1; Mon, 06 Apr 2020 17:34:55 -0400
X-MC-Unique: In7mhNAcMW-pZEazlMwwFw-1
Received: by mail-wm1-f70.google.com with SMTP id n127so412636wme.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 14:34:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=J2Be15duY9KpnTQHFwFOEXZe0/tIjp9ZiSA/Vi9AXgk=;
        b=BpgM3K+qVLherCrUoIR9P+Q9uhDxtFVW322YFDn+9YyV95422zp/zjoUsucQCcZv58
         EyWNCCb9i7tQpzlHM5o59lNe/aLNFcEfXRRiiKl1VFo8sbovtr4iqE2sJUEegeV2u9xI
         fFP26oPcgLa5tFUVJB+XG7zCsSIDNZ3s2+bYMfnb5k1tgYAPFrIg7dwXjWyfVo8jQphd
         mzDL2nIKAzTewIvJ3HBefR9lzqtLuoK631V8Yc297vJBlXhmRCUDWVMdS9LpTAtU8J7W
         kn1k/WpomXrh3nhKnO8GrQWdcnpFIl6V9+qo/lergI/C/cTWCMZLJnOUwP7L6viiYG6B
         fEzw==
X-Gm-Message-State: AGi0PuY9ZHyM3PjhJNzvIWkjuu+Chl12fpmBollQIHMc6oVwfD8DgZd5
        yh0VJntpcZJmif6PGSpPMnhDNbRhCfqBhV9E8XYQlHKuOmickUA4RN9ZVz5WZLSU7B92yUOyvjR
        7WJIfyhTO9jXRPUCtJChZvzNj
X-Received: by 2002:a1c:2842:: with SMTP id o63mr1033322wmo.73.1586208894306;
        Mon, 06 Apr 2020 14:34:54 -0700 (PDT)
X-Google-Smtp-Source: APiQypKv6HqxsBY+hJ7T4a8LOBSURe73yebXRFq0DgashhftdKumNSVNpEzL9yqzt3u5/v4eXRQlSA==
X-Received: by 2002:a1c:2842:: with SMTP id o63mr1033305wmo.73.1586208894121;
        Mon, 06 Apr 2020 14:34:54 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
        by smtp.gmail.com with ESMTPSA id v9sm17502734wrv.18.2020.04.06.14.34.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 14:34:53 -0700 (PDT)
Date:   Mon, 6 Apr 2020 17:34:52 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH v5 00/12] virtio: alignment issues
Message-ID: <20200406213314.248038-1-mst@redhat.com>
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
 18 files changed, 111 insertions(+), 45 deletions(-)

-- 
MST

