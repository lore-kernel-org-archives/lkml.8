Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD2F9C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 17:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F34220758
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 17:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597859917;
	bh=FcKEK8nVUQ61VuZBZmyyOwDw3C6WJOxWeroTZ8ZuSBY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ev8nwQc5Oz0QNa6NVhownxjfW9wCrMPGJjTklZ1SQaYTzdRjqdL9uIEHulNuaH1A2
	 GDonlVLcRtdecFgeDDBymdw8fi+i4v047htbrSQvjf4XNSxTMUkxkYYpSG/dz2xJHp
	 7z+64Xy2IfDJ6mWtI8Dj0V9WRtCbWtfrhrnXIKjs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbgHSR6g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 13:58:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:34072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725997AbgHSR61 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 13:58:27 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76DB520758;
        Wed, 19 Aug 2020 17:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597859907;
        bh=FcKEK8nVUQ61VuZBZmyyOwDw3C6WJOxWeroTZ8ZuSBY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gFQNncgwiwmwxWsYWwE5iAJyUaG0++Q7dc59CZRO/qv8QTuh6YqKK6m+972q4/H9J
         Je3bLVjZjVaCYkX9RUQqT/LmWGEY7lgCD3u3YZr71IKsMOcv6XTtTTyTxqUH7Y/tGJ
         AH3d+JNZi7783S2SsZMfgypCq7xogJFiM7u4mo5A=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Tsahee Zidenberg <tsahee@annapurnalabs.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [RESEND PATCH 3/3] arm64: dts: alpine: Fix GIC unit address
Date:   Wed, 19 Aug 2020 19:58:16 +0200
Message-Id: <20200819175816.21398-3-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200819175816.21398-1-krzk@kernel.org>
References: <20200819175816.21398-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Node unit address should be the same as first address appearing in "reg"
property.  Fixes DTC warning:

    arch/arm64/boot/dts/al/alpine-v2.dtsi:116.38-126.5:
        Warning (simple_bus_reg): /soc/interrupt-controller@f0100000: simple-bus unit address format error, expected "f0200000"

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/amazon/alpine-v2.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amazon/alpine-v2.dtsi b/arch/arm64/boot/dts/amazon/alpine-v2.dtsi
index de2eaf77b1ff..4eb2cd14e00b 100644
--- a/arch/arm64/boot/dts/amazon/alpine-v2.dtsi
+++ b/arch/arm64/boot/dts/amazon/alpine-v2.dtsi
@@ -113,7 +113,7 @@
 				     <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
-		gic: interrupt-controller@f0100000 {
+		gic: interrupt-controller@f0200000 {
 			compatible = "arm,gic-v3";
 			reg = <0x0 0xf0200000 0x0 0x10000>,	/* GIC Dist */
 			      <0x0 0xf0280000 0x0 0x200000>,	/* GICR */
-- 
2.17.1

