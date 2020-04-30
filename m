Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED444C47247
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 16:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBD72208CA
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 16:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588263552;
	bh=1HSEtM//mtsWijKO6s3LsrrY5g4LGqp0ULlRYJzv8go=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Fk14Y3sapWluzcrXJ3N83ekisMqiQ/fHQgZDH+CgBE1PZl3uF7yHOQd89qloeglmd
	 nyr5BIGwXcHHhD9umE+GmHgqZ48zEYZBuNwxA5lW5Ks6QXYPnWnwNLUuHulJU2JDSC
	 30u9fOS10P58Lso+2XsfyDjedV9S6dQlFRTJoRzg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbgD3QSr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 12:18:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:58618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727049AbgD3QSi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 12:18:38 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C272E2173E;
        Thu, 30 Apr 2020 16:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588263517;
        bh=1HSEtM//mtsWijKO6s3LsrrY5g4LGqp0ULlRYJzv8go=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZIEkWaxruoI8rsJBH/VsKhH81CfBr1pX/uYW/ta2Pj4pE70cPG45WjjB5FDkbzM79
         RkjX4fa8QqnVjXL0DOJpsSzoiksLGXUGI2/shW4AjSSyJH/ZnkumklOlrTo8bYQ8YQ
         CEXZ9hmPzXDLi47/TRyn/TVFRQ9zu5MtYiMY2D1Y=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jUBtU-00Axh8-1g; Thu, 30 Apr 2020 18:18:36 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH v4 07/19] docs: misc-devices/pci-endpoint-test.txt: convert to ReST
Date:   Thu, 30 Apr 2020 18:18:21 +0200
Message-Id: <5e6389e49965a39d5ea5face113848671409bb7e.1588263270.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <cover.1588263270.git.mchehab+huawei@kernel.org>
References: <cover.1588263270.git.mchehab+huawei@kernel.org>
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
index 68b43e140641..a72ab89e7d1a 100644
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
index 99e151475d8f..9388743d78e3 100644
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
2.25.4

