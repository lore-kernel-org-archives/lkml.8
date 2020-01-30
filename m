Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5495C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 13:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3A09206F0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 13:55:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Hsgt91NF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbgA3Nz0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 08:55:26 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44179 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbgA3NzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 08:55:25 -0500
Received: by mail-wr1-f67.google.com with SMTP id m16so4097741wrx.11
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 05:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+F4GqQNvHeyvPBLDXOr4ugLmUZWpBmhlLb4cPNNG6Rs=;
        b=Hsgt91NFPm119V+zbEGWawnrCBtWg9piRmYhYC2bT7elPU+Z8u2OmaWv3qu8RGiKwX
         H9lYCFRchXe6iE3eJHrb5SnIAltpCOMDTZtynzRC3CrlGDo2ScPguSgWKYgnIRgaNS/7
         lRJYxfeX4xdfn8QEtv/PQKgzx3CoVBp/qmKF8mMzTjXWWo2cEINAToJ5M7f31p4/FvtC
         dfNNItizQi9+6++QSS4DhyImc0cHhbLk1Wz4RG2+oLVypR6iNNtKvBPTmk1oHQeeYM77
         lmYUL6iJ5GLHppQVim0RgGNBNugo9nJtrHTrdGtx21tqQJQ4uKQfUwpqpzSGETuva6MZ
         exTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+F4GqQNvHeyvPBLDXOr4ugLmUZWpBmhlLb4cPNNG6Rs=;
        b=s/efvfthkIm7bJ/gPun4mPRcvR6pA1azt/AUFU1ECA0tvWnyOnYROrk0yDUNl4PzUM
         2UJIc2fm2wqQ3+a/SR4BLP1/OcrPLDS7iEoHkHcnKdq5UOQ/dKoF++y1JLl/Oj92qNwE
         nNQz/gTQThD2BrGSk7stL2b+uvkk1kThwV8ITmmTQ7guTaV2mrZ1mA1aOEILIGpcHLM1
         yaqHuhWN8BiAkHiDqkC+gAWYhONkWT8NTixu7/ssrKZowF7Spoi9TmKF0GbkVPD2vpVY
         bNEYuGwTVJsScUEL4fU54zZKe5vipHvbznqIO7/ETkLYnzfDH65tsnZeYs56O2PA9P/U
         Ls3g==
X-Gm-Message-State: APjAAAVC7kT5/c2049N0iAEap25bec+K1yHog6n1ulo6Xw8nN1G0dm3w
        FWybBq+V7qODZMQlBXWL1eLOVQ==
X-Google-Smtp-Source: APXvYqwj7bBHy+7KHga1i//BX0QzwuGPQEM/g0/Fa+NBimy82M6KxztfSR+anYrv5e3AGpXV94YabQ==
X-Received: by 2002:a5d:568a:: with SMTP id f10mr5144524wrv.180.1580392521992;
        Thu, 30 Jan 2020 05:55:21 -0800 (PST)
Received: from localhost.localdomain (lfbn-nic-1-505-157.w90-116.abo.wanadoo.fr. [90.116.92.157])
        by smtp.gmail.com with ESMTPSA id g7sm7374936wrq.21.2020.01.30.05.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 05:55:21 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH -next] MAINTAINERS: remove unnecessary ':' characters
Date:   Thu, 30 Jan 2020 14:55:15 +0100
Message-Id: <20200130135515.30359-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Commit e567cb3fef30 ("MAINTAINERS: add an entry for kfifo") added a new
entry to MAINTAINERS. Following the example of the previous entry on the
list I added a trailing ':' character at the end of the title line.

This however results in rather strange looking output from
scripts/get_maintainer.pl:

$ ./scripts/get_maintainer.pl ./0001-kfifo.patch
Stefani Seibold <stefani@seibold.net> (maintainer:KFIFO:)
linux-kernel@vger.kernel.org (open list)

It turns out there are more entries like this. Fix the entire file by
removing all trailing colons.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 MAINTAINERS | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c91009a87dc2..2b8633a8c334 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3912,7 +3912,7 @@ S:	Supported
 F:	Documentation/filesystems/ceph.txt
 F:	fs/ceph/
 
-CERTIFICATE HANDLING:
+CERTIFICATE HANDLING
 M:	David Howells <dhowells@redhat.com>
 M:	David Woodhouse <dwmw2@infradead.org>
 L:	keyrings@vger.kernel.org
@@ -3922,7 +3922,7 @@ F:	certs/
 F:	scripts/sign-file.c
 F:	scripts/extract-cert.c
 
-CERTIFIED WIRELESS USB (WUSB) SUBSYSTEM:
+CERTIFIED WIRELESS USB (WUSB) SUBSYSTEM
 L:	devel@driverdev.osuosl.org
 S:	Obsolete
 F:	drivers/staging/wusbcore/
@@ -7050,7 +7050,7 @@ L:	kvm@vger.kernel.org
 S:	Supported
 F:	drivers/uio/uio_pci_generic.c
 
-GENERIC VDSO LIBRARY:
+GENERIC VDSO LIBRARY
 M:	Andy Lutomirski <luto@kernel.org>
 M:	Thomas Gleixner <tglx@linutronix.de>
 M:	Vincenzo Frascino <vincenzo.frascino@arm.com>
@@ -9291,7 +9291,7 @@ F:	include/keys/trusted-type.h
 F:	security/keys/trusted.c
 F:	include/keys/trusted.h
 
-KEYS/KEYRINGS:
+KEYS/KEYRINGS
 M:	David Howells <dhowells@redhat.com>
 M:	Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
 L:	keyrings@vger.kernel.org
@@ -9304,7 +9304,7 @@ F:	include/uapi/linux/keyctl.h
 F:	include/keys/
 F:	security/keys/
 
-KFIFO:
+KFIFO
 M:	Stefani Seibold <stefani@seibold.net>
 S:	Maintained
 F:	lib/kfifo.c
@@ -11504,7 +11504,7 @@ F:	drivers/scsi/mac_scsi.*
 F:	drivers/scsi/sun3_scsi.*
 F:	drivers/scsi/sun3_scsi_vme.c
 
-NCSI LIBRARY:
+NCSI LIBRARY
 M:	Samuel Mendoza-Jonas <sam@mendozajonas.com>
 S:	Maintained
 F:	net/ncsi/
@@ -13532,7 +13532,7 @@ L:	linuxppc-dev@lists.ozlabs.org
 S:	Maintained
 F:	drivers/block/ps3vram.c
 
-PSAMPLE PACKET SAMPLING SUPPORT:
+PSAMPLE PACKET SAMPLING SUPPORT
 M:	Yotam Gigi <yotam.gi@gmail.com>
 S:	Maintained
 F:	net/psample
@@ -17101,7 +17101,7 @@ S:	Maintained
 F:	Documentation/admin-guide/ufs.rst
 F:	fs/ufs/
 
-UHID USERSPACE HID IO DRIVER:
+UHID USERSPACE HID IO DRIVER
 M:	David Herrmann <dh.herrmann@googlemail.com>
 L:	linux-input@vger.kernel.org
 S:	Maintained
@@ -17115,18 +17115,18 @@ S:	Maintained
 F:	drivers/usb/common/ulpi.c
 F:	include/linux/ulpi/
 
-ULTRA-WIDEBAND (UWB) SUBSYSTEM:
+ULTRA-WIDEBAND (UWB) SUBSYSTEM
 L:	devel@driverdev.osuosl.org
 S:	Obsolete
 F:	drivers/staging/uwb/
 
-UNICODE SUBSYSTEM:
+UNICODE SUBSYSTEM
 M:	Gabriel Krisman Bertazi <krisman@collabora.com>
 L:	linux-fsdevel@vger.kernel.org
 S:	Supported
 F:	fs/unicode/
 
-UNICORE32 ARCHITECTURE:
+UNICORE32 ARCHITECTURE
 M:	Guan Xuetao <gxt@pku.edu.cn>
 W:	http://mprc.pku.edu.cn/~guanxuetao/linux
 S:	Maintained
@@ -17812,7 +17812,7 @@ F:	include/linux/vbox_utils.h
 F:	include/uapi/linux/vbox*.h
 F:	drivers/virt/vboxguest/
 
-VIRTUAL BOX SHARED FOLDER VFS DRIVER:
+VIRTUAL BOX SHARED FOLDER VFS DRIVER
 M:	Hans de Goede <hdegoede@redhat.com>
 L:	linux-fsdevel@vger.kernel.org
 S:	Maintained
-- 
2.23.0

