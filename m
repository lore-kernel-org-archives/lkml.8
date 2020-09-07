Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F5F5C433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 15:30:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F304206B5
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 15:30:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="eiHKKSqz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730082AbgIGPNq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 11:13:46 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:41628 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730048AbgIGOw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 10:52:28 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 087EqOTj083979;
        Mon, 7 Sep 2020 09:52:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1599490344;
        bh=maV1HnxzUqcAea8SA8agGpNMSixjUoS/2oLuG+aMCVM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=eiHKKSqzh+8nGrh8IHiCbgINb30UHAWojxqd9w622NuQ9AhmeS4m37ibjCgU1d6fI
         AwPjQZprYih03rAXP0ui+KVKJMYbhpxiFRZ1N6EOmLu/cAeknGOc2JwEUFzmf0xz7r
         M11MYP7Z4wpE9EBSe6fcH5iX5BNCQyL/XDPeqtNw=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 087EqOQ1128161
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 7 Sep 2020 09:52:24 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 7 Sep
 2020 09:52:24 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 7 Sep 2020 09:52:24 -0500
Received: from lta0400828a.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 087EqEEO010923;
        Mon, 7 Sep 2020 09:52:22 -0500
From:   Roger Quadros <rogerq@ti.com>
To:     <t-kristo@ti.com>, <nm@ti.com>
CC:     <robh+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <nsekhar@ti.com>,
        <kishon@ti.com>, Roger Quadros <rogerq@ti.com>
Subject: [PATCH v2 3/6] arm64: dts: ti: k3-j7200-main.dtsi: Add USB to SERDES lane MUX
Date:   Mon, 7 Sep 2020 17:52:10 +0300
Message-ID: <20200907145213.30788-4-rogerq@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200907145213.30788-1-rogerq@ti.com>
References: <20200907145213.30788-1-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The USB controller can be connected to one of the 2 lanes
of SERDES0 using a MUX. Add a MUX controller node for that.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
index e72c7a0ccad5..af9e8e46b49e 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
@@ -31,6 +31,12 @@
 			mux-reg-masks = <0x4080 0x3>, <0x4084 0x3>, /* SERDES0 lane0/1 select */
 					<0x4088 0x3>, <0x408c 0x3>; /* SERDES0 lane2/3 select */
 		};
+
+		usb_serdes_mux: mux-controller@4000 {
+			compatible = "mmio-mux";
+			#mux-control-cells = <1>;
+			mux-reg-masks = <0x4000 0x8000000>; /* USB0 to SERDES0 lane 1/3 mux */
+		};
 	};
 
 	gic500: interrupt-controller@1800000 {
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

