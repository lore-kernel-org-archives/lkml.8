Return-Path: <SRS0=C9WH=4E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E42EC76199
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 03:33:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50E882073A
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 03:33:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbgBPDd0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Feb 2020 22:33:26 -0500
Received: from inva021.nxp.com ([92.121.34.21]:34240 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726651AbgBPDd0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Feb 2020 22:33:26 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 3373B201940;
        Sun, 16 Feb 2020 04:33:24 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 37A5E200CC3;
        Sun, 16 Feb 2020 04:33:21 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 3A3104029B;
        Sun, 16 Feb 2020 11:33:17 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH] rtc: snvs: Remove unused include of of_device.h
Date:   Sun, 16 Feb 2020 11:27:45 +0800
Message-Id: <1581823666-16944-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is nothing in use from of_device.h, remove it.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/rtc/rtc-snvs.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/rtc/rtc-snvs.c b/drivers/rtc/rtc-snvs.c
index 757f4da..7630089 100644
--- a/drivers/rtc/rtc-snvs.c
+++ b/drivers/rtc/rtc-snvs.c
@@ -7,7 +7,6 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pm_wakeirq.h>
 #include <linux/rtc.h>
-- 
2.7.4

