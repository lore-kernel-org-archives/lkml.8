Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E65C4724C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 16:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C371D20873
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 16:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588263597;
	bh=vUQJK6iUb1DSHmuLcT8V2zKM9fkwWsWsXbhGEZFJdNU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=L8PMazR8g0CEhDTXeDbe3h+m9Sxp4qEPz0ln2hhd9KA4YH0m93agGXNx//h38Qzy2
	 F49Nknhxc1yXLZC/kx/X0sL7HFCNCSwGCVVmfS79NqbPzSfXxhGYnh0UCkLTUJpGnw
	 M5KMCztd/JRQwj4aJA3omJF2/JYssghGW5wOOBZo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728411AbgD3QTr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 12:19:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:58752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728118AbgD3QSj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 12:18:39 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E525424958;
        Thu, 30 Apr 2020 16:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588263518;
        bh=vUQJK6iUb1DSHmuLcT8V2zKM9fkwWsWsXbhGEZFJdNU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ILgmivu4xQs3dGo9SH0b0gTkpmemnKFtds1UebIAhkIkQExXQydry1RXgDZzZt1ns
         nx8iZSA62AXTHe3HyvjKu1O9bB1pE2s7udYhBegRUMtU/efFtvJvvK9DrpReKOg4uM
         o7cIfqDvgZDtfvtxYkZcQdhGwiGSDFP3XnyznTgE=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jUBtU-00AxhS-5I; Thu, 30 Apr 2020 18:18:36 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v4 11/19] docs: misc-devices/apds990x.txt: convert to ReST format
Date:   Thu, 30 Apr 2020 18:18:25 +0200
Message-Id: <9b02b1e2b42e9f6b4e911802ada9b63722090398.1588263270.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <cover.1588263270.git.mchehab+huawei@kernel.org>
References: <cover.1588263270.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Adjust title markup;
- Adjust identation.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../{apds990x.txt => apds990x.rst}            | 31 ++++++++++++++-----
 Documentation/misc-devices/index.rst          |  1 +
 2 files changed, 25 insertions(+), 7 deletions(-)
 rename Documentation/misc-devices/{apds990x.txt => apds990x.rst} (86%)

diff --git a/Documentation/misc-devices/apds990x.txt b/Documentation/misc-devices/apds990x.rst
similarity index 86%
rename from Documentation/misc-devices/apds990x.txt
rename to Documentation/misc-devices/apds990x.rst
index 454d95d623b3..e2f75577f731 100644
--- a/Documentation/misc-devices/apds990x.txt
+++ b/Documentation/misc-devices/apds990x.rst
@@ -1,3 +1,6 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+======================
 Kernel driver apds990x
 ======================
 
@@ -50,14 +53,18 @@ chip_id
 
 power_state
 	RW - enable / disable chip. Uses counting logic
+
 	     1 enables the chip
 	     0 disables the chip
 lux0_input
 	RO - measured lux value
+
 	     sysfs_notify called when threshold interrupt occurs
 
 lux0_sensor_range
-	RO - lux0_input max value. Actually never reaches since sensor tends
+	RO - lux0_input max value.
+
+	     Actually never reaches since sensor tends
 	     to saturate much before that. Real max value varies depending
 	     on the light spectrum etc.
 
@@ -68,7 +75,9 @@ lux0_rate_avail
 	RO - supported measurement rates
 
 lux0_calibscale
-	RW - calibration value. Set to neutral value by default.
+	RW - calibration value.
+
+	     Set to neutral value by default.
 	     Output results are multiplied with calibscale / calibscale_default
 	     value.
 
@@ -76,16 +85,21 @@ lux0_calibscale_default
 	RO - neutral calibration value
 
 lux0_thresh_above_value
-	RW - HI level threshold value. All results above the value
+	RW - HI level threshold value.
+
+	     All results above the value
 	     trigs an interrupt. 65535 (i.e. sensor_range) disables the above
 	     interrupt.
 
 lux0_thresh_below_value
-	RW - LO level threshold value. All results below the value
+	RW - LO level threshold value.
+
+	     All results below the value
 	     trigs an interrupt. 0 disables the below interrupt.
 
 prox0_raw
 	RO - measured proximity value
+
 	     sysfs_notify called when threshold interrupt occurs
 
 prox0_sensor_range
@@ -93,11 +107,14 @@ prox0_sensor_range
 
 prox0_raw_en
 	RW - enable / disable proximity - uses counting logic
-	     1 enables the proximity
-	     0 disables the proximity
+
+	     - 1 enables the proximity
+	     - 0 disables the proximity
 
 prox0_reporting_mode
-	RW - trigger / periodic. In "trigger" mode the driver tells two possible
+	RW - trigger / periodic.
+
+	     In "trigger" mode the driver tells two possible
 	     values: 0 or prox0_sensor_range value. 0 means no proximity,
 	     1023 means proximity. This causes minimal number of interrupts.
 	     In "periodic" mode the driver reports all values above
diff --git a/Documentation/misc-devices/index.rst b/Documentation/misc-devices/index.rst
index d28e755a1595..a31c2ab8151f 100644
--- a/Documentation/misc-devices/index.rst
+++ b/Documentation/misc-devices/index.rst
@@ -15,6 +15,7 @@ fit into other categories.
    :maxdepth: 2
 
    ad525x_dpot
+   apds990x
    bh1770glc
    eeprom
    c2port
-- 
2.25.4

