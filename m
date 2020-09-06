Return-Path: <SRS0=pQss=CP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75535C43461
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 14:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AAA420714
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 14:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599402476;
	bh=br/hzg6lNZVK5EakhampscuZH0tZyYzLNorJ+mKMInE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ruK2umXvTGGy7bDDVuYPvMZWkPO7k3JM+e+atu+c/dDvHO6shl4EYdWIqa4d8l2Ng
	 gVe63g8lSmCPh/yb2L5Wy2AaQrwiJhTr8dRWWutQntqszFhGlj89irx8L2eGriR40P
	 eB6Uw7TkQvReBn951lw5yKNPdH5D/bufCvUn1eI4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728872AbgIFO0l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Sep 2020 10:26:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:57422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728905AbgIFOVz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 10:21:55 -0400
Received: from localhost.localdomain (unknown [194.230.155.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C1AC208C7;
        Sun,  6 Sep 2020 14:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599402114;
        bh=br/hzg6lNZVK5EakhampscuZH0tZyYzLNorJ+mKMInE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2Ytcjf9GeqtEZRksLpNgVi2vJfHcPxzotuV8g1kn1dLhaSjp7M6O775tKpVNPzYTx
         Xywx24N8ytJfIrnP3yPCx2Gt27sUgrWnR6oZDUfUClVR0ZTe1sYRI70M5E0PZwWMdY
         MIRvwjkcco0yWvYmpLUdNaKGQLm9WEIMsoqdHBzg=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>
Subject: [PATCH v3 2/3] ARM: dts: exynos: Add assigned clock parent to CMU in Exynos4412 Odroid
Date:   Sun,  6 Sep 2020 16:21:45 +0200
Message-Id: <20200906142146.21266-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200906142146.21266-1-krzk@kernel.org>
References: <20200906142146.21266-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 68605101460e ("ARM: dts: exynos: Add support for audio over HDMI
for Odroid X/X2/U3") added assigned clocks under Clock Management Unit.

However the dtschema expects "clocks" property if "assigned-clocks" are
used.  Add reference to input clock, the parent used in
"assigned-clock-parents" to silence the dtschema warnings:

  arch/arm/boot/dts/exynos4412-odroidu3.dt.yaml: clock-controller@10030000: 'clocks' is a dependency of 'assigned-clocks'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v2:
1. Use XUSBXTI as real input clock.
---
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
index ca3c78e0966c..4a9f9881f10f 100644
--- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
+++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
@@ -120,6 +120,7 @@
 };
 
 &clock {
+	clocks = <&clock CLK_XUSBXTI>;
 	assigned-clocks = <&clock CLK_FOUT_EPLL>;
 	assigned-clock-rates = <45158401>;
 };
-- 
2.17.1

