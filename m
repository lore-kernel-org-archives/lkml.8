Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D9EC352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 12:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F1D720842
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 12:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581425288;
	bh=IEMmRHvU26st71jvjIMOxidWurLcy+y23gwdpZADlqQ=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=bmCtpX2iMZZZps/gM/cpGlIUAQu6LFO36UoMLIyCteWQ74PsrJlV3k7fBI+1U6Gb8
	 05ZezweROW/nJRql/lNhMH8GMqJD3VqgHzJAJ/SwRi1k90QrTTx6bbEtseNaslHiJr
	 61SwCrYwXyiWcY6PFq2yPQGY1a8rCn/5q1GLqi5o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728826AbgBKMsH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 07:48:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:57618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728680AbgBKMsF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 07:48:05 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1609C20842;
        Tue, 11 Feb 2020 12:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581425284;
        bh=IEMmRHvU26st71jvjIMOxidWurLcy+y23gwdpZADlqQ=;
        h=Date:From:To:Cc:Subject:From;
        b=laZdw/y8kDeCJOxdPcpiQNClTbi0V7NCceFzysRdB9n6Tu76jaLr4hAzZlm/jTXSV
         HPctyEkiZtFTqNNKs47A87mnwFbXBXCJRg340UM5166kMCc/bSEjyWRYO79Fa0t9JQ
         ZjQ3QF3caXYAiEAsvdngNQetSBlDYHtw1sJtSeCU=
Date:   Tue, 11 Feb 2020 04:48:03 -0800
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-usb@vger.kernel.org, devel@driverdev.osuosl.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] Staging: remove wusbcore and UWB from the kernel tree.
Message-ID: <20200211124803.GA1880331@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's been over 6 months, and no one has noticed that these drivers are
deleted, probably because no one actually has this hardware.  As no one
has volunteered to maintain the code, let's drop it for good.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
[resending and deleting the actual diffs as the patch was too big for
the lists]

 MAINTAINERS                                   |   10 -
 drivers/staging/Kconfig                       |    3 -
 drivers/staging/Makefile                      |    2 -
 drivers/staging/uwb/Kconfig                   |   72 -
 drivers/staging/uwb/Makefile                  |   32 -
 drivers/staging/uwb/TODO                      |    8 -
 drivers/staging/uwb/address.c                 |  352 --
 drivers/staging/uwb/allocator.c               |  374 ---
 drivers/staging/uwb/beacon.c                  |  595 ----
 drivers/staging/uwb/driver.c                  |  143 -
 drivers/staging/uwb/drp-avail.c               |  278 --
 drivers/staging/uwb/drp-ie.c                  |  305 --
 drivers/staging/uwb/drp.c                     |  842 -----
 drivers/staging/uwb/est.c                     |  450 ---
 drivers/staging/uwb/hwa-rc.c                  |  929 ------
 drivers/staging/uwb/i1480/Makefile            |    2 -
 drivers/staging/uwb/i1480/dfu/Makefile        |   10 -
 drivers/staging/uwb/i1480/dfu/dfu.c           |  198 --
 drivers/staging/uwb/i1480/dfu/i1480-dfu.h     |  246 --
 drivers/staging/uwb/i1480/dfu/mac.c           |  496 ---
 drivers/staging/uwb/i1480/dfu/phy.c           |  190 --
 drivers/staging/uwb/i1480/dfu/usb.c           |  448 ---
 drivers/staging/uwb/i1480/i1480-est.c         |   85 -
 drivers/staging/uwb/ie-rcv.c                  |   42 -
 drivers/staging/uwb/ie.c                      |  366 ---
 drivers/staging/uwb/include/debug-cmd.h       |   57 -
 drivers/staging/uwb/include/spec.h            |  767 -----
 drivers/staging/uwb/include/umc.h             |  192 --
 drivers/staging/uwb/include/whci.h            |  102 -
 drivers/staging/uwb/lc-dev.c                  |  457 ---
 drivers/staging/uwb/lc-rc.c                   |  569 ----
 drivers/staging/uwb/neh.c                     |  606 ----
 drivers/staging/uwb/pal.c                     |  128 -
 drivers/staging/uwb/radio.c                   |  196 --
 drivers/staging/uwb/reset.c                   |  379 ---
 drivers/staging/uwb/rsv.c                     | 1000 ------
 drivers/staging/uwb/scan.c                    |  120 -
 drivers/staging/uwb/umc-bus.c                 |  211 --
 drivers/staging/uwb/umc-dev.c                 |   94 -
 drivers/staging/uwb/umc-drv.c                 |   31 -
 drivers/staging/uwb/uwb-debug.c               |  354 --
 drivers/staging/uwb/uwb-internal.h            |  366 ---
 drivers/staging/uwb/uwb.h                     |  817 -----
 drivers/staging/uwb/uwbd.c                    |  356 --
 drivers/staging/uwb/whc-rc.c                  |  467 ---
 drivers/staging/uwb/whci.c                    |  257 --
 .../staging/wusbcore/Documentation/wusb-cbaf  |  130 -
 .../Documentation/wusb-design-overview.rst    |  457 ---
 drivers/staging/wusbcore/Kconfig              |   39 -
 drivers/staging/wusbcore/Makefile             |   28 -
 drivers/staging/wusbcore/TODO                 |    8 -
 drivers/staging/wusbcore/cbaf.c               |  645 ----
 drivers/staging/wusbcore/crypto.c             |  441 ---
 drivers/staging/wusbcore/dev-sysfs.c          |  124 -
 drivers/staging/wusbcore/devconnect.c         | 1085 ------
 drivers/staging/wusbcore/host/Kconfig         |   28 -
 drivers/staging/wusbcore/host/Makefile        |    3 -
 drivers/staging/wusbcore/host/hwa-hc.c        |  875 -----
 drivers/staging/wusbcore/host/whci/Makefile   |   14 -
 drivers/staging/wusbcore/host/whci/asl.c      |  376 ---
 drivers/staging/wusbcore/host/whci/debug.c    |  153 -
 drivers/staging/wusbcore/host/whci/hcd.c      |  356 --
 drivers/staging/wusbcore/host/whci/hw.c       |   93 -
 drivers/staging/wusbcore/host/whci/init.c     |  177 -
 drivers/staging/wusbcore/host/whci/int.c      |   82 -
 drivers/staging/wusbcore/host/whci/pzl.c      |  404 ---
 drivers/staging/wusbcore/host/whci/qset.c     |  831 -----
 drivers/staging/wusbcore/host/whci/whcd.h     |  202 --
 drivers/staging/wusbcore/host/whci/whci-hc.h  |  401 ---
 drivers/staging/wusbcore/host/whci/wusb.c     |  210 --
 .../staging/wusbcore/include/association.h    |  151 -
 drivers/staging/wusbcore/include/wusb-wa.h    |  304 --
 drivers/staging/wusbcore/include/wusb.h       |  362 --
 drivers/staging/wusbcore/mmc.c                |  303 --
 drivers/staging/wusbcore/pal.c                |   45 -
 drivers/staging/wusbcore/reservation.c        |  110 -
 drivers/staging/wusbcore/rh.c                 |  426 ---
 drivers/staging/wusbcore/security.c           |  599 ----
 drivers/staging/wusbcore/wa-hc.c              |   88 -
 drivers/staging/wusbcore/wa-hc.h              |  467 ---
 drivers/staging/wusbcore/wa-nep.c             |  289 --
 drivers/staging/wusbcore/wa-rpipe.c           |  539 ---
 drivers/staging/wusbcore/wa-xfer.c            | 2927 -----------------
 drivers/staging/wusbcore/wusbhc.c             |  490 ---
 drivers/staging/wusbcore/wusbhc.h             |  487 ---
 85 files changed, 28753 deletions(-)
 delete mode 100644 drivers/staging/uwb/Kconfig
 delete mode 100644 drivers/staging/uwb/Makefile
 delete mode 100644 drivers/staging/uwb/TODO
 delete mode 100644 drivers/staging/uwb/address.c
 delete mode 100644 drivers/staging/uwb/allocator.c
 delete mode 100644 drivers/staging/uwb/beacon.c
 delete mode 100644 drivers/staging/uwb/driver.c
 delete mode 100644 drivers/staging/uwb/drp-avail.c
 delete mode 100644 drivers/staging/uwb/drp-ie.c
 delete mode 100644 drivers/staging/uwb/drp.c
 delete mode 100644 drivers/staging/uwb/est.c
 delete mode 100644 drivers/staging/uwb/hwa-rc.c
 delete mode 100644 drivers/staging/uwb/i1480/Makefile
 delete mode 100644 drivers/staging/uwb/i1480/dfu/Makefile
 delete mode 100644 drivers/staging/uwb/i1480/dfu/dfu.c
 delete mode 100644 drivers/staging/uwb/i1480/dfu/i1480-dfu.h
 delete mode 100644 drivers/staging/uwb/i1480/dfu/mac.c
 delete mode 100644 drivers/staging/uwb/i1480/dfu/phy.c
 delete mode 100644 drivers/staging/uwb/i1480/dfu/usb.c
 delete mode 100644 drivers/staging/uwb/i1480/i1480-est.c
 delete mode 100644 drivers/staging/uwb/ie-rcv.c
 delete mode 100644 drivers/staging/uwb/ie.c
 delete mode 100644 drivers/staging/uwb/include/debug-cmd.h
 delete mode 100644 drivers/staging/uwb/include/spec.h
 delete mode 100644 drivers/staging/uwb/include/umc.h
 delete mode 100644 drivers/staging/uwb/include/whci.h
 delete mode 100644 drivers/staging/uwb/lc-dev.c
 delete mode 100644 drivers/staging/uwb/lc-rc.c
 delete mode 100644 drivers/staging/uwb/neh.c
 delete mode 100644 drivers/staging/uwb/pal.c
 delete mode 100644 drivers/staging/uwb/radio.c
 delete mode 100644 drivers/staging/uwb/reset.c
 delete mode 100644 drivers/staging/uwb/rsv.c
 delete mode 100644 drivers/staging/uwb/scan.c
 delete mode 100644 drivers/staging/uwb/umc-bus.c
 delete mode 100644 drivers/staging/uwb/umc-dev.c
 delete mode 100644 drivers/staging/uwb/umc-drv.c
 delete mode 100644 drivers/staging/uwb/uwb-debug.c
 delete mode 100644 drivers/staging/uwb/uwb-internal.h
 delete mode 100644 drivers/staging/uwb/uwb.h
 delete mode 100644 drivers/staging/uwb/uwbd.c
 delete mode 100644 drivers/staging/uwb/whc-rc.c
 delete mode 100644 drivers/staging/uwb/whci.c
 delete mode 100644 drivers/staging/wusbcore/Documentation/wusb-cbaf
 delete mode 100644 drivers/staging/wusbcore/Documentation/wusb-design-overview.rst
 delete mode 100644 drivers/staging/wusbcore/Kconfig
 delete mode 100644 drivers/staging/wusbcore/Makefile
 delete mode 100644 drivers/staging/wusbcore/TODO
 delete mode 100644 drivers/staging/wusbcore/cbaf.c
 delete mode 100644 drivers/staging/wusbcore/crypto.c
 delete mode 100644 drivers/staging/wusbcore/dev-sysfs.c
 delete mode 100644 drivers/staging/wusbcore/devconnect.c
 delete mode 100644 drivers/staging/wusbcore/host/Kconfig
 delete mode 100644 drivers/staging/wusbcore/host/Makefile
 delete mode 100644 drivers/staging/wusbcore/host/hwa-hc.c
 delete mode 100644 drivers/staging/wusbcore/host/whci/Makefile
 delete mode 100644 drivers/staging/wusbcore/host/whci/asl.c
 delete mode 100644 drivers/staging/wusbcore/host/whci/debug.c
 delete mode 100644 drivers/staging/wusbcore/host/whci/hcd.c
 delete mode 100644 drivers/staging/wusbcore/host/whci/hw.c
 delete mode 100644 drivers/staging/wusbcore/host/whci/init.c
 delete mode 100644 drivers/staging/wusbcore/host/whci/int.c
 delete mode 100644 drivers/staging/wusbcore/host/whci/pzl.c
 delete mode 100644 drivers/staging/wusbcore/host/whci/qset.c
 delete mode 100644 drivers/staging/wusbcore/host/whci/whcd.h
 delete mode 100644 drivers/staging/wusbcore/host/whci/whci-hc.h
 delete mode 100644 drivers/staging/wusbcore/host/whci/wusb.c
 delete mode 100644 drivers/staging/wusbcore/include/association.h
 delete mode 100644 drivers/staging/wusbcore/include/wusb-wa.h
 delete mode 100644 drivers/staging/wusbcore/include/wusb.h
 delete mode 100644 drivers/staging/wusbcore/mmc.c
 delete mode 100644 drivers/staging/wusbcore/pal.c
 delete mode 100644 drivers/staging/wusbcore/reservation.c
 delete mode 100644 drivers/staging/wusbcore/rh.c
 delete mode 100644 drivers/staging/wusbcore/security.c
 delete mode 100644 drivers/staging/wusbcore/wa-hc.c
 delete mode 100644 drivers/staging/wusbcore/wa-hc.h
 delete mode 100644 drivers/staging/wusbcore/wa-nep.c
 delete mode 100644 drivers/staging/wusbcore/wa-rpipe.c
 delete mode 100644 drivers/staging/wusbcore/wa-xfer.c
 delete mode 100644 drivers/staging/wusbcore/wusbhc.c
 delete mode 100644 drivers/staging/wusbcore/wusbhc.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 38fe2f3f7b6f..9a4c715d1e50 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3919,11 +3919,6 @@ F:	certs/
 F:	scripts/sign-file.c
 F:	scripts/extract-cert.c
 
-CERTIFIED WIRELESS USB (WUSB) SUBSYSTEM:
-L:	devel@driverdev.osuosl.org
-S:	Obsolete
-F:	drivers/staging/wusbcore/
-
 CFAG12864B LCD DRIVER
 M:	Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>
 S:	Maintained
@@ -17094,11 +17089,6 @@ S:	Maintained
 F:	drivers/usb/common/ulpi.c
 F:	include/linux/ulpi/
 
-ULTRA-WIDEBAND (UWB) SUBSYSTEM:
-L:	devel@driverdev.osuosl.org
-S:	Obsolete
-F:	drivers/staging/uwb/
-
 UNICODE SUBSYSTEM:
 M:	Gabriel Krisman Bertazi <krisman@collabora.com>
 L:	linux-fsdevel@vger.kernel.org
diff --git a/drivers/staging/Kconfig b/drivers/staging/Kconfig
index baccd7c883cc..0f82e23e151b 100644
--- a/drivers/staging/Kconfig
+++ b/drivers/staging/Kconfig
@@ -112,9 +112,6 @@ source "drivers/staging/fieldbus/Kconfig"
 
 source "drivers/staging/kpc2000/Kconfig"
 
-source "drivers/staging/wusbcore/Kconfig"
-source "drivers/staging/uwb/Kconfig"
-
 source "drivers/staging/exfat/Kconfig"
 
 source "drivers/staging/qlge/Kconfig"
diff --git a/drivers/staging/Makefile b/drivers/staging/Makefile
index fdd03fd6e704..49b21951b6f2 100644
--- a/drivers/staging/Makefile
+++ b/drivers/staging/Makefile
@@ -46,8 +46,6 @@ obj-$(CONFIG_STAGING_GASKET_FRAMEWORK)	+= gasket/
 obj-$(CONFIG_XIL_AXIS_FIFO)	+= axis-fifo/
 obj-$(CONFIG_FIELDBUS_DEV)     += fieldbus/
 obj-$(CONFIG_KPC2000)		+= kpc2000/
-obj-$(CONFIG_UWB)		+= uwb/
-obj-$(CONFIG_USB_WUSB)		+= wusbcore/
 obj-$(CONFIG_STAGING_EXFAT_FS)	+= exfat/
 obj-$(CONFIG_QLGE)		+= qlge/
 obj-$(CONFIG_NET_VENDOR_HP)	+= hp/
