Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B7E0C2BA1A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 21:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5197F206C3
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 21:34:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LUZlI2Wo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbgDFVec (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 17:34:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49918 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725895AbgDFVeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 17:34:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586208869;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=1sZ8OOJadwa2nvBkBvJvN7OoNXEjWxDQSrFUIfTzI4g=;
        b=LUZlI2Wo04c51zs+UNizXdUcZK+Y2A4Ua6R7ORUuUUvx90IC0Y2BVtKuBzPiq2l0bU5uhO
        JbcxM8OATnwhp91NflCfcm/Cg0U1d6ltqaDIuHKtGcp7olkpixhz0/DimH+ydlYAJ+yHJW
        A1zSQYVSbVjdBwSqkx7kJKEUL//ZUpc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-494-9jGSM0QKOjeJJ9nDdGfxjg-1; Mon, 06 Apr 2020 17:34:28 -0400
X-MC-Unique: 9jGSM0QKOjeJJ9nDdGfxjg-1
Received: by mail-wm1-f71.google.com with SMTP id e16so412479wmh.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 14:34:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=1sZ8OOJadwa2nvBkBvJvN7OoNXEjWxDQSrFUIfTzI4g=;
        b=fqkxXrLSF4y61tVeC0T7OxywfQxM/qE2RxviB67j9zHXbZLjNWT/9B0dOAc1pMpg9h
         wvvOG6mgRdpFM4phAy3OON53Gvd8Pi+fOmiDJYD2WIZftPc35IcxPVfJdrfRl9VT0FCX
         DvzZpMiWJSdGq+HCK2QkptjJNeP4fp6obHl+q8HdNXY3GIJwhcaQ7pRiw7WHH1nQaLoZ
         8Y81LMsPnGix/c5JTJOLxDwFtDlEcRie2GS7zMXgD5ZXuOXZz+FpPKfNr5o8yPBlBrU0
         +7Nsf8S5nKjJW2uQS/IaPltwc33x4DPD1MfnVWQugjoqcn8nnRfXRQd47JUYl5J8sO+f
         Cf6A==
X-Gm-Message-State: AGi0PuYSnmyWLv90PZWKnzbHea9idPNb0GMRNVJOUS2ieMQ2ef0LrBHR
        CDmi775D32SZy8b10U+nKd1XmrA013gt+g8aYGtsdkcyA7wINrzehYHY3PdJOwgprnM72VsXmQx
        57H8A/VXRd2riKVwhK2EeerFr
X-Received: by 2002:a1c:195:: with SMTP id 143mr1089750wmb.0.1586208866444;
        Mon, 06 Apr 2020 14:34:26 -0700 (PDT)
X-Google-Smtp-Source: APiQypJtVitTo8Jc7qPkfGBinVZbvA0f5dsOX7DORdYPtHLOGRIFfRXKAwHHQ2twIGwKrTUEcixAMQ==
X-Received: by 2002:a1c:195:: with SMTP id 143mr1089730wmb.0.1586208866128;
        Mon, 06 Apr 2020 14:34:26 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
        by smtp.gmail.com with ESMTPSA id h5sm26965139wro.83.2020.04.06.14.34.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 14:34:25 -0700 (PDT)
Date:   Mon, 6 Apr 2020 17:34:24 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH v4 00/12] virtio: alignment issues
Message-ID: <20200406210108.148131-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Message-ID: <20200406213424.8H9A6CbSvxAftDvjkeiJ8E_zwDxMYJF5VQZ-_-iagiw@z>

This is an alternative to
	vhost: force spec specified alignment on types
which is a bit safer as it does not change UAPI.
I still think it's best to change the UAPI header as well,
we can do that as a follow-up cleanup.

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

 drivers/misc/mic/vop/vop_main.c          |  5 +--
 drivers/misc/mic/vop/vop_vringh.c        |  8 +++--
 drivers/platform/mellanox/mlxbf-tmfifo.c |  6 ++--
 drivers/remoteproc/remoteproc_core.c     |  2 +-
 drivers/vhost/vhost.h                    |  6 ++--
 drivers/virtio/virtio_pci_modern.c       |  1 +
 drivers/virtio/virtio_ring.c             | 15 ++++----
 include/linux/virtio_ring.h              | 46 ++++++++++++++++++++++++
 include/linux/vringh.h                   |  1 +
 include/uapi/linux/virtio_ring.h         | 30 ++++++++++------
 tools/virtio/Makefile                    |  2 +-
 tools/virtio/asm/barrier.h               |  1 +
 tools/virtio/linux/compiler.h            |  1 +
 tools/virtio/ringtest/virtio_ring_0_9.c  |  6 ++--
 tools/virtio/virtio_test.c               |  6 ++--
 tools/virtio/vringh_test.c               | 18 +++++-----
 16 files changed, 110 insertions(+), 44 deletions(-)

-- 
MST

