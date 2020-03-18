Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C621C5ACD7
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 08:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D20020753
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 08:35:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727494AbgCRIf1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 04:35:27 -0400
Received: from comms.puri.sm ([159.203.221.185]:55306 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727387AbgCRIf0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 04:35:26 -0400
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 8065BDFFBF;
        Wed, 18 Mar 2020 01:35:26 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id M3qdoT-6_6FE; Wed, 18 Mar 2020 01:35:25 -0700 (PDT)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     balbi@kernel.org, robh@kernel.org
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH 2/2] dt-bindings: usb: dwc3: add optional extcon description
Date:   Wed, 18 Mar 2020 09:35:08 +0100
Message-Id: <20200318083508.20781-2-martin.kepplinger@puri.sm>
In-Reply-To: <20200318083508.20781-1-martin.kepplinger@puri.sm>
References: <20200318083508.20781-1-martin.kepplinger@puri.sm>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

the dwc3 drd module already hooks up an extcon device if described in DT.

Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
---
 Documentation/devicetree/bindings/usb/dwc3.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/dwc3.txt b/Documentation/devicetree/bindings/usb/dwc3.txt
index 9946ff9ba735..9aa0cefbf5f6 100644
--- a/Documentation/devicetree/bindings/usb/dwc3.txt
+++ b/Documentation/devicetree/bindings/usb/dwc3.txt
@@ -31,6 +31,8 @@ Exception for clocks:
     "xlnx,zynqmp-dwc3"
 
 Optional properties:
+ - extcon: phandle for the extcon device dwc3 DRD uses to detect
+   connect/disconnect events.
  - usb-phy : array of phandle for the PHY device.  The first element
    in the array is expected to be a handle to the USB2/HS PHY and
    the second element is expected to be a handle to the USB3/SS PHY
-- 
2.20.1

