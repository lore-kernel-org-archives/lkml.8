Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B42C33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 11:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90DA72253D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 11:45:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="UTnoAprY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728998AbgAWLpC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 06:45:02 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:51322 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727312AbgAWLo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 06:44:57 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 00NBip87129993;
        Thu, 23 Jan 2020 05:44:51 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1579779891;
        bh=TQxJOkllZRM/u+My4lOJpaDn2K7FzjpSKQ+ZfGHnqnw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=UTnoAprYrY7UKJedUUIFAdWlBX0HziZyzoxF9hFDX5Huqp63r8F9SqdqKBPAkGrSY
         4TcQ6Kgk7c+s226i0hFCfnZ54lq6KYOY+iP95wZJJwnSvurYUg9ofxVPQd+TfRyix5
         bKiTJBEh/mZB1pRkcv/g60DTPpAsnrPhTUx3gZEA=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00NBipJL060521;
        Thu, 23 Jan 2020 05:44:51 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 23
 Jan 2020 05:44:50 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 23 Jan 2020 05:44:50 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00NBijBE114078;
        Thu, 23 Jan 2020 05:44:48 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <t-kristo@ti.com>, <nm@ti.com>, <lokeshvutla@ti.com>
CC:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 1/9] arm64: dts: ti: k3-am65-main: Correct main NAVSS representation
Date:   Thu, 23 Jan 2020 13:45:20 +0200
Message-ID: <20200123114528.26552-2-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200123114528.26552-1-peter.ujfalusi@ti.com>
References: <20200123114528.26552-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NAVSS is a subsystem containing different IPs, it is not really a bus.
Change the compatible from "simple-bus" to "simple-mfd" to reflect that.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index efb24579922c..972e14bf9478 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -385,8 +385,8 @@ intr_main_gpio: interrupt-controller0 {
 		ti,sci-rm-range-girq = <0x1>;
 	};
 
-	cbass_main_navss: interconnect0 {
-		compatible = "simple-bus";
+	main_navss {
+		compatible = "simple-mfd";
 		#address-cells = <2>;
 		#size-cells = <2>;
 		ranges;
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

