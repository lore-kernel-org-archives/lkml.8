Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A18C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 06:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A55402068E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 06:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592203849;
	bh=2e8YbV+iFyIafDw6TGRdo7FrHkXoXdqbP8J/qGks5Cg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PNUgfwQoyKuG44AMl4EYZd6h/RR8mMhHFZ7HRDsdjdD04pfEeQjiYd8EgrzpCSojK
	 pShp5y+zmUhgckVEwx7kAIsV8rlXBUuUU7EgHPUTO/77sH2/CDPTlSVafAwEIoBD70
	 JE2U5zpL/Xp2jd35hKsTSeY7Eisj2wvncd5tFdtY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728566AbgFOGus (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 02:50:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:36678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728595AbgFOGuf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 02:50:35 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3DBAF20899;
        Mon, 15 Jun 2020 06:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592203832;
        bh=2e8YbV+iFyIafDw6TGRdo7FrHkXoXdqbP8J/qGks5Cg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jj19mfBZolBK4MzdifC5wG/g+igMTiQglZ7t+8vdToUyngy9ux9s+CtBiD5DOaMDF
         AHGa567kz/oGW9v0h5VJwYYFTC0wDMMZ8ox8Uh4+xwsdi+LCy3V9fWHPTkPCvu9lWV
         5BYgPF9QnHSkccsFHQl3Ect0q9MU+ZeHhgvg1Y08=
Received: from mchehab by mail.kernel.org with local (Exim 4.93)
        (envelope-from <mchehab@kernel.org>)
        id 1jkiww-009o6J-Bx; Mon, 15 Jun 2020 08:50:30 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 12/22] docs: misc-devices/apds990x.txt: convert to ReST format
Date:   Mon, 15 Jun 2020 08:50:17 +0200
Message-Id: <444743782e5c8b8085d8016c8be3baabe4d23b53.1592203650.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1592203650.git.mchehab+huawei@kernel.org>
References: <cover.1592203650.git.mchehab+huawei@kernel.org>
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
index edf66b59f2d4..46072ce3d7ef 100644
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
2.26.2

