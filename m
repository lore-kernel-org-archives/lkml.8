Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E9DC47257
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 14:49:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D13A420857
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 14:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588344544;
	bh=wya6wRqdMSvqt8leut7SPom5osO64wxCrIIXhcHwnN8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2eOYh7XIn4LJFm3sv4J2aYq/r4j9fZ3843fcUZQy/GYsmthHf41H4tHYj91JXdbv4
	 YPEx3SZ8U3WHXNbR6yK4Ize0dIUJb/Vy8c4DdTEAQuPSt1LXXF4SzjaJwaxpX5RebE
	 9ARr4GmPQ5VBxURajbVcQSpnLb7cbhz+HKPwgph0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730529AbgEAOtD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 10:49:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:52652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729360AbgEAOpH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 10:45:07 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 225ED2495D;
        Fri,  1 May 2020 14:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588344305;
        bh=wya6wRqdMSvqt8leut7SPom5osO64wxCrIIXhcHwnN8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OkAO8/EWVJ8Glf3QWOgQdRNz2gP5YEWxviYMcKaML4ns315KdJ14hvpe4yuyzHKzE
         jMiMRBVg6JNHxyDNvGVpxZ2S7M67y/buNCpmmLp2YfGxmbJLL2TSy+tTVLlsfNO9Hk
         qNpEeur7RAKdI2EjdzXH6/+lGCIAJkrSjIQY3JxM=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jUWuT-00FCeN-Qh; Fri, 01 May 2020 16:45:01 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH 23/37] docs: networking: device drivers: convert freescale/gianfar.txt to ReST
Date:   Fri,  1 May 2020 16:44:45 +0200
Message-Id: <692a90829ddf549be95150976cd91e7ce26231ff.1588344146.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <cover.1588344146.git.mchehab+huawei@kernel.org>
References: <cover.1588344146.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- add SPDX header;
- adjust titles and chapters, adding proper markups;
- use :field: markup;
- add to networking/index.rst.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../freescale/{gianfar.txt => gianfar.rst}    | 21 +++++++++++++------
 .../networking/device_drivers/index.rst       |  1 +
 2 files changed, 16 insertions(+), 6 deletions(-)
 rename Documentation/networking/device_drivers/freescale/{gianfar.txt => gianfar.rst} (82%)

diff --git a/Documentation/networking/device_drivers/freescale/gianfar.txt b/Documentation/networking/device_drivers/freescale/gianfar.rst
similarity index 82%
rename from Documentation/networking/device_drivers/freescale/gianfar.txt
rename to Documentation/networking/device_drivers/freescale/gianfar.rst
index ba1daea7f2e4..9c4a91d3824b 100644
--- a/Documentation/networking/device_drivers/freescale/gianfar.txt
+++ b/Documentation/networking/device_drivers/freescale/gianfar.rst
@@ -1,10 +1,15 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===========================
 The Gianfar Ethernet Driver
+===========================
 
-Author: Andy Fleming <afleming@freescale.com>
-Updated: 2005-07-28
+:Author: Andy Fleming <afleming@freescale.com>
+:Updated: 2005-07-28
 
 
-CHECKSUM OFFLOADING
+Checksum Offloading
+===================
 
 The eTSEC controller (first included in parts from late 2005 like
 the 8548) has the ability to perform TCP, UDP, and IP checksums
@@ -15,13 +20,15 @@ packets.  Use ethtool to enable or disable this feature for RX
 and TX.
 
 VLAN
+====
 
 In order to use VLAN, please consult Linux documentation on
 configuring VLANs.  The gianfar driver supports hardware insertion and
 extraction of VLAN headers, but not filtering.  Filtering will be
 done by the kernel.
 
-MULTICASTING
+Multicasting
+============
 
 The gianfar driver supports using the group hash table on the
 TSEC (and the extended hash table on the eTSEC) for multicast
@@ -29,13 +36,15 @@ filtering.  On the eTSEC, the exact-match MAC registers are used
 before the hash tables.  See Linux documentation on how to join
 multicast groups.
 
-PADDING
+Padding
+=======
 
 The gianfar driver supports padding received frames with 2 bytes
 to align the IP header to a 16-byte boundary, when supported by
 hardware.
 
-ETHTOOL
+Ethtool
+=======
 
 The gianfar driver supports the use of ethtool for many
 configuration options.  You must run ethtool only on currently
diff --git a/Documentation/networking/device_drivers/index.rst b/Documentation/networking/device_drivers/index.rst
index 7e59ee43c030..cec3415ee459 100644
--- a/Documentation/networking/device_drivers/index.rst
+++ b/Documentation/networking/device_drivers/index.rst
@@ -38,6 +38,7 @@ Contents:
    dec/dmfe
    dlink/dl2k
    freescale/dpaa
+   freescale/gianfar
 
 .. only::  subproject and html
 
-- 
2.25.4

