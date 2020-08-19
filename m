Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A821BC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 17:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76E53207BB
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 17:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597859911;
	bh=xhNDSmKO9WoDEcHY5PNkQZTuXWDvvddZbNzaO4C08aQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=u5cRHG3FRIIVwneQWmZ8OVnhdGiCW66gdTLxDpygHljABW4HfCa6ZHAwxH/D5/Bxo
	 dbusd8hFGGIsPSAFTqvF8xTs/F0j//TZNGcfOf2DaAjW7ituTl251Z1N0LC2M3iAZV
	 3WwDlMiVyoScnMn5kLJVSiGtr2OJwfDCn1+fmiU8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgHSR63 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 13:58:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:34002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726707AbgHSR6Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 13:58:25 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25D17207DE;
        Wed, 19 Aug 2020 17:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597859904;
        bh=xhNDSmKO9WoDEcHY5PNkQZTuXWDvvddZbNzaO4C08aQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kARqJNpU3Ue75BEemzPITdEyzH3+KyOvyS9fccP92Ef3P3ofJpzP6TLOdeTxNP8Ez
         Hn7DJnORqyMOhKwNiouv69Zsj5lQW/Fa3D6SwvZ7elvPRIBC+WM73KtleGM4i8FkrZ
         fXl5VSwiCwLYQyuICnvpYYHRcPNtGSuSEkoy1ywM=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Tsahee Zidenberg <tsahee@annapurnalabs.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [RESEND PATCH 2/3] arm64: dts: alpine: Align GIC nodename with dtschema
Date:   Wed, 19 Aug 2020 19:58:15 +0200
Message-Id: <20200819175816.21398-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200819175816.21398-1-krzk@kernel.org>
References: <20200819175816.21398-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix dtschema validator warnings like:
    gic@f0100000: $nodename:0:
        'gic@f0100000' does not match '^interrupt-controller(@[0-9a-f,]+)*$'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/amazon/alpine-v2.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amazon/alpine-v2.dtsi b/arch/arm64/boot/dts/amazon/alpine-v2.dtsi
index d5e7e2bb4e6c..de2eaf77b1ff 100644
--- a/arch/arm64/boot/dts/amazon/alpine-v2.dtsi
+++ b/arch/arm64/boot/dts/amazon/alpine-v2.dtsi
@@ -113,7 +113,7 @@
 				     <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
-		gic: gic@f0100000 {
+		gic: interrupt-controller@f0100000 {
 			compatible = "arm,gic-v3";
 			reg = <0x0 0xf0200000 0x0 0x10000>,	/* GIC Dist */
 			      <0x0 0xf0280000 0x0 0x200000>,	/* GICR */
-- 
2.17.1

