Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D3CC2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 07:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F3A221D94
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 07:08:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728726AbgDQHIX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 03:08:23 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:40684 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728449AbgDQHIW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 03:08:22 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B3121971BA29CF053A3;
        Fri, 17 Apr 2020 15:08:21 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Fri, 17 Apr 2020
 15:08:13 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <gregkh@linuxfoundation.org>, <nishkadg.linux@gmail.com>,
        <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>, Hulk Robot <hulkci@huawei.com>
Subject: [PATCH] staging: rtl8723bs: remove defined but not used 'dB_Invert_Table'
Date:   Fri, 17 Apr 2020 15:34:39 +0800
Message-ID: <20200417073439.41888-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following gcc warning:

drivers/staging/rtl8723bs/hal/odm.c:10:18: warning: ‘dB_Invert_Table’
defined but not used [-Wunused-const-variable=]
 static const u16 dB_Invert_Table[8][12] = {
                  ^~~~~~~~~~~~~~~

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/staging/rtl8723bs/hal/odm.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/odm.c b/drivers/staging/rtl8723bs/hal/odm.c
index aa6631ee4ea7..f2a9e95a1563 100644
--- a/drivers/staging/rtl8723bs/hal/odm.c
+++ b/drivers/staging/rtl8723bs/hal/odm.c
@@ -7,19 +7,6 @@
 
 #include "odm_precomp.h"
 
-static const u16 dB_Invert_Table[8][12] = {
-	{1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 4, 4},
-	{4, 5, 6, 6, 7, 8, 9, 10, 11, 13, 14, 16},
-	{18, 20, 22, 25, 28, 32, 35, 40, 45, 50, 56, 63},
-	{71, 79, 89, 100, 112, 126, 141, 158, 178, 200, 224, 251},
-	{282, 316, 355, 398, 447, 501, 562, 631, 708, 794, 891, 1000},
-	{1122, 1259, 1413, 1585, 1778, 1995, 2239, 2512, 2818, 3162, 3548, 3981},
-	{4467, 5012, 5623, 6310, 7079, 7943, 8913, 10000, 11220, 12589, 14125,
-	 15849},
-	{17783, 19953, 22387, 25119, 28184, 31623, 35481, 39811, 44668, 50119,
-	 56234, 65535}
- };
-
 /*  Global var */
 
 u32 OFDMSwingTable[OFDM_TABLE_SIZE] = {
-- 
2.21.1

