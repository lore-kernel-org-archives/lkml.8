Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A78DC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 06:06:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A0CC206E2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 06:06:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbgFAGGP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 02:06:15 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:43940 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725965AbgFAGGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 02:06:14 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R521e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01422;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0U-Ax0ff_1590991567;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0U-Ax0ff_1590991567)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 01 Jun 2020 14:06:07 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, orsonzhai@gmail.com
Cc:     zhang.lyra@gmail.com, baolin.wang7@gmail.com,
        baolin.wang@linux.alibaba.com, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] hwspinlock: sprd: Remove redundant header files
Date:   Mon,  1 Jun 2020 14:05:52 +0800
Message-Id: <1590991552-93643-1-git-send-email-baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove redundant header files.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 drivers/hwspinlock/sprd_hwspinlock.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/hwspinlock/sprd_hwspinlock.c b/drivers/hwspinlock/sprd_hwspinlock.c
index 36dc803..b157495 100644
--- a/drivers/hwspinlock/sprd_hwspinlock.c
+++ b/drivers/hwspinlock/sprd_hwspinlock.c
@@ -4,7 +4,6 @@
  * Copyright (C) 2017 Spreadtrum  - http://www.spreadtrum.com
  */
 
-#include <linux/bitops.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/device.h>
@@ -15,7 +14,6 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
-#include <linux/slab.h>
 
 #include "hwspinlock_internal.h"
 
-- 
1.8.3.1

