Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4551CC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 17:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B71620786
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 17:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597859907;
	bh=ewj35rSkElcFIZJ1hg66kwd3Hqh8xk0tOa2edu8ul6s=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=QvLATP1Q6j5Zeb4uLVDFWRaUSJoDq+mhD+SKZR6WydhGf08wr1vABwFotsZ+m9xyJ
	 C5KxspVFoiE5BdiCMINM8H7U6r+Qxjxw72JxrvCeLQnkl4yCNVbIQGRMr8DsbCWGIU
	 a74w+sViLsV2WPE7atWF2bxig+tkxlgk47K3Ypp4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbgHSR6Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 13:58:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:33936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725997AbgHSR6X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 13:58:23 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1253E20758;
        Wed, 19 Aug 2020 17:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597859902;
        bh=ewj35rSkElcFIZJ1hg66kwd3Hqh8xk0tOa2edu8ul6s=;
        h=From:To:Cc:Subject:Date:From;
        b=uET4EILb8hObuCzAq7NrKxdO3bjrqz7U0vz9LVFNGdhMwoW/A4PRfzH+6R513YthJ
         DgCBVnQEowsJoqmkiI237Lvm9yPuQRLz0+x8xwECDKYpfuTuRZ5tnoKmmnOM/6fzuE
         dGhvNJ/YCAsjUI8Vw4OYnYsWhFFBG4lM828jM2jc=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Tsahee Zidenberg <tsahee@annapurnalabs.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [RESEND PATCH 1/3] ARM: dts: alpine: Align GIC nodename with dtschema
Date:   Wed, 19 Aug 2020 19:58:14 +0200
Message-Id: <20200819175816.21398-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix dtschema validator warnings like:
    gic@fb001000: $nodename:0:
        'gic@fb001000' does not match '^interrupt-controller(@[0-9a-f,]+)*$'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/alpine.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/alpine.dtsi b/arch/arm/boot/dts/alpine.dtsi
index d3036ea823d1..3b0675a1c460 100644
--- a/arch/arm/boot/dts/alpine.dtsi
+++ b/arch/arm/boot/dts/alpine.dtsi
@@ -91,7 +91,7 @@
 		};
 
 		/* Interrupt Controller */
-		gic: gic@fb001000 {
+		gic: interrupt-controller@fb001000 {
 			compatible = "arm,cortex-a15-gic";
 			#interrupt-cells = <3>;
 			#size-cells = <0>;
-- 
2.17.1

