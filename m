Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED856C433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 18:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC92620BED
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 18:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599156875;
	bh=CWtP88KUjlDugGT2fPPmSCAGGW9+H2kgyuCh3PmZbrs=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=V0MQfpszHmDYF8uDViB03Z1zR+qDXYnBbUfm/6SzgUBhm0GnBkDR9XA35r0tw0CBI
	 ckzOOtDZuzSTcKjtHs9zpMkJy3NLA04KIaCV9gDC2VnBFnc7JcdUHpt/Ym+qLmRjYl
	 E2e2DDqIj7vhdHBE0gixpfTz3NXYXQwXdRTLHx2Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728850AbgICSOe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 14:14:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:39190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726990AbgICSOd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 14:14:33 -0400
Received: from localhost.localdomain (unknown [194.230.155.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4815B208C7;
        Thu,  3 Sep 2020 18:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599156872;
        bh=CWtP88KUjlDugGT2fPPmSCAGGW9+H2kgyuCh3PmZbrs=;
        h=From:To:Cc:Subject:Date:From;
        b=sDElgBhSGQbkTYlKOAQiIsBn0BnTP7dEKkEOniJVCk79hyX8L6oG/wYXe1TxiUMZo
         Spal2AdgZQcRutu/G5UCn2yZMJjw8LeX6MJ7nKRWZGc8DDRtnFcNn3knv+sQwqDjdu
         Tcis9G4Y5ciE+EINZph6IR5RYCZ1gQ6U5Fy8mHyQ=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>
Subject: [PATCH v2 1/3] ARM: dts: exynos: Add assigned clock parent to CMU in Exynos3250
Date:   Thu,  3 Sep 2020 20:14:23 +0200
Message-Id: <20200903181425.5015-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 52005dece527 ("ARM: dts: Add assigned clock parents to CMU node
for exynos3250") added assigned clocks under Clock Management Unit to
fix hangs when accessing ISP registers.

However the dtschema expects "clocks" property if "assigned-clocks" are
used.  Add reference to input clock, the parent used in
"assigned-clock-parents" to silence the dtschema warnings:

  arch/arm/boot/dts/exynos3250-artik5-eval.dt.yaml: clock-controller@10030000: 'clocks' is a dependency of 'assigned-clocks'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. Add clocks property.

This is a v2 for:
https://lore.kernel.org/linux-samsung-soc/20200901101534.GE23793@kozik-lap/T/#me85ac382b847dadbc3f6ebf30e94e70b5df1ebb6
---
 arch/arm/boot/dts/exynos3250.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
index a1e93fb7f694..89b160280469 100644
--- a/arch/arm/boot/dts/exynos3250.dtsi
+++ b/arch/arm/boot/dts/exynos3250.dtsi
@@ -214,6 +214,7 @@
 			compatible = "samsung,exynos3250-cmu";
 			reg = <0x10030000 0x20000>;
 			#clock-cells = <1>;
+			clocks = <&cmu CLK_FIN_PLL>;
 			assigned-clocks = <&cmu CLK_MOUT_ACLK_400_MCUISP_SUB>,
 					  <&cmu CLK_MOUT_ACLK_266_SUB>;
 			assigned-clock-parents = <&cmu CLK_FIN_PLL>,
-- 
2.17.1

