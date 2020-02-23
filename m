Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14896C35671
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 20:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB13B206E0
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 20:44:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbgBWUoY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 15:44:24 -0500
Received: from mga18.intel.com ([134.134.136.126]:27677 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726302AbgBWUoY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 15:44:24 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Feb 2020 12:44:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,477,1574150400"; 
   d="scan'208";a="230436248"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.155])
  by orsmga008.jf.intel.com with ESMTP; 23 Feb 2020 12:44:22 -0800
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next] mei: remove unused includes from pci-{me,txe}.c
Date:   Sun, 23 Feb 2020 22:44:19 +0200
Message-Id: <20200223204419.2634-1-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During the development some of the module functions were factored
out of pci-mei.c and pci-txe.c files, but the includes
have remain there. We can remove them now.

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/misc/mei/pci-me.c  | 11 +----------
 drivers/misc/mei/pci-txe.c |  5 +----
 2 files changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/misc/mei/pci-me.c b/drivers/misc/mei/pci-me.c
index 2711451b3d87..f51e5326b8bd 100644
--- a/drivers/misc/mei/pci-me.c
+++ b/drivers/misc/mei/pci-me.c
@@ -1,25 +1,16 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright (c) 2003-2019, Intel Corporation. All rights reserved.
+ * Copyright (c) 2003-2020, Intel Corporation. All rights reserved.
  * Intel Management Engine Interface (Intel MEI) Linux driver
  */
 
 #include <linux/module.h>
-#include <linux/moduleparam.h>
 #include <linux/kernel.h>
 #include <linux/device.h>
-#include <linux/fs.h>
 #include <linux/errno.h>
 #include <linux/types.h>
-#include <linux/fcntl.h>
 #include <linux/pci.h>
-#include <linux/poll.h>
-#include <linux/ioctl.h>
-#include <linux/cdev.h>
 #include <linux/sched.h>
-#include <linux/uuid.h>
-#include <linux/compat.h>
-#include <linux/jiffies.h>
 #include <linux/interrupt.h>
 
 #include <linux/pm_domain.h>
diff --git a/drivers/misc/mei/pci-txe.c b/drivers/misc/mei/pci-txe.c
index f1c16a587495..beacf2a2f2b5 100644
--- a/drivers/misc/mei/pci-txe.c
+++ b/drivers/misc/mei/pci-txe.c
@@ -1,20 +1,17 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright (c) 2013-2017, Intel Corporation. All rights reserved.
+ * Copyright (c) 2013-2020, Intel Corporation. All rights reserved.
  * Intel Management Engine Interface (Intel MEI) Linux driver
  */
 
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/device.h>
-#include <linux/fs.h>
 #include <linux/errno.h>
 #include <linux/types.h>
 #include <linux/pci.h>
 #include <linux/init.h>
 #include <linux/sched.h>
-#include <linux/uuid.h>
-#include <linux/jiffies.h>
 #include <linux/interrupt.h>
 #include <linux/workqueue.h>
 #include <linux/pm_domain.h>
-- 
2.21.1

