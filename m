Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E959C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 08:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CFBB2076E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 08:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593158751;
	bh=oxZuekvIPEtXM6zB/IiVbn+wXbPMFca/PZzTAFdxW30=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=p6KWd86p9PdjcQr3ez/0jhCVRrFBFjCr/YyPKaSas4bTqYEJxtIkeUta2r0Yb5cnR
	 MgNZF3IlVOXNHlimgmPazQrAaqtBkK/riAZ+Dy8ItL4bcOEk6Yam4BiekhRvLIja32
	 Zgnc5XEq8crhlJeDVY9pwGBmMuDdg9+QmGdM6UY0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729147AbgFZIFt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 04:05:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:36604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729082AbgFZIFm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 04:05:42 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 12E1820857;
        Fri, 26 Jun 2020 08:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593158742;
        bh=oxZuekvIPEtXM6zB/IiVbn+wXbPMFca/PZzTAFdxW30=;
        h=From:To:Cc:Subject:Date:From;
        b=sXRXnyjYIlPCcgYot6AonrBd7xik/cOcpHH2VwHbdmahhAt4LUD/SpWYkuF+3jDev
         k2bmuddg2HJ9ME+0uXJa8XWQGdymFjs5BZEvYKxVt+sGH0Yrd/+I99SmK681v11dIh
         7jkhIFO/+aX43apwegX3TWjZZKTl/g2lUcbVn8P0=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Jun Nie <jun.nie@linaro.org>, Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH] ARM: dts: zx: Align L2 cache-controller nodename with dtschema
Date:   Fri, 26 Jun 2020 10:05:38 +0200
Message-Id: <20200626080538.3454-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix dtschema validator warnings like:
    l2-cache-controller@c00000: $nodename:0:
        'l2-cache-controller@c00000' does not match '^(cache-controller|cpu)(@[0-9a-f,]+)*$'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/zx296702.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/zx296702.dtsi b/arch/arm/boot/dts/zx296702.dtsi
index afd98de029be..f378c661b3bf 100644
--- a/arch/arm/boot/dts/zx296702.dtsi
+++ b/arch/arm/boot/dts/zx296702.dtsi
@@ -58,7 +58,7 @@
 			clocks = <&topclk ZX296702_A9_PERIPHCLK>;
 		};
 
-		l2cc: l2-cache-controller@c00000 {
+		l2cc: cache-controller@c00000 {
 			compatible = "arm,pl310-cache";
 			reg = <0x00c00000 0x1000>;
 			cache-unified;
-- 
2.17.1

