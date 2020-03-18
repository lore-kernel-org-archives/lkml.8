Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A451AC5ACD6
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 10:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75F8B2076C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 10:31:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="j7De3Ill"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbgCRKbn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 06:31:43 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:7443 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727324AbgCRKbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 06:31:42 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e71f85c0000>; Wed, 18 Mar 2020 03:30:52 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 18 Mar 2020 03:31:41 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 18 Mar 2020 03:31:41 -0700
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 18 Mar
 2020 10:31:41 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 18 Mar 2020 10:31:41 +0000
Received: from nkristam-ubuntu.nvidia.com (Not Verified[10.19.67.128]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e71f8890002>; Wed, 18 Mar 2020 03:31:40 -0700
From:   Nagarjuna Kristam <nkristam@nvidia.com>
To:     <kishon@ti.com>, <robh+dt@kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <balbi@kernel.org>,
        <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <jckuo@nvidia.com>, Nagarjuna Kristam <nkristam@nvidia.com>
Subject: [PATCH V1 1/8] dt-bindings: phy: tegra-xusb: Add charger-detect property
Date:   Wed, 18 Mar 2020 16:01:00 +0530
Message-ID: <1584527467-8058-2-git-send-email-nkristam@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1584527467-8058-1-git-send-email-nkristam@nvidia.com>
References: <1584527467-8058-1-git-send-email-nkristam@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1584527452; bh=Ur7COE1LR32rGOz+P92MOunBwsp5tY0yJq0Yuagh3FA=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=j7De3Ill6zgqK3UmI3iIErLBoTjeUXQkQaGVIH17WXclxVYWZPm/If8jFhd9URArX
         lyLmZ8eg98VGuTzZlfsqDs2t1S6AsxS8LoemFS7MCPf3mMQPRTX/4eoast6zd+xspc
         sfr5rxgP9XVpDzkeQ1HCpuQQwVnRM2G/7EkREikTRIGaTpOiWg5FwYj0rn+i1FS5hJ
         lppSCHaZzPYcySJjCJA6d62AO4fym5oOvhwcqNj/KaaOhxeoI36dx1YoswyS94bF3s
         gg0XKEe3SlnJtxEZ2TFPoePWeukrsVYLyfKc65WFbfrpUJ7QG3cLP0hFZFPS7GVCXv
         vWJc2nZiRRoOg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add nvidia,charger-detect boolean property for Tegra210 and Tegra186
platforms. This property is used to inform driver to perform charger
detection on corresponding USB 2 port.

Signed-off-by: Nagarjuna Kristam <nkristam@nvidia.com>
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

