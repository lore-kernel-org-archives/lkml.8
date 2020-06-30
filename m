Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E5EAC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 09:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 188DD20774
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 09:27:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Valvzgq/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731968AbgF3J1i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 05:27:38 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:46414 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730256AbgF3J1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 05:27:36 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 05U9RXFu080159;
        Tue, 30 Jun 2020 04:27:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1593509253;
        bh=bBXVbl5c7a74Y3IHGcEjGv+uAGNnH0MEPRnsBGW+LLI=;
        h=From:To:CC:Subject:Date;
        b=Valvzgq/D6YZon5L70SMhk26W6zijqijkNWAvGQVjNKiXA1FGcnGWgAOFRvwFxv/p
         YdnNbBusL1qcVfTn/d8UY0JmaM+w6TjPrw8GqcIKq/0UpU9Adxqbx11/kahaWPhzI8
         j7yt8++do2cAxguzzwBpNpayAbrPzzrmLHdxvqeY=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 05U9RXQb030278
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 30 Jun 2020 04:27:33 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 30
 Jun 2020 04:27:33 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 30 Jun 2020 04:27:33 -0500
Received: from lta0400828a.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 05U9RUU4003947;
        Tue, 30 Jun 2020 04:27:31 -0500
From:   Roger Quadros <rogerq@ti.com>
To:     <kishon@ti.com>
CC:     <robh+dt@kernel.org>, <nsekhar@ti.com>, <vigneshr@ti.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Roger Quadros <rogerq@ti.com>
Subject: [PATCH v3 0/3] phy: omap-usb2: add quirk to disable charger detection
Date:   Tue, 30 Jun 2020 12:27:26 +0300
Message-ID: <20200630092729.15346-1-rogerq@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

- convert DT binding to YAML
- add DT property to disable charger detection
  (Errata i2075 for AM65 SR1.0)

Changelog:
v3
- Removed quotes from compatibles
- changed property to "ti,disable-charger-det"

v2
- Address Rob's comments on YAML schema.

cheers,
-roger

Roger Quadros (3):
  dt-binding: phy: convert ti,omap-usb2 to YAML
  dt-binding: phy: ti,omap-usb2: Add quirk to disable charger detection
  phy: omap-usb2-phy: disable PHY charger detect

 .../devicetree/bindings/phy/ti,omap-usb2.yaml | 74 +++++++++++++++++++
 .../devicetree/bindings/phy/ti-phy.txt        | 37 ----------
 drivers/phy/ti/phy-omap-usb2.c                | 35 +++++++--
 3 files changed, 102 insertions(+), 44 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/ti,omap-usb2.yaml

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

