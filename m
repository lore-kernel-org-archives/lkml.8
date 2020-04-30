Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37F19C4724C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 16:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17723208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 16:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588263532;
	bh=tkR3wAT0LBmvaZI9/1wP4hUMFYjfHl3vE2K0GoEx1LM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aXDnwfjDAf9IZYCyoX5CiMm9ZsH2a5hO4OutioCbW2nwMObKIrhpa3dDsFpX0in50
	 kr+q4FwvnVQV0kAFGryPqlc8Fgt2GU1fRrmm4hrPnTFFNNwdW+/EKIzOwmoxGLRIjs
	 vZeCXtHm7jd0JhBvgdH31o9OvA+/KESbISttZcuQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbgD3QSv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 12:18:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:58738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727089AbgD3QSj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 12:18:39 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB2CB24955;
        Thu, 30 Apr 2020 16:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588263518;
        bh=tkR3wAT0LBmvaZI9/1wP4hUMFYjfHl3vE2K0GoEx1LM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D6Djx5AJAN0TwrnZVbjAKbp7koalkpKSiHnBBAzdRIYlEFCzI8amprN6d/qh3JlSv
         zaFOXLv7JPZdiGSMtUueeOe5h+2S/dJDr9jxwV4Dnba+xZIrOzn7DjwTKuy8uua3qy
         pypGgyaAcQ/auq/XNZPMITb6H7qC0SntzfMiROL0=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jUBtU-00AxhN-4O; Thu, 30 Apr 2020 18:18:36 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v4 10/19] docs: misc-devices/bh1770glc.txt: convert to ReST
Date:   Thu, 30 Apr 2020 18:18:24 +0200
Message-Id: <1aaa71c0a287b53d8e77e535fa46bbc18f348b1a.1588263270.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <cover.1588263270.git.mchehab+huawei@kernel.org>
References: <cover.1588263270.git.mchehab+huawei@kernel.org>
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
index f4ecafad6678..d28e755a1595 100644
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
2.25.4

