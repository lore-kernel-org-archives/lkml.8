Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23525C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 06:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2A2E2067B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 06:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592203926;
	bh=GBxMSAyNiO53In1PcIEzqcowz8jfHN90ejuS0lkWYik=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sXXzuAwOh//UK7IDJsCGGkn5PUiznyaGAokPfj+JgUWwK3/21rpok7JgF8M8HpGaU
	 PBuSQq2wpWCb7N7RdE4Jh9HfcL2duUZK8Ir8tahvKK1aT8pdkDHkOnMbwPAZhInizm
	 Ya8zXTwniyTSQxi35zFKdZLOLL3lXPvdhdgAjE9s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728955AbgFOGwE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 02:52:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:36678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728578AbgFOGue (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 02:50:34 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26B9A20842;
        Mon, 15 Jun 2020 06:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592203832;
        bh=GBxMSAyNiO53In1PcIEzqcowz8jfHN90ejuS0lkWYik=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=afOBXEFbOs8ZOvq8t9OIUDBjLcMV/2r5IH7GZTMBaYV6p/tNJT9ErmXILHLwc9qK+
         /WF+Dgt2COODdWIH+Bd5w3je7NE+GSnWErMBX35ev8beX7lVuKD0vYkielbyYJaMrK
         ikFbyrClt60Ghyas2f8BoMrYlQFXZHs9Eyiz+cQA=
Received: from mchehab by mail.kernel.org with local (Exim 4.93)
        (envelope-from <mchehab@kernel.org>)
        id 1jkiww-009o5w-52; Mon, 15 Jun 2020 08:50:30 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH 08/22] docs: misc-devices/pci-endpoint-test.txt: convert to ReST
Date:   Mon, 15 Jun 2020 08:50:13 +0200
Message-Id: <1b1f4e5e57fd2065828cecc9d07afbd247349e94.1592203650.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1592203650.git.mchehab+huawei@kernel.org>
References: <cover.1592203650.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- use title markups;
- mark literal blocks.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../{ad525x_dpot.txt => ad525x_dpot.rst}      | 24 +++++++++----------
 Documentation/misc-devices/index.rst          |  1 +
 drivers/misc/Kconfig                          |  2 +-
 drivers/misc/ad525x_dpot.c                    |  2 +-
 4 files changed, 15 insertions(+), 14 deletions(-)
 rename Documentation/misc-devices/{ad525x_dpot.txt => ad525x_dpot.rst} (85%)

diff --git a/Documentation/misc-devices/ad525x_dpot.txt b/Documentation/misc-devices/ad525x_dpot.rst
similarity index 85%
rename from Documentation/misc-devices/ad525x_dpot.txt
rename to Documentation/misc-devices/ad525x_dpot.rst
index 0c9413b1cbf3..6483ec254520 100644
--- a/Documentation/misc-devices/ad525x_dpot.txt
+++ b/Documentation/misc-devices/ad525x_dpot.rst
@@ -1,6 +1,8 @@
----------------------------------
-  AD525x Digital Potentiometers
----------------------------------
+.. SPDX-License-Identifier: GPL-2.0
+
+=============================
+AD525x Digital Potentiometers
+=============================
 
 The ad525x_dpot driver exports a simple sysfs interface.  This allows you to
 work with the immediate resistance settings as well as update the saved startup
@@ -8,9 +10,8 @@ settings.  Access to the factory programmed tolerance is also provided, but
 interpretation of this settings is required by the end application according to
 the specific part in use.
 
----------
-  Files
----------
+Files
+=====
 
 Each dpot device will have a set of eeprom, rdac, and tolerance files.  How
 many depends on the actual part you have, as will the range of allowed values.
@@ -24,23 +25,22 @@ and may vary greatly on a part-by-part basis.  For exact interpretation of
 this field, please consult the datasheet for your part.  This is presented
 as a hex file for easier parsing.
 
------------
-  Example
------------
+Example
+=======
 
 Locate the device in your sysfs tree.  This is probably easiest by going into
-the common i2c directory and locating the device by the i2c slave address.
+the common i2c directory and locating the device by the i2c slave address::
 
 	# ls /sys/bus/i2c/devices/
 	0-0022  0-0027  0-002f
 
 So assuming the device in question is on the first i2c bus and has the slave
-address of 0x2f, we descend (unrelated sysfs entries have been trimmed).
+address of 0x2f, we descend (unrelated sysfs entries have been trimmed)::
 
 	# ls /sys/bus/i2c/devices/0-002f/
 	eeprom0 rdac0 tolerance0
 
-You can use simple reads/writes to access these files:
+You can use simple reads/writes to access these files::
 
 	# cd /sys/bus/i2c/devices/0-002f/
 
diff --git a/Documentation/misc-devices/index.rst b/Documentation/misc-devices/index.rst
index 56fc1e03488a..d05626dd0fbb 100644
--- a/Documentation/misc-devices/index.rst
+++ b/Documentation/misc-devices/index.rst
@@ -14,6 +14,7 @@ fit into other categories.
 .. toctree::
    :maxdepth: 2
 
+   ad525x_dpot
    eeprom
    ibmvmc
    ics932s401
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index e1b1ba5e2b92..3ca4325cc191 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -24,7 +24,7 @@ config AD525X_DPOT
 	  AD5271, AD5272, AD5274
 	  digital potentiometer chips.
 
-	  See Documentation/misc-devices/ad525x_dpot.txt for the
+	  See Documentation/misc-devices/ad525x_dpot.rst for the
 	  userspace interface.
 
 	  This driver can also be built as a module.  If so, the module
diff --git a/drivers/misc/ad525x_dpot.c b/drivers/misc/ad525x_dpot.c
index ccce3226a571..6f164522b028 100644
--- a/drivers/misc/ad525x_dpot.c
+++ b/drivers/misc/ad525x_dpot.c
@@ -58,7 +58,7 @@
  * AD5272		1		1024		20, 50, 100 (50-TP)
  * AD5274		1		256		20, 50, 100 (50-TP)
  *
- * See Documentation/misc-devices/ad525x_dpot.txt for more info.
+ * See Documentation/misc-devices/ad525x_dpot.rst for more info.
  *
  * derived from ad5258.c
  * Copyright (c) 2009 Cyber Switching, Inc.
-- 
2.26.2

