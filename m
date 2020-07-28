Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D59A2C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 17:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD91B20825
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 17:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595956746;
	bh=bM7CttTx2inQru+0qSBCK2LAYwqEhSZiejev6ND6HJA=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=S5EsEfUuQLA6iYLHHLkyCwD7kayLw6oYpBblA/7dnEH7fgfAGuTYzB3RPQkfUYVbS
	 4zbMdXmlzPh8hwBMuX7/OJneiw0SfdCHN+rkr6/I8/Yd1Q3KjQAhg8x6oQujx5PqUa
	 2YOsnfdFpNvQt3rq0Hz0B3h9zNbUTVZZhE7i4JrM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731933AbgG1RTF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 13:19:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:38306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731684AbgG1RTE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 13:19:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 83DAB20809;
        Tue, 28 Jul 2020 17:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595956744;
        bh=bM7CttTx2inQru+0qSBCK2LAYwqEhSZiejev6ND6HJA=;
        h=From:To:Cc:Subject:Date:From;
        b=fI9BBAyD17FvnfxHURgATv47Zvwd2SNMntJ+T+7t6wHM6GeFPe0XZINTSRkZWZ6VW
         elNlB0mVaC36d+Nh79cZ08lkq4nZImfwGt7yFO8pgd6TdWt4OpatV/AV2aGB+p/KU8
         beF8hwWYiiJxdpoKyX/uBBviAs67RANCf9QicC2c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        Omer Shpigelman <oshpigelman@habana.ai>,
        Tomer Tayar <ttayar@habana.ai>,
        Moti Haimovski <mhaimovski@habana.ai>,
        Ofir Bitton <obitton@habana.ai>,
        Ben Segal <bpsegal20@gmail.com>,
        Christine Gharzuzi <cgharzuzi@habana.ai>,
        Pawel Piskorski <ppiskorski@habana.ai>
Subject: [PATCH] habanalabs: fix up absolute include instructions
Date:   Tue, 28 Jul 2020 19:18:51 +0200
Message-Id: <20200728171851.55842-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no need to try to be cute with the include file locations in the
Makefile, so just specify exactly where the files are.

Bonus is this fixes the problem of building with O= as well as trying to
just build the subdirectory alone.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Oded Gabbay <oded.gabbay@gmail.com>
Cc: Omer Shpigelman <oshpigelman@habana.ai>
Cc: Tomer Tayar <ttayar@habana.ai>
Cc: Moti Haimovski <mhaimovski@habana.ai>
Cc: Ofir Bitton <obitton@habana.ai>
Cc: Ben Segal <bpsegal20@gmail.com>
Cc: Christine Gharzuzi <cgharzuzi@habana.ai>
Cc: Pawel Piskorski <ppiskorski@habana.ai>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/misc/habanalabs/common/Makefile         |  2 --
 drivers/misc/habanalabs/common/debugfs.c        |  2 +-
 drivers/misc/habanalabs/common/firmware_if.c    |  2 +-
 drivers/misc/habanalabs/common/habanalabs.h     |  4 ++--
 drivers/misc/habanalabs/common/memory.c         |  2 +-
 drivers/misc/habanalabs/common/mmu.c            |  2 +-
 drivers/misc/habanalabs/common/pci.c            |  2 +-
 drivers/misc/habanalabs/gaudi/Makefile          |  2 --
 drivers/misc/habanalabs/gaudi/gaudi.c           | 12 ++++++------
 drivers/misc/habanalabs/gaudi/gaudiP.h          | 10 +++++-----
 drivers/misc/habanalabs/gaudi/gaudi_coresight.c |  6 +++---
 drivers/misc/habanalabs/gaudi/gaudi_hwmgr.c     |  2 +-
 drivers/misc/habanalabs/gaudi/gaudi_security.c  |  2 +-
 drivers/misc/habanalabs/goya/Makefile           |  2 --
 drivers/misc/habanalabs/goya/goya.c             |  8 ++++----
 drivers/misc/habanalabs/goya/goyaP.h            | 12 ++++++------
 drivers/misc/habanalabs/goya/goya_coresight.c   |  6 +++---
 drivers/misc/habanalabs/goya/goya_security.c    |  2 +-
 18 files changed, 37 insertions(+), 43 deletions(-)

diff --git a/drivers/misc/habanalabs/common/Makefile b/drivers/misc/habanalabs/common/Makefile
index 97d03b5c8683..b984bfa4face 100644
--- a/drivers/misc/habanalabs/common/Makefile
+++ b/drivers/misc/habanalabs/common/Makefile
@@ -1,6 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
-subdir-ccflags-y += -I$(src)/common
-
 HL_COMMON_FILES := common/habanalabs_drv.o common/device.o common/context.o \
 		common/asid.o common/habanalabs_ioctl.o \
 		common/command_buffer.o common/hw_queue.o common/irq.o \
diff --git a/drivers/misc/habanalabs/common/debugfs.c b/drivers/misc/habanalabs/common/debugfs.c
index 0bc036e01ee8..c50c6fc9e905 100644
--- a/drivers/misc/habanalabs/common/debugfs.c
+++ b/drivers/misc/habanalabs/common/debugfs.c
@@ -6,7 +6,7 @@
  */
 
 #include "habanalabs.h"
-#include "include/hw_ip/mmu/mmu_general.h"
+#include "../include/hw_ip/mmu/mmu_general.h"
 
 #include <linux/pci.h>
 #include <linux/debugfs.h>
diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index 5981dbd8c6df..f70302cdab1b 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -6,7 +6,7 @@
  */
 
 #include "habanalabs.h"
-#include "include/common/hl_boot_if.h"
+#include "../include/common/hl_boot_if.h"
 
 #include <linux/firmware.h>
 #include <linux/genalloc.h>
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index eb42aa5476a9..018d9d67e8e6 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -8,8 +8,8 @@
 #ifndef HABANALABSP_H_
 #define HABANALABSP_H_
 
-#include "include/common/armcp_if.h"
-#include "include/common/qman_if.h"
+#include "../include/common/armcp_if.h"
+#include "../include/common/qman_if.h"
 #include <uapi/misc/habanalabs.h>
 
 #include <linux/cdev.h>
diff --git a/drivers/misc/habanalabs/common/memory.c b/drivers/misc/habanalabs/common/memory.c
index e4e1693e5c6c..dce9273e557a 100644
--- a/drivers/misc/habanalabs/common/memory.c
+++ b/drivers/misc/habanalabs/common/memory.c
@@ -7,7 +7,7 @@
 
 #include <uapi/misc/habanalabs.h>
 #include "habanalabs.h"
-#include "include/hw_ip/mmu/mmu_general.h"
+#include "../include/hw_ip/mmu/mmu_general.h"
 
 #include <linux/uaccess.h>
 #include <linux/slab.h>
diff --git a/drivers/misc/habanalabs/common/mmu.c b/drivers/misc/habanalabs/common/mmu.c
index 04303950e630..edcc11d5eaf1 100644
--- a/drivers/misc/habanalabs/common/mmu.c
+++ b/drivers/misc/habanalabs/common/mmu.c
@@ -6,7 +6,7 @@
  */
 
 #include "habanalabs.h"
-#include "include/hw_ip/mmu/mmu_general.h"
+#include "../include/hw_ip/mmu/mmu_general.h"
 
 #include <linux/genalloc.h>
 #include <linux/slab.h>
diff --git a/drivers/misc/habanalabs/common/pci.c b/drivers/misc/habanalabs/common/pci.c
index 1791f6623c69..7bd3737571f3 100644
--- a/drivers/misc/habanalabs/common/pci.c
+++ b/drivers/misc/habanalabs/common/pci.c
@@ -6,7 +6,7 @@
  */
 
 #include "habanalabs.h"
-#include "include/hw_ip/pci/pci_general.h"
+#include "../include/hw_ip/pci/pci_general.h"
 
 #include <linux/pci.h>
 #include <linux/bitfield.h>
diff --git a/drivers/misc/habanalabs/gaudi/Makefile b/drivers/misc/habanalabs/gaudi/Makefile
index 75104ae74e2b..c9f4703cff24 100644
--- a/drivers/misc/habanalabs/gaudi/Makefile
+++ b/drivers/misc/habanalabs/gaudi/Makefile
@@ -1,5 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
-subdir-ccflags-y += -I$(src)/common
-
 HL_GAUDI_FILES := gaudi/gaudi.o gaudi/gaudi_hwmgr.o gaudi/gaudi_security.o \
 	gaudi/gaudi_coresight.o
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 78fbff646f99..d4b3b995f69d 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -6,12 +6,12 @@
  */
 
 #include "gaudiP.h"
-#include "include/hw_ip/mmu/mmu_general.h"
-#include "include/hw_ip/mmu/mmu_v1_1.h"
-#include "include/gaudi/gaudi_masks.h"
-#include "include/gaudi/gaudi_fw_if.h"
-#include "include/gaudi/gaudi_reg_map.h"
-#include "include/gaudi/gaudi_async_ids_map_extended.h"
+#include "../include/hw_ip/mmu/mmu_general.h"
+#include "../include/hw_ip/mmu/mmu_v1_1.h"
+#include "../include/gaudi/gaudi_masks.h"
+#include "../include/gaudi/gaudi_fw_if.h"
+#include "../include/gaudi/gaudi_reg_map.h"
+#include "../include/gaudi/gaudi_async_ids_map_extended.h"
 
 #include <linux/module.h>
 #include <linux/pci.h>
diff --git a/drivers/misc/habanalabs/gaudi/gaudiP.h b/drivers/misc/habanalabs/gaudi/gaudiP.h
index a94ab6a180f0..5dc99f6f0296 100644
--- a/drivers/misc/habanalabs/gaudi/gaudiP.h
+++ b/drivers/misc/habanalabs/gaudi/gaudiP.h
@@ -9,11 +9,11 @@
 #define GAUDIP_H_
 
 #include <uapi/misc/habanalabs.h>
-#include "habanalabs.h"
-#include "include/common/hl_boot_if.h"
-#include "include/gaudi/gaudi_packets.h"
-#include "include/gaudi/gaudi.h"
-#include "include/gaudi/gaudi_async_events.h"
+#include "../common/habanalabs.h"
+#include "../include/common/hl_boot_if.h"
+#include "../include/gaudi/gaudi_packets.h"
+#include "../include/gaudi/gaudi.h"
+#include "../include/gaudi/gaudi_async_events.h"
 
 #define NUMBER_OF_EXT_HW_QUEUES		12
 #define NUMBER_OF_CMPLT_QUEUES		NUMBER_OF_EXT_HW_QUEUES
diff --git a/drivers/misc/habanalabs/gaudi/gaudi_coresight.c b/drivers/misc/habanalabs/gaudi/gaudi_coresight.c
index c32322cb1728..5673ee49819e 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi_coresight.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi_coresight.c
@@ -6,9 +6,9 @@
  */
 
 #include "gaudiP.h"
-#include "include/gaudi/gaudi_coresight.h"
-#include "include/gaudi/asic_reg/gaudi_regs.h"
-#include "include/gaudi/gaudi_masks.h"
+#include "../include/gaudi/gaudi_coresight.h"
+#include "../include/gaudi/asic_reg/gaudi_regs.h"
+#include "../include/gaudi/gaudi_masks.h"
 
 #include <uapi/misc/habanalabs.h>
 #include <linux/coresight.h>
diff --git a/drivers/misc/habanalabs/gaudi/gaudi_hwmgr.c b/drivers/misc/habanalabs/gaudi/gaudi_hwmgr.c
index 6dd2c2a1cd70..1076b4932ce2 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi_hwmgr.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi_hwmgr.c
@@ -6,7 +6,7 @@
  */
 
 #include "gaudiP.h"
-#include "include/gaudi/gaudi_fw_if.h"
+#include "../include/gaudi/gaudi_fw_if.h"
 
 void gaudi_set_pll_profile(struct hl_device *hdev, enum hl_pll_frequency freq)
 {
diff --git a/drivers/misc/habanalabs/gaudi/gaudi_security.c b/drivers/misc/habanalabs/gaudi/gaudi_security.c
index abdd5ed8f2cf..8d5d6ddee6ed 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi_security.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi_security.c
@@ -6,7 +6,7 @@
  */
 
 #include "gaudiP.h"
-#include "include/gaudi/asic_reg/gaudi_regs.h"
+#include "../include/gaudi/asic_reg/gaudi_regs.h"
 
 #define GAUDI_NUMBER_OF_RR_REGS		24
 #define GAUDI_NUMBER_OF_LBW_RANGES	12
diff --git a/drivers/misc/habanalabs/goya/Makefile b/drivers/misc/habanalabs/goya/Makefile
index bd769083628e..b3f3b7b96683 100644
--- a/drivers/misc/habanalabs/goya/Makefile
+++ b/drivers/misc/habanalabs/goya/Makefile
@@ -1,5 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
-subdir-ccflags-y += -I$(src)
-
 HL_GOYA_FILES :=  goya/goya.o goya/goya_security.o goya/goya_hwmgr.o \
 	goya/goya_coresight.o
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index a4dfea7556da..dedcd2211fb7 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -6,10 +6,10 @@
  */
 
 #include "goyaP.h"
-#include "include/hw_ip/mmu/mmu_general.h"
-#include "include/hw_ip/mmu/mmu_v1_0.h"
-#include "include/goya/asic_reg/goya_masks.h"
-#include "include/goya/goya_reg_map.h"
+#include "../include/hw_ip/mmu/mmu_general.h"
+#include "../include/hw_ip/mmu/mmu_v1_0.h"
+#include "../include/goya/asic_reg/goya_masks.h"
+#include "../include/goya/goya_reg_map.h"
 
 #include <linux/pci.h>
 #include <linux/genalloc.h>
diff --git a/drivers/misc/habanalabs/goya/goyaP.h b/drivers/misc/habanalabs/goya/goyaP.h
index 9e674cf39fd9..bb7474ee9784 100644
--- a/drivers/misc/habanalabs/goya/goyaP.h
+++ b/drivers/misc/habanalabs/goya/goyaP.h
@@ -9,12 +9,12 @@
 #define GOYAP_H_
 
 #include <uapi/misc/habanalabs.h>
-#include "habanalabs.h"
-#include "include/common/hl_boot_if.h"
-#include "include/goya/goya_packets.h"
-#include "include/goya/goya.h"
-#include "include/goya/goya_async_events.h"
-#include "include/goya/goya_fw_if.h"
+#include "../common/habanalabs.h"
+#include "../include/common/hl_boot_if.h"
+#include "../include/goya/goya_packets.h"
+#include "../include/goya/goya.h"
+#include "../include/goya/goya_async_events.h"
+#include "../include/goya/goya_fw_if.h"
 
 #define NUMBER_OF_CMPLT_QUEUES		5
 #define NUMBER_OF_EXT_HW_QUEUES		5
diff --git a/drivers/misc/habanalabs/goya/goya_coresight.c b/drivers/misc/habanalabs/goya/goya_coresight.c
index 18e12e9d284b..b03912483de0 100644
--- a/drivers/misc/habanalabs/goya/goya_coresight.c
+++ b/drivers/misc/habanalabs/goya/goya_coresight.c
@@ -6,9 +6,9 @@
  */
 
 #include "goyaP.h"
-#include "include/goya/goya_coresight.h"
-#include "include/goya/asic_reg/goya_regs.h"
-#include "include/goya/asic_reg/goya_masks.h"
+#include "../include/goya/goya_coresight.h"
+#include "../include/goya/asic_reg/goya_regs.h"
+#include "../include/goya/asic_reg/goya_masks.h"
 
 #include <uapi/misc/habanalabs.h>
 
diff --git a/drivers/misc/habanalabs/goya/goya_security.c b/drivers/misc/habanalabs/goya/goya_security.c
index de8297001fea..14701836f92b 100644
--- a/drivers/misc/habanalabs/goya/goya_security.c
+++ b/drivers/misc/habanalabs/goya/goya_security.c
@@ -6,7 +6,7 @@
  */
 
 #include "goyaP.h"
-#include "include/goya/asic_reg/goya_regs.h"
+#include "../include/goya/asic_reg/goya_regs.h"
 
 /*
  * goya_set_block_as_protected - set the given block as protected
-- 
2.27.0

