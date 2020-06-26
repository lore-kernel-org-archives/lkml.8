Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90BC2C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 08:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FB1B2082E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 08:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593158819;
	bh=bPwCaiRUHtIB4Vkkq8BcydU1A3dIjpEtHR80BgnI2mI=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=glvmFX+0XuklSC5dN+7uiuLZEgPN8YiIh01UoHLMOkDFkJ8z/HIHobiScPl8phAqs
	 VvwrT0179Zln2+h+nkHCbnd7lBniDEjDIFxzJCsv4JApE+BftTw4YLNRxXb35cE/yf
	 5KvqixlUKco/Y8qc5kctiiEw4YzyFxLNb2wgDJQc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729369AbgFZIG6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 04:06:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:38184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729115AbgFZIGz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 04:06:55 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED82520836;
        Fri, 26 Jun 2020 08:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593158815;
        bh=bPwCaiRUHtIB4Vkkq8BcydU1A3dIjpEtHR80BgnI2mI=;
        h=From:To:Cc:Subject:Date:From;
        b=FRlwNmMDI/vIG0jsge053G/9EjuUAMRyoAyJcPFwn0la4LbHhSs/8AbiSPt4c5YHj
         /NUbY4Om/u//SuVaCIi1ndX1c+K8U3qZv1DLGCm8QrljpaH7kzjF/MbSZQGpMD2xXU
         d7kbpOcS3JYVNHf843o0T0cBij1L4FhVF4Jd896E=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH] ARM: dts: am: Align L2 cache-controller nodename with dtschema
Date:   Fri, 26 Jun 2020 10:06:51 +0200
Message-Id: <20200626080651.4355-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix dtschema validator warnings like:
    l2-cache-controller@48242000: $nodename:0: 'l2-cache-controller@48242000'
        does not match '^(cache-controller|cpu)(@[0-9a-f,]+)*$'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/am4372.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index 51ad9e881a62..73737af49f48 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -153,7 +153,7 @@
 		clocks = <&mpu_periphclk>;
 	};
 
-	l2-cache-controller@48242000 {
+	cache-controller@48242000 {
 		compatible = "arm,pl310-cache";
 		reg = <0x48242000 0x1000>;
 		cache-unified;
-- 
2.17.1

