Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E525C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 06:50:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B119207F5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 06:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592203841;
	bh=l/voElHgBXF6XaGCARYoDwEnBOxjNFzYqUDS5RtZWBQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1WkkQlXnpzKMT1sjSgQ55bbaNuCqqdzT+YnSlg9HMgSDRPe+4Sg8nAjucHNIwXglW
	 bMWnABD2BalZur8MAjWIrUjVz/43PNhHye9SHIx95HYSa0CEgPDLFoOeKc1fOE/6W8
	 5PAJAzdC0y+cBoEbch0+Pz5J1hhPmUBxEPAchc50=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728891AbgFOGuk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 02:50:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:36702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728587AbgFOGue (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 02:50:34 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C7CA20857;
        Mon, 15 Jun 2020 06:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592203832;
        bh=l/voElHgBXF6XaGCARYoDwEnBOxjNFzYqUDS5RtZWBQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z+xFLW/A6QPFJ8r+sDAdHZeJ06Y3JWxsjc0qDyJ/sUQOnVug737ar7f9uEZygLqhv
         /e1w/Wd6SRBOew6HFjVvNtPx5+Vy1j9ugv6V7onPJizAwLIiGabpbNNknFounpkbaM
         UX43oHtxDkBEV1nqqaVJphgPvLWnBxch7/ih7PA4=
Received: from mchehab by mail.kernel.org with local (Exim 4.93)
        (envelope-from <mchehab@kernel.org>)
        id 1jkiww-009o6F-A7; Mon, 15 Jun 2020 08:50:30 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 11/22] docs: misc-devices/bh1770glc.txt: convert to ReST
Date:   Mon, 15 Jun 2020 08:50:16 +0200
Message-Id: <58ba712524318d03b3196bba33cb409472b4807d.1592203650.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1592203650.git.mchehab+huawei@kernel.org>
References: <cover.1592203650.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Adjust document title markup;
- use list markups;
- Adjust identations to display properly at ReST output.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../{bh1770glc.txt => bh1770glc.rst}          | 45 +++++++++++++------
 Documentation/misc-devices/index.rst          |  1 +
 2 files changed, 33 insertions(+), 13 deletions(-)
 rename Documentation/misc-devices/{bh1770glc.txt => bh1770glc.rst} (83%)

diff --git a/Documentation/misc-devices/bh1770glc.txt b/Documentation/misc-devices/bh1770glc.rst
similarity index 83%
rename from Documentation/misc-devices/bh1770glc.txt
rename to Documentation/misc-devices/bh1770glc.rst
index 7d64c014dc70..ea5ca58bb958 100644
--- a/Documentation/misc-devices/bh1770glc.txt
+++ b/Documentation/misc-devices/bh1770glc.rst
@@ -1,9 +1,13 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=======================
 Kernel driver bh1770glc
 =======================
 
 Supported chips:
-ROHM BH1770GLC
-OSRAM SFH7770
+
+- ROHM BH1770GLC
+- OSRAM SFH7770
 
 Data sheet:
 Not freely available
@@ -48,12 +52,16 @@ chip_id
 	RO - shows detected chip type and version
 
 power_state
-	RW - enable / disable chip. Uses counting logic
-	     1 enables the chip
-	     0 disables the chip
+	RW - enable / disable chip
+
+	Uses counting logic
+
+	     - 1 enables the chip
+	     - 0 disables the chip
 
 lux0_input
 	RO - measured lux value
+
 	     sysfs_notify called when threshold interrupt occurs
 
 lux0_sensor_range
@@ -66,16 +74,22 @@ lux0_rate_avail
 	RO - supported measurement rates
 
 lux0_thresh_above_value
-	RW - HI level threshold value. All results above the value
+	RW - HI level threshold value
+
+	     All results above the value
 	     trigs an interrupt. 65535 (i.e. sensor_range) disables the above
 	     interrupt.
 
 lux0_thresh_below_value
-	RW - LO level threshold value. All results below the value
+	RW - LO level threshold value
+
+	     All results below the value
 	     trigs an interrupt. 0 disables the below interrupt.
 
 lux0_calibscale
-	RW - calibration value. Set to neutral value by default.
+	RW - calibration value
+
+	     Set to neutral value by default.
 	     Output results are multiplied with calibscale / calibscale_default
 	     value.
 
@@ -84,32 +98,37 @@ lux0_calibscale_default
 
 prox0_raw
 	RO - measured proximity value
+
 	     sysfs_notify called when threshold interrupt occurs
 
 prox0_sensor_range
 	RO - prox0_raw max value
 
 prox0_raw_en
-	RW - enable / disable proximity - uses counting logic
-	     1 enables the proximity
-	     0 disables the proximity
+	RW - enable / disable proximity
+
+	     Uses counting logic
+
+	     - 1 enables the proximity
+	     - 0 disables the proximity
 
 prox0_thresh_above_count
 	RW - number of proximity interrupts needed before triggering the event
 
 prox0_rate_above
 	RW - Measurement rate (in Hz) when the level is above threshold
-	     i.e. when proximity on has been reported.
+	i.e. when proximity on has been reported.
 
 prox0_rate_below
 	RW - Measurement rate (in Hz) when the level is below threshold
-	     i.e. when proximity off has been reported.
+	i.e. when proximity off has been reported.
 
 prox0_rate_avail
 	RO - Supported proximity measurement rates in Hz
 
 prox0_thresh_above0_value
 	RW - threshold level which trigs proximity events.
+
 	     Filtered by persistence filter (prox0_thresh_above_count)
 
 prox0_thresh_above1_value
diff --git a/Documentation/misc-devices/index.rst b/Documentation/misc-devices/index.rst
index 27e268805067..edf66b59f2d4 100644
--- a/Documentation/misc-devices/index.rst
+++ b/Documentation/misc-devices/index.rst
@@ -15,6 +15,7 @@ fit into other categories.
    :maxdepth: 2
 
    ad525x_dpot
+   bh1770glc
    eeprom
    c2port
    ibmvmc
-- 
2.26.2

