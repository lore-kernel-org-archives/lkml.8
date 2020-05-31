Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4461C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 05:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0DB2206E2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 05:22:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726022AbgFAFWs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 01:22:48 -0400
Received: from mga12.intel.com ([192.55.52.136]:8652 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725788AbgFAFWs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 01:22:48 -0400
IronPort-SDR: 3DJGJgq6SNHgHiRUsQuQ0f6Wfpc1UWD0nqSTQbK1rhEzvQNZFK5IiAzh96ItX6a+oH2qWPWVne
 99VAKJKxwAow==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2020 22:22:47 -0700
IronPort-SDR: x/VS843ZPMV31YMBY+LvHL3NIKbKwx5UPVJLKGjiapJBCYhOgsdiBRyipqp8yFaHWCnxN5awoU
 t0GDNHNIY0fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,459,1583222400"; 
   d="scan'208";a="470196419"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by fmsmga005.fm.intel.com with ESMTP; 31 May 2020 22:22:43 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        slawomir.blauciak@intel.com, mengdong.lin@intel.com,
        bard.liao@intel.com
Subject: [PATCH] soundwire: clarify SPDX use of GPL-2.0
Date:   Mon,  1 Jun 2020 01:28:07 +0800
Message-Id: <20200531172807.27042-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Change SPDX from GPL-2.0 to GPL-2.0-only for Intel-contributed
code. This was explicit before the transition to SPDX and lost in
translation.

No change to the dual-license parts, the only clarification is to the
GPL-2.0 term.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/bus.c                 | 2 +-
 drivers/soundwire/bus.h                 | 2 +-
 drivers/soundwire/bus_type.c            | 2 +-
 drivers/soundwire/cadence_master.c      | 2 +-
 drivers/soundwire/cadence_master.h      | 2 +-
 drivers/soundwire/intel.c               | 2 +-
 drivers/soundwire/intel.h               | 2 +-
 drivers/soundwire/intel_init.c          | 2 +-
 drivers/soundwire/mipi_disco.c          | 2 +-
 drivers/soundwire/slave.c               | 2 +-
 drivers/soundwire/stream.c              | 2 +-
 include/linux/soundwire/sdw.h           | 2 +-
 include/linux/soundwire/sdw_intel.h     | 2 +-
 include/linux/soundwire/sdw_registers.h | 2 +-
 include/linux/soundwire/sdw_type.h      | 2 +-
 15 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index 24ba77226376..2289c2ac8c5a 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
 // Copyright(c) 2015-17 Intel Corporation.
 
 #include <linux/acpi.h>
diff --git a/drivers/soundwire/bus.h b/drivers/soundwire/bus.h
index 82484f741168..697a5b371568 100644
--- a/drivers/soundwire/bus.h
+++ b/drivers/soundwire/bus.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause) */
 /* Copyright(c) 2015-17 Intel Corporation. */
 
 #ifndef __SDW_BUS_H
diff --git a/drivers/soundwire/bus_type.c b/drivers/soundwire/bus_type.c
index de9a671802b8..95a87d4e26c2 100644
--- a/drivers/soundwire/bus_type.c
+++ b/drivers/soundwire/bus_type.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 // Copyright(c) 2015-17 Intel Corporation.
 
 #include <linux/module.h>
diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index 9ea87538b9ef..fe238645ed2c 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
 // Copyright(c) 2015-17 Intel Corporation.
 
 /*
diff --git a/drivers/soundwire/cadence_master.h b/drivers/soundwire/cadence_master.h
index b410656f8194..ea606b4fba76 100644
--- a/drivers/soundwire/cadence_master.h
+++ b/drivers/soundwire/cadence_master.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause) */
 /* Copyright(c) 2015-17 Intel Corporation. */
 #include <sound/soc.h>
 
diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 4cfdd074e310..1eda63f488f5 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
 // Copyright(c) 2015-17 Intel Corporation.
 
 /*
diff --git a/drivers/soundwire/intel.h b/drivers/soundwire/intel.h
index 38b7c125fb10..7b4af8018e1a 100644
--- a/drivers/soundwire/intel.h
+++ b/drivers/soundwire/intel.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause) */
 /* Copyright(c) 2015-17 Intel Corporation. */
 
 #ifndef __SDW_INTEL_LOCAL_H
diff --git a/drivers/soundwire/intel_init.c b/drivers/soundwire/intel_init.c
index d5d42795a48f..947345d5c960 100644
--- a/drivers/soundwire/intel_init.c
+++ b/drivers/soundwire/intel_init.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
 // Copyright(c) 2015-17 Intel Corporation.
 
 /*
diff --git a/drivers/soundwire/mipi_disco.c b/drivers/soundwire/mipi_disco.c
index 4ae62b452b8c..dbd8fc6f4dad 100644
--- a/drivers/soundwire/mipi_disco.c
+++ b/drivers/soundwire/mipi_disco.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
 // Copyright(c) 2015-17 Intel Corporation.
 
 /*
diff --git a/drivers/soundwire/slave.c b/drivers/soundwire/slave.c
index 0839445ee07b..8e8b62dff51c 100644
--- a/drivers/soundwire/slave.c
+++ b/drivers/soundwire/slave.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
 // Copyright(c) 2015-17 Intel Corporation.
 
 #include <linux/acpi.h>
diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index a9a72574b34a..296cea48bdcc 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
 // Copyright(c) 2015-18 Intel Corporation.
 
 /*
diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index 9c27a32df9bb..1fde044f5f3e 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause) */
 /* Copyright(c) 2015-17 Intel Corporation. */
 
 #ifndef __SOUNDWIRE_H
diff --git a/include/linux/soundwire/sdw_intel.h b/include/linux/soundwire/sdw_intel.h
index 979b41b5dcb4..96a8633339a1 100644
--- a/include/linux/soundwire/sdw_intel.h
+++ b/include/linux/soundwire/sdw_intel.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause) */
 /* Copyright(c) 2015-17 Intel Corporation. */
 
 #ifndef __SDW_INTEL_H
diff --git a/include/linux/soundwire/sdw_registers.h b/include/linux/soundwire/sdw_registers.h
index a686f7988156..06d895168b32 100644
--- a/include/linux/soundwire/sdw_registers.h
+++ b/include/linux/soundwire/sdw_registers.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause) */
 /* Copyright(c) 2015-17 Intel Corporation. */
 
 #ifndef __SDW_REGISTERS_H
diff --git a/include/linux/soundwire/sdw_type.h b/include/linux/soundwire/sdw_type.h
index 52eb66cd11bc..25ab91f5c6be 100644
--- a/include/linux/soundwire/sdw_type.h
+++ b/include/linux/soundwire/sdw_type.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: GPL-2.0-only */
 /* Copyright(c) 2015-17 Intel Corporation. */
 
 #ifndef __SOUNDWIRE_TYPES_H
-- 
2.17.1

