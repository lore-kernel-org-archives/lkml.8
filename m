Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AABE8C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 07:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83AA921D94
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 07:07:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728677AbgDQHHu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 03:07:50 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2389 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728105AbgDQHHu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 03:07:50 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 37AB0F6534BED5201DE4;
        Fri, 17 Apr 2020 15:07:48 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Fri, 17 Apr 2020
 15:07:40 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <gregkh@linuxfoundation.org>, <devel@driverdev.osuosl.org>,
        <linux-kernel@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>, Hulk Robot <hulkci@huawei.com>
Subject: [PATCH] staging: rtl8723bs: remove some variables in hal_btcoex.c
Date:   Fri, 17 Apr 2020 15:33:10 +0800
Message-ID: <20200417073310.40893-1-yanaijie@huawei.com>
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

drivers/staging/rtl8723bs/hal/hal_btcoex.c:45:26: warning: ‘ioStaString’
defined but not used [-Wunused-const-variable=]
 static const char *const ioStaString[] = {
                          ^~~~~~~~~~~
drivers/staging/rtl8723bs/hal/hal_btcoex.c:38:26: warning:
‘h2cStaString’ defined but not used [-Wunused-const-variable=]
 static const char *const h2cStaString[] = {
                          ^~~~~~~~~~~~
drivers/staging/rtl8723bs/hal/hal_btcoex.c:33:26: warning:
‘BtLinkRoleString’ defined but not used [-Wunused-const-variable=]
 static const char *const BtLinkRoleString[] = {
                          ^~~~~~~~~~~~~~~~
drivers/staging/rtl8723bs/hal/hal_btcoex.c:23:26: warning:
‘BtSpecString’ defined but not used [-Wunused-const-variable=]
 static const char *const BtSpecString[] = {
                          ^~~~~~~~~~~~
drivers/staging/rtl8723bs/hal/hal_btcoex.c:15:26: warning:
‘BtProfileString’ defined but not used [-Wunused-const-variable=]
 static const char *const BtProfileString[] = {
                          ^~~~~~~~~~~~~~~

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/staging/rtl8723bs/hal/hal_btcoex.c | 43 ----------------------
 1 file changed, 43 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_btcoex.c b/drivers/staging/rtl8723bs/hal/hal_btcoex.c
index d5793e4614bf..a6ed1bb9945e 100644
--- a/drivers/staging/rtl8723bs/hal/hal_btcoex.c
+++ b/drivers/staging/rtl8723bs/hal/hal_btcoex.c
@@ -12,49 +12,6 @@
 #include <Mp_Precomp.h>
 
 /* 		Global variables */
-static const char *const BtProfileString[] = {
-	"NONE",
-	"A2DP",
-	"PAN",
-	"HID",
-	"SCO",
-};
-
-static const char *const BtSpecString[] = {
-	"1.0b",
-	"1.1",
-	"1.2",
-	"2.0+EDR",
-	"2.1+EDR",
-	"3.0+HS",
-	"4.0",
-};
-
-static const char *const BtLinkRoleString[] = {
-	"Master",
-	"Slave",
-};
-
-static const char *const h2cStaString[] = {
-	"successful",
-	"h2c busy",
-	"rf off",
-	"fw not read",
-};
-
-static const char *const ioStaString[] = {
-	"success",
-	"can not IO",
-	"rf off",
-	"fw not read",
-	"wait io timeout",
-	"invalid len",
-	"idle Q empty",
-	"insert waitQ fail",
-	"unknown fail",
-	"wrong level",
-	"h2c stopped",
-};
 
 BTC_COEXIST GLBtCoexist;
 static u8 GLBtcWiFiInScanState;
-- 
2.21.1

