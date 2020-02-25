Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 511E1C35E0E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 20:14:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34E6321744
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 20:14:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731722AbgBYUOc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 15:14:32 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:11382 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728224AbgBYUOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 15:14:32 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01PK92St058083;
        Tue, 25 Feb 2020 15:14:21 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yax398vum-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Feb 2020 15:14:21 -0500
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 01PK9OCR059563;
        Tue, 25 Feb 2020 15:14:21 -0500
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yax398vu6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Feb 2020 15:14:21 -0500
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 01PKDExb023589;
        Tue, 25 Feb 2020 20:14:19 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma02wdc.us.ibm.com with ESMTP id 2yaux6ps3m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Feb 2020 20:14:19 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01PKEIoF29032860
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Feb 2020 20:14:18 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A2A8D6A058;
        Tue, 25 Feb 2020 20:14:18 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3B0C86A051;
        Tue, 25 Feb 2020 20:14:18 +0000 (GMT)
Received: from MSBARTH-P50.rch.stglabs.ibm.com (unknown [9.10.99.26])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 25 Feb 2020 20:14:18 +0000 (GMT)
From:   Matthew Barth <msbarth@linux.ibm.com>
To:     Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
        openbmc@lists.ozlabs.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Brandon Wyman <bjwyman@gmail.com>,
        Eddie James <eajames@linux.ibm.com>
Cc:     Matthew Barth <msbarth@linux.ibm.com>
Subject: [PATCH v2] ARM: dts: rainier: Set PCA9552 pin types
Date:   Tue, 25 Feb 2020 14:14:15 -0600
Message-Id: <20200225201415.431668-1-msbarth@linux.ibm.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-25_08:2020-02-25,2020-02-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 bulkscore=0 spamscore=0 suspectscore=0 mlxlogscore=987 priorityscore=1501
 lowpriorityscore=0 clxscore=1011 phishscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002250139
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All 16 pins of the PCA9552 at 7-bit address 0x61 should be set as type
GPIO.

Signed-off-by: Matthew Barth <msbarth@linux.ibm.com>
---
v2: Added leds-pca955x.h include
    Added upstream to patch
---
---
 arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
index c63cefce636d..d9fa9fd48058 100644
--- a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
@@ -4,6 +4,7 @@
 
 #include "aspeed-g6.dtsi"
 #include <dt-bindings/gpio/aspeed-gpio.h>
+#include <dt-bindings/leds/leds-pca955x.h>
 
 / {
 	model = "Rainier";
@@ -351,66 +352,82 @@
 
 		gpio@0 {
 			reg = <0>;
+			type = <PCA955X_TYPE_GPIO>;
 		};
 
 		gpio@1 {
 			reg = <1>;
+			type = <PCA955X_TYPE_GPIO>;
 		};
 
 		gpio@2 {
 			reg = <2>;
+			type = <PCA955X_TYPE_GPIO>;
 		};
 
 		gpio@3 {
 			reg = <3>;
+			type = <PCA955X_TYPE_GPIO>;
 		};
 
 		gpio@4 {
 			reg = <4>;
+			type = <PCA955X_TYPE_GPIO>;
 		};
 
 		gpio@5 {
 			reg = <5>;
+			type = <PCA955X_TYPE_GPIO>;
 		};
 
 		gpio@6 {
 			reg = <6>;
+			type = <PCA955X_TYPE_GPIO>;
 		};
 
 		gpio@7 {
 			reg = <7>;
+			type = <PCA955X_TYPE_GPIO>;
 		};
 
 		gpio@8 {
 			reg = <8>;
+			type = <PCA955X_TYPE_GPIO>;
 		};
 
 		gpio@9 {
 			reg = <9>;
+			type = <PCA955X_TYPE_GPIO>;
 		};
 
 		gpio@10 {
 			reg = <10>;
+			type = <PCA955X_TYPE_GPIO>;
 		};
 
 		gpio@11 {
 			reg = <11>;
+			type = <PCA955X_TYPE_GPIO>;
 		};
 
 		gpio@12 {
 			reg = <12>;
+			type = <PCA955X_TYPE_GPIO>;
 		};
 
 		gpio@13 {
 			reg = <13>;
+			type = <PCA955X_TYPE_GPIO>;
 		};
 
 		gpio@14 {
 			reg = <14>;
+			type = <PCA955X_TYPE_GPIO>;
 		};
 
 		gpio@15 {
 			reg = <15>;
+			type = <PCA955X_TYPE_GPIO>;
 		};
 	};
 
-- 
2.24.1

