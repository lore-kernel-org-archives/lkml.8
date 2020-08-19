Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7763AC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 11:29:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CBEE207BB
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 11:29:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbgHSL27 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 07:28:59 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:9776 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728106AbgHSL2d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 07:28:33 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 65B808222144AFFC17C0;
        Wed, 19 Aug 2020 19:28:32 +0800 (CST)
Received: from huawei.com (10.175.113.133) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Wed, 19 Aug 2020
 19:28:27 +0800
From:   Wang Hai <wanghai38@huawei.com>
To:     <ysato@users.sourceforge.jp>, <dalias@libc.org>,
        <linux-sh@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] sh: mach-sh03: remove duplicate include
Date:   Wed, 19 Aug 2020 19:26:17 +0800
Message-ID: <20200819112617.6015-1-wanghai38@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.113.133]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove linux/rtc.h which is included more than once

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wang Hai <wanghai38@huawei.com>
---
 arch/sh/boards/mach-sh03/rtc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/sh/boards/mach-sh03/rtc.c b/arch/sh/boards/mach-sh03/rtc.c
index 8b23ed7c201c..165e2ccaab4d 100644
--- a/arch/sh/boards/mach-sh03/rtc.c
+++ b/arch/sh/boards/mach-sh03/rtc.c
@@ -14,7 +14,6 @@
 #include <linux/rtc.h>
 #include <linux/spinlock.h>
 #include <linux/io.h>
-#include <linux/rtc.h>
 #include <linux/platform_device.h>
 
 #define RTC_BASE	0xb0000000
-- 
2.17.1

