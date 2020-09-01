Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E628C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 22:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B92C206FA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 22:31:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="WiKnj/tv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728561AbgIAWb3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 18:31:29 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:49680 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728280AbgIAWbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 18:31:18 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 081MV6nk120516;
        Tue, 1 Sep 2020 17:31:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1598999467;
        bh=IBp5ZPDU8qMnr/bbmmbmkpX7jXB/QhyA2xNq7BTJHqA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=WiKnj/tvi8+CdbgjBIHUQo663iSLiVjLjAehZ9YQE/xo0WU7fZilCQtCx/lT9dt5z
         asHRFNhLvzrQl7CbD0K2b3lCIptpVUkfJ/99UaRm4tKujFs9hG/dtrVRVK3uJ2voXY
         w0c5hONA5//i7ho1tK+G9QanoCS5J9vXCMqTR4X8=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 081MV6kh053959
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 1 Sep 2020 17:31:06 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 1 Sep
 2020 17:31:06 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 1 Sep 2020 17:31:06 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 081MV6B6119462;
        Tue, 1 Sep 2020 17:31:06 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Rob Herring <robh+dt@kernel.org>, Tero Kristo <t-kristo@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Suman Anna <s-anna@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>, <lokeshvutla@ti.com>,
        <grygorii.strashko@ti.com>, <nsekhar@ti.com>,
        Nishanth Menon <nm@ti.com>
Subject: [PATCH 5/7] arm64: dts: ti: k3-am65-wakeup: Use generic temperature-sensor for node name
Date:   Tue, 1 Sep 2020 17:30:57 -0500
Message-ID: <20200901223059.14801-6-nm@ti.com>
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

Use temperature-sensor@ naming for nodes following standard conventions of device
tree (section 2.2.2 Generic Names recommendation in [1]).

[1] https://github.com/devicetree-org/devicetree-specification/tree/v0.3

Suggested-by: Suman Anna <s-anna@ti.com>
Suggested-by: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
index bb498be2f0a4..ed42f13e7663 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
@@ -95,7 +95,7 @@
 		clock-names = "gpio";
 	};
 
-	wkup_vtm0: thermal@42050000 {
+	wkup_vtm0: temperature-sensor@42050000 {
 		compatible = "ti,am654-vtm";
 		reg = <0x42050000 0x25c>;
 		power-domains = <&k3_pds 80 TI_SCI_PD_EXCLUSIVE>;
-- 
2.17.1

