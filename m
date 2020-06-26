Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22159C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 08:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0024620836
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 08:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593158810;
	bh=xJcoCjSkig5dmU/FRfiprSGxsAHQk6SGiq1SH+O+sE8=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=evA7mbIq/DhVbn/FpdrP4qcXRIPVrO20haXHRTfZ9hIm1y74jq+N33cT4RNlbJ+Mi
	 qxgpYIYXRSGnmzaGfEk+8I7bv3e18F4nPoFTsyk1M2Nz27Vln/BXs6PqBT48jjGmn7
	 GIIdJkkeJ8ss06DFCclhCBymJnt3y2UflowGWZcE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729342AbgFZIGr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 04:06:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:37998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729115AbgFZIGp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 04:06:45 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3422520B1F;
        Fri, 26 Jun 2020 08:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593158805;
        bh=xJcoCjSkig5dmU/FRfiprSGxsAHQk6SGiq1SH+O+sE8=;
        h=From:To:Cc:Subject:Date:From;
        b=ck7OLYba7jjrETtbpjwXcUUF8ehksOZxfQSR8URT5Qn497c/iOWx4gTek04g0A6VE
         QjiM9t5BhBAui7RTzoEESHJ+odN8JG9Fwhm5oYrfujugua51ergIb6L6joEvpjCzuz
         p7887iV1ASSDYkPYS+c6tdoiXKYj7cBX9/+afeZo=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH] ARM: dts: berlin: Align L2 cache-controller nodename with dtschema
Date:   Fri, 26 Jun 2020 10:06:41 +0200
Message-Id: <20200626080642.4244-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix dtschema validator warnings like:
    l2-cache-controller@ac0000: $nodename:0:
        'l2-cache-controller@ac0000' does not match '^(cache-controller|cpu)(@[0-9a-f,]+)*$'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/berlin2.dtsi   | 2 +-
 arch/arm/boot/dts/berlin2cd.dtsi | 2 +-
 arch/arm/boot/dts/berlin2q.dtsi  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/berlin2.dtsi b/arch/arm/boot/dts/berlin2.dtsi
index 3ab3cd250da7..6194857f8a02 100644
--- a/arch/arm/boot/dts/berlin2.dtsi
+++ b/arch/arm/boot/dts/berlin2.dtsi
@@ -106,7 +106,7 @@
 			status = "disabled";
 		};
 
-		l2: l2-cache-controller@ac0000 {
+		l2: cache-controller@ac0000 {
 			compatible = "marvell,tauros3-cache", "arm,pl310-cache";
 			reg = <0xac0000 0x1000>;
 			cache-unified;
diff --git a/arch/arm/boot/dts/berlin2cd.dtsi b/arch/arm/boot/dts/berlin2cd.dtsi
index 7cf3e6302d75..6f30d7eb3b41 100644
--- a/arch/arm/boot/dts/berlin2cd.dtsi
+++ b/arch/arm/boot/dts/berlin2cd.dtsi
@@ -71,7 +71,7 @@
 			status = "disabled";
 		};
 
-		l2: l2-cache-controller@ac0000 {
+		l2: cache-controller@ac0000 {
 			compatible = "arm,pl310-cache";
 			reg = <0xac0000 0x1000>;
 			cache-unified;
diff --git a/arch/arm/boot/dts/berlin2q.dtsi b/arch/arm/boot/dts/berlin2q.dtsi
index c44a32e873f4..b6a0acac6836 100644
--- a/arch/arm/boot/dts/berlin2q.dtsi
+++ b/arch/arm/boot/dts/berlin2q.dtsi
@@ -149,7 +149,7 @@
 			status = "disabled";
 		};
 
-		l2: l2-cache-controller@ac0000 {
+		l2: cache-controller@ac0000 {
 			compatible = "arm,pl310-cache";
 			reg = <0xac0000 0x1000>;
 			cache-unified;
-- 
2.17.1

