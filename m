Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C79C433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73FF9208C7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599062268;
	bh=1m3c5z+YojmlbQYo3PaCuZUa03edPF1GtR7lN3uiPnk=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Em47PZqDfnsX24AUiBgnLcvKa2VtHtAGbF6OEmZucrNUeenXUgQA1EVQrt+pgkwao
	 RpdR+DpB2I0NHzTVBlPGKY/rX4RRsDFWUQP7fs83sr7ur+SpIaGogpkfm7gDJcFtn/
	 SYYGTF9vNH+YodQHjHEllPW2v1+vkWypUeeRrhbU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbgIBP5r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 11:57:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:46372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726380AbgIBP5q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 11:57:46 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09731207EA;
        Wed,  2 Sep 2020 15:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599062266;
        bh=1m3c5z+YojmlbQYo3PaCuZUa03edPF1GtR7lN3uiPnk=;
        h=From:To:Cc:Subject:Date:From;
        b=CICOFV9ZAkG/TbPYw3ao1s/lbo+ThNE5FD8WwzA1CMDccVUiCS86ev0JsdoqBqxTN
         2kHhj1o2ZdrHCjE0zehtTgPanH0t3OlxFur3mn/5RYmYp8eXpJLchseVKywHCG1inO
         At9VMfJRkLGWfmiFZKGcMQ3Y5vj96hB68wY2joyg=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>
Subject: [PATCH v2 1/2] ARM: dts: exynos: Remove I2C9 samsung,i2c-slave-addr from Exynos5250 boards
Date:   Wed,  2 Sep 2020 17:57:32 +0200
Message-Id: <20200902155733.20271-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The property samsung,i2c-slave-addr in I2C9 controller on Exynos5250
Arndale and SMDK5250 boards, is not actually needed.  There is only one
master on this bus.  It's not clear why this property was added at first
place.

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. New patch, Marek already tested the removal so I am adding his tag.
---
 arch/arm/boot/dts/exynos5250-arndale.dts  | 1 -
 arch/arm/boot/dts/exynos5250-smdk5250.dts | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5250-arndale.dts b/arch/arm/boot/dts/exynos5250-arndale.dts
index f2bcce167b2d..d37479ea4fa2 100644
--- a/arch/arm/boot/dts/exynos5250-arndale.dts
+++ b/arch/arm/boot/dts/exynos5250-arndale.dts
@@ -542,7 +542,6 @@
 	status = "okay";
 	samsung,i2c-sda-delay = <100>;
 	samsung,i2c-max-bus-freq = <40000>;
-	samsung,i2c-slave-addr = <0x38>;
 
 	sata_phy_i2c: sata-phy@38 {
 		compatible = "samsung,exynos-sataphy-i2c";
diff --git a/arch/arm/boot/dts/exynos5250-smdk5250.dts b/arch/arm/boot/dts/exynos5250-smdk5250.dts
index 00af7fb65080..bd8827c69ff1 100644
--- a/arch/arm/boot/dts/exynos5250-smdk5250.dts
+++ b/arch/arm/boot/dts/exynos5250-smdk5250.dts
@@ -326,7 +326,6 @@
 	status = "okay";
 	samsung,i2c-sda-delay = <100>;
 	samsung,i2c-max-bus-freq = <40000>;
-	samsung,i2c-slave-addr = <0x38>;
 
 	sata_phy_i2c: sata-phy@38 {
 		compatible = "samsung,exynos-sataphy-i2c";
-- 
2.17.1

