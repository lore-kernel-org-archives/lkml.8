Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F018C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 06:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B23A2067B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 06:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592203866;
	bh=X53zD6kwaqfzgxBePBBcrX0yh3IsKueHcHG8OkNcZo8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Najg8tGskrHv3Y/9XScdUSnZ0vXL/VDEu+nRQrwrR2DNxGzJZoKMlhtzT3gxsfApO
	 ikFMEY5pNCeVAmFYwLL5AQjfnazqZqmXEKHa+jkUc98g4mBjaF3T/F0JVbq5hs6HT+
	 hs2djxs6G5U16h+McY/YA4KdBznqW8v85RlsAJGw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728881AbgFOGui (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 02:50:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:36700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728586AbgFOGue (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 02:50:34 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2513620836;
        Mon, 15 Jun 2020 06:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592203832;
        bh=X53zD6kwaqfzgxBePBBcrX0yh3IsKueHcHG8OkNcZo8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eALfoGgejnGCuaeTMlXK0sIrL86zokTNRIYPTNXpHEUamyPYYHoHDhCbYRiBXnM6S
         66hNAt82v/3MkGL5ygIrbx3vBF1wzHHoZdpivKZxIntHeHZhZZhzaKyFZlRAyZUa9n
         FzW8T2NG3EJOZWswXhFtswOOVOouW4VxEmkCJNks=
Received: from mchehab by mail.kernel.org with local (Exim 4.93)
        (envelope-from <mchehab@kernel.org>)
        id 1jkiww-009o68-90; Mon, 15 Jun 2020 08:50:30 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 10/22] docs: misc-devices/c2port.txt: convert to ReST format
Date:   Mon, 15 Jun 2020 08:50:15 +0200
Message-Id: <b3b2f3f58a9a33f9e8526d4fa36bee305ea4da38.1592203650.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1592203650.git.mchehab+huawei@kernel.org>
References: <cover.1592203650.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Use copyright symbol;
- use title markups;
- adjust indentation;
- mark literal blocks as such.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../misc-devices/{c2port.txt => c2port.rst}   | 58 ++++++++++---------
 Documentation/misc-devices/index.rst          |  1 +
 2 files changed, 32 insertions(+), 27 deletions(-)
 rename Documentation/misc-devices/{c2port.txt => c2port.rst} (59%)

diff --git a/Documentation/misc-devices/c2port.txt b/Documentation/misc-devices/c2port.rst
similarity index 59%
rename from Documentation/misc-devices/c2port.txt
rename to Documentation/misc-devices/c2port.rst
index 31351b1a5a1f..3cf3c571bead 100644
--- a/Documentation/misc-devices/c2port.txt
+++ b/Documentation/misc-devices/c2port.rst
@@ -1,7 +1,11 @@
-			C2 port support
-			---------------
+.. SPDX-License-Identifier: GPL-2.0
+.. include:: <isonum.txt>
 
-(C) Copyright 2007 Rodolfo Giometti <giometti@enneenne.com>
+===============
+C2 port support
+===============
+
+|copy| Copyright 2007 Rodolfo Giometti <giometti@enneenne.com>
 
 This program is free software; you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
@@ -32,10 +36,10 @@ The C2 Interface main references are at (https://www.silabs.com)
 Silicon Laboratories site], see:
 
 - AN127: FLASH Programming via the C2 Interface at
-https://www.silabs.com/Support Documents/TechnicalDocs/an127.pdf 
+  https://www.silabs.com/Support Documents/TechnicalDocs/an127.pdf
 
 - C2 Specification at
-https://www.silabs.com/pages/DownloadDoc.aspx?FILEURL=Support%20Documents/TechnicalDocs/an127.pdf&src=SearchResults
+  https://www.silabs.com/pages/DownloadDoc.aspx?FILEURL=Support%20Documents/TechnicalDocs/an127.pdf&src=SearchResults
 
 however it implements a two wire serial communication protocol (bit
 banging) designed to enable in-system programming, debugging, and
@@ -47,44 +51,44 @@ Using the driver
 ----------------
 
 Once the driver is loaded you can use sysfs support to get C2port's
-info or read/write in-system flash.
+info or read/write in-system flash::
 
-# ls /sys/class/c2port/c2port0/
-access            flash_block_size  flash_erase       rev_id
-dev_id            flash_blocks_num  flash_size        subsystem/
-flash_access      flash_data        reset             uevent
+  # ls /sys/class/c2port/c2port0/
+  access            flash_block_size  flash_erase       rev_id
+  dev_id            flash_blocks_num  flash_size        subsystem/
+  flash_access      flash_data        reset             uevent
 
 Initially the C2port access is disabled since you hardware may have
 such lines multiplexed with other devices so, to get access to the
-C2port, you need the command:
+C2port, you need the command::
 
-# echo 1 > /sys/class/c2port/c2port0/access
+  # echo 1 > /sys/class/c2port/c2port0/access
 
 after that you should read the device ID and revision ID of the
-connected micro controller:
+connected micro controller::
 
-# cat /sys/class/c2port/c2port0/dev_id
-8
-# cat /sys/class/c2port/c2port0/rev_id
-1
+  # cat /sys/class/c2port/c2port0/dev_id
+  8
+  # cat /sys/class/c2port/c2port0/rev_id
+  1
 
 However, for security reasons, the in-system flash access in not
-enabled yet, to do so you need the command:
+enabled yet, to do so you need the command::
 
-# echo 1 > /sys/class/c2port/c2port0/flash_access
+  # echo 1 > /sys/class/c2port/c2port0/flash_access
 
-After that you can read the whole flash:
+After that you can read the whole flash::
 
-# cat /sys/class/c2port/c2port0/flash_data > image
+  # cat /sys/class/c2port/c2port0/flash_data > image
 
-erase it:
+erase it::
 
-# echo 1 > /sys/class/c2port/c2port0/flash_erase
+  # echo 1 > /sys/class/c2port/c2port0/flash_erase
 
-and write it:
+and write it::
 
-# cat image > /sys/class/c2port/c2port0/flash_data
+  # cat image > /sys/class/c2port/c2port0/flash_data
 
-after writing you have to reset the device to execute the new code:
+after writing you have to reset the device to execute the new code::
 
-# echo 1 > /sys/class/c2port/c2port0/reset
+  # echo 1 > /sys/class/c2port/c2port0/reset
diff --git a/Documentation/misc-devices/index.rst b/Documentation/misc-devices/index.rst
index d2e87f791821..27e268805067 100644
--- a/Documentation/misc-devices/index.rst
+++ b/Documentation/misc-devices/index.rst
@@ -16,6 +16,7 @@ fit into other categories.
 
    ad525x_dpot
    eeprom
+   c2port
    ibmvmc
    ics932s401
    isl29003
-- 
2.26.2

