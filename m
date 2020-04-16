Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EE11C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 22:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E4DD218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 22:20:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h+XUgF8f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729057AbgDPWUk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 18:20:40 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:48187 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728221AbgDPWUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 18:20:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587075635;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=LKcXo+p/uaeU/hsHRyKbdRNMgG4/p28XvmGbqiu1vto=;
        b=h+XUgF8fNbmivRrbmWh3OCPTzT2pIToJpS+uI624hDwynyGBVCI2QJeEQ5hmVvg4i0DQDu
        EHwbbF4Dw1IbH5TJAoD1T1Q0F8X3ajeWKG29ApAWMBMLGJX0zw1RLeWP0gfeNhUo/4ibR8
        zodwIMYioRXlibUNpkPQpYRaeRBQ/1s=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-0Ey7AXIPMBq80xnagwDEOw-1; Thu, 16 Apr 2020 18:20:24 -0400
X-MC-Unique: 0Ey7AXIPMBq80xnagwDEOw-1
Received: by mail-wr1-f72.google.com with SMTP id y1so2480795wrp.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 15:20:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=LKcXo+p/uaeU/hsHRyKbdRNMgG4/p28XvmGbqiu1vto=;
        b=TGKUeCoNjiztZueCqtnaWHuHIuJKDRc1QTzXuXkFOj8gtEoALx7QOUM/IGYfv6H05r
         JtTfZcdCljP3it5wqbSBJjrbCAudSwnzI1w1WoiXxOBtQZ7oxwqBYKSS+B+Vbdu36ZE1
         6ySyOWJNCYiilZ+3I/teyzzISHpvSMBuOqfqpzKRF9eX7yz+Iu4M/Cxq2iLTin/cwt+x
         IcAvYfUIVFWEfGE20+FhtllUg/TK2Rl6HbNhiiYJefhzbgXLwtl93w3NF2blvCcKN3f9
         tJy6EzsAvRl5J10DjwhLqbGnZTy5jnVM2UNmZs4AZHLZOLolK0s1IiqTpFa1krPvs5k8
         jVCQ==
X-Gm-Message-State: AGi0Pubvj5CX69SNIErnkocyfeEuVTcTTsg4cPtkYfroBEqydBCcVySi
        ScNfxdUHtfie4CnjKhsr08LQhOuUqW4rRPqH9oo0RT1GIbmXMNJwk1kz7mzdf2tJADkZ2oWmLJa
        Df3OYfE5yEDqAqhur2GGfgvpQ
X-Received: by 2002:a7b:c955:: with SMTP id i21mr43714wml.25.1587075622980;
        Thu, 16 Apr 2020 15:20:22 -0700 (PDT)
X-Google-Smtp-Source: APiQypLTMzBiCaoZdbA9StOEic7q7PuNDUniFaAXDS0fu05xLaJzs2UfTHwtFzY0cbIA235H0bagiw==
X-Received: by 2002:a7b:c955:: with SMTP id i21mr43692wml.25.1587075622724;
        Thu, 16 Apr 2020 15:20:22 -0700 (PDT)
Received: from redhat.com (bzq-79-183-51-3.red.bezeqint.net. [79.183.51.3])
        by smtp.gmail.com with ESMTPSA id g186sm5712499wmg.36.2020.04.16.15.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 15:20:22 -0700 (PDT)
Date:   Thu, 16 Apr 2020 18:20:20 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Richard Earnshaw <Richard.Earnshaw@arm.com>,
        Sudeep Dutt <sudeep.dutt@intel.com>,
        Ashutosh Dixit <ashutosh.dixit@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jason Wang <jasowang@redhat.com>, netdev@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org
Subject: [PATCH v3] vhost: disable for OABI
Message-ID: <20200416221902.5801-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vhost is currently broken on the some ARM configs.

The reason is that that uses apcs-gnu which is the ancient OABI that is been
deprecated for a long time.

Given that virtio support on such ancient systems is not needed in the
first place, let's just add something along the lines of

	depends on !ARM || AEABI

to the virtio Kconfig declaration, and add a comment that it has to do
with struct member alignment.

Note: we can't make VHOST and VHOST_RING themselves have
a dependency since these are selected. Add a new symbol for that.

Link: https://lore.kernel.org/r/20200406121233.109889-3-mst@redhat.com
Suggested-by: Ard Biesheuvel <ardb@kernel.org>
Suggested-by: Richard Earnshaw <Richard.Earnshaw@arm.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

Changes from v2:
	- drop prompt from VHOST_DPN
	- typo fix in commit log
	- OABI is a possible ARM config but not the default one

 drivers/misc/mic/Kconfig |  2 +-
 drivers/net/caif/Kconfig |  2 +-
 drivers/vdpa/Kconfig     |  2 +-
 drivers/vhost/Kconfig    | 17 +++++++++++++----
 4 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/misc/mic/Kconfig b/drivers/misc/mic/Kconfig
index 8f201d019f5a..3bfe72c59864 100644
--- a/drivers/misc/mic/Kconfig
+++ b/drivers/misc/mic/Kconfig
@@ -116,7 +116,7 @@ config MIC_COSM
 
 config VOP
 	tristate "VOP Driver"
-	depends on VOP_BUS
+	depends on VOP_BUS && VHOST_DPN
 	select VHOST_RING
 	select VIRTIO
 	help
diff --git a/drivers/net/caif/Kconfig b/drivers/net/caif/Kconfig
index 9db0570c5beb..661c25eb1c46 100644
--- a/drivers/net/caif/Kconfig
+++ b/drivers/net/caif/Kconfig
@@ -50,7 +50,7 @@ config CAIF_HSI
 
 config CAIF_VIRTIO
 	tristate "CAIF virtio transport driver"
-	depends on CAIF && HAS_DMA
+	depends on CAIF && HAS_DMA && VHOST_DPN
 	select VHOST_RING
 	select VIRTIO
 	select GENERIC_ALLOCATOR
diff --git a/drivers/vdpa/Kconfig b/drivers/vdpa/Kconfig
index 71d9a64f2c7d..ee35f8261a88 100644
--- a/drivers/vdpa/Kconfig
+++ b/drivers/vdpa/Kconfig
@@ -10,7 +10,7 @@ if VDPA
 
 config VDPA_SIM
 	tristate "vDPA device simulator"
-	depends on RUNTIME_TESTING_MENU && HAS_DMA
+	depends on RUNTIME_TESTING_MENU && HAS_DMA && VHOST_DPN
 	select VHOST_RING
 	select VHOST_IOTLB
 	default n
diff --git a/drivers/vhost/Kconfig b/drivers/vhost/Kconfig
index e79cbbdfea45..d9b3a3ec765a 100644
--- a/drivers/vhost/Kconfig
+++ b/drivers/vhost/Kconfig
@@ -12,6 +12,15 @@ config VHOST_RING
 	  This option is selected by any driver which needs to access
 	  the host side of a virtio ring.
 
+config VHOST_DPN
+	bool
+	depends on !ARM || AEABI
+	default y
+	help
+	  Anything selecting VHOST or VHOST_RING must depend on VHOST_DPN.
+	  This excludes the deprecated ARM ABI since that forces a 4 byte
+	  alignment on all structs - incompatible with virtio spec requirements.
+
 config VHOST
 	tristate
 	select VHOST_IOTLB
@@ -27,7 +36,7 @@ if VHOST_MENU
 
 config VHOST_NET
 	tristate "Host kernel accelerator for virtio net"
-	depends on NET && EVENTFD && (TUN || !TUN) && (TAP || !TAP)
+	depends on NET && EVENTFD && (TUN || !TUN) && (TAP || !TAP) && VHOST_DPN
 	select VHOST
 	---help---
 	  This kernel module can be loaded in host kernel to accelerate
@@ -39,7 +48,7 @@ config VHOST_NET
 
 config VHOST_SCSI
 	tristate "VHOST_SCSI TCM fabric driver"
-	depends on TARGET_CORE && EVENTFD
+	depends on TARGET_CORE && EVENTFD && VHOST_DPN
 	select VHOST
 	default n
 	---help---
@@ -48,7 +57,7 @@ config VHOST_SCSI
 
 config VHOST_VSOCK
 	tristate "vhost virtio-vsock driver"
-	depends on VSOCKETS && EVENTFD
+	depends on VSOCKETS && EVENTFD && VHOST_DPN
 	select VHOST
 	select VIRTIO_VSOCKETS_COMMON
 	default n
@@ -62,7 +71,7 @@ config VHOST_VSOCK
 
 config VHOST_VDPA
 	tristate "Vhost driver for vDPA-based backend"
-	depends on EVENTFD
+	depends on EVENTFD && VHOST_DPN
 	select VHOST
 	depends on VDPA
 	help
-- 
MST

