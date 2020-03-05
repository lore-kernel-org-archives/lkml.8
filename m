Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1812C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 06:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CD6F208CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 06:45:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BhRVMO7h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbgCEGpJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 01:45:09 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:38776 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbgCEGpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 01:45:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=dYRz1/C4UArkRFUUf0KVfHlXss7sHPLeL9Yd6mUbX6c=; b=BhRVMO7hYF3jIiTpkjux2YSR37
        gE6fK03WylbYuSQYql7oKAObVJSdA0yttS6CQW4GQxFlhGgmjNU50+JhP7PiwhpE5PgonFEIif75c
        HURMbPyJrqmgnCwT3GazXVKohaxVGOMgzCv+M9Pfy9bDrFl4A9nfAywi4oXM7Z6csqN/ozZ8rm6mq
        fKi+RA/e9Uepg6z3HSAg6/sftck4fgn8MaQ9oDA489Xxc1RowV7iLRy6nThWqfKMTn0CdmlY9hU8H
        uvOt9lhKFNo30AwolNWob97BlzQcOhvNsoJ2M5rPhG+nPaHtQ5u4U3el9BpvNGf5IkSE6cIXX0bGb
        V/NgiVJg==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j9kFn-0005lx-Rx; Thu, 05 Mar 2020 06:45:07 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] char: group some /dev configs together and un-split tty
 configs
Message-ID: <4e90d9af-c1ec-020f-b66b-a5a02e7fbe59@infradead.org>
Date:   Wed, 4 Mar 2020 22:45:06 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Group /dev/{mem,kmem,nvram,raw,port} driver configs together.
This also means that tty configs are now grouped together instead
of being split up.

This just moves Kconfig lines around. There are no other changes.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/char/Kconfig |  100 ++++++++++++++++++++---------------------
 1 file changed, 50 insertions(+), 50 deletions(-)

--- linux-next-20200304.orig/drivers/char/Kconfig
+++ linux-next-20200304/drivers/char/Kconfig
@@ -7,25 +7,6 @@ menu "Character devices"
 
 source "drivers/tty/Kconfig"
 
-config DEVMEM
-	bool "/dev/mem virtual device support"
-	default y
-	help
-	  Say Y here if you want to support the /dev/mem device.
-	  The /dev/mem device is used to access areas of physical
-	  memory.
-	  When in doubt, say "Y".
-
-config DEVKMEM
-	bool "/dev/kmem virtual device support"
-	# On arm64, VMALLOC_START < PAGE_OFFSET, which confuses kmem read/write
-	depends on !ARM64
-	help
-	  Say Y here if you want to support the /dev/kmem device. The
-	  /dev/kmem device is rarely used, but can be used for certain
-	  kind of kernel debugging operations.
-	  When in doubt, say "N".
-
 source "drivers/tty/serial/Kconfig"
 source "drivers/tty/serdev/Kconfig"
 
@@ -220,29 +201,6 @@ config NWFLASH
 
 source "drivers/char/hw_random/Kconfig"
 
-config NVRAM
-	tristate "/dev/nvram support"
-	depends on X86 || HAVE_ARCH_NVRAM_OPS
-	default M68K || PPC
-	---help---
-	  If you say Y here and create a character special file /dev/nvram
-	  with major number 10 and minor number 144 using mknod ("man mknod"),
-	  you get read and write access to the non-volatile memory.
-
-	  /dev/nvram may be used to view settings in NVRAM or to change them
-	  (with some utility). It could also be used to frequently
-	  save a few bits of very important data that may not be lost over
-	  power-off and for which writing to disk is too insecure. Note
-	  however that most NVRAM space in a PC belongs to the BIOS and you
-	  should NEVER idly tamper with it. See Ralf Brown's interrupt list
-	  for a guide to the use of CMOS bytes by your BIOS.
-
-	  This memory is conventionally called "NVRAM" on PowerPC machines,
-	  "CMOS RAM" on PCs, "NVRAM" on Ataris and "PRAM" on Macintoshes.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called nvram.
-
 #
 # These legacy RTC drivers just cause too many conflicts with the generic
 # RTC framework ... let's not even try to coexist any more.
@@ -431,6 +389,48 @@ config NSC_GPIO
 	  pc8736x_gpio drivers.  If those drivers are built as
 	  modules, this one will be too, named nsc_gpio
 
+config DEVMEM
+	bool "/dev/mem virtual device support"
+	default y
+	help
+	  Say Y here if you want to support the /dev/mem device.
+	  The /dev/mem device is used to access areas of physical
+	  memory.
+	  When in doubt, say "Y".
+
+config DEVKMEM
+	bool "/dev/kmem virtual device support"
+	# On arm64, VMALLOC_START < PAGE_OFFSET, which confuses kmem read/write
+	depends on !ARM64
+	help
+	  Say Y here if you want to support the /dev/kmem device. The
+	  /dev/kmem device is rarely used, but can be used for certain
+	  kind of kernel debugging operations.
+	  When in doubt, say "N".
+
+config NVRAM
+	tristate "/dev/nvram support"
+	depends on X86 || HAVE_ARCH_NVRAM_OPS
+	default M68K || PPC
+	---help---
+	  If you say Y here and create a character special file /dev/nvram
+	  with major number 10 and minor number 144 using mknod ("man mknod"),
+	  you get read and write access to the non-volatile memory.
+
+	  /dev/nvram may be used to view settings in NVRAM or to change them
+	  (with some utility). It could also be used to frequently
+	  save a few bits of very important data that may not be lost over
+	  power-off and for which writing to disk is too insecure. Note
+	  however that most NVRAM space in a PC belongs to the BIOS and you
+	  should NEVER idly tamper with it. See Ralf Brown's interrupt list
+	  for a guide to the use of CMOS bytes by your BIOS.
+
+	  This memory is conventionally called "NVRAM" on PowerPC machines,
+	  "CMOS RAM" on PCs, "NVRAM" on Ataris and "PRAM" on Macintoshes.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called nvram.
+
 config RAW_DRIVER
 	tristate "RAW driver (/dev/raw/rawN)"
 	depends on BLOCK
@@ -452,6 +452,14 @@ config MAX_RAW_DEVS
 	  Default is 256. Increase this number in case you need lots of
 	  raw devices.
 
+config DEVPORT
+	bool "/dev/port character device"
+	depends on ISA || PCI
+	default y
+	help
+	  Say Y here if you want to support the /dev/port device. The /dev/port
+	  device is similar to /dev/mem, but for I/O ports.
+
 config HPET
 	bool "HPET - High Precision Event Timer" if (X86 || IA64)
 	default n
@@ -511,14 +519,6 @@ config TELCLOCK
 	  /sys/devices/platform/telco_clock, with a number of files for
 	  controlling the behavior of this hardware.
 
-config DEVPORT
-	bool "/dev/port character device"
-	depends on ISA || PCI
-	default y
-	help
-	  Say Y here if you want to support the /dev/port device. The /dev/port
-	  device is similar to /dev/mem, but for I/O ports.
-
 source "drivers/s390/char/Kconfig"
 
 source "drivers/char/xillybus/Kconfig"

