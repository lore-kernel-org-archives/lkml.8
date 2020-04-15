Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBAEEC2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 08:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7CD4206E9
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 08:29:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="W9Ip2w4s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2894566AbgDOI3E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 04:29:04 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:16774 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2894466AbgDOI1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 04:27:10 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e96c4b90000>; Wed, 15 Apr 2020 01:24:25 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 15 Apr 2020 01:25:23 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 15 Apr 2020 01:25:23 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 15 Apr
 2020 08:25:22 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 15 Apr 2020 08:25:22 +0000
Received: from nkristam-ubuntu.nvidia.com (Not Verified[10.19.67.128]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e96c4ef0000>; Wed, 15 Apr 2020 01:25:21 -0700
From:   Nagarjuna Kristam <nkristam@nvidia.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>, <kishon@ti.com>
CC:     <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Nagarjuna Kristam <nkristam@nvidia.com>
Subject: [PATCH V2 1/8] dt-bindings: phy: tegra-xusb: Add charger-detect property
Date:   Wed, 15 Apr 2020 13:55:01 +0530
Message-ID: <1586939108-10075-2-git-send-email-nkristam@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1586939108-10075-1-git-send-email-nkristam@nvidia.com>
References: <1586939108-10075-1-git-send-email-nkristam@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1586939065; bh=SV8SYGELTW8vG0isvMFMvi6jGyjhj/U0TJjzJY0h4YA=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=W9Ip2w4sJ4GcC+j42qRE8/LGsCSIOrqZ+8+7GADC/vJBlGvVVjGbltupTQjoBKVpU
         zlD7HSFxoFF35N/OubsbW05ui8FG2h/MrjE2bioybjIUET9Zx0RoMZPNePqpoEhW4m
         j4ZW8CuEZ4S8/s0u37ct4Sr+tmQSPyt05gWtQbU1WcqBOI5S1Ul+CN8g9Mm5AwhSSJ
         ZhGe0t3LlWfFuVKpABfv2gYQnP0d4+Kq3C7kn0k86jLo78v9JtzBL49CfqEPeOCOXR
         iFLnoFa41s9bRTGRBszW6CcWOkV1wTS2v9rifQz2yuHXiWcdkV+QrYRJckYpd3Jtsm
         +R1Gztu25QExg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add nvidia,charger-detect boolean property for Tegra210 and Tegra186
platforms. This property is used to inform driver to perform charger
detection on corresponding USB 2 port.

Signed-off-by: Nagarjuna Kristam <nkristam@nvidia.com>
Acked-by: Rob Herring <robh@kernel.org>
---
V2:
 - Added Acked-by updates to commit message.
---
 Documentation/devicetree/bindings/phy/nvidia,tegra124-xusb-padctl.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/nvidia,tegra124-xusb-padctl.txt b/Documentation/devicetree/bindings/phy/nvidia,tegra124-xusb-padctl.txt
index 38c5fa2..9b2d2dd 100644
--- a/Documentation/devicetree/bindings/phy/nvidia,tegra124-xusb-padctl.txt
+++ b/Documentation/devicetree/bindings/phy/nvidia,tegra124-xusb-padctl.txt
@@ -190,6 +190,10 @@ Required properties for OTG/Peripheral capable USB2 ports:
   and peripheral roles. Connector should be added as subnode.
   See usb/usb-conn-gpio.txt.
 
+Optional properties for OTG/Peripheral capable USB2 ports:
+- nvidia,charger-detect: A boolean property whose presence inform driver to
+  perform charger-detect activity.
+
 Optional properties:
 - nvidia,internal: A boolean property whose presence determines that a port
   is internal. In the absence of this property the port is considered to be
-- 
2.7.4

