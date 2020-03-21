Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA9CC4332D
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 14:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37FC420409
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 14:39:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gorani.run header.i=@gorani.run header.b="sAR5y0fA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbgCUOjs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 10:39:48 -0400
Received: from mout-u-204.mailbox.org ([91.198.250.253]:44590 "EHLO
        mout-u-204.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727244AbgCUOjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 10:39:47 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-u-204.mailbox.org (Postfix) with ESMTPS id 48l3FY4BMnzQkJl;
        Sat, 21 Mar 2020 15:39:45 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gorani.run; s=MBO0001;
        t=1584801583;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Tkpjw41OSQS6g4mnJ1HdI3U2kVush6jX6zP98pED8vo=;
        b=sAR5y0fAccgXVWrnYlH9HkSy0j/qIMg3EXITWYl9lGkPa/KR5mp/m083mpcbKwXhx/vgch
        dS+1bufCW+lKOHUIZJ3hV65QTD1avsJWu0gExWdtuCBfjE3lPVwSwYC+iXhUFITurtJy7h
        +kx1fhSA9yS9T7EsV5pCv9lEIayFNiwDXWJNiGDTmKI7x2Hcia1O5woQovtAscEk0oT84L
        w9JrJTwDre073BVtsIF+EiOqmhm3R+Rc9spSXNRpFkVrFuEIBXTjn5YMIJZwSF1IdmVkzh
        FXxuQh9dhs1Df5CLq21/vxXa3PHki1sA3VdvSLF+dwGlKpk+XAaodJh3JFk9Cw==
Received: from smtp2.mailbox.org ([80.241.60.241])
        by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
        with ESMTP id exzjPqbLDL-R; Sat, 21 Mar 2020 15:39:42 +0100 (CET)
From:   Sungbo Eo <mans0n@gorani.run>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-oxnas@groups.io,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sungbo Eo <mans0n@gorani.run>
Subject: [PATCH] ARM: dts: oxnas: Fix clear-mask property
Date:   Sat, 21 Mar 2020 23:36:53 +0900
Message-Id: <20200321143653.2412823-1-mans0n@gorani.run>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Disable all rps-irq interrupts during driver initialization to prevent
an accidental interrupt on GIC.

Fixes: 84316f4ef141 ("ARM: boot: dts: Add Oxford Semiconductor OX810SE dtsi")
Fixes: 38d4a53733f5 ("ARM: dts: Add support for OX820 and Pogoplug V3")
Signed-off-by: Sungbo Eo <mans0n@gorani.run>
---
 arch/arm/boot/dts/ox810se.dtsi | 4 ++--
 arch/arm/boot/dts/ox820.dtsi   | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/ox810se.dtsi b/arch/arm/boot/dts/ox810se.dtsi
index 9f6c2b660ed3..0755e5864c4a 100644
--- a/arch/arm/boot/dts/ox810se.dtsi
+++ b/arch/arm/boot/dts/ox810se.dtsi
@@ -323,8 +323,8 @@ intc: interrupt-controller@0 {
 					interrupt-controller;
 					reg = <0 0x200>;
 					#interrupt-cells = <1>;
-					valid-mask = <0xFFFFFFFF>;
-					clear-mask = <0>;
+					valid-mask = <0xffffffff>;
+					clear-mask = <0xffffffff>;
 				};
 
 				timer0: timer@200 {
diff --git a/arch/arm/boot/dts/ox820.dtsi b/arch/arm/boot/dts/ox820.dtsi
index c9b327732063..90846a7655b4 100644
--- a/arch/arm/boot/dts/ox820.dtsi
+++ b/arch/arm/boot/dts/ox820.dtsi
@@ -240,8 +240,8 @@ intc: interrupt-controller@0 {
 					reg = <0 0x200>;
 					interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
 					#interrupt-cells = <1>;
-					valid-mask = <0xFFFFFFFF>;
-					clear-mask = <0>;
+					valid-mask = <0xffffffff>;
+					clear-mask = <0xffffffff>;
 				};
 
 				timer0: timer@200 {
-- 
2.25.2

