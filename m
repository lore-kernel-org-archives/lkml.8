Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 542C2C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 08:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3285920857
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 08:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593158757;
	bh=1fZMJ3y3iXanBoUJxpiehdkGjNQckPHcelxa/DFVciM=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=pJpVD1zb51jyoaS6GL4ifE/30dV4+k5HyHiLmw+nEyZczOIlIIuimhOidT7Zkfbv4
	 eJZLOaiH68DF2R2PmLRKciLfc0kUyk01l6G5uePkWRjEY4xsbRfvq+La7WFldNC8GK
	 6FWpUtAgyxHitYEuPPiJymZ1WAFWCmEpTY+9U1fQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729171AbgFZIFz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 04:05:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:36852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729160AbgFZIFw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 04:05:52 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5151208C7;
        Fri, 26 Jun 2020 08:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593158752;
        bh=1fZMJ3y3iXanBoUJxpiehdkGjNQckPHcelxa/DFVciM=;
        h=From:To:Cc:Subject:Date:From;
        b=LI4nHCU9gWKR3R6AgIuCPrfqdNwDLAgeVWqMVwMUxZqJLdnfCRcRrCIbgpkALwjjn
         ZCznLqwAMZdi+GaN8wTlaGARr1fbUeZ6S4ckwdYsmhhqD7easK7HHHfiVv0vaHPS0Y
         x8Wo2agJ9JFMCBNaVnE8d1MmAJD6N/f5RuDctf2w=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Stefan Agner <stefan@agner.ch>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH] ARM: dts: vf610: Align L2 cache-controller nodename with dtschema
Date:   Fri, 26 Jun 2020 10:05:47 +0200
Message-Id: <20200626080547.3569-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix dtschema validator warnings like:
    l2-cache@40006000: $nodename:0:
        'l2-cache@40006000' does not match '^(cache-controller|cpu)(@[0-9a-f,]+)*$'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/vf610.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/vf610.dtsi b/arch/arm/boot/dts/vf610.dtsi
index 7fd39817f8ab..956182d08e74 100644
--- a/arch/arm/boot/dts/vf610.dtsi
+++ b/arch/arm/boot/dts/vf610.dtsi
@@ -10,7 +10,7 @@
 };
 
 &aips0 {
-	L2: l2-cache@40006000 {
+	L2: cache-controller@40006000 {
 		compatible = "arm,pl310-cache";
 		reg = <0x40006000 0x1000>;
 		cache-unified;
-- 
2.17.1

