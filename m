Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A5ECC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 11:46:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 732AD2074B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 11:46:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="mDfO/PE7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbgFBLqR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 07:46:17 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:37050 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgFBLqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 07:46:15 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 052BkDAg009565;
        Tue, 2 Jun 2020 06:46:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1591098373;
        bh=LRdmRboNOihhKyCidGFZIk0kpdnA33gVqEoBikUotJY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=mDfO/PE7tq+p615FDvxypSKBFGjDJAA+x5O5T2OW4zCooRAlrOq5GneyPA2mBdMTP
         u1nJdH2TM5U/97+GZfSQIzsr0k64/LXDiYM5wAm4cBBIQ0yiaP6QHaeTRD5p1jV5Pt
         hUO57Iz8QWgRImxemRVAnaegJVJHrVu3Tu8bwbUk=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 052BkDpf100728;
        Tue, 2 Jun 2020 06:46:13 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 2 Jun
 2020 06:46:13 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 2 Jun 2020 06:46:13 -0500
Received: from lta0400828a.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 052Bk8kt000625;
        Tue, 2 Jun 2020 06:46:12 -0500
From:   Roger Quadros <rogerq@ti.com>
To:     <kishon@ti.com>, <robh+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Roger Quadros <rogerq@ti.com>
Subject: [PATCHv2 2/3] dt-binding: phy: ti,omap-usb2: Add quirk to disable charger detection
Date:   Tue, 2 Jun 2020 14:46:05 +0300
Message-ID: <20200602114606.32045-3-rogerq@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200602114606.32045-1-rogerq@ti.com>
References: <20200602114606.32045-1-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add "ti,dis-chg-det-quirk" property to disable the USB2_PHY Charger Detect
logic.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 Documentation/devicetree/bindings/phy/ti,omap-usb2.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/ti,omap-usb2.yaml b/Documentation/devicetree/bindings/phy/ti,omap-usb2.yaml
index 2bbea8d2bcb1..5e8c7a98de1e 100644
--- a/Documentation/devicetree/bindings/phy/ti,omap-usb2.yaml
+++ b/Documentation/devicetree/bindings/phy/ti,omap-usb2.yaml
@@ -50,6 +50,11 @@ properties:
       (deprecated) phandle of the control module used by PHY driver
       to power on the PHY. Use syscon-phy-power instead.
 
+  ti,dis-chg-det-quirk:
+    description:
+      if present, driver will disable charger detection logic.
+    type: boolean
+
 required:
   - compatible
   - reg
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

