Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D1DAC47247
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 05:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2831F208D6
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 05:54:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbgEHFyJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 01:54:09 -0400
Received: from inva020.nxp.com ([92.121.34.13]:50658 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725865AbgEHFyJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 01:54:09 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 7B7731A12CB;
        Fri,  8 May 2020 07:54:06 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id F06EA1A077F;
        Fri,  8 May 2020 07:54:01 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 0A06A40288;
        Fri,  8 May 2020 13:53:55 +0800 (SGT)
From:   Biwen Li <biwen.li@oss.nxp.com>
To:     leoyang.li@nxp.com, robh+dt@kernel.org, mpe@ellerman.id.au,
        benh@kernel.crashing.org, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com
Cc:     devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        Biwen Li <biwen.li@nxp.com>
Subject: [PATCH 1/3] rtc: ds1374: add uie_unsupported property to drop warning
Date:   Fri,  8 May 2020 13:49:23 +0800
Message-Id: <20200508054925.48237-1-biwen.li@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Biwen Li <biwen.li@nxp.com>

Add uie_unsupported property to drop warning as follows:
    - $ hwclock.util-linux
      hwclock.util-liux: select() /dev/rtc0
      to wait for clock tick timed out

My case:
    - RTC ds1374's INT pin is connected to VCC on T4240RDB,
      then the RTC cannot inform cpu about the alarm
      interrupt

Signed-off-by: Biwen Li <biwen.li@nxp.com>
---
 drivers/rtc/rtc-ds1374.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/rtc/rtc-ds1374.c b/drivers/rtc/rtc-ds1374.c
index 9c51a12cf70f..e530e887a17e 100644
--- a/drivers/rtc/rtc-ds1374.c
+++ b/drivers/rtc/rtc-ds1374.c
@@ -651,6 +651,10 @@ static int ds1374_probe(struct i2c_client *client,
 	if (ret)
 		return ret;
 
+	if (of_property_read_bool(client->dev.of_node,
+						 "uie_unsupported"))
+		ds1374->rtc->uie_unsupported = true;
+
 #ifdef CONFIG_RTC_DRV_DS1374_WDT
 	save_client = client;
 	ret = misc_register(&ds1374_miscdev);
-- 
2.17.1

