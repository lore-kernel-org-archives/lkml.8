Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05FB5C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 19:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C71452054F
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 19:19:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gQxJZiUE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728240AbgCaTTk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 15:19:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29776 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727509AbgCaTTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 15:19:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585682379;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=0IfbKcvIcmN0WMW+gq6VvzM1ouYbOK6lV9wgE4RKQWc=;
        b=gQxJZiUExwWnalyRDdQZS8zBW8CV8msLJdVCI/9pLhaaEBggGjJ0QMc+T6D7hvh6gO6Rsl
        TxN32sPWTU457JBCUfbqscEym+CCJfP3OfCN6qY+U2WO6I5r3xyWezPzYnuElK6XqkjEcq
        f4moghaD+yDSaNZdm5tbL8FF4YsdjS4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-319-rTbzpUNhN7qIkAMC7OEbYg-1; Tue, 31 Mar 2020 15:19:37 -0400
X-MC-Unique: rTbzpUNhN7qIkAMC7OEbYg-1
Received: by mail-wr1-f71.google.com with SMTP id d1so13368789wru.15
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 12:19:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=0IfbKcvIcmN0WMW+gq6VvzM1ouYbOK6lV9wgE4RKQWc=;
        b=K8W6lummthpAaXt3zsIL2ysb/52N1YWcUX+SCHrhg5BZHp4spA705qaRszOYLS1l8J
         kH+yu+yUb/UNKRDP5ooiNroftHfg2sv/5mkC/pDedJ3jRf7o5tKv4G10lsoDNKy6Iks1
         YLojHgInwcc6nKeZcBwx+mOnBkYYWWSDtT5QpeAb9BWsjSXPjFCS5yb6NBiQQ4Ln/2/U
         YNpcZhbhDNDzH17nqocLHXF+Sy2Rf/38xGaU/+wVjkhYNb5PaM2ntrzweu7RVqCpkoyd
         s0TeIie6rxX+zydMl1+r4VaWbENUOV3ljOFyAHf5N4gEIvd89t5hK6JTIk3qrHoLBBP4
         xasQ==
X-Gm-Message-State: ANhLgQ25GmZ2rX+8ywuvGUGT6JJ1Pj8TV6qOojkdqJV4qYtzGwgflUYj
        VG5i/Qb9qG5C9KVTqfCryU2pzkCLDPDp0WT+dT5XqFMDWUiPhalECYvwoGNDecMNOzV+N9z2RFk
        oNPpDqiMtUPV9vElJB6Y0hjb+
X-Received: by 2002:adf:a1d6:: with SMTP id v22mr22564892wrv.416.1585682376134;
        Tue, 31 Mar 2020 12:19:36 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vu2xlJgmTza5dDHi7A+t9Wih6f98CSATtc1FXRvBFpYcTJRvETxc9Lb0w/9E67SGOaoydrTIw==
X-Received: by 2002:adf:a1d6:: with SMTP id v22mr22564872wrv.416.1585682375933;
        Tue, 31 Mar 2020 12:19:35 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
        by smtp.gmail.com with ESMTPSA id y189sm5131865wmb.26.2020.03.31.12.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 12:19:35 -0700 (PDT)
Date:   Tue, 31 Mar 2020 15:19:33 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH] vdpa: move to drivers/vdpa
Message-ID: <20200331191825.249436-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have both vhost and virtio drivers that depend on vdpa.
It's easier to locate it at a top level directory otherwise
we run into issues e.g. if vhost is built-in but virtio
is modular.  Let's just move it up a level.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

Randy I'd say the issue you are reporting (vhost=y, virtio=m)
is esoteric enough not to require a rebase for this.
So I'd just apply this on top.
Do you agree?

 MAINTAINERS                                   | 1 +
 drivers/Kconfig                               | 2 ++
 drivers/Makefile                              | 1 +
 drivers/{virtio => }/vdpa/Kconfig             | 0
 drivers/{virtio => }/vdpa/Makefile            | 0
 drivers/{virtio => }/vdpa/ifcvf/Makefile      | 0
 drivers/{virtio => }/vdpa/ifcvf/ifcvf_base.c  | 0
 drivers/{virtio => }/vdpa/ifcvf/ifcvf_base.h  | 0
 drivers/{virtio => }/vdpa/ifcvf/ifcvf_main.c  | 0
 drivers/{virtio => }/vdpa/vdpa.c              | 0
 drivers/{virtio => }/vdpa/vdpa_sim/Makefile   | 0
 drivers/{virtio => }/vdpa/vdpa_sim/vdpa_sim.c | 0
 drivers/virtio/Kconfig                        | 2 --
 13 files changed, 4 insertions(+), 2 deletions(-)
 rename drivers/{virtio => }/vdpa/Kconfig (100%)
 rename drivers/{virtio => }/vdpa/Makefile (100%)
 rename drivers/{virtio => }/vdpa/ifcvf/Makefile (100%)
 rename drivers/{virtio => }/vdpa/ifcvf/ifcvf_base.c (100%)
 rename drivers/{virtio => }/vdpa/ifcvf/ifcvf_base.h (100%)
 rename drivers/{virtio => }/vdpa/ifcvf/ifcvf_main.c (100%)
 rename drivers/{virtio => }/vdpa/vdpa.c (100%)
 rename drivers/{virtio => }/vdpa/vdpa_sim/Makefile (100%)
 rename drivers/{virtio => }/vdpa/vdpa_sim/vdpa_sim.c (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 70c47bc55343..7cfa55c765fd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17695,6 +17695,7 @@ L:	virtualization@lists.linux-foundation.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/virtio/
 F:	drivers/virtio/
+F:	drivers/vdpa/
 F:	tools/virtio/
 F:	drivers/net/virtio_net.c
 F:	drivers/block/virtio_blk.c
diff --git a/drivers/Kconfig b/drivers/Kconfig
index 7a6d8b2b68b4..ac23d520e916 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -138,6 +138,8 @@ source "drivers/virt/Kconfig"
 
 source "drivers/virtio/Kconfig"
 
+source "drivers/vdpa/Kconfig"
+
 source "drivers/vhost/Kconfig"
 
 source "drivers/hv/Kconfig"
diff --git a/drivers/Makefile b/drivers/Makefile
index 31cf17dee252..21688f3b1588 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -42,6 +42,7 @@ obj-$(CONFIG_DMADEVICES)	+= dma/
 obj-y				+= soc/
 
 obj-$(CONFIG_VIRTIO)		+= virtio/
+obj-$(CONFIG_VDPA)		+= vdpa/
 obj-$(CONFIG_XEN)		+= xen/
 
 # regulators early, since some subsystems rely on them to initialize
diff --git a/drivers/virtio/vdpa/Kconfig b/drivers/vdpa/Kconfig
similarity index 100%
rename from drivers/virtio/vdpa/Kconfig
rename to drivers/vdpa/Kconfig
diff --git a/drivers/virtio/vdpa/Makefile b/drivers/vdpa/Makefile
similarity index 100%
rename from drivers/virtio/vdpa/Makefile
rename to drivers/vdpa/Makefile
diff --git a/drivers/virtio/vdpa/ifcvf/Makefile b/drivers/vdpa/ifcvf/Makefile
similarity index 100%
rename from drivers/virtio/vdpa/ifcvf/Makefile
rename to drivers/vdpa/ifcvf/Makefile
diff --git a/drivers/virtio/vdpa/ifcvf/ifcvf_base.c b/drivers/vdpa/ifcvf/ifcvf_base.c
similarity index 100%
rename from drivers/virtio/vdpa/ifcvf/ifcvf_base.c
rename to drivers/vdpa/ifcvf/ifcvf_base.c
diff --git a/drivers/virtio/vdpa/ifcvf/ifcvf_base.h b/drivers/vdpa/ifcvf/ifcvf_base.h
similarity index 100%
rename from drivers/virtio/vdpa/ifcvf/ifcvf_base.h
rename to drivers/vdpa/ifcvf/ifcvf_base.h
diff --git a/drivers/virtio/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
similarity index 100%
rename from drivers/virtio/vdpa/ifcvf/ifcvf_main.c
rename to drivers/vdpa/ifcvf/ifcvf_main.c
diff --git a/drivers/virtio/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
similarity index 100%
rename from drivers/virtio/vdpa/vdpa.c
rename to drivers/vdpa/vdpa.c
diff --git a/drivers/virtio/vdpa/vdpa_sim/Makefile b/drivers/vdpa/vdpa_sim/Makefile
similarity index 100%
rename from drivers/virtio/vdpa/vdpa_sim/Makefile
rename to drivers/vdpa/vdpa_sim/Makefile
diff --git a/drivers/virtio/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
similarity index 100%
rename from drivers/virtio/vdpa/vdpa_sim/vdpa_sim.c
rename to drivers/vdpa/vdpa_sim/vdpa_sim.c
diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
index 99e424570644..2aadf398d8cc 100644
--- a/drivers/virtio/Kconfig
+++ b/drivers/virtio/Kconfig
@@ -109,5 +109,3 @@ config VIRTIO_MMIO_CMDLINE_DEVICES
 	 If unsure, say 'N'.
 
 endif # VIRTIO_MENU
-
-source "drivers/virtio/vdpa/Kconfig"
-- 
MST

