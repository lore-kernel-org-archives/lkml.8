Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFAC4C4724C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 16:20:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC2D720873
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 16:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588263604;
	bh=E2W+Pp9D1/Ag9kxnKEgTpnr6s13MrdK3Hx82R//8IyQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PlLeHoAfRBYsHkyqQFKAyhiS8MbQOGih7O+wt3chVaOQkO+swEcNtRi4ltBcjjj5L
	 LwZdl/vs/le88FUV7wJacKBXOWkhPQAn6PPVyBkUsjyDzC8jDO41aUoM78INP6S0fS
	 Nlm3khodnCwlumyfDJKqUOZoe/MTYbpQUl0HyPSI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728446AbgD3QUD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 12:20:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:58740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727108AbgD3QSj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 12:18:39 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1F4224956;
        Thu, 30 Apr 2020 16:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588263518;
        bh=E2W+Pp9D1/Ag9kxnKEgTpnr6s13MrdK3Hx82R//8IyQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RI72qE74qq8DRf2eNEeVqVVN3J3AsfpRNkLolqnnMt1UB+xXG53sXXUOhtryaQxWQ
         d4sxs7io0tLSLVN6ydVgQqmfpRN/HzyviegkS1PGjEm87RQTdEtt41iEBibjjU4G74
         0RawY5uPG2KfZwz/dllOCbsAgNvbX3os2ytmLVcU=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jUBtU-00AxhH-3S; Thu, 30 Apr 2020 18:18:36 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v4 09/19] docs: misc-devices/c2port.txt: convert to ReST format
Date:   Thu, 30 Apr 2020 18:18:23 +0200
Message-Id: <1d175df3e43b2606b892a2bfed387cd5c1b6e3cd.1588263270.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <cover.1588263270.git.mchehab+huawei@kernel.org>
References: <cover.1588263270.git.mchehab+huawei@kernel.org>
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
index ea7344465610..258e1c1d43c7 100644
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
@@ -32,10 +36,10 @@ The C2 Interface main references are at (http://www.silabs.com)
 Silicon Laboratories site], see:
 
 - AN127: FLASH Programming via the C2 Interface at
-http://www.silabs.com/Support Documents/TechnicalDocs/an127.pdf 
+  http://www.silabs.com/Support Documents/TechnicalDocs/an127.pdf
 
 - C2 Specification at
-http://www.silabs.com/pages/DownloadDoc.aspx?FILEURL=Support%20Documents/TechnicalDocs/an127.pdf&src=SearchResults
+  http://www.silabs.com/pages/DownloadDoc.aspx?FILEURL=Support%20Documents/TechnicalDocs/an127.pdf&src=SearchResults
 
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
index 17e77b6aa27c..f4ecafad6678 100644
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
2.25.4

