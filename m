Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A38C2BA1E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 12:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A653A20CC7
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 12:12:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FL/Hz1sY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbgDFMMz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 08:12:55 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:40559 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727614AbgDFMMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 08:12:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586175170;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dQAEJjJ23njMAMzpYV3TzkQNiOgjGmbglBN46bPRZ/k=;
        b=FL/Hz1sYb5fZql6/Fw1IbPDUj7GjcUk7wl/0uMI2lk4fOixhHzpKkZK0i5ieH4xOiRtKBD
        gWUrnf6ZODujrN0nUvj/XI1mbagBckJ6MEzSTpk3t5OvMFZ8gSTReAruTMljcPYAr5pKoj
        mgBhuh41G9opgLqiFR5EQRpVqfu9YWY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-376-_cECkFoSNPaXgDbKQvhQcQ-1; Mon, 06 Apr 2020 08:12:49 -0400
X-MC-Unique: _cECkFoSNPaXgDbKQvhQcQ-1
Received: by mail-wr1-f69.google.com with SMTP id g6so2497085wru.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 05:12:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dQAEJjJ23njMAMzpYV3TzkQNiOgjGmbglBN46bPRZ/k=;
        b=ER6McfbeK6RkgYiuYfDJrovQomZg/doawo4EYG7JQO0jRKabTCP5lIiXGiioTB5EG/
         Sjsuf8M4Z7Hw2FTKcPM0u/3UYLPAqWQqZuGPCV1d0axqxglFqDOCIB+vey3HYpQI3GrV
         PeU0WD57sJRKzbenoyrUXfD3GzOQ2rmlThesVyAq2086YYJOWAqic4PRXto85gE2aIQX
         cEtYFb7tMR9cNcbgYBUcWyXhCJIM4eESIRx5y8o3+uU10vwSwhPkv5sGkGbfnPeQ0Zv4
         AnubI1DtEjRH0D7m35G0yxg9hi7KqtV9wZKASiO+VB0gCA5kW7B2WNCE9oUyfBPL0yi0
         7ZEw==
X-Gm-Message-State: AGi0PubyngPpYtZmAOAqeVP8DNIChBuBQI3oKL4z6QqWtfsVAHT1nd+O
        8iicIPKLTCe6tSP2JFVR2QXBtn9GbOUAu+PAOVN9wV6RZV56V3vqhpYF2KlBMNET+orLiVVEpgO
        ThW+cJcY5WqdgncrSoVwaQXBC
X-Received: by 2002:adf:bc12:: with SMTP id s18mr25165020wrg.220.1586175167834;
        Mon, 06 Apr 2020 05:12:47 -0700 (PDT)
X-Google-Smtp-Source: APiQypLwgTks29i/561QCQdpKOflCqiUKEhbZa/gBiQmA5aq0hS0WhmnIdFdpGtSrxr+GiRrPLsSEg==
X-Received: by 2002:adf:bc12:: with SMTP id s18mr25164995wrg.220.1586175167620;
        Mon, 06 Apr 2020 05:12:47 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
        by smtp.gmail.com with ESMTPSA id c20sm11334886wmd.36.2020.04.06.05.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 05:12:47 -0700 (PDT)
Date:   Mon, 6 Apr 2020 08:12:44 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
        "christophe.lyon@st.com" <christophe.lyon@st.com>,
        kbuild test robot <lkp@intel.com>,
        "daniel.santos@pobox.com" <daniel.santos@pobox.com>,
        Jason Wang <jasowang@redhat.com>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Richard Earnshaw <Richard.Earnshaw@arm.com>,
        Sudeep Dutt <sudeep.dutt@intel.com>,
        Ashutosh Dixit <ashutosh.dixit@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org
Subject: [PATCH v2 2/2] vhost: disable for OABI
Message-ID: <20200406121233.109889-3-mst@redhat.com>
References: <20200406121233.109889-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200406121233.109889-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vhost is currently broken on the default ARM config.

The reason is that that uses apcs-gnu which is the ancient OABI that is been
deprecated for a long time.

Given that virtio support on such ancient systems is not needed in the
first place, let's just add something along the lines of

	depends on !ARM || AEABI

to the virtio Kconfig declaration, and add a comment that it has to do
with struct member alignment.

Note: we can't make VHOST and VHOST_RING themselves have
a dependency since these are selected. Add a new symbol for that.

Suggested-by: Ard Biesheuvel <ardb@kernel.org>
Siggested-by: Richard Earnshaw <Richard.Earnshaw@arm.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
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
index d0cb0e583a5d..aee28def466b 100644
--- a/drivers/vdpa/Kconfig
+++ b/drivers/vdpa/Kconfig
@@ -14,7 +14,7 @@ if VDPA_MENU
 
 config VDPA_SIM
 	tristate "vDPA device simulator"
-	depends on RUNTIME_TESTING_MENU && HAS_DMA
+	depends on RUNTIME_TESTING_MENU && HAS_DMA && VHOST_DPN
 	select VDPA
 	select VHOST_RING
 	select VHOST_IOTLB
diff --git a/drivers/vhost/Kconfig b/drivers/vhost/Kconfig
index cb6b17323eb2..b3486e218f62 100644
--- a/drivers/vhost/Kconfig
+++ b/drivers/vhost/Kconfig
@@ -12,6 +12,15 @@ config VHOST_RING
 	  This option is selected by any driver which needs to access
 	  the host side of a virtio ring.
 
+config VHOST_DPN
+	bool "VHOST dependencies"
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
 	select VDPA
 	help
-- 
MST

