Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC9CC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 03:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41668207D8
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 03:47:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728570AbgE0Dro (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 23:47:44 -0400
Received: from inva020.nxp.com ([92.121.34.13]:57960 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728489AbgE0Dro (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 23:47:44 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 02B251A05E9;
        Wed, 27 May 2020 05:47:42 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 76C441A060C;
        Wed, 27 May 2020 05:47:37 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 816D5402BC;
        Wed, 27 May 2020 11:47:31 +0800 (SGT)
From:   Biwen Li <biwen.li@oss.nxp.com>
To:     leoyang.li@nxp.com, robh+dt@kernel.org, mpe@ellerman.id.au,
        benh@kernel.crashing.org, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com
Cc:     devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        Biwen Li <biwen.li@nxp.com>
Subject: [v3 2/2] dts: ppc: t1024rdb: remove interrupts property
Date:   Wed, 27 May 2020 11:42:28 +0800
Message-Id: <20200527034228.23793-2-biwen.li@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200527034228.23793-1-biwen.li@oss.nxp.com>
References: <20200527034228.23793-1-biwen.li@oss.nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Biwen Li <biwen.li@nxp.com>

Since the interrupt pin for RTC DS1339 is not connected
to the CPU on T1024RDB, remove the interrupt property
from the device tree.

This also fix the following warning for hwclock.util-linux:
$ hwclock.util-linux
hwclock.util-linux: select() to /dev/rtc0
to wait for clock tick timed out

Signed-off-by: Biwen Li <biwen.li@nxp.com>
---
 arch/powerpc/boot/dts/fsl/t1024rdb.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/boot/dts/fsl/t1024rdb.dts b/arch/powerpc/boot/dts/fsl/t1024rdb.dts
index 645caff98ed1..605ceec66af3 100644
--- a/arch/powerpc/boot/dts/fsl/t1024rdb.dts
+++ b/arch/powerpc/boot/dts/fsl/t1024rdb.dts
@@ -161,7 +161,6 @@
 			rtc@68 {
 				compatible = "dallas,ds1339";
 				reg = <0x68>;
-				interrupts = <0x1 0x1 0 0>;
 			};
 		};
 
-- 
2.17.1

