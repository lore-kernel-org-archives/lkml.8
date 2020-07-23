Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6CF8C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 14:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2115208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 14:59:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729533AbgGWO7u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 10:59:50 -0400
Received: from mga09.intel.com ([134.134.136.24]:50088 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729471AbgGWO7r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 10:59:47 -0400
IronPort-SDR: kmbRv2b1ApX5x6PWsy+YORO6zoI1nfNpbcW8d9twlfY3ar1auo5X4ElfBypkDuo0sVPTcybw4M
 4qP1BGq48SYQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9690"; a="151839035"
X-IronPort-AV: E=Sophos;i="5.75,386,1589266800"; 
   d="scan'208";a="151839035"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2020 07:59:47 -0700
IronPort-SDR: gwpzmg9c53jfxnnX6yQrdjYo1MydZpLxCQ96VsUjluu4n7XeLRknM7J/jfvewWqyL19bprePu7
 ds++qHE2MgcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,386,1589266800"; 
   d="scan'208";a="311051210"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.138])
  by fmsmga004.fm.intel.com with ESMTP; 23 Jul 2020 07:59:45 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [char-misc-next 4/6] mei: client: use sizeof of variable instead of struct type
Date:   Thu, 23 Jul 2020 17:59:25 +0300
Message-Id: <20200723145927.882743-5-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200723145927.882743-1-tomas.winkler@intel.com>
References: <20200723145927.882743-1-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a possibility of bug when variable type has changed but
corresponding struct passed to the sizeof has not.

Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/misc/mei/client.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/mei/client.c b/drivers/misc/mei/client.c
index b32c825a0945..2572887d99b6 100644
--- a/drivers/misc/mei/client.c
+++ b/drivers/misc/mei/client.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright (c) 2003-2019, Intel Corporation. All rights reserved.
+ * Copyright (c) 2003-2020, Intel Corporation. All rights reserved.
  * Intel Management Engine Interface (Intel MEI) Linux driver
  */
 
@@ -369,7 +369,7 @@ static struct mei_cl_cb *mei_io_cb_init(struct mei_cl *cl,
 {
 	struct mei_cl_cb *cb;
 
-	cb = kzalloc(sizeof(struct mei_cl_cb), GFP_KERNEL);
+	cb = kzalloc(sizeof(*cb), GFP_KERNEL);
 	if (!cb)
 		return NULL;
 
@@ -552,7 +552,7 @@ int mei_cl_flush_queues(struct mei_cl *cl, const struct file *fp)
  */
 static void mei_cl_init(struct mei_cl *cl, struct mei_device *dev)
 {
-	memset(cl, 0, sizeof(struct mei_cl));
+	memset(cl, 0, sizeof(*cl));
 	init_waitqueue_head(&cl->wait);
 	init_waitqueue_head(&cl->rx_wait);
 	init_waitqueue_head(&cl->tx_wait);
@@ -575,7 +575,7 @@ struct mei_cl *mei_cl_allocate(struct mei_device *dev)
 {
 	struct mei_cl *cl;
 
-	cl = kmalloc(sizeof(struct mei_cl), GFP_KERNEL);
+	cl = kmalloc(sizeof(*cl), GFP_KERNEL);
 	if (!cl)
 		return NULL;
 
-- 
2.25.4

