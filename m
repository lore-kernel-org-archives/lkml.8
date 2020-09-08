Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26BF6C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 15:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEFE723E20
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 15:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599580012;
	bh=jo8XYvozevoqwLnr8Q8ChiN/Mq4AJaD2/hqaujjU+jw=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=PNBN07DN+0Iw0IG83w0oZOrcK7gWa80E3sgbuyZgbmzsrYWCGDulubm2M1iDCTFew
	 O9/vWSdHRKyom2D4hxdnXOdND99p81mpszfjEmVWFPR+qSZcF5eH7LC1wCRDd1DgYC
	 C14x4a7cEL5/u1a/Fhz5y8T/Yow1lkxrObc0f9X8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730532AbgIHPqu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 11:46:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:33980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730609AbgIHPm2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:42:28 -0400
Received: from localhost.localdomain (unknown [194.230.155.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB9DF22B4E;
        Tue,  8 Sep 2020 14:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599577169;
        bh=jo8XYvozevoqwLnr8Q8ChiN/Mq4AJaD2/hqaujjU+jw=;
        h=From:To:Cc:Subject:Date:From;
        b=JPbf4sMP6KmcVCTAryLd32cvDGv2RaJpdhFq6aE4BYR2ha21kqZ/1SaAxL9ZPf8Mt
         4G+jN5cNbtfuleQ/g0rZxuMgJCxoev6ierAyzkVjN+wSoN3KRcqonaa6ssaEyOYFSj
         zexwbpNsyG8uRkJReKcoe/L7fIF6gPIwtkW99EB4=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] dt-bindings: power: Correct interrupt flags in examples
Date:   Tue,  8 Sep 2020 16:59:22 +0200
Message-Id: <20200908145922.4502-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GPIO_ACTIVE_x flags are not correct in the context of interrupt flags.
These are simple defines so they could be used in DTS but they will not
have the same meaning:
1. GPIO_ACTIVE_HIGH = 0 = IRQ_TYPE_NONE
2. GPIO_ACTIVE_LOW  = 1 = IRQ_TYPE_EDGE_RISING

Correct the interrupt flags, assuming the author of the code wanted some
logical behavior behind the name "ACTIVE_xxx", this is:
  ACTIVE_LOW => IRQ_TYPE_LEVEL_LOW

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 .../devicetree/bindings/power/supply/act8945a-charger.txt       | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/power/supply/act8945a-charger.txt b/Documentation/devicetree/bindings/power/supply/act8945a-charger.txt
index c7dfb7cecf40..cb737a9e1f16 100644
--- a/Documentation/devicetree/bindings/power/supply/act8945a-charger.txt
+++ b/Documentation/devicetree/bindings/power/supply/act8945a-charger.txt
@@ -33,7 +33,7 @@ Example:
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_charger_chglev &pinctrl_charger_lbo &pinctrl_charger_irq>;
 			interrupt-parent = <&pioA>;
-			interrupts = <45 GPIO_ACTIVE_LOW>;
+			interrupts = <45 IRQ_TYPE_LEVEL_LOW>;
 
 			active-semi,chglev-gpios = <&pioA 12 GPIO_ACTIVE_HIGH>;
 			active-semi,lbo-gpios = <&pioA 72 GPIO_ACTIVE_LOW>;
-- 
2.17.1

