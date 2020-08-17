Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6905C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF22620674
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597692885;
	bh=mE9Cv2gDprxIhiW8xNiatgrYr6zEmkc5sLn2LDuaYG4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AxrzYR2aKmJlNjaVMzmuqhBqwGJr4nDBI/ZNqdDohXGukDMHbkZ0L4SXnjElgsQSG
	 z108G2v+y43KbACgYp5pglLxN8FKfa6DJdc0CNaIBWbjHUbAYlYoic+tKvh83CbcMJ
	 65vf8MAl1xAyQnYlFkPtrXDe74VT10ujUAm2i++I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732327AbgHQTem (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 15:34:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:50560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730164AbgHQPaE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:30:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A28E023C43;
        Mon, 17 Aug 2020 15:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597678204;
        bh=mE9Cv2gDprxIhiW8xNiatgrYr6zEmkc5sLn2LDuaYG4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QhDNrWE39sKaDalheo9t38yn2HQjRTsd6VWZopfLhZW7iOygc+wdYGWuy+008cvHt
         WjODVvTBczUX77f7jzH+lBr2JOy7rTZ1M6BX2HdolYw1GHdES4RAndQ9I04urUS8ZP
         3l8UCEJNhu2j/iGkPIHSvVvrOdxX99X5hxe0ucQw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 223/464] dt-bindings: phy: uniphier: Fix incorrect clocks and clock-names for PXs3 usb3-hsphy
Date:   Mon, 17 Aug 2020 17:12:56 +0200
Message-Id: <20200817143844.479110912@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143833.737102804@linuxfoundation.org>
References: <20200817143833.737102804@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>

[ Upstream commit 03815930c162561a5c204494b4160d6ccf631b0b ]

The usb3-hsphy for PXs3 SoC needs to accept 3 clocks like usb3-ssphy.

Fixes: 134ab2845acb ("dt-bindings: phy: Convert UniPhier USB3-PHY conroller to json-schema")
Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Link: https://lore.kernel.org/r/1594198664-29381-1-git-send-email-hayashi.kunihiko@socionext.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../bindings/phy/socionext,uniphier-usb3hs-phy.yaml       | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/socionext,uniphier-usb3hs-phy.yaml b/Documentation/devicetree/bindings/phy/socionext,uniphier-usb3hs-phy.yaml
index f88d36207b87e..c871d462c9523 100644
--- a/Documentation/devicetree/bindings/phy/socionext,uniphier-usb3hs-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/socionext,uniphier-usb3hs-phy.yaml
@@ -31,12 +31,16 @@ properties:
 
   clocks:
     minItems: 1
-    maxItems: 2
+    maxItems: 3
 
   clock-names:
     oneOf:
       - const: link          # for PXs2
-      - items:               # for PXs3
+      - items:               # for PXs3 with phy-ext
+        - const: link
+        - const: phy
+        - const: phy-ext
+      - items:               # for others
         - const: link
         - const: phy
 
-- 
2.25.1



