Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F989C3B1BF
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 19:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6870A2073A
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 19:44:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="S4PAo9/d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388706AbgBNTo2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 14:44:28 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:35472 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729015AbgBNTo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 14:44:28 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01EJiGno005325;
        Fri, 14 Feb 2020 13:44:16 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1581709456;
        bh=IeFQzTuM1uT4IXWP1iDdK+ZHoJFomcVp/TUPe3FcUcg=;
        h=From:To:CC:Subject:Date;
        b=S4PAo9/d9TMiVNzT0fRaMzqmRtqImiDgUNFxtQI13QXp9cJx4hJxECYgvuVHgVLDA
         mx66vUj2itR6HS7NApC/7PYhDWIhvigU5t3A3o9gni82Vi+NN2C06E3hENonVUXG+a
         tdmQMdTVxg8NdVSG9hGd3CjE8BTw4e1Vkdkoyibc=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01EJiGH2043961
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 14 Feb 2020 13:44:16 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 14
 Feb 2020 13:44:15 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 14 Feb 2020 13:44:15 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01EJiEd4003237;
        Fri, 14 Feb 2020 13:44:15 -0600
From:   Grygorii Strashko <grygorii.strashko@ti.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Simon Horman <simon.horman@netronome.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        <devicetree@vger.kernel.org>
CC:     "David S . Miller" <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH v2] dt-bindings: net: mdio: remove compatible string from example
Date:   Fri, 14 Feb 2020 21:44:08 +0200
Message-ID: <20200214194408.9308-1-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove vendor specific compatible string from example, otherwise DT YAML
schemas validation may trigger warnings specific to TI ti,davinci_mdio
and not to the generic MDIO example.

For example, the "bus_freq" is required for davinci_mdio, but not required for
generic mdio example. As result following warning will be produced:
 mdio.example.dt.yaml: mdio@5c030000: 'bus_freq' is a required property

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
Remove compatible string from example instead of changing it.

v1: https://patchwork.ozlabs.org/patch/1201674/

 Documentation/devicetree/bindings/net/mdio.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/mdio.yaml b/Documentation/devicetree/bindings/net/mdio.yaml
index 5d08d2ffd4eb..50c3397a82bc 100644
--- a/Documentation/devicetree/bindings/net/mdio.yaml
+++ b/Documentation/devicetree/bindings/net/mdio.yaml
@@ -56,7 +56,6 @@ patternProperties:
 examples:
   - |
     davinci_mdio: mdio@5c030000 {
-        compatible = "ti,davinci_mdio";
         reg = <0x5c030000 0x1000>;
         #address-cells = <1>;
         #size-cells = <0>;
-- 
2.17.1

