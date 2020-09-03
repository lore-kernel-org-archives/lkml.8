Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 567CFC433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 13:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33739206E7
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 13:40:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Xm6NdHNQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728790AbgICNkp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 09:40:45 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:37654 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728905AbgICNB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 09:01:57 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 083D0M1G043860;
        Thu, 3 Sep 2020 08:00:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1599138022;
        bh=3UnrmFd1UMtNAPC3bqLE3uCixOBOTPJ7m2wRMDZjtV4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Xm6NdHNQ9qMpxmsEgxNjcB+Woz0I80fIWI7Eu6IkWIY4aEw/3Hcy4oDiUvI73JuQ4
         EkDihg1tuoIxW2wsCNQLh/XU8L2mAlr/fwIQBhf8RcE2bZPy85l9oM/iF+/v05HwtM
         PeXbnzL0Io64qLXhrCVqX04qlnFiRJf2zTdgLEGA=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 083D0MSV028026
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 3 Sep 2020 08:00:22 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 3 Sep
 2020 08:00:22 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 3 Sep 2020 08:00:22 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 083D0LCj125605;
        Thu, 3 Sep 2020 08:00:21 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Rob Herring <robh+dt@kernel.org>, Tero Kristo <t-kristo@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Suman Anna <s-anna@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>, <lokeshvutla@ti.com>,
        <grygorii.strashko@ti.com>, <nsekhar@ti.com>,
        Nishanth Menon <nm@ti.com>
Subject: [PATCH V2 2/8] arm64: dts: ti: k3-am65-main: Use lower case hexadecimal
Date:   Thu, 3 Sep 2020 08:00:09 -0500
Message-ID: <20200903130015.21361-3-nm@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200901223059.14801-1-nm@ti.com>
References: <20200901223059.14801-1-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Device tree convention uses lower case a-f for hexadecimals. Fix the
same.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
Change:
v2: - new

 arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index 76e0edc4ad5c..d53d1ead4bb6 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -344,9 +344,9 @@
 					<0x4090 0x3>; /* SERDES1 lane select */
 		};
 
-		dss_oldi_io_ctrl: dss_oldi_io_ctrl@41E0 {
+		dss_oldi_io_ctrl: dss_oldi_io_ctrl@41e0 {
 			compatible = "syscon";
-			reg = <0x0000041E0 0x14>;
+			reg = <0x0000041e0 0x14>;
 		};
 
 		ehrpwm_tbclk: syscon@4140 {
-- 
2.17.1

