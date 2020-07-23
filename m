Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1404FC433EA
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 14:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECC1C208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 14:59:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729495AbgGWO7q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 10:59:46 -0400
Received: from mga09.intel.com ([134.134.136.24]:50088 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729471AbgGWO7n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 10:59:43 -0400
IronPort-SDR: m6Har90y6gD0BdJ5DWG9AVm2eoE0NalWau6FjY5ahwzkInvnWY50zzBnn5fTiGDYLQo6r5mhM+
 +M+X3uIKe4xg==
X-IronPort-AV: E=McAfee;i="6000,8403,9690"; a="151839019"
X-IronPort-AV: E=Sophos;i="5.75,386,1589266800"; 
   d="scan'208";a="151839019"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2020 07:59:43 -0700
IronPort-SDR: StcE0bSg8qHZFrbi+u65usLAWxIOiou07afJRHhIQaB3TbGAo1wa+NDQ2wW+ewNqEC34kFkjAb
 RSkkAiY1HSGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,386,1589266800"; 
   d="scan'208";a="311051190"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.138])
  by fmsmga004.fm.intel.com with ESMTP; 23 Jul 2020 07:59:41 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [char-misc-next 2/6] mei: ioctl: use sizeof of variable instead of struct type
Date:   Thu, 23 Jul 2020 17:59:23 +0300
Message-Id: <20200723145927.882743-3-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200723145927.882743-1-tomas.winkler@intel.com>
References: <20200723145927.882743-1-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use sizeof(connect_data))) instead of
sizeof(struct mei_connect_client_data) when copying data
between user space and kernel.

There is a possibility of bug when variable type has changed but
corresponding struct passed to the sizeof has not.

Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/misc/mei/main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/mei/main.c b/drivers/misc/mei/main.c
index f17297f2943d..05e6ad6d4d54 100644
--- a/drivers/misc/mei/main.c
+++ b/drivers/misc/mei/main.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright (c) 2003-2018, Intel Corporation. All rights reserved.
+ * Copyright (c) 2003-2020, Intel Corporation. All rights reserved.
  * Intel Management Engine Interface (Intel MEI) Linux driver
  */
 
@@ -476,7 +476,7 @@ static long mei_ioctl(struct file *file, unsigned int cmd, unsigned long data)
 	case IOCTL_MEI_CONNECT_CLIENT:
 		dev_dbg(dev->dev, ": IOCTL_MEI_CONNECT_CLIENT.\n");
 		if (copy_from_user(&connect_data, (char __user *)data,
-				sizeof(struct mei_connect_client_data))) {
+				   sizeof(connect_data))) {
 			dev_dbg(dev->dev, "failed to copy data from userland\n");
 			rets = -EFAULT;
 			goto out;
@@ -488,7 +488,7 @@ static long mei_ioctl(struct file *file, unsigned int cmd, unsigned long data)
 
 		/* if all is ok, copying the data back to user. */
 		if (copy_to_user((char __user *)data, &connect_data,
-				sizeof(struct mei_connect_client_data))) {
+				 sizeof(connect_data))) {
 			dev_dbg(dev->dev, "failed to copy data to userland\n");
 			rets = -EFAULT;
 			goto out;
-- 
2.25.4

