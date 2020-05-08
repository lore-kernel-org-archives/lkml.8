Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFFC8C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 05:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBC5320870
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 05:54:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbgEHFyM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 01:54:12 -0400
Received: from inva021.nxp.com ([92.121.34.21]:51524 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725865AbgEHFyK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 01:54:10 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id EDA75201278;
        Fri,  8 May 2020 07:54:08 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 6F4D6201276;
        Fri,  8 May 2020 07:54:04 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 62F364030E;
        Fri,  8 May 2020 13:53:58 +0800 (SGT)
From:   Biwen Li <biwen.li@oss.nxp.com>
To:     leoyang.li@nxp.com, robh+dt@kernel.org, mpe@ellerman.id.au,
        benh@kernel.crashing.org, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com
Cc:     devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        Biwen Li <biwen.li@nxp.com>
Subject: [PATCH 3/3] dts: ppc: t1024rdb: add wakeup-source property to drop warning
Date:   Fri,  8 May 2020 13:49:25 +0800
Message-Id: <20200508054925.48237-3-biwen.li@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200508054925.48237-1-biwen.li@oss.nxp.com>
References: <20200508054925.48237-1-biwen.li@oss.nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Biwen Li <biwen.li@nxp.com>

This adds wakeup-source property to drop warning as follows:
    - $ hwclock.util-linux
      hwclock.util-linux: select() to /dev/rtc0
      to wait for clock tick timed out

My case:
    - RTC ds1339s INT pin isn't connected to cpus INT pin on T1024RDB,
      then the RTC cannot inform cpu about alarm interrupt

How to fix it?
    - add wakeup-source property and remove IRQ line
      to set uie_unsupported flag

Signed-off-by: Biwen Li <biwen.li@nxp.com>
---
 arch/powerpc/boot/dts/fsl/t1024rdb.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/boot/dts/fsl/t1024rdb.dts b/arch/powerpc/boot/dts/fsl/t1024rdb.dts
index 645caff98ed1..191cbf5cda4e 100644
--- a/arch/powerpc/boot/dts/fsl/t1024rdb.dts
+++ b/arch/powerpc/boot/dts/fsl/t1024rdb.dts
@@ -161,7 +161,7 @@
 			rtc@68 {
 				compatible = "dallas,ds1339";
 				reg = <0x68>;
-				interrupts = <0x1 0x1 0 0>;
+				wakeup-source;
 			};
 		};
 
-- 
2.17.1

