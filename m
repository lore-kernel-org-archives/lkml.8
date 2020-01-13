Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27CE3C33CAE
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 16:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0401A24682
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 16:29:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729015AbgAMQ2u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 11:28:50 -0500
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:37950 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728922AbgAMQ2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 11:28:48 -0500
Received: from Internal Mail-Server by MTLPINE1 (envelope-from vadimp@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 13 Jan 2020 18:28:44 +0200
Received: from r-build-lowlevel.mtr.labs.mlnx. (r-build-lowlevel.mtr.labs.mlnx [10.209.0.190])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 00DGSefZ032667;
        Mon, 13 Jan 2020 18:28:44 +0200
From:   Vadim Pasternak <vadimp@mellanox.com>
To:     andy@infradead.org, dvhart@infradead.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vadim Pasternak <vadimp@mellanox.com>
Subject: [PATCH platform-next v3 04/11] Documentation/ABI: Style changes
Date:   Mon, 13 Jan 2020 16:28:32 +0000
Message-Id: <20200113162839.18103-5-vadimp@mellanox.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200113162839.18103-1-vadimp@mellanox.com>
References: <20200113162839.18103-1-vadimp@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove blank lines between "What" and "Date" keywords.
Start each section with "What" keyword.

Signed-off-by: Vadim Pasternak <vadimp@mellanox.com>
---
 Documentation/ABI/stable/sysfs-driver-mlxreg-io | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/Documentation/ABI/stable/sysfs-driver-mlxreg-io b/Documentation/ABI/stable/sysfs-driver-mlxreg-io
index 05601a90a9b6..eb6db7382ae3 100644
--- a/Documentation/ABI/stable/sysfs-driver-mlxreg-io
+++ b/Documentation/ABI/stable/sysfs-driver-mlxreg-io
@@ -1,5 +1,4 @@
 What:		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/asic_health
-
 Date:		June 2018
 KernelVersion:	4.19
 Contact:	Vadim Pasternak <vadimpmellanox.com>
@@ -19,7 +18,6 @@ Description:	These files show with which CPLD versions have been burned
 		The files are read only.
 
 What:		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/fan_dir
-
 Date:		December 2018
 KernelVersion:	5.0
 Contact:	Vadim Pasternak <vadimpmellanox.com>
@@ -30,7 +28,6 @@ Description:	This file shows the system fans direction:
 		The files are read only.
 
 What:		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/cpld3_version
-
 Date:		November 2018
 KernelVersion:	5.0
 Contact:	Vadim Pasternak <vadimpmellanox.com>
@@ -40,7 +37,6 @@ Description:	These files show with which CPLD versions have been burned
 		The files are read only.
 
 What:		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/jtag_enable
-
 Date:		November 2018
 KernelVersion:	5.0
 Contact:	Vadim Pasternak <vadimpmellanox.com>
@@ -108,7 +104,6 @@ What:		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/reset_comex_pwr_fail
 What:		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/reset_from_comex
 What:		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/reset_system
 What:		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/reset_voltmon_upgrade_fail
-
 Date:		November 2018
 KernelVersion:	5.0
 Contact:	Vadim Pasternak <vadimpmellanox.com>
@@ -130,6 +125,12 @@ Description:	These files show with which CPLD versions have been burned
 
 		The files are read only.
 
+What:		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/reset_comex_thermal
+What:		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/reset_comex_wd
+What:		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/reset_from_asic
+What:		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/reset_reload_bios
+What:		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/reset_sff_wd
+What:		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/reset_swb_wd
 Date:		June 2019
 KernelVersion:	5.3
 Contact:	Vadim Pasternak <vadimpmellanox.com>
@@ -142,10 +143,3 @@ Description:	These files show the system reset cause, as following:
 		only last reset cause.
 
 		The files are read only.
-
-What:		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/reset_comex_thermal
-What:		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/reset_comex_wd
-What:		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/reset_from_asic
-What:		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/reset_reload_bios
-What:		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/reset_sff_wd
-What:		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/reset_swb_wd
-- 
2.11.0

