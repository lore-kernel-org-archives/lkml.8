Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0012FC433ED
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 14:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC21820709
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 14:59:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729552AbgGWO75 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 10:59:57 -0400
Received: from mga09.intel.com ([134.134.136.24]:50088 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729516AbgGWO7u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 10:59:50 -0400
IronPort-SDR: 7vzeljEVqcEpeGUds1RIMls+elW+Q3XCZtI2QbNIkVCNglwM+xrVpxigK0af9OmJzHUCodPGrK
 P2RvJSi8tPRg==
X-IronPort-AV: E=McAfee;i="6000,8403,9690"; a="151839039"
X-IronPort-AV: E=Sophos;i="5.75,386,1589266800"; 
   d="scan'208";a="151839039"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2020 07:59:49 -0700
IronPort-SDR: LgnjdUVQexeR+PkGRmSkul40LHMRb1AI4AlvfpZuNfKRslOSybQtINI8gmlF7Gpin2bpEQe6WX
 pRv6rHHDz6WQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,386,1589266800"; 
   d="scan'208";a="311051223"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.138])
  by fmsmga004.fm.intel.com with ESMTP; 23 Jul 2020 07:59:47 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [char-misc-next 5/6] mei: hw: use sizeof of variable instead of struct type
Date:   Thu, 23 Jul 2020 17:59:26 +0300
Message-Id: <20200723145927.882743-6-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200723145927.882743-1-tomas.winkler@intel.com>
References: <20200723145927.882743-1-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use sizeof(*dev) + sizeof(*hw) instead of
sizeof(struct mei_device) + sizeof(struct mei_me_hw)

There is a possibility of bug when variable type has changed but
corresponding struct passed to the sizeof has not.

Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/misc/mei/hw-me.c  | 5 ++---
 drivers/misc/mei/hw-txe.c | 5 ++---
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/mei/hw-me.c b/drivers/misc/mei/hw-me.c
index c51d3da8f333..7692b69abcb5 100644
--- a/drivers/misc/mei/hw-me.c
+++ b/drivers/misc/mei/hw-me.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright (c) 2003-2019, Intel Corporation. All rights reserved.
+ * Copyright (c) 2003-2020, Intel Corporation. All rights reserved.
  * Intel Management Engine Interface (Intel MEI) Linux driver
  */
 
@@ -1600,8 +1600,7 @@ struct mei_device *mei_me_dev_init(struct device *parent,
 	struct mei_me_hw *hw;
 	int i;
 
-	dev = devm_kzalloc(parent, sizeof(struct mei_device) +
-			   sizeof(struct mei_me_hw), GFP_KERNEL);
+	dev = devm_kzalloc(parent, sizeof(*dev) + sizeof(*hw), GFP_KERNEL);
 	if (!dev)
 		return NULL;
 
diff --git a/drivers/misc/mei/hw-txe.c b/drivers/misc/mei/hw-txe.c
index 785b260b3ae9..a4e854b9b9e6 100644
--- a/drivers/misc/mei/hw-txe.c
+++ b/drivers/misc/mei/hw-txe.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright (c) 2013-2019, Intel Corporation. All rights reserved.
+ * Copyright (c) 2013-2020, Intel Corporation. All rights reserved.
  * Intel Management Engine Interface (Intel MEI) Linux driver
  */
 
@@ -1201,8 +1201,7 @@ struct mei_device *mei_txe_dev_init(struct pci_dev *pdev)
 	struct mei_device *dev;
 	struct mei_txe_hw *hw;
 
-	dev = devm_kzalloc(&pdev->dev, sizeof(struct mei_device) +
-			   sizeof(struct mei_txe_hw), GFP_KERNEL);
+	dev = devm_kzalloc(&pdev->dev, sizeof(*dev) + sizeof(*hw), GFP_KERNEL);
 	if (!dev)
 		return NULL;
 
-- 
2.25.4

